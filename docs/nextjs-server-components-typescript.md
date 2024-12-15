# Next.js Server Components with TypeScript

## Overview
This document covers TypeScript patterns and best practices for Next.js Server Components, particularly focusing on data fetching and type safety.

## Server Component Types

### Page Props Types
```typescript
// Basic page props interface
interface PageProps {
  params: { [key: string]: string };
  searchParams: { [key: string]: string | string[] | undefined };
}

// Example usage in a page component
export default async function Page({ params, searchParams }: PageProps) {
  // Type-safe access to params and searchParams
  const { id } = params;
  const { q } = searchParams;
}
```

### Data Fetching Types
```typescript
// Type for async data fetching
type FetchResult<T> = {
  data: T | null;
  error?: string;
};

// Example usage
async function fetchData<T>(url: string): Promise<FetchResult<T>> {
  try {
    const response = await fetch(url);
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    const data = await response.json();
    return { data };
  } catch (error) {
    return { data: null, error: error instanceof Error ? error.message : 'Unknown error' };
  }
}
```

## Type-Safe API Routes

### Route Handler Types
```typescript
import { NextRequest, NextResponse } from 'next/server';

interface ApiResponse<T> {
  data?: T;
  error?: string;
}

export async function GET(
  request: NextRequest,
  { params }: { params: { id: string } }
): Promise<NextResponse<ApiResponse<any>>> {
  try {
    // Type-safe params access
    const { id } = params;
    return NextResponse.json({ data: { id } });
  } catch (error) {
    return NextResponse.json(
      { error: 'Failed to fetch data' },
      { status: 500 }
    );
  }
}
```

## Metadata Types

### Static Metadata
```typescript
import { Metadata } from 'next';

export const metadata: Metadata = {
  title: 'My Page',
  description: 'Page description'
};
```

### Dynamic Metadata
```typescript
import { Metadata } from 'next';

export async function generateMetadata(
  { params, searchParams }: PageProps
): Promise<Metadata> {
  return {
    title: `Page ${params.id}`,
    description: `Dynamic description for ${params.id}`
  };
}
```

## Error Handling

### Error Page Types
```typescript
interface ErrorPageProps {
  error: Error;
  reset: () => void;
}

export default function Error({ error, reset }: ErrorPageProps) {
  return (
    <div>
      <h2>Something went wrong!</h2>
      <button onClick={reset}>Try again</button>
    </div>
  );
}
```

## Loading States

### Loading Component Types
```typescript
interface LoadingProps {
  partial?: boolean;
}

export default function Loading({ partial }: LoadingProps) {
  return (
    <div>
      {partial ? 'Loading part of the page...' : 'Loading full page...'}
    </div>
  );
}
```

## Best Practices

1. **Type Safety in Server Components**
   - Always define proper interfaces for component props
   - Use strict TypeScript configurations
   - Avoid using `any` types

2. **Data Fetching**
   - Create type-safe wrapper functions for fetch operations
   - Define proper return types for all async operations
   - Handle errors with typed error responses

3. **State Management**
   - Use TypeScript to ensure type safety in state updates
   - Define proper interfaces for all state objects
   - Utilize discriminated unions for complex state

4. **API Integration**
   - Define types for all API responses
   - Use zod or similar libraries for runtime type validation
   - Create type-safe API client functions

## Common Issues and Solutions

### Issue: Type Safety with Dynamic Routes
```typescript
// Solution: Define proper param types
interface DynamicRouteParams {
  params: {
    slug: string[];
  };
  searchParams: { [key: string]: string | string[] | undefined };
}

export default function Page({ params, searchParams }: DynamicRouteParams) {
  // Type-safe access to dynamic route parameters
  const [category, id] = params.slug;
}
```

### Issue: Async Component Type Inference
```typescript
// Solution: Use proper type annotations
interface PageData {
  title: string;
  content: string;
}

async function getData(): Promise<PageData> {
  // ... fetch data
  return { title: 'Title', content: 'Content' };
}

export default async function Page() {
  const data = await getData();
  // TypeScript now knows the shape of data
  return <h1>{data.title}</h1>;
}
```
Server Components
React Server Components allow you to write UI that can be rendered and optionally cached on the server. In Next.js, the rendering work is further split by route segments to enable streaming and partial rendering, and there are three different server rendering strategies:

Static Rendering
Dynamic Rendering
Streaming
This page will go through how Server Components work, when you might use them, and the different server rendering strategies.

Benefits of Server Rendering
There are a couple of benefits to doing the rendering work on the server, including:

Data Fetching: Server Components allow you to move data fetching to the server, closer to your data source. This can improve performance by reducing time it takes to fetch data needed for rendering, and the number of requests the client needs to make.
Security: Server Components allow you to keep sensitive data and logic on the server, such as tokens and API keys, without the risk of exposing them to the client.
Caching: By rendering on the server, the result can be cached and reused on subsequent requests and across users. This can improve performance and reduce cost by reducing the amount of rendering and data fetching done on each request.
Performance: Server Components give you additional tools to optimize performance from the baseline. For example, if you start with an app composed of entirely Client Components, moving non-interactive pieces of your UI to Server Components can reduce the amount of client-side JavaScript needed. This is beneficial for users with slower internet or less powerful devices, as the browser has less client-side JavaScript to download, parse, and execute.
Initial Page Load and First Contentful Paint (FCP): On the server, we can generate HTML to allow users to view the page immediately, without waiting for the client to download, parse and execute the JavaScript needed to render the page.
Search Engine Optimization and Social Network Shareability: The rendered HTML can be used by search engine bots to index your pages and social network bots to generate social card previews for your pages.
Streaming: Server Components allow you to split the rendering work into chunks and stream them to the client as they become ready. This allows the user to see parts of the page earlier without having to wait for the entire page to be rendered on the server.
Using Server Components in Next.js
By default, Next.js uses Server Components. This allows you to automatically implement server rendering with no additional configuration, and you can opt into using Client Components when needed, see Client Components.

How are Server Components rendered?
On the server, Next.js uses React's APIs to orchestrate rendering. The rendering work is split into chunks: by individual route segments and Suspense Boundaries.

Each chunk is rendered in two steps:

React renders Server Components into a special data format called the React Server Component Payload (RSC Payload).
Next.js uses the RSC Payload and Client Component JavaScript instructions to render HTML on the server.
Then, on the client:

The HTML is used to immediately show a fast non-interactive preview of the route - this is for the initial page load only.
The React Server Components Payload is used to reconcile the Client and Server Component trees, and update the DOM.
The JavaScript instructions are used to hydrate Client Components and make the application interactive.
What is the React Server Component Payload (RSC)?
The RSC Payload is a compact binary representation of the rendered React Server Components tree. It's used by React on the client to update the browser's DOM. The RSC Payload contains:

The rendered result of Server Components
Placeholders for where Client Components should be rendered and references to their JavaScript files
Any props passed from a Server Component to a Client Component
Server Rendering Strategies
There are three subsets of server rendering: Static, Dynamic, and Streaming.

Static Rendering (Default)
With Static Rendering, routes are rendered at build time, or in the background after data revalidation. The result is cached and can be pushed to a Content Delivery Network (CDN). This optimization allows you to share the result of the rendering work between users and server requests.

Static rendering is useful when a route has data that is not personalized to the user and can be known at build time, such as a static blog post or a product page.

Dynamic Rendering
With Dynamic Rendering, routes are rendered for each user at request time.

Dynamic rendering is useful when a route has data that is personalized to the user or has information that can only be known at request time, such as cookies or the URL's search params.

Dynamic Routes with Cached Data

In most websites, routes are not fully static or fully dynamic - it's a spectrum. For example, you can have an e-commerce page that uses cached product data that's revalidated at an interval, but also has uncached, personalized customer data.

In Next.js, you can have dynamically rendered routes that have both cached and uncached data. This is because the RSC Payload and data are cached separately. This allows you to opt into dynamic rendering without worrying about the performance impact of fetching all the data at request time.

Learn more about the full-route cache and Data Cache.

Switching to Dynamic Rendering
During rendering, if a Dynamic API or a fetch option of { cache: 'no-store' } is discovered, Next.js will switch to dynamically rendering the whole route. This table summarizes how Dynamic APIs and data caching affect whether a route is statically or dynamically rendered:

Dynamic APIs	Data	Route
No	Cached	Statically Rendered
Yes	Cached	Dynamically Rendered
No	Not Cached	Dynamically Rendered
Yes	Not Cached	Dynamically Rendered
In the table above, for a route to be fully static, all data must be cached. However, you can have a dynamically rendered route that uses both cached and uncached data fetches.

As a developer, you do not need to choose between static and dynamic rendering as Next.js will automatically choose the best rendering strategy for each route based on the features and APIs used. Instead, you choose when to cache or revalidate specific data, and you may choose to stream parts of your UI.

Dynamic APIs
Dynamic APIs rely on information that can only be known at request time (and not ahead of time during prerendering). Using any of these APIs signals the developer's intention and will opt the whole route into dynamic rendering at the request time. These APIs include:

cookies
headers
connection
draftMode
searchParams prop
unstable_noStore
Streaming
Diagram showing parallelization of route segments during streaming, showing data fetching, rendering, and hydration of individual chunks.
Streaming enables you to progressively render UI from the server. Work is split into chunks and streamed to the client as it becomes ready. This allows the user to see parts of the page immediately, before the entire content has finished rendering.

Diagram showing partially rendered page on the client, with loading UI for chunks that are being streamed.
Streaming is built into the Next.js App Router by default. This helps improve both the initial page loading performance, as well as UI that depends on slower data fetches that would block rendering the whole route. For example, reviews on a product page.

You can start streaming route segments using loading.js and UI components with React Suspense. See the Loading UI and Streaming section for more information.
Client Components
Client Components allow you to write interactive UI that is prerendered on the server and can use client JavaScript to run in the browser.

This page will go through how Client Components work, how they're rendered, and when you might use them.

Benefits of Client Rendering
There are a couple of benefits to doing the rendering work on the client, including:

Interactivity: Client Components can use state, effects, and event listeners, meaning they can provide immediate feedback to the user and update the UI.
Browser APIs: Client Components have access to browser APIs, like geolocation or localStorage.
Using Client Components in Next.js
To use Client Components, you can add the React "use client" directive at the top of a file, above your imports.

"use client" is used to declare a boundary between a Server and Client Component modules. This means that by defining a "use client" in a file, all other modules imported into it, including child components, are considered part of the client bundle.

app/counter.tsx
TypeScript

TypeScript

'use client'
 
import { useState } from 'react'
 
export default function Counter() {
  const [count, setCount] = useState(0)
 
  return (
    <div>
      <p>You clicked {count} times</p>
      <button onClick={() => setCount(count + 1)}>Click me</button>
    </div>
  )
}
The diagram below shows that using onClick and useState in a nested component (toggle.js) will cause an error if the "use client" directive is not defined. This is because, by default, all components in the App Router are Server Components where these APIs are not available. By defining the "use client" directive in toggle.js, you can tell React to enter the client boundary where these APIs are available.

Use Client Directive and Network Boundary
Defining multiple use client entry points:

You can define multiple "use client" entry points in your React Component tree. This allows you to split your application into multiple client bundles.

However, "use client" doesn't need to be defined in every component that needs to be rendered on the client. Once you define the boundary, all child components and modules imported into it are considered part of the client bundle.

How are Client Components Rendered?
In Next.js, Client Components are rendered differently depending on whether the request is part of a full page load (an initial visit to your application or a page reload triggered by a browser refresh) or a subsequent navigation.

Full page load
To optimize the initial page load, Next.js will use React's APIs to render a static HTML preview on the server for both Client and Server Components. This means, when the user first visits your application, they will see the content of the page immediately, without having to wait for the client to download, parse, and execute the Client Component JavaScript bundle.

On the server:

React renders Server Components into a special data format called the React Server Component Payload (RSC Payload), which includes references to Client Components.
Next.js uses the RSC Payload and Client Component JavaScript instructions to render HTML for the route on the server.
Then, on the client:

The HTML is used to immediately show a fast non-interactive initial preview of the route.
The React Server Components Payload is used to reconcile the Client and Server Component trees, and update the DOM.
The JavaScript instructions are used to hydrate Client Components and make their UI interactive.
What is hydration?

Hydration is the process of attaching event listeners to the DOM, to make the static HTML interactive. Behind the scenes, hydration is done with the hydrateRoot React API.

Subsequent Navigations
On subsequent navigations, Client Components are rendered entirely on the client, without the server-rendered HTML.

This means the Client Component JavaScript bundle is downloaded and parsed. Once the bundle is ready, React will use the RSC Payload to reconcile the Client and Server Component trees, and update the DOM.

