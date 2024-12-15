# Next.js API Routes Documentation

## Overview
Documentation for Next.js API routes and best practices in the App Router, with specific examples from the Denver Contractors project.

## App Router API Routes

### Route Handlers
- **Location**: `app/(api)` directory (using route groups)
- **File Convention**: `route.ts` or `route.js`
- **HTTP Methods**: GET, POST, PUT, PATCH, DELETE, HEAD, OPTIONS

#### Project Example
```typescript
// app/(api)/search/places/route.ts
import { NextResponse } from 'next/server';
import { searchPlaces } from '@/utils/googlePlaces';

export async function GET(request: Request) {
  try {
    const { searchParams } = new URL(request.url);
    const keyword = searchParams.get('keyword');
    const location = searchParams.get('location');

    if (!keyword || !location) {
      return NextResponse.json(
        { error: 'Missing required parameters' },
        { status: 400 }
      );
    }

    const results = await searchPlaces(keyword, location);
    return NextResponse.json({ results });
  } catch (error) {
    return NextResponse.json(
      { error: 'Failed to fetch results' },
      { status: 500 }
    );
  }
}
```

### Route Organization
- **Route Groups**: Use route groups (e.g., `(api)`) to organize API routes
- **Naming Convention**: Use descriptive names that reflect the resource
- **File Structure**:
  ```
  app/
  ├── (api)/
  │   └── search/
  │       └── places/
  │           └── route.ts
  ├── (pages)/
  │   └── search/
  │       └── results/
  │           └── page.tsx
  ```

### Common Pitfalls and Solutions

#### Routing Conflicts
**Problem**: Conflicting routes between API routes and pages
```
❌ /api/places/results/page.tsx
❌ /api/places/results/route.ts
```

**Solution**: 
1. Use route groups to separate API routes and pages
2. Keep API routes in `(api)` group
3. Keep pages in `(pages)` group

#### Cache and Build Issues
If you encounter routing conflicts during build:
1. Clear the Next.js cache (delete `.next` folder)
2. Rebuild the project (`npm run build`)
3. Verify route organization follows the pattern above

### Request Handling
- Request object structure
- Response formatting
- Error handling with TypeScript types

### Caching and Revalidation
- Static vs dynamic routes
- Revalidation strategies
- Cache control headers

### Security Best Practices
- Input validation
- Rate limiting
- Error handling
- API key protection

### Project-Specific Patterns

#### Error Handling
```typescript
try {
  // API logic
} catch (error) {
  console.error('API Error:', error);
  return NextResponse.json(
    { error: 'Failed to fetch results' },
    { status: 500 }
  );
}
```

#### Response Format
```typescript
// Success response
return NextResponse.json({
  results: data,
  metadata: {
    count: data.length,
    query: { keyword, location }
  }
});

// Error response
return NextResponse.json(
  { error: 'Error message' },
  { status: errorCode }
);
```

## Route Groups and Parallel Routes

#### Route Groups
Route groups in Next.js are created by wrapping a folder name in parentheses `(foldername)`. They are useful for:

1. **Organizing Routes**: Group routes without affecting the URL structure
   ```
   app/
   ├── (api)/              # API routes group
   │   └── search/
   │       └── places/
   │           └── route.ts
   ├── (pages)/           # Pages group
   │   └── search/
   │       └── results/
   │           └── page.tsx
   ```

2. **Preventing Route Conflicts**: By using route groups, we can have similar route paths for different purposes without conflicts
   - `/search/results` serves the page component
   - `/api/search/places` serves the API endpoint

3. **Shared Layouts**: Routes within a group can share a layout while keeping the layout code separate from other groups

#### Parallel Routes
Parallel routes allow you to simultaneously render multiple pages in the same layout. They are defined using slots with the `@folder` convention.

1. **Use Cases**:
   - Dashboards with multiple views
   - Split views
   - Modals and dialogs

2. **Example Structure**:
   ```
   app/
   ├── @modal/
   │   └── login/
   │       └── page.tsx   # /login renders this parallel to main content
   ├── @dashboard/
   │   └── analytics/
   │       └── page.tsx   # /analytics renders this parallel to main content
   └── layout.tsx         # Parent layout receiving modal and dashboard as props
   ```

3. **Important Notes**:
   - Slots are passed as props to the parent layout
   - Slots don't affect URL structure
   - Cannot mix static and dynamic parallel routes at the same segment level
   - The `children` prop is an implicit slot

4. **Default Handling**:
   - Use `default.js` for unmatched parallel routes
   - Helps prevent accidental rendering of parallel routes

#### Best Practices
1. Use route groups `(group)` to organize your code without affecting URLs
2. Keep API routes in a separate group from pages
3. Use parallel routes `@folder` for complex UI with multiple simultaneous views
4. Always provide fallback UI with `default.js` for parallel routes

## Pages Router API Routes

### Basic Structure
- **Location**: `pages/api` directory
- **File Convention**: `[name].ts` or `[name].js`
- **Handler Function**: `export default function handler(req, res)`

### Dynamic API Routes
- Catch-all routes
- Optional catch-all routes
- Query parameters

### Response Helpers
- Status codes
- JSON responses
- Error handling

### Best Practices
- Input validation
- Error handling
- Security considerations
- Rate limiting

## TypeScript Support
- Type definitions
- Request/Response types
- Error handling types

## Common Use Cases
- Authentication
- Database operations
- External API integration
- File uploads

