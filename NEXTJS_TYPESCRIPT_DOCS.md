# Next.js TypeScript Documentation Reference

## Required Documentation

Please provide documentation for the following key areas:

### 1. TypeScript with App Router
- Official Next.js documentation about TypeScript configuration in App Router
- Type definitions for page props and parameters
- Examples of correct type usage in server components
- Information about `generateMetadata` typing

### 2. Dynamic Route Segments
- How to properly type dynamic route parameters
- Examples of nested dynamic routes with TypeScript
- Type definitions for:
  - `params` object
  - `searchParams`
  - Page props

### 3. Server Components
- TypeScript patterns for async Server Components
- How to handle data fetching with proper types
- Type safety between client and server components
- Examples of correct prop typing for Server Components

### 4. Error Handling
- Type definitions for error states
- How to properly type error boundaries
- TypeScript patterns for handling async errors

## Current Issues

We're specifically trying to resolve type errors related to:
1. Page props in dynamic routes
2. Params typing in the App Router
3. Server Component async data fetching

Please provide any relevant documentation that addresses these areas.

How to type a page component with props in Next.js?
Asked 3 years, 2 months ago
Modified 1 year ago
Viewed 16k times
9

I'm looking to correctly annotate the Home function component's parameters, but am running into a little bit of trouble. I was hoping to annotate it like: { events }: { events: Event[] }, but am getting the TypeScript error, Property 'events' does not exist on type '{ children: ReactNode }' in Next.js.

Next does a lot of wizardry behind the scenes, so I am not sure how I can fix this. Any ideas?

import type { NextPage } from 'next';
import { GetServerSideProps } from 'next';
import axios from '../lib/axios';

import { Event } from '../ts/interfaces';

const Home: NextPage = ({ events }) => {
  return (
    <div>
      {events.map((event: Event) => (
        <div key={event.title}>{event.title}</div>
      ))}
    </div>
  );
};

export const getServerSideProps: GetServerSideProps = async () => {
  const res = await axios.get<Event[]>(`${process.env.API_URL}/events`);

  return {
    props: { events: res.data },
  };
};

export default Home;
reactjstypescriptnext.js
Share
Improve this question
Follow
edited Oct 14, 2021 at 20:35
juliomalves's user avatar
juliomalves
50.1k2323 gold badges176176 silver badges166166 bronze badges
asked Oct 13, 2021 at 18:57
Dan Zuzevich's user avatar
Dan Zuzevich
3,81144 gold badges3030 silver badges4343 bronze badges
1
Could you shows us what NextPage is? Might be useful – 
majkelS
 CommentedOct 13, 2021 at 19:24
Add a comment
2 Answers
Sorted by:

Highest score (default)
19

You need to pass the Home props type (in your case { events: Event[] }) as the generic type to NextPage.

import { Event } from '../ts/interfaces';

const Home: NextPage<{ events: Event[] }> = ({ events }) => {
    return (
        <div>
            {events.map((event: Event) => (
                <div key={event.title}>{event.title}</div>
            ))}
        </div>
    );
};
Share
Improve this answer
Follow
edited Jun 6, 2022 at 8:25
answered Oct 13, 2021 at 21:32
juliomalves's user avatar
juliomalves
50.1k2323 gold badges176176 silver badges166166 bronze badges
2
Interesting how the official typescript example doesn't include NextPage, nor how to add with a custom prop type. – 
wanna_coder101
 CommentedMay 30, 2022 at 2:52
4
@wanna_coder101 Weirdly enough the only place where NextPage is referenced in the docs is here: nextjs.org/docs/api-reference/data-fetching/…. – 
juliomalves
 CommentedMay 30, 2022 at 7:37 
1
Thanks for this! I was trying to pass a PageProps interface, but kept getting an error of Type '({ posts }: { posts: PageProps; }) => { posts: PageProps; }' is not assignable to type 'NextPage<{ posts: PageProps; }, { posts: PageProps; }>'. Couldn't understand the duplication. – 
deadbyte
 CommentedAug 10, 2022 at 18:54
Add a comment
11

If someone is looking for a type of "app directory" page (next 13+). You'll have to make your own, I couldn't find a type to import from the next package, so:

interface IPageProps {
  params: { your_dynamic_prop_here: string };
  searchParams: Record<string | string[], string | undefined>
}
export default function Page(props: IPageProps) {...}
Defining Page Component Props:

In Next.js, you can define the props for your page components using TypeScript interfaces or types. This ensures that your components receive the expected props with the correct types.

typescript
Copy code
import { GetStaticProps } from 'next';

interface PageProps {
  title: string;
  content: string;
}

const Page: React.FC<PageProps> = ({ title, content }) => (
  <div>
    <h1>{title}</h1>
    <p>{content}</p>
  </div>
);

export default Page;
Using getStaticProps with TypeScript:

When fetching data at build time using getStaticProps, you can define the return type to ensure type safety.

typescript
Copy code
export const getStaticProps: GetStaticProps<PageProps> = async () => {
  // Fetch your data here
  const data = {
    title: 'My Page Title',
    content: 'This is the page content.',
  };

  return {
    props: data,
  };
};
This setup ensures that the props returned by getStaticProps match the PageProps interface, providing type safety throughout your component.

Using getServerSideProps with TypeScript:

Similarly, when fetching data on each request using getServerSideProps, you can define the return type for type safety.

typescript
Copy code
import { GetServerSideProps } from 'next';

export const getServerSideProps: GetServerSideProps<PageProps> = async () => {
  // Fetch your data here
  const data = {
    title: 'My Page Title',
    content: 'This is the page content.',
  };

  return {
    props: data,
  };
};
This ensures that the props returned by getServerSideProps conform to the PageProps interface.

For more detailed information, refer to the Next.js documentation on Data Fetching and TypeScript.

By following these practices, you can ensure that your Next.js pages are strongly typed, leading to more robust and maintainable code.


Sources






To effectively utilize page props in Next.js with TypeScript, it's essential to understand how to define and type your page components and data fetching functions. Here's a concise guide to help you:

Defining Page Component Props:

In Next.js, you can define the props for your page components using TypeScript interfaces or types. This ensures that your components receive the expected props with the correct types.

typescript
Copy code
import { GetStaticProps } from 'next';

interface PageProps {
  title: string;
  content: string;
}

const Page: React.FC<PageProps> = ({ title, content }) => (
  <div>
    <h1>{title}</h1>
    <p>{content}</p>
  </div>
);

export default Page;
Using getStaticProps with TypeScript:

When fetching data at build time using getStaticProps, you can define the return type to ensure type safety.

typescript
Copy code
export const getStaticProps: GetStaticProps<PageProps> = async () => {
  // Fetch your data here
  const data = {
    title: 'My Page Title',
    content: 'This is the page content.',
  };

  return {
    props: data,
  };
};
This setup ensures that the props returned by getStaticProps match the PageProps interface, providing type safety throughout your component.

Using getServerSideProps with TypeScript:

Similarly, when fetching data on each request using getServerSideProps, you can define the return type for type safety.

typescript
Copy code
import { GetServerSideProps } from 'next';

export const getServerSideProps: GetServerSideProps<PageProps> = async () => {
  // Fetch your data here
  const data = {
    title: 'My Page Title',
    content: 'This is the page content.',
  };

  return {
    props: data,
  };
};
This ensures that the props returned by getServerSideProps conform to the PageProps interface.

For more detailed information, refer to the Next.js documentation on Data Fetching and TypeScript.

By following these practices, you can ensure that your Next.js pages are strongly typed, leading to more robust and maintainable code.


Sources













To effectively utilize page props in Next.js with TypeScript, it's essential to understand how to define and type your page components and data fetching functions. Here's a concise guide to help you:

Defining Page Component Props:

In Next.js, you can define the props for your page components using TypeScript interfaces or types. This ensures that your components receive the expected props with the correct types.

typescript
Copy code
import { GetStaticProps } from 'next';

interface PageProps {
  title: string;
  content: string;
}

const Page: React.FC<PageProps> = ({ title, content }) => (
  <div>
    <h1>{title}</h1>
    <p>{content}</p>
  </div>
);

export default Page;
Using getStaticProps with TypeScript:

When fetching data at build time using getStaticProps, you can define the return type to ensure type safety.

typescript
Copy code
export const getStaticProps: GetStaticProps<PageProps> = async () => {
  // Fetch your data here
  const data = {
    title: 'My Page Title',
    content: 'This is the page content.',
  };

  return {
    props: data,
  };
};
This setup ensures that the props returned by getStaticProps match the PageProps interface, providing type safety throughout your component.

Using getServerSideProps with TypeScript:

Similarly, when fetching data on each request using getServerSideProps, you can define the return type for type safety.

typescript
Copy code
import { GetServerSideProps } from 'next';

export const getServerSideProps: GetServerSideProps<PageProps> = async () => {
  // Fetch your data here
  const data = {
    title: 'My Page Title',
    content: 'This is the page content.',
  };

  return {
    props: data,
  };
};
This ensures that the props returned by getServerSideProps conform to the PageProps interface.

For more detailed information, refer to the Next.js documentation on Data Fetching and TypeScript.

By following these practices, you can ensure that your Next.js pages are strongly typed, leading to more robust and maintainable code.

API Reference
Configuration
TypeScript
TypeScript
Next.js comes with built-in TypeScript, automatically installing the necessary packages and configuring the proper settings when you create a new project with create-next-app.

To add TypeScript to an existing project, rename a file to .ts / .tsx. Run next dev and next build to automatically install the necessary dependencies and add a tsconfig.json file with the recommended config options.

Good to know: If you already have a jsconfig.json file, copy the paths compiler option from the old jsconfig.json into the new tsconfig.json file, and delete the old jsconfig.json file.

Examples
Type checking next.config.ts
You can use TypeScript and import types in your Next.js configuration by using next.config.ts.

next.config.ts

import type { NextConfig } from 'next'
 
const nextConfig: NextConfig = {
  /* config options here */
}
 
export default nextConfig
Good to know: Module resolution in next.config.ts is currently limited to CommonJS. This may cause incompatibilities with ESM only packages being loaded in next.config.ts.

When using the next.config.js file, you can add some type checking in your IDE using JSDoc as below:

next.config.js

// @ts-check
 
/** @type {import('next').NextConfig} */
const nextConfig = {
  /* config options here */
}
 