Going back to the Server Environment
Sometimes, after you've declared the "use client" boundary, you may want to go back to the server environment. For example, you may want to reduce the client bundle size, fetch data on the server, or use an API that is only available on the server.

You can keep code on the server even though it's theoretically nested inside Client Components by interleaving Client and Server Components and Server Actions. See the Composition Patterns page for more information.
Data Fetching and Caching
This guide will walk you through the basics of data fetching and caching in Next.js, providing practical examples and best practices.

Here's a minimal example of data fetching in Next.js:

app/page.tsx
TypeScript

TypeScript

export default async function Page() {
  const data = await fetch('https://api.vercel.app/blog')
  const posts = await data.json()
  return (
    <ul>
      {posts.map((post) => (
        <li key={post.id}>{post.title}</li>
      ))}
    </ul>
  )
}
This example demonstrates a basic server-side data fetch using the fetch API in an asynchronous React Server Component.

Reference
fetch
React cache
Next.js unstable_cache
Examples
Fetching data on the server with the fetch API
This component will fetch and display a list of blog posts. The response from fetch is not cached by default.

app/page.tsx
TypeScript

TypeScript

export default async function Page() {
  const data = await fetch('https://api.vercel.app/blog')
  const posts = await data.json()
  return (
    <ul>
      {posts.map((post) => (
        <li key={post.id}>{post.title}</li>
      ))}
    </ul>
  )
}
If you are not using any Dynamic APIs anywhere else in this route, it will be prerendered during next build to a static page. The data can then be updated using Incremental Static Regeneration.

To prevent the page from prerendering, you can add the following to your file:


export const dynamic = 'force-dynamic'
However, you will commonly use functions like cookies, headers, or reading the incoming searchParams from the page props, which will automatically make the page render dynamically. In this case, you do not need to explicitly use force-dynamic.

Fetching data on the server with an ORM or database
This component will fetch and display a list of blog posts. The response from the database is not cached by default but could be with additional configuration.

app/page.tsx
TypeScript

TypeScript

import { db, posts } from '@/lib/db'
 
export default async function Page() {
  const allPosts = await db.select().from(posts)
  return (
    <ul>
      {allPosts.map((post) => (
        <li key={post.id}>{post.title}</li>
      ))}
    </ul>
  )
}
If you are not using any Dynamic APIs anywhere else in this route, it will be prerendered during next build to a static page. The data can then be updated using Incremental Static Regeneration.

To prevent the page from prerendering, you can add the following to your file:


export const dynamic = 'force-dynamic'
However, you will commonly use functions like cookies, headers, or reading the incoming searchParams from the page props, which will automatically make the page render dynamically. In this case, you do not need to explicitly use force-dynamic.

Fetching data on the client
We recommend first attempting to fetch data on the server-side.

However, there are still cases where client-side data fetching makes sense. In these scenarios, you can manually call fetch in a useEffect (not recommended), or lean on popular React libraries in the community (such as SWR or React Query) for client fetching.

app/page.tsx
TypeScript

TypeScript

'use client'
 
import { useState, useEffect } from 'react'
 
export function Posts() {
  const [posts, setPosts] = useState(null)
 
  useEffect(() => {
    async function fetchPosts() {
      const res = await fetch('https://api.vercel.app/blog')
      const data = await res.json()
      setPosts(data)
    }
    fetchPosts()
  }, [])
 
  if (!posts) return <div>Loading...</div>
 
  return (
    <ul>
      {posts.map((post) => (
        <li key={post.id}>{post.title}</li>
      ))}
    </ul>
  )
}
Caching data with an ORM or Database
You can use the unstable_cache API to cache the response to allow pages to be prerendered when running next build.

app/page.tsx
TypeScript

TypeScript

import { unstable_cache } from 'next/cache'
import { db, posts } from '@/lib/db'
 
const getPosts = unstable_cache(
  async () => {
    return await db.select().from(posts)
  },
  ['posts'],
  { revalidate: 3600, tags: ['posts'] }
)
 
export default async function Page() {
  const allPosts = await getPosts()
 
  return (
    <ul>
      {allPosts.map((post) => (
        <li key={post.id}>{post.title}</li>
      ))}
    </ul>
  )
}
This example caches the result of the database query for 1 hour (3600 seconds). It also adds the cache tag posts which can then be invalidated with Incremental Static Regeneration.

Reusing data across multiple functions
Next.js uses APIs like generateMetadata and generateStaticParams where you will need to use the same data fetched in the page.

If you are using fetch, requests can be memoized by adding cache: 'force-cache'. This means you can safely call the same URL with the same options, and only one request will be made.

Good to know:

In previous versions of Next.js, using fetch would have a default cache value of force-cache. This changed in version 15, to a default of cache: no-store.
app/blog/[id]/page.tsx
TypeScript

TypeScript

import { notFound } from 'next/navigation'
 
interface Post {
  id: string
  title: string
  content: string
}
 
async function getPost(id: string) {
  const res = await fetch(`https://api.vercel.app/blog/${id}`, {
    cache: 'force-cache',
  })
  const post: Post = await res.json()
  if (!post) notFound()
  return post
}
 
export async function generateStaticParams() {
  const posts = await fetch('https://api.vercel.app/blog', {
    cache: 'force-cache',
  }).then((res) => res.json())
 
  return posts.map((post: Post) => ({
    id: String(post.id),
  }))
}
 
export async function generateMetadata({
  params,
}: {
  params: Promise<{ id: string }>
}) {
  const { id } = await params
  const post = await getPost(id)
 
  return {
    title: post.title,
  }
}
 
export default async function Page({
  params,
}: {
  params: Promise<{ id: string }>
}) {
  const { id } = await params
  const post = await getPost(id)
 
  return (
    <article>
      <h1>{post.title}</h1>
      <p>{post.content}</p>
    </article>
  )
}
If you are not using fetch, and instead using an ORM or database directly, you can wrap your data fetch with the React cache function. This will de-duplicate and only make one query.


import { cache } from 'react'
import { db, posts, eq } from '@/lib/db' // Example with Drizzle ORM
import { notFound } from 'next/navigation'
 
export const getPost = cache(async (id) => {
  const post = await db.query.posts.findFirst({
    where: eq(posts.id, parseInt(id)),
  })
 
  if (!post) notFound()
  return post
})
Revalidating cached data
Learn more about revalidating cached data with Incremental Static Regeneration.

Patterns
Parallel and sequential data fetching
When fetching data inside components, you need to be aware of two data fetching patterns: Parallel and Sequential.