## References
- [Next.js Route Handlers Documentation](https://nextjs.org/docs/app/building-your-application/routing/route-handlers)
- [Next.js API Routes Migration Guide](https://nextjs.org/docs/app/building-your-application/upgrading/app-router-migration#migrating-api-routes)
- [Next.js Route Groups](https://nextjs.org/docs/app/building-your-application/routing/route-groups)

API Routes
Good to know: If you are using the App Router, you can use Server Components or Route Handlers instead of API Routes.

API routes provide a solution to build a public API with Next.js.

Any file inside the folder pages/api is mapped to /api/* and will be treated as an API endpoint instead of a page. They are server-side only bundles and won't increase your client-side bundle size.

For example, the following API route returns a JSON response with a status code of 200:

pages/api/hello.ts
TypeScript

TypeScript

import type { NextApiRequest, NextApiResponse } from 'next'
 
type ResponseData = {
  message: string
}
 
export default function handler(
  req: NextApiRequest,
  res: NextApiResponse<ResponseData>
) {
  res.status(200).json({ message: 'Hello from Next.js!' })
}
Good to know:

API Routes do not specify CORS headers, meaning they are same-origin only by default. You can customize such behavior by wrapping the request handler with the CORS request helpers.
API Routes can't be used with static exports. However, Route Handlers in the App Router can.
API Routes will be affected by pageExtensions configuration in next.config.js.
Parameters

export default function handler(req: NextApiRequest, res: NextApiResponse) {
  // ...
}
req: An instance of http.IncomingMessage
res: An instance of http.ServerResponse
HTTP Methods
To handle different HTTP methods in an API route, you can use req.method in your request handler, like so:

pages/api/hello.ts
TypeScript

TypeScript

import type { NextApiRequest, NextApiResponse } from 'next'
 
export default function handler(req: NextApiRequest, res: NextApiResponse) {
  if (req.method === 'POST') {
    // Process a POST request
  } else {
    // Handle any other HTTP method
  }
}
Request Helpers
API Routes provide built-in request helpers which parse the incoming request (req):

req.cookies - An object containing the cookies sent by the request. Defaults to {}
req.query - An object containing the query string. Defaults to {}
req.body - An object containing the body parsed by content-type, or null if no body was sent
Custom config
Every API Route can export a config object to change the default configuration, which is the following:


export const config = {
  api: {
    bodyParser: {
      sizeLimit: '1mb',
    },
  },
  // Specifies the maximum allowed duration for this function to execute (in seconds)
  maxDuration: 5,
}
bodyParser is automatically enabled. If you want to consume the body as a Stream or with raw-body, you can set this to false.

One use case for disabling the automatic bodyParsing is to allow you to verify the raw body of a webhook request, for example from GitHub.


export const config = {
  api: {
    bodyParser: false,
  },
}
bodyParser.sizeLimit is the maximum size allowed for the parsed body, in any format supported by bytes, like so:


export const config = {
  api: {
    bodyParser: {
      sizeLimit: '500kb',
    },
  },
}
externalResolver is an explicit flag that tells the server that this route is being handled by an external resolver like express or connect. Enabling this option disables warnings for unresolved requests.


export const config = {
  api: {
    externalResolver: true,
  },
}
responseLimit is automatically enabled, warning when an API Routes' response body is over 4MB.

If you are not using Next.js in a serverless environment, and understand the performance implications of not using a CDN or dedicated media host, you can set this limit to false.


export const config = {
  api: {
    responseLimit: false,
  },
}
responseLimit can also take the number of bytes or any string format supported by bytes, for example 1000, '500kb' or '3mb'. This value will be the maximum response size before a warning is displayed. Default is 4MB. (see above)


export const config = {
  api: {
    responseLimit: '8mb',
  },
}
Response Helpers
The Server Response object, (often abbreviated as res) includes a set of Express.js-like helper methods to improve the developer experience and increase the speed of creating new API endpoints.

The included helpers are:

res.status(code) - A function to set the status code. code must be a valid HTTP status code
res.json(body) - Sends a JSON response. body must be a serializable object
res.send(body) - Sends the HTTP response. body can be a string, an object or a Buffer
res.redirect([status,] path) - Redirects to a specified path or URL. status must be a valid HTTP status code. If not specified, status defaults to "307" "Temporary redirect".
res.revalidate(urlPath) - Revalidate a page on demand using getStaticProps. urlPath must be a string.
Setting the status code of a response
When sending a response back to the client, you can set the status code of the response.

The following example sets the status code of the response to 200 (OK) and returns a message property with the value of Hello from Next.js! as a JSON response:

pages/api/hello.ts
TypeScript

TypeScript

import type { NextApiRequest, NextApiResponse } from 'next'
 
type ResponseData = {
  message: string
}
 
export default function handler(
  req: NextApiRequest,
  res: NextApiResponse<ResponseData>
) {
  res.status(200).json({ message: 'Hello from Next.js!' })
}
Sending a JSON response
When sending a response back to the client you can send a JSON response, this must be a serializable object. In a real world application you might want to let the client know the status of the request depending on the result of the requested endpoint.

The following example sends a JSON response with the status code 200 (OK) and the result of the async operation. It's contained in a try catch block to handle any errors that may occur, with the appropriate status code and error message caught and sent back to the client:

pages/api/hello.ts
TypeScript

TypeScript

import type { NextApiRequest, NextApiResponse } from 'next'
 
export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse
) {
  try {
    const result = await someAsyncOperation()
    res.status(200).json({ result })
  } catch (err) {
    res.status(500).json({ error: 'failed to load data' })
  }
}
Sending a HTTP response
Sending an HTTP response works the same way as when sending a JSON response. The only difference is that the response body can be a string, an object or a Buffer.

The following example sends a HTTP response with the status code 200 (OK) and the result of the async operation.

pages/api/hello.ts
TypeScript

TypeScript

import type { NextApiRequest, NextApiResponse } from 'next'
 
export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse
) {
  try {
    const result = await someAsyncOperation()
    res.status(200).send({ result })
  } catch (err) {
    res.status(500).send({ error: 'failed to fetch data' })
  }
}
Redirects to a specified path or URL
Taking a form as an example, you may want to redirect your client to a specified path or URL once they have submitted the form.

The following example redirects the client to the / path if the form is successfully submitted:

pages/api/hello.ts
TypeScript

TypeScript

import type { NextApiRequest, NextApiResponse } from 'next'
 
export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse
) {
  const { name, message } = req.body
 
  try {
    await handleFormInputAsync({ name, message })
    res.redirect(307, '/')
  } catch (err) {
    res.status(500).send({ error: 'Failed to fetch data' })
  }
}
Adding TypeScript types
You can make your API Routes more type-safe by importing the NextApiRequest and NextApiResponse types from next, in addition to those, you can also type your response data:


import type { NextApiRequest, NextApiResponse } from 'next'
 
type ResponseData = {
  message: string
}
 
export default function handler(
  req: NextApiRequest,
  res: NextApiResponse<ResponseData>
) {
  res.status(200).json({ message: 'Hello from Next.js!' })
}
Good to know: The body of NextApiRequest is any because the client may include any payload. You should validate the type/shape of the body at runtime before using it.

Dynamic API Routes
API Routes support dynamic routes, and follow the same file naming rules used for pages/.

pages/api/post/[pid].ts
TypeScript

TypeScript

import type { NextApiRequest, NextApiResponse } from 'next'
 
export default function handler(req: NextApiRequest, res: NextApiResponse) {
  const { pid } = req.query
  res.end(`Post: ${pid}`)
}
Now, a request to /api/post/abc will respond with the text: Post: abc.

Catch all API routes
API Routes can be extended to catch all paths by adding three dots (...) inside the brackets. For example:

pages/api/post/[...slug].js matches /api/post/a, but also /api/post/a/b, /api/post/a/b/c and so on.
Good to know: You can use names other than slug, such as: [...param]

Matched parameters will be sent as a query parameter (slug in the example) to the page, and it will always be an array, so, the path /api/post/a will have the following query object:


{ "slug": ["a"] }
And in the case of /api/post/a/b, and any other matching path, new parameters will be added to the array, like so:


{ "slug": ["a", "b"] }
For example:

pages/api/post/[...slug].ts
TypeScript

TypeScript

import type { NextApiRequest, NextApiResponse } from 'next'
 
export default function handler(req: NextApiRequest, res: NextApiResponse) {
  const { slug } = req.query
  res.end(`Post: ${slug.join(', ')}`)
}
Now, a request to /api/post/a/b/c will respond with the text: Post: a, b, c.

Optional catch all API routes
Catch all routes can be made optional by including the parameter in double brackets ([[...slug]]).

For example, pages/api/post/[[...slug]].js will match /api/post, /api/post/a, /api/post/a/b, and so on.

The main difference between catch all and optional catch all routes is that with optional, the route without the parameter is also matched (/api/post in the example above).

The query objects are as follows:


{ } // GET `/api/post` (empty object)
{ "slug": ["a"] } // `GET /api/post/a` (single-element array)
{ "slug": ["a", "b"] } // `GET /api/post/a/b` (multi-element array)
Caveats
Predefined API routes take precedence over dynamic API routes, and dynamic API routes over catch all API routes. Take a look at the following examples:
pages/api/post/create.js - Will match /api/post/create
pages/api/post/[pid].js - Will match /api/post/1, /api/post/abc, etc. But not /api/post/create
pages/api/post/[...slug].js - Will match /api/post/1/2, /api/post/a/b/c, etc. But not /api/post/create, /api/post/abc
Edge API Routes
If you would like to use API Routes with the Edge Runtime, we recommend incrementally adopting the App Router and using Route Handlers instead.

The Route Handlers function signature is isomorphic, meaning you can use the same function for both Edge and Node.js runtimes.
How to create layouts and pages
Next.js uses file-system based routing, meaning you can use folders and files to define routes. This page will guide you through how to create layouts and pages, and link between them.

Creating a page
A page is UI that is rendered on a specific route. To create a page, add a page file inside the app directory and default export a React component. For example, to create an index page (/):

page.js special file
app/page.tsx
TypeScript

TypeScript

export default function Page() {
  return <h1>Hello Next.js!</h1>
}
Creating a layout
A layout is UI that is shared between multiple pages. On navigation, layouts preserve state, remain interactive, and do not rerender.

You can define a layout by default exporting a React component from a layout file. The component should accept a children prop which can be a page or another layout.

For example, to create a layout that accepts your index page as child, add a layout file inside the app directory:

layout.js special file
app/layout.tsx
TypeScript

TypeScript

export default function DashboardLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">
      <body>
        {/* Layout UI */}
        {/* Place children where you want to render a page or nested layout */}
        <main>{children}</main>
      </body>
    </html>
  )
}
The layout above is called a root layout because it's defined at the root of the app directory. The root layout is required and must contain html and body tags.