module.exports = nextConfig
Static Generation and Server-side Rendering
For getStaticProps, getStaticPaths, and getServerSideProps, you can use the GetStaticProps, GetStaticPaths, and GetServerSideProps types respectively:

pages/blog/[slug].tsx

import type { GetStaticProps, GetStaticPaths, GetServerSideProps } from 'next'
 
export const getStaticProps = (async (context) => {
  // ...
}) satisfies GetStaticProps
 
export const getStaticPaths = (async () => {
  // ...
}) satisfies GetStaticPaths
 
export const getServerSideProps = (async (context) => {
  // ...
}) satisfies GetServerSideProps
Good to know: satisfies was added to TypeScript in 4.9. We recommend upgrading to the latest version of TypeScript.

With API Routes
The following is an example of how to use the built-in types for API routes:

pages/api/hello.ts

import type { NextApiRequest, NextApiResponse } from 'next'
 
export default function handler(req: NextApiRequest, res: NextApiResponse) {
  res.status(200).json({ name: 'John Doe' })
}
You can also type the response data:

pages/api/hello.ts

import type { NextApiRequest, NextApiResponse } from 'next'
 
type Data = {
  name: string
}
 
export default function handler(
  req: NextApiRequest,
  res: NextApiResponse<Data>
) {
  res.status(200).json({ name: 'John Doe' })
}
With custom App
If you have a custom App, you can use the built-in type AppProps and change file name to ./pages/_app.tsx like so:


import type { AppProps } from 'next/app'
 
export default function MyApp({ Component, pageProps }: AppProps) {
  return <Component {...pageProps} />
}
Incremental type checking
Since v10.2.1 Next.js supports incremental type checking when enabled in your tsconfig.json, this can help speed up type checking in larger applications.

Disabling TypeScript errors in production
Next.js fails your production build (next build) when TypeScript errors are present in your project.

If you'd like Next.js to dangerously produce production code even when your application has errors, you can disable the built-in type checking step.

If disabled, be sure you are running type checks as part of your build or deploy process, otherwise this can be very dangerous.

Open next.config.ts and enable the ignoreBuildErrors option in the typescript config:

next.config.ts

import type { NextConfig } from 'next'
 
const nextConfig: NextConfig = {
  typescript: {
    // !! WARN !!
    // Dangerously allow production builds to successfully complete even if
    // your project has type errors.
    // !! WARN !!
    ignoreBuildErrors: true,
  },
}
 
export default nextConfig
Good to know: You can run tsc --noEmit to check for TypeScript errors yourself before building. This is useful for CI/CD pipelines where you'd like to check for TypeScript errors before deploying.

Custom type declarations
When you need to declare custom types, you might be tempted to modify next-env.d.ts. However, this file is automatically generated, so any changes you make will be overwritten. Instead, you should create a new file, let's call it new-types.d.ts, and reference it in your tsconfig.json:

tsconfig.json

{
  "compilerOptions": {
    "skipLibCheck": true
    //...truncated...
  },
  "include": [
    "new-types.d.ts",
    "next-env.d.ts",
    ".next/types/**/*.ts",
    "**/*.ts",
    "**/*.tsx"
  ],
  "exclude": ["node_modules"]
}
Version Changes
Version	Changes
v15.0.0	next.config.ts support added for TypeScript projects.
v13.2.0	Statically typed links are available in beta.
v12.0.0	SWC is now used by default to compile TypeScript and TSX for faster builds.
v10.2.1	Incremental type checking support added when enabled in your tsconfig.json.
ESLint
Next.js provides an ESLint plugin, eslint-plugin-next, already bundled within the base configuration that makes it possible to catch common issues and problems in a Next.js application.

Reference
Recommended rule-sets from the following ESLint plugins are all used within eslint-config-next:

eslint-plugin-react
eslint-plugin-react-hooks
eslint-plugin-next
This will take precedence over the configuration from next.config.js.

Rules
The full set of rules is as follows:

Enabled in recommended config	Rule	Description
@next/next/google-font-display	Enforce font-display behavior with Google Fonts.
@next/next/google-font-preconnect	Ensure preconnect is used with Google Fonts.
@next/next/inline-script-id	Enforce id attribute on next/script components with inline content.
@next/next/next-script-for-ga	Prefer next/script component when using the inline script for Google Analytics.
@next/next/no-assign-module-variable	Prevent assignment to the module variable.
@next/next/no-async-client-component	Prevent client components from being async functions.
@next/next/no-before-interactive-script-outside-document	Prevent usage of next/script's beforeInteractive strategy outside of pages/_document.js.
@next/next/no-css-tags	Prevent manual stylesheet tags.
@next/next/no-document-import-in-page	Prevent importing next/document outside of pages/_document.js.
@next/next/no-duplicate-head	Prevent duplicate usage of <Head> in pages/_document.js.
@next/next/no-head-element	Prevent usage of <head> element.
@next/next/no-head-import-in-document	Prevent usage of next/head in pages/_document.js.
@next/next/no-html-link-for-pages	Prevent usage of <a> elements to navigate to internal Next.js pages.
@next/next/no-img-element	Prevent usage of <img> element due to slower LCP and higher bandwidth.
@next/next/no-page-custom-font	Prevent page-only custom fonts.
@next/next/no-script-component-in-head	Prevent usage of next/script in next/head component.
@next/next/no-styled-jsx-in-document	Prevent usage of styled-jsx in pages/_document.js.
@next/next/no-sync-scripts	Prevent synchronous scripts.
@next/next/no-title-in-document-head	Prevent usage of <title> with Head component from next/document.
@next/next/no-typos	Prevent common typos in Next.js's data fetching functions
@next/next/no-unwanted-polyfillio	Prevent duplicate polyfills from Polyfill.io.
We recommend using an appropriate integration to view warnings and errors directly in your code editor during development.

Examples
Linting custom directories and files
By default, Next.js will run ESLint for all files in the pages/, app/, components/, lib/, and src/ directories. However, you can specify which directories using the dirs option in the eslint config in next.config.js for production builds:

next.config.js

module.exports = {
  eslint: {
    dirs: ['pages', 'utils'], // Only run ESLint on the 'pages' and 'utils' directories during production builds (next build)
  },
}
Similarly, the --dir and --file flags can be used for next lint to lint specific directories and files:

Terminal

next lint --dir pages --dir utils --file bar.js
Specifying a root directory within a monorepo
If you're using eslint-plugin-next in a project where Next.js isn't installed in your root directory (such as a monorepo), you can tell eslint-plugin-next where to find your Next.js application using the settings property in your .eslintrc:

eslint.config.mjs

import { FlatCompat } from '@eslint/eslintrc'
const compat = new FlatCompat({
  // import.meta.dirname is available after Node.js v20.11.0
  baseDirectory: import.meta.dirname,
})
const eslintConfig = [
  ...compat.config({
    extends: ['next'],
    settings: {
      next: {
        rootDir: 'packages/my-app/',
      },
    },
  }),
]
export default eslintConfig
rootDir can be a path (relative or absolute), a glob (i.e. "packages/*/"), or an array of paths and/or globs.

Disabling the cache
To improve performance, information of files processed by ESLint are cached by default. This is stored in .next/cache or in your defined build directory. If you include any ESLint rules that depend on more than the contents of a single source file and need to disable the cache, use the --no-cache flag with next lint.

Terminal

next lint --no-cache
Disabling rules
If you would like to modify or disable any rules provided by the supported plugins (react, react-hooks, next), you can directly change them using the rules property in your .eslintrc:

eslint.config.mjs

import { FlatCompat } from '@eslint/eslintrc'
const compat = new FlatCompat({
  // import.meta.dirname is available after Node.js v20.11.0
  baseDirectory: import.meta.dirname,
})
const eslintConfig = [
  ...compat.config({
    extends: ['next'],
    rules: {
      'react/no-unescaped-entities': 'off',
      '@next/next/no-page-custom-font': 'off',
    },
  }),
]
export default eslintConfig
With Core Web Vitals
The next/core-web-vitals rule set is enabled when next lint is run for the first time and the strict option is selected.

eslint.config.mjs

import { FlatCompat } from '@eslint/eslintrc'
const compat = new FlatCompat({
  // import.meta.dirname is available after Node.js v20.11.0
  baseDirectory: import.meta.dirname,
})
const eslintConfig = [
  ...compat.config({
    extends: ['next/core-web-vitals'],
  }),
]
export default eslintConfig
next/core-web-vitals updates eslint-plugin-next to error on a number of rules that are warnings by default if they affect Core Web Vitals.

The next/core-web-vitals entry point is automatically included for new applications built with Create Next App.

With TypeScript
In addition to the Next.js ESLint rules, create-next-app --typescript will also add TypeScript-specific lint rules with next/typescript to your config:

eslint.config.mjs

import { FlatCompat } from '@eslint/eslintrc'
const compat = new FlatCompat({
  // import.meta.dirname is available after Node.js v20.11.0
  baseDirectory: import.meta.dirname,
})
const eslintConfig = [
  ...compat.config({
    extends: ['next/core-web-vitals', 'next/typescript'],
  }),
]
export default eslintConfig
Those rules are based on plugin:@typescript-eslint/recommended. See typescript-eslint > Configs for more details.

With Prettier
ESLint also contains code formatting rules, which can conflict with your existing Prettier setup. We recommend including eslint-config-prettier in your ESLint config to make ESLint and Prettier work together.

First, install the dependency:

Terminal

npm install --save-dev eslint-config-prettier
 
yarn add --dev eslint-config-prettier
 
pnpm add --save-dev eslint-config-prettier
 
bun add --dev eslint-config-prettier
Then, add prettier to your existing ESLint config:

eslint.config.mjs

import { FlatCompat } from '@eslint/eslintrc'
const compat = new FlatCompat({
  // import.meta.dirname is available after Node.js v20.11.0
  baseDirectory: import.meta.dirname,
})
const eslintConfig = [
  ...compat.config({
    extends: ['next', 'prettier'],
  }),
]
export default eslintConfig
Running lint on staged files
If you would like to use next lint with lint-staged to run the linter on staged git files, you'll have to add the following to the .lintstagedrc.js file in the root of your project in order to specify usage of the --file flag.

.lintstagedrc.js

const path = require('path')
 
const buildEslintCommand = (filenames) =>
  `next lint --fix --file ${filenames
    .map((f) => path.relative(process.cwd(), f))
    .join(' --file ')}`
 
