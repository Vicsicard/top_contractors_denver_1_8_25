# MongoDB with TypeScript in Next.js

## Overview
This document covers the integration of MongoDB with TypeScript in our Next.js application, including best practices, type definitions, and common patterns.

## MongoDB Connection Setup

### Type Definitions
When setting up MongoDB connection with TypeScript, we need proper type definitions for the global cache:

```typescript
interface MongooseCache {
  conn: typeof mongoose | null;
  promise: Promise<typeof mongoose> | null;
}

// Extend the globalThis type
declare global {
  // Use let instead of var to satisfy ESLint
  let mongoose: MongooseCache | undefined;
}
```

### Connection Pattern
Here's the recommended pattern for MongoDB connection with proper TypeScript types:

```typescript
import mongoose from 'mongoose';

let cached = (globalThis as unknown as { mongoose?: MongooseCache }).mongoose;

if (!cached) {
    cached = (globalThis as unknown as { mongoose?: MongooseCache }).mongoose = {
        conn: null,
        promise: null
    };
}

export async function connectDB(): Promise<typeof mongoose> {
    if (cached.conn) {
        return cached.conn;
    }
    // ... rest of connection logic
}
```

## Error Handling with TypeScript and Mongoose

### Custom Error Types
```typescript
// Define custom error types for MongoDB operations
interface MongoError extends Error {
  code?: number;
  keyPattern?: { [key: string]: number };
  keyValue?: { [key: string]: any };
}

// Type guard for MongoDB errors
function isMongoError(error: any): error is MongoError {
  return error.code !== undefined && error.name === 'MongoError';
}
```

### Error Handling Pattern
```typescript
async function safeMongoOperation<T>(operation: () => Promise<T>): Promise<T> {
  try {
    return await operation();
  } catch (error) {
    if (isMongoError(error)) {
      if (error.code === 11000) {
        throw new Error('Duplicate key error');
      }
      // Handle other specific MongoDB errors
    }
    throw error;
  }
}
```

## Schema Definitions

### Basic Schema with TypeScript
```typescript
import { Schema, model, Document } from 'mongoose';

interface IUser extends Document {
  name: string;
  email: string;
  createdAt: Date;
}

const userSchema = new Schema<IUser>({
  name: { type: String, required: true },
  email: { type: String, required: true, unique: true },
  createdAt: { type: Date, default: Date.now }
});

const User = model<IUser>('User', userSchema);
```

### Model Type Safety
When using models, ensure proper typing:

```typescript
async function findUser(email: string): Promise<IUser | null> {
  return await User.findOne({ email });
}
```

## Caching Strategies with TypeScript

### Cache Interface
```typescript
interface MongooseCache {
  conn: typeof mongoose | null;
  promise: Promise<typeof mongoose> | null;
}

// Type-safe global declaration
declare global {
  let mongoose: MongooseCache | undefined;
}
```

### Connection Caching Pattern
```typescript
let cached = (globalThis as unknown as { mongoose?: MongooseCache }).mongoose;

if (!cached) {
  cached = (globalThis as unknown as { mongoose?: MongooseCache }).mongoose = {
    conn: null,
    promise: null
  };
}

export async function connectDB(): Promise<typeof mongoose> {
  if (cached.conn) {
    return cached.conn;
  }

  if (!cached.promise) {
    cached.promise = mongoose.connect(MONGODB_URI, {
      bufferCommands: false,
    });
  }

  try {
    cached.conn = await cached.promise;
  } catch (e) {
    cached.promise = null;
    throw e;
  }

  return cached.conn;
}
```

## Custom Type Definitions for MongoDB Models

### Document Interfaces
```typescript
// Base interface for all documents
interface BaseDocument {
  _id: Types.ObjectId;
  createdAt: Date;
  updatedAt: Date;
}

// Example of a typed model interface
interface IPlaceCache extends BaseDocument {
  placeId: string;
  data: PlacesSearchResult;
  keyword: string;
  location: string;
}

// Schema type with methods
interface PlaceCacheModel extends Model<IPlaceCache> {
  findByKeywordAndLocation(keyword: string, location: string): Promise<IPlaceCache[]>;
}
```

### Schema Definition with Types
```typescript
const PlaceCacheSchema = new Schema<IPlaceCache, PlaceCacheModel>({
  placeId: {
    type: String,
    required: true,
    unique: true,
    index: true
  },
  data: {
    type: {
      name: { type: String, required: true },
      formatted_address: { type: String, required: true },
      place_id: { type: String, required: true },
      rating: { type: Number, required: false },
      user_ratings_total: { type: Number, required: false },
      categories: [{ type: String }],
      phone: { type: String, required: false },
      website: { type: String, required: false }
    },
    required: true,
  },
  keyword: {
    type: String,
    required: true,
    index: true,
    lowercase: true,
    trim: true
  },
  location: {
    type: String,
    required: true,
    index: true
  }
}, {
  timestamps: true
});
```

### Model Creation with Type Safety
```typescript
// Create the model with proper typing
const PlaceCache = model<IPlaceCache, PlaceCacheModel>('PlaceCache', PlaceCacheSchema);

// Type-safe usage example
async function findCachedPlace(keyword: string, location: string): Promise<IPlaceCache | null> {
  return await PlaceCache.findOne({ keyword, location }).exec();
}
```

## Best Practices

1. **Type Safety**: Always define interfaces for your schemas
2. **Global Types**: Use proper type declarations for global variables
3. **Null Checks**: Include proper null checking in TypeScript
4. **Model Types**: Use proper model typing with generics

## Common Issues and Solutions

### Global Type Declaration
When using `globalThis` or global variables, ensure proper type declaration:

```typescript
// Correct way to declare global types
declare global {
  let mongoose: MongooseCache | undefined;
}

// Avoid using 'any' type
declare global {
  let mongoose: any; // ❌ Bad practice
}
```

### Model Creation
Ensure proper typing when creating models:

```typescript
// Correct way
const model = mongoose.model<IUser>('User', userSchema);

// Avoid missing type parameters
const model = mongoose.model('User', userSchema); // ❌ Missing type parameter
```

## Resources