Sequential and Parallel Data Fetching
Sequential: requests in a component tree are dependent on each other. This can lead to longer loading times.
Parallel: requests in a route are eagerly initiated and will load data at the same time. This reduces the total time it takes to load data.
Sequential data fetching
If you have nested components, and each component fetches its own data, then data fetching will happen sequentially if those data requests are not memoized.

There may be cases where you want this pattern because one fetch depends on the result of the other. For example, the Playlists component will only start fetching data once the Artist component has finished fetching data because Playlists depends on the artistID prop:

app/artist/[username]/page.tsx
TypeScript

TypeScript

export default async function Page({
  params,
}: {
  params: Promise<{ username: string }>
}) {
  const { username } = await params
  // Get artist information
  const artist = await getArtist(username)
 
  return (
    <>
      <h1>{artist.name}</h1>
      {/* Show fallback UI while the Playlists component is loading */}
      <Suspense fallback={<div>Loading...</div>}>
        {/* Pass the artist ID to the Playlists component */}
        <Playlists artistID={artist.id} />
      </Suspense>
    </>
  )
}
 
async function Playlists({ artistID }: { artistID: string }) {
  // Use the artist ID to fetch playlists
  const playlists = await getArtistPlaylists(artistID)
 
  return (
    <ul>
      {playlists.map((playlist) => (
        <li key={playlist.id}>{playlist.name}</li>
      ))}
    </ul>
  )
}
You can use loading.js (for route segments) or React <Suspense> (for nested components) to show an instant loading state while React streams in the result.

This will prevent the whole route from being blocked by data requests, and the user will be able to interact with the parts of the page that are ready.

Parallel Data Fetching
By default, layout and page segments are rendered in parallel. This means requests will be initiated in parallel.

However, due to the nature of async/await, an awaited request inside the same segment or component will block any requests below it.

To fetch data in parallel, you can eagerly initiate requests by defining them outside the components that use the data. This saves time by initiating both requests in parallel, however, the user won't see the rendered result until both promises are resolved.

In the example below, the getArtist and getAlbums functions are defined outside the Page component and initiated inside the component using Promise.all:

app/artist/[username]/page.tsx
TypeScript

TypeScript

import Albums from './albums'
 
async function getArtist(username: string) {
  const res = await fetch(`https://api.example.com/artist/${username}`)
  return res.json()
}
 
async function getAlbums(username: string) {
  const res = await fetch(`https://api.example.com/artist/${username}/albums`)
  return res.json()
}
 
export default async function Page({
  params,
}: {
  params: Promise<{ username: string }>
}) {
  const { username } = await params
  const artistData = getArtist(username)
  const albumsData = getAlbums(username)
 
  // Initiate both requests in parallel
  const [artist, albums] = await Promise.all([artistData, albumsData])
 
  return (
    <>
      <h1>{artist.name}</h1>
      <Albums list={albums} />
    </>
  )
}
In addition, you can add a Suspense Boundary to break up the rendering work and show part of the result as soon as possible.

Preloading Data
Another way to prevent waterfalls is to use the preload pattern by creating an utility function that you eagerly call above blocking requests. For example, checkIsAvailable() blocks <Item/> from rendering, so you can call preload() before it to eagerly initiate <Item/> data dependencies. By the time <Item/> is rendered, its data has already been fetched.

Note that preload function doesn't block checkIsAvailable() from running.

components/Item.tsx
TypeScript

TypeScript

import { getItem } from '@/utils/get-item'
 
export const preload = (id: string) => {
  // void evaluates the given expression and returns undefined
  // https://developer.mozilla.org/docs/Web/JavaScript/Reference/Operators/void
  void getItem(id)
}
export default async function Item({ id }: { id: string }) {
  const result = await getItem(id)
  // ...
}
app/item/[id]/page.tsx
TypeScript

TypeScript

import Item, { preload, checkIsAvailable } from '@/components/Item'
 
export default async function Page({
  params,
}: {
  params: Promise<{ id: string }>
}) {
  const { id } = await params
  // starting loading item data
  preload(id)
  // perform another asynchronous task
  const isAvailable = await checkIsAvailable()
 
  return isAvailable ? <Item id={id} /> : null
}
Good to know: The "preload" function can also have any name as it's a pattern, not an API.

Using React cache and server-only with the Preload Pattern
You can combine the cache function, the preload pattern, and the server-only package to create a data fetching utility that can be used throughout your app.

utils/get-item.ts
TypeScript

TypeScript

import { cache } from 'react'
import 'server-only'
 
export const preload = (id: string) => {
  void getItem(id)
}
 
export const getItem = cache(async (id: string) => {
  // ...
})
With this approach, you can eagerly fetch data, cache responses, and guarantee that this data fetching only happens on the server.

The utils/get-item exports can be used by Layouts, Pages, or other components to give them control over when an item's data is fetched.

Good to know:

We recommend using the server-only package to make sure server data fetching functions are never used on the client.
Preventing sensitive data from being exposed to the client
We recommend using React's taint APIs, taintObjectReference and taintUniqueValue, to prevent whole object instances or sensitive values from being passed to the client.

To enable tainting in your application, set the Next.js Config experimental.taint option to true:

next.config.js

module.exports = {
  experimental: {
    taint: true,
  },
}
Then pass the object or value you want to taint to the experimental_taintObjectReference or experimental_taintUniqueValue functions:

app/utils.ts
TypeScript

TypeScript

import { queryDataFromDB } from './api'
import {
  experimental_taintObjectReference,
  experimental_taintUniqueValue,
} from 'react'
 
export async function getUserData() {
  const data = await queryDataFromDB()
  experimental_taintObjectReference(
    'Do not pass the whole user object to the client',
    data
  )
  experimental_taintUniqueValue(
    "Do not pass the user's address to the client",
    data,
    data.address
  )
  return data
}
app/page.tsx
TypeScript

TypeScript

import { getUserData } from './data'
 
export async function Page() {
  const userData = getUserData()
  return (
    <ClientComponent
      user={userData} // this will cause an error because of taintObjectReference
      address={userData.address} // this will cause an error because of taintUniqueValue
    />
  )
}
getServerSideProps
getServerSideProps is a Next.js function that can be used to fetch data and render the contents of a page at request time.

Example
You can use getServerSideProps by exporting it from a Page Component. The example below shows how you can fetch data from a 3rd party API in getServerSideProps, and pass the data to the page as props:

pages/index.tsx
TypeScript