Creating a nested route
A nested route is a route composed of multiple URL segments. For example, the /blog/[slug] route is composed of three segments:

/ (Root Segment)
blog (Segment)
[slug] (Leaf Segment)
In Next.js:

Folders are used to define the route segments that map to URL segments.
Files (like page and layout) are used to create UI that is shown for a segment.
To create nested routes, you can nest folders inside each other. For example, to add a route for /blog, create a folder called blog in the app directory. Then, to make /blog publicly accessible, add a page file:

File hierarchy showing blog folder and a page.js file
app/blog/page.tsx
TypeScript

TypeScript

import { getPosts } from '@/lib/posts'
import { Post } from '@/ui/post'
 
export default async function Page() {
  const posts = await getPosts()
 
  return (
    <ul>
      {posts.map((post) => (
        <Post key={post.id} post={post} />
      ))}
    </ul>
  )
}
You can continue nesting folders to create nested routes. For example, to create a route for a specific blog post, create a new [slug] folder inside blog and add a page file:

File hierarchy showing blog folder with a nested slug folder and a page.js file
app/blog/[slug]/page.tsx
TypeScript

TypeScript

function generateStaticParams() {}
 
export default function Page() {
  return <h1>Hello, Blog Post Page!</h1>
}
Good to know: Wrapping a folder name in square brackets (e.g. [slug]) creates a special dynamic route segment used to generate multiple pages from data. This is useful for blog posts, product pages, etc.

Nesting layouts
By default, layouts in the folder hierarchy are also nested, which means they wrap child layouts via their children prop. You can nest layouts by adding layout inside specific route segments (folders).

For example, to create a layout for the /blog route, add a new layout file inside the blog folder.

File hierarchy showing root layout wrapping the blog layout
app/blog/layout.tsx
TypeScript

TypeScript

export default function BlogLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return <section>{children}</section>
}
If you were to combine the two layouts above, the root layout (app/layout.js) would wrap the blog layout (app/blog/layout.js), which would wrap the blog (app/blog/page.js) and blog post page (app/blog/[slug]/page.js).

Linking between pages
You can use the <Link> component to navigate between routes. <Link> is a built-in Next.js component that extends the HTML <a> tag to provide prefetching and client-side navigation.

For example, to generate a list of blog posts, import <Link> from next/link and pass a href prop to the component:

app/ui/post.tsx
TypeScript

TypeScript

import Link from 'next/link'
 
export default async function Post({ post }) {
  const posts = await getPosts()
 
  return (
    <ul>
      {posts.map((post) => (
        <li key={post.slug}>
          <Link href={`/blog/${post.slug}`}>{post.title}</Link>
        </li>
      ))}
    </ul>
  )
}
<Link> is the primary and recommended way to navigate between routes in your Next.js application. However, you can also use the useRouter hook for more advanced navigation.


Route Groups
In the app directory, nested folders are normally mapped to URL paths. However, you can mark a folder as a Route Group to prevent the folder from being included in the route's URL path.

This allows you to organize your route segments and project files into logical groups without affecting the URL path structure.

Route groups are useful for:

Organizing routes into groups e.g. by site section, intent, or team.
Enabling nested layouts in the same route segment level:
Creating multiple nested layouts in the same segment, including multiple root layouts
Adding a layout to a subset of routes in a common segment
Adding a loading skeleton to specific route in a common segment
Convention
A route group can be created by wrapping a folder's name in parenthesis: (folderName)