module.exports = {
  '*.{js,jsx,ts,tsx}': [buildEslintCommand],
}
Disabling linting during production builds
If you do not want ESLint to run during next build, you can set the eslint.ignoreDuringBuilds option in next.config.js to true:

next.config.ts
TypeScript

TypeScript

import type { NextConfig } from 'next'
 
const nextConfig: NextConfig = {
  eslint: {
    // Warning: This allows production builds to successfully complete even if
    // your project has ESLint errors.
    ignoreDuringBuilds: true,
  },
}
 
export default nextConfig
Migrating existing config
If you already have ESLint configured in your application, we recommend extending from this plugin directly instead of including eslint-config-next unless a few conditions are met.

Recommended plugin ruleset
If the following conditions are true:

You have one or more of the following plugins already installed (either separately or through a different config such as airbnb or react-app):
react
react-hooks
jsx-a11y
import
You've defined specific parserOptions that are different from how Babel is configured within Next.js (this is not recommended unless you have customized your Babel configuration)
You have eslint-plugin-import installed with Node.js and/or TypeScript resolvers defined to handle imports
Then we recommend either removing these settings if you prefer how these properties have been configured within eslint-config-next or extending directly from the Next.js ESLint plugin instead:


module.exports = {
  extends: [
    //...
    'plugin:@next/next/recommended',
  ],
}
The plugin can be installed normally in your project without needing to run next lint:

Terminal

npm install --save-dev @next/eslint-plugin-next
 
yarn add --dev @next/eslint-plugin-next
 
pnpm add --save-dev @next/eslint-plugin-next
 
bun add --dev @next/eslint-plugin-next
This eliminates the risk of collisions or errors that can occur due to importing the same plugin or parser across multiple configurations.

Additional configurations
If you already use a separate ESLint configuration and want to include eslint-config-next, ensure that it is extended last after other configurations. For example:

eslint.config.mjs

import js from '@eslint/js'
import { FlatCompat } from '@eslint/eslintrc'
const compat = new FlatCompat({
  // import.meta.dirname is available after Node.js v20.11.0
  baseDirectory: import.meta.dirname,
  recommendedConfig: js.configs.recommended,
})
const eslintConfig = [
  ...compat.config({
    extends: ['eslint:recommended', 'next'],
  }),
]
export default eslintConfig
The next configuration already handles setting default values for the parser, plugins and settings properties. There is no need to manually re-declare any of these properties unless you need a different configuration for your use case.

If you include any other shareable configurations, you will need to make sure that these properties are not overwritten or modified. Otherwise, we recommend removing any configurations that share behavior with the next configuration or extending directly from the Next.js ESLint plugin as mentioned above.

CLI
Next.js comes with two Command Line Interface (CLI) tools:

create-next-app: Quickly create a new Next.js application using the default template or an example from a public GitHub repository.
next: Run the Next.js development server, build your application, and more.
next CLI
The Next.js CLI allows you to develop, build, start your application, and more.

Basic usage:

Terminal

npx next [command] [options]
Reference
The following options are available:

Options	Description
-h or --help	Shows all available options
-v or --version	Outputs the Next.js version number
Commands
The following commands are available:

Command	Description
dev	Starts Next.js in development mode with Hot Module Reloading, error reporting, and more.
build	Creates an optimized production build of your application. Displaying information about each route.
start	Starts Next.js in production mode. The application should be compiled with next build first.
info	Prints relevant details about the current system which can be used to report Next.js bugs.
lint	Runs ESLint for all files in the /src, /app, /pages, /components, and /lib directories. It also provides a guided setup to install any required dependencies if ESLint it is not already configured in your application.
telemetry	Allows you to enable or disable Next.js' completely anonymous telemetry collection.
Good to know: Running next without a command is an alias for next dev.

next dev options
next dev starts the application in development mode with Hot Module Reloading (HMR), error reporting, and more. The following options are available when running next dev:

Option	Description
-h, --help	Show all available options.
[directory]	A directory in which to build the application. If not provided, current directory is used.
--turbopack	Starts development mode using Turbopack.
-p or --port <port>	Specify a port number on which to start the application. Default: 3000, env: PORT
-Hor --hostname <hostname>	Specify a hostname on which to start the application. Useful for making the application available for other devices on the network. Default: 0.0.0.0
--experimental-https	Starts the server with HTTPS and generates a self-signed certificate.
--experimental-https-key <path>	Path to a HTTPS key file.
--experimental-https-cert <path>	Path to a HTTPS certificate file.
--experimental-https-ca <path>	Path to a HTTPS certificate authority file.
--experimental-upload-trace <traceUrl>	Reports a subset of the debugging trace to a remote HTTP URL.
next build options
next build creates an optimized production build of your application. The output displays information about each route. For example:

Terminal

Route (app)                              Size     First Load JS
┌ ○ /_not-found                          0 B               0 kB
└ ƒ /products/[id]                       0 B               0 kB
 
○  (Static)   prerendered as static content
ƒ  (Dynamic)  server-rendered on demand
Size: The size of assets downloaded when navigating to the page client-side. The size for each route only includes its dependencies.
First Load JS: The size of assets downloaded when visiting the page from the server. The amount of JS shared by all is shown as a separate metric.
Both of these values are compressed with gzip. The first load is indicated by green, yellow, or red. Aim for green for performant applications.

The following options are available for the next build command:

Option	Description
-h, --help	Show all available options.
[directory]	A directory on which to build the application. If not provided, the current directory will be used.
-d or --debug	Enables a more verbose build output. With this flag enabled additional build output like rewrites, redirects, and headers will be shown.
--profile	Enables production profiling for React.
--no-lint	Disables linting.
--no-mangling	Disables mangling. This may affect performance and should only be used for debugging purposes.
--experimental-app-only	Builds only App Router routes.
--experimental-build-mode [mode]	Uses an experimental build mode. (choices: "compile", "generate", default: "default")
next start options
next start starts the application in production mode. The application should be compiled with next build first.

The following options are available for the next start command:

Option	Description
-h or --help	Show all available options.
[directory]	A directory on which to start the application. If no directory is provided, the current directory will be used.
-p or --port <port>	Specify a port number on which to start the application. (default: 3000, env: PORT)
-H or --hostname <hostname>	Specify a hostname on which to start the application (default: 0.0.0.0).
--keepAliveTimeout <keepAliveTimeout>	Specify the maximum amount of milliseconds to wait before closing the inactive connections.
next info options
next info prints relevant details about the current system which can be used to report Next.js bugs when opening a GitHub issue. This information includes Operating System platform/arch/version, Binaries (Node.js, npm, Yarn, pnpm), package versions (next, react, react-dom), and more.

The output should look like this:

Terminal

Operating System:
  Platform: darwin
  Arch: arm64
  Version: Darwin Kernel Version 23.6.0
  Available memory (MB): 65536
  Available CPU cores: 10
Binaries:
  Node: 20.12.0
  npm: 10.5.0
  Yarn: 1.22.19
  pnpm: 9.6.0
Relevant Packages:
  next: 15.0.0-canary.115 // Latest available version is detected (15.0.0-canary.115).
  eslint-config-next: 14.2.5
  react: 19.0.0-rc
  react-dom: 19.0.0
  typescript: 5.5.4
Next.js Config:
  output: N/A
The following options are available for the next info command:

Option	Description
-h or --help	Show all available options
--verbose	Collects additional information for debugging.
next lint options
next lint runs ESLint for all files in the pages/, app/, components/, lib/, and src/ directories. It also provides a guided setup to install any required dependencies if ESLint is not already configured in your application.

The following options are available for the next lint command:

Option	Description
[directory]	A base directory on which to lint the application. If not provided, the current directory will be used.
-d, --dir, <dirs...>	Include directory, or directories, to run ESLint.
--file, <files...>	Include file, or files, to run ESLint.
--ext, [exts...]	Specify JavaScript file extensions. (default: [".js", ".mjs", ".cjs", ".jsx", ".ts", ".mts", ".cts", ".tsx"])
-c, --config, <config>	Uses this configuration file, overriding all other configuration options.
--resolve-plugins-relative-to, <rprt>	Specify a directory where plugins should be resolved from.
--strict	Creates a .eslintrc.json file using the Next.js strict configuration.
--rulesdir, <rulesdir...>	Uses additional rules from this directory(s).
--fix	Automatically fix linting issues.
--fix-type <fixType>	Specify the types of fixes to apply (e.g., problem, suggestion, layout).
--ignore-path <path>	Specify a file to ignore.
--no-ignore <path>	Disables the --ignore-path option.
--quiet	Reports errors only.
--max-warnings [maxWarnings]	Specify the number of warnings before triggering a non-zero exit code. (default: -1)
-o, --output-file, <outputFile>	Specify a file to write report to.
-f, --format, <format>	Uses a specific output format.
--no-inline-config	Prevents comments from changing config or rules.
--report-unused-disable-directives-severity <level>	Specify severity level for unused eslint-disable directives. (choices: "error", "off", "warn")
--no-cache	Disables caching.
--cache-location, <cacheLocation>	Specify a location for cache.
--cache-strategy, [cacheStrategy]	Specify a strategy to use for detecting changed files in the cache. (default: "metadata")
--error-on-unmatched-pattern	Reports errors when any file patterns are unmatched.
-h, --help	Displays this message.
next telemetry options
Next.js collects completely anonymous telemetry data about general usage. Participation in this anonymous program is optional, and you can opt-out if you prefer not to share information.

The following options are available for the next telemetry command:

Option	Description
-h, --help	Show all available options.
--enable	Enables Next.js' telemetry collection.
--disable	Disables Next.js' telemetry collection.
Learn more about Telemetry.

Examples
Changing the default port
By default, Next.js uses http://localhost:3000 during development and with next start. The default port can be changed with the -p option, like so:

Terminal

next dev -p 4000
Or using the PORT environment variable:

Terminal

PORT=4000 next dev
Good to know: PORT cannot be set in .env as booting up the HTTP server happens before any other code is initialized.

Using HTTPS during development
For certain use cases like webhooks or authentication, you can use HTTPS to have a secure environment on localhost. Next.js can generate a self-signed certificate with next dev using the --experimental-https flag:

Terminal

next dev --experimental-https
With the generated certificate, the Next.js development server will exist at https://localhost:3000. The default port 3000 is used unless a port is specified with -p, --port, or PORT.