TypeScript

import type { InferGetServerSidePropsType, GetServerSideProps } from 'next'
 
type Repo = {
  name: string
  stargazers_count: number
}
 
export const getServerSideProps = (async () => {
  // Fetch data from external API
  const res = await fetch('https://api.github.com/repos/vercel/next.js')
  const repo: Repo = await res.json()
  // Pass data to the page via props
  return { props: { repo } }
}) satisfies GetServerSideProps<{ repo: Repo }>
 
export default function Page({
  repo,
}: InferGetServerSidePropsType<typeof getServerSideProps>) {
  return (
    <main>
      <p>{repo.stargazers_count}</p>
    </main>
  )
}
When should I use getServerSideProps?
You should use getServerSideProps if you need to render a page that relies on personalized user data, or information that can only be known at request time. For example, authorization headers or a geolocation.

If you do not need to fetch the data at request time, or would prefer to cache the data and pre-rendered HTML, we recommend using getStaticProps.

Behavior
getServerSideProps runs on the server.
getServerSideProps can only be exported from a page.
getServerSideProps returns JSON.
When a user visits a page, getServerSideProps will be used to fetch data at request time, and the data is used to render the initial HTML of the page.
props passed to the page component can be viewed on the client as part of the initial HTML. This is to allow the page to be hydrated correctly. Make sure that you don't pass any sensitive information that shouldn't be available on the client in props.
When a user visits the page through next/link or next/router, Next.js sends an API request to the server, which runs getServerSideProps.
You do not have to call a Next.js API Route to fetch data when using getServerSideProps since the function runs on the server. Instead, you can call a CMS, database, or other third-party APIs directly from inside getServerSideProps.
Good to know:

See getServerSideProps API reference for parameters and props that can be used with getServerSideProps.
You can use the next-code-elimination tool to verify what Next.js eliminates from the client-side bundle.
Error Handling
If an error is thrown inside getServerSideProps, it will show the pages/500.js file. Check out the documentation for 500 page to learn more on how to create it. During development, this file will not be used and the development error overlay will be shown instead.

Edge Cases
Caching with Server-Side Rendering (SSR)
You can use caching headers (Cache-Control) inside getServerSideProps to cache dynamic responses. For example, using stale-while-revalidate.


// This value is considered fresh for ten seconds (s-maxage=10).
// If a request is repeated within the next 10 seconds, the previously
// cached value will still be fresh. If the request is repeated before 59 seconds,
// the cached value will be stale but still render (stale-while-revalidate=59).
//
// In the background, a revalidation request will be made to populate the cache
// with a fresh value. If you refresh the page, you will see the new value.
export async function getServerSideProps({ req, res }) {
  res.setHeader(
    'Cache-Control',
    'public, s-maxage=10, stale-while-revalidate=59'
  )
 
  return {
    props: {},
  }
}
However, before reaching for cache-control, we recommend seeing if getStaticProps with ISR is a better fit for your use case.
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

Previous
Custom Document
Next
Server Actions and Mutations
Server Actions are asynchronous functions that are executed on the server. They can be called in Server and Client Components to handle form submissions and data mutations in Next.js applications.

🎥 Watch: Learn more about mutations with Server Actions → YouTube (10 minutes).

Convention
A Server Action can be defined with the React "use server" directive. You can place the directive at the top of an async function to mark the function as a Server Action, or at the top of a separate file to mark all exports of that file as Server Actions.

Server Components
Server Components can use the inline function level or module level "use server" directive. To inline a Server Action, add "use server" to the top of the function body:

app/page.tsx
TypeScript

TypeScript

export default function Page() {
  // Server Action
  async function create() {
    'use server'
    // Mutate data
  }
 
  return '...'
}
Client Components
To call a Server Action in a Client Component, create a new file and add the "use server" directive at the top of it. All exported functions within the file will be marked as Server Actions that can be reused in both Client and Server Components:

app/actions.ts
TypeScript

TypeScript

'use server'
 
export async function create() {}
app/ui/button.tsx
TypeScript

TypeScript

'use client'
 
import { create } from '@/app/actions'
 
export function Button() {
  return <button onClick={() => create()}>Create</button>
}
Passing actions as props
You can also pass a Server Action to a Client Component as a prop:


<ClientComponent updateItemAction={updateItem} />
app/client-component.tsx
TypeScript

TypeScript

'use client'
 
export default function ClientComponent({
  updateItemAction,
}: {
  updateItemAction: (formData: FormData) => void
}) {
  return <form action={updateItemAction}>{/* ... */}</form>
}
Usually, the Next.js TypeScript plugin would flag updateItemAction in client-component.tsx since it is a function which generally can't be serialized across client-server boundaries. However, props named action or ending with Action are assumed to receive Server Actions. This is only a heuristic since the TypeScript plugin doesn't actually know if it receives a Server Action or an ordinary function. Runtime type-checking will still ensure you don't accidentally pass a function to a Client Component.

Behavior
Server actions can be invoked using the action attribute in a <form> element:
Server Components support progressive enhancement by default, meaning the form will be submitted even if JavaScript hasn't loaded yet or is disabled.
In Client Components, forms invoking Server Actions will queue submissions if JavaScript isn't loaded yet, prioritizing client hydration.
After hydration, the browser does not refresh on form submission.
Server Actions are not limited to <form> and can be invoked from event handlers, useEffect, third-party libraries, and other form elements like <button>.
Server Actions integrate with the Next.js caching and revalidation architecture. When an action is invoked, Next.js can return both the updated UI and new data in a single server roundtrip.
Behind the scenes, actions use the POST method, and only this HTTP method can invoke them.
The arguments and return value of Server Actions must be serializable by React. See the React docs for a list of serializable arguments and values.
Server Actions are functions. This means they can be reused anywhere in your application.
Server Actions inherit the runtime from the page or layout they are used on.
Server Actions inherit the Route Segment Config from the page or layout they are used on, including fields like maxDuration.
Examples
Forms
React extends the HTML <form> element to allow Server Actions to be invoked with the action prop.

When invoked in a form, the action automatically receives the FormData object. You don't need to use React useState to manage fields, instead, you can extract the data using the native FormData methods:

app/invoices/page.tsx
TypeScript

TypeScript

export default function Page() {
  async function createInvoice(formData: FormData) {
    'use server'
 
    const rawFormData = {
      customerId: formData.get('customerId'),
      amount: formData.get('amount'),
      status: formData.get('status'),
    }
 
    // mutate data
    // revalidate cache
  }
 
  return <form action={createInvoice}>...</form>
}
Good to know:

