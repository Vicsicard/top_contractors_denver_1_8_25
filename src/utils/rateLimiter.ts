// Simple rate limiter implementation for Edge runtime
class EdgeRateLimiter {
  private points: number;
  private duration: number;
  private timestamps: number[];

  constructor(points: number, duration: number) {
    this.points = points;
    this.duration = duration;
    this.timestamps = [];
  }

  async consume(): Promise<void> {
    const now = Date.now();
    const windowStart = now - (this.duration * 1000);
    
    // Remove timestamps outside the current window
    this.timestamps = this.timestamps.filter(ts => ts > windowStart);

    if (this.timestamps.length >= this.points) {
      const oldestTimestamp = this.timestamps[0];
      const msToWait = oldestTimestamp - windowStart;
      await new Promise(resolve => setTimeout(resolve, msToWait));
      return this.consume();
    }

    this.timestamps.push(now);
  }
}

// Configure rate limiter (10 requests per second)
export const rateLimiter = new EdgeRateLimiter(10, 1);

// Function to wait for a token from the rate limiter
export const waitForToken = async (): Promise<void> => {
  try {
    await rateLimiter.consume();
  } catch (error) {
    console.error('Rate limiter error:', error);
    // If something goes wrong, add a small delay
    await new Promise(resolve => setTimeout(resolve, 1000));
  }
};