Examples
Organize routes without affecting the URL path
To organize routes without affecting the URL, create a group to keep related routes together. The folders in parenthesis will be omitted from the URL (e.g. (marketing) or (shop).

Organizing Routes with Route Groups
Even though routes inside (marketing) and (shop) share the same URL hierarchy, you can create a different layout for each group by adding a layout.js file inside their folders.

Route Groups with Multiple Layouts
Opting specific segments into a layout
To opt specific routes into a layout, create a new route group (e.g. (shop)) and move the routes that share the same layout into the group (e.g. account and cart). The routes outside of the group will not share the layout (e.g. checkout).

Route Groups with Opt-in Layouts
Opting for loading skeletons on a specific route
To apply a loading skeleton via a loading.js file to a specific route, create a new route group (e.g., /(overview)) and then move your loading.tsx inside that route group.

Folder structure showing a loading.tsx and a page.tsx inside the route group
Now, the loading.tsx file will only apply to your dashboard → overview page instead of all your dashboard pages without affecting the URL path structure.

Creating multiple root layouts
To create multiple root layouts, remove the top-level layout.js file, and add a layout.js file inside each route group. This is useful for partitioning an application into sections that have a completely different UI or experience. The <html> and <body> tags need to be added to each root layout.

Route Groups with Multiple Root Layouts
In the example above, both (marketing) and (shop) have their own root layout.

Good to know:

The naming of route groups has no special significance other than for organization. They do not affect the URL path.
Routes that include a route group should not resolve to the same URL path as other routes. For example, since route groups don't affect URL structure, (marketing)/about/page.js and (shop)/about/page.js would both resolve to /about and cause an error.
If you use multiple root layouts without a top-level layout.js file, your home page.js file should be defined in one of the route groups, For example: app/(marketing)/page.js.
Navigating across multiple root layouts will cause a full page load (as opposed to a client-side navigation). For example, navigating from /cart that uses app/(shop)/layout.js to /blog that uses app/(marketing)/layout.js will cause a full page load. This only applies to multiple root layouts.
API Routes
Good to know: If you are using the App Router, you can use Server Components or Route Handlers instead of API Routes.

API routes provide a solution to build a public API with Next.js.

Any file inside the folder pages/api is mapped to /api/* and will be treated as an API endpoint instead of a page. They are server-side only bundles and won't increase your client-side bundle size.

For example, the following API route returns a JSON response with a status code of 200:

pages/api/hello.ts
TypeScript

TypeScript

import type { NextApiRequest, NextApiResponse } from 'next'
 
type ResponseData = {
  message: string
}
 
export default function handler(
  req: NextApiRequest,
  res: NextApiResponse<ResponseData>
) {
  res.status(200).json({ message: 'Hello from Next.js!' })
}
Good to know:

API Routes do not specify CORS headers, meaning they are same-origin only by default. You can customize such behavior by wrapping the request handler with the CORS request helpers.
API Routes can't be used with static exports. However, Route Handlers in the App Router can.
API Routes will be affected by pageExtensions configuration in next.config.js.
Parameters

export default function handler(req: NextApiRequest, res: NextApiResponse) {
  // ...
}
req: An instance of http.IncomingMessage
res: An instance of http.ServerResponse
HTTP Methods
To handle different HTTP methods in an API route, you can use req.method in your request handler, like so:

pages/api/hello.ts
TypeScript

TypeScript

import type { NextApiRequest, NextApiResponse } from 'next'
 
export default function handler(req: NextApiRequest, res: NextApiResponse) {
  if (req.method === 'POST') {
    // Process a POST request
  } else {
    // Handle any other HTTP method
  }
}
Request Helpers
API Routes provide built-in request helpers which parse the incoming request (req):

req.cookies - An object containing the cookies sent by the request. Defaults to {}
req.query - An object containing the query string. Defaults to {}
req.body - An object containing the body parsed by content-type, or null if no body was sent
Custom config
Every API Route can export a config object to change the default configuration, which is the following:


export const config = {
  api: {
    bodyParser: {
      sizeLimit: '1mb',
    },
  },
  // Specifies the maximum allowed duration for this function to execute (in seconds)
  maxDuration: 5,
}
bodyParser is automatically enabled. If you want to consume the body as a Stream or with raw-body, you can set this to false.

One use case for disabling the automatic bodyParsing is to allow you to verify the raw body of a webhook request, for example from GitHub.


export const config = {
  api: {
    bodyParser: false,
  },
}
bodyParser.sizeLimit is the maximum size allowed for the parsed body, in any format supported by bytes, like so:


export const config = {
  api: {
    bodyParser: {
      sizeLimit: '500kb',
    },
  },
}
externalResolver is an explicit flag that tells the server that this route is being handled by an external resolver like express or connect. Enabling this option disables warnings for unresolved requests.


export const config = {
  api: {
    externalResolver: true,
  },
}
responseLimit is automatically enabled, warning when an API Routes' response body is over 4MB.

If you are not using Next.js in a serverless environment, and understand the performance implications of not using a CDN or dedicated media host, you can set this limit to false.


export const config = {
  api: {
    responseLimit: false,
  },
}
responseLimit can also take the number of bytes or any string format supported by bytes, for example 1000, '500kb' or '3mb'. This value will be the maximum response size before a warning is displayed. Default is 4MB. (see above)


export const config = {
  api: {
    responseLimit: '8mb',
  },
}
Response Helpers
The Server Response object, (often abbreviated as res) includes a set of Express.js-like helper methods to improve the developer experience and increase the speed of creating new API endpoints.

The included helpers are:

res.status(code) - A function to set the status code. code must be a valid HTTP status code
res.json(body) - Sends a JSON response. body must be a serializable object
res.send(body) - Sends the HTTP response. body can be a string, an object or a Buffer
res.redirect([status,] path) - Redirects to a specified path or URL. status must be a valid HTTP status code. If not specified, status defaults to "307" "Temporary redirect".
res.revalidate(urlPath) - Revalidate a page on demand using getStaticProps. urlPath must be a string.
Setting the status code of a response
When sending a response back to the client, you can set the status code of the response.

The following example sets the status code of the response to 200 (OK) and returns a message property with the value of Hello from Next.js! as a JSON response:

pages/api/hello.ts
TypeScript

TypeScript

import type { NextApiRequest, NextApiResponse } from 'next'
 
type ResponseData = {
  message: string
}
 
export default function handler(
  req: NextApiRequest,
  res: NextApiResponse<ResponseData>
) {
  res.status(200).json({ message: 'Hello from Next.js!' })
}
Sending a JSON response
When sending a response back to the client you can send a JSON response, this must be a serializable object. In a real world application you might want to let the client know the status of the request depending on the result of the requested endpoint.

The following example sends a JSON response with the status code 200 (OK) and the result of the async operation. It's contained in a try catch block to handle any errors that may occur, with the appropriate status code and error message caught and sent back to the client:

pages/api/hello.ts
TypeScript

TypeScript

import type { NextApiRequest, NextApiResponse } from 'next'
 
export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse
) {
  try {
    const result = await someAsyncOperation()
    res.status(200).json({ result })
  } catch (err) {
    res.status(500).json({ error: 'failed to load data' })
  }
}
Sending a HTTP response
Sending an HTTP response works the same way as when sending a JSON response. The only difference is that the response body can be a string, an object or a Buffer.

The following example sends a HTTP response with the status code 200 (OK) and the result of the async operation.

pages/api/hello.ts
TypeScript

TypeScript

import type { NextApiRequest, NextApiResponse } from 'next'
 
export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse
) {
  try {
    const result = await someAsyncOperation()
    res.status(200).send({ result })
  } catch (err) {
    res.status(500).send({ error: 'failed to fetch data' })
  }
}
Redirects to a specified path or URL
Taking a form as an example, you may want to redirect your client to a specified path or URL once they have submitted the form.

The following example redirects the client to the / path if the form is successfully submitted:

pages/api/hello.ts
TypeScript

TypeScript

import type { NextApiRequest, NextApiResponse } from 'next'
 
export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse
) {
  const { name, message } = req.body
 
  try {
    await handleFormInputAsync({ name, message })
    res.redirect(307, '/')
  } catch (err) {
    res.status(500).send({ error: 'Failed to fetch data' })
  }
}
Adding TypeScript types
You can make your API Routes more type-safe by importing the NextApiRequest and NextApiResponse types from next, in addition to those, you can also type your response data:


import type { NextApiRequest, NextApiResponse } from 'next'
 
type ResponseData = {
  message: string
}
 
export default function handler(
  req: NextApiRequest,
  res: NextApiResponse<ResponseData>
) {
  res.status(200).json({ message: 'Hello from Next.js!' })
}
Good to know: The body of NextApiRequest is any because the client may include any payload. You should validate the type/shape of the body at runtime before using it.

Dynamic API Routes
API Routes support dynamic routes, and follow the same file naming rules used for pages/.

pages/api/post/[pid].ts
TypeScript

TypeScript

import type { NextApiRequest, NextApiResponse } from 'next'
 
export default function handler(req: NextApiRequest, res: NextApiResponse) {
  const { pid } = req.query
  res.end(`Post: ${pid}`)
}
Now, a request to /api/post/abc will respond with the text: Post: abc.

Catch all API routes
API Routes can be extended to catch all paths by adding three dots (...) inside the brackets. For example:

pages/api/post/[...slug].js matches /api/post/a, but also /api/post/a/b, /api/post/a/b/c and so on.
Good to know: You can use names other than slug, such as: [...param]

Matched parameters will be sent as a query parameter (slug in the example) to the page, and it will always be an array, so, the path /api/post/a will have the following query object:


{ "slug": ["a"] }
And in the case of /api/post/a/b, and any other matching path, new parameters will be added to the array, like so:


{ "slug": ["a", "b"] }
For example:

pages/api/post/[...slug].ts
TypeScript

TypeScript

import type { NextApiRequest, NextApiResponse } from 'next'
 
export default function handler(req: NextApiRequest, res: NextApiResponse) {
  const { slug } = req.query
  res.end(`Post: ${slug.join(', ')}`)
}
Now, a request to /api/post/a/b/c will respond with the text: Post: a, b, c.

Optional catch all API routes
Catch all routes can be made optional by including the parameter in double brackets ([[...slug]]).

For example, pages/api/post/[[...slug]].js will match /api/post, /api/post/a, /api/post/a/b, and so on.

The main difference between catch all and optional catch all routes is that with optional, the route without the parameter is also matched (/api/post in the example above).

The query objects are as follows:


{ } // GET `/api/post` (empty object)
{ "slug": ["a"] } // `GET /api/post/a` (single-element array)
{ "slug": ["a", "b"] } // `GET /api/post/a/b` (multi-element array)
Caveats
Predefined API routes take precedence over dynamic API routes, and dynamic API routes over catch all API routes. Take a look at the following examples:
pages/api/post/create.js - Will match /api/post/create
pages/api/post/[pid].js - Will match /api/post/1, /api/post/abc, etc. But not /api/post/create
pages/api/post/[...slug].js - Will match /api/post/1/2, /api/post/a/b/c, etc. But not /api/post/create, /api/post/abc

Route Groups
In the app directory, nested folders are normally mapped to URL paths. However, you can mark a folder as a Route Group to prevent the folder from being included in the route's URL path.

This allows you to organize your route segments and project files into logical groups without affecting the URL path structure.

Route groups are useful for:

Organizing routes into groups e.g. by site section, intent, or team.
Enabling nested layouts in the same route segment level:
Creating multiple nested layouts in the same segment, including multiple root layouts
Adding a layout to a subset of routes in a common segment
Adding a loading skeleton to specific route in a common segment
Convention
A route group can be created by wrapping a folder's name in parenthesis: (folderName)

Examples
Organize routes without affecting the URL path
To organize routes without affecting the URL, create a group to keep related routes together. The folders in parenthesis will be omitted from the URL (e.g. (marketing) or (shop).

Organizing Routes with Route Groups
Even though routes inside (marketing) and (shop) share the same URL hierarchy, you can create a different layout for each group by adding a layout.js file inside their folders.

Route Groups with Multiple Layouts
Opting specific segments into a layout
To opt specific routes into a layout, create a new route group (e.g. (shop)) and move the routes that share the same layout into the group (e.g. account and cart). The routes outside of the group will not share the layout (e.g. checkout).

Route Groups with Opt-in Layouts
Opting for loading skeletons on a specific route
To apply a loading skeleton via a loading.js file to a specific route, create a new route group (e.g., /(overview)) and then move your loading.tsx inside that route group.

Folder structure showing a loading.tsx and a page.tsx inside the route group
Now, the loading.tsx file will only apply to your dashboard → overview page instead of all your dashboard pages without affecting the URL path structure.

Creating multiple root layouts
To create multiple root layouts, remove the top-level layout.js file, and add a layout.js file inside each route group. This is useful for partitioning an application into sections that have a completely different UI or experience. The <html> and <body> tags need to be added to each root layout.

Route Groups with Multiple Root Layouts
In the example above, both (marketing) and (shop) have their own root layout.

Good to know:

The naming of route groups has no special significance other than for organization. They do not affect the URL path.
Routes that include a route group should not resolve to the same URL path as other routes. For example, since route groups don't affect URL structure, (marketing)/about/page.js and (shop)/about/page.js would both resolve to /about and cause an error.
If you use multiple root layouts without a top-level layout.js file, your home page.js file should be defined in one of the route groups, For example: app/(marketing)/page.js.
Navigating across multiple root layouts will cause a full page load (as opposed to a client-side navigation). For example, navigating from /cart that uses app/(shop)/layout.js to /blog that uses app/(marketing)/layout.js will cause a full page load. This only applies to multiple root layouts.

Dynamic Routes
When you don't know the exact segment names ahead of time and want to create routes from dynamic data, you can use Dynamic Segments that are filled in at request time or prerendered at build time.

Convention
A Dynamic Segment can be created by wrapping a folder's name in square brackets: [folderName]. For example, [id] or [slug].

Dynamic Segments are passed as the params prop to layout, page, route, and generateMetadata functions.

Example
For example, a blog could include the following route app/blog/[slug]/page.js where [slug] is the Dynamic Segment for blog posts.

app/blog/[slug]/page.tsx
TypeScript

TypeScript

export default async function Page({
  params,
}: {
  params: Promise<{ slug: string }>
}) {
  const slug = (await params).slug
  return <div>My Post: {slug}</div>
}
Route	Example URL	params
app/blog/[slug]/page.js	/blog/a	{ slug: 'a' }
app/blog/[slug]/page.js	/blog/b	{ slug: 'b' }
app/blog/[slug]/page.js	/blog/c	{ slug: 'c' }
See the generateStaticParams() page to learn how to generate the params for the segment.

Good to know
Since the params prop is a promise. You must use async/await or React's use function to access the values.
In version 14 and earlier, params was a synchronous prop. To help with backwards compatibility, you can still access it synchronously in Next.js 15, but this behavior will be deprecated in the future.
Dynamic Segments are equivalent to Dynamic Routes in the pages directory.
Generating Static Params
The generateStaticParams function can be used in combination with dynamic route segments to statically generate routes at build time instead of on-demand at request time.

app/blog/[slug]/page.tsx
TypeScript

TypeScript

export async function generateStaticParams() {
  const posts = await fetch('https://.../posts').then((res) => res.json())
 
  return posts.map((post) => ({
    slug: post.slug,
  }))
}
The primary benefit of the generateStaticParams function is its smart retrieval of data. If content is fetched within the generateStaticParams function using a fetch request, the requests are automatically memoized. This means a fetch request with the same arguments across multiple generateStaticParams, Layouts, and Pages will only be made once, which decreases build times.

Use the migration guide if you are migrating from the pages directory.

See generateStaticParams server function documentation for more information and advanced use cases.

Catch-all Segments
Dynamic Segments can be extended to catch-all subsequent segments by adding an ellipsis inside the brackets [...folderName].

For example, app/shop/[...slug]/page.js will match /shop/clothes, but also /shop/clothes/tops, /shop/clothes/tops/t-shirts, and so on.

Route	Example URL	params
app/shop/[...slug]/page.js	/shop/a	{ slug: ['a'] }
app/shop/[...slug]/page.js	/shop/a/b	{ slug: ['a', 'b'] }
app/shop/[...slug]/page.js	/shop/a/b/c	{ slug: ['a', 'b', 'c'] }
Optional Catch-all Segments
Catch-all Segments can be made optional by including the parameter in double square brackets: [[...folderName]].

For example, app/shop/[[...slug]]/page.js will also match /shop, in addition to /shop/clothes, /shop/clothes/tops, /shop/clothes/tops/t-shirts.

The difference between catch-all and optional catch-all segments is that with optional, the route without the parameter is also matched (/shop in the example above).

Route	Example URL	params
app/shop/[[...slug]]/page.js	/shop	{ slug: undefined }
app/shop/[[...slug]]/page.js	/shop/a	{ slug: ['a'] }
app/shop/[[...slug]]/page.js	/shop/a/b	{ slug: ['a', 'b'] }
app/shop/[[...slug]]/page.js	/shop/a/b/c	{ slug: ['a', 'b', 'c'] }
TypeScript
When using TypeScript, you can add types for params depending on your configured route segment.

app/blog/[slug]/page.tsx
TypeScript

TypeScript

export default async function Page({
  params,
}: {
  params: Promise<{ slug: string }>
}) {
  return <h1>My Page</h1>
}
Route	params Type Definition
app/blog/[slug]/page.js	{ slug: string }
app/shop/[...slug]/page.js	{ slug: string[] }
app/shop/[[...slug]]/page.js	{ slug?: string[] }
app/[categoryId]/[itemId]/page.js	{ categoryId: string, itemId: string }
Good to know: This may be done automatically by the TypeScript plugin in the future.

Route Handlers
Route Handlers allow you to create custom request handlers for a given route using the Web Request and Response APIs.

Route.js Special File
Good to know: Route Handlers are only available inside the app directory. They are the equivalent of API Routes inside the pages directory meaning you do not need to use API Routes and Route Handlers together.

Convention
Route Handlers are defined in a route.js|ts file inside the app directory:

app/api/route.ts
TypeScript

TypeScript

export async function GET(request: Request) {}
Route Handlers can be nested anywhere inside the app directory, similar to page.js and layout.js. But there cannot be a route.js file at the same route segment level as page.js.

Supported HTTP Methods
The following HTTP methods are supported: GET, POST, PUT, PATCH, DELETE, HEAD, and OPTIONS. If an unsupported method is called, Next.js will return a 405 Method Not Allowed response.

Extended NextRequest and NextResponse APIs
In addition to supporting the native Request and Response APIs, Next.js extends them with NextRequest and NextResponse to provide convenient helpers for advanced use cases.

Behavior
Caching
Route Handlers are not cached by default. You can, however, opt into caching for GET methods. Other supported HTTP methods are not cached. To cache a GET method, use a route config option such as export const dynamic = 'force-static' in your Route Handler file.

app/items/route.ts
TypeScript

TypeScript

export const dynamic = 'force-static'
 
export async function GET() {
  const res = await fetch('https://data.mongodb-api.com/...', {
    headers: {
      'Content-Type': 'application/json',
      'API-Key': process.env.DATA_API_KEY,
    },
  })
  const data = await res.json()
 
  return Response.json({ data })
}
Good to know: Other supported HTTP methods are not cached, even if they are placed alongside a GET method that is cached, in the same file.

Special Route Handlers
Special Route Handlers like sitemap.ts, opengraph-image.tsx, and icon.tsx, and other metadata files remain static by default unless they use Dynamic APIs or dynamic config options.

Route Resolution
You can consider a route the lowest level routing primitive.

They do not participate in layouts or client-side navigations like page.
There cannot be a route.js file at the same route as page.js.
Page	Route	Result
app/page.js	app/route.js	 Conflict
app/page.js	app/api/route.js	 Valid
app/[user]/page.js	app/api/route.js	 Valid
Each route.js or page.js file takes over all HTTP verbs for that route.

app/page.ts
TypeScript

TypeScript

export default function Page() {
  return <h1>Hello, Next.js!</h1>
}
 
// ❌ Conflict
// `app/route.ts`
export async function POST(request: Request) {}
Examples
The following examples show how to combine Route Handlers with other Next.js APIs and features.

Revalidating Cached Data
You can revalidate cached data using Incremental Static Regeneration (ISR):

app/posts/route.ts
TypeScript

TypeScript

export const revalidate = 60
 
export async function GET() {
  const data = await fetch('https://api.vercel.app/blog')
  const posts = await data.json()
 
  return Response.json(posts)
}
Cookies
You can read or set cookies with cookies from next/headers. This server function can be called directly in a Route Handler, or nested inside of another function.

Alternatively, you can return a new Response using the Set-Cookie header.

app/api/route.ts
TypeScript

TypeScript

import { cookies } from 'next/headers'
 
export async function GET(request: Request) {
  const cookieStore = await cookies()
  const token = cookieStore.get('token')
 
  return new Response('Hello, Next.js!', {
    status: 200,
    headers: { 'Set-Cookie': `token=${token.value}` },
  })
}
You can also use the underlying Web APIs to read cookies from the request (NextRequest):

app/api/route.ts
TypeScript

TypeScript

import { type NextRequest } from 'next/server'
 
export async function GET(request: NextRequest) {
  const token = request.cookies.get('token')
}
Headers
You can read headers with headers from next/headers. This server function can be called directly in a Route Handler, or nested inside of another function.

This headers instance is read-only. To set headers, you need to return a new Response with new headers.

app/api/route.ts
TypeScript

TypeScript

import { headers } from 'next/headers'
 
export async function GET(request: Request) {
  const headersList = await headers()
  const referer = headersList.get('referer')
 
  return new Response('Hello, Next.js!', {
    status: 200,
    headers: { referer: referer },
  })
}
You can also use the underlying Web APIs to read headers from the request (NextRequest):

app/api/route.ts
TypeScript

TypeScript

import { type NextRequest } from 'next/server'
 
export async function GET(request: NextRequest) {
  const requestHeaders = new Headers(request.headers)
}
Redirects
app/api/route.ts
TypeScript

TypeScript

import { redirect } from 'next/navigation'
 
export async function GET(request: Request) {
  redirect('https://nextjs.org/')
}
Dynamic Route Segments
Route Handlers can use Dynamic Segments to create request handlers from dynamic data.

app/items/[slug]/route.ts
TypeScript

TypeScript

export async function GET(
  request: Request,
  { params }: { params: Promise<{ slug: string }> }
) {
  const slug = (await params).slug // 'a', 'b', or 'c'
}
Route	Example URL	params
app/items/[slug]/route.js	/items/a	Promise<{ slug: 'a' }>
app/items/[slug]/route.js	/items/b	Promise<{ slug: 'b' }>
app/items/[slug]/route.js	/items/c	Promise<{ slug: 'c' }>
URL Query Parameters
The request object passed to the Route Handler is a NextRequest instance, which has some additional convenience methods, including for more easily handling query parameters.

app/api/search/route.ts
TypeScript

TypeScript

import { type NextRequest } from 'next/server'
 
export function GET(request: NextRequest) {
  const searchParams = request.nextUrl.searchParams
  const query = searchParams.get('query')
  // query is "hello" for /api/search?query=hello
}
Streaming
Streaming is commonly used in combination with Large Language Models (LLMs), such as OpenAI, for AI-generated content. Learn more about the AI SDK.

app/api/chat/route.ts
TypeScript

TypeScript

import { openai } from '@ai-sdk/openai'
import { StreamingTextResponse, streamText } from 'ai'
 
export async function POST(req: Request) {
  const { messages } = await req.json()
  const result = await streamText({
    model: openai('gpt-4-turbo'),
    messages,
  })
 
  return new StreamingTextResponse(result.toAIStream())
}
These abstractions use the Web APIs to create a stream. You can also use the underlying Web APIs directly.

app/api/route.ts
TypeScript

TypeScript

// https://developer.mozilla.org/docs/Web/API/ReadableStream#convert_async_iterator_to_stream
function iteratorToStream(iterator: any) {
  return new ReadableStream({
    async pull(controller) {
      const { value, done } = await iterator.next()
 
      if (done) {
        controller.close()
      } else {
        controller.enqueue(value)
      }
    },
  })
}
 
function sleep(time: number) {
  return new Promise((resolve) => {
    setTimeout(resolve, time)
  })
}
 
const encoder = new TextEncoder()
 
async function* makeIterator() {
  yield encoder.encode('<p>One</p>')
  await sleep(200)
  yield encoder.encode('<p>Two</p>')
  await sleep(200)
  yield encoder.encode('<p>Three</p>')
}
 
export async function GET() {
  const iterator = makeIterator()
  const stream = iteratorToStream(iterator)
 
  return new Response(stream)
}
Request Body
You can read the Request body using the standard Web API methods:

app/items/route.ts
TypeScript

TypeScript

export async function POST(request: Request) {
  const res = await request.json()
  return Response.json({ res })
}
Request Body FormData
You can read the FormData using the request.formData() function:

app/items/route.ts
TypeScript

TypeScript

export async function POST(request: Request) {
  const formData = await request.formData()
  const name = formData.get('name')
  const email = formData.get('email')
  return Response.json({ name, email })
}
Since formData data are all strings, you may want to use zod-form-data to validate the request and retrieve data in the format you prefer (e.g. number).

CORS
You can set CORS headers for a specific Route Handler using the standard Web API methods:

app/api/route.ts
TypeScript

TypeScript

export async function GET(request: Request) {
  return new Response('Hello, Next.js!', {
    status: 200,
    headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
      'Access-Control-Allow-Headers': 'Content-Type, Authorization',
    },
  })
}
Good to know:

To add CORS headers to multiple Route Handlers, you can use Middleware or the next.config.js file.
Alternatively, see our CORS example package.
Webhooks
You can use a Route Handler to receive webhooks from third-party services:

app/api/route.ts
TypeScript

TypeScript

export async function POST(request: Request) {
  try {
    const text = await request.text()
    // Process the webhook payload
  } catch (error) {
    return new Response(`Webhook error: ${error.message}`, {
      status: 400,
    })
  }
 
  return new Response('Success!', {
    status: 200,
  })
}
Notably, unlike API Routes with the Pages Router, you do not need to use bodyParser to use any additional configuration.

Non-UI Responses
You can use Route Handlers to return non-UI content. Note that sitemap.xml, robots.txt, app icons, and open graph images all have built-in support.

app/rss.xml/route.ts
TypeScript

TypeScript

export async function GET() {
  return new Response(
    `<?xml version="1.0" encoding="UTF-8" ?>
<rss version="2.0">
 
<channel>
  <title>Next.js Documentation</title>
  <link>https://nextjs.org/docs</link>
  <description>The React Framework for the Web</description>
</channel>
 
</rss>`,
    {
      headers: {
        'Content-Type': 'text/xml',
      },
    }
  )
}
Segment Config Options
Route Handlers use the same route segment configuration as pages and layouts.

app/items/route.ts
TypeScript

TypeScript

export const dynamic = 'auto'
export const dynamicParams = true
export const revalidate = false
export const fetchCache = 'auto'
export const runtime = 'nodejs'
export const preferredRegion = 'auto'

Error Handling
Errors can be divided into two categories: expected errors and uncaught exceptions:

Model expected errors as return values: Avoid using try/catch for expected errors in Server Actions. Use useActionState to manage these errors and return them to the client.
Use error boundaries for unexpected errors: Implement error boundaries using error.tsx and global-error.tsx files to handle unexpected errors and provide a fallback UI.
Handling Expected Errors
Expected errors are those that can occur during the normal operation of the application, such as those from server-side form validation or failed requests. These errors should be handled explicitly and returned to the client.

Handling Expected Errors from Server Actions
Use the useActionState hook to manage the state of Server Actions, including handling errors. This approach avoids try/catch blocks for expected errors, which should be modeled as return values rather than thrown exceptions.

app/actions.ts
TypeScript

TypeScript

'use server'
 
import { redirect } from 'next/navigation'
 
export async function createUser(prevState: any, formData: FormData) {
  const res = await fetch('https://...')
  const json = await res.json()
 
  if (!res.ok) {
    return { message: 'Please enter a valid email' }
  }
 
  redirect('/dashboard')
}
Then, you can pass your action to the useActionState hook and use the returned state to display an error message.

app/ui/signup.tsx
TypeScript

TypeScript

'use client'
 
import { useActionState } from 'react'
import { createUser } from '@/app/actions'
 
const initialState = {
  message: '',
}
 
export function Signup() {
  const [state, formAction, pending] = useActionState(createUser, initialState)
 
  return (
    <form action={formAction}>
      <label htmlFor="email">Email</label>
      <input type="text" id="email" name="email" required />
      {/* ... */}
      <p aria-live="polite">{state?.message}</p>
      <button disabled={pending}>Sign up</button>
    </form>
  )
}
You could also use the returned state to display a toast message from the client component.

