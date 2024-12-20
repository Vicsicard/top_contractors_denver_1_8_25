import Bottleneck from 'bottleneck';

// Configure rate limiter
const limiter = new Bottleneck({
  maxConcurrent: 1,
  minTime: 200,
  reservoir: 100,
  reservoirRefreshAmount: 100,
  reservoirRefreshInterval: 60 * 60 * 1000 // 1 hour
});

export const rateLimiter = {
  async waitForToken() {
    return limiter.schedule(() => Promise.resolve());
  }
};