- [Mongoose TypeScript Documentation](https://mongoosejs.com/docs/typescript.html)
- [TypeScript Documentation](https://www.typescriptlang.org/docs/)
- [Next.js with MongoDB](https://nextjs.org/docs/api-reference/data-fetching)

ypeScript Support

Mongoose introduced officially supported TypeScript bindings in v5.11.0. Mongoose's index.d.ts file supports a wide variety of syntaxes and strives to be compatible with @types/mongoose where possible. This guide describes Mongoose's recommended approach to working with Mongoose in TypeScript.

Creating Your First Document
To get started with Mongoose in TypeScript, you need to:

Create an interface representing a document in MongoDB.
Create a Schema corresponding to the document interface.
Create a Model.
Connect to MongoDB.
import { Schema, model, connect } from 'mongoose';

// 1. Create an interface representing a document in MongoDB.
interface IUser {
  name: string;
  email: string;
  avatar?: string;
}

// 2. Create a Schema corresponding to the document interface.
const userSchema = new Schema<IUser>({
  name: { type: String, required: true },
  email: { type: String, required: true },
  avatar: String
});

// 3. Create a Model.
const User = model<IUser>('User', userSchema);

run().catch(err => console.log(err));

async function run() {
  // 4. Connect to MongoDB
  await connect('mongodb://127.0.0.1:27017/test');

  const user = new User({
    name: 'Bill',
    email: 'bill@initech.com',
    avatar: 'https://i.imgur.com/dM7Thhn.png'
  });
  await user.save();

  console.log(user.email); // 'bill@initech.com'
}
You as the developer are responsible for ensuring that your document interface lines up with your Mongoose schema. For example, Mongoose won't report an error if email is required in your Mongoose schema but optional in your document interface.

The User() constructor returns an instance of HydratedDocument<IUser>. IUser is a document interface, it represents the raw object structure that IUser objects look like in MongoDB. HydratedDocument<IUser> represents a hydrated Mongoose document, with methods, virtuals, and other Mongoose-specific features.

import { HydratedDocument } from 'mongoose';

const user: HydratedDocument<IUser> = new User({
  name: 'Bill',
  email: 'bill@initech.com',
  avatar: 'https://i.imgur.com/dM7Thhn.png'
});
ObjectIds and Other Mongoose Types
To define a property of type ObjectId, you should use Types.ObjectId in the TypeScript document interface. You should use 'ObjectId' or Schema.Types.ObjectId in your schema definition.

import { Schema, Types } from 'mongoose';

// 1. Create an interface representing a document in MongoDB.
interface IUser {
  name: string;
  email: string;
  // Use `Types.ObjectId` in document interface...
  organization: Types.ObjectId;
}

// 2. Create a Schema corresponding to the document interface.
const userSchema = new Schema<IUser>({
  name: { type: String, required: true },
  email: { type: String, required: true },
  // And `Schema.Types.ObjectId` in the schema definition.
  organization: { type: Schema.Types.ObjectId, ref: 'Organization' }
});
That's because Schema.Types.ObjectId is a class that inherits from SchemaType, not the class you use to create a new MongoDB ObjectId.

Using Custom Bindings
If Mongoose's built-in index.d.ts file does not work for you, you can remove it in a postinstall script in your package.json as shown below. However, before you do, please open an issue on Mongoose's GitHub page and describe the issue you're experiencing.

{
  "postinstall": "rm ./node_modules/mongoose/index.d.ts"
}
Next Up
How To Set Up Mongoose With Typescript In NextJS ?
Last Updated : 30 Jun, 2024
Integrating Mongoose with TypeScript in a Next.js application allows you to harness the power of MongoDB while maintaining strong typing and modern JavaScript features. This guide will walk you through the process of setting up Mongoose with TypeScript in a Next.js project, ensuring your application is robust, scalable, and easy to maintain.

Prerequisites:
Node.js and NPM
MongoDB
Next.js with TypeScript
Steps to Create a NextJS App and Installing Module
Step 1: Initialize Next app and move to the project directory.

npx create-next-app my-next-app
cd my-next-app
Step 2: Install the required dependencies:

npm install tailwindcss  react-hook-form mongoose mongodb
Project Structure
Screenshot-2024-05-30-141047
Project Structure
Step 3: Setting Up MongoDB Connection inside .env file add:

MONGOB_URI = mongodb+srv://yourMongodbnab:yourpassword@cluster0.ldnz1.mongodb.net/DatabaseName
The Updated dependencies of your package.json file will look like this:



"dependencies": {
    "mongoose": "^8.4.0",
    "next": "13.4",
    "react": "^18",
    "react-dom": "^18"
}
Example: Beow is an example of uploading an Image to MongoDB using only NextJS 13.4.


1
// utils/connectToDb.ts
2
import mongoose, { Connection } from "mongoose";
3
import { GridFSBucket } from "mongodb";
4
​
5
let client: Connection | null = null;
6
let bucket: GridFSBucket | null = null;
7
​
8
const MONGODB_URI = process.env.MONGODB_URI as string;
9
​
10
interface DbConnection {
11
    client: Connection;
12
    bucket: GridFSBucket;
13
}
14
​
15
async function connectToDb(): Promise<DbConnection> {
16
    if (client) {
17
        return { client, bucket: bucket as GridFSBucket };
18
    }
19
​
20
    await mongoose.connect(MONGODB_URI);
21
​
22
    client = mongoose.connection;
23
    bucket = new mongoose.mongo.GridFSBucket(client.db, {
24
        bucketName: "images",
25
    });
26
​
27
    console.log("Connected to the Database");
28
    return { client, bucket };
29
}
30
​
31
export default connectToDb;
Start your Next.js development server:

npm run dev
Visit http://localhost:3000 in your browser to see the application in action.

Output:
Screenshot-2024-05-21-142353
Output
When you enter the file name, upload a file, and then click on the submit button, your file is successfully uploaded to MongoDB.

Conclusion
Overall, using Mongoose in Next.js empowers developers to build feature-rich, data-driven web applications with a modern frontend and a robust backend database, enabling seamless integration, efficient data management, and scalable architecture.



Want to be a Software Developer or a Working Professional looking to enhance your Software Development Skills? Then, master the concepts of Full-Stack Development. Our Full Stack Development - React and Node.js Course will help you achieve this quickly. Learn everything from Front-End to Back-End Development with hands-on Projects and real-world examples. This course enables you to build scalable, efficient, dynamic web applications that stand out. Ready to become an expert in Full-Stack? Enroll Now and Start Creating the Future!



Comment

More info
Next Article 
Using Mongoose with NestJS
Last Updated : 14 Jul, 2024
NestJS is a progressive Node.js framework for building efficient, reliable, and scalable server-side applications. It provides a solid foundation for backend development with TypeScript support, built-in decorators, and a modular architecture. Mongoose, on the other hand, is a powerful Object Data Modeling (ODM) library for MongoDB and Node.js. Integrating Mongoose with NestJS allows developers to use the power of MongoDB in a structured and organized manner.

This article will guide you through the process of setting up a NestJS application with Mongoose, creating schemas, and building a basic module, controller, and service to interact with MongoDB.

Prerequisites
Node.js and npm
NestJS CLI
Steps to Use Mongoose with NestJS
Step 1: Create a new NestJS project:
nest new nest-gfg
cd nest-gfg
This will create a new directory my-nest-app and set up a basic NestJS project structure inside it.

Step 2: Creating a Basic Module, Controller, and Service
Generate a module:



nest generate module example
Generate a controller:



nest generate controller example
Generate a service:



nest generate service example
Step 3: Install Mongoose using the following command.
npm install @nestjs/mongoose mongoose
Step 4: Install dotenv for security
npm install dotenv
Folder Structure
rty
Folder Structure
Dependencies
"dependencies": {
     "@nestjs/common": "^10.0.0",
     "@nestjs/core": "^10.0.0",
     "@nestjs/mongoose": "^10.0.10",
     "@nestjs/platform-express": "^10.0.0",
     "dotenv": "^16.4.5",
     "mongoose": "^8.5.1",
     "reflect-metadata": "^0.2.0",
     "rxjs": "^7.8.1"
  }
Example: In this example we will connect to MongoDB Alas and create some data in the collection.


1
//src/main.ts
2
​
3
import { NestFactory } from '@nestjs/core';
4
import { AppModule } from './app.module';
5
import * as dotenv from 'dotenv';
6
​
7
dotenv.config();
8
​
9
async function bootstrap() {
10
    const app = await NestFactory.create(AppModule);
11
    await app.listen(3000);
12
}
13
bootstrap();
Run the application using the following command.

npm run start
Output


Want to be a Software Developer or a Working Professional looking to enhance your Software Development Skills? Then, master the concepts of Full-Stack Development. Our Full Stack Development - React and Node.js Course will help you achieve this quickly. Learn everything from Front-End to Back-End Development with hands-on Projects and real-world examples. This course enables you to build scalable, efficient, dynamic web applications that stand out. Ready to become an expert in Full-Stack? Enroll Now and Start Creating the Future!



Comment

More info
Next Article 
How to Post Data in MongoDB Using NodeJS?
Last Updated : 22 May, 2024
In this tutorial, we will go through the process of creating a simple Node.js application that allows us to post data to a MongoDB database. Here we will use Express.js for the server framework and Mongoose for interacting with MongoDB. And also we use the Ejs for our front end to render the simple HTML form.

Prerequisites
NPM & NodeJS
MongoDB
Steps on How to post data in MongoDB using NodeJS
Step 1: Create a New Directory: At first create a new directory for your project and navigate into it.

mkdir Your_folder_name
cd Your_folder_name
Step 2: Initialize a New Node.js Project: After that, you have to Initialize a new node project using npm.

npm init -y
Step 3: Install required packages: Then install the the required package using npm.

npm install express mongoose ejs
Step 4: Require Mongoose: After that in your NodeJS application, you need to require Mongoose.



const mongoose = require('mongoose');
Step 5: Call the connect method : Then you need to call the mongoose connect mothod to connect it.

const mongoose = require('mongoose');

const url = 'mongodb://localhost:27017/userData';

const connectDB = async () => {
    try {
        await mongoose.connect(url, {
           
        });
        console.log('Database is connected');
    } catch (err) {
        console.error('Error connecting to the database:', err);
        process.exit(1);
    }
};
Step 6: Then Define a schema : A schema is a structure, that gives information about how the data is being stored in a collection.

const userSchema = new Schema({
  name: {
    type: String,
    required: true,
  },
  email:{
    type:String,
    required:true,
  },
  mobile:{
    type: Number,
    required: true,
  },
  age: {
    type: Number,
    required: true,
  },
});

//Here you can add some more data as your need.
Project Structure
Screenshot-_443_
Folder structure
The updated dependencies in package.json file will look like:

 "dependencies": {
    "ejs": "^3.1.10",
    "express": "^4.19.2",
    "mongoose": "^8.3.4"
  }
Example: Below is the code example of how to post data in mongodb using node js


1
<!-- view/index.ejs !-->
2
<!DOCTYPE html>
3
<html lang="en">
4
<head>
5
    <meta charset="UTF-8">
6
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
7
    <title>Home Page</title>
8
    <style>
9
        body {
10
            font-family: Arial, sans-serif;
11
            background-color: #f9f9f9;
12
            margin: 0;
13
            padding: 0;
14
            display: flex;
15
            justify-content: center;
16
            align-items: center;
17
            height: 100vh;
18
        }
19
​
20
        .container {
21
            max-width: 400px;
22
            padding: 20px;
23
            background-color: #fff;
24
            border-radius: 8px;
25
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
26
        }
27
​
28
        h1 {
29
            color: #333;
30
            text-align: center;
31
            margin-bottom: 20px;
32
        }
33
​
34
        p {
35
            color: #666;
36
            text-align: center;
37
            margin-bottom: 20px;
38
        }
39
​
40
        form {
41
            text-align: center;
42
        }
43
​
44
        label {
45
            display: block;
46
            margin-bottom: 10px;
47
            color: #333;
48
        }
49
​
50
        input[type="text"],
51
        input[type="email"],
52
        input[type="tel"],
53
        input[type="number"],
54
        button {
55
            width: 100%;
56
            padding: 10px;
57
            margin-bottom: 15px;
58
            border: 1px solid #ccc;
59
            border-radius: 5px;
60
            box-sizing: border-box;
61
        }
62
​
63
        button {
64
            background-color: #007bff;
65
            color: #fff;
66
            cursor: pointer;
67
        }
68
​
69
        button:hover {
70
            background-color: #0056b3;
71
        }
72
​
73
        .message {
74
            color: green;
75
            text-align: center;
76
            margin-bottom: 20px;
77
        }
78
​
79
        .error {
80
            color: red;
81
            text-align: center;
82
            margin-bottom: 20px;
83
        }
84
    </style>
85
</head>
86
<body>
87
    <div class="container">
88
        <h1>Welcome to our website!</h1>
89
        <p>This is a simple form to save user data to the database.</p>
90
        <form id="userForm" action="/user" method="post" 
91
              onsubmit="return validateForm()">
92
            <label for="name">Name:</label>
93
            <input type="text" id="name" name="name" >
94
            <label for="email">Email Id:</label>
95
            <input type="email" id="email" name="email" >
96
            <label for="mobile">Mobile No:</label>
97
            <input type="tel" id="mobile" name="mobile" pattern="[0-9]{10}">
98
            <label for="age">Age:</label>
99
            <input type="number" id="age" name="age" >
100
            <button type="submit">Submit</button>
101
        </form>
102
        <% if (message) { %>
103
            <p class="message"><%= message %></p>
104
        <% } else if (error) { %>
105
            <p class="error"><%= error %></p>
106
        <% } %>
107
    </div>
108
​
109
    <script>
110
        function validateForm() {
111
            var name = document.getElementById("name").value;
112
            var email = document.getElementById("email").value;
113
            var mobile = document.getElementById("mobile").value;
114
            var age = document.getElementById("age").value;
115
​
116
            if (name === "" || email === "" || mobile === "" || age === "") {
117
                alert("Please fill out all fields.");
118
                return false;
119
            }
120
​
121
            if (!/^[0-9]{10}$/.test(mobile)) {
122
                alert("Please enter a valid 10-digit mobile number.");
123
                return false;
124
            }
125
​
126
            return true;
127
        }
128
    </script>
129
</body>
130
</html>
To run the code write in the command prompt.



node server.js
And open a new tab of your browser and type the following command to show the output.

http://localhost:3000/
Output
Database Output:

compressed_Screenshot-_445_
How to Post Data in MongoDB Using NodeJS?
Want to be a Software Developer or a Working Professional looking to enhance your Software Development Skills? Then, master the concepts of Full-Stack Development. Our Full Stack Development - React and Node.js Course will help you achieve this quickly. Learn everything from Front-End to Back-End Development with hands-on Projects and real-world examples. This course enables you to build scalable, efficient, dynamic web applications that stand out. Ready to become an expert in Full-Stack? Enroll Now and Start Creating the Future!



Comment

More info
Next Article 
How to use Material-UI with Next.js ?
Last Updated : 26 Jul, 2024
Integrating Material-UI (now known as MUI) with Next.js allows you to build modern, responsive user interfaces with a comprehensive set of React components. In this article, we will learn some additional necessary steps to be performed to integrate Material-UI with the Next.js project.

Prerequisites:
Node.js and NPM
Next.js
Approach
To use the Material-UI with Next.js we have to wrap the complete app with the ThemeProvider for consistent theming, using Material-UI components in your pages, and ensuring server-side rendering support with Emotion’s styling solutions for optimized performance and consistent styling.

First Let’s start by creating a Next.js project.

Steps to Integrate Material UI with Next.js
Step 1: Initialize a nwe Next.js project using the following command:

npx create-next-app gfg-next-mui
Step 2: Move to the Project directory



cd gfg-next-mui
Step 3: Install Material-UI

To install the dependencies and save them in your package.json file, run:

npm install @mui/material @emotion/react @emotion/styled @emotion/server
Project Structure:
It will look like this.

Project Structure
The updated dependencies in the package.json file are:

"dependencies": {
    "@emotion/react": "^11.13.0",
    "@emotion/server": "^11.11.0",
    "@emotion/styled": "^11.13.0",
    "@mui/material": "^5.16.5",
    "next": "14.2.4",
    "react": "^18",
    "react-dom": "^18"
}
Step 4: Modify the _document.js file. Configure the next app for server-side rendering using the Material UI and emotion library.




// pages/_document.js

import * as React from 'react';
import Document, { Html, Head, Main, NextScript } from 'next/document';
import createEmotionServer from '@emotion/server/create-instance';
import theme from '../src/theme';
import createEmotionCache from '../src/createEmotionCache';

export default class MyDocument extends Document {
    render() {
        return (
            <Html lang="en">
                <Head>
                    {/* PWA primary color */}
                    <meta name="theme-color" 
                        content={theme.palette.primary.main} />
                    <link rel="shortcut icon" 
                        href="/static/favicon.ico" />
                    <link
                        rel="stylesheet"
                        href=
"https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap"
                    />
{/* Inject MUI styles first to match with the prepend: true configuration. */}
                    {this.props.emotionStyleTags}
                </Head>
                <body>
                    <Main />
                    <NextScript />
                </body>
            </Html>
        );
    }
}

// `getInitialProps` belongs to `_document` (instead of `_app`),
// it's compatible with static-site generation (SSG).
MyDocument.getInitialProps = async (ctx) => {
   
    const originalRenderPage = ctx.renderPage;

    // You can consider sharing the same emotion cache between 
    // all the SSR requests to speed up performance.
    // However, be aware that it can have global side effects.
   
   const cache = createEmotionCache();
    const { extractCriticalToChunks } = createEmotionServer(cache);

    ctx.renderPage = () =>
        originalRenderPage({
            enhanceApp: (App) =>
                function EnhanceApp(props) {
                    return <App emotionCache={cache} {...props} />;
                },
        });

    const initialProps = await Document.getInitialProps(ctx);

    // This is important. It prevents emotion to render invalid HTML.
    // See 
// https://github.com/mui-org/material-ui/issues/26561#issuecomment-855286153
    
    const emotionStyles = extractCriticalToChunks(initialProps.html);
    const emotionStyleTags = emotionStyles.styles.map((style) => (
        <style
            data-emotion={`${style.key} ${style.ids.join(' ')}`}
            key={style.key}

            // eslint-disable-next-line react/no-danger
            dangerouslySetInnerHTML={{ __html: style.css }}
        />
    ));

    return {
        ...initialProps,
        emotionStyleTags,
    };
};
Step 5: Define Material-UI theme with custom primary, secondary, and error colors using createTheme from @mui/material/styles.

Create an src folder, add theme.js and createEmotionCache.js files as below


1
// Filename - src/theme.js
2
​
3
import { createTheme } from "@mui/material/styles";
4
import { red } from "@mui/material/colors";
5
​
6
// Create a theme instance.
7
const theme = createTheme({
8
    palette: {
9
        primary: {
10
            main: "#556cd6",
11
        },
12
        secondary: {
13
            main: "#19857b",
14
        },
15
        error: {
16
            main: red.A400,
17
        },
18
    },
19
});
20
​
21
export default theme;
Step 5: Update the file /pages/_app.js with the below code


1
// Filename - pages/_app.js
2
​
3
import * as React from "react";
4
import PropTypes from "prop-types";
5
import Head from "next/head";
6
import { ThemeProvider } from "@mui/material/styles";
7
import CssBaseline from "@mui/material/CssBaseline";
8
import { CacheProvider } from "@emotion/react";
9
import theme from "../src/theme";
10
import createEmotionCache from "../src/createEmotionCache";
11
​
12
// Client-side cache shared for the whole session
13
// of the user in the browser.
14
​
15
const clientSideEmotionCache = createEmotionCache();
16
​
17
export default function MyApp(props) {
18
    const { Component,
19
            emotionCache = clientSideEmotionCache,
20
            pageProps } = props;
21
​
22
    return (
23
        <CacheProvider value={emotionCache}>
24
            <Head>
25
                <meta 
26
                    name="viewport" 
27
                    content="initial-scale=1, 
28
                    width=device-width" />
29
            </Head>
30
            <ThemeProvider theme={theme}>
31
                {/* CssBaseline kickstart an elegant, 
32
                consistent, and simple baseline to
33
                build upon. */}
34
​
35
                <CssBaseline />
36
                <Component {...pageProps} />
37
            </ThemeProvider>
38
        </CacheProvider>
39
    );
40
}
41
​
42
MyApp.propTypes = {
43
    Component: PropTypes.elementType.isRequired,
44
    emotionCache: PropTypes.object,
45
    pageProps: PropTypes.object.isRequired,
46
};
Step 6: Update the Home Component in /pages/index.js with the below code.


1
// pages/inde.js
2
​
3
import Head from "next/head";
4
import styles from "../styles/Home.module.css";
5
​
6
export default function Home() {
7
    return (
8
        <div className={styles.container}>
9
            <Head>
10
                <title>Create Next App</title>
11
                <link rel="icon" href="/favicon.ico" />
12
            </Head>
13
​
14
            <main className={styles.main}>
15
                <h1 className={styles.title}>
16
                    Welcome to <a href="https://nextjs.org">
17
                        Next.js!</a> integrated with{" "}
18
                    <a href="https://mui.com/">Material-UI!</a>
19
                </h1>
20
                <p className={styles.description}>
21
                    Get started by editing{" "}
22
                    <code className={styles.code}>
23
                        pages/index.js</code>
24
                </p>
25
​
26
            </main>
27
        </div>
28
    );
29
}
Steps to run the application: To run the app, type the following command in the terminal.

npm run dev
Output:



Want to be a Software Developer or a Working Professional looking to enhance your Software Development Skills? Then, master the concepts of Full-Stack Development. Our Full Stack Development - React and Node.js Course will help you achieve this quickly. Learn everything from Front-End to Back-End Development with hands-on Projects and real-world examples. This course enables you to build scalable, efficient, dynamic web applications that stand out. Ready to become an expert in Full-Stack? Enroll Now and Start Creating the Future!



Comment

More info
Next Article 
How to use Select Component in Material UI ?
How to make Mongo schema from pure Typescript classes ?
Last Updated : 08 Sep, 2022
TypeScript is an object-oriented programming language, and it is a superset of JavaScript and contains all of its elements. By using TSC (TypeScript Compiler), we can convert Typescript code (.ts file) to JavaScript (.js file). It is open-source and its code is easier to read and understand. 

MongoDB is a versatile widely used NoSQL documentation based database. A collection can hold a bunch of documents. We can assume a collection as a table in RDBMS technology, but no strong entity relationships are required in the collection. A mongoose schema is equivalent to a collection. We can keep different data inside a Mongoose schema to create the collection in MongoDB. In this article, let us see how to make Mongo schema from pure Typescript class. The extension of the Typescript file is .ts and usually, from Angular framework projects, we are using Typescript classes, and let us see in detail. In order to interact with MongoDB, we require Mongoose. 

Project Setup and Module Installation:

Step 1: We are going to use the Typescript class, let us create by initializing a project using the following command.

 yarn init (or npm init ) 
 



When prompted, set the entry point to the following file.

src/server.ts .
Step 2: Install the required module using the following command.

# Dependency to connect to create MongoDB 
# Schema and connect to mongodb
yarn add express mongoose

# Dependency to create TypeScript files, 
# Dependency to execute those files in Node
# Dependency to speed up the development
yarn add -D nodemon typescript ts-node 
    @types/express @types/mongoose @types/node

# GlobalDependencies
npm i -g typescript ts-node
package.json: Our package.json file will look like this.

{
  "name": "mongo-typescript",
  "version": "1.0.0",
  "main": "src/server.ts",
  "license": "MIT",
  "scripts": {
    "start": "node --inspect=5858 -r ts-node/register ./src/server.ts",
    "dev": "nodemon",
    "build": "tsc",
    "script": "cd src/scripts && ts-node"
  },
  "dependencies": {
    "express": "^4.17.1",
    "mongoose": "^5.9.7"
  },
  "devDependencies": {
    "@types/express": "^4.17.6",
    "@types/mongoose": "^5.7.10",
    "@types/node": "^13.11.1",
    "nodemon": "^2.0.3",
    "ts-node": "^8.8.2",
    "typescript": "^3.8.3"
  }
}
tsconfig.json: This file has to be created in the root directory, and it will tell the compiler about the location for TypeScript files, and it will allow us to use ES6 import/export syntax.

{
  "compilerOptions": {
    "target": "es6",
    "module": "commonjs",
    "outDir": "dist",
    "sourceMap": true
  },
  "include": ["src/**/*.ts"],
  "exclude": ["node_modules", ".vscode"]
}
Connecting to the Database: For database connectivity, Create a separate folder using the following commands.



mkdir src 
cd src 
mkdir database 
touch database.ts
Project Structure: It will look like this.



 

Example:




import * as Mongoose from 'mongoose'; 
import { EmployeeModel } from './employees/employees.model'; 
  
let database: Mongoose.Connection; 
  
export const connect = () => { 
    // Add your own uri below, here my dbname is UserDB 
    // and we are using the local mongodb 
    const uri = 
        'mongodb://localhost:27017/UserDB'; 
  
    if (database) { 
        return; 
    } 
    // In order to fix all the deprecation warnings,  
    // below are needed while connecting 
    Mongoose.connect(uri, { 
        useNewUrlParser: true, 
        useFindAndModify: true, 
        useUnifiedTopology: true, 
        useCreateIndex: true, 
    }); 
  
    database = Mongoose.connection; 
    // When mentioned database is available and successfully connects 
    database.once('open', async () => { 
        console.log('Connected to database successfully'); 
    }); 
  
    // In case of any error 
    database.on('error', () => { 
        console.log(`Error connecting to database. Check Whether mongoDB 
        installed or you can try to give opensource Mongo Atlas database`); 
    }); 
  
    return { 
        EmployeeModel 
    }; 
}; 
  
// Safer way to get disconnected 
export const disconnect = () => { 
    if (!database) { 
        return; 
    } 
  
    Mongoose.disconnect(); 
};



import * as express from "express"; 
import { connect } from "./database/database"; 
  
const app = express(); 
  
// Available port number and it should not  
// be used by other services 
const port = 5002; 
  
connect(); 
  
// To indicate the project initiated,  
// let us add console message 
app.listen(port, () => { 
    console.log(`Server started on http://localhost:${port}`); 
});
Create models

Typescript files are helpful to create Mongo Schema. It is mentioned as Three parts to a Mongoose model (schema, static methods, and instance methods), Fourth one is to hold our TypeScript interfaces, and the fifth to bring everything together.

Inside the src/database/<collectionname> folder, let us create the models. Here <<collectionname> represents the name of MongoDB collection. Let us have it as employees.

<collectionname>.schema.ts: Define the Mongoose Schema, which helps for the determination of the shape of our MongoDB documents.
<collectionname>.statics.ts: Required static methods are added and called on the model itself.
<collectionname>.methods.ts: Instance methods of our model, functions which can be called on individual model instances.
<collectionname>.types.ts: Store the types we’ll use in the other files.
<collectionname>.model.ts: It is used to combine everything together.
We can use the following command to create a directory and files.

# Move to scr folder and create database folder
cd src 
mkdir database 

# Move to database folder and create employees folder
cd database 
mkdir employees

# Move to employees folder and create files
cd employees 
touch employees.schema.ts employees.statics.ts 
touch employees.methods.ts employees.types.ts employees.model.ts



// Main schema file where we can define the 
// required attributes 
import * as Mongoose from "mongoose"; 
  
const EmployeeSchema = new Mongoose.Schema({ 
    firstName: String, 
    lastName: String, 
    age: Number, 
    dateOfJoining: { 
        type: Date, 
        default: new Date(), 
    }, 
    lastUpdated: { 
        type: Date, 
        default: new Date(), 
    }, 
    gender: String, 
    department: String, 
  
    // All other required attributes 
    // should be given here 
}); 
  
export default EmployeeSchema;
IEmployeeDocument: Inclusion of our fields and other elements of a standard Mongoose Document.
IEmployeeModel: Representation of a standard Mongoose Model, containing documents of our IEmployeeDocument type.



import { Document, Model } from "mongoose"; 
  
// These fields represent fields of collection  
// and name of the collection is Employee 
export interface IEmployee { 
    firstName: string; 
    lastName: string; 
    age: number; 
    dateOfEntry?: Date; 
    lastUpdated?: Date; 
    gender: String; 
    department: String; 
} 
  
export interface IEmployeeDocument extends IEmployee, Document { } 
export interface IEmployeeModel extends Model<IEmployeeDocument> { }
 




import { model } from "mongoose"; 
import { IEmployeeDocument } from "./employees.types"; 
import EmployeeSchema from "./employees.schema"; 
  
export const EmployeeModel = model<IEmployeeDocument>("employee", 
  EmployeeSchema 
)
Create two static methods as shown below:

findOneOrCreate: Checks for an entry for its existence and if not, creates a new entry.
findByAge: Returns an array of employees, based on a provided age range.
Similarly, we can define methods depends upon the requirement like findByGender, findByDepartment, etc., which ultimately matches our requirements




import { IEmployeeDocument, IEmployeeModel } from "./employees.types"; 
  
// Check for the existence of an entry  
// and if it is not available, create one 
export async function findOneOrCreate( 
    this: IEmployeeModel, 
    { 
        firstName, 
        lastName, 
        age, 
        gender, 
        department, 
    }: { 
        firstName: string; lastName: string; age: number;  
        gender: string; department: string 
    } 
): Promise<IEmployeeDocument> { 
    const employeeRecord = await this.findOne({ 
        firstName, 
        lastName, age, gender, department 
    }); 
    if (employeeRecord) { 
        return employeeRecord; 
    } else { 
        return this.create({ 
            firstName, lastName, 
            age, gender, department 
        }); 
    } 
} 
  
export async function findByAge( 
    this: IEmployeeModel, 
    min?: number, 
    max?: number 
): Promise<IEmployeeDocument[]> { 
    return this.find({ age: { $gte: min || 0, $lte: max || Infinity } }); 
} 
  
// Similarly add the rest of the methods according to the requirement



import { Document } from "mongoose"; 
import { IEmployeeDocument } from "./employees.types"; 
  
export async function setLastUpdated( 
  this: IEmployeeDocument): Promise<void> { 
    const now = new Date(); 
    if (!this.lastUpdated || this.lastUpdated < now) { 
        this.lastUpdated = now; 
        await this.save(); 
    } 
} 
  
export async function sameLastName( 
    this: IEmployeeDocument): Promise<Document[]> { 
        return this.model("employee") 
            .find({ lastName: this.lastName }); 
} 



import * as Mongoose from "mongoose"; 
import { findOneOrCreate, findByAge } from "./employees.statics"; 
import { setLastUpdated, sameLastName } from "./employees.methods"; 
  
const EmployeeSchema = new Mongoose.Schema({ 
    firstName: String, 
    lastName: String, 
    age: Number, 
    dateOfJoining: { 
        type: Date, 
        default: new Date(), 
    }, 
    lastUpdated: { 
        type: Date, 
        default: new Date(), 
    }, 
    gender: String, 
    department: String, 
    // All other required attributes should be given here 
}); 
  
EmployeeSchema.statics.findOneOrCreate = findOneOrCreate; 
EmployeeSchema.statics.findByAge = findByAge; 
  
EmployeeSchema.methods.setLastUpdated = setLastUpdated; 
EmployeeSchema.methods.sameLastName = sameLastName; 
  
export default EmployeeSchema;



import { Document, Model } from "mongoose"; 
  
export interface IEmployee { 
    firstName: string; 
    lastName: string; 
    age: number; 
    dateOfJoining?: Date; 
    lastUpdated?: Date; 
    gender: String; 
    department: String; 
} 
  
export interface IEmployeeDocument extends IEmployee, Document { 
    setLastUpdated: (this: IEmployeeDocument) => Promise<void>; 
    sameLastName: (this: IEmployeeDocument) => Promise<Document[]>; 
} 
  
export interface IEmployeeModel extends Model<IEmployeeDocument> { 
    findOneOrCreate: ( 
        this: IEmployeeModel, 
        { 
            firstName, 
            lastName, 
            age, 
            gender, 
            department, 
        }: { firstName: string; lastName: string; age: number;  
            gender: string; department: string; } 
    ) => Promise<IEmployeeDocument>; 
    findByAge: ( 
        this: IEmployeeModel, 
        min?: number, 
        max?: number 
    ) => Promise<IEmployeeDocument[]>; 
}



import { EmployeeModel } from "../database/employees/employees.model"; 
import { connect, disconnect } from "../database/database"; 
  
(async () => { 
    connect(); 
    // Via "sampleEmployeeData.ts" we can add data to Mongoose schema 
    // Our schema name is employees 
    const employees = [ 
        { 
            firstName: "Rachel", lastName: "Green", age: 25, 
            gender: "Female", department: "Design"
        }, 
        { 
            firstName: "Monica", lastName: "Geller", age: 25, 
            gender: "Female", department: "Catering"
        }, 
        { 
            firstName: "Phebe", lastName: "Phebe", age: 25, 
            gender: "Female", department: "Masus"
        }, 
        { 
            firstName: "Ross", lastName: "Geller", age: 30, 
            gender: "Male", department: "Paleontology"
        }, 
        { 
            firstName: "Chandler", lastName: "Bing", age: 30, 
            gender: "Male", department: "IT"
        }, 
        { 
            firstName: "Joey", lastName: "Joey", age: 30, 
            gender: "Male", department: "Dramatist"
        }, 
    ]; 
  
    try { 
        for (const employee of employees) { 
            await EmployeeModel.create(employee); 
            console.log(`Created employee ${employee.firstName}  
            ${employee.lastName}`); 
        } 
  
        disconnect(); 
    } catch (e) { 
        console.log(e); 
    } 
})();
Steps to run the application: Start the server using the following command.

yarn start


The next step is we need to create the collections using the Mongoose schema. Use the following command to fill in the data:

yarn script sampleEmployeeData.ts
Output:



In the Mongo shell, we can verify the same. In UserDB database, on querying db.employees.find().pretty(), we can see the output:



Conclusion: Typescript files are so cool which has advanced features of JavaScript and by using mongoose, Express we can easily create MongoDB schemas by using Typescript files
How to Use TypeScript with MongoDB Atlas
You will need to create a MongoDB database in this tutorial. The easiest way is to create a free cluster in MongoDB Atlas, MongoDB's fully-managed, multi-cloud document database service.
Sign up free
Log in
Microsoft developed TypeScript as a superset of JavaScript that has a single open-source compiler. It has all the same features of JavaScript, but with an additional layer on top: the type system. This allows for optional static typing, as well as type inference. In addition to many other languages, MongoDB also supports TypeScript through the MongoDB NodeJS Driver. The driver has the types for Typescript already built in so there is no need for any other packages.

Table of Contents

Why TypeScript?
Prerequisites
Setting Up Your Project
Creating Models
Creating Services
Creating Routes
Pulling Together
Testing Our Methods
Create
Read
Update
Delete
Adding Schema Validation
Summary
Why TypeScript?
JavaScript has long been one of the most used languages when developing web applications. It can be used either on the front end, or in the back end using Node.js.

However, JavaScript isn’t without its limitations, such as a lack of static typing, making it much harder to spot issues at compile-time and leading to harder-to-debug errors at runtime. As the size of a project increases, the maintainability and readability of the code reduces as well.

This is where TypeScript comes in. It’s an extra layer on top of JavaScript, but adds static types. Because it’s an extra layer and not a separate framework, it actually uses a transpiler at build time to convert the TypeScript code into JavaScript. Therefore, you can continue using any JavaScript libraries in your project.

But at the application layer, when working on the code, developers get types and type-checking. This means knowing what data types can be used with no unexpected changes. Plus, by being limited by types, errors will be raised at time of coding, or build time, reducing the number of bugs.

Knowing that you have the advantages of type-safety means being able to focus on writing the code and generally being more productive.

In this post, you will learn how to get started using MongoDB Atlas, MongoDB’s Database-as-a-Service, with a web API for listing games, created with Express, with the object-oriented power of TypeScript.

Prerequisites
You will need to have Node installed in order to follow along with this tutorial. It has access to npm out of the box for package management in your projects.

You will also need to create a MongoDB database. The easiest way to get started with MongoDB is to create a free cluster in MongoDB Atlas, MongoDB's fully-managed, multi-cloud document database service.

Need to create an account?
Launch a free cluster with MongoDB Atlas.
Try free
Setting Up Your Project
This article focuses on how to add MongoDB and enjoy the power of TypeScript. To get you into coding faster, a companion repository was created on GitHub.

The default ‘main’ branch gives you the basic boilerplate code required to follow this tutorial. However, if you want to run the completed version, there is another branch on the repo called ‘finish’.

This project is already set up with Express and TypeScript configurations. Out of the box, when run, it will print “Hello world!” to the page. The steps listed under each heading will walk you through adding MongoDB access and creating a model. Then, test your newly created endpoints with each of the Create, Read, Update, and Delete (CRUD) operations before adding schema validation at database level.

In order to connect to the database later on, follow the steps outlined below.

Adding the MongoDB NodeJS Driver
The first thing you will need to do is add the MongoDB npm package. From the root of the project in your terminal of choice, use the following command to install the MongoDB NodeJS Driver:

npm install mongodb
Adding MongoDB Atlas Connection String
The companion repository already has the dotenv package installed. This package allows the loading of config from a .env file. Combining your connection string with a .env file allows for a separation of user secrets from functionality. It’s good practice to add the .env file to a .gitignore file to avoid leaking API keys, connection strings, and other private config settings. This has already been done in the project so you don’t have to do it.

Add a .env file to the root of the project and add the following, populating the value strings with the details from Atlas:

DB_CONN_STRING=""
DB_NAME=""
GAMES_COLLECTION_NAME=""
You should already have your database and MongoDB cluster created. However, if you need help with getting your connection string, the MongoDB documentation can help.

Your .env file should look similar to this when complete.

DB_CONN_STRING="mongodb+srv://<username>:<password>@sandbox.jadwj.mongodb.net"
DB_NAME="gamesDB"
GAMES_COLLECTION_NAME="games"
Make sure your connection string has had any templated values such as <password> replaced with your password you set when creating the user.

Creating Models with TypeScript
In TypeScript, classes or interfaces can be used to create models to represent what our documents will look like. Classes can define what properties an object should have, as well as what data type those properties should be. This is like an application-level schema. Classes also provide the ability to create instances of that class and take advantage of the benefits of object-orientated programming.

To keep the code clean, we are going to create folders under the src/ directory to hold the relevant files. Create a new “models” folder inside the src folder.

Inside this folder, create a file called game.ts and paste the following outline into it:

// External dependencies

// Class Implementation
Your src folder should like the following image at this stage:

 game.ts file inside models folder that lives inside src folder

Next, under the ‘External Dependencies’ section, add:

import { ObjectId } from "mongodb";
ObjectId is a unique MongoDB data type which is used for the ‘_id’ field that every document has and is used as a unique identifier and acts as the primary key.

Now it’s time to create our class. Paste the following code under the “Class Implementation” heading:

export default class Game {
    constructor(public name: string, public price: number, public category: string, public id?: ObjectId) {}
}
Here we are adding properties for our game model and their data types, to take advantage of TypeScript as part of the constructor. This allows the objects to be created, while also defining the properties. The id property has a ? after it to denote that it’s optional. Although every document in MongoDB has an id, it won’t always exist at code level, such as when you are creating a document. In this instance, the ‘_id’ field is auto-generated at creation time.

We now have a model of our data represented in code so that developers can take advantage of autocomplete and type checking.

Creating Services
Now we need to create our service that will talk to the database. This class will be responsible for configuring the connection.

Create a new folder under src/ called ‘services’ and inside that, create a database.service.ts file and paste the following outline:

// External Dependencies

// Global Variables

// Initialize Connection
As this service will be connecting to the database, it will need to use the MongDB NodeJS driver and .env config. Paste the following under the “External Dependencies” heading:

import * as mongoDB from "mongodb";
import * as dotenv from "dotenv";
We want to access our collection from outside our service, so, under the “Global Variables” heading, add:

export const collections: { games?: mongoDB.Collection } = {}
Now we are ready to start coding in the key functions in this service. We want to have a function that can be called to initialize the connection to the database so it’s ready for when we want to talk to the database later in the code. Under “Initialize Connection,” paste the following:

export async function connectToDatabase () {
   dotenv.config();

   const client: mongoDB.MongoClient = new mongoDB.MongoClient(process.env.DB_CONN_STRING);
           
   await client.connect();
       
   const db: mongoDB.Db = client.db(process.env.DB_NAME);
  
   const gamesCollection: mongoDB.Collection = db.collection(process.env.GAMES_COLLECTION_NAME);

 collections.games = gamesCollection;
      
        console.log(`Successfully connected to database: ${db.databaseName} and collection: ${gamesCollection.collectionName}`);
}
There is quite a lot happening here, so let’s break it down. dotenv.config(); pulls in the .env file so the values can be accessed when calling process.env. The .config() call is empty as we use the default location for a .env file, which is the root of the project.

It then creates a new MongoDB client, passing it the connection string, including valid user credentials. Then it attempts to connect to MongoDB, the database, and the collection with the names specified in .env, persisting this to the global collection variable for access externally.

Creating Routes
Now that we have the functionality available to communicate with the database, it’s time to provide endpoints for the client side to communicate using Express and perform CRUD operations.

In order to keep the code clean, we are going to create a router which will handle all calls to the same endpoint, in this case, ‘/game’. These endpoints will also talk to our database service.

Under ‘/src’, create a ‘routes’ folder, and inside that folder, create a file called games.router.ts and paste the following outline:

// External Dependencies

// Global Config

// GET

// POST

// PUT

// DELETE
Under ‘External Dependencies’, paste the following import statements:

import express, { Request, Response } from "express";
import { ObjectId } from "mongodb";
import { collections } from "../services/database.service";
import Game from "../models/game";
We then need to set up our router before we can start coding the endpoints, so paste the following under ‘Global Config’:

export const gamesRouter = express.Router();

gamesRouter.use(express.json());
In MongoDB, information is stored in BSON Documents. BSON is a binary, JSON-like structure. It supports the same data types as JSON with a few extras, such as date and raw binary, as well as more number types such as integer, long, and float.

Because of this, we are able to accept JSON input to our application when creating or updating documents. We do, however, have to tell our router to use the json parser middleware built into Express, which is why we call use(express.json());.

Next we will begin to add in handlers to the router for each endpoint we want on our API.

GET
The first endpoint we will add is our default GET route:

gamesRouter.get("/", async (_req: Request, res: Response) => {
    try {
       const games = (await collections.games.find({}).toArray()) as Game[];

        res.status(200).send(games);
    } catch (error) {
        res.status(500).send(error.message);
    }
});
Later on, you will see how we configure the app to send all ‘/games’ traffic to our router. But for now, know that because we are inside this router, we only have to specify ‘/’ to handle calls to it.

Here we are calling find on the collection. The find function takes an object in the first argument, which is the filter we want to apply to the search. In this case, we want to return every document in the collection so we pass an empty object.

The find function actually returns a special type called a Cursor which manages the results of our query, so we cast it to an array, which is a basic TypeScript data type easier to work with across the codebase. Since we know it will be a document matching our Games model, we also add the additional as Game[]; to the line so we have an array of specifically Game objects.

This array is then sent back to the front end to be displayed on screen. This is where the ‘res’ Response object built into Express is used. We send a status code of 200, which means success, back as well as the array of games documents. This is useful when using API clients such as Postman.

Next, we will add an endpoint to GET a specific document:

gamesRouter.get("/:id", async (req: Request, res: Response) => {
    const id = req?.params?.id;

    try {
        
        const query = { _id: new ObjectId(id) };
        const game = (await collections.games.findOne(query)) as Game;

        if (game) {
            res.status(200).send(game);
        }
    } catch (error) {
        res.status(404).send(`Unable to find matching document with id: ${req.params.id}`);
    }
});
This endpoint looks slightly different. The ‘:id’ is a route parameter that gives us a named parameter at that location in the URL. For example, the route we have specified here would look like '/game/<your document id>' where the templated id string in brackets would be replaced with the document id. This makes it much easier to use than query parameters.

It takes the id and uses this in a query object we build. Since _id is of type ObjectId, we create a new ObjectId, passing in the string id to convert. We then call findOne, passing in that query, so we filter the results by the first one matching that id and cast it to our Game model.

We then return a 200 status code and the game object if one was found, or we return 404 a.k.a. not found, and an error message to the client.

POST
Express and TypeScript make handling POST requests to create a new document in your collection super easy. Paste the following under the ‘POST’ heading:

gamesRouter.post("/", async (req: Request, res: Response) => {
    try {
        const newGame = req.body as Game;
        const result = await collections.games.insertOne(newGame);

        result
            ? res.status(201).send(`Successfully created a new game with id ${result.insertedId}`)
            : res.status(500).send("Failed to create a new game.");
    } catch (error) {
        console.error(error);
        res.status(400).send(error.message);
    }
});
Here we create our new game object by parsing the request body. We then use the insertOne method to create a single document inside a collection, passing the new game. If a collection does not exist, the first write operation will implicitly create it. The same thing happens when we create a database. The first structure inside a database will implicitly create it.

We then do some simple error handling, returning a status code and message, depending on the outcome of the insert.

Use InsertMany to insert multiple documents at once.

PUT
The PUT method is used when requesting an update to an existing document. Paste the code under the ‘PUT’ heading:

gamesRouter.put("/:id", async (req: Request, res: Response) => {
    const id = req?.params?.id;

    try {
        const updatedGame: Game = req.body as Game;
        const query = { _id: new ObjectId(id) };
      
        const result = await collections.games.updateOne(query, { $set: updatedGame });

        result
            ? res.status(200).send(`Successfully updated game with id ${id}`)
            : res.status(304).send(`Game with id: ${id} not updated`);
    } catch (error) {
        console.error(error.message);
        res.status(400).send(error.message);
    }
});
This is very similar to the POST method above. However, we also have the ‘:id’ request parameter you learned about in GET.

Like with the findOne function, updateOne takes a query as the first argument. The second argument is another object, in this case, the update filter. Because we have a whole object and we don’t need to care what is new or not, we pass in ‘$set’ which is a property that adds or updates all fields in the document.

Instead of passing a 500 error if it fails this time, however, we pass 304, which means not modified to reflect that the document hasn’t changed.

Although we don’t use it here as the default settings are fine, the function takes an optional third argument which is an object of optional parameters. One example is upsert, which if set to true, will create a new document if it doesn’t exist when being requested to be updated. You can read more about updateOne and optional arguments in our documentation.

DELETE
Finally we come to delete. Paste the following code under the “Delete” heading:

gamesRouter.delete("/:id", async (req: Request, res: Response) => {
    const id = req?.params?.id;

    try {
        const query = { _id: new ObjectId(id) };
        const result = await collections.games.deleteOne(query);

        if (result && result.deletedCount) {
            res.status(202).send(`Successfully removed game with id ${id}`);
        } else if (!result) {
            res.status(400).send(`Failed to remove game with id ${id}`);
        } else if (!result.deletedCount) {
            res.status(404).send(`Game with id ${id} does not exist`);
        }
    } catch (error) {
        console.error(error.message);
        res.status(400).send(error.message);
    }
});
Nothing much different to earlier functions such as read is happening here. We create a query from the id and pass that query to the deleteOne function. See our reference documentation to learn more about deleting multiple documents.

If it was able to be deleted, a 202 status is returned. 202 means accepted as we only know it accepted the deletion. Otherwise we return 400 if it wasn't deleted, or 404 if the document couldn't be found.

Pulling Together
Woo! You now have a service that connects to the database and a router that handles requests from the client and passes those through to your service. But there is one last step to pull it all together and that is updating index.ts to reflect our new service and router.

Replace the current import statement with the following:

import express from "express";
import { connectToDatabase } from "./services/database.service"
import { gamesRouter } from "./routes/games.router";
Next, we need to replace the app.get and app.listen calls with:

connectToDatabase()
    .then(() => {
        app.use("/games", gamesRouter);

        app.listen(port, () => {
            console.log(`Server started at http://localhost:${port}`);
        });
    })
    .catch((error: Error) => {
        console.error("Database connection failed", error);
        process.exit();
    });
This first calls the connectToDatabase function to initialize the connection. Then when that is complete, as long as it was successful, it tells the app to route all “/games” traffic to our gamesRouter class and starts the server.

Testing Our Methods
Now it’s time to test out our methods! First we need to start the application, so in your CLI, enter the following to build and run the application:

npm run start
This will then start the application at http://localhost:8080 that you can use your API client of choice (such as Postman) to test your application via the endpoints.

Create
Make a POST request to http://localhost:8080/games, passing it a JSON object in the body which defines the fields for the new game.

You will also need to specify ‘Content-Type’ as ‘application/json’ in the header of your request. Once you press send, you should get back a ‘201 Created’ status that we set in our code earlier.

Screenshot of Postman showing a json body being sent to the api and getting a 201 created status back

You can use the following JSON snippet or create your own:

{
   "name": "Fable Anniversary",
   "price": 4.99,
   "category": "Video Game"
}
Read
Make a GET request to http://localhost:8080/games. You don’t need to specify any headers or a body for this. It will return an array of documents in your collection. The collection will only contain the one document that you created in the previous step.

Screenshot of Postman showing a GET request to /games that returns an array containing the one game document created already.

From this list, copy the ‘_id’ value of your document, we will now use this to test the GET for a specific document.

Make a GET request to http://localhost:8080/games/<your document id> to see your document successfully returned.

Screenshot of Postman making a GET request to /game/id of the document and returning that document

Update
Next we can update our existing document to test the update endpoint as we already have the document id from the last step.

Make a PUT request to http://localhost:8080/games/<your document id>, ensuring that you still have the content-type set to application/json in the header. In the body, use the same details as when you created the document but change something, such as price.

Screenshot of Postman showing a PUT request to /games/id of document

Delete
Make a DELETE request to http://localhost:8080/games/<your document id>. You should get back a 202 status.

Screenshot of Postman showing a DELETE request to /games/id of document

Adding Schema Validation with the MongoDB NodeJS Driver
You have a working API written with TypeScript that talks to MongoDB Atlas and your database in the cloud. Woo! However, TypeScript and its advantages, such as static typing, are at application level for the developer.

In the past, developers have used a library called Mongoose to help address this with application level schemas. However, this only impacts the application and not the database, which means if another project or user decides to insert a document or update an existing document with a different set of fields or data types, your code will break.

For this reason, it’s important to think about adding validation at a database level instead, so that no external changes can be made to the data that would break your TypeScript code.

This is where MongoDB’s schema validation comes into play. This will allow us to restrict the database as well to only accept the fields and data types that we expect in our models.

Going into detail about schema validation is outside the scope of this post as it’s such a powerful and broad topic.

However, if you want to learn more, there is a great article on Schema Validation. If you would like a more hands-on example, we have a JSON Schema Tutorial that you can follow.

There is also a great article looking at why you don’t need Mongoose anymore, if you want to learn more.

For now, we will simply apply some JSON schema validation to our existing collection to ensure all future documents match the model we expect.

In database.service.ts, add the following after const db: mongoDB.Db = client.db(process.env.DB_NAME;:

await db.command({
            "collMod": process.env.GAMES_COLLECTION_NAME,
            "validator": {
                $jsonSchema: {
                    bsonType: "object",
                    required: ["name", "price", "category"],
                    additionalProperties: false,
                    properties: {
                    _id: {},
                    name: {
                        bsonType: "string",
                        description: "'name' is required and is a string"
                    },
                    price: {
                        bsonType: "number",
                        description: "'price' is required and is a number"
                    },
                    category: {
                        bsonType: "string",
                        description: "'category' is required and is a string"
                    }
                    }
                }
             }
        });
If you haven’t seen a JSON schema before, this might look a bit intimidating but don’t worry—let’s talk through what is going on.

We send a command to our database that tells it to moderate the collection with the name defined in process.env. We then pass an object of the schema to the validator property. This schema specifies that name, price, and category are required fields. It also specifies their data type in our BSON document and a description.

The collection modification command we are sending is specifically for existing collections. However, you can also apply schema validation when creating a collection for the first time, by passing a schema object to the validator property of the createCollection command.

With the new command added, the next time you run the project, it will apply this validation to your collection. If you were then to try and create or update documents with a different shape to that which it is expecting, you will get a message that the document has failed validation. Useful!

Summary
In this tutorial, you have learned how to use TypeScript with MongoDB Atlas to add a powerful NoSQL document database to your application, enjoying the benefits of a statically typed language at developer level.

We also used Express to create a Web API to allow for communicating with our database via RESTful calls.

We then added schema validation to our collection at database level, to apply a model across all applications that use our database, not just our own. A database being used by multiple projects is common at the enterprise level, so having this schema applied to your collection could save a lot of bugs and code updates, should anyone try to change something.
