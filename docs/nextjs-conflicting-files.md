# Next.js Conflicting Files Documentation

## Overview
Understanding and resolving conflicts between public files and page files in Next.js.

## Types of Conflicts

### Public vs Page Conflicts
- **Public Directory**: Files in the `public` directory are served at the root path
- **Page Files**: Pages in `app` or `pages` directory that resolve to the same path
- **Conflict Example**: Having both `public/about.html` and `app/about/page.tsx`

### Route Conflicts
- **Parallel Routes**: Cannot have two routes that resolve to the same URL path
- **Examples**:
  - `/api/data/route.ts` vs `/api/data/page.tsx`
  - `app/blog/[slug]/route.ts` vs `app/blog/[slug]/page.tsx`

### Route Group Conflicts
- **Route Groups**: Using parentheses for organization `(group-name)`
- **Common Issues**: Overlapping route groups
- **Example**: `(api)/data/route.ts` vs `api/data/route.ts`

## Best Practices

### File Organization
- Keep public assets in appropriate subdirectories
- Use clear naming conventions
- Avoid duplicate route patterns

### Route Groups
- Use meaningful group names
- Document group purposes
- Maintain consistent structure

### Conflict Resolution
- Steps to identify conflicts
- How to resolve common issues
- Testing route resolution

## Common Issues

### Path Resolution
- How Next.js resolves paths
- Priority order for conflicting routes
- Debug techniques

### Build Errors
- Common error messages
- How to interpret build logs
- Solutions for typical conflicts

## Examples

### Correct Structure
```
app/
  (api)/
    users/
      route.ts
  (pages)/
    users/
      page.tsx
public/
  images/
    user-avatar.png
```

### Incorrect Structure
```
app/
  api/users/route.ts
  api/users/page.tsx  # Conflict!
public/
  api/users.html      # Another conflict!
```

## References
- Add official Next.js documentation references here

Conflicting Public File and Page File
Why This Error Occurred
One of your public files has the same path as a page file which is not supported. Since only one resource can reside at the URL both public files and page files must be unique.

Possible Ways to Fix It
Rename either the public file or page file that is causing the conflict.

Example conflict between public file and page file

Folder structure

public/
  hello
pages/
  hello.js
Non-conflicting public file and page file

Folder structure

public/
  hello.txt
pages/
  hello.js
 Static Assets
Next.js can serve static files, like images, under a folder called public in the root directory. Files inside public can then be referenced by your code starting from the base URL (/).

For example, the file public/avatars/me.png can be viewed by visiting the /avatars/me.png path. The code to display that image might look like:

avatar.js

import Image from 'next/image'
 
export function Avatar({ id, alt }) {
  return <Image src={`/avatars/${id}.png`} alt={alt} width="64" height="64" />
}
 
export function AvatarOfMe() {
  return <Avatar id="me" alt="A portrait of me" />
}
Caching
Next.js cannot safely cache assets in the public folder because they may change. The default caching headers applied are:


Cache-Control: public, max-age=0
Robots, Favicons, and others
The folder is also useful for robots.txt, favicon.ico, Google Site Verification, and any other static files (including .html). But make sure to not have a static file with the same name as a file in the pages/ directory, as this will result in an error. Read more.

Good to know:

The directory must be named public. The name cannot be changed and it's the only directory used to serve static assets.
Only assets that are in the public directory at build time will be served by Next.js. Files added at request time won't be available. We recommend using a third-party service like Vercel Blob for persistent file storage.
 Optimizing Bundling
Bundling external packages can significantly improve the performance of your application. By default, packages imported into your application are not bundled. This can impact performance or might not work if external packages are not pre-bundled, for example, if imported from a monorepo or node_modules. This page will guide you through how to analyze and configure package bundling.

Analyzing JavaScript bundles
@next/bundle-analyzer is a plugin for Next.js that helps you manage the size of your application bundles. It generates a visual report of the size of each package and their dependencies. You can use the information to remove large dependencies, split, or lazy-load your code.

Installation
Install the plugin by running the following command:


npm i @next/bundle-analyzer
# or
yarn add @next/bundle-analyzer
# or
pnpm add @next/bundle-analyzer
Then, add the bundle analyzer's settings to your next.config.js.

next.config.js

/** @type {import('next').NextConfig} */
const nextConfig = {}
 
const withBundleAnalyzer = require('@next/bundle-analyzer')({
  enabled: process.env.ANALYZE === 'true',
})
 
module.exports = withBundleAnalyzer(nextConfig)
Generating a report
Run the following command to analyze your bundles:


ANALYZE=true npm run build
# or
ANALYZE=true yarn build
# or
ANALYZE=true pnpm build
The report will open three new tabs in your browser, which you can inspect. Periodically evaluating your application's bundles can help you maintain application performance over time.

Optimizing package imports
Some packages, such as icon libraries, can export hundreds of modules, which can cause performance issues in development and production.

