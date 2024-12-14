# Next.js Layouts and Pages Documentation

## Creating Pages and Layouts

### Pages
A page is UI that is rendered on a specific route. Pages are defined by exporting a default React component from a `page.js` file.

```typescript
// app/page.tsx
export default function Page() {
  return <h1>Hello Next.js!</h1>
}
```

### Layouts
Layouts are shared UI between multiple pages. They:
- Preserve state on navigation
- Remain interactive
- Do not re-render

```typescript
// app/layout.tsx
export default function DashboardLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">
      <body>
        <main>{children}</main>
      </body>
    </html>
  )
}
```

## Route Structure

### Nested Routes
Routes are composed of multiple segments that map to URL paths:
- Folders define route segments
- Files (page.js, layout.js) create UI for segments

Example structure:
```
app/
  blog/
    [slug]/
      page.tsx    # /blog/[slug]
    page.tsx      # /blog
  page.tsx        # /
```

### Route Groups
- Use parentheses for organization: `(group-name)`
- Don't affect URL structure
- Useful for organizing related routes

## Navigation

### Link Component
```typescript
import Link from 'next/link'

export function PostList({ posts }) {
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
```

## Best Practices

### Layout Organization
- Use root layout for global UI elements
- Create nested layouts for specific sections
- Keep layouts focused and minimal

### Page Structure
- Export default components from page files
- Handle loading and error states appropriately
- Use dynamic routes when needed

## References
- [Next.js Documentation - Pages and Layouts](https://nextjs.org/docs/app/building-your-application/routing/pages-and-layouts)
- [Next.js Documentation - Route Groups](https://nextjs.org/docs/app/building-your-application/routing/route-groups)