Example: Form with Loading & Error States
When working with forms that have many fields, you may want to consider using the entries() method with JavaScript's Object.fromEntries(). For example: const rawFormData = Object.fromEntries(formData). One thing to note is that the formData will include additional $ACTION_ properties.
See React <form> documentation to learn more.
Passing additional arguments
You can pass additional arguments to a Server Action using the JavaScript bind method.

app/client-component.tsx
TypeScript

TypeScript

'use client'
 
import { updateUser } from './actions'
 
export function UserProfile({ userId }: { userId: string }) {
  const updateUserWithId = updateUser.bind(null, userId)
 
  return (
    <form action={updateUserWithId}>
      <input type="text" name="name" />
      <button type="submit">Update User Name</button>
    </form>
  )
}
The Server Action will receive the userId argument, in addition to the form data:

app/actions.ts
TypeScript

TypeScript

'use server'
 
export async function updateUser(userId: string, formData: FormData) {}
Good to know:

An alternative is to pass arguments as hidden input fields in the form (e.g. <input type="hidden" name="userId" value={userId} />). However, the value will be part of the rendered HTML and will not be encoded.
.bind works in both Server and Client Components. It also supports progressive enhancement.
Nested form elements
You can also invoke a Server Action in elements nested inside <form> such as <button>, <input type="submit">, and <input type="image">. These elements accept the formAction prop or event handlers.

This is useful in cases where you want to call multiple server actions within a form. For example, you can create a specific <button> element for saving a post draft in addition to publishing it. See the React <form> docs for more information.

Programmatic form submission
You can trigger a form submission programmatically using the requestSubmit() method. For example, when the user submits a form using the ⌘ + Enter keyboard shortcut, you can listen for the onKeyDown event:

app/entry.tsx
TypeScript

TypeScript

'use client'
 
export function Entry() {
  const handleKeyDown = (e: React.KeyboardEvent<HTMLTextAreaElement>) => {
    if (
      (e.ctrlKey || e.metaKey) &&
      (e.key === 'Enter' || e.key === 'NumpadEnter')
    ) {
      e.preventDefault()
      e.currentTarget.form?.requestSubmit()
    }
  }
 
  return (
    <div>
      <textarea name="entry" rows={20} required onKeyDown={handleKeyDown} />
    </div>
  )
}
This will trigger the submission of the nearest <form> ancestor, which will invoke the Server Action.

Server-side form validation
You can use the HTML attributes like required and type="email" for basic client-side form validation.

For more advanced server-side validation, you can use a library like zod to validate the form fields before mutating the data:

app/actions.ts
TypeScript

TypeScript

'use server'
 
import { z } from 'zod'
 
const schema = z.object({
  email: z.string({
    invalid_type_error: 'Invalid Email',
  }),
})
 
export default async function createUser(formData: FormData) {
  const validatedFields = schema.safeParse({
    email: formData.get('email'),
  })
 
  // Return early if the form data is invalid
  if (!validatedFields.success) {
    return {
      errors: validatedFields.error.flatten().fieldErrors,
    }
  }
 
  // Mutate data
}
Once the fields have been validated on the server, you can return a serializable object in your action and use the React useActionState hook to show a message to the user.

By passing the action to useActionState, the action's function signature changes to receive a new prevState or initialState parameter as its first argument.
useActionState is a React hook and therefore must be used in a Client Component.
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
Pending states
The useActionState hook exposes a pending boolean that can be used to show a loading indicator while the action is being executed.

Alternatively, you can use the useFormStatus hook to show a loading indicator while the action is being executed. When using this hook, you'll need to create a separate component to render the loading indicator. For example, to disable the button when the action is pending:

app/ui/button.tsx
TypeScript

TypeScript

'use client'
 
import { useFormStatus } from 'react-dom'
 
export function SubmitButton() {
  const { pending } = useFormStatus()
 
  return (
    <button disabled={pending} type="submit">
      Sign Up
    </button>
  )
}
You can then nest the SubmitButton component inside the form:

app/ui/signup.tsx
TypeScript

TypeScript

import { SubmitButton } from './button'
import { createUser } from '@/app/actions'
 
export function Signup() {
  return (
    <form action={createUser}>
      {/* Other form elements */}
      <SubmitButton />
    </form>
  )
}
Good to know: In React 19, useFormStatus includes additional keys on the returned object, like data, method, and action. If you are not using React 19, only the pending key is available.

Optimistic updates
You can use the React useOptimistic hook to optimistically update the UI before the Server Action finishes executing, rather than waiting for the response:

app/page.tsx
TypeScript

TypeScript

'use client'
 
import { useOptimistic } from 'react'
import { send } from './actions'
 
type Message = {
  message: string
}
 
export function Thread({ messages }: { messages: Message[] }) {
  const [optimisticMessages, addOptimisticMessage] = useOptimistic<
    Message[],
    string
  >(messages, (state, newMessage) => [...state, { message: newMessage }])
 
  const formAction = async (formData: FormData) => {
    const message = formData.get('message') as string
    addOptimisticMessage(message)
    await send(message)
  }
 
  return (
    <div>
      {optimisticMessages.map((m, i) => (
        <div key={i}>{m.message}</div>
      ))}
      <form action={formAction}>
        <input type="text" name="message" />
        <button type="submit">Send</button>
      </form>
    </div>
  )
}
Event handlers
While it's common to use Server Actions within <form> elements, they can also be invoked with event handlers such as onClick. For example, to increment a like count:

app/like-button.tsx
TypeScript

TypeScript

'use client'
 
import { incrementLike } from './actions'
import { useState } from 'react'
 
export default function LikeButton({ initialLikes }: { initialLikes: number }) {
  const [likes, setLikes] = useState(initialLikes)
 
  return (
    <>
      <p>Total Likes: {likes}</p>
      <button
        onClick={async () => {
          const updatedLikes = await incrementLike()
          setLikes(updatedLikes)
        }}
      >
        Like
      </button>
    </>
  )
}
You can also add event handlers to form elements, for example, to save a form field onChange:

app/ui/edit-post.tsx

'use client'
 
import { publishPost, saveDraft } from './actions'
 
export default function EditPost() {
  return (
    <form action={publishPost}>
      <textarea
        name="content"
        onChange={async (e) => {
          await saveDraft(e.target.value)
        }}
      />
      <button type="submit">Publish</button>
    </form>
  )
}
For cases like this, where multiple events might be fired in quick succession, we recommend debouncing to prevent unnecessary Server Action invocations.