You can also provide a custom certificate and key with --experimental-https-key and --experimental-https-cert. Optionally, you can provide a custom CA certificate with --experimental-https-ca as well.

Terminal

next dev --experimental-https --experimental-https-key ./certificates/localhost-key.pem --experimental-https-cert ./certificates/localhost.pem
next dev --experimental-https is only intended for development and creates a locally trusted certificate with mkcert. In production, use properly issued certificates from trusted authorities.

Good to know: When deploying to Vercel, HTTPS is automatically configured for your Next.js application.

Configuring a timeout for downstream proxies
When deploying Next.js behind a downstream proxy (e.g. a load-balancer like AWS ELB/ALB), it's important to configure Next's underlying HTTP server with keep-alive timeouts that are larger than the downstream proxy's timeouts. Otherwise, once a keep-alive timeout is reached for a given TCP connection, Node.js will immediately terminate that connection without notifying the downstream proxy. This results in a proxy error whenever it attempts to reuse a connection that Node.js has already terminated.

To configure the timeout values for the production Next.js server, pass --keepAliveTimeout (in milliseconds) to next start, like so:

Terminal

next start --keepAliveTimeout 70000
Passing Node.js arguments
You can pass any node arguments to next commands. For example:

Terminal

NODE_OPTIONS='--throw-deprecation' next
NODE_OPTIONS='-r esm' next
NODE_OPTIONS='--inspect' next
Edge Runtime
The Next.js Edge Runtime is used for Middleware and supports the following APIs:

Network APIs
API	Description
Blob	Represents a blob
fetch	Fetches a resource
FetchEvent	Represents a fetch event
File	Represents a file
FormData	Represents form data
Headers	Represents HTTP headers
Request	Represents an HTTP request
Response	Represents an HTTP response
URLSearchParams	Represents URL search parameters
WebSocket	Represents a websocket connection
Encoding APIs
API	Description
atob	Decodes a base-64 encoded string
btoa	Encodes a string in base-64
TextDecoder	Decodes a Uint8Array into a string
TextDecoderStream	Chainable decoder for streams
TextEncoder	Encodes a string into a Uint8Array
TextEncoderStream	Chainable encoder for streams
Stream APIs
API	Description
ReadableStream	Represents a readable stream
ReadableStreamBYOBReader	Represents a reader of a ReadableStream
ReadableStreamDefaultReader	Represents a reader of a ReadableStream
TransformStream	Represents a transform stream
WritableStream	Represents a writable stream
WritableStreamDefaultWriter	Represents a writer of a WritableStream
Crypto APIs
API	Description
crypto	Provides access to the cryptographic functionality of the platform
CryptoKey	Represents a cryptographic key
SubtleCrypto	Provides access to common cryptographic primitives, like hashing, signing, encryption or decryption
Web Standard APIs
API	Description
AbortController	Allows you to abort one or more DOM requests as and when desired
Array	Represents an array of values
ArrayBuffer	Represents a generic, fixed-length raw binary data buffer
Atomics	Provides atomic operations as static methods
BigInt	Represents a whole number with arbitrary precision
BigInt64Array	Represents a typed array of 64-bit signed integers
BigUint64Array	Represents a typed array of 64-bit unsigned integers
Boolean	Represents a logical entity and can have two values: true and false
clearInterval	Cancels a timed, repeating action which was previously established by a call to setInterval()
clearTimeout	Cancels a timed, repeating action which was previously established by a call to setTimeout()
console	Provides access to the browser's debugging console
DataView	Represents a generic view of an ArrayBuffer
Date	Represents a single moment in time in a platform-independent format
decodeURI	Decodes a Uniform Resource Identifier (URI) previously created by encodeURI or by a similar routine
decodeURIComponent	Decodes a Uniform Resource Identifier (URI) component previously created by encodeURIComponent or by a similar routine
DOMException	Represents an error that occurs in the DOM
encodeURI	Encodes a Uniform Resource Identifier (URI) by replacing each instance of certain characters by one, two, three, or four escape sequences representing the UTF-8 encoding of the character
encodeURIComponent	Encodes a Uniform Resource Identifier (URI) component by replacing each instance of certain characters by one, two, three, or four escape sequences representing the UTF-8 encoding of the character
Error	Represents an error when trying to execute a statement or accessing a property
EvalError	Represents an error that occurs regarding the global function eval()
Float32Array	Represents a typed array of 32-bit floating point numbers
Float64Array	Represents a typed array of 64-bit floating point numbers
Function	Represents a function
Infinity	Represents the mathematical Infinity value
Int8Array	Represents a typed array of 8-bit signed integers
Int16Array	Represents a typed array of 16-bit signed integers
Int32Array	Represents a typed array of 32-bit signed integers
Intl	Provides access to internationalization and localization functionality
isFinite	Determines whether a value is a finite number
isNaN	Determines whether a value is NaN or not
JSON	Provides functionality to convert JavaScript values to and from the JSON format
Map	Represents a collection of values, where each value may occur only once
Math	Provides access to mathematical functions and constants
Number	Represents a numeric value
Object	Represents the object that is the base of all JavaScript objects
parseFloat	Parses a string argument and returns a floating point number
parseInt	Parses a string argument and returns an integer of the specified radix
Promise	Represents the eventual completion (or failure) of an asynchronous operation, and its resulting value
Proxy	Represents an object that is used to define custom behavior for fundamental operations (e.g. property lookup, assignment, enumeration, function invocation, etc)
queueMicrotask	Queues a microtask to be executed
RangeError	Represents an error when a value is not in the set or range of allowed values
ReferenceError	Represents an error when a non-existent variable is referenced
Reflect	Provides methods for interceptable JavaScript operations
RegExp	Represents a regular expression, allowing you to match combinations of characters
Set	Represents a collection of values, where each value may occur only once
setInterval	Repeatedly calls a function, with a fixed time delay between each call
setTimeout	Calls a function or evaluates an expression after a specified number of milliseconds
SharedArrayBuffer	Represents a generic, fixed-length raw binary data buffer
String	Represents a sequence of characters
structuredClone	Creates a deep copy of a value
Symbol	Represents a unique and immutable data type that is used as the key of an object property
SyntaxError	Represents an error when trying to interpret syntactically invalid code
TypeError	Represents an error when a value is not of the expected type
Uint8Array	Represents a typed array of 8-bit unsigned integers
Uint8ClampedArray	Represents a typed array of 8-bit unsigned integers clamped to 0-255
Uint32Array	Represents a typed array of 32-bit unsigned integers
URIError	Represents an error when a global URI handling function was used in a wrong way
URL	Represents an object providing static methods used for creating object URLs
URLPattern	Represents a URL pattern
URLSearchParams	Represents a collection of key/value pairs
WeakMap	Represents a collection of key/value pairs in which the keys are weakly referenced
WeakSet	Represents a collection of objects in which each object may occur only once
WebAssembly	Provides access to WebAssembly
Next.js Specific Polyfills
AsyncLocalStorage
Environment Variables
You can use process.env to access Environment Variables for both next dev and next build.

Unsupported APIs
The Edge Runtime has some restrictions including:

Native Node.js APIs are not supported. For example, you can't read or write to the filesystem.
node_modules can be used, as long as they implement ES Modules and do not use native Node.js APIs.
Calling require directly is not allowed. Use ES Modules instead.
The following JavaScript language features are disabled, and will not work:

API	Description
eval	Evaluates JavaScript code represented as a string
new Function(evalString)	Creates a new function with the code provided as an argument
WebAssembly.compile	Compiles a WebAssembly module from a buffer source
WebAssembly.instantiate	Compiles and instantiates a WebAssembly module from a buffer source
In rare cases, your code could contain (or import) some dynamic code evaluation statements which can not be reached at runtime and which can not be removed by treeshaking. You can relax the check to allow specific files with your Middleware configuration:

middleware.ts

export const config = {
  unstable_allowDynamic: [
    // allows a single file
    '/lib/utilities.js',
    // use a glob to allow anything in the function-bind 3rd party module
    '**/node_modules/function-bind/**',
  ],
}
unstable_allowDynamic is a glob, or an array of globs, ignoring dynamic code evaluation for specific files. The globs are relative to your application root folder.

Be warned that if these statements are executed on the Edge, they will throw and cause a runtime error.
Turbopack
Turbopack is an incremental bundler optimized for JavaScript and TypeScript, written in Rust, and built into Next.js. Turbopack can be used in Next.js in both the pages and app directories for faster local development.

To enable Turbopack, use the --turbopack flag when running the Next.js development server.

package.json

{
  "scripts": {
    "dev": "next dev --turbopack",
    "build": "next build",
    "start": "next start",
    "lint": "next lint"
  }
}
Reference
Supported features
Turbopack in Next.js requires zero-configuration for most users and can be extended for more advanced use cases. To learn more about the currently supported features for Turbopack, view the API Reference.

Unsupported features
Turbopack currently only supports next dev and does not support next build. We are currently working on support for builds as we move closer towards stability.

These features are currently not supported:

