# TypeScript and ESLint Configuration Guide

## TypeScript Configuration

### tsconfig.json Settings
```json
{
  "compilerOptions": {
    "target": "es5",
    "lib": ["dom", "dom.iterable", "esnext"],
    "allowJs": true,
    "skipLibCheck": true,
    "strict": true,
    "noEmit": true,
    "esModuleInterop": true,
    "module": "esnext",
    "moduleResolution": "bundler",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "jsx": "preserve",
    "incremental": true,
    "plugins": [
      {
        "name": "next"
      }
    ],
    "paths": {
      "@/*": ["./src/*"]
    }
  },
  "include": ["next-env.d.ts", "**/*.ts", "**/*.tsx", ".next/types/**/*.ts"],
  "exclude": ["node_modules"]
}
```

### Important Compiler Options Explained

1. **strict**: Enables all strict type checking options
   - `strictNullChecks`: Makes handling null and undefined more explicit
   - `strictFunctionTypes`: Enables stricter checking of function types
   - `strictBindCallApply`: Ensures bind, call, and apply methods are type-safe

2. **moduleResolution**: How TypeScript looks up imported modules
   - "bundler": For use with modern bundlers like Next.js
   - Affects how import statements are resolved

3. **paths**: Configure module aliases
   - `@/*`: Maps to `src/*` for cleaner imports
   - Helps maintain consistent import paths

## ESLint Configuration

### .eslintrc.json
```json
{
  "extends": [
    "next/core-web-vitals",
    "plugin:@typescript-eslint/recommended"
  ],
  "parser": "@typescript-eslint/parser",
  "plugins": ["@typescript-eslint"],
  "rules": {
    "@typescript-eslint/no-explicit-any": "error",
    "@typescript-eslint/explicit-function-return-type": "warn",
    "@typescript-eslint/no-unused-vars": ["error", { "argsIgnorePattern": "^_" }],
    "no-console": ["warn", { "allow": ["warn", "error"] }]
  },
  "settings": {
    "next": {
      "rootDir": true
    }
  }
}
```

### Key ESLint Rules Explained

1. **@typescript-eslint/no-explicit-any**
   - Prevents use of `any` type
   - Forces explicit type declarations
   - Can be temporarily disabled with `// @ts-ignore`

2. **@typescript-eslint/explicit-function-return-type**
   - Requires explicit return types on functions
   - Improves code readability and maintainability
   - Example:
     ```typescript
     // Good
     function add(a: number, b: number): number {
       return a + b;
     }
     
     // Bad
     function add(a: number, b: number) {
       return a + b;
     }
     ```

3. **@typescript-eslint/no-unused-vars**
   - Flags unused variables
   - `argsIgnorePattern`: Allows unused parameters prefixed with underscore
   - Example:
     ```typescript
     // Good
     function logUser(user: User, _context: Context) {
       console.log(user);
     }
     
     // Bad
     function logUser(user: User, context: Context) {
       console.log(user);
     }
     ```

## Type Declarations

### Global Types
```typescript
// src/types/global.d.ts
declare global {
  interface Window {
    dataLayer: any[];
  }
  
  namespace NodeJS {
    interface ProcessEnv {
      NEXT_PUBLIC_API_URL: string;
      MONGODB_URI: string;
    }
  }
}

export {};
```

### Module Declarations
```typescript
// src/types/modules.d.ts
declare module '*.svg' {
  const content: React.FC<React.SVGProps<SVGSVGElement>>;
  export default content;
}

declare module '*.module.css' {
  const classes: { [key: string]: string };
  export default classes;
}
```

## Best Practices

1. **Type Imports/Exports**
   ```typescript
   // Prefer type imports for better tree-shaking
   import type { User } from './types';
   
   // Export type separately from implementation
   export interface Config {
     // ...
   }
   export type { Config };
   ```

2. **Utility Types**
   ```typescript
   // Use built-in utility types
   type UserPartial = Partial<User>;
   type UserReadonly = Readonly<User>;
   type UserPick = Pick<User, 'id' | 'name'>;
   ```

3. **Type Guards**
   ```typescript
   function isUser(obj: any): obj is User {
     return 'id' in obj && 'name' in obj;
   }
   ```

## Common Issues and Solutions

### Issue: Module Resolution
```json
{
  "compilerOptions": {
    "baseUrl": ".",
    "paths": {
      "@/*": ["src/*"],
      "@components/*": ["src/components/*"],
      "@utils/*": ["src/utils/*"]
    }
  }
}
```

### Issue: Environment Variables
```typescript
// src/env.d.ts
declare namespace NodeJS {
  interface ProcessEnv {
    NODE_ENV: 'development' | 'production' | 'test';
    NEXT_PUBLIC_API_URL: string;
  }
}
```

### Issue: Third-Party Library Types
```bash
# Install missing types
npm install --save-dev @types/package-name
```
Essential tsconfig.json options you should use
Published: 2024-11-11
1772 words - 7 min read
#typescript
#tsconfig
#best-practices
The tsconfig.json file in TypeScript is more than just a list of settings. It's a tool to manage how your code behaves, how secure it is, and how well it works with other systems. Whether you're an experienced TypeScript user or new to the language, understanding these configuration options will help you build a strong, efficient, and easy-to-maintain codebase.

TL;DR
Here’s a quick look at recommended best-practice settings for your tsconfig.json. These options will help improve build speed, enforce code safety, enhance debugging, and ensure compatibility:

{
    "compilerOptions": {
        "incremental": true, // Enables incremental compilation, build only the changed code
        "strict": true, // Enables all strict type-checking options (best practice)
        "rootDir": "src", // Root directory of input files
        "outDir": "./build", // Output directory for compiled files
        "allowJs": true, // Allows JavaScript files to be compiled alongside TypeScript files.
        "target": "es6", // Specifies the ECMAScript target version
        "module": "NodeNext", // Sets the module system to use (commonjs, nodenext, esnext)
        "lib": ["es2024"], // Specifies the library files to be included in the compilation.
        "sourceMap": true, // Generates source maps for debugging
        "skipLibCheck": true, // Skips type checking of declaration files
        "noUnusedParameters": false, // Do not allow unused parameters in functions.
        "noUnusedLocals": false, // Similar to noUnusedParameters, but for local variables.
        "noUncheckedIndexedAccess": true, // it ensures that indexed access types are checked for undefined values,
        "esModuleInterop": true, // Enables compatibility with CommonJS modules, allowing default imports from modules with no default export.
        "resolveJsonModule": true, // Allows importing JSON files as modules
        "forceConsistentCasingInFileNames": true, // Ensures that file names are treated with consistent casing, which is important for cross-platform compatibility.,
        "noImplicitOverride": true, // This option requires that any method in a subclass that overrides a method in a superclass must explicitly use the override keyword.
        "noPropertyAccessFromIndexSignature": true, // This setting enforces that properties accessed via dot notation must be explicitly defined in the type.
        "allowUnreachableCode": false, // When set to false, this option raises errors for code that is unreachable, meaning it cannot be executed.
        "noFallthroughCasesInSwitch": true, // This option reports errors for switch statement cases that fall through without a break, return, or throw statement.
        "noErrorTruncation": true, // When enabled, this option prevents TypeScript from truncating error messages, providing full details about the error.
        "declaration": true // Generates corresponding .d.ts file
    },
    "include": ["src/**/*.ts"],
    "exclude": []
}
What Is tsconfig.json and why it matters?
The tsconfig.json file is a key part of any TypeScript project. It tells the compiler how to turn your TypeScript code into JavaScript. By setting up this file, you can control things like how strict the error checks are and what format the output should be in. This is important for managing real-world production issues effectively.

1. Performance boosters: options for faster compilation
incremental: true

“Only recompile what has changed.”

The incremental option is ideal for large codebases or iterative projects where only a portion of code changes between builds. When enabled, TypeScript caches the previous build, allowing it to skip recompilation for unchanged files, saving time.

Example: Suppose you have a large project and make a minor update in one file. With incremental enabled, only that file will be recompiled, significantly reducing the build time.

2. Strictness first: options for code safety
strict: true

