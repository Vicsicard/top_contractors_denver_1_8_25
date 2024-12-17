import Bottleneck from 'bottleneck';

// Track tokens and requests
let tokenUsage = 0;
const tokenLimit = 100000; // Adjust based on your API plan
const requestLimit = 100; // Requests per hour

// Create limiter instance
export const limiter = new Bottleneck({
    maxConcurrent: 1,
    reservoir: requestLimit,
    reservoirRefreshAmount: requestLimit,
    reservoirRefreshInterval: 60 * 60 * 1000, // Reset hourly
});

// Reset token usage hourly
setInterval(() => {
    tokenUsage = 0;
}, 60 * 60 * 1000);

interface RequestOptions extends RequestInit {
    headers?: HeadersInit;
}

export async function makeRateLimitedRequest(
    apiUrl: string, 
    options: RequestOptions, 
    estimatedTokens: number
): Promise<any> {
    return limiter.schedule(async () => {
        if (tokenUsage + estimatedTokens > tokenLimit) {
            console.log("Token limit reached. Waiting for reset.");
            await new Promise(resolve => setTimeout(resolve, 60 * 60 * 1000));
            tokenUsage = 0;
        }

        try {
            const response = await fetch(apiUrl, options);

            if (response.status === 429) {
                const retryAfter = parseInt(response.headers.get("Retry-After") || "60", 10);
                console.log(`Rate limit exceeded. Retrying after ${retryAfter} seconds.`);
                await new Promise(resolve => setTimeout(resolve, retryAfter * 1000));
                return makeRateLimitedRequest(apiUrl, options, estimatedTokens);
            }

            if (!response.ok) {
                throw new Error(`HTTP Error: ${response.status}`);
            }

            tokenUsage += estimatedTokens;
            return await response.json();
        } catch (error) {
            console.error("Request error:", error instanceof Error ? error.message : "Unknown error");
            throw error;
        }
    });
}
