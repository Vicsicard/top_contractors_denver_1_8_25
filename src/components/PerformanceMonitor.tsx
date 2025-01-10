'use client';

import { useEffect } from 'react';
import { onCLS, onFID, onLCP, onFCP, onTTFB } from 'web-vitals';

interface Metric {
  name: string;
  value: number;
  rating: 'good' | 'needs-improvement' | 'poor';
  delta: number;
  id: string;
}

export function PerformanceMonitor() {
  useEffect(() => {
    // Only run in production
    if (process.env.NODE_ENV === 'production') {
      const reportWebVital = ({ name, value, rating, delta, id }: Metric) => {
        // Send to your analytics platform
        console.log(`Web Vital: ${name}`, {
          value,
          rating,
          delta,
          id
        });

        // Example: Send to Google Analytics
        if (typeof window.gtag === 'function') {
          window.gtag('event', name, {
            value: Math.round(name === 'CLS' ? value * 1000 : value),
            metric_id: id,
            metric_value: value,
            metric_delta: delta,
            metric_rating: rating,
          });
        }
      };

      // Monitor Core Web Vitals
      onCLS(reportWebVital);
      onFID(reportWebVital);
      onLCP(reportWebVital);
      onFCP(reportWebVital);
      onTTFB(reportWebVital);
    }
  }, []);

  // This component doesn't render anything
  return null;
}

// Add type for gtag
declare global {
  interface Window {
    gtag: (
      command: string,
      eventName: string,
      eventParameters?: {
        [key: string]: any;
      }
    ) => void;
  }
}