“Enable all strict type-checking options for enhanced code reliability. A TypeScript best practice.”

Setting "strict": true enables TypeScript’s full range of type-checking features, designed to catch potential bugs and edge cases early. This comprehensive flag is essentially a shortcut that enables several other critical options:

noImplicitAny: Disallows variables and parameters from being implicitly assigned the any type. This setting forces you to explicitly define types, reducing the risk of unexpected behaviors.
strictNullChecks: Ensures null and undefined are treated as distinct types, which makes code more predictable by preventing accidental operations on possibly null or undefined values.
strictFunctionTypes: Enforces stricter checking of function types, particularly useful for function assignments and compatibility across different scopes.
strictBindCallApply: Adds type checks for the bind, call, and apply methods to ensure arguments are compatible with the function’s parameter types.
strictPropertyInitialization: Ensures that class properties are initialized before use, typically by setting them in the constructor, preventing potential runtime errors.
noImplicitThis: Triggers an error if the this keyword implicitly has an any type, requiring explicit typing and promoting safer this usage.
alwaysStrict: Ensures all files are parsed in ECMAScript’s strict mode ("use strict"; is added to each file), catching more errors at runtime.
useUnknownInCatchVariables: Changes the type of the error variable in catch blocks from any to unknown, promoting better error handling by requiring explicit error type checks.
noUncheckedIndexedAccess: true

“Protect against undefined values in object lookups.”

This option is great for when you want an extra layer of safety when accessing object properties dynamically. When enabled, it checks that any indexed access types are not undefined, helping avoid runtime errors.

3. Output management: options for organizing build files
rootDir: "src"

“Specifies the directory of input files.”

This option points to the source files directory, which can help keep your project clean by organizing files logically. By setting rootDir, you ensure that the compiler knows where to find the source files it needs to build.

outDir: "./build"

“Defines the output directory for compiled JavaScript files.”

This is where TypeScript will output compiled files. Specifying an outDir is crucial for keeping your source files (src/) separate from generated JavaScript, making it easier to manage and clean up builds.

Tip: For a clean project structure, it’s a best practice to specify both rootDir and outDir.

4. Compatibility controls: options for cross-platform and module compatibility
target: "es6"

“Sets the ECMAScript version for the output.”

TypeScript compiles code to various JavaScript versions, but which version depends on your environment. Setting target to es6 is typically ideal for modern applications since it supports async/await and many new JavaScript features while still being compatible with most browsers and Node.js environments.

module: "NodeNext"

“Defines the module system, such as CommonJS, ESNext, or NodeNext.”

With NodeNext, you can use ES modules alongside TypeScript. This is especially useful if you’re working with libraries or Node.js modules in the latest format. For projects targeting other environments, consider commonjs or esnext depending on the requirements.

5. Debugging and testing: options for a better development experience
sourceMap: true

“Generates source maps to assist with debugging.”

Source maps map your TypeScript to the output JavaScript, making debugging in tools like Vscode debug, Chrome DevTools much easier. Without source maps, debugging is cumbersome since errors trace back to the generated JavaScript, not the original TypeScript code.

skipLibCheck: true

“Skip type-checking for third-party libraries.”

If you use many third-party libraries, setting skipLibCheck to true can reduce the type-checking workload. This can speed up your build process without compromising your code’s safety since it’s assumed libraries are already well-tested.

6. Code quality enforcements: options for cleaner, more predictable code
noUnusedParameters and noUnusedLocals: false

“Checks for unused parameters and variables.”

These options raise warnings for unused variables and parameters. It’s good practice to enable these for cleaner code, though occasionally setting them to false is helpful during refactoring or experimentation phases.

noImplicitOverride: true

“Ensures that methods overriding superclass methods explicitly use the override keyword.”

With noImplicitOverride, any overridden method must use the override keyword, making your code more readable and easier to debug, especially in large projects.

7. Module and JSON compatibility: options for better Interoperability
esModuleInterop: true

“Allows default imports from CommonJS modules.”

In TypeScript, some modules need interop handling between ES modules and CommonJS. With esModuleInterop, you can cleanly import default exports from CommonJS modules, making it easier to integrate libraries.

resolveJsonModule: true

“Enables importing JSON files as modules.”

Importing JSON files is often needed for configuration, localization, or mock data. By enabling resolveJsonModule, you can import JSON directly, with TypeScript automatically typing it as any.

8. Case sensitivity and cross-platform stability
forceConsistentCasingInFileNames: true

“Prevents issues from inconsistent file naming, which can break cross-platform compatibility.”

This option ensures case-sensitive file paths across platforms, preventing subtle bugs and cross-platform issues, especially between Unix and Windows.

9. Preventing common mistakes: safety checks and fallthrough cases
allowUnreachableCode: false

“Raises errors for unreachable code.”

Set allowUnreachableCode to false to prevent unreachable code from sneaking into production, ensuring cleaner and more intentional code paths.

noFallthroughCasesInSwitch: true

“Raises errors for fall-through cases in switch statements.”

This option prevents unexpected behavior in switch statements by enforcing an error if a case falls through without an explicit break, return, or throw.

Conclusion
Understanding the options in tsconfig.json can greatly enhance your TypeScript development by speeding up builds, organizing output, improving code quality, and making debugging easier. Master these settings to customize your TypeScript projects effectively, producing code that is efficient, easy to maintain, and secure.

The TSConfig Cheat Sheet
Matt Pocock
Matt Pocock
Matt is a well-regarded TypeScript expert known for his ability to demystify complex TypeScript concepts.
tsconfig.json scares everyone. It's a huge file with a TON of potential options.

But really, there are only a few configuration options you need to care about. Let's figure them out, and cheatsheet them.

#
The Package
This article is so popular that I've bundled its recommendations into a library! It's called @total-typescript/tsconfig, and you can check it out here.

#
Quickstart
Want just the code? Here you go:

{
  "compilerOptions": {
    /* Base Options: */
    "esModuleInterop": true,
    "skipLibCheck": true,
    "target": "es2022",
    "allowJs": true,
    "resolveJsonModule": true,
    "moduleDetection": "force",
    "isolatedModules": true,
    "verbatimModuleSyntax": true,

    /* Strictness */
    "strict": true,
    "noUncheckedIndexedAccess": true,
    "noImplicitOverride": true,

    /* If transpiling with TypeScript: */
    "module": "NodeNext",
    "outDir": "dist",
    "sourceMap": true,

    /* AND if you're building for a library: */
    "declaration": true,

    /* AND if you're building for a library in a monorepo: */
    "composite": true,
    "declarationMap": true,

    /* If NOT transpiling with TypeScript: */
    "module": "preserve",
    "noEmit": true,

    /* If your code runs in the DOM: */
    "lib": ["es2022", "dom", "dom.iterable"],

    /* If your code doesn't run in the DOM: */
    "lib": ["es2022"]
  }
}
#
Full Explanation
#
Base Options
Here are the base options I recommend for all projects.

{
  "compilerOptions": {
    "esModuleInterop": true,
    "skipLibCheck": true,
    "target": "es2022",
    "allowJs": true,
    "resolveJsonModule": true,
    "moduleDetection": "force",
    "isolatedModules": true,
    "verbatimModuleSyntax": true
  }
}
esModuleInterop: Helps mend a few of the fences between CommonJS and ES Modules.
skipLibCheck: Skips checking the types of .d.ts files. This is important for performance, because otherwise all node_modules will be checked.
target: The version of JavaScript you're targeting. I recommend es2022 over esnext for stability.
allowJs and resolveJsonModule: Allows you to import .js and .json files. Always useful.
moduleDetection: This option forces TypeScript to consider all files as modules. This helps to avoid 'cannot redeclare block-scoped variable' errors.
isolatedModules: This option prevents a few TS features which are unsafe when treating modules as isolated files.
verbatimModuleSyntax: This option forces you to use import type and export type, leading to more predictable behavior and fewer unnecessary imports. With module: NodeNext, it also enforces you're using the correct import syntax for ESM or CJS.
#
Strictness
Here are the strictness options I recommend for all projects.