Handling Expected Errors from Server Components
When fetching data inside of a Server Component, you can use the response to conditionally render an error message or redirect.

app/page.tsx
TypeScript

TypeScript

export default async function Page() {
  const res = await fetch(`https://...`)
  const data = await res.json()
 
  if (!res.ok) {
    return 'There was an error.'
  }
 
  return '...'
}
Uncaught Exceptions
Uncaught exceptions are unexpected errors that indicate bugs or issues that should not occur during the normal flow of your application. These should be handled by throwing errors, which will then be caught by error boundaries.

Common: Handle uncaught errors below the root layout with error.js.
Optional: Handle granular uncaught errors with nested error.js files (e.g. app/dashboard/error.js)
Uncommon: Handle uncaught errors in the root layout with global-error.js.
Using Error Boundaries
Next.js uses error boundaries to handle uncaught exceptions. Error boundaries catch errors in their child components and display a fallback UI instead of the component tree that crashed.

Create an error boundary by adding an error.tsx file inside a route segment and exporting a React component:

app/dashboard/error.tsx
TypeScript

TypeScript

'use client' // Error boundaries must be Client Components
 
import { useEffect } from 'react'
 
export default function Error({
  error,
  reset,
}: {
  error: Error & { digest?: string }
  reset: () => void
}) {
  useEffect(() => {
    // Log the error to an error reporting service
    console.error(error)
  }, [error])
 
  return (
    <div>
      <h2>Something went wrong!</h2>
      <button
        onClick={
          // Attempt to recover by trying to re-render the segment
          () => reset()
        }
      >
        Try again
      </button>
    </div>
  )
}
If you want errors to bubble up to the parent error boundary, you can throw when rendering the error component.