useEffect
You can use the React useEffect hook to invoke a Server Action when the component mounts or a dependency changes. This is useful for mutations that depend on global events or need to be triggered automatically. For example, onKeyDown for app shortcuts, an intersection observer hook for infinite scrolling, or when the component mounts to update a view count:

app/view-count.tsx
TypeScript

TypeScript

'use client'
 
import { incrementViews } from './actions'
import { useState, useEffect } from 'react'
 
export default function ViewCount({ initialViews }: { initialViews: number }) {
  const [views, setViews] = useState(initialViews)
 
  useEffect(() => {
    const updateViews = async () => {
      const updatedViews = await incrementViews()
      setViews(updatedViews)
    }
 
    updateViews()
  }, [])
 
  return <p>Total Views: {views}</p>
}
Remember to consider the behavior and caveats of useEffect.

Error Handling
When an error is thrown, it'll be caught by the nearest error.js or <Suspense> boundary on the client. See Error Handling for more information.

Good to know:

Aside from throwing the error, you can also return an object to be handled by useActionState. See Server-side validation and error handling.
Revalidating data
You can revalidate the Next.js Cache inside your Server Actions with the revalidatePath API:

app/actions.ts
TypeScript

TypeScript

'use server'
 
import { revalidatePath } from 'next/cache'
 
export async function createPost() {
  try {
    // ...
  } catch (error) {
    // ...
  }
 
  revalidatePath('/posts')
}
Or invalidate a specific data fetch with a cache tag using revalidateTag:

app/actions.ts
TypeScript

TypeScript

'use server'
 
import { revalidateTag } from 'next/cache'
 
export async function createPost() {
  try {
    // ...
  } catch (error) {
    // ...
  }
 
  revalidateTag('posts')
}
Redirecting
If you would like to redirect the user to a different route after the completion of a Server Action, you can use redirect API. redirect needs to be called outside of the try/catch block:

app/actions.ts
TypeScript

TypeScript

'use server'
 
import { redirect } from 'next/navigation'
import { revalidateTag } from 'next/cache'
 
export async function createPost(id: string) {
  try {
    // ...
  } catch (error) {
    // ...
  }
 
  revalidateTag('posts') // Update cached posts
  redirect(`/post/${id}`) // Navigate to the new post page
}
Cookies
You can get, set, and delete cookies inside a Server Action using the cookies API:

app/actions.ts
TypeScript

TypeScript

'use server'
 
import { cookies } from 'next/headers'
 
export async function exampleAction() {
  const cookieStore = await cookies()
 
  // Get cookie
  cookieStore.get('name')?.value
 
  // Set cookie
  cookieStore.set('name', 'Delba')
 
  // Delete cookie
  cookieStore.delete('name')
}
See additional examples for deleting cookies from Server Actions.

Security
By default, when a Server Action is created and exported, it creates a public HTTP endpoint and should be treated with the same security assumptions and authorization checks. This means, even if a Server Action or utility function is not imported elsewhere in your code, it’s still publicly accessible.

To improve security, Next.js has the following built-in features:

Secure action IDs: Next.js creates encrypted, non-deterministic IDs to allow the client to reference and call the Server Action. These IDs are periodically recalculated between builds for enhanced security.
Dead code elimination: Unused Server Actions (referenced by their IDs) are removed from client bundle to avoid public access by third-party.
Good to know:

The IDs are created during compilation and are cached for a maximum of 14 days. They will be regenerated when a new build is initiated or when the build cache is invalidated. This security improvement reduces the risk in cases where an authentication layer is missing. However, you should still treat Server Actions like public HTTP endpoints.


// app/actions.js
'use server'
 
// This action **is** used in our application, so Next.js
// will create a secure ID to allow the client to reference
// and call the Server Action.
export async function updateUserAction(formData) {}
 
// This action **is not** used in our application, so Next.js
// will automatically remove this code during `next build`
// and will not create a public endpoint.
export async function deleteUserAction(formData) {}
Authentication and authorization
You should ensure that the user is authorized to perform the action. For example:

app/actions.ts

'use server'
 
import { auth } from './lib'
 
export function addItem() {
  const { user } = auth()
  if (!user) {
    throw new Error('You must be signed in to perform this action')
  }
 
  // ...
}
Closures and encryption
Defining a Server Action inside a component creates a closure where the action has access to the outer function's scope. For example, the publish action has access to the publishVersion variable:

app/page.tsx
TypeScript

TypeScript

export default async function Page() {
  const publishVersion = await getLatestVersion();
 
  async function publish() {
    "use server";
    if (publishVersion !== await getLatestVersion()) {
      throw new Error('The version has changed since pressing publish');
    }
    ...
  }
 
  return (
    <form>
      <button formAction={publish}>Publish</button>
    </form>
  );
}
Closures are useful when you need to capture a snapshot of data (e.g. publishVersion) at the time of rendering so that it can be used later when the action is invoked.

However, for this to happen, the captured variables are sent to the client and back to the server when the action is invoked. To prevent sensitive data from being exposed to the client, Next.js automatically encrypts the closed-over variables. A new private key is generated for each action every time a Next.js application is built. This means actions can only be invoked for a specific build.

Good to know: We don't recommend relying on encryption alone to prevent sensitive values from being exposed on the client. Instead, you should use the React taint APIs to proactively prevent specific data from being sent to the client.

Overwriting encryption keys (advanced)
When self-hosting your Next.js application across multiple servers, each server instance may end up with a different encryption key, leading to potential inconsistencies.

To mitigate this, you can overwrite the encryption key using the process.env.NEXT_SERVER_ACTIONS_ENCRYPTION_KEY environment variable. Specifying this variable ensures that your encryption keys are persistent across builds, and all server instances use the same key.

This is an advanced use case where consistent encryption behavior across multiple deployments is critical for your application. You should consider standard security practices such key rotation and signing.

Good to know: Next.js applications deployed to Vercel automatically handle this.

Allowed origins (advanced)
Since Server Actions can be invoked in a <form> element, this opens them up to CSRF attacks.

Behind the scenes, Server Actions use the POST method, and only this HTTP method is allowed to invoke them. This prevents most CSRF vulnerabilities in modern browsers, particularly with SameSite cookies being the default.

As an additional protection, Server Actions in Next.js also compare the Origin header to the Host header (or X-Forwarded-Host). If these don't match, the request will be aborted. In other words, Server Actions can only be invoked on the same host as the page that hosts it.