{
  "compilerOptions": {
    "strict": true,
    "noUncheckedIndexedAccess": true,
    "noImplicitOverride": true
  }
}
strict: Enables all strict type checking options. Indispensable.
noUncheckedIndexedAccess: Prevents you from accessing an array or object without first checking if it's defined. This is a great way to prevent runtime errors, and should really be included in strict.
noImplicitOverride: Makes the override keyword actually useful in classes.
Many folks recommended the strictness options in tsconfig/bases, a wonderful repo which catalogs TSConfig options. These options include lots of rules which I consider too 'noisy', like noImplicitReturns, noUnusedLocals, noUnusedParameters, and noFallthroughCasesInSwitch. I recommend you add these rules to your tsconfig.json only if you want them.

#
Transpiling with TypeScript
If you're transpiling your code (creating JavaScript files) with tsc, you'll want these options.

{
  "compilerOptions": {
    "module": "NodeNext",
    "outDir": "dist"
  }
}
module: Tells TypeScript what module syntax to use. NodeNext is the best option for Node. moduleResolution: NodeNext is implied from this option.
outDir: Tells TypeScript where to put the compiled JavaScript files. dist is my preferred convention, but it's up to you.
#
Building for a Library
If you're building for a library, you'll want declaration: true.

{
  "compilerOptions": {
    "declaration": true
  }
}
declaration: Tells TypeScript to emit .d.ts files. This is needed so that libraries can get autocomplete on the .js files you're creating.
#
Building for a Library in a Monorepo
If you're building for a library in a monorepo, you'll also want these options.

{
  "compilerOptions": {
    "declaration": true,
    "composite": true,
    "sourceMap": true,
    "declarationMap": true
  }
}
composite: Tells TypeScript to emit .tsbuildinfo files. This tells TypeScript that your project is part of a monorepo, and also helps it to cache builds to run faster.
sourceMap and declarationMap: Tells TypeScript to emit source maps and declaration maps. These are needed so that when consumers of your libraries are debugging, they can jump to the original source code using go-to-definition.
#
Not Transpiling with TypeScript
If you're not transpiling your code with tsc, i.e. using TypeScript as more of a linter, you'll want these options.

{
  "compilerOptions": {
    "module": "preserve",
    "noEmit": true
  }
}
module: preserve is the best option because it most closely mimics how bundlers treat modules. moduleResolution: Bundler is implied from this option.
noEmit: Tells TypeScript not to emit any files. This is important when you're using a bundler so you don't emit useless .js files.
#
Running in the DOM
If your code runs in the DOM, you'll want these options.

{
  "compilerOptions": {
    "lib": ["es2022", "dom", "dom.iterable"]
  }
}
lib: Tells TypeScript what built-in types to include. es2022 is the best option for stability. dom and dom.iterable give you types for window, document etc.
#
Not Running in the DOM
If your code doesn't run in the DOM, you'll want lib: ["es2022"].

{
  "compilerOptions": {
    "lib": ["es2022"]
  }
}
These are the same as above, but without the dom and dom.iterable typings.

#
Changelog
I've been updating this cheatsheet as TypeScript evolves, and as I refine my view of what belongs in a reusable tsconfig.json. Here's the changelog:

2024-04-23: Added verbatimModuleSyntax to the base options. With the introduction of module: Preserve, verbatimModuleSyntax is much more useful. Many applications do 'fake ESM', where they write imports and exports but transpile to CommonJS. Next.js is a common example. Before module: Preserve, verbatimModuleSyntax would error on every single import or export statement because it was expecting a module. With module: Preserve, its scope is narrowed making sure import/export type is used correctly.
2024-04-23: Added noImplicitOverride to the strictness options. Never knew about this option, or the override keyword, until I discovered it while researching my book. noImplicitOverride is a very small improvement at no cost, so why not?
Using ESLint with TypeScript
Kenny DuMez
Kenny DuMez
Graphite software engineer
Using ESLint with TypeScript helps maintain high code quality, catch common errors, and enforce code style and best practices. This guide will provide an in-depth look at how to set up and configure ESLint in a TypeScript project, highlighting key plugins, rules, and configurations.

Step 1: Configuring ESLint with TypeScript
Installation: In this example we'll install ESLint with npm. If you haven't already initialized npm in your project, do that first, then install ESLint and the necessary TypeScript extensions.

Terminal
npm init -y
npm install eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin --save-dev


eslint: The core ESLint library.
@typescript-eslint/parser: A parser that allows ESLint to understand TypeScript syntax.
@typescript-eslint/eslint-plugin: A plugin that contains a set of ESLint rules that are specific to TypeScript.
Configuration: Once ESLint is installed, create an ESLint configuration file in your project root. You can do this by running eslint --init and choosing the appropriate options for TypeScript, or by manually creating a .eslintrc.json file that looks something like this:

Terminal
{
  "parser": "@typescript-eslint/parser",
  "extends": ["eslint:recommended", "plugin:@typescript-eslint/recommended"],
  "parserOptions": {
    "ecmaVersion": 2020,
    "sourceType": "module"
  },
  "rules": {
    // Custom rules here
  }
}


This configuration configures ESLint to use the TypeScript parser and apply recommended rules from both ESLint and the TypeScript ESLint plugin.

Step 2: Configuring TypeScript ESLint rules
Key rules and plugins:

@typescript-eslint/no-unused-vars: This rule extends the base ESLint no-unused-vars rule. It helps in catching unused variables in your TypeScript code, preventing potential bugs and reducing bloat.

Terminal
"rules": {
  "@typescript-eslint/no-unused-vars": ["error"]
}


eslint-import-resolver-typescript: This resolver helps ESLint resolve the file paths in your TypeScript project when using modules. You can install it separately by running:

Terminal
npm install eslint-import-resolver-typescript --save-dev


Then, configure it in your ESLint configuration:

Terminal
"settings": {
  "import/resolver": {
    "typescript": {} // loads <rootdir>/tsconfig.json to eslint
  }
}


@typescript-eslint/no-explicit-any: Forbids the use of the any type, pushing for a more specific type definition, increasing type safety.

Terminal
"rules": {
  "@typescript-eslint/no-explicit-any": ["error"]
}


@typescript-eslint/naming-convention: Enforces naming conventions using ESLint. This rule can be customized to require specific patterns for variables, types, properties, etc.

Terminal
"rules": {
  "@typescript-eslint/naming-convention": [
    "error",
    {
      "selector": "variableLike",
      "format": ["camelCase"]
    },
    {
      "selector": "typeLike",
      "format": ["PascalCase"]
    }
  ]
}


@typescript-eslint/ban-types: Prevents the use of specific types that are considered problematic. This rule can be configured to ban types like {} or Object that are too generic.

Terminal
"rules": {
  "@typescript-eslint/ban-types": [
    "error",
    {
      "types": {
        "Object": "Use {} instead",
        "{}": "Specify more detailed type or use `Record<string, unknown>`"
      }
    }
  ]
}


@typescript-eslint/consistent-type-imports: Enforces consistent usage of type imports throughout the project.

Terminal
"rules": {
  "@typescript-eslint/consistent-type-imports": ["error"]
}


@typescript-eslint/no-unsafe-assignment: Prevents unsafe assignments that can lead to runtime errors, such as assigning any typed variables to variables of a more specific type.

Terminal
"rules": {
  "@typescript-eslint/no-unsafe-assignment": ["warn"]
}


Step 3: Integrating ESLint into your workflow
Running ESLint: You can run ESLint manually via the command line or integrate it into your IDE to get real-time feedback. To run ESLint manually, run:

Terminal
npx eslint . --ext .ts,.tsx


IDE integration: Most modern IDEs like Visual Studio Code support ESLint integration. Install the ESLint plugin and it will automatically use your project's ESLint configuration.

For further reading see the official ESLint documentation.
Custom Rules
important
This page describes how to write your own custom ESLint rules using typescript-eslint. You should be familiar with ESLint's developer guide and ASTs before writing custom rules.

As long as you are using @typescript-eslint/parser as the parser in your ESLint configuration, custom ESLint rules generally work the same way for JavaScript and TypeScript code. The main four changes to custom rules writing are:

Utils Package: we recommend using @typescript-eslint/utils to create custom rules
AST Extensions: targeting TypeScript-specific syntax in your rule selectors
Typed Rules: using the TypeScript type checker to inform rule logic
Testing: using @typescript-eslint/rule-tester's RuleTester instead of ESLint core's
Utils Package
The @typescript-eslint/utils package acts as a replacement package for eslint that exports all the same objects and types, but with typescript-eslint support. It also exports common utility functions and constants most custom typescript-eslint rules tend to use.

caution
@types/eslint types are based on @types/estree and do not recognize typescript-eslint nodes and properties. You should generally not need to import from eslint when writing custom typescript-eslint rules in TypeScript.

RuleCreator
The recommended way to create custom ESLint rules that make use of typescript-eslint features and/or syntax is with the ESLintUtils.RuleCreator function exported by @typescript-eslint/utils.

It takes in a function that transforms a rule name into its documentation URL, then returns a function that takes in a rule module object. RuleCreator will infer the allowed message IDs the rule is allowed to emit from the provided meta.messages object.

This rule bans function declarations that start with a lower-case letter:

import { ESLintUtils } from '@typescript-eslint/utils';

const createRule = ESLintUtils.RuleCreator(
  name => `https://example.com/rule/${name}`,
);

// Type: RuleModule<"uppercase", ...>
export const rule = createRule({
  create(context) {
    return {
      FunctionDeclaration(node) {
        if (node.id != null) {
          if (/^[a-z]/.test(node.id.name)) {
            context.report({
              messageId: 'uppercase',
              node: node.id,
            });
          }
        }
      },
    };
  },
  name: 'uppercase-first-declarations',
  meta: {
    docs: {
      description:
        'Function declaration names should start with an upper-case letter.',
    },
    messages: {
      uppercase: 'Start this name with an upper-case letter.',
    },
    type: 'suggestion',
    schema: [],
  },
  defaultOptions: [],
});


RuleCreator rule creator functions return rules typed as the RuleModule interface exported by @typescript-eslint/utils. It allows specifying generics for:

MessageIds: a union of string literal message IDs that may be reported
Options: what options users may configure for the rule (by default, [])
If the rule is able to take in rule options, declare them as a tuple type containing a single object of rule options:

import { ESLintUtils } from '@typescript-eslint/utils';

type MessageIds = 'lowercase' | 'uppercase';

type Options = [
  {
    preferredCase?: 'lower' | 'upper';
  },
];

// Type: RuleModule<MessageIds, Options, ...>
export const rule = createRule<Options, MessageIds>({
  // ...
});

Extra Rule Docs Types
By default, rule meta.docs is allowed to contain only description and url as described in ESLint's Custom Rules > Rule Structure docs. Additional docs properties may be added as a type argument to ESLintUtils.RuleCreator:

interface MyPluginDocs {
  recommended: boolean;
}

const createRule = ESLintUtils.RuleCreator<MyPluginDocs>(
  name => `https://example.com/rule/${name}`,
);

createRule({
  // ...
  meta: {
    docs: {
      description: '...',
      recommended: true,
    },
    // ...
  },
});

Undocumented Rules
Although it is generally not recommended to create custom rules without documentation, if you are sure you want to do this you can use the ESLintUtils.RuleCreator.withoutDocs function to directly create a rule. It applies the same type inference as the createRules above without enforcing a documentation URL.

import { ESLintUtils } from '@typescript-eslint/utils';

export const rule = ESLintUtils.RuleCreator.withoutDocs({
  create(context) {
    // ...
  },
  meta: {
    // ...
  },
});

caution
We recommend any custom ESLint rule include a descriptive error message and link to informative documentation.

Handling rule options
ESLint rules can take options. When handling options, you will need to add information in at most three places:

The Options generic type argument to RuleCreator, where you declare the type of the options
The meta.schema property, where you add a JSON schema describing the options shape
The defaultOptions property, where you add the default options value
type MessageIds = 'lowercase' | 'uppercase';

type Options = [
  {
    preferredCase: 'lower' | 'upper';
  },
];

export const rule = createRule<Options, MessageIds>({
  meta: {
    // ...
    schema: [
      {
        type: 'object',
        properties: {
          preferredCase: {
            type: 'string',
            enum: ['lower', 'upper'],
          },
        },
        additionalProperties: false,
      },
    ],
  },
  defaultOptions: [
    {
      preferredCase: 'lower',
    },
  ],
  create(context, options) {
    if (options[0].preferredCase === 'lower') {
      // ...
    }
  },
});

warning
When reading the options, use the second parameter of the create function, not context.options from the first parameter. The first is created by ESLint and does not have the default options applied.

AST Extensions
@typescript-eslint/estree creates AST nodes for TypeScript syntax with names that begin with TS, such as TSInterfaceDeclaration and TSTypeAnnotation. These nodes are treated just like any other AST node. You can query for them in your rule selectors.

This version of the above rule instead bans interface declaration names that start with a lower-case letter:

import { ESLintUtils } from '@typescript-eslint/utils';

export const rule = createRule({
  create(context) {
    return {
      TSInterfaceDeclaration(node) {
        if (/^[a-z]/.test(node.id.name)) {
          // ...
        }
      },
    };
  },
  // ...
});

Node Types
TypeScript types for nodes exist in a TSESTree namespace exported by @typescript-eslint/utils. The above rule body could be better written in TypeScript with a type annotation on the node:

An AST_NODE_TYPES enum is exported as well to hold the values for AST node type properties. TSESTree.Node is available as union type that uses its type member as a discriminant.

For example, checking node.type can narrow down the type of the node:

import { AST_NODE_TYPES, TSESTree } from '@typescript-eslint/utils';

export function describeNode(node: TSESTree.Node): string {
  switch (node.type) {
    case AST_NODE_TYPES.ArrayExpression:
      return `Array containing ${node.elements.map(describeNode).join(', ')}`;

    case AST_NODE_TYPES.Literal:
      return `Literal value ${node.raw}`;

    default:
      return '🤷';
  }
}


Explicit Node Types
Rule queries that use more features of esquery such as targeting multiple node types may not be able to infer the type of the node. In that case, it is best to add an explicit type declaration.

This rule snippet targets name nodes of both function and interface declarations:

import { TSESTree } from '@typescript-eslint/utils';

export const rule = createRule({
  create(context) {
    return {
      'FunctionDeclaration, TSInterfaceDeclaration'(
        node: TSESTree.FunctionDeclaration | TSESTree.TSInterfaceDeclaration,
      ) {
        if (/^[a-z]/.test(node.id.name)) {
          // ...
        }
      },
    };
  },
  // ...
});


Typed Rules
tip
Read TypeScript's Compiler APIs > Type Checker APIs for how to use a program's type checker.

The biggest addition typescript-eslint brings to ESLint rules is the ability to use TypeScript's type checker APIs.

@typescript-eslint/utils exports an ESLintUtils namespace containing a getParserServices function that takes in an ESLint context and returns a services object.

That services object contains:

program: A full TypeScript ts.Program object if type checking is enabled, or null otherwise
esTreeNodeToTSNodeMap: Map of @typescript-eslint/estree TSESTree.Node nodes to their TypeScript ts.Node equivalents
tsNodeToESTreeNodeMap: Map of TypeScript ts.Node nodes to their @typescript-eslint/estree TSESTree.Node equivalents
If type checking is enabled, that services object additionally contains:

getTypeAtLocation: Wraps the type checker function, with a TSESTree.Node parameter instead of a ts.Node
getSymbolAtLocation: Wraps the type checker function, with a TSESTree.Node parameter instead of a ts.Node
Those additional objects internally map from ESTree nodes to their TypeScript equivalents, then call to the TypeScript program. By using the TypeScript program from the parser services, rules are able to ask TypeScript for full type information on those nodes.

This rule bans for-of looping over an enum by using the TypeScript type checker via typescript-eslint's services:

import { ESLintUtils } from '@typescript-eslint/utils';
import * as ts from 'typescript';

