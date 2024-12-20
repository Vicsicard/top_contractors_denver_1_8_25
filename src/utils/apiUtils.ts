interface RequestOptions extends RequestInit {
  headers?: HeadersInit;
}

type RequestFunction = () => Promise<Response>;

export async function makeRateLimitedRequest(
  requestFn: RequestFunction,
  maxRetries: number = 3
) {
  let retryCount = 0;
  let lastError: Error | null = null;

  while (retryCount < maxRetries) {
    try {
      const response = await requestFn();
      
      if (response.status === 429) {
        const retryAfter = parseInt(response.headers.get("Retry-After") || "1", 10);
        console.log(`Rate limit exceeded. Retrying after ${retryAfter} seconds.`);
        await new Promise(resolve => setTimeout(resolve, retryAfter * 1000));
        retryCount++;
        continue;
      }

      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }

      return response;
    } catch (error) {
      lastError = error instanceof Error ? error : new Error("Unknown error");
      console.error("Request error:", lastError.message);
      
      if (retryCount < maxRetries - 1) {
        const backoffTime = Math.min(1000 * Math.pow(2, retryCount), 10000);
        console.log(`Retry ${retryCount + 1} of ${maxRetries}. Waiting ${backoffTime}ms`);
        await new Promise(resolve => setTimeout(resolve, backoffTime));
        retryCount++;
      } else {
        throw lastError;
      }
    }
  }

  throw lastError || new Error("Max retries exceeded");
}

// Helper function with exponential backoff
export async function makeRequestWithBackoff(requestFn: RequestFunction) {
  try {
    const response = await makeRateLimitedRequest(requestFn);
    return await response.json();
  } catch (error) {
    console.error("Request failed after retries:", error instanceof Error ? error.message : "Unknown error");
    throw error;
  }
}