Turbopack leverages Lightning CSS which doesn't support some low usage CSS Modules features
:local and :global as standalone pseudo classes. Only the function variant is supported, for example: :global(a).
The @value rule which has been superseded by CSS variables.
:import and :export ICSS rules.
Invalid CSS comment syntax such as //
CSS comments should be written as /* comment */ per the specification.
Preprocessors such as Sass do support this alternative syntax for comments.
webpack() configuration in next.config.js
Turbopack replaces Webpack, this means that webpack configuration is not supported.
To configure Turbopack, see the documentation.
A subset of Webpack loaders are supported in Turbopack.
Babel (.babelrc)
Turbopack leverages the SWC compiler for all transpilation and optimizations. This means that Babel is not included by default.
If you have a .babelrc file, you might no longer need it because Next.js includes common Babel plugins as SWC transforms that can be enabled. You can read more about this in the compiler documentation.
If you still need to use Babel after verifying your particular use case is not covered, you can leverage Turbopack's support for custom webpack loaders to include babel-loader.
Creating a root layout automatically in App Router.
This behavior is currently not supported since it changes input files, instead, an error will be shown for you to manually add a root layout in the desired location.
@next/font (legacy font support).
@next/font is deprecated in favor of next/font. next/font is fully supported with Turbopack.
Relay transforms
We are planning to implement this in the future.
Blocking .css imports in pages/_document.tsx
Currently with webpack Next.js blocks importing .css files in pages/_document.tsx
We are planning to implement this warning in the future.
experimental.typedRoutes
We are planning to implement this in the future.
experimental.nextScriptWorkers
We are planning to implement this in the future.
experimental.sri.algorithm
We are planning to implement this in the future.
experimental.fallbackNodePolyfills
We are planning to implement this in the future.
experimental.esmExternals
We are currently not planning to support the legacy esmExternals configuration in Next.js with Turbopack.
AMP.
We are currently not planning to support AMP in Next.js with Turbopack.
Yarn PnP
We are currently not planning to support Yarn PnP in Next.js with Turbopack.
experimental.urlImports
We are currently not planning to support experimental.urlImports in Next.js with Turbopack.
:import and :export ICSS rules
We are currently not planning to support :import and :export ICSS rules in Next.js with Turbopack as Lightning CSS the CSS parser Turbopack uses does not support these rules.
unstable_allowDynamic configuration in edge runtime
Examples
Generating Trace Files
Trace files allow the Next.js team to investigate and improve performance metrics and memory usage. To generate a trace file, append NEXT_TURBOPACK_TRACING=1 to the next dev --turbopack command, this will generate a .next/trace-turbopack file.

When reporting issues related to Turbopack performance and memory usage, please include the trace file in your GitHub issue.

Previous
Edge Runtime
Next
Accessibility
The Next.js team is committed to making Next.js accessible to all developers (and their end-users). By adding accessibility features to Next.js by default, we aim to make the Web more inclusive for everyone.

Route Announcements
When transitioning between pages rendered on the server (e.g. using the <a href> tag) screen readers and other assistive technology announce the page title when the page loads so that users understand that the page has changed.

In addition to traditional page navigations, Next.js also supports client-side transitions for improved performance (using next/link). To ensure that client-side transitions are also announced to assistive technology, Next.js includes a route announcer by default.

The Next.js route announcer looks for the page name to announce by first inspecting document.title, then the <h1> element, and finally the URL pathname. For the most accessible user experience, ensure that each page in your application has a unique and descriptive title.

Linting
Next.js provides an integrated ESLint experience out of the box, including custom rules for Next.js. By default, Next.js includes eslint-plugin-jsx-a11y to help catch accessibility issues early, including warning on:

aria-props
aria-proptypes
aria-unsupported-elements
role-has-required-aria-props
role-supports-aria-props
For example, this plugin helps ensure you add alt text to img tags, use correct aria-* attributes, use correct role attributes, and more.

Accessibility Resources
WebAIM WCAG checklist
WCAG 2.2 Guidelines
The A11y Project
Check color contrast ratios between foreground and background elements
Use prefers-reduced-motion when working with animations
Fast Refresh
Fast refresh is a React feature integrated into Next.js that allows you live reload the browser page while maintaining temporary client-side state when you save changes to a file. It's enabled by default in all Next.js applications on 9.4 or newer. With Fast Refresh enabled, most edits should be visible within a second.

How It Works
If you edit a file that only exports React component(s), Fast Refresh will update the code only for that file, and re-render your component. You can edit anything in that file, including styles, rendering logic, event handlers, or effects.
If you edit a file with exports that aren't React components, Fast Refresh will re-run both that file, and the other files importing it. So if both Button.js and Modal.js import theme.js, editing theme.js will update both components.
Finally, if you edit a file that's imported by files outside of the React tree, Fast Refresh will fall back to doing a full reload. You might have a file which renders a React component but also exports a value that is imported by a non-React component. For example, maybe your component also exports a constant, and a non-React utility file imports it. In that case, consider migrating the constant to a separate file and importing it into both files. This will re-enable Fast Refresh to work. Other cases can usually be solved in a similar way.
Error Resilience
Syntax Errors
If you make a syntax error during development, you can fix it and save the file again. The error will disappear automatically, so you won't need to reload the app. You will not lose component state.

Runtime Errors
If you make a mistake that leads to a runtime error inside your component, you'll be greeted with a contextual overlay. Fixing the error will automatically dismiss the overlay, without reloading the app.

Component state will be retained if the error did not occur during rendering. If the error did occur during rendering, React will remount your application using the updated code.

If you have error boundaries in your app (which is a good idea for graceful failures in production), they will retry rendering on the next edit after a rendering error. This means having an error boundary can prevent you from always getting reset to the root app state. However, keep in mind that error boundaries shouldn't be too granular. They are used by React in production, and should always be designed intentionally.

Limitations
Fast Refresh tries to preserve local React state in the component you're editing, but only if it's safe to do so. Here's a few reasons why you might see local state being reset on every edit to a file:

Local state is not preserved for class components (only function components and Hooks preserve state).
The file you're editing might have other exports in addition to a React component.
Sometimes, a file would export the result of calling a higher-order component like HOC(WrappedComponent). If the returned component is a class, its state will be reset.
Anonymous arrow functions like export default () => <div />; cause Fast Refresh to not preserve local component state. For large codebases you can use our name-default-component codemod.
As more of your codebase moves to function components and Hooks, you can expect state to be preserved in more cases.

Tips
Fast Refresh preserves React local state in function components (and Hooks) by default.
Sometimes you might want to force the state to be reset, and a component to be remounted. For example, this can be handy if you're tweaking an animation that only happens on mount. To do this, you can add // @refresh reset anywhere in the file you're editing. This directive is local to the file, and instructs Fast Refresh to remount components defined in that file on every edit.
You can put console.log or debugger; into the components you edit during development.
Remember that imports are case sensitive. Both fast and full refresh can fail, when your import doesn't match the actual filename. For example, './header' vs './Header'.
Fast Refresh and Hooks
When possible, Fast Refresh attempts to preserve the state of your component between edits. In particular, useState and useRef preserve their previous values as long as you don't change their arguments or the order of the Hook calls.

Hooks with dependencies—such as useEffect, useMemo, and useCallback—will always update during Fast Refresh. Their list of dependencies will be ignored while Fast Refresh is happening.

For example, when you edit useMemo(() => x * 2, [x]) to useMemo(() => x * 10, [x]), it will re-run even though x (the dependency) has not changed. If React didn't do that, your edit wouldn't reflect on the screen!

Sometimes, this can lead to unexpected results. For example, even a useEffect with an empty array of dependencies would still re-run once during Fast Refresh.

However, writing code resilient to occasional re-running of useEffect is a good practice even without Fast Refresh. It will make it easier for you to introduce new dependencies to it later on and it's enforced by React Strict Mode, which we highly recommend enabling.
Next.js Compiler
The Next.js Compiler, written in Rust using SWC, allows Next.js to transform and minify your JavaScript code for production. This replaces Babel for individual files and Terser for minifying output bundles.

Compilation using the Next.js Compiler is 17x faster than Babel and enabled by default since Next.js version 12. If you have an existing Babel configuration or are using unsupported features, your application will opt-out of the Next.js Compiler and continue using Babel.

Why SWC?
SWC is an extensible Rust-based platform for the next generation of fast developer tools.

SWC can be used for compilation, minification, bundling, and more – and is designed to be extended. It's something you can call to perform code transformations (either built-in or custom). Running those transformations happens through higher-level tools like Next.js.

We chose to build on SWC for a few reasons:

Extensibility: SWC can be used as a Crate inside Next.js, without having to fork the library or workaround design constraints.
Performance: We were able to achieve ~3x faster Fast Refresh and ~5x faster builds in Next.js by switching to SWC, with more room for optimization still in progress.
WebAssembly: Rust's support for WASM is essential for supporting all possible platforms and taking Next.js development everywhere.
Community: The Rust community and ecosystem are amazing and still growing.
Supported Features
Styled Components
We're working to port babel-plugin-styled-components to the Next.js Compiler.

First, update to the latest version of Next.js: npm install next@latest. Then, update your next.config.js file:

next.config.js

module.exports = {
  compiler: {
    styledComponents: true,
  },
}
For advanced use cases, you can configure individual properties for styled-components compilation.

Note: ssr and displayName transforms are the main requirement for using styled-components in Next.js.

next.config.js

module.exports = {
  compiler: {
    // see https://styled-components.com/docs/tooling#babel-plugin for more info on the options.
    styledComponents: {
      // Enabled by default in development, disabled in production to reduce file size,
      // setting this will override the default for all environments.
      displayName?: boolean,
      // Enabled by default.
      ssr?: boolean,
      // Enabled by default.
      fileName?: boolean,
      // Empty by default.
      topLevelImportPaths?: string[],
      // Defaults to ["index"].
      meaninglessFileNames?: string[],
      // Enabled by default.
      minify?: boolean,
      // Enabled by default.
      transpileTemplateLiterals?: boolean,
      // Empty by default.
      namespace?: string,
      // Disabled by default.
      pure?: boolean,
      // Enabled by default.
      cssProp?: boolean,
    },
  },
}
Jest
The Next.js Compiler transpiles your tests and simplifies configuring Jest together with Next.js including:

Auto mocking of .css, .module.css (and their .scss variants), and image imports
Automatically sets up transform using SWC
Loading .env (and all variants) into process.env
Ignores node_modules from test resolving and transforms
Ignoring .next from test resolving
Loads next.config.js for flags that enable experimental SWC transforms
First, update to the latest version of Next.js: npm install next@latest. Then, update your jest.config.js file:

jest.config.js

const nextJest = require('next/jest')
 
// Providing the path to your Next.js app which will enable loading next.config.js and .env files
const createJestConfig = nextJest({ dir: './' })
 
// Any custom config you want to pass to Jest
const customJestConfig = {
  setupFilesAfterEnv: ['<rootDir>/jest.setup.js'],
}
 
// createJestConfig is exported in this way to ensure that next/jest can load the Next.js configuration, which is async
module.exports = createJestConfig(customJestConfig)
Relay
To enable Relay support:

next.config.js

module.exports = {
  compiler: {
    relay: {
      // This should match relay.config.js
      src: './',
      artifactDirectory: './__generated__',
      language: 'typescript',
      eagerEsModules: false,
    },
  },
}
Good to know: In Next.js, all JavaScript files in pages directory are considered routes. So, for relay-compiler you'll need to specify artifactDirectory configuration settings outside of the pages, otherwise relay-compiler will generate files next to the source file in the __generated__ directory, and this file will be considered a route, which will break production builds.