export const rule = createRule({
  create(context) {
    return {
      ForOfStatement(node) {
        // 1. Grab the parser services for the rule
        const services = ESLintUtils.getParserServices(context);

        // 2. Find the TS type for the ES node
        const type = services.getTypeAtLocation(node.right);

        // 3. Check the TS type's backing symbol for being an enum
        if (type.symbol.flags & ts.SymbolFlags.Enum) {
          context.report({
            messageId: 'loopOverEnum',
            node: node.right,
          });
        }
      },
    };
  },
  meta: {
    docs: {
      description: 'Avoid looping over enums.',
    },
    messages: {
      loopOverEnum: 'Do not loop over enums.',
    },
    type: 'suggestion',
    schema: [],
  },
  name: 'no-loop-over-enum',
  defaultOptions: [],
});


note
Rules can retrieve their full backing TypeScript type checker with services.program.getTypeChecker(). This can be necessary for TypeScript APIs not wrapped by the parser services.

Conditional Type Information
We recommend against changing rule logic based solely on whether services.program exists. In our experience, users are generally surprised when rules behave differently with or without type information. Additionally, if they misconfigure their ESLint config, they may not realize why the rule started behaving differently. Consider either gating type checking behind an explicit option for the rule or creating two versions of the rule instead.

tip
Documentation generators such as eslint-doc-generator can automatically indicate in a rule's docs whether it needs type information.

Testing
@typescript-eslint/rule-tester exports a RuleTester with a similar API to the built-in ESLint RuleTester. It should be provided with the same parser and parserOptions you would use in your ESLint configuration.

Below is a quick-start guide. For more in-depth docs and examples see the @typescript-eslint/rule-tester package documentation.

Testing Untyped Rules
For rules that don't need type information, no constructor parameters are necessary:

import { RuleTester } from '@typescript-eslint/rule-tester';
import rule from './my-rule';

const ruleTester = new RuleTester();

ruleTester.run('my-rule', rule, {
  valid: [
    /* ... */
  ],
  invalid: [
    /* ... */
  ],
});

Testing Typed Rules
For rules that do need type information, parserOptions must be passed in as well. We recommend using parserOptions.projectService with options to allow a default project for each test file.

import { RuleTester } from '@typescript-eslint/rule-tester';
import rule from './my-typed-rule';

const ruleTester = new RuleTester({
  languageOptions: {
    parserOptions: {
      projectService: {
        allowDefaultProject: ['*.ts*'],
      },
      tsconfigRootDir: __dirname,
    },
  },
});

ruleTester.run('my-typed-rule', rule, {
  valid: [
    /* ... */
  ],
  invalid: [
    /* ... */
  ],
});
Shared Configs
ESLint shareable configurations exist to provide a comprehensive list of rules settings that you can start with. @typescript-eslint/eslint-plugin includes built-in configurations you can extend from to pull in the recommended starting rules.

With the exception of all, strict, and strict-type-checked, all configurations are considered "stable". Rule additions and removals are treated as breaking changes and will only be done in major version bumps.

Getting Started
See Getting Started > Quickstart first to set up your ESLint configuration file. Packages > typescript-eslint includes more documentation on the tseslint helper.

eslint.config.mjs
// @ts-check

import eslint from '@eslint/js';
import tseslint from 'typescript-eslint';

export default tseslint.config(
  eslint.configs.recommended,
  tseslint.configs.recommended,
);

Projects Without Type Checking
If your project does not enable typed linting, we suggest enabling the recommended and stylistic configurations to start:

Flat Config
Legacy Config
eslint.config.mjs
export default tseslint.config(
  eslint.configs.recommended,
  tseslint.configs.recommended,
  tseslint.configs.stylistic,
);

If a majority of developers working on your project are comfortable with TypeScript and typescript-eslint, consider replacing recommended with strict.

Projects With Type Checking
If your project enables typed linting, we suggest enabling the recommended-type-checked and stylistic-type-checked configurations to start:

Flat Config
Legacy Config
eslint.config.mjs
export default tseslint.config(
  eslint.configs.recommended,
  tseslint.configs.recommendedTypeChecked,
  tseslint.configs.stylisticTypeChecked,
);

If a majority of developers working on your project are comfortable with TypeScript and typescript-eslint, consider replacing recommended-type-checked with strict-type-checked.

Recommended Configurations
We recommend that most projects should extend from one of:

recommended: Recommended rules for code correctness that you can drop in without additional configuration.
recommended-type-checked: Contains recommended + additional recommended rules that require type information.
strict: Contains recommended + additional strict rules that can also catch bugs but are more opinionated than recommended rules.
strict-type-checked: Contains strict + additional strict rules require type information.
Additionally, we provide a stylistic config that enforces concise and consistent code. We recommend that most projects should extend from either:

stylistic: Stylistic rules you can drop in without additional configuration.
stylistic-type-checked: Contains stylistic + additional stylistic rules that require type information.
note
These configurations are our recommended starting points, but you don't need to use them as-is. ESLint allows configuring own rule settings on top of extended configurations. See ESLint's Configuring Rules docs.

recommended
Recommended rules for code correctness that you can drop in without additional configuration. These rules are those whose reports are almost always for a bad practice and/or likely bug. recommended also disables core ESLint rules known to conflict with typescript-eslint rules or cause issues in TypeScript codebases.

Flat Config
Legacy Config
eslint.config.mjs
export default tseslint.config(
  tseslint.configs.recommended,
);

See configs/recommended.ts for the exact contents of this config.

recommended-type-checked
Contains all of recommended along with additional recommended rules that require type information. Rules newly added in this configuration are similarly useful to those in recommended.

Flat Config
Legacy Config
eslint.config.mjs
export default tseslint.config(
  tseslint.configs.recommendedTypeChecked,
);

See configs/recommended-type-checked.ts for the exact contents of this config.

strict
Contains all of recommended, as well as additional strict rules that can also catch bugs. Rules added in strict are more opinionated than recommended rules and might not apply to all projects.

Flat Config
Legacy Config
eslint.config.mjs
export default tseslint.config(
  tseslint.configs.strict,
);

Some rules also enabled in recommended default to more strict settings in this configuration. See configs/strict.ts for the exact contents of this config.

tip
We recommend a TypeScript project extend from plugin:@typescript-eslint/strict only if a nontrivial percentage of its developers are highly proficient in TypeScript.

warning
This configuration is not considered "stable" under Semantic Versioning (semver). Its enabled rules and/or their options may change outside of major version updates.

strict-type-checked
Contains all of recommended, recommended-type-checked, and strict, along with additional strict rules that require type information. Rules newly added in this configuration are similarly useful (and opinionated) to those in strict.

Flat Config
Legacy Config
eslint.config.mjs
export default tseslint.config(
  tseslint.configs.strictTypeChecked,
);

Some rules also enabled in recommended-type-checked default to more strict settings in this configuration. See configs/strict-type-checked.ts for the exact contents of this config.

tip
We recommend a TypeScript project extend from plugin:@typescript-eslint/strict-type-checked only if a nontrivial percentage of its developers are highly proficient in TypeScript.

warning
This configuration is not considered "stable" under Semantic Versioning (semver). Its enabled rules and/or their options may change outside of major version updates.

stylistic
Rules considered to be best practice for modern TypeScript codebases, but that do not impact program logic. These rules are generally opinionated about enforcing simpler code patterns.

Flat Config
Legacy Config
eslint.config.mjs
export default tseslint.config(
  tseslint.configs.stylistic,
);

Note that stylistic does not replace recommended or strict. stylistic adds additional rules.

See configs/stylistic.ts for the exact contents of this config.

stylistic-type-checked
Contains all of stylistic, along with additional stylistic rules that require type information. Rules newly added in this configuration are similarly opinionated to those in stylistic.

Flat Config
Legacy Config
eslint.config.mjs
export default tseslint.config(
  tseslint.configs.stylisticTypeChecked,
);

Note that stylistic-type-checked does not replace recommended-type-checked or strict-type-checked. stylistic-type-checked adds additional rules.

See configs/stylistic-type-checked.ts for the exact contents of this config.

Other Configurations
typescript-eslint includes a few utility configurations.

all
Enables each the rules provided as a part of typescript-eslint. Note that many rules are not applicable in all codebases, or are meant to be configured.

See configs/all.ts for the exact contents of this config.

