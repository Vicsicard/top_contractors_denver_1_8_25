import { waitForToken } from './rateLimiter';

type RequestFunction = () => Promise<Response>;

export async function makeRateLimitedRequest(
  requestFn: RequestFunction,
  maxRetries: number = 3
) {
  let retryCount = 0;
  let lastError: Error | null = null;

  while (retryCount < maxRetries) {
    try {
      await waitForToken();
      const response = await requestFn();
      
      if (response.status === 429) {
        const retryAfter = parseInt(response.headers.get("Retry-After") || "1", 10);
        console.log(`Rate limit exceeded. Retrying after ${retryAfter} seconds.`);
        await new Promise(resolve => setTimeout(resolve, retryAfter * 1000));
        retryCount++;
        continue;
      }

      return response;
    } catch (error) {
      lastError = error as Error;
      const backoffTime = Math.pow(2, retryCount) * 1000; // exponential backoff
      console.log(`Request failed. Retrying in ${backoffTime/1000} seconds...`);
      await new Promise(resolve => setTimeout(resolve, backoffTime));
      retryCount++;
    }
  }

  throw lastError || new Error('Max retries exceeded');
}

// Helper function with exponential backoff
export async function makeRequestWithBackoff(requestFn: RequestFunction): Promise<Response> {
  return makeRateLimitedRequest(requestFn);
}