Remove React Properties
Allows to remove JSX properties. This is often used for testing. Similar to babel-plugin-react-remove-properties.

To remove properties matching the default regex ^data-test:

next.config.js

module.exports = {
  compiler: {
    reactRemoveProperties: true,
  },
}
To remove custom properties:

next.config.js

module.exports = {
  compiler: {
    // The regexes defined here are processed in Rust so the syntax is different from
    // JavaScript `RegExp`s. See https://docs.rs/regex.
    reactRemoveProperties: { properties: ['^data-custom$'] },
  },
}
Remove Console
This transform allows for removing all console.* calls in application code (not node_modules). Similar to babel-plugin-transform-remove-console.

Remove all console.* calls:

next.config.js

module.exports = {
  compiler: {
    removeConsole: true,
  },
}
Remove console.* output except console.error:

next.config.js

module.exports = {
  compiler: {
    removeConsole: {
      exclude: ['error'],
    },
  },
}
Legacy Decorators
Next.js will automatically detect experimentalDecorators in jsconfig.json or tsconfig.json. Legacy decorators are commonly used with older versions of libraries like mobx.

This flag is only supported for compatibility with existing applications. We do not recommend using legacy decorators in new applications.

First, update to the latest version of Next.js: npm install next@latest. Then, update your jsconfig.json or tsconfig.json file:


{
  "compilerOptions": {
    "experimentalDecorators": true
  }
}
importSource
Next.js will automatically detect jsxImportSource in jsconfig.json or tsconfig.json and apply that. This is commonly used with libraries like Theme UI.

First, update to the latest version of Next.js: npm install next@latest. Then, update your jsconfig.json or tsconfig.json file:


{
  "compilerOptions": {
    "jsxImportSource": "theme-ui"
  }
}
Emotion
We're working to port @emotion/babel-plugin to the Next.js Compiler.

First, update to the latest version of Next.js: npm install next@latest. Then, update your next.config.js file:

next.config.js

 
module.exports = {
  compiler: {
    emotion: boolean | {
      // default is true. It will be disabled when build type is production.
      sourceMap?: boolean,
      // default is 'dev-only'.
      autoLabel?: 'never' | 'dev-only' | 'always',
      // default is '[local]'.
      // Allowed values: `[local]` `[filename]` and `[dirname]`
      // This option only works when autoLabel is set to 'dev-only' or 'always'.
      // It allows you to define the format of the resulting label.
      // The format is defined via string where variable parts are enclosed in square brackets [].
      // For example labelFormat: "my-classname--[local]", where [local] will be replaced with the name of the variable the result is assigned to.
      labelFormat?: string,
      // default is undefined.
      // This option allows you to tell the compiler what imports it should
      // look at to determine what it should transform so if you re-export
      // Emotion's exports, you can still use transforms.
      importMap?: {
        [packageName: string]: {
          [exportName: string]: {
            canonicalImport?: [string, string],
            styledBaseImport?: [string, string],
          }
        }
      },
    },
  },
}
Minification
Next.js' swc compiler is used for minification by default since v13. This is 7x faster than Terser.

Good to know: Starting with v15, minification cannot customized using next.config.js. Support for the swcMinify flag has been removed.

Module Transpilation
Next.js can automatically transpile and bundle dependencies from local packages (like monorepos) or from external dependencies (node_modules). This replaces the next-transpile-modules package.

next.config.js

module.exports = {
  transpilePackages: ['@acme/ui', 'lodash-es'],
}
Modularize Imports
This option has been superseded by optimizePackageImports in Next.js 13.5. We recommend upgrading to use the new option that does not require manual configuration of import paths.

Define (Replacing variables during build)
The define option allows you to statically replace variables in your code at build-time. The option takes an object as key-value pairs, where the keys are the variables that should be replaced with the corresponding values.

Use the compiler.define field in next.config.js:

next.config.js

module.exports = {
  compiler: {
    define: {
      MY_STRING_VARIABLE: JSON.stringify('my-string'),
      MY_NUMBER_VARIABLE: '42',
    },
  },
}
Experimental Features
SWC Trace profiling
You can generate SWC's internal transform traces as chromium's trace event format.

next.config.js

module.exports = {
  experimental: {
    swcTraceProfiling: true,
  },
}
Once enabled, swc will generate trace named as swc-trace-profile-${timestamp}.json under .next/. Chromium's trace viewer (chrome://tracing/, https://ui.perfetto.dev/), or compatible flamegraph viewer (https://www.speedscope.app/) can load & visualize generated traces.

SWC Plugins (experimental)
You can configure swc's transform to use SWC's experimental plugin support written in wasm to customize transformation behavior.

next.config.js

module.exports = {
  experimental: {
    swcPlugins: [
      [
        'plugin',
        {
          ...pluginOptions,
        },
      ],
    ],
  },
}
swcPlugins accepts an array of tuples for configuring plugins. A tuple for the plugin contains the path to the plugin and an object for plugin configuration. The path to the plugin can be an npm module package name or an absolute path to the .wasm binary itself.

Unsupported Features
When your application has a .babelrc file, Next.js will automatically fall back to using Babel for transforming individual files. This ensures backwards compatibility with existing applications that leverage custom Babel plugins.

If you're using a custom Babel setup, please share your configuration. We're working to port as many commonly used Babel transformations as possible, as well as supporting plugins in the future.

Version History
Version	Changes
v13.1.0	Module Transpilation and Modularize Imports stable.
v13.0.0	SWC Minifier enabled by default.
v12.3.0	SWC Minifier stable.
v12.2.0	SWC Plugins experimental support added.
v12.1.0	Added support for Styled Components, Jest, Relay, Remove React Properties, Legacy Decorators, Remove Console, and jsxImportSource.
v12.0.0	Next.js Compiler introduced.
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

Next Steps
For more information on what to do next, we recommend the following sections
Linking and Navigating
Learn how navigation works in Next.js, and how to use the Link Component and `useRouter` hook.
generateStaticParams
API reference for the generateStaticParams function.
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

Next Steps
default.js
API Reference for the default.js file.
Intercepting Routes
Intercepting routes allows you to load a route from another part of your application within the current layout. This routing paradigm can be useful when you want to display the content of a route without the user switching to a different context.

For example, when clicking on a photo in a feed, you can display the photo in a modal, overlaying the feed. In this case, Next.js intercepts the /photo/123 route, masks the URL, and overlays it over /feed.

Intercepting routes soft navigation
However, when navigating to the photo by clicking a shareable URL or by refreshing the page, the entire photo page should render instead of the modal. No route interception should occur.

Intercepting routes hard navigation
Convention
Intercepting routes can be defined with the (..) convention, which is similar to relative path convention ../ but for segments.

You can use:

(.) to match segments on the same level
(..) to match segments one level above
(..)(..) to match segments two levels above
(...) to match segments from the root app directory
For example, you can intercept the photo segment from within the feed segment by creating a (..)photo directory.

Intercepting routes folder structure
Note that the (..) convention is based on route segments, not the file-system.

Examples
Modals
Intercepting Routes can be used together with Parallel Routes to create modals. This allows you to solve common challenges when building modals, such as:

Making the modal content shareable through a URL.
Preserving context when the page is refreshed, instead of closing the modal.
Closing the modal on backwards navigation rather than going to the previous route.
Reopening the modal on forwards navigation.
Consider the following UI pattern, where a user can open a photo modal from a gallery using client-side navigation, or navigate to the photo page directly from a shareable URL:

Intercepting routes modal example
In the above example, the path to the photo segment can use the (..) matcher since @modal is a slot and not a segment. This means that the photo route is only one segment level higher, despite being two file-system levels higher.

See the Parallel Routes documentation for a step-by-step example, or see our image gallery example.

Good to know:

Other examples could include opening a login modal in a top navbar while also having a dedicated /login page, or opening a shopping cart in a side modal.
Next Steps
Learn how to use modals with Intercepted and Parallel Routes.
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
See the API reference for more details.

API Reference
Learn more about the route.js file.
route.js
API reference for the route.js special file.
Middleware
Middleware allows you to run code before a request is completed. Then, based on the incoming request, you can modify the response by rewriting, redirecting, modifying the request or response headers, or responding directly.

Middleware runs before cached content and routes are matched. See Matching Paths for more details.

Use Cases
Integrating Middleware into your application can lead to significant improvements in performance, security, and user experience. Some common scenarios where Middleware is particularly effective include:

Authentication and Authorization: Ensure user identity and check session cookies before granting access to specific pages or API routes.
Server-Side Redirects: Redirect users at the server level based on certain conditions (e.g., locale, user role).
Path Rewriting: Support A/B testing, feature rollouts, or legacy paths by dynamically rewriting paths to API routes or pages based on request properties.
Bot Detection: Protect your resources by detecting and blocking bot traffic.
Logging and Analytics: Capture and analyze request data for insights before processing by the page or API.
Feature Flagging: Enable or disable features dynamically for seamless feature rollouts or testing.
Recognizing situations where middleware may not be the optimal approach is just as crucial. Here are some scenarios to be mindful of:

Complex Data Fetching and Manipulation: Middleware is not designed for direct data fetching or manipulation, this should be done within Route Handlers or server-side utilities instead.
Heavy Computational Tasks: Middleware should be lightweight and respond quickly or it can cause delays in page load. Heavy computational tasks or long-running processes should be done within dedicated Route Handlers.
Extensive Session Management: While Middleware can manage basic session tasks, extensive session management should be managed by dedicated authentication services or within Route Handlers.
Direct Database Operations: Performing direct database operations within Middleware is not recommended. Database interactions should be done within Route Handlers or server-side utilities.
Convention
Use the file middleware.ts (or .js) in the root of your project to define Middleware. For example, at the same level as pages or app, or inside src if applicable.

Note: While only one middleware.ts file is supported per project, you can still organize your middleware logic modularly. Break out middleware functionalities into separate .ts or .js files and import them into your main middleware.ts file. This allows for cleaner management of route-specific middleware, aggregated in the middleware.ts for centralized control. By enforcing a single middleware file, it simplifies configuration, prevents potential conflicts, and optimizes performance by avoiding multiple middleware layers.

Example
middleware.ts
TypeScript

TypeScript

import { NextResponse } from 'next/server'
import type { NextRequest } from 'next/server'
 