warning
We do not recommend TypeScript projects extend from plugin:@typescript-eslint/all. Many rules conflict with each other and/or are intended to be configured per-project.

warning
This configuration is not considered "stable" under Semantic Versioning (semver). Its enabled rules and/or their options may change outside of major version updates.

base
A minimal ruleset that sets only the required parser and plugin options needed to run typescript-eslint. We don't recommend using this directly; instead, extend from an earlier recommended rule.

This config is automatically included if you use any of the recommended configurations.

See configs/base.ts for the exact contents of this config.

disable-type-checked
A utility ruleset that will disable type-aware linting and all type-aware rules available in our project. This config is useful if you'd like to have your base config concerned with type-aware linting, and then conditionally use overrides to disable type-aware linting on specific subsets of your codebase.

See configs/disable-type-checked.ts for the exact contents of this config.

info
If you use type-aware rules from other plugins, you will need to manually disable these rules or use a premade config they provide to disable them.

Flat Config
Legacy Config
eslint.config.mjs
export default tseslint.config(
  eslint.configs.recommended,
  tseslint.configs.recommendedTypeChecked,
  {
    languageOptions: {
      parserOptions: {
        projectService: true,
        tsconfigRootDir: import.meta.dirname,
      },
    },
  },
  {
    files: ['**/*.js'],
    extends: [tseslint.configs.disableTypeChecked],
  },
);

warning
This configuration is not considered "stable" under Semantic Versioning (semver). Its enabled rules and/or their options may change outside of major version updates.

eslint-recommended
This ruleset is meant to be used after extending eslint:recommended. It disables core ESLint rules that are already checked by the TypeScript compiler. Additionally, it enables rules that promote using the more modern constructs TypeScript allows for.

Flat Config
Legacy Config
eslint.config.mjs
export default tseslint.config(
  eslint.configs.recommended,
  tseslint.configs.eslintRecommended,
);

This config is automatically included if you use any of the recommended configurations.

See configs/eslint-recommended.ts for the exact contents of this config.

recommended-type-checked-only
A version of recommended that only contains type-checked rules and disables of any corresponding core ESLint rules. This config plus recommended is equivalent to recommended-type-checked.

.eslintrc.js
module.exports = {
  extends: ['plugin:@typescript-eslint/recommended-type-checked-only'],
};


See configs/recommended-type-checked-only.ts for the exact contents of this config.

strict-type-checked-only
A version of strict that only contains type-checked rules and disables of any corresponding core ESLint rules. This config plus strict is equivalent to strict-type-checked.

.eslintrc.js
module.exports = {
  extends: ['plugin:@typescript-eslint/strict-type-checked-only'],
};


See configs/strict-type-checked-only.ts for the exact contents of this config.

warning
This configuration is not considered "stable" under Semantic Versioning (semver). Its enabled rules and/or their options may change outside of major version updates.

stylistic-type-checked-only
A version of stylistic that only contains type-checked rules and disables of any corresponding core ESLint rules. This config plus stylistic is equivalent to stylistic-type-checked.

.eslintrc.js
module.exports = {
  extends: ['plugin:@typescript-eslint/stylistic-type-checked-only'],
};


See configs/stylistic-type-checked-only.ts for the exact contents of this config.

Suggesting Configuration Changes
If you feel strongly that a specific rule should (or should not) be one of these configurations, please file an issue along with a detailed argument explaining your reasoning.

Formatting
None of the preset configs provided by typescript-eslint enable formatting rules (rules that only serve to enforce code whitespace and other trivia). We strongly recommend you use Prettier or an equivalent for formatting your code, not ESLint formatting rules. See What About Formatting? > Suggested Usage.

Edit this page

Overview
@typescript-eslint/eslint-plugin includes over 100 rules that detect best practice violations, bugs, and/or stylistic issues specifically for TypeScript code. All of our rules are listed below.

tip
Instead of enabling rules one by one, we recommend using one of our pre-defined configs to enable a large set of recommended rules.

Rules
The rules are listed in alphabetical order. You can optionally filter them based on these categories:

Config Group (⚙️)
Metadata
(These categories are explained in more detail below.)