Handling Errors in Nested Routes
Errors will bubble up to the nearest parent error boundary. This allows for granular error handling by placing error.tsx files at different levels in the route hierarchy.

Nested Error Component Hierarchy
Handling Global Errors
While less common, you can handle errors in the root layout using app/global-error.js, located in the root app directory, even when leveraging internationalization. Global error UI must define its own <html> and <body> tags, since it is replacing the root layout or template when active.

app/global-error.tsx
TypeScript

TypeScript

'use client' // Error boundaries must be Client Components
 
export default function GlobalError({
  error,
  reset,
}: {
  error: Error & { digest?: string }
  reset: () => void
}) {
  return (
    // global-error must include html and body tags
    <html>
      <body>
        <h2>Something went wrong!</h2>
        <button onClick={() => reset()}>Try again</button>
      </body>
    </html>
  )
}

Parallel Routes
Parallel Routes allows you to simultaneously or conditionally render one or more pages within the same layout. They are useful for highly dynamic sections of an app, such as dashboards and feeds on social sites.

For example, considering a dashboard, you can use parallel routes to simultaneously render the team and analytics pages:

Parallel Routes Diagram
Slots
Parallel routes are created using named slots. Slots are defined with the @folder convention. For example, the following file structure defines two slots: @analytics and @team:

Parallel Routes File-system Structure
Slots are passed as props to the shared parent layout. For the example above, the component in app/layout.js now accepts the @analytics and @team slots props, and can render them in parallel alongside the children prop:

app/layout.tsx
TypeScript

TypeScript

export default function Layout({
  children,
  team,
  analytics,
}: {
  children: React.ReactNode
  analytics: React.ReactNode
  team: React.ReactNode
}) {
  return (
    <>
      {children}
      {team}
      {analytics}
    </>
  )
}
However, slots are not route segments and do not affect the URL structure. For example, for /@analytics/views, the URL will be /views since @analytics is a slot. Slots are combined with the regular Page component to form the final page associated with the route segment. Because of this, you cannot have separate static and dynamic slots at the same route segment level. If one slot is dynamic, all slots at that level must be dynamic.

Good to know:

The children prop is an implicit slot that does not need to be mapped to a folder. This means app/page.js is equivalent to app/@children/page.js.
Active state and navigation
By default, Next.js keeps track of the active state (or subpage) for each slot. However, the content rendered within a slot will depend on the type of navigation:

Soft Navigation: During client-side navigation, Next.js will perform a partial render, changing the subpage within the slot, while maintaining the other slot's active subpages, even if they don't match the current URL.
Hard Navigation: After a full-page load (browser refresh), Next.js cannot determine the active state for the slots that don't match the current URL. Instead, it will render a default.js file for the unmatched slots, or 404 if default.js doesn't exist.
Good to know:

The 404 for unmatched routes helps ensure that you don't accidentally render a parallel route on a page that it was not intended for.
default.js
You can define a default.js file to render as a fallback for unmatched slots during the initial load or full-page reload.

Consider the following folder structure. The @team slot has a /settings page, but @analytics does not.

Parallel Routes unmatched routes
When navigating to /settings, the @team slot will render the /settings page while maintaining the currently active page for the @analytics slot.

On refresh, Next.js will render a default.js for @analytics. If default.js doesn't exist, a 404 is rendered instead.

Additionally, since children is an implicit slot, you also need to create a default.js file to render a fallback for children when Next.js cannot recover the active state of the parent page.

useSelectedLayoutSegment(s)
Both useSelectedLayoutSegment and useSelectedLayoutSegments accept a parallelRoutesKey parameter, which allows you to read the active route segment within a slot.

app/layout.tsx
TypeScript

TypeScript

'use client'
 
import { useSelectedLayoutSegment } from 'next/navigation'
 
export default function Layout({ auth }: { auth: React.ReactNode }) {
  const loginSegment = useSelectedLayoutSegment('auth')
  // ...
}
When a user navigates to app/@auth/login (or /login in the URL bar), loginSegment will be equal to the string "login".

Examples
Conditional Routes
You can use Parallel Routes to conditionally render routes based on certain conditions, such as user role. For example, to render a different dashboard page for the /admin or /user roles:

Conditional routes diagram
app/dashboard/layout.tsx
TypeScript

TypeScript

import { checkUserRole } from '@/lib/auth'
 
export default function Layout({
  user,
  admin,
}: {
  user: React.ReactNode
  admin: React.ReactNode
}) {
  const role = checkUserRole()
  return role === 'admin' ? admin : user
}
Tab Groups
You can add a layout inside a slot to allow users to navigate the slot independently. This is useful for creating tabs.

For example, the @analytics slot has two subpages: /page-views and /visitors.

Analytics slot with two subpages and a layout
Within @analytics, create a layout file to share the tabs between the two pages:

app/@analytics/layout.tsx
TypeScript

TypeScript

import Link from 'next/link'
 
export default function Layout({ children }: { children: React.ReactNode }) {
  return (
    <>
      <nav>
        <Link href="/page-views">Page Views</Link>
        <Link href="/visitors">Visitors</Link>
      </nav>
      <div>{children}</div>
    </>
  )
}
Modals
Parallel Routes can be used together with Intercepting Routes to create modals that support deep linking. This allows you to solve common challenges when building modals, such as:

Making the modal content shareable through a URL.
Preserving context when the page is refreshed, instead of closing the modal.
Closing the modal on backwards navigation rather than going to the previous route.
Reopening the modal on forwards navigation.
Consider the following UI pattern, where a user can open a login modal from a layout using client-side navigation, or access a separate /login page:

Parallel Routes Diagram
To implement this pattern, start by creating a /login route that renders your main login page.

Parallel Routes Diagram
app/login/page.tsx
TypeScript

TypeScript

import { Login } from '@/app/ui/login'
 
export default function Page() {
  return <Login />
}
Then, inside the @auth slot, add default.js file that returns null. This ensures that the modal is not rendered when it's not active.

app/@auth/default.tsx
TypeScript

TypeScript

export default function Default() {
  return null
}
Inside your @auth slot, intercept the /login route by updating the /(.)login folder. Import the <Modal> component and its children into the /(.)login/page.tsx file:

app/@auth/(.)login/page.tsx
TypeScript

TypeScript

import { Modal } from '@/app/ui/modal'
import { Login } from '@/app/ui/login'
 
export default function Page() {
  return (
    <Modal>
      <Login />
    </Modal>
  )
}
Good to know:

The convention used to intercept the route, e.g. (.), depends on your file-system structure. See Intercepting Routes convention.
By separating the <Modal> functionality from the modal content (<Login>), you can ensure any content inside the modal, e.g. forms, are Server Components. See Interleaving Client and Server Components for more information.
Opening the modal
Now, you can leverage the Next.js router to open and close the modal. This ensures the URL is correctly updated when the modal is open, and when navigating backwards and forwards.

To open the modal, pass the @auth slot as a prop to the parent layout and render it alongside the children prop.

app/layout.tsx
TypeScript

TypeScript

import Link from 'next/link'
 
export default function Layout({
  auth,
  children,
}: {
  auth: React.ReactNode
  children: React.ReactNode
}) {
  return (
    <>
      <nav>
        <Link href="/login">Open modal</Link>
      </nav>
      <div>{auth}</div>
      <div>{children}</div>
    </>
  )
}
When the user clicks the <Link>, the modal will open instead of navigating to the /login page. However, on refresh or initial load, navigating to /login will take the user to the main login page.

Closing the modal
You can close the modal by calling router.back() or by using the Link component.

app/ui/modal.tsx
TypeScript

TypeScript

'use client'
 
import { useRouter } from 'next/navigation'
 
export function Modal({ children }: { children: React.ReactNode }) {
  const router = useRouter()
 
  return (
    <>
      <button
        onClick={() => {
          router.back()
        }}
      >
        Close modal
      </button>
      <div>{children}</div>
    </>
  )
}
When using the Link component to navigate away from a page that shouldn't render the @auth slot anymore, we need to make sure the parallel route matches to a component that returns null. For example, when navigating back to the root page, we create a @auth/page.tsx component:

app/ui/modal.tsx
TypeScript

TypeScript

import Link from 'next/link'
 
export function Modal({ children }: { children: React.ReactNode }) {
  return (
    <>
      <Link href="/">Close modal</Link>
      <div>{children}</div>
    </>
  )
}
app/@auth/page.tsx
TypeScript

TypeScript

export default function Page() {
  return null
}
Or if navigating to any other page (such as /foo, /foo/bar, etc), you can use a catch-all slot:

app/@auth/[...catchAll]/page.tsx
TypeScript

TypeScript

export default function CatchAll() {
  return null
}
Good to know:

We use a catch-all route in our @auth slot to close the modal because of the behavior described in Active state and navigation. Since client-side navigations to a route that no longer match the slot will remain visible, we need to match the slot to a route that returns null to close the modal.
Other examples could include opening a photo modal in a gallery while also having a dedicated /photo/[id] page, or opening a shopping cart in a side modal.
View an example of modals with Intercepted and Parallel Routes.
Loading and Error UI
Parallel Routes can be streamed independently, allowing you to define independent error and loading states for each route:

Parallel routes enable custom error and loading states
See the Loading UI and Error Handling documentation for more information.