// This function can be marked `async` if using `await` inside
export function middleware(request: NextRequest) {
  return NextResponse.redirect(new URL('/home', request.url))
}
 
// See "Matching Paths" below to learn more
export const config = {
  matcher: '/about/:path*',
}
Matching Paths
Middleware will be invoked for every route in your project. Given this, it's crucial to use matchers to precisely target or exclude specific routes. The following is the execution order:

headers from next.config.js
redirects from next.config.js
Middleware (rewrites, redirects, etc.)
beforeFiles (rewrites) from next.config.js
Filesystem routes (public/, _next/static/, pages/, app/, etc.)
afterFiles (rewrites) from next.config.js
Dynamic Routes (/blog/[slug])
fallback (rewrites) from next.config.js
There are two ways to define which paths Middleware will run on:

Custom matcher config
Conditional statements
Matcher
matcher allows you to filter Middleware to run on specific paths.

middleware.js

export const config = {
  matcher: '/about/:path*',
}
You can match a single path or multiple paths with an array syntax:

middleware.js

export const config = {
  matcher: ['/about/:path*', '/dashboard/:path*'],
}
The matcher config allows full regex so matching like negative lookaheads or character matching is supported. An example of a negative lookahead to match all except specific paths can be seen here:

middleware.js

export const config = {
  matcher: [
    /*
     * Match all request paths except for the ones starting with:
     * - api (API routes)
     * - _next/static (static files)
     * - _next/image (image optimization files)
     * - favicon.ico, sitemap.xml, robots.txt (metadata files)
     */
    '/((?!api|_next/static|_next/image|favicon.ico|sitemap.xml|robots.txt).*)',
  ],
}
You can also bypass Middleware for certain requests by using the missing or has arrays, or a combination of both:

middleware.js

export const config = {
  matcher: [
    /*
     * Match all request paths except for the ones starting with:
     * - api (API routes)
     * - _next/static (static files)
     * - _next/image (image optimization files)
     * - favicon.ico, sitemap.xml, robots.txt (metadata files)
     */
    {
      source:
        '/((?!api|_next/static|_next/image|favicon.ico|sitemap.xml|robots.txt).*)',
      missing: [
        { type: 'header', key: 'next-router-prefetch' },
        { type: 'header', key: 'purpose', value: 'prefetch' },
      ],
    },
 
    {
      source:
        '/((?!api|_next/static|_next/image|favicon.ico|sitemap.xml|robots.txt).*)',
      has: [
        { type: 'header', key: 'next-router-prefetch' },
        { type: 'header', key: 'purpose', value: 'prefetch' },
      ],
    },
 
    {
      source:
        '/((?!api|_next/static|_next/image|favicon.ico|sitemap.xml|robots.txt).*)',
      has: [{ type: 'header', key: 'x-present' }],
      missing: [{ type: 'header', key: 'x-missing', value: 'prefetch' }],
    },
  ],
}
Good to know: The matcher values need to be constants so they can be statically analyzed at build-time. Dynamic values such as variables will be ignored.

Configured matchers:

MUST start with /
Can include named parameters: /about/:path matches /about/a and /about/b but not /about/a/c
Can have modifiers on named parameters (starting with :): /about/:path* matches /about/a/b/c because * is zero or more. ? is zero or one and + one or more
Can use regular expression enclosed in parenthesis: /about/(.*) is the same as /about/:path*
Read more details on path-to-regexp documentation.

Good to know: For backward compatibility, Next.js always considers /public as /public/index. Therefore, a matcher of /public/:path will match.

Conditional Statements
middleware.ts
TypeScript

TypeScript

import { NextResponse } from 'next/server'
import type { NextRequest } from 'next/server'
 
export function middleware(request: NextRequest) {
  if (request.nextUrl.pathname.startsWith('/about')) {
    return NextResponse.rewrite(new URL('/about-2', request.url))
  }
 
  if (request.nextUrl.pathname.startsWith('/dashboard')) {
    return NextResponse.rewrite(new URL('/dashboard/user', request.url))
  }
}
NextResponse
The NextResponse API allows you to:

redirect the incoming request to a different URL
rewrite the response by displaying a given URL
Set request headers for API Routes, getServerSideProps, and rewrite destinations
Set response cookies
Set response headers
To produce a response from Middleware, you can:

rewrite to a route (Page or Route Handler) that produces a response
return a NextResponse directly. See Producing a Response
Using Cookies
Cookies are regular headers. On a Request, they are stored in the Cookie header. On a Response they are in the Set-Cookie header. Next.js provides a convenient way to access and manipulate these cookies through the cookies extension on NextRequest and NextResponse.

For incoming requests, cookies comes with the following methods: get, getAll, set, and delete cookies. You can check for the existence of a cookie with has or remove all cookies with clear.
For outgoing responses, cookies have the following methods get, getAll, set, and delete.
middleware.ts
TypeScript

TypeScript

import { NextResponse } from 'next/server'
import type { NextRequest } from 'next/server'
 
export function middleware(request: NextRequest) {
  // Assume a "Cookie:nextjs=fast" header to be present on the incoming request
  // Getting cookies from the request using the `RequestCookies` API
  let cookie = request.cookies.get('nextjs')
  console.log(cookie) // => { name: 'nextjs', value: 'fast', Path: '/' }
  const allCookies = request.cookies.getAll()
  console.log(allCookies) // => [{ name: 'nextjs', value: 'fast' }]
 
  request.cookies.has('nextjs') // => true
  request.cookies.delete('nextjs')
  request.cookies.has('nextjs') // => false
 
  // Setting cookies on the response using the `ResponseCookies` API
  const response = NextResponse.next()
  response.cookies.set('vercel', 'fast')
  response.cookies.set({
    name: 'vercel',
    value: 'fast',
    path: '/',
  })
  cookie = response.cookies.get('vercel')
  console.log(cookie) // => { name: 'vercel', value: 'fast', Path: '/' }
  // The outgoing response will have a `Set-Cookie:vercel=fast;path=/` header.
 
  return response
}
Setting Headers
You can set request and response headers using the NextResponse API (setting request headers is available since Next.js v13.0.0).

middleware.ts
TypeScript

TypeScript

import { NextResponse } from 'next/server'
import type { NextRequest } from 'next/server'
 
export function middleware(request: NextRequest) {
  // Clone the request headers and set a new header `x-hello-from-middleware1`
  const requestHeaders = new Headers(request.headers)
  requestHeaders.set('x-hello-from-middleware1', 'hello')
 
  // You can also set request headers in NextResponse.next
  const response = NextResponse.next({
    request: {
      // New request headers
      headers: requestHeaders,
    },
  })
 
  // Set a new response header `x-hello-from-middleware2`
  response.headers.set('x-hello-from-middleware2', 'hello')
  return response
}
Good to know: Avoid setting large headers as it might cause 431 Request Header Fields Too Large error depending on your backend web server configuration.

CORS
You can set CORS headers in Middleware to allow cross-origin requests, including simple and preflighted requests.

middleware.ts
TypeScript

TypeScript

import { NextRequest, NextResponse } from 'next/server'
 
const allowedOrigins = ['https://acme.com', 'https://my-app.org']
 
const corsOptions = {
  'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
  'Access-Control-Allow-Headers': 'Content-Type, Authorization',
}
 
export function middleware(request: NextRequest) {
  // Check the origin from the request
  const origin = request.headers.get('origin') ?? ''
  const isAllowedOrigin = allowedOrigins.includes(origin)
 
  // Handle preflighted requests
  const isPreflight = request.method === 'OPTIONS'
 
  if (isPreflight) {
    const preflightHeaders = {
      ...(isAllowedOrigin && { 'Access-Control-Allow-Origin': origin }),
      ...corsOptions,
    }
    return NextResponse.json({}, { headers: preflightHeaders })
  }
 
  // Handle simple requests
  const response = NextResponse.next()
 
  if (isAllowedOrigin) {
    response.headers.set('Access-Control-Allow-Origin', origin)
  }
 
  Object.entries(corsOptions).forEach(([key, value]) => {
    response.headers.set(key, value)
  })
 
  return response
}
 
export const config = {
  matcher: '/api/:path*',
}
Good to know: You can configure CORS headers for individual routes in Route Handlers.

Producing a Response
You can respond from Middleware directly by returning a Response or NextResponse instance. (This is available since Next.js v13.1.0)

middleware.ts
TypeScript

TypeScript

import type { NextRequest } from 'next/server'
import { isAuthenticated } from '@lib/auth'
 
// Limit the middleware to paths starting with `/api/`
export const config = {
  matcher: '/api/:function*',
}
 
export function middleware(request: NextRequest) {
  // Call our authentication function to check the request
  if (!isAuthenticated(request)) {
    // Respond with JSON indicating an error message
    return Response.json(
      { success: false, message: 'authentication failed' },
      { status: 401 }
    )
  }
}
waitUntil and NextFetchEvent
The NextFetchEvent object extends the native FetchEvent object, and includes the waitUntil() method.

The waitUntil() method takes a promise as an argument, and extends the lifetime of the Middleware until the promise settles. This is useful for performing work in the background.

middleware.ts

import { NextResponse } from 'next/server'
import type { NextFetchEvent, NextRequest } from 'next/server'
 
export function middleware(req: NextRequest, event: NextFetchEvent) {
  event.waitUntil(
    fetch('https://my-analytics-platform.com', {
      method: 'POST',
      body: JSON.stringify({ pathname: req.nextUrl.pathname }),
    })
  )
 
  return NextResponse.next()
}
Advanced Middleware Flags
In v13.1 of Next.js two additional flags were introduced for middleware, skipMiddlewareUrlNormalize and skipTrailingSlashRedirect to handle advanced use cases.

skipTrailingSlashRedirect disables Next.js redirects for adding or removing trailing slashes. This allows custom handling inside middleware to maintain the trailing slash for some paths but not others, which can make incremental migrations easier.

next.config.js

module.exports = {
  skipTrailingSlashRedirect: true,
}
middleware.js

const legacyPrefixes = ['/docs', '/blog']
 