Rule	
⚙️
🔧
💭
🧱
💀
@typescript-eslint/adjacent-overload-signatures
Require that function overload signatures be consecutive	🎨				
@typescript-eslint/array-type
Require consistently using either T[] or Array<T> for arrays	🎨	🔧			
@typescript-eslint/await-thenable
Disallow awaiting a value that is not a Thenable	✅	💡	💭		
@typescript-eslint/ban-ts-comment
Disallow @ts-<directive> comments or require descriptions after directives	✅	💡			
@typescript-eslint/ban-tslint-comment
Disallow // tslint:<rule-flag> comments	🎨	🔧			
@typescript-eslint/class-literal-property-style
Enforce that literals on classes are exposed in a consistent style	🎨	💡			
@typescript-eslint/class-methods-use-this
Enforce that class methods utilize this				🧱	
@typescript-eslint/consistent-generic-constructors
Enforce specifying generic type arguments on type annotation or constructor name of a constructor call	🎨	🔧			
@typescript-eslint/consistent-indexed-object-style
Require or disallow the Record type	🎨	🔧			
@typescript-eslint/consistent-return
Require return statements to either always or never specify values			💭	🧱	
@typescript-eslint/consistent-type-assertions
Enforce consistent usage of type assertions	🎨	🔧
💡			
@typescript-eslint/consistent-type-definitions
Enforce type definitions to consistently use either interface or type	🎨	🔧			
@typescript-eslint/consistent-type-exports
Enforce consistent usage of type exports		🔧	💭		
@typescript-eslint/consistent-type-imports
Enforce consistent usage of type imports		🔧			
@typescript-eslint/default-param-last
Enforce default parameters to be last				🧱	
@typescript-eslint/dot-notation
Enforce dot notation whenever possible	🎨	🔧	💭	🧱	
@typescript-eslint/explicit-function-return-type
Require explicit return types on functions and class methods					
@typescript-eslint/explicit-member-accessibility
Require explicit accessibility modifiers on class properties and methods		🔧
💡			
@typescript-eslint/explicit-module-boundary-types
Require explicit return and argument types on exported functions' and classes' public class methods					
@typescript-eslint/init-declarations
Require or disallow initialization in variable declarations				🧱	
@typescript-eslint/max-params
Enforce a maximum number of parameters in function definitions				🧱	
@typescript-eslint/member-ordering
Require a consistent member declaration order					
@typescript-eslint/method-signature-style
Enforce using a particular method signature syntax		🔧			
@typescript-eslint/naming-convention
Enforce naming conventions for everything across a codebase			💭		
@typescript-eslint/no-array-constructor
Disallow generic Array constructors	✅	🔧		🧱	
@typescript-eslint/no-array-delete
Disallow using the delete operator on array values	✅	💡	💭		
@typescript-eslint/no-base-to-string
Require .toString() and .toLocaleString() to only be called on objects which provide useful information when stringified	✅		💭		
@typescript-eslint/no-confusing-non-null-assertion
Disallow non-null assertion in locations that may be confusing	🎨	💡			
@typescript-eslint/no-confusing-void-expression
Require expressions of type void to appear in statement position	🔒	🔧
💡	💭		
@typescript-eslint/no-deprecated
Disallow using code marked as @deprecated	🔒		💭		
@typescript-eslint/no-dupe-class-members
Disallow duplicate class members				🧱	
@typescript-eslint/no-duplicate-enum-values
Disallow duplicate enum member values	✅				
@typescript-eslint/no-duplicate-type-constituents
Disallow duplicate constituents of union or intersection types	✅	🔧	💭		
@typescript-eslint/no-dynamic-delete
Disallow using the delete operator on computed key expressions	🔒	🔧			
@typescript-eslint/no-empty-function
Disallow empty functions	🎨			🧱	
@typescript-eslint/no-empty-interface
Disallow the declaration of empty interfaces		🔧
💡			💀
@typescript-eslint/no-empty-object-type
Disallow accidentally using the "empty object" type	✅	💡			
@typescript-eslint/no-explicit-any
Disallow the any type	✅	🔧
💡			
@typescript-eslint/no-extra-non-null-assertion
Disallow extra non-null assertions	✅	🔧			
@typescript-eslint/no-extraneous-class
Disallow classes used as namespaces	🔒				
@typescript-eslint/no-floating-promises
Require Promise-like statements to be handled appropriately	✅	💡	💭		
@typescript-eslint/no-for-in-array
Disallow iterating over an array with a for-in loop	✅		💭		
@typescript-eslint/no-implied-eval
Disallow the use of eval()-like methods	✅		💭	🧱	
@typescript-eslint/no-import-type-side-effects
Enforce the use of top-level import type qualifier when an import only has specifiers with inline type qualifiers		🔧			
@typescript-eslint/no-inferrable-types
Disallow explicit type declarations for variables or parameters initialized to a number, string, or boolean	🎨	🔧			
@typescript-eslint/no-invalid-this
Disallow this keywords outside of classes or class-like objects				🧱	
@typescript-eslint/no-invalid-void-type
Disallow void type outside of generic or return types	🔒				
@typescript-eslint/no-loop-func
Disallow function declarations that contain unsafe references inside loop statements				🧱	
@typescript-eslint/no-loss-of-precision
Disallow literal numbers that lose precision				🧱	💀
@typescript-eslint/no-magic-numbers
Disallow magic numbers				🧱	
@typescript-eslint/no-meaningless-void-operator
Disallow the void operator except when used to discard a value	🔒	🔧
💡	💭		
@typescript-eslint/no-misused-new
Enforce valid definition of new and constructor	✅				
@typescript-eslint/no-misused-promises
Disallow Promises in places not designed to handle them	✅		💭		
@typescript-eslint/no-mixed-enums
Disallow enums from having both number and string members	🔒		💭		
@typescript-eslint/no-namespace
Disallow TypeScript namespaces	✅				
@typescript-eslint/no-non-null-asserted-nullish-coalescing
Disallow non-null assertions in the left operand of a nullish coalescing operator	🔒	💡			
@typescript-eslint/no-non-null-asserted-optional-chain
Disallow non-null assertions after an optional chain expression	✅	💡			
@typescript-eslint/no-non-null-assertion
Disallow non-null assertions using the ! postfix operator	🔒	💡			
@typescript-eslint/no-redeclare
Disallow variable redeclaration				🧱	
@typescript-eslint/no-redundant-type-constituents
Disallow members of unions and intersections that do nothing or override type information	✅		💭		
@typescript-eslint/no-require-imports
Disallow invocation of require()	✅				
@typescript-eslint/no-restricted-imports
Disallow specified modules when loaded by import				🧱	
@typescript-eslint/no-restricted-types
Disallow certain types		🔧
💡			
@typescript-eslint/no-shadow
Disallow variable declarations from shadowing variables declared in the outer scope				🧱	
@typescript-eslint/no-this-alias
Disallow aliasing this	✅				
@typescript-eslint/no-type-alias
Disallow type aliases					💀
@typescript-eslint/no-unnecessary-boolean-literal-compare
Disallow unnecessary equality comparisons against boolean literals	🔒	🔧	💭		
@typescript-eslint/no-unnecessary-condition
Disallow conditionals where the type is always truthy or always falsy	🔒	🔧	💭		
@typescript-eslint/no-unnecessary-parameter-property-assignment
Disallow unnecessary assignment of constructor property parameter					
@typescript-eslint/no-unnecessary-qualifier
Disallow unnecessary namespace qualifiers		🔧	💭		
@typescript-eslint/no-unnecessary-template-expression
Disallow unnecessary template expressions	🔒	🔧	💭		
@typescript-eslint/no-unnecessary-type-arguments
Disallow type arguments that are equal to the default	🔒	🔧	💭		
@typescript-eslint/no-unnecessary-type-assertion
Disallow type assertions that do not change the type of an expression	✅	🔧	💭		
@typescript-eslint/no-unnecessary-type-constraint
Disallow unnecessary constraints on generic types	✅	💡			
@typescript-eslint/no-unnecessary-type-parameters
Disallow type parameters that aren't used multiple times	🔒	💡	💭		
@typescript-eslint/no-unsafe-argument
Disallow calling a function with a value with type any	✅		💭		
@typescript-eslint/no-unsafe-assignment
Disallow assigning a value with type any to variables and properties	✅		💭		
@typescript-eslint/no-unsafe-call
Disallow calling a value with type any	✅		💭		
@typescript-eslint/no-unsafe-declaration-merging
Disallow unsafe declaration merging	✅				
@typescript-eslint/no-unsafe-enum-comparison
Disallow comparing an enum value with a non-enum value	✅	💡	💭		
@typescript-eslint/no-unsafe-function-type
Disallow using the unsafe built-in Function type	✅	🔧			
@typescript-eslint/no-unsafe-member-access
Disallow member access on a value with type any	✅		💭		
@typescript-eslint/no-unsafe-return
Disallow returning a value with type any from a function	✅		💭		
@typescript-eslint/no-unsafe-type-assertion
Disallow type assertions that narrow a type			💭		
@typescript-eslint/no-unsafe-unary-minus
Require unary negation to take a number	✅		💭		
@typescript-eslint/no-unused-expressions
Disallow unused expressions	✅			🧱	
@typescript-eslint/no-unused-vars
Disallow unused variables	✅			🧱	
@typescript-eslint/no-use-before-define
Disallow the use of variables before they are defined				🧱	
@typescript-eslint/no-useless-constructor
Disallow unnecessary constructors	🔒	💡		🧱	
@typescript-eslint/no-useless-empty-export
Disallow empty exports that don't change anything in a module file		🔧			
@typescript-eslint/no-var-requires
Disallow require statements except in import statements					💀
@typescript-eslint/no-wrapper-object-types
Disallow using confusing built-in primitive class wrappers	✅	🔧			
@typescript-eslint/non-nullable-type-assertion-style
Enforce non-null assertions over explicit type casts	🎨	🔧	💭		
@typescript-eslint/only-throw-error
Disallow throwing non-Error values as exceptions	✅		💭	🧱	
@typescript-eslint/parameter-properties
Require or disallow parameter properties in class constructors					
@typescript-eslint/prefer-as-const
Enforce the use of as const over literal type	✅	🔧
💡			
@typescript-eslint/prefer-destructuring
Require destructuring from arrays and/or objects		🔧	💭	🧱	
@typescript-eslint/prefer-enum-initializers
Require each enum member value to be explicitly initialized		💡			
@typescript-eslint/prefer-find
Enforce the use of Array.prototype.find() over Array.prototype.filter() followed by [0] when looking for a single result	🎨	💡	💭		
@typescript-eslint/prefer-for-of
Enforce the use of for-of loop over the standard for loop where possible	🎨				
@typescript-eslint/prefer-function-type
Enforce using function types instead of interfaces with call signatures	🎨	🔧			
@typescript-eslint/prefer-includes
Enforce includes method over indexOf method	🎨	🔧	💭		
@typescript-eslint/prefer-literal-enum-member
Require all enum members to be literal values	🔒				
@typescript-eslint/prefer-namespace-keyword
Require using namespace keyword over module keyword to declare custom TypeScript modules	✅	🔧			
@typescript-eslint/prefer-nullish-coalescing
Enforce using the nullish coalescing operator instead of logical assignments or chaining	🎨	💡	💭		
@typescript-eslint/prefer-optional-chain
Enforce using concise optional chain expressions instead of chained logical ands, negated logical ors, or empty objects	🎨	🔧
💡	💭		
@typescript-eslint/prefer-promise-reject-errors
Require using Error objects as Promise rejection reasons	✅		💭	🧱	
@typescript-eslint/prefer-readonly
Require private members to be marked as readonly if they're never modified outside of the constructor		🔧	💭		
@typescript-eslint/prefer-readonly-parameter-types
Require function parameters to be typed as readonly to prevent accidental mutation of inputs			💭		
@typescript-eslint/prefer-reduce-type-parameter
Enforce using type parameter when calling Array#reduce instead of casting	🔒	🔧	💭		
@typescript-eslint/prefer-regexp-exec
Enforce RegExp#exec over String#match if no global flag is provided	🎨	🔧	💭		
@typescript-eslint/prefer-return-this-type
Enforce that this is used when only this type is returned	🔒	🔧	💭		
@typescript-eslint/prefer-string-starts-ends-with
Enforce using String#startsWith and String#endsWith over other equivalent methods of checking substrings	🎨	🔧	💭		
@typescript-eslint/prefer-ts-expect-error
Enforce using @ts-expect-error over @ts-ignore		🔧			💀
@typescript-eslint/promise-function-async
Require any function or method that returns a Promise to be marked async		🔧	💭		
@typescript-eslint/related-getter-setter-pairs
Enforce that get() types should be assignable to their equivalent set() type	🔒		💭		
@typescript-eslint/require-array-sort-compare
Require Array#sort and Array#toSorted calls to always provide a compareFunction			💭		
@typescript-eslint/require-await
Disallow async functions which do not return promises and have no await expression	✅	💡	💭	🧱	
@typescript-eslint/restrict-plus-operands
Require both operands of addition to be the same type and be bigint, number, or string	✅		💭		
@typescript-eslint/restrict-template-expressions
Enforce template literal expressions to be of string type	✅		💭		
@typescript-eslint/return-await
Enforce consistent awaiting of returned promises	✅	🔧
💡	💭	🧱	
@typescript-eslint/sort-type-constituents
Enforce constituents of a type union/intersection to be sorted alphabetically		🔧
💡			💀
@typescript-eslint/strict-boolean-expressions
Disallow certain types in boolean expressions		🔧
💡	💭		
@typescript-eslint/switch-exhaustiveness-check
Require switch-case statements to be exhaustive		💡	💭		
@typescript-eslint/triple-slash-reference
Disallow certain triple slash directives in favor of ES6-style import declarations	✅				
@typescript-eslint/typedef
Require type annotations in certain places					
@typescript-eslint/unbound-method
Enforce unbound methods are called with their expected scope	✅		💭		
@typescript-eslint/unified-signatures
Disallow two overloads that could be unified into one with a union or an optional/rest parameter	🔒				
@typescript-eslint/use-unknown-in-catch-callback-variable
Enforce typing arguments in Promise rejection callbacks as unknown	🔒	🔧
💡	💭		
Filtering
Config Group (⚙️)
"Config Group" refers to the pre-defined config that includes the rule. Extending from a configuration preset allow for enabling a large set of recommended rules all at once.