For large applications that use reverse proxies or multi-layered backend architectures (where the server API differs from the production domain), it's recommended to use the configuration option serverActions.allowedOrigins option to specify a list of safe origins. The option accepts an array of strings.

next.config.js

/** @type {import('next').NextConfig} */
module.exports = {
  experimental: {
    serverActions: {
      allowedOrigins: ['my-proxy.com', '*.my-proxy.com'],
    },
  },
}
Learn more about Security and Server Actions.

Additional resources
For more information, check out the following React docs:

Server Actions
"use server"
<form>
useFormStatus
useActionState
useOptimistic
Server Components
React Server Components allow you to write UI that can be rendered and optionally cached on the server. In Next.js, the rendering work is further split by route segments to enable streaming and partial rendering, and there are three different server rendering strategies:

Static Rendering
Dynamic Rendering
Streaming
This page will go through how Server Components work, when you might use them, and the different server rendering strategies.

Benefits of Server Rendering
There are a couple of benefits to doing the rendering work on the server, including:

Data Fetching: Server Components allow you to move data fetching to the server, closer to your data source. This can improve performance by reducing time it takes to fetch data needed for rendering, and the number of requests the client needs to make.
Security: Server Components allow you to keep sensitive data and logic on the server, such as tokens and API keys, without the risk of exposing them to the client.
Caching: By rendering on the server, the result can be cached and reused on subsequent requests and across users. This can improve performance and reduce cost by reducing the amount of rendering and data fetching done on each request.
Performance: Server Components give you additional tools to optimize performance from the baseline. For example, if you start with an app composed of entirely Client Components, moving non-interactive pieces of your UI to Server Components can reduce the amount of client-side JavaScript needed. This is beneficial for users with slower internet or less powerful devices, as the browser has less client-side JavaScript to download, parse, and execute.
Initial Page Load and First Contentful Paint (FCP): On the server, we can generate HTML to allow users to view the page immediately, without waiting for the client to download, parse and execute the JavaScript needed to render the page.
Search Engine Optimization and Social Network Shareability: The rendered HTML can be used by search engine bots to index your pages and social network bots to generate social card previews for your pages.
Streaming: Server Components allow you to split the rendering work into chunks and stream them to the client as they become ready. This allows the user to see parts of the page earlier without having to wait for the entire page to be rendered on the server.
Using Server Components in Next.js
By default, Next.js uses Server Components. This allows you to automatically implement server rendering with no additional configuration, and you can opt into using Client Components when needed, see Client Components.

How are Server Components rendered?
On the server, Next.js uses React's APIs to orchestrate rendering. The rendering work is split into chunks: by individual route segments and Suspense Boundaries.

Each chunk is rendered in two steps:

React renders Server Components into a special data format called the React Server Component Payload (RSC Payload).
Next.js uses the RSC Payload and Client Component JavaScript instructions to render HTML on the server.
Then, on the client:

The HTML is used to immediately show a fast non-interactive preview of the route - this is for the initial page load only.
The React Server Components Payload is used to reconcile the Client and Server Component trees, and update the DOM.
The JavaScript instructions are used to hydrate Client Components and make the application interactive.
What is the React Server Component Payload (RSC)?
The RSC Payload is a compact binary representation of the rendered React Server Components tree. It's used by React on the client to update the browser's DOM. The RSC Payload contains:

The rendered result of Server Components
Placeholders for where Client Components should be rendered and references to their JavaScript files
Any props passed from a Server Component to a Client Component
Server Rendering Strategies
There are three subsets of server rendering: Static, Dynamic, and Streaming.

Static Rendering (Default)
With Static Rendering, routes are rendered at build time, or in the background after data revalidation. The result is cached and can be pushed to a Content Delivery Network (CDN). This optimization allows you to share the result of the rendering work between users and server requests.

Static rendering is useful when a route has data that is not personalized to the user and can be known at build time, such as a static blog post or a product page.

Dynamic Rendering
With Dynamic Rendering, routes are rendered for each user at request time.

Dynamic rendering is useful when a route has data that is personalized to the user or has information that can only be known at request time, such as cookies or the URL's search params.

Dynamic Routes with Cached Data

In most websites, routes are not fully static or fully dynamic - it's a spectrum. For example, you can have an e-commerce page that uses cached product data that's revalidated at an interval, but also has uncached, personalized customer data.

In Next.js, you can have dynamically rendered routes that have both cached and uncached data. This is because the RSC Payload and data are cached separately. This allows you to opt into dynamic rendering without worrying about the performance impact of fetching all the data at request time.

Learn more about the full-route cache and Data Cache.

Switching to Dynamic Rendering
During rendering, if a Dynamic API or a fetch option of { cache: 'no-store' } is discovered, Next.js will switch to dynamically rendering the whole route. This table summarizes how Dynamic APIs and data caching affect whether a route is statically or dynamically rendered:

Dynamic APIs	Data	Route
No	Cached	Statically Rendered
Yes	Cached	Dynamically Rendered
No	Not Cached	Dynamically Rendered
Yes	Not Cached	Dynamically Rendered
In the table above, for a route to be fully static, all data must be cached. However, you can have a dynamically rendered route that uses both cached and uncached data fetches.

As a developer, you do not need to choose between static and dynamic rendering as Next.js will automatically choose the best rendering strategy for each route based on the features and APIs used. Instead, you choose when to cache or revalidate specific data, and you may choose to stream parts of your UI.

Dynamic APIs
Dynamic APIs rely on information that can only be known at request time (and not ahead of time during prerendering). Using any of these APIs signals the developer's intention and will opt the whole route into dynamic rendering at the request time. These APIs include:

cookies
headers
connection
draftMode
searchParams prop
unstable_noStore
Streaming
Diagram showing parallelization of route segments during streaming, showing data fetching, rendering, and hydration of individual chunks.
Streaming enables you to progressively render UI from the server. Work is split into chunks and streamed to the client as it becomes ready. This allows the user to see parts of the page immediately, before the entire content has finished rendering.

Diagram showing partially rendered page on the client, with loading UI for chunks that are being streamed.
Streaming is built into the Next.js App Router by default. This helps improve both the initial page loading performance, as well as UI that depends on slower data fetches that would block rendering the whole route. For example, reviews on a product page.

You can start streaming route segments using loading.js and UI components with React Suspense. See the Loading UI and Streaming section for more information.
