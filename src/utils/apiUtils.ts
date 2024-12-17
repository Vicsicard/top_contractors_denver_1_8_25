interface RequestOptions extends RequestInit {
  headers?: HeadersInit;
}

export async function makeRateLimitedRequest(
  apiUrl: string,
  options: RequestOptions = {}
) {
  try {
    const response = await fetch(apiUrl, options);
    
    if (response.status === 429) {
      const retryAfter = parseInt(response.headers.get("Retry-After") || "1", 10);
      console.log(`Rate limit exceeded. Retrying after ${retryAfter} seconds.`);
      await new Promise(resolve => setTimeout(resolve, retryAfter * 1000));
      return makeRateLimitedRequest(apiUrl, options); // Retry the request
    }

    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }

    return await response.json();
  } catch (error) {
    console.error("Request error:", error instanceof Error ? error.message : "Unknown error");
    throw error;
  }
}

// Add exponential backoff for repeated rate limit hits
export async function makeRequestWithBackoff(
  apiUrl: string,
  options: RequestOptions = {},
  maxRetries: number = 3
) {
  let retryCount = 0;
  
  while (retryCount < maxRetries) {
    try {
      return await makeRateLimitedRequest(apiUrl, options);
    } catch (error) {
      if (error instanceof Error && error.message.includes("429")) {
        retryCount++;
        const backoffTime = Math.min(1000 * Math.pow(2, retryCount), 10000); // Max 10 seconds
        console.log(`Retry ${retryCount} of ${maxRetries}. Waiting ${backoffTime}ms`);
        await new Promise(resolve => setTimeout(resolve, backoffTime));
      } else {
        throw error;
      }
    }
  }
  
  throw new Error("Max retries exceeded");
}