Metadata
🔧 fixable refers to whether the rule contains an ESLint --fix auto-fixer.
💡 has suggestions refers to whether the rule contains an ESLint suggestion fixer.
Sometimes, it is not safe to automatically fix the code with an auto-fixer. But in these cases, we often have a good guess of what the correct fix should be, and we can provide it as a suggestion to the developer.
💭 requires type information refers to whether the rule requires typed linting.
🧱 extension rule means that the rule is an extension of an core ESLint rule (see Extension Rules).
💀 deprecated rule means that the rule should no longer be used and will be removed from the plugin in a future version.
Extension Rules
Some core ESLint rules do not support TypeScript syntax: either they crash, ignore the syntax, or falsely report against it. In these cases, we create what we call an "extension rule": a rule within our plugin that has the same functionality, but also supports TypeScript.

Extension rules generally completely replace the base rule from ESLint core. If the base rule is enabled in a config you extend from, you'll need to disable the base rule:

module.exports = {
  extends: ['eslint:recommended'],
  rules: {
    // Note: you must disable the base rule as it can report incorrect errors
    'no-unused-vars': 'off',
    '@typescript-eslint/no-unused-vars': 'error',
  },
};
Linting with Type Information
Some typescript-eslint rules utilize the awesome power of TypeScript's type checking APIs to provide much deeper insights into your code. To tap into TypeScript's additional powers, there are two small changes you need to make to your config file:

Flat Config
Legacy Config
Add TypeChecked to the name of any preset configs you're using, namely recommended, strict, and stylistic.
Add languageOptions.parserOptions to tell our parser how to find the TSConfig for each source file.
eslint.config.mjs
import eslint from '@eslint/js';
import tseslint from 'typescript-eslint';

export default tseslint.config(
  eslint.configs.recommended,
  tseslint.configs.recommendedTypeChecked,
  {
    languageOptions: {
      parserOptions: {
        projectService: true,
        tsconfigRootDir: import.meta.dirname,
      },
    },
  },
);

note
import.meta.dirname is only present for ESM files in Node.js >=20.11.0 / >= 21.2.0.
For CommonJS modules and/or older versions of Node.js, use __dirname or an alternative.

In more detail:

tseslint.configs.recommendedTypeChecked is another shared configuration we provide. This one contains recommended rules that additionally require type information.
parserOptions.projectService: true indicates to ask TypeScript's type checking service for each source file's type information (see Parser#projectService).
parserOptions.tsconfigRootDir tells our parser the absolute path of your project's root directory (see Parser#tsconfigRootDir).
caution
Your ESLint config file may start receiving a parsing error about type information. See our TSConfig inclusion FAQ.

With that done, run the same lint command you ran before. You may see new rules reporting errors based on type information!

Shared Configurations
If you enabled the strict shared config and/or stylistic shared config in a previous step, be sure to replace them with strictTypeChecked and stylisticTypeChecked respectively to add their type-checked rules.

Flat Config
Legacy Config
eslint.config.mjs
export default tseslint.config(
  eslint.configs.recommended,
  tseslint.configs.strictTypeChecked,
  tseslint.configs.stylisticTypeChecked,
  // ...
);

You can read more about the rules provided by typescript-eslint in our rules docs and shared configurations docs.

FAQs
Can I customize the TSConfig used for typed linting?
Yes, but it's not recommended in most configurations. parserOptions.projectService uses the same "project service" APIs used by editors such as VS Code to generate TypeScript's type information. Using a different TSConfig runs the risk of providing different types for typed linting than what your editor or tsc see.

If you absolutely must, the parserOptions.project option can be used instead of parserOptions.projectService with either:

true: to always use tsconfig.jsons nearest to source files
string | string[]: any number of glob paths to match TSConfig files relative to parserOptions.tsconfigRootDir, or the current working directory if that is not provided
For example, if you use a specific tsconfig.eslint.json for linting, you'd specify:

Flat Config
Legacy Config
eslint.config.mjs
export default tseslint.config({
  // ...
  languageOptions: {
    parserOptions: {
      project: './tsconfig.eslint.json',
      tsconfigRootDir: import.meta.dirname,
    },
  },
  // ...
});

See the @typescript-eslint/parser project docs for more details.

note
If your project is a multi-package monorepo, see our docs on configuring a monorepo.

How can I disable type-aware linting for a subset of files?
You can combine ESLint's overrides config in conjunction with our disable-type-checked config to turn off type-aware linting on specific subsets of files.

Flat Config
Legacy Config
eslint.config.mjs
export default tseslint.config(
  eslint.configs.recommended,
  tseslint.configs.recommendedTypeChecked,
  tseslint.configs.stylisticTypeChecked,
  {
    languageOptions: {
      parserOptions: {
        projectService: true,
        tsconfigRootDir: import.meta.dirname,
      },
    },
  },
  {
    files: ['**/*.js'],
    extends: [tseslint.configs.disableTypeChecked],
  },
);

info
If you use type-aware rules from other plugins, you will need to manually disable these rules or use a premade config they provide to disable them.

How is performance?
Typed rules come with a catch. By using typed linting in your config, you incur the performance penalty of asking TypeScript to do a build of your project before ESLint can do its linting. For small projects this takes a negligible amount of time (a few seconds or less); for large projects, it can take longer.

Most of our users do not mind this cost as the power and safety of type-aware static analysis rules is worth the tradeoff. Additionally, most users primarily consume lint errors via IDE plugins which, through caching, do not suffer the same penalties. This means that generally they usually only run a complete lint before a push, or via their CI, where the extra time often doesn't matter.

We strongly recommend you do use type-aware linting, but the above information is included so that you can make your own, informed decision.
console.log(`Searching for places with keyword: "${keyword}" in location: "${location}"`);