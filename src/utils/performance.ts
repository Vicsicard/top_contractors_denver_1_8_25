// Function to preload critical resources
export function preloadResources() {
  const resources = [
    { href: '/fonts/inter.woff2', as: 'font', type: 'font/woff2', crossOrigin: 'anonymous' },
    { href: '/logo.png', as: 'image' }
  ];

  resources.forEach(({ href, as, type, crossOrigin }) => {
    const link = document.createElement('link');
    link.rel = 'preload';
    link.href = href;
    link.as = as;
    if (type) link.type = type;
    if (crossOrigin) link.crossOrigin = crossOrigin;
    document.head.appendChild(link);
  });
}

// Function to defer non-critical resources
export function deferNonCriticalResources() {
  const deferredScripts = [
    '/analytics.js',
    '/chat-widget.js'
  ];

  deferredScripts.forEach(src => {
    const script = document.createElement('script');
    script.src = src;
    script.defer = true;
    document.body.appendChild(script);
  });
}

// Function to implement intersection observer for lazy loading
export function setupIntersectionObserver() {
  const options = {
    root: null,
    rootMargin: '50px',
    threshold: 0.1
  };

  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        const element = entry.target as HTMLImageElement;
        if (element.dataset.src) {
          element.src = element.dataset.src;
          element.removeAttribute('data-src');
          observer.unobserve(element);
        }
      }
    });
  }, options);

  return observer;
}

// Function to measure and report Core Web Vitals
export function measureWebVitals() {
  if ('web-vital' in window) {
    // @ts-expect-error - web-vitals types not available
    webVitals.getCLS(console.log);
    // @ts-expect-error - web-vitals types not available
    webVitals.getFID(console.log);
    // @ts-expect-error - web-vitals types not available
    webVitals.getLCP(console.log);
  }
}

// Function to optimize resource hints
export function addResourceHints() {
  const hints = [
    { rel: 'dns-prefetch', href: 'https://fonts.googleapis.com' },
    { rel: 'preconnect', href: 'https://fonts.googleapis.com' },
    { rel: 'preconnect', href: 'https://fonts.gstatic.com', crossOrigin: 'anonymous' }
  ];

  hints.forEach(({ rel, href, crossOrigin }) => {
    const link = document.createElement('link');
    link.rel = rel;
    link.href = href;
    if (crossOrigin) link.crossOrigin = crossOrigin;
    document.head.appendChild(link);
  });
}