You can optimize how these packages are imported by adding the optimizePackageImports option to your next.config.js. This option will only load the modules you actually use, while still giving you the convenience of writing import statements with many named exports.

next.config.js

/** @type {import('next').NextConfig} */
const nextConfig = {
  experimental: {
    optimizePackageImports: ['icon-library'],
  },
}
 
module.exports = nextConfig
Next.js also optimizes some libraries automatically, thus they do not need to be included in the optimizePackageImports list. See the full list.

Bundling specific packages
To bundle specific packages, you can use the transpilePackages option in your next.config.js. This option is useful for bundling external packages that are not pre-bundled, for example, in a monorepo or imported from node_modules.

next.config.js

/** @type {import('next').NextConfig} */
const nextConfig = {
  transpilePackages: ['package-name'],
}
 
module.exports = nextConfig
Bundling all packages
To automatically bundle all packages (default behavior in the App Router), you can use the bundlePagesRouterDependencies option in your next.config.js.

next.config.js

/** @type {import('next').NextConfig} */
const nextConfig = {
  bundlePagesRouterDependencies: true,
}
 
module.exports = nextConfig
Opting specific packages out of bundling
If you have the bundlePagesRouterDependencies option enabled, you can opt specific packages out of automatic bundling using the serverExternalPackages option in your next.config.js:

next.config.js

/** @type {import('next').NextConfig} */
const nextConfig = {
  // Automatically bundle external packages in the Pages Router:
  bundlePagesRouterDependencies: true,
  // Opt specific packages out of bundling for both App and Pages Router:
  serverExternalPackages: ['package-name'],
}
 
module.exports = nextConfig
Production Checklist
Before taking your Next.js application to production, there are some optimizations and patterns you should consider implementing for the best user experience, performance, and security.

This page provides best practices that you can use as a reference when building your application, before going to production, and after deployment - as well as the automatic Next.js optimizations you should be aware of.

Automatic optimizations
These Next.js optimizations are enabled by default and require no configuration:

Code-splitting: Next.js automatically code-splits your application code by pages. This means only the code needed for the current page is loaded on navigation. You may also consider lazy loading third-party libraries, where appropriate.
Prefetching: When a link to a new route enters the user's viewport, Next.js prefetches the route in background. This makes navigation to new routes almost instant. You can opt out of prefetching, where appropriate.
Automatic Static Optimization: Next.js automatically determines that a page is static (can be pre-rendered) if it has no blocking data requirements. Optimized pages can be cached, and served to the end-user from multiple CDN locations. You may opt into Server-side Rendering, where appropriate.
These defaults aim to improve your application's performance, and reduce the cost and amount of data transferred on each network request.

During development
While building your application, we recommend using the following features to ensure the best performance and user experience:

Routing and rendering
<Link> component: Use the <Link> component for client-side navigation and prefetching.
Custom Errors: Gracefully handle 500 and 404 errors
Data fetching and caching
API Routes: Use Route Handlers to access your backend resources, and prevent sensitive secrets from being exposed to the client.
Data Caching: Verify whether your data requests are being cached or not, and opt into caching, where appropriate. Ensure requests that don't use getStaticProps are cached where appropriate.
Incremental Static Regeneration: Use Incremental Static Regeneration to update static pages after they've been built, without rebuilding your entire site.
Static Images: Use the public directory to automatically cache your application's static assets, e.g. images.
UI and accessibility
Font Module: Optimize fonts by using the Font Module, which automatically hosts your font files with other static assets, removes external network requests, and reduces layout shift.
<Image> Component: Optimize images by using the Image Component, which automatically optimizes images, prevents layout shift, and serves them in modern formats like WebP or AVIF.
<Script> Component: Optimize third-party scripts by using the Script Component, which automatically defers scripts and prevents them from blocking the main thread.
ESLint: Use the built-in eslint-plugin-jsx-a11y plugin to catch accessibility issues early.
Security
Environment Variables: Ensure your .env.* files are added to .gitignore and only public variables are prefixed with NEXT_PUBLIC_.
Content Security Policy: Consider adding a Content Security Policy to protect your application against various security threats such as cross-site scripting, clickjacking, and other code injection attacks.
Metadata and SEO
<Head> Component: Use the next/head component to add page titles, descriptions, and more.
Type safety
TypeScript and TS Plugin: Use TypeScript and the TypeScript plugin for better type-safety, and to help you catch errors early.
Before going to production
Before going to production, you can run next build to build your application locally and catch any build errors, then run next start to measure the performance of your application in a production-like environment.

Core Web Vitals
Lighthouse: Run lighthouse in incognito to gain a better understanding of how your users will experience your site, and to identify areas for improvement. This is a simulated test and should be paired with looking at field data (such as Core Web Vitals).
Analyzing bundles
Use the @next/bundle-analyzer plugin to analyze the size of your JavaScript bundles and identify large modules and dependencies that might be impacting your application's performance.

Additionally, the following tools can help you understand the impact of adding new dependencies to your application:

Import Cost
Package Phobia
Bundle Phobia
bundlejs
After deployment
Depending on where you deploy your application, you might have access to additional tools and integrations to help you monitor and improve your application's performance.

For Vercel deployments, we recommend the following:

Analytics: A built-in analytics dashboard to help you understand your application's traffic, including the number of unique visitors, page views, and more.
Speed Insights: Real-world performance insights based on visitor data, offering a practical view of how your website is performing in the field.
Logging: Runtime and Activity logs to help you debug issues and monitor your application in production. Alternatively, see the integrations page for a list of third-party tools and services.
Good to know:

To get a comprehensive understanding of the best practices for production deployments on Vercel, including detailed strategies for improving website performance, refer to the Vercel Production Checklist.

Following these recommendations will help you build a faster, more reliable, and secure application for your users.
Static Exports
Next.js enables starting as a static site or Single-Page Application (SPA), then later optionally upgrading to use features that require a server.

When running next build, Next.js generates an HTML file per route. By breaking a strict SPA into individual HTML files, Next.js can avoid loading unnecessary JavaScript code on the client-side, reducing the bundle size and enabling faster page loads.

Since Next.js supports this static export, it can be deployed and hosted on any web server that can serve HTML/CSS/JS static assets.

Configuration
To enable a static export, change the output mode inside next.config.js:

next.config.js

/**
 * @type {import('next').NextConfig}
 */
const nextConfig = {
  output: 'export',
 
  // Optional: Change links `/me` -> `/me/` and emit `/me.html` -> `/me/index.html`
  // trailingSlash: true,
 
  // Optional: Prevent automatic `/me` -> `/me/`, instead preserve `href`
  // skipTrailingSlashRedirect: true,
 
  // Optional: Change the output directory `out` -> `dist`
  // distDir: 'dist',
}
 
module.exports = nextConfig
After running next build, Next.js will produce an out folder which contains the HTML/CSS/JS assets for your application.

You can utilize getStaticProps and getStaticPaths to generate an HTML file for each page in your pages directory (or more for dynamic routes).

Supported Features
The majority of core Next.js features needed to build a static site are supported, including:

Dynamic Routes when using getStaticPaths
Prefetching with next/link
Preloading JavaScript
Dynamic Imports
Any styling options (e.g. CSS Modules, styled-jsx)
Client-side data fetching
getStaticProps
getStaticPaths
Image Optimization
Image Optimization through next/image can be used with a static export by defining a custom image loader in next.config.js. For example, you can optimize images with a service like Cloudinary:

next.config.js

/** @type {import('next').NextConfig} */
const nextConfig = {
  output: 'export',
  images: {
    loader: 'custom',
    loaderFile: './my-loader.ts',
  },
}
 
module.exports = nextConfig
This custom loader will define how to fetch images from a remote source. For example, the following loader will construct the URL for Cloudinary:

my-loader.ts
TypeScript

TypeScript

export default function cloudinaryLoader({
  src,
  width,
  quality,
}: {
  src: string
  width: number
  quality?: number
}) {
  const params = ['f_auto', 'c_limit', `w_${width}`, `q_${quality || 'auto'}`]
  return `https://res.cloudinary.com/demo/image/upload/${params.join(
    ','
  )}${src}`
}
You can then use next/image in your application, defining relative paths to the image in Cloudinary:

app/page.tsx
TypeScript

TypeScript

import Image from 'next/image'
 
export default function Page() {
  return <Image alt="turtles" src="/turtles.jpg" width={300} height={300} />
}
Unsupported Features
Features that require a Node.js server, or dynamic logic that cannot be computed during the build process, are not supported:

Internationalized Routing
API Routes
Rewrites
Redirects
Headers
Middleware
Incremental Static Regeneration
Image Optimization with the default loader
Draft Mode
getStaticPaths with fallback: true
getStaticPaths with fallback: 'blocking'
getServerSideProps
Deploying
With a static export, Next.js can be deployed and hosted on any web server that can serve HTML/CSS/JS static assets.

When running next build, Next.js generates the static export into the out folder. For example, let's say you have the following routes:

/
/blog/[id]
After running next build, Next.js will generate the following files:

/out/index.html
/out/404.html
/out/blog/post-1.html
/out/blog/post-2.html
If you are using a static host like Nginx, you can configure rewrites from incoming requests to the correct files:

nginx.conf

server {
  listen 80;
  server_name acme.com;
 
  root /var/www/out;
 
  location / {
      try_files $uri $uri.html $uri/ =404;
  }
 
  # This is necessary when `trailingSlash: false`.
  # You can omit this when `trailingSlash: true`.
  location /blog/ {
      rewrite ^/blog/(.*)$ /blog/$1.html break;
  }
 
  error_page 404 /404.html;
  location = /404.html {
      internal;
  }
}
Version History
Version	Changes
v14.0.0	next export has been removed in favor of "output": "export"
v13.4.0	App Router (Stable) adds enhanced static export support, including using React Server Components and Route Handlers.
v13.3.0	next export is deprecated and replaced with "output": "export"