export default async function middleware(req) {
  const { pathname } = req.nextUrl
 
  if (legacyPrefixes.some((prefix) => pathname.startsWith(prefix))) {
    return NextResponse.next()
  }
 
  // apply trailing slash handling
  if (
    !pathname.endsWith('/') &&
    !pathname.match(/((?!\.well-known(?:\/.*)?)(?:[^/]+\/)*[^/]+\.\w+)/)
  ) {
    return NextResponse.redirect(
      new URL(`${req.nextUrl.pathname}/`, req.nextUrl)
    )
  }
}
skipMiddlewareUrlNormalize allows for disabling the URL normalization in Next.js to make handling direct visits and client-transitions the same. In some advanced cases, this option provides full control by using the original URL.

next.config.js

module.exports = {
  skipMiddlewareUrlNormalize: true,
}
middleware.js

export default async function middleware(req) {
  const { pathname } = req.nextUrl
 
  // GET /_next/data/build-id/hello.json
 
  console.log(pathname)
  // with the flag this now /_next/data/build-id/hello.json
  // without the flag this would be normalized to /hello
}
Unit Testing (experimental)
Starting in Next.js 15.1, the next/experimental/testing/server package contains utilities to help unit test middleware files. Unit testing middleware can help ensure that it's only run on desired paths and that custom routing logic works as intended before code reaches production.

The unstable_doesMiddlewareMatch function can be used to assert whether middleware will run for the provided URL, headers, and cookies.


import { unstable_doesMiddlewareMatch } from 'next/experimental/testing/server'
 
expect(
  unstable_doesMiddlewareMatch({
    config,
    nextConfig,
    url: '/test',
  })
).toEqual(false)
The entire middleware function can also be tested.


import { isRewrite, getRewrittenUrl } from 'next/experimental/testing/server'
 
const request = new NextRequest('https://nextjs.org/docs')
const response = await middleware(request)
expect(isRewrite(response)).toEqual(true)
expect(getRewrittenUrl(response)).toEqual('https://other-domain.com/docs')
// getRedirectUrl could also be used if the response were
Internationalization
Next.js enables you to configure the routing and rendering of content to support multiple languages. Making your site adaptive to different locales includes translated content (localization) and internationalized routes.

Terminology
Locale: An identifier for a set of language and formatting preferences. This usually includes the preferred language of the user and possibly their geographic region.
en-US: English as spoken in the United States
nl-NL: Dutch as spoken in the Netherlands
nl: Dutch, no specific region
Routing Overview
It’s recommended to use the user’s language preferences in the browser to select which locale to use. Changing your preferred language will modify the incoming Accept-Language header to your application.

For example, using the following libraries, you can look at an incoming Request to determine which locale to select, based on the Headers, locales you plan to support, and the default locale.

middleware.js

import { match } from '@formatjs/intl-localematcher'
import Negotiator from 'negotiator'
 
let headers = { 'accept-language': 'en-US,en;q=0.5' }
let languages = new Negotiator({ headers }).languages()
let locales = ['en-US', 'nl-NL', 'nl']
let defaultLocale = 'en-US'
 
match(languages, locales, defaultLocale) // -> 'en-US'
Routing can be internationalized by either the sub-path (/fr/products) or domain (my-site.fr/products). With this information, you can now redirect the user based on the locale inside Middleware.

middleware.js

import { NextResponse } from "next/server";
 
let locales = ['en-US', 'nl-NL', 'nl']
 
// Get the preferred locale, similar to the above or using a library
function getLocale(request) { ... }
 
export function middleware(request) {
  // Check if there is any supported locale in the pathname
  const { pathname } = request.nextUrl
  const pathnameHasLocale = locales.some(
    (locale) => pathname.startsWith(`/${locale}/`) || pathname === `/${locale}`
  )
 
  if (pathnameHasLocale) return
 
  // Redirect if there is no locale
  const locale = getLocale(request)
  request.nextUrl.pathname = `/${locale}${pathname}`
  // e.g. incoming request is /products
  // The new URL is now /en-US/products
  return NextResponse.redirect(request.nextUrl)
}
 
export const config = {
  matcher: [
    // Skip all internal paths (_next)
    '/((?!_next).*)',
    // Optional: only run on root (/) URL
    // '/'
  ],
}
Finally, ensure all special files inside app/ are nested under app/[lang]. This enables the Next.js router to dynamically handle different locales in the route, and forward the lang parameter to every layout and page. For example:

app/[lang]/page.tsx
TypeScript

TypeScript

// You now have access to the current locale
// e.g. /en-US/products -> `lang` is "en-US"
export default async function Page({
  params,
}: {
  params: Promise<{ lang: string }>
}) {
  const lang = (await params).lang;
  return ...
}
The root layout can also be nested in the new folder (e.g. app/[lang]/layout.js).

Localization
Changing displayed content based on the user’s preferred locale, or localization, is not something specific to Next.js. The patterns described below would work the same with any web application.

Let’s assume we want to support both English and Dutch content inside our application. We might maintain two different “dictionaries”, which are objects that give us a mapping from some key to a localized string. For example:

dictionaries/en.json

{
  "products": {
    "cart": "Add to Cart"
  }
}
dictionaries/nl.json

{
  "products": {
    "cart": "Toevoegen aan Winkelwagen"
  }
}
We can then create a getDictionary function to load the translations for the requested locale:

app/[lang]/dictionaries.ts
TypeScript

TypeScript

import 'server-only'
 
const dictionaries = {
  en: () => import('./dictionaries/en.json').then((module) => module.default),
  nl: () => import('./dictionaries/nl.json').then((module) => module.default),
}
 
export const getDictionary = async (locale: 'en' | 'nl') =>
  dictionaries[locale]()
Given the currently selected language, we can fetch the dictionary inside of a layout or page.

app/[lang]/page.tsx
TypeScript

TypeScript

import { getDictionary } from './dictionaries'
 
export default async function Page({
  params,
}: {
  params: Promise<{ lang: 'en' | 'nl' }>
}) {
  const lang = (await params).lang
  const dict = await getDictionary(lang) // en
  return <button>{dict.products.cart}</button> // Add to Cart
}
Because all layouts and pages in the app/ directory default to Server Components, we do not need to worry about the size of the translation files affecting our client-side JavaScript bundle size. This code will only run on the server, and only the resulting HTML will be sent to the browser.

Static Generation
To generate static routes for a given set of locales, we can use generateStaticParams with any page or layout. This can be global, for example, in the root layout:

app/[lang]/layout.tsx
TypeScript

TypeScript

export async function generateStaticParams() {
  return [{ lang: 'en-US' }, { lang: 'de' }]
}
 
export default function RootLayout({
  children,
  params,
}: Readonly<{
  children: React.ReactNode
  params: { lang: 'en-US' | 'de' }
}>) {
  return (
    <html lang={params.lang}>
      <body>{children}</body>
    </html>
  )
}
Resources
Minimal i18n routing and translations
next-intl
next-international
next-i18n-router
paraglide-next
lingui
Previous
Middleware
Next
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
See the API reference for more details.

API Reference
Learn more about the route.js file.
route.js
API reference for the route.js 
Metadata
Next.js has a Metadata API that can be used to define your application metadata (e.g. meta and link tags inside your HTML head element) for improved SEO and web shareability.

There are two ways you can add metadata to your application:

Config-based Metadata: Export a static metadata object or a dynamic generateMetadata function in a layout.js or page.js file.
File-based Metadata: Add static or dynamically generated special files to route segments.
With both these options, Next.js will automatically generate the relevant <head> elements for your pages. You can also create dynamic OG images using the ImageResponse constructor.

Static Metadata
To define static metadata, export a Metadata object from a layout.js or static page.js file.

layout.tsx | page.tsx
TypeScript

TypeScript

import type { Metadata } from 'next'
 
export const metadata: Metadata = {
  title: '...',
  description: '...',
}
 
export default function Page() {}
For all the available options, see the API Reference.

Dynamic Metadata
You can use generateMetadata function to fetch metadata that requires dynamic values.

app/products/[id]/page.tsx
TypeScript

TypeScript

import type { Metadata, ResolvingMetadata } from 'next'
 
type Props = {
  params: Promise<{ id: string }>
  searchParams: Promise<{ [key: string]: string | string[] | undefined }>
}
 
export async function generateMetadata(
  { params, searchParams }: Props,
  parent: ResolvingMetadata
): Promise<Metadata> {
  // read route params
  const id = (await params).id
 
  // fetch data
  const product = await fetch(`https://.../${id}`).then((res) => res.json())
 
  // optionally access and extend (rather than replace) parent metadata
  const previousImages = (await parent).openGraph?.images || []
 
  return {
    title: product.title,
    openGraph: {
      images: ['/some-specific-page-image.jpg', ...previousImages],
    },
  }
}
 
export default function Page({ params, searchParams }: Props) {}
For all the available params, see the API Reference.

Good to know:

Both static and dynamic metadata through generateMetadata are only supported in Server Components.
fetch requests are automatically memoized for the same data across generateMetadata, generateStaticParams, Layouts, Pages, and Server Components. React cache can be used if fetch is unavailable.
Next.js will wait for data fetching inside generateMetadata to complete before streaming UI to the client. This guarantees the first part of a streamed response includes <head> tags.
File-based metadata
These special files are available for metadata:

favicon.ico, apple-icon.jpg, and icon.jpg
opengraph-image.jpg and twitter-image.jpg
robots.txt
sitemap.xml
You can use these for static metadata, or you can programmatically generate these files with code.

For implementation and examples, see the Metadata Files API Reference and Dynamic Image Generation.

Behavior
File-based metadata has the higher priority and will override any config-based metadata.

Default Fields
There are two default meta tags that are always added even if a route doesn't define metadata:

The meta charset tag sets the character encoding for the website.
The meta viewport tag sets the viewport width and scale for the website to adjust for different devices.

<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
Good to know: You can overwrite the default viewport meta tag.

Ordering
Metadata is evaluated in order, starting from the root segment down to the segment closest to the final page.js segment. For example:

app/layout.tsx (Root Layout)
app/blog/layout.tsx (Nested Blog Layout)
app/blog/[slug]/page.tsx (Blog Page)
Merging
Following the evaluation order, Metadata objects exported from multiple segments in the same route are shallowly merged together to form the final metadata output of a route. Duplicate keys are replaced based on their ordering.

This means metadata with nested fields such as openGraph and robots that are defined in an earlier segment are overwritten by the last segment to define them.

Overwriting fields
app/layout.js

export const metadata = {
  title: 'Acme',
  openGraph: {
    title: 'Acme',
    description: 'Acme is a...',
  },
}
app/blog/page.jsssss