# MongoDB TypeScript Testing Guide

## Table of Contents
1. [Introduction](#introduction)
2. [Setting Up the Testing Environment](#setting-up-the-testing-environment)
3. [Test Configuration](#test-configuration)
4. [Writing Tests](#writing-tests)
5. [Best Practices](#best-practices)
6. [Common Testing Patterns](#common-testing-patterns)

## Introduction

This guide covers comprehensive testing strategies for MongoDB with TypeScript in a Next.js environment. We'll explore how to write effective tests while maintaining type safety and following best practices.

## Setting Up the Testing Environment

### Required Dependencies

```bash
npm install --save-dev jest @types/jest @shelf/jest-mongodb mongodb-memory-server ts-jest
```

### Jest Configuration

Create a `jest.config.js`:

```javascript
module.exports = {
  preset: '@shelf/jest-mongodb',
  transform: {
    '^.+\\.tsx?$': 'ts-jest',
  },
  testEnvironment: 'node',
  moduleFileExtensions: ['ts', 'tsx', 'js', 'jsx', 'json', 'node'],
};
```

## Test Configuration

### Setting Up Test Database

```typescript
// test/setup.ts
import { MongoMemoryServer } from 'mongodb-memory-server';
import mongoose from 'mongoose';

let mongod: MongoMemoryServer;

beforeAll(async () => {
  mongod = await MongoMemoryServer.create();
  const uri = mongod.getUri();
  await mongoose.connect(uri);
});

afterAll(async () => {
  await mongoose.disconnect();
  await mongod.stop();
});

afterEach(async () => {
  const collections = mongoose.connection.collections;
  for (const key in collections) {
    const collection = collections[key];
    await collection.deleteMany({});
  }
});
```

## Writing Tests

### Model Testing

```typescript
// user.test.ts
import { User, IUser } from '../models/User';

describe('User Model Test', () => {
  it('should create & save user successfully', async () => {
    const validUser = {
      name: 'John Doe',
      email: 'john@example.com',
      age: 30,
    };

    const savedUser = await new User(validUser).save();
    expect(savedUser._id).toBeDefined();
    expect(savedUser.name).toBe(validUser.name);
    expect(savedUser.email).toBe(validUser.email);
  });

  it('should fail to save user without required fields', async () => {
    const userWithoutRequiredField = new User({ name: 'John Doe' });
    let err: any;
    try {
      await userWithoutRequiredField.save();
    } catch (error) {
      err = error;
    }
    expect(err).toBeInstanceOf(mongoose.Error.ValidationError);
  });
});
```

### Repository Pattern Testing

```typescript
// userRepository.test.ts
import { UserRepository } from '../repositories/UserRepository';
import { User, IUser } from '../models/User';

describe('UserRepository', () => {
  let userRepository: UserRepository;

  beforeEach(() => {
    userRepository = new UserRepository();
  });

  it('should find user by id', async () => {
    const user = await new User({
      name: 'Test User',
      email: 'test@example.com',
    }).save();

    const foundUser = await userRepository.findById(user._id);
    expect(foundUser).toBeDefined();
    expect(foundUser?.name).toBe('Test User');
  });
});
```

## Best Practices

1. **Isolation**: Each test should run in isolation
   ```typescript
   beforeEach(async () => {
     await User.deleteMany({});
   });
   ```

2. **Type Safety**: Use TypeScript interfaces for test data
   ```typescript
   interface TestUser extends IUser {
     testField?: string;
   }

   const testData: TestUser = {
     name: 'Test User',
     email: 'test@example.com',
     testField: 'test',
   };
   ```

3. **Mocking**: Mock external services and dependencies
   ```typescript
   jest.mock('../services/emailService', () => ({
     sendEmail: jest.fn().mockResolvedValue(true),
   }));
   ```

## Common Testing Patterns

### Testing Transactions

```typescript
describe('Transaction Tests', () => {
  it('should rollback changes on error', async () => {
    const session = await mongoose.startSession();
    session.startTransaction();

    try {
      const user = await User.create([{ 
        name: 'Test User',
        email: 'test@example.com',
      }], { session });

      // Simulate error
      throw new Error('Test Error');

      await session.commitTransaction();
    } catch (error) {
      await session.abortTransaction();
    } finally {
      session.endSession();
    }

    const users = await User.find({});
    expect(users.length).toBe(0);
  });
});
```

### Testing Aggregations

```typescript
describe('Aggregation Tests', () => {
  it('should aggregate user data correctly', async () => {
    await User.insertMany([
      { name: 'User 1', age: 20 },
      { name: 'User 2', age: 30 },
      { name: 'User 3', age: 20 },
    ]);

    const result = await User.aggregate([
      { $group: { _id: '$age', count: { $sum: 1 } } },
      { $sort: { _id: 1 } },
    ]);

    expect(result).toEqual([
      { _id: 20, count: 2 },
      { _id: 30, count: 1 },
    ]);
  });
});
```

### Testing Error Handling

```typescript
describe('Error Handling', () => {
  it('should handle duplicate key errors', async () => {
    const userData = {
      email: 'duplicate@example.com',
      name: 'Test User',
    };

    await new User(userData).save();
    
    let error: any;
    try {
      await new User(userData).save();
    } catch (err) {
      error = err;
    }

    expect(error).toBeDefined();
    expect(error.code).toBe(11000); // MongoDB duplicate key error code
  });
});
```

## Resources

- [Jest Documentation](https://jestjs.io/docs/getting-started)
- [MongoDB Memory Server](https://github.com/nodkz/mongodb-memory-server)
- [Mongoose Documentation](https://mongoosejs.com/docs/)


Integration Testing: Mocking Your MongoDB Database in Node
Ian Rustandi
Ian Rustandi

·
Follow

1 min read
·
Jul 13, 2017
48


3





I was in the process of writing my first test suite on a project. Unit tests for model validation were pretty straight forward, but when it came time to write integration tests, I had a difficult time testing my controllers since they were being called from my backend file (server.js). I’ll discuss what I did to get around this limitation below. The solution I came up with was to add a conditional statement in my server.js to choose the database based on the Node Environment.

In the example below is a simple CRUD-like app that will take a post request, validate it against our mongoose schema, and send a response back to the client. Our goal here for integration testing is to test our controller (literally called someController), which is serving as our Express middleware for the POST request to our specified route and our GET request to our api route.

To be continued…

My setup:

Testing frameworks: Mocha, supertest
Assertion library: Chai
Node/Express
Mongoose/MongoDB

See line 11 for the conditional




Nodejs
Testing Mongoose with Ts-Jest
#
node
#
mongodb
#
typescript
#
jest
If you want to learn MongoDB with mongoose, learning by testing is just for you. In this blog post, I talk about how to install ts-jest , how to create models and fake data using typescript and @faker-js/faker, and how to use jest to test them.

Why testing is important ?
Testing the code that We write makes us aware of the possible problems that occur in the future or gives us an idea about the behavior of the code. For instance, We have a car model and the car model has a field named age.The age field can not be negative. At this point, We need to be sure what happens when the age is a negative value. We give a negative input for the age field to the car model then we expect the car model throws an error in a testing module. So we can be sure if the car model works in line with the purpose before deploying the project.

What is jest?
Jest is a javascript testing framework. I will test all models by using jest. The reason I use the jest framework is that it requires minimum configuration for testing.

Creating the project and installing the packages
Creating the package.json



npm init -y


I will use ts-jest package in this blog post beacause ts-jest lets me use jest to test projects written in typescript.

Installing the packages.



npm install -D jest typescript ts-jest @types/jest ts-node @types/node


While installing mongoose we don't need the @types/mongoose because the mongoose package has built-in Typescript declarations.



npm install mongoose


Giving data to inputs by myself is hard so I install the @faker-js/faker package. @faker-js/faker helps me create random data for the models.



npm install -D @faker-js/faker


Creating tsconfig.json



tsc --init


Changing properties in tsconfig.json for the project



 "rootDir": "./src",
 "moduleResolution": "node",
 "baseUrl": ".",
 "outDir": "./build",


Adding include and exclude sides in tsconfig.json.



"include": ["src/**/*.ts"],
"exclude": ["node_modules","build"]


Creating config file for testing


npx ts-jest config:init


After that, You could see jest.config.js in the project folder. And that's it. We are ready to go.

Project Structure
I create two main folders named src and test because I accept this project as a real one. Model files will be in models folder in the src but tests of the models will be in the test.

Connecting the MongoDB
I Create the connectDBForTesting.ts in the test folder. My MongoDB runs on localhost:27018 if you have different options you could add or change connection options while you connect to MongoDB.



touch test/connectDBForTesting.ts


test/connectDBForTesting.ts



import mongoose from "mongoose";

export async function connectDBForTesting() {
  try {
    const dbUri = "mongodb://localhost:27018";
    const dbName = "test";
    await mongoose.connect(dbUri, {
      dbName,
      autoCreate: true,
    });
  } catch (error) {
    console.log("DB connect error");
  }
}

export async function disconnectDBForTesting() {
  try {
    await mongoose.connection.close();
  } catch (error) {
    console.log("DB disconnect error");
  }
}


Creating mongoose model
Models in mongoose are used for creating, reading, deleting, and updating the Documents from the MongoDB database. Let's create and test a Person model.



touch src/models/person.model.ts


src/models/person.model.ts



import mongoose, { Types, Schema, Document } from "mongoose";

export interface PersonInput {
  name: string;
  lastName: string;
  address: string;
  gender: string;
  job: string;
  age: number;
}

export interface PersonDocument extends PersonInput, Document {
  updatedAt: Date;
  createdAt: Date;
}

const PersonSchema = new mongoose.Schema<PersonDocument>(
  {
    name: { type: String, required: [true, "name required"] },
    lastName: { type: String },
    address: { type: String, required: [true, "address required"] },
    gender: { type: String, required: [true, "gender is required"] },
    job: { type: String },
    age: { type: Number, min: [18, "age must be adult"] },
  },
  {
    timestamps: true, // to create updatedAt and createdAt
  }
);

const personModel = mongoose.model("Person", PersonSchema);
export default personModel;


We have 2 important things here, PersonInput and PersonDocument interfaces. The PersonInput interface is used to create the personModel and the PersonDocument interface describes the object that is returned by the personModel. You will see clearly in the test section of the personModel.

Creating test for the personModel


touch test/person.model.test.ts


test/person.model.test.ts



import {
  connectDBForTesting,
  disconnectDBForTesting,
} from "../connectDBForTesting";

import personModel, {
  PersonDocument,
  PersonInput,
} from "../../src/models/person.model";
import faker from "@faker-js/faker";
describe("personModel Testing", () => {
  beforeAll(async () => {
    await connectDBForTesting();
  });

  afterAll(async () => {
    await personModel.collection.drop();
    await disconnectDBForTesting();
  });
});


First of all, the describe creates a block that includes test sections. You can add some global objects in the describe block to use them.

beforeAll runs a function before all tests in the describe block run. In the beforeAll, I connect the MongoDB server.

afterAll runs a function after all tests in the describe block have complated. In the afterAll, I disconnect the MongoDB server and drop the personModel collection.

PersonModel Create Test


test("personModel Create Test", async () => {
  const personInput: PersonInput = {
    name: faker.name.findName(),
    lastName: faker.name.lastName(),
    age: faker.datatype.number({ min: 18, max: 50 }),
    address: faker.address.streetAddress(),
    gender: faker.name.gender(),
    job: faker.name.jobTitle(),
  };
  const person = new personModel({ ...personInput });
  const createdPerson = await person.save();
  expect(createdPerson).toBeDefined();
  expect(createdPerson.name).toBe(person.name);
  expect(createdPerson.lastName).toBe(person.lastName);
  expect(createdPerson.age).toBe(person.age);
  expect(createdPerson.address).toBe(person.address);
  expect(createdPerson.gender).toBe(person.gender);
  expect(createdPerson.job).toBe(person.job);
});


Note : When a new personModel is declared it returns a PersonDocument type object. So I can use the mongoose.Document properties, validates, and middlewares.

I create a person object using personInput. The person.save() method inserts a new document into the database and return PersonDocument type object.

expect checks if the given data matches the certain conditions or not. If the given data matches the certain conditions the test passes. If not so, the test fails.

The last state of the test/models/person.model.test.ts


import {
  connectDBForTesting,
  disconnectDBForTesting,
} from "../connectDBForTesting";

import personModel, {
  PersonDocument,
  PersonInput,
} from "../../src/models/person.model";
import faker from "@faker-js/faker";
describe("personModel Testing", () => {
  beforeAll(async () => {
    await connectDBForTesting();
  });
  afterAll(async () => {
    await personModel.collection.drop();
    await disconnectDBForTesting();
  });

  test("personModel Create Test", async () => {
    const personInput: PersonInput = {
      name: faker.name.findName(),
      lastName: faker.name.lastName(),
      age: faker.datatype.number({ min: 18, max: 50 }),
      address: faker.address.streetAddress(),
      gender: faker.name.gender(),
      job: faker.name.jobTitle(),
    };
    const person = new personModel({ ...personInput });
    const createdPerson = await person.save();
    expect(createdPerson).toBeDefined();
    expect(createdPerson.name).toBe(person.name);
    expect(createdPerson.lastName).toBe(person.lastName);
    expect(createdPerson.age).toBe(person.age);
    expect(createdPerson.address).toBe(person.address);
    expect(createdPerson.gender).toBe(person.gender);
    expect(createdPerson.job).toBe(person.job);
  });
});


Running the jest
I add a command to the scripts in package.json to run the jest.



"scripts": {
    "test": "npx jest --coverage "
  },


coverage options indicates that test coverage information should be collected and reported in the output. But you can ignore it.

I run the test.



npm run test


The test result

result of the test

To see what happens when a test fails I change a expect side with a wrong data on purpose.



expect(createdPerson.job).toBe(person.name);


The result of the test failing

The result of the test failing

The reason the test fails is that the jest expects the createdPerson.job and createdPerson.name to have the same data.

PersonModel Read Test


test("personModel Read Test", async () => {
  const personInput: PersonInput = {
    name: faker.name.findName(),
    lastName: faker.name.lastName(),
    age: faker.datatype.number({ min: 18, max: 50 }),
    address: faker.address.streetAddress(),
    gender: faker.name.gender(),
    job: faker.name.jobTitle(),
  };
  const person = new personModel({ ...personInput });
  await person.save();
  const fetchedPerson = await personModel.findOne({ _id: person._id });
  expect(fetchedPerson).toBeDefined();
  expect(fetchedPerson).toMatchObject(personInput);
});


I create a personModel and save it then fetch the person by _id. The fetchedPerson has to be defined and its properties have to be the same as the personInput has. I can check if the fetchPerson properties match the personInput properties using the expect.tobe() one by one but using expect.toMatchObject() is a little bit more easy.

expect.toMatchObject() checks if a received javascript object matches the properties of an expected javascript object.

Something is missing
For the each test, I created person model over and over again.It was not much efficient Therefore I declare the personInput and personModel top of the describe.



describe("personModel Testing", () => {}
const personInput: PersonInput = {
    name: faker.name.findName(),
    lastName: faker.name.lastName(),
    age: faker.datatype.number({ min: 18, max: 50 }),
    address: faker.address.streetAddress(),
    gender: faker.name.gender(),
    job: faker.name.jobTitle(),
  };
  const person = new personModel({ ...personInput });
)


So I can use the personInput and person objects in all tests.

PersonModel Update Test


test("personModel Update Test", async () => {
  const personUpdateInput: PersonInput = {
    name: faker.name.findName(),
    lastName: faker.name.lastName(),
    age: faker.datatype.number({ min: 18, max: 50 }),
    address: faker.address.streetAddress(),
    gender: faker.name.gender(),
    job: faker.name.jobTitle(),
  };
  await personModel.updateOne({ _id: person._id }, { ...personUpdateInput });
  const fetchedPerson = await personModel.findOne({ _id: person._id });
  expect(fetchedPerson).toBeDefined();
  expect(fetchedPerson).toMatchObject(personUpdateInput);
  expect(fetchedPerson).not.toMatchObject(personInput);
});


Even if I use the same schema, I can create personUpdateInput that is different from personInput because @faker-js/faker creates data randomly. The properties of fetchedPerson is expected to match the personUpdateInput at the same time is expect to not match the personInput.

PersonModel Delete Test


test("personModel Delete Test", async () => {
  await personModel.deleteOne({ _id: person._id });
  const fetchedPerson = await personModel.findOne({ _id: person._id });
  expect(fetchedPerson).toBeNull();
});


I delete a mongoose document by using person._id. After that, The fetchedPerson fetched from MongoDB by using is expected to be null.

The last State of the test/models/person.model.test.ts


import {

  connectDBForTesting,

  disconnectDBForTesting,

} from "../connectDBForTesting";



import personModel, {

  PersonDocument,

  PersonInput,

} from "../../src/models/person.model";

import faker from "@faker-js/faker";

describe("personModel Testing", () => {

  const personInput: PersonInput = {

    name: faker.name.findName(),

    lastName: faker.name.lastName(),

    age: faker.datatype.number({ min: 18, max: 50 }),

    address: faker.address.streetAddress(),

    gender: faker.name.gender(),

    job: faker.name.jobTitle(),

  };

  const person = new personModel({ ...personInput });



beforeAll(async () => {

    await connectDBForTesting();

  });

  afterAll(async () => {

    await personModel.collection.drop();

    await disconnectDBForTesting();

  });



test("personModel Create Test", async () => {

    const createdPerson = await person.save();

    expect(createdPerson).toBeDefined();

    expect(createdPerson.name).toBe(person.name);

    expect(createdPerson.lastName).toBe(person.lastName);

    expect(createdPerson.age).toBe(person.age);

    expect(createdPerson.address).toBe(person.address);

    expect(createdPerson.gender).toBe(person.gender);

    expect(createdPerson.job).toBe(person.job);

  });



test("personModel Read Test", async () => {

    const fetchedPerson = await personModel.findOne({ _id: person._id });

    expect(fetchedPerson).toBeDefined();

    expect(fetchedPerson).toMatchObject(personInput);

  });

  test("personModel Update Test", async () => {

    const personUpdateInput: PersonInput = {

      name: faker.name.findName(),

      lastName: faker.name.lastName(),

      age: faker.datatype.number({ min: 18, max: 50 }),

      address: faker.address.streetAddress(),

      gender: faker.name.gender(),

      job: faker.name.jobTitle(),

    };

    await personModel.updateOne({ _id: person._id }, { ...personUpdateInput });

    const fetchedPerson = await personModel.findOne({ _id: person._id });

    expect(fetchedPerson).toBeDefined();

    expect(fetchedPerson).toMatchObject(personUpdateInput);

    expect(fetchedPerson).not.toMatchObject(personInput);

  });



test("personModel Delete Test", async () => {

    await personModel.deleteOne({ _id: person._id });

    const fetchedPerson = await personModel.findOne({ _id: person._id });

    expect(fetchedPerson).toBeNull();

  });

});






Testing all



npm run test






Result
Result
That's it. This is usually how to test mongoose models:

create a mongoose model.
create a test for the mongoose model.
apply the CRUD operations for the mongoose model in test sections.
if test fails, try to find out and solve the problem.
if the all tests pass, you are ready to go.
Sources:

https://jestjs.io/docs/getting-started
https://www.youtube.com/watch?v=TbT7eO1fxuI
https://mongoosejs.com/docs/guide.html
https://kulshekhar.github.io/ts-jest/
Contact me:

Linkedin

twitter

github

Github Repo: https://github.com/pandashavenobugs/testing-mongoose-with-tsjest-blogpost
Schemas

If you haven't yet done so, please take a minute to read the quickstart to get an idea of how Mongoose works. If you are migrating from 7.x to 8.x please take a moment to read the migration guide.

Defining your schema
Creating a model
Ids
Instance methods
Statics
Query Helpers
Indexes
Virtuals
Aliases
Options
With ES6 Classes
Pluggable
Further Reading
Defining your schema
Everything in Mongoose starts with a Schema. Each schema maps to a MongoDB collection and defines the shape of the documents within that collection.

import mongoose from 'mongoose';
const { Schema } = mongoose;

const blogSchema = new Schema({
  title: String, // String is shorthand for {type: String}
  author: String,
  body: String,
  comments: [{ body: String, date: Date }],
  date: { type: Date, default: Date.now },
  hidden: Boolean,
  meta: {
    votes: Number,
    favs: Number
  }
});
If you want to add additional keys later, use the Schema#add method.

Each key in our code blogSchema defines a property in our documents which will be cast to its associated SchemaType. For example, we've defined a property title which will be cast to the String SchemaType and property date which will be cast to a Date SchemaType.

Notice above that if a property only requires a type, it can be specified using a shorthand notation (contrast the title property above with the date property).

Keys may also be assigned nested objects containing further key/type definitions like the meta property above. This will happen whenever a key's value is a POJO that doesn't have a type property.

In these cases, Mongoose only creates actual schema paths for leaves in the tree. (like meta.votes and meta.favs above), and the branches do not have actual paths. A side-effect of this is that meta above cannot have its own validation. If validation is needed up the tree, a path needs to be created up the tree - see the Subdocuments section for more information on how to do this. Also read the Mixed subsection of the SchemaTypes guide for some gotchas.

The permitted SchemaTypes are:

String
Number
Date
Buffer
Boolean
Mixed
ObjectId
Array
Decimal128
Map
UUID
Double
Int32
Read more about SchemaTypes here.

Schemas not only define the structure of your document and casting of properties, they also define document instance methods, static Model methods, compound indexes, and document lifecycle hooks called middleware.

Creating a model
To use our schema definition, we need to convert our blogSchema into a Model we can work with. To do so, we pass it into mongoose.model(modelName, schema):

const Blog = mongoose.model('Blog', blogSchema);
// ready to go!
Ids
By default, Mongoose adds an _id property to your schemas.

const schema = new Schema();

schema.path('_id'); // ObjectId { ... }
When you create a new document with the automatically added _id property, Mongoose creates a new _id of type ObjectId to your document.

const Model = mongoose.model('Test', schema);

const doc = new Model();
doc._id instanceof mongoose.Types.ObjectId; // true
You can also overwrite Mongoose's default _id with your own _id. Just be careful: Mongoose will refuse to save a top-level document that doesn't have an _id, so you're responsible for setting _id if you define your own _id path.

const schema = new Schema({
  _id: Number // <-- overwrite Mongoose's default `_id`
});
const Model = mongoose.model('Test', schema);

const doc = new Model();
await doc.save(); // Throws "document must have an _id before saving"

doc._id = 1;
await doc.save(); // works
Mongoose also adds an _id property to subdocuments. You can disable the _id property on your subdocuments as follows. Mongoose does allow saving subdocuments without an _id property.

const nestedSchema = new Schema(
  { name: String },
  { _id: false } // <-- disable `_id`
);
const schema = new Schema({
  subdoc: nestedSchema,
  docArray: [nestedSchema]
});
const Test = mongoose.model('Test', schema);

// Neither `subdoc` nor `docArray.0` will have an `_id`
await Test.create({
  subdoc: { name: 'test 1' },
  docArray: [{ name: 'test 2' }]
});
Alternatively, you can disable _id using the following syntax:

const nestedSchema = new Schema({
  _id: false, // <-- disable _id
  name: String
});
Instance methods
Instances of Models are documents. Documents have many of their own built-in instance methods. We may also define our own custom document instance methods.

// define a schema
const animalSchema = new Schema({ name: String, type: String },
  {
  // Assign a function to the "methods" object of our animalSchema through schema options.
  // By following this approach, there is no need to create a separate TS type to define the type of the instance functions.
    methods: {
      findSimilarTypes(cb) {
        return mongoose.model('Animal').find({ type: this.type }, cb);
      }
    }
  });

// Or, assign a function to the "methods" object of our animalSchema
animalSchema.methods.findSimilarTypes = function(cb) {
  return mongoose.model('Animal').find({ type: this.type }, cb);
};
Now all of our animal instances have a findSimilarTypes method available to them.

const Animal = mongoose.model('Animal', animalSchema);
const dog = new Animal({ type: 'dog' });

dog.findSimilarTypes((err, dogs) => {
  console.log(dogs); // woof
});
Overwriting a default mongoose document method may lead to unpredictable results. See this for more details.
The example above uses the Schema.methods object directly to save an instance method. You can also use the Schema.method() helper as described here.
Do not declare methods using ES6 arrow functions (=>). Arrow functions explicitly prevent binding this, so your method will not have access to the document and the above examples will not work.
Statics
You can also add static functions to your model. There are three equivalent ways to add a static:

Add a function property to the second argument of the schema-constructor (statics)
Add a function property to schema.statics
Call the Schema#static() function

// define a schema
const animalSchema = new Schema({ name: String, type: String },
  {
  // Assign a function to the "statics" object of our animalSchema through schema options.
  // By following this approach, there is no need to create a separate TS type to define the type of the statics functions.
    statics: {
      findByName(name) {
        return this.find({ name: new RegExp(name, 'i') });
      }
    }
  });

// Or, Assign a function to the "statics" object of our animalSchema
animalSchema.statics.findByName = function(name) {
  return this.find({ name: new RegExp(name, 'i') });
};
// Or, equivalently, you can call `animalSchema.static()`.
animalSchema.static('findByBreed', function(breed) { return this.find({ breed }); });

const Animal = mongoose.model('Animal', animalSchema);
let animals = await Animal.findByName('fido');
animals = animals.concat(await Animal.findByBreed('Poodle'));
Do not declare statics using ES6 arrow functions (=>). Arrow functions explicitly prevent binding this, so the above examples will not work because of the value of this.

Query Helpers
You can also add query helper functions, which are like instance methods but for mongoose queries. Query helper methods let you extend mongoose's chainable query builder API.


// define a schema
const animalSchema = new Schema({ name: String, type: String },
  {
  // Assign a function to the "query" object of our animalSchema through schema options.
  // By following this approach, there is no need to create a separate TS type to define the type of the query functions.
    query: {
      byName(name) {
        return this.where({ name: new RegExp(name, 'i') });
      }
    }
  });

// Or, Assign a function to the "query" object of our animalSchema
animalSchema.query.byName = function(name) {
  return this.where({ name: new RegExp(name, 'i') });
};

const Animal = mongoose.model('Animal', animalSchema);

Animal.find().byName('fido').exec((err, animals) => {
  console.log(animals);
});

Animal.findOne().byName('fido').exec((err, animal) => {
  console.log(animal);
});
Indexes
MongoDB supports secondary indexes. With mongoose, we define these indexes within our Schema at the path level or the schema level. Defining indexes at the schema level is necessary when creating compound indexes.

const animalSchema = new Schema({
  name: String,
  type: String,
  tags: { type: [String], index: true } // path level
});

animalSchema.index({ name: 1, type: -1 }); // schema level
See SchemaType#index() for other index options.

When your application starts up, Mongoose automatically calls createIndex for each defined index in your schema. Mongoose will call createIndex for each index sequentially, and emit an 'index' event on the model when all the createIndex calls succeeded or when there was an error. While nice for development, it is recommended this behavior be disabled in production since index creation can cause a significant performance impact. Disable the behavior by setting the autoIndex option of your schema to false, or globally on the connection by setting the option autoIndex to false.

mongoose.connect('mongodb://user:pass@127.0.0.1:port/database', { autoIndex: false });
// or
mongoose.createConnection('mongodb://user:pass@127.0.0.1:port/database', { autoIndex: false });
// or
mongoose.set('autoIndex', false);
// or
animalSchema.set('autoIndex', false);
// or
new Schema({ /* ... */ }, { autoIndex: false });
Mongoose will emit an index event on the model when indexes are done building or an error occurred.

// Will cause an error because mongodb has an _id index by default that
// is not sparse
animalSchema.index({ _id: 1 }, { sparse: true });
const Animal = mongoose.model('Animal', animalSchema);

Animal.on('index', error => {
  // "_id index cannot be sparse"
  console.log(error.message);
});
See also the Model#ensureIndexes method.

Virtuals
Virtuals are document properties that you can get and set but that do not get persisted to MongoDB. The getters are useful for formatting or combining fields, while setters are useful for de-composing a single value into multiple values for storage.

// define a schema
const personSchema = new Schema({
  name: {
    first: String,
    last: String
  }
});

// compile our model
const Person = mongoose.model('Person', personSchema);

// create a document
const axl = new Person({
  name: { first: 'Axl', last: 'Rose' }
});
Suppose you want to print out the person's full name. You could do it yourself:

console.log(axl.name.first + ' ' + axl.name.last); // Axl Rose
But concatenating the first and last name every time can get cumbersome. And what if you want to do some extra processing on the name, like removing diacritics? A virtual property getter lets you define a fullName property that won't get persisted to MongoDB.

// That can be done either by adding it to schema options:
const personSchema = new Schema({
  name: {
    first: String,
    last: String
  }
}, {
  virtuals: {
    fullName: {
      get() {
        return this.name.first + ' ' + this.name.last;
      }
    }
  }
});

// Or by using the virtual method as following:
personSchema.virtual('fullName').get(function() {
  return this.name.first + ' ' + this.name.last;
});
Now, mongoose will call your getter function every time you access the fullName property:

console.log(axl.fullName); // Axl Rose
If you use toJSON() or toObject() Mongoose will not include virtuals by default. Pass { virtuals: true } to toJSON() or toObject() to include virtuals.

// Convert `doc` to a POJO, with virtuals attached
doc.toObject({ virtuals: true });

// Equivalent:
doc.toJSON({ virtuals: true });
The above caveat for toJSON() also includes the output of calling JSON.stringify() on a Mongoose document, because JSON.stringify() calls toJSON(). To include virtuals in JSON.stringify() output, you can either call toObject({ virtuals: true }) on the document before calling JSON.stringify(), or set the toJSON: { virtuals: true } option on your schema.

// Explicitly add virtuals to `JSON.stringify()` output
JSON.stringify(doc.toObject({ virtuals: true }));

// Or, to automatically attach virtuals to `JSON.stringify()` output:
const personSchema = new Schema({
  name: {
    first: String,
    last: String
  }
}, {
  toJSON: { virtuals: true } // <-- include virtuals in `JSON.stringify()`
});
You can also add a custom setter to your virtual that will let you set both first name and last name via the fullName virtual.

// Again that can be done either by adding it to schema options:
const personSchema = new Schema({
  name: {
    first: String,
    last: String
  }
}, {
  virtuals: {
    fullName: {
      get() {
        return this.name.first + ' ' + this.name.last;
      },
      set(v) {
        this.name.first = v.substr(0, v.indexOf(' '));
        this.name.last = v.substr(v.indexOf(' ') + 1);
      }
    }
  }
});

// Or by using the virtual method as following:
personSchema.virtual('fullName').
  get(function() {
    return this.name.first + ' ' + this.name.last;
  }).
  set(function(v) {
    this.name.first = v.substr(0, v.indexOf(' '));
    this.name.last = v.substr(v.indexOf(' ') + 1);
  });

axl.fullName = 'William Rose'; // Now `axl.name.first` is "William"
Virtual property setters are applied before other validation. So the example above would still work even if the first and last name fields were required.

Only non-virtual properties work as part of queries and for field selection. Since virtuals are not stored in MongoDB, you can't query with them.

You can learn more about virtuals here.

Aliases
Aliases are a particular type of virtual where the getter and setter seamlessly get and set another property. This is handy for saving network bandwidth, so you can convert a short property name stored in the database into a longer name for code readability.

const personSchema = new Schema({
  n: {
    type: String,
    // Now accessing `name` will get you the value of `n`, and setting `name` will set the value of `n`
    alias: 'name'
  }
});

// Setting `name` will propagate to `n`
const person = new Person({ name: 'Val' });
console.log(person); // { n: 'Val' }
console.log(person.toObject({ virtuals: true })); // { n: 'Val', name: 'Val' }
console.log(person.name); // "Val"

person.name = 'Not Val';
console.log(person); // { n: 'Not Val' }
You can also declare aliases on nested paths. It is easier to use nested schemas and subdocuments, but you can also declare nested path aliases inline as long as you use the full nested path nested.myProp as the alias.

const childSchema = new Schema({
  n: {
    type: String,
    alias: 'name'
  }
}, { _id: false });

const parentSchema = new Schema({
  // If in a child schema, alias doesn't need to include the full nested path
  c: childSchema,
  name: {
    f: {
      type: String,
      // Alias needs to include the full nested path if declared inline
      alias: 'name.first'
    }
  }
});
Options
Schemas have a few configurable options which can be passed to the constructor or to the set method:

new Schema({ /* ... */ }, options);

// or

const schema = new Schema({ /* ... */ });
schema.set(option, value);
Valid options:

autoIndex
autoCreate
bufferCommands
bufferTimeoutMS
capped
collection
discriminatorKey
excludeIndexes
id
_id
minimize
read
writeConcern
shardKey
statics
strict
strictQuery
toJSON
toObject
typeKey
validateBeforeSave
versionKey
optimisticConcurrency
collation
timeseries
selectPopulatedPaths
skipVersioning
timestamps
storeSubdocValidationError
collectionOptions
methods
query
autoSearchIndex
readConcern
option: autoIndex
By default, Mongoose's init() function creates all the indexes defined in your model's schema by calling Model.createIndexes() after you successfully connect to MongoDB. Creating indexes automatically is great for development and test environments. But index builds can also create significant load on your production database. If you want to manage indexes carefully in production, you can set autoIndex to false.

const schema = new Schema({ /* ... */ }, { autoIndex: false });
const Clock = mongoose.model('Clock', schema);
Clock.ensureIndexes(callback);
The autoIndex option is set to true by default. You can change this default by setting mongoose.set('autoIndex', false);

option: autoCreate
Before Mongoose builds indexes, it calls Model.createCollection() to create the underlying collection in MongoDB by default. Calling createCollection() sets the collection's default collation based on the collation option and establishes the collection as a capped collection if you set the capped schema option.

You can disable this behavior by setting autoCreate to false using mongoose.set('autoCreate', false). Like autoIndex, autoCreate is helpful for development and test environments, but you may want to disable it for production to avoid unnecessary database calls.

Unfortunately, createCollection() cannot change an existing collection. For example, if you add capped: { size: 1024 } to your schema and the existing collection is not capped, createCollection() will not overwrite the existing collection. That is because the MongoDB server does not allow changing a collection's options without dropping the collection first.

const schema = new Schema({ name: String }, {
  autoCreate: false,
  capped: { size: 1024 }
});
const Test = mongoose.model('Test', schema);

// No-op if collection already exists, even if the collection is not capped.
// This means that `capped` won't be applied if the 'tests' collection already exists.
await Test.createCollection();
option: bufferCommands
By default, mongoose buffers commands when the connection goes down until the driver manages to reconnect. To disable buffering, set bufferCommands to false.

const schema = new Schema({ /* ... */ }, { bufferCommands: false });
The schema bufferCommands option overrides the global bufferCommands option.

mongoose.set('bufferCommands', true);
// Schema option below overrides the above, if the schema option is set.
const schema = new Schema({ /* ... */ }, { bufferCommands: false });
option: bufferTimeoutMS
If bufferCommands is on, this option sets the maximum amount of time Mongoose buffering will wait before throwing an error. If not specified, Mongoose will use 10000 (10 seconds).

// If an operation is buffered for more than 1 second, throw an error.
const schema = new Schema({ /* ... */ }, { bufferTimeoutMS: 1000 });
option: capped
Mongoose supports MongoDBs capped collections. To specify the underlying MongoDB collection be capped, set the capped option to the maximum size of the collection in bytes.

new Schema({ /* ... */ }, { capped: 1024 });
The capped option may also be set to an object if you want to pass additional options like max. In this case you must explicitly pass the size option, which is required.

new Schema({ /* ... */ }, { capped: { size: 1024, max: 1000, autoIndexId: true } });
option: collection
Mongoose by default produces a collection name by passing the model name to the utils.toCollectionName method. This method pluralizes the name. Set this option if you need a different name for your collection.

const dataSchema = new Schema({ /* ... */ }, { collection: 'data' });
option: discriminatorKey
When you define a discriminator, Mongoose adds a path to your schema that stores which discriminator a document is an instance of. By default, Mongoose adds an __t path, but you can set discriminatorKey to overwrite this default.

const baseSchema = new Schema({}, { discriminatorKey: 'type' });
const BaseModel = mongoose.model('Test', baseSchema);

const personSchema = new Schema({ name: String });
const PersonModel = BaseModel.discriminator('Person', personSchema);

const doc = new PersonModel({ name: 'James T. Kirk' });
// Without `discriminatorKey`, Mongoose would store the discriminator
// key in `__t` instead of `type`
doc.type; // 'Person'
option: excludeIndexes
When excludeIndexes is true, Mongoose will not create indexes from the given subdocument schema. This option only works when the schema is used in a subdocument path or document array path, Mongoose ignores this option if set on the top-level schema for a model. Defaults to false.

const childSchema1 = Schema({
  name: { type: String, index: true }
});

const childSchema2 = Schema({
  name: { type: String, index: true }
}, { excludeIndexes: true });

// Mongoose will create an index on `child1.name`, but **not** `child2.name`, because `excludeIndexes`
// is true on `childSchema2`
const User = new Schema({
  name: { type: String, index: true },
  child1: childSchema1,
  child2: childSchema2
});
option: id
Mongoose assigns each of your schemas an id virtual getter by default which returns the document's _id field cast to a string, or in the case of ObjectIds, its hexString. If you don't want an id getter added to your schema, you may disable it by passing this option at schema construction time.

// default behavior
const schema = new Schema({ name: String });
const Page = mongoose.model('Page', schema);
const p = new Page({ name: 'mongodb.org' });
console.log(p.id); // '50341373e894ad16347efe01'

// disabled id
const schema = new Schema({ name: String }, { id: false });
const Page = mongoose.model('Page', schema);
const p = new Page({ name: 'mongodb.org' });
console.log(p.id); // undefined
option: _id
Mongoose assigns each of your schemas an _id field by default if one is not passed into the Schema constructor. The type assigned is an ObjectId to coincide with MongoDB's default behavior. If you don't want an _id added to your schema at all, you may disable it using this option.

You can only use this option on subdocuments. Mongoose can't save a document without knowing its id, so you will get an error if you try to save a document without an _id.

// default behavior
const schema = new Schema({ name: String });
const Page = mongoose.model('Page', schema);
const p = new Page({ name: 'mongodb.org' });
console.log(p); // { _id: '50341373e894ad16347efe01', name: 'mongodb.org' }

// disabled _id
const childSchema = new Schema({ name: String }, { _id: false });
const parentSchema = new Schema({ children: [childSchema] });

const Model = mongoose.model('Model', parentSchema);

Model.create({ children: [{ name: 'Luke' }] }, (error, doc) => {
  // doc.children[0]._id will be undefined
});
option: minimize
Mongoose will, by default, "minimize" schemas by removing empty objects.

const schema = new Schema({ name: String, inventory: {} });
const Character = mongoose.model('Character', schema);

// will store `inventory` field if it is not empty
const frodo = new Character({ name: 'Frodo', inventory: { ringOfPower: 1 } });
await frodo.save();
let doc = await Character.findOne({ name: 'Frodo' }).lean();
doc.inventory; // { ringOfPower: 1 }

// will not store `inventory` field if it is empty
const sam = new Character({ name: 'Sam', inventory: {} });
await sam.save();
doc = await Character.findOne({ name: 'Sam' }).lean();
doc.inventory; // undefined
This behavior can be overridden by setting minimize option to false. It will then store empty objects.

const schema = new Schema({ name: String, inventory: {} }, { minimize: false });
const Character = mongoose.model('Character', schema);

// will store `inventory` if empty
const sam = new Character({ name: 'Sam', inventory: {} });
await sam.save();
doc = await Character.findOne({ name: 'Sam' }).lean();
doc.inventory; // {}
To check whether an object is empty, you can use the $isEmpty() helper:

const sam = new Character({ name: 'Sam', inventory: {} });
sam.$isEmpty('inventory'); // true

sam.inventory.barrowBlade = 1;
sam.$isEmpty('inventory'); // false
option: read
Allows setting query#read options at the schema level, providing us a way to apply default ReadPreferences to all queries derived from a model.

const schema = new Schema({ /* ... */ }, { read: 'primary' });            // also aliased as 'p'
const schema = new Schema({ /* ... */ }, { read: 'primaryPreferred' });   // aliased as 'pp'
const schema = new Schema({ /* ... */ }, { read: 'secondary' });          // aliased as 's'
const schema = new Schema({ /* ... */ }, { read: 'secondaryPreferred' }); // aliased as 'sp'
const schema = new Schema({ /* ... */ }, { read: 'nearest' });            // aliased as 'n'
The alias of each pref is also permitted so instead of having to type out 'secondaryPreferred' and getting the spelling wrong, we can simply pass 'sp'.

The read option also allows us to specify tag sets. These tell the driver from which members of the replica-set it should attempt to read. Read more about tag sets here and here.

NOTE: you may also specify the driver read preference strategy option when connecting:

// pings the replset members periodically to track network latency
const options = { replset: { strategy: 'ping' } };
mongoose.connect(uri, options);

const schema = new Schema({ /* ... */ }, { read: ['nearest', { disk: 'ssd' }] });
mongoose.model('JellyBean', schema);
option: writeConcern
Allows setting write concern at the schema level.

const schema = new Schema({ name: String }, {
  writeConcern: {
    w: 'majority',
    j: true,
    wtimeout: 1000
  }
});
option: shardKey
The shardKey option is used when we have a sharded MongoDB architecture. Each sharded collection is given a shard key which must be present in all insert/update operations. We just need to set this schema option to the same shard key and we’ll be all set.

new Schema({ /* ... */ }, { shardKey: { tag: 1, name: 1 } });
Note that Mongoose does not send the shardcollection command for you. You must configure your shards yourself.

option: strict
The strict option, (enabled by default), ensures that values passed to our model constructor that were not specified in our schema do not get saved to the db.

const thingSchema = new Schema({ /* ... */ })
const Thing = mongoose.model('Thing', thingSchema);
const thing = new Thing({ iAmNotInTheSchema: true });
thing.save(); // iAmNotInTheSchema is not saved to the db

// set to false..
const thingSchema = new Schema({ /* ... */ }, { strict: false });
const thing = new Thing({ iAmNotInTheSchema: true });
thing.save(); // iAmNotInTheSchema is now saved to the db!!
This also affects the use of doc.set() to set a property value.

const thingSchema = new Schema({ /* ... */ });
const Thing = mongoose.model('Thing', thingSchema);
const thing = new Thing;
thing.set('iAmNotInTheSchema', true);
thing.save(); // iAmNotInTheSchema is not saved to the db
This value can be overridden at the model instance level by passing a second boolean argument:

const Thing = mongoose.model('Thing');
const thing = new Thing(doc, true);  // enables strict mode
const thing = new Thing(doc, false); // disables strict mode
The strict option may also be set to "throw" which will cause errors to be produced instead of dropping the bad data.

NOTE: Any key/val set on the instance that does not exist in your schema is always ignored, regardless of schema option.

const thingSchema = new Schema({ /* ... */ });
const Thing = mongoose.model('Thing', thingSchema);
const thing = new Thing;
thing.iAmNotInTheSchema = true;
thing.save(); // iAmNotInTheSchema is never saved to the db
option: strictQuery
Mongoose supports a separate strictQuery option to avoid strict mode for query filters. This is because empty query filters cause Mongoose to return all documents in the model, which can cause issues.

const mySchema = new Schema({ field: Number }, { strict: true });
const MyModel = mongoose.model('Test', mySchema);
// Mongoose will filter out `notInSchema: 1` because `strict: true`, meaning this query will return
// _all_ documents in the 'tests' collection
MyModel.find({ notInSchema: 1 });
The strict option does apply to updates. The strictQuery option is just for query filters.

// Mongoose will strip out `notInSchema` from the update if `strict` is
// not `false`
MyModel.updateMany({}, { $set: { notInSchema: 1 } });
Mongoose has a separate strictQuery option to toggle strict mode for the filter parameter to queries.

const mySchema = new Schema({ field: Number }, {
  strict: true,
  strictQuery: false // Turn off strict mode for query filters
});
const MyModel = mongoose.model('Test', mySchema);
// Mongoose will not strip out `notInSchema: 1` because `strictQuery` is false
MyModel.find({ notInSchema: 1 });
In general, we do not recommend passing user-defined objects as query filters:

// Don't do this!
const docs = await MyModel.find(req.query);

// Do this instead:
const docs = await MyModel.find({ name: req.query.name, age: req.query.age }).setOptions({ sanitizeFilter: true });
In Mongoose 7, strictQuery is false by default. However, you can override this behavior globally:

// Set `strictQuery` to `true` to omit unknown fields in queries.
mongoose.set('strictQuery', true);
option: toJSON
Exactly the same as the toObject option but only applies when the document's toJSON method is called.

const schema = new Schema({ name: String });
schema.path('name').get(function(v) {
  return v + ' is my name';
});
schema.set('toJSON', { getters: true, virtuals: false });
const M = mongoose.model('Person', schema);
const m = new M({ name: 'Max Headroom' });
console.log(m.toObject()); // { _id: 504e0cd7dd992d9be2f20b6f, name: 'Max Headroom' }
console.log(m.toJSON()); // { _id: 504e0cd7dd992d9be2f20b6f, name: 'Max Headroom is my name' }
// since we know toJSON is called whenever a js object is stringified:
console.log(JSON.stringify(m)); // { "_id": "504e0cd7dd992d9be2f20b6f", "name": "Max Headroom is my name" }
To see all available toJSON/toObject options, read this.

option: toObject
Documents have a toObject method which converts the mongoose document into a plain JavaScript object. This method accepts a few options. Instead of applying these options on a per-document basis, we may declare the options at the schema level and have them applied to all of the schema's documents by default.

To have all virtuals show up in your console.log output, set the toObject option to { getters: true }:

const schema = new Schema({ name: String });
schema.path('name').get(function(v) {
  return v + ' is my name';
});
schema.set('toObject', { getters: true });
const M = mongoose.model('Person', schema);
const m = new M({ name: 'Max Headroom' });
console.log(m); // { _id: 504e0cd7dd992d9be2f20b6f, name: 'Max Headroom is my name' }
To see all available toObject options, read this.

option: typeKey
By default, if you have an object with key 'type' in your schema, mongoose will interpret it as a type declaration.

// Mongoose interprets this as 'loc is a String'
const schema = new Schema({ loc: { type: String, coordinates: [Number] } });
However, for applications like geoJSON, the 'type' property is important. If you want to control which key mongoose uses to find type declarations, set the 'typeKey' schema option.

const schema = new Schema({
  // Mongoose interprets this as 'loc is an object with 2 keys, type and coordinates'
  loc: { type: String, coordinates: [Number] },
  // Mongoose interprets this as 'name is a String'
  name: { $type: String }
}, { typeKey: '$type' }); // A '$type' key means this object is a type declaration
option: validateBeforeSave
By default, documents are automatically validated before they are saved to the database. This is to prevent saving an invalid document. If you want to handle validation manually, and be able to save objects which don't pass validation, you can set validateBeforeSave to false.

const schema = new Schema({ name: String });
schema.set('validateBeforeSave', false);
schema.path('name').validate(function(value) {
  return value != null;
});
const M = mongoose.model('Person', schema);
const m = new M({ name: null });
m.validate(function(err) {
  console.log(err); // Will tell you that null is not allowed.
});
m.save(); // Succeeds despite being invalid
option: versionKey
The versionKey is a property set on each document when first created by Mongoose. This keys value contains the internal revision of the document. The versionKey option is a string that represents the path to use for versioning. The default is __v. If this conflicts with your application you can configure as such:

const schema = new Schema({ name: 'string' });
const Thing = mongoose.model('Thing', schema);
const thing = new Thing({ name: 'mongoose v3' });
await thing.save(); // { __v: 0, name: 'mongoose v3' }

// customized versionKey
new Schema({ /* ... */ }, { versionKey: '_somethingElse' })
const Thing = mongoose.model('Thing', schema);
const thing = new Thing({ name: 'mongoose v3' });
thing.save(); // { _somethingElse: 0, name: 'mongoose v3' }
Note that Mongoose's default versioning is not a full optimistic concurrency solution. Mongoose's default versioning only operates on arrays as shown below.

// 2 copies of the same document
const doc1 = await Model.findOne({ _id });
const doc2 = await Model.findOne({ _id });

// Delete first 3 comments from `doc1`
doc1.comments.splice(0, 3);
await doc1.save();

// The below `save()` will throw a VersionError, because you're trying to
// modify the comment at index 1, and the above `splice()` removed that
// comment.
doc2.set('comments.1.body', 'new comment');
await doc2.save();
If you need optimistic concurrency support for save(), you can set the optimisticConcurrency option.

Document versioning can also be disabled by setting the versionKey to false. DO NOT disable versioning unless you know what you are doing.

new Schema({ /* ... */ }, { versionKey: false });
const Thing = mongoose.model('Thing', schema);
const thing = new Thing({ name: 'no versioning please' });
thing.save(); // { name: 'no versioning please' }
Mongoose only updates the version key when you use save(). If you use update(), findOneAndUpdate(), etc. Mongoose will not update the version key. As a workaround, you can use the below middleware.

schema.pre('findOneAndUpdate', function() {
  const update = this.getUpdate();
  if (update.__v != null) {
    delete update.__v;
  }
  const keys = ['$set', '$setOnInsert'];
  for (const key of keys) {
    if (update[key] != null && update[key].__v != null) {
      delete update[key].__v;
      if (Object.keys(update[key]).length === 0) {
        delete update[key];
      }
    }
  }
  update.$inc = update.$inc || {};
  update.$inc.__v = 1;
});
option: optimisticConcurrency
Optimistic concurrency is a strategy to ensure the document you're updating didn't change between when you loaded it using find() or findOne(), and when you update it using save().

For example, suppose you have a House model that contains a list of photos, and a status that represents whether this house shows up in searches. Suppose that a house that has status 'APPROVED' must have at least two photos. You might implement the logic of approving a house document as shown below:

async function markApproved(id) {
  const house = await House.findOne({ _id });
  if (house.photos.length < 2) {
    throw new Error('House must have at least two photos!');
  }

  house.status = 'APPROVED';
  await house.save();
}
The markApproved() function looks right in isolation, but there might be a potential issue: what if another function removes the house's photos between the findOne() call and the save() call? For example, the below code will succeed:

const house = await House.findOne({ _id });
if (house.photos.length < 2) {
  throw new Error('House must have at least two photos!');
}

const house2 = await House.findOne({ _id });
house2.photos = [];
await house2.save();

// Marks the house as 'APPROVED' even though it has 0 photos!
house.status = 'APPROVED';
await house.save();
If you set the optimisticConcurrency option on the House model's schema, the above script will throw an error.

const House = mongoose.model('House', Schema({
  status: String,
  photos: [String]
}, { optimisticConcurrency: true }));

const house = await House.findOne({ _id });
if (house.photos.length < 2) {
  throw new Error('House must have at least two photos!');
}

const house2 = await House.findOne({ _id });
house2.photos = [];
await house2.save();

// Throws 'VersionError: No matching document found for id "..." version 0'
house.status = 'APPROVED';
await house.save();
option: collation
Sets a default collation for every query and aggregation. Here's a beginner-friendly overview of collations.

const schema = new Schema({
  name: String
}, { collation: { locale: 'en_US', strength: 1 } });

const MyModel = db.model('MyModel', schema);

MyModel.create([{ name: 'val' }, { name: 'Val' }]).
  then(() => {
    return MyModel.find({ name: 'val' });
  }).
  then((docs) => {
    // `docs` will contain both docs, because `strength: 1` means
    // MongoDB will ignore case when matching.
  });
option: timeseries
If you set the timeseries option on a schema, Mongoose will create a timeseries collection for any model that you create from that schema.

const schema = Schema({ name: String, timestamp: Date, metadata: Object }, {
  timeseries: {
    timeField: 'timestamp',
    metaField: 'metadata',
    granularity: 'hours'
  },
  autoCreate: false,
  expireAfterSeconds: 86400
});

// `Test` collection will be a timeseries collection
const Test = db.model('Test', schema);
option: skipVersioning
skipVersioning allows excluding paths from versioning (i.e., the internal revision will not be incremented even if these paths are updated). DO NOT do this unless you know what you're doing. For subdocuments, include this on the parent document using the fully qualified path.

new Schema({ /* ... */ }, { skipVersioning: { dontVersionMe: true } });
thing.dontVersionMe.push('hey');
thing.save(); // version is not incremented
option: timestamps
The timestamps option tells Mongoose to assign createdAt and updatedAt fields to your schema. The type assigned is Date.

By default, the names of the fields are createdAt and updatedAt. Customize the field names by setting timestamps.createdAt and timestamps.updatedAt.

The way timestamps works under the hood is:

If you create a new document, mongoose simply sets createdAt, and updatedAt to the time of creation.
If you update a document, mongoose will add updatedAt to the $set object.
If you set upsert: true on an update operation, mongoose will use $setOnInsert operator to add createdAt to the document in case the upsert operation resulted into a new inserted document.
const thingSchema = new Schema({ /* ... */ }, { timestamps: { createdAt: 'created_at' } });
const Thing = mongoose.model('Thing', thingSchema);
const thing = new Thing();
await thing.save(); // `created_at` & `updatedAt` will be included

// With updates, Mongoose will add `updatedAt` to `$set`
await Thing.updateOne({}, { $set: { name: 'Test' } });

// If you set upsert: true, Mongoose will add `created_at` to `$setOnInsert` as well
await Thing.findOneAndUpdate({}, { $set: { name: 'Test2' } });

// Mongoose also adds timestamps to bulkWrite() operations
// See https://mongoosejs.com/docs/api/model.html#model_Model-bulkWrite
await Thing.bulkWrite([
  {
    insertOne: {
      document: {
        name: 'Jean-Luc Picard',
        ship: 'USS Stargazer'
      // Mongoose will add `created_at` and `updatedAt`
      }
    }
  },
  {
    updateOne: {
      filter: { name: 'Jean-Luc Picard' },
      update: {
        $set: {
          ship: 'USS Enterprise'
        // Mongoose will add `updatedAt`
        }
      }
    }
  }
]);
By default, Mongoose uses new Date() to get the current time. If you want to overwrite the function Mongoose uses to get the current time, you can set the timestamps.currentTime option. Mongoose will call the timestamps.currentTime function whenever it needs to get the current time.

const schema = Schema({
  createdAt: Number,
  updatedAt: Number,
  name: String
}, {
  // Make Mongoose use Unix time (seconds since Jan 1, 1970)
  timestamps: { currentTime: () => Math.floor(Date.now() / 1000) }
});
option: pluginTags
Mongoose supports defining global plugins, plugins that apply to all schemas.

// Add a `meta` property to all schemas
mongoose.plugin(function myPlugin(schema) {
  schema.add({ meta: {} });
});
Sometimes, you may only want to apply a given plugin to some schemas. In that case, you can add pluginTags to a schema:

const schema1 = new Schema({
  name: String
}, { pluginTags: ['useMetaPlugin'] });

const schema2 = new Schema({
  name: String
});
If you call plugin() with a tags option, Mongoose will only apply that plugin to schemas that have a matching entry in pluginTags.

// Add a `meta` property to all schemas
mongoose.plugin(function myPlugin(schema) {
  schema.add({ meta: {} });
}, { tags: ['useMetaPlugin'] });
option: selectPopulatedPaths
By default, Mongoose will automatically select() any populated paths for you, unless you explicitly exclude them.

const bookSchema = new Schema({
  title: 'String',
  author: { type: 'ObjectId', ref: 'Person' }
});
const Book = mongoose.model('Book', bookSchema);

// By default, Mongoose will add `author` to the below `select()`.
await Book.find().select('title').populate('author');

// In other words, the below query is equivalent to the above
await Book.find().select('title author').populate('author');
To opt out of selecting populated fields by default, set selectPopulatedPaths to false in your schema.

const bookSchema = new Schema({
  title: 'String',
  author: { type: 'ObjectId', ref: 'Person' }
}, { selectPopulatedPaths: false });
const Book = mongoose.model('Book', bookSchema);

// Because `selectPopulatedPaths` is false, the below doc will **not**
// contain an `author` property.
const doc = await Book.findOne().select('title').populate('author');
option: storeSubdocValidationError
For legacy reasons, when there is a validation error in subpath of a single nested schema, Mongoose will record that there was a validation error in the single nested schema path as well. For example:

const childSchema = new Schema({ name: { type: String, required: true } });
const parentSchema = new Schema({ child: childSchema });

const Parent = mongoose.model('Parent', parentSchema);

// Will contain an error for both 'child.name' _and_ 'child'
new Parent({ child: {} }).validateSync().errors;
Set the storeSubdocValidationError to false on the child schema to make Mongoose only reports the parent error.

const childSchema = new Schema({
  name: { type: String, required: true }
}, { storeSubdocValidationError: false }); // <-- set on the child schema
const parentSchema = new Schema({ child: childSchema });

const Parent = mongoose.model('Parent', parentSchema);

// Will only contain an error for 'child.name'
new Parent({ child: {} }).validateSync().errors;
option: collectionOptions
Options like collation and capped affect the options Mongoose passes to MongoDB when creating a new collection. Mongoose schemas support most MongoDB createCollection() options, but not all. You can use the collectionOptions option to set any createCollection() options; Mongoose will use collectionOptions as the default values when calling createCollection() for your schema.

const schema = new Schema({ name: String }, {
  autoCreate: false,
  collectionOptions: {
    capped: true,
    max: 1000
  }
});
const Test = mongoose.model('Test', schema);

// Equivalent to `createCollection({ capped: true, max: 1000 })`
await Test.createCollection();
option: autoSearchIndex
Similar to autoIndex, except for automatically creates any Atlas search indexes defined in your schema. Unlike autoIndex, this option defaults to false.

const schema = new Schema({ name: String }, { autoSearchIndex: true });
schema.searchIndex({
  name: 'my-index',
  definition: { mappings: { dynamic: true } }
});
// Will automatically attempt to create the `my-index` search index.
const Test = mongoose.model('Test', schema);
option: readConcern
Read concerns are similar to writeConcern, but for read operations like find() and findOne(). To set a default readConcern, pass the readConcern option to the schema constructor as follows.

const eventSchema = new mongoose.Schema(
  { name: String },
  {
    readConcern: { level: 'available' } // <-- set default readConcern for all queries
  }
);
With ES6 Classes
Schemas have a loadClass() method that you can use to create a Mongoose schema from an ES6 class:

ES6 class methods become Mongoose methods
ES6 class statics become Mongoose statics
ES6 getters and setters become Mongoose virtuals
Here's an example of using loadClass() to create a schema from an ES6 class:

class MyClass {
  myMethod() { return 42; }
  static myStatic() { return 42; }
  get myVirtual() { return 42; }
}

const schema = new mongoose.Schema();
schema.loadClass(MyClass);

console.log(schema.methods); // { myMethod: [Function: myMethod] }
console.log(schema.statics); // { myStatic: [Function: myStatic] }
console.log(schema.virtuals); // { myVirtual: VirtualType { ... } }
Pluggable
Schemas are also pluggable which allows us to package up reusable features into plugins that can be shared with the community or just between your projects.
How to test mongoose models with jest and mockingoose
#
mongodb
#
node
#
jest
#
unittesting
A bit of introduction
Most of the times when you are getting introduced to Unit Testing, after an brief explaination showing what are unit tests and maybe the famous pyramid explaining the differences between unit tests, integration tests and E2E tests, you will be presented with your first test, possibly using the same library we are going to use today, Jest, and you will see something like this:



// sum.js
const add = (a, b) => {
  return a + b;
}

module.exports = {
  add,
};

// sum.test.js
const { add } = require('./sum');

it('should sum numbers', () => {
  expect(add(1, 2)).toBe(3);
}


The above test is clear and easy to understand, but the reality is that, while this can be applied to a lot of cases, things get very complicated when you have to start to mock things like dependencies, API calls, etc...
And one very tricky case is when you have to test a function that invoke some models from an ODM like Mongoose, like doing some CRUD operations against a database.
In some cases a solution could be to use an actual test database, so you don't mock anything but you use real data. The only problem with that is that is assuming that you must have a database at your disposal to run unit tests, and that's not always possible, plus you have to clean the database, and a pletora of other problems.
Another solution could be to use a database that lives only in memory and only for the duration of your tests, like the excellent mongodb-memory-server package.
But while this will work most of the times, if you deploy your code on any CI/CD you might encounter problems (and I did!).
Also a key factor of unit testing, is that you shouldn't rely on external services run them, unlike E2E tests for example.
What you should do is to mock most of the dependencies you need, as your goal is to just test the function and no deeper than that.

Solving the problem with mockingoose
Prerequisites
You already know how to use Jest
You already know hot Mongoose models works
You have a good knowledge of how a Node.js with a framework like Express.js application works
The models
So let's say that we have a couple of models, the classic Books and Authors, and our Books model will look something like this:



// models/books.js

const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const BooksSchema = new Schema({
  title: {
    type: String,
    trim: true
  },
  author: {
    type: Schema.Types.ObjectId,
    ref: 'authors'
  },
  year: {
    type: String,
  }
});

module.exports = mongoose.model('books', BooksSchema);


The service
So, often you see examples where they have a route where you have an endpoint and how that endpoint is resolved, calling the model, fetching the data and returning a response.
The problem here is that you rarely do that, as you want to abstract the logic away from the router, and for various reasons, like avoiding to have huge files, keep the code DRY, and perhaps reuse the same code in different context, not only as a resolver for an API endpoint.
I'm not going too much into details, but what I normally do is to have a router file, that list the various routes for a specific module of my APIs, each route calls a controller, and the controller calls a service. The controller is just a bridge saying "this route wants to do X, I'll ask the data to a service and then return back the response to the route.
And the core logic, like fetch the list of books will live in the service, which has to query the model, and return the data.
So my Books service will be something like this:



// services/books.js

const Books = require('../models/books');

const fetchBooks = () => Books
  .find({})
  .populate('author')
  .exec();

const fetchBook = id => Books
  .findById(id)
  .populate('author')
  .exec();

const createBook = ({title, author, year}) => {
  const book = new Books({
    title,
    author,
    year,
  });
  return book.save();
}

module.exports = {
  fetchBooks,
  fetchBook,
  createBook,
};



Note: the code above is brutally minimal just to keep the example as lean as possible.

As you see, our service will include the Books model, and it will use it to do operations on the database ODM.

Testing the service
Install mockingoose
The first thing is to install mockingoose with npm i mockingoose -D.

Create your test
Now you want to create your test file, for example books.test.js.
Then you will need to import the mockingoose, the model and the functions you are going to test into the file:



const mockingoose = require('mockingoose');
const BooksModel = require('../models/books');
const {
  fetchBooks,
  fetchBook,
  createBook,
} = require('./books');


Now to let the magic happen, we need to wrap our model with mockingoose, and then tell to the mocked model, what it supposed to return, for example if you want to return a list of books:



mockingoose(BooksModel).toReturn([
  {
    title: 'Book 1',
    author: {
      firstname: 'John',
      lastname: 'Doe'
    },
    year: 2021,
  },
  {
    title: 'Book 2',
    author: {
      firstname: 'Jane',
      lastname: 'Doe'
    },
    year: 2022,
  }
], 'find');


As you can the toReturn function expects two values, the first one is the data you want the model to return, the second one is which operations, like find, findOne, update, etc... and in our case we are going to call the find one as we need to fetch the list of books.
So the complete test for fetching the book will look something like this:



// books.test.js

const mockingoose = require('mockingoose');
const BooksModel = require('../models/books');
const {
  fetchBooks,
  fetchBook,
  createBook,
} = require('./books');

describe('Books service', () => {
  describe('fetchBooks', () => {
    it ('should return the list of books', async () => {
      mockingoose(BooksModel).toReturn([
        {
          title: 'Book 1',
          author: {
            firstname: 'John',
            lastname: 'Doe'
          },
          year: 2021,
        },
        {
          title: 'Book 2',
          author: {
            firstname: 'Jane',
            lastname: 'Doe'
          },
          year: 2022,
        }
      ], 'find');
      const results = await fetchBooks();
      expect(results[0].title).toBe('Book 1');
    });
  });
});


Similarly if you want to test the fetchBook method, which fetches only one document, it will be something like this:



describe('fetchBook', () => {
  it ('should return a book', async () => {
    mockingoose(BooksModel).toReturn(
      {
        _id: 1,
        title: 'Book 1',
        author: {
          firstname: 'John',
          lastname: 'Doe'
        },
        year: 2021,
      }, 'findOne');
    const results = await fetchBook(1);
    expect(results.title).toBe('test');
  });
});


The nice thing of this library is that it will also support if you call chained operations like exec or populate for example, so you don't need to worry about them.

Run the tests
So now if you run your tests with npm run test, you should see your fist tests running successfully:

Screenshot 2021-09-07 at 12.07.47

Final thoughts
Testing your real world application can be challenging sometimes, especially when you get lost in mocking most of the application data, but with tools like mockingoose makes my life much easier, and it works fine on CI/CD as well!
For more details on how to use this library, please visit the github project page.
Unit Testing in NodeJS with Express, TypeScript, Jest and Supertest || Part Three: Writing Unit Tests || A Comprehensive Guide
#
jest
#
node
#
express
#
unittest
Welcome back to the third installment of our series on building a powerful API with Node.js, Express, and MongoDB and writing unit tests for each line of code! In the previous 2 parts: part one and part two, we set up the environment and meticulously crafted our application, ensuring robust user authentication and seamless database interactions. Now, it's time to fortify our codebase and elevate our development practices through the implementation of thorough unit tests.
In this part, we'll embark on a step-by-step journey through the process of writing unit tests for each line of code in our API. From utility functions, routes, controllers to services and models, we'll ensure that every aspect of our application is rigorously tested.

Why Unit Testing Matters
Unit testing plays a pivotal role in the development lifecycle, offering numerous benefits, including:

Early Issue Detection:
Identify and address bugs and issues early in the development process, reducing the likelihood of encountering them in later stages.

Code Maintainability:
Establish a safety net for code changes by ensuring that existing functionalities remain intact during modifications.

Documentation:
Unit tests serve as living documentation, showcasing the expected behavior of each component, function, or module.

Enhanced Collaboration:
Facilitate collaboration among team members by providing a clear understanding of the intended functionality and expected outcomes.

Folder Structure for Unit Tests
Organizing your unit tests is crucial for clarity and ease of maintenance. Consider adopting a structure similar to your application's folder layout. For our API, I recommend the following structure:

Image description

Just like I promised, we will be writing unit tests for each line of code. In the first part of this guide, after setting up the environment, we wrote some tests in the app.test.ts but by then we didn't have all the code in the index file like we do now, lets first update that file and make sure everything we have in the src/index.ts is working as expected including datababase connection to MongoDB Atlas, among others before starting with models.
Replace code inside app.test.ts with the following code:

import request from "supertest";
import app from "../index";
import mongoose from "mongoose";

beforeAll(async () => {
  // Set up: Establish the MongoDB connection before running tests
  if (!process.env.MONGODB_URL) {
    throw new Error("MONGO_URI environment variable is not defined/set");
  }

  await mongoose.connect(process.env.MONGODB_URL);
});

afterAll(async () => {
  // Teardown: Close the MongoDB connection after all tests have completed
  await mongoose.connection.close();
});

// Unit test for testing initial route ("/")
describe("GET /", () => {
  it('responds with "Welcome to unit testing guide for nodejs, typescript and express!"', async () => {
    const response = await request(app).get("/");

    expect(response.status).toBe(200);
    expect(response.text).toBe(
      "Welcome to unit testing guide for nodejs, typescript and express!"
    );
  });
});

Our app.test.ts file orchestrates the setup and teardown of the testing environment, establishing a MongoDB connection before tests begin and closing it afterward. The primary test case verifies the behavior of the root route ("/"), ensuring it responds with a welcome message and a 200 status. The code includes error handling to prompt the developer if the MongoDB connection string (MONGODB_URL) is not defined. This file serves as a foundational template for testing the core functionalities of the application, paving the way for more extensive unit testing across various directories and components.

Open your terminal and run:

npm run test
The output should be as shown below:

Image description

All set, now ready to write unit tests for our code in other directories.

Unit Tests for Database Models
Lets start with the data layer by writing unit tests for our database models.
Testing models allows us to validate the structure, functionality, and interactions with the database. By establishing robust tests for our models, we create a solid base upon which the rest of our unit tests can thrive.
The beforeAll hook orchestrates the setup process before running any tests, ensuring a valid MongoDB connection is established based on the MONGODB_URL environment variable. It throws an error if the variable is not defined, alerting the developer to set the MongoDB connection string. On the other hand, the afterAll hook handles cleanup after all tests are completed, closing the MongoDB connection to prevent resource leaks and maintain a clean testing environment. These hooks collectively manage the initialization and teardown phases, ensuring a consistent and isolated testing environment for the unit tests.

Create a new file: src/tests/models/userModel.test.ts and place the following code:

import mongoose from "mongoose";
import User, { IUser } from "../../models/User";
import dotenv from "dotenv";
dotenv.config();

describe("User Model Tests", () => {
  let createdUser: IUser;

  beforeAll(async () => {
    // Set up: Establish the MongoDB connection before running tests
    if (!process.env.MONGODB_URL) {
      throw new Error("MONGODB_URL environment variable is not defined/set");
    }

    await mongoose.connect(process.env.MONGODB_URL);
  });

  afterAll(async () => {
    // Remove the created user
    // await User.deleteMany();

    // Teardown: Close the MongoDB connection after all tests have completed
    await mongoose.connection.close();
  });

  // Test Case: Create a new user
  it("should create a new user", async () => {
    const userData: Partial<Omit<IUser, "_id">> = {
      email: "test@example.com",
      username: "testuser",
      password: "testpassword",
      isAdmin: false,
      savedProducts: [],
    };

    createdUser = await User.create(userData);

    expect(createdUser.email).toBe(userData.email);
    expect(createdUser.username).toBe(userData.username);
    expect(createdUser.isAdmin).toBe(userData.isAdmin);
  }, 10000); // Increase timeout to 10 seconds

  // Test Case: Ensure email and username are unique
  it("should fail to create a user with duplicate email or username", async () => {
    const userData: Partial<Omit<IUser, "_id">> = {
      email: "test@example.com",
      username: "testuser",
      password: "testpassword",
      isAdmin: false,
      savedProducts: [],
    };

    try {
      // Attempt to create a user with the same email and username
      await User.create(userData);
      // If the above line doesn't throw an error, the test should fail
      expect(true).toBe(false);
    } catch (error) {
      // Expect a MongoDB duplicate key error (code 11000)
      expect(error.code).toBe(11000);
    }
  }, 10000); // Increase timeout to 10 seconds

  // Test Case: Get all users
  it("should get all users", async () => {
    // Fetch all users from the database
    const allUsers = await User.find();

    // Expectations
    const userWithoutTimestamps = {
      _id: createdUser._id,
      email: createdUser.email,
      username: createdUser.username,
      isAdmin: createdUser.isAdmin,
      savedProducts: createdUser.savedProducts,
    };

    expect(allUsers).toContainEqual(
      expect.objectContaining(userWithoutTimestamps)
    );
  });

  const removeMongoProps = (user: any) => {
    const { __v, _id, createdAt, updatedAt, ...cleanedUser } = user.toObject();
    return cleanedUser;
  };

  // Test Case: Get all users
  it("should get all users", async () => {
    const allUsers = await User.find();

    // If there is a created user, expect the array to contain an object
    // that partially matches the properties of the createdUser
    if (createdUser) {
      const cleanedCreatedUser = removeMongoProps(createdUser);

      expect(allUsers).toEqual(
        expect.arrayContaining([expect.objectContaining(cleanedCreatedUser)])
      );
    }
  });

  // Test Case: Update an existing user
  it("should update an existing user", async () => {
    // Check if there is a created user to update
    if (createdUser) {
      // Define updated data
      const updatedUserData: Partial<IUser> = {
        username: "testuser",
        isAdmin: true,
      };

      // Update the user and get the updated user
      const updatedUser = await User.findByIdAndUpdate(
        createdUser._id,
        updatedUserData,
        { new: true }
      );

      // Expectations
      expect(updatedUser?.username).toBe(updatedUserData.username);
      expect(updatedUser?.isAdmin).toBe(updatedUserData.isAdmin);
    }
  });

  // Test Case: Get user by ID
  it("should get user by ID", async () => {
    // Get the created user by ID
    const retrievedUser = await User.findById(createdUser._id);

    // Expectations
    expect(retrievedUser?.email).toBe(createdUser.email);
    expect(retrievedUser?.username).toBe(createdUser.username);
    // Add other properties that you want to compare

    // For example, if updatedAt is expected to be different, you can ignore it:
    // expect(retrievedUser?.updatedAt).toBeDefined();
  });

  // Test Case: Delete an existing user
  it("should delete an existing user", async () => {
    // Delete the created user
    await User.findByIdAndDelete(createdUser._id);

    // Attempt to find the deleted user
    const deletedUser = await User.findById(createdUser._id);

    // Expectations
    expect(deletedUser).toBeNull();
  });
});

Our userModel.test.ts script contains a series of Jest test cases for the user model. Before running the tests, it establishes a connection to a MongoDB database specified in the environment variable MONGODB_URL. The test suite covers creating a new user, ensuring the uniqueness of email and username, retrieving all users, updating an existing user, fetching a user by ID, and finally, deleting an existing user. The tests use the User model from the src/models/User file and leverage various assertions to verify the expected behavior of these operations. Additionally, a utility function removeMongoProps is used to clean MongoDB-specific properties from user objects for precise comparisons. The script performs setup and teardown procedures to connect to and disconnect from the database, making it a comprehensive set of tests for the user model.
I always prefer to test all crud operations on the model at this stage to be sure but the main effort should be on the data since we are on the data layer.
Feel free to add more test cases on the model forxample the one that tests the data type of data received on each field and compare it with what the model has among others.
All good for our user model because all our tests passed under different test data. Its time to move to the product model.

Create a new file: src/__tests__/models/productModel.test.ts and place the following code:

import mongoose from "mongoose";
import Product, { IProduct } from "../../models/Product";
import dotenv from "dotenv";
dotenv.config();

describe("Product Model Tests", () => {
  let createdProduct: IProduct;

  beforeAll(async () => {
    // Set up: Establish the MongoDB connection before running tests
    if (!process.env.MONGODB_URL) {
      throw new Error("MONGODB_URL environment variable is not defined/set");
    }

    await mongoose.connect(process.env.MONGODB_URL);
  });

  afterAll(async () => {
    // Remove the created product
    // await Product.deleteMany();

    // Teardown: Close the MongoDB connection after all tests have completed
    await mongoose.connection.close();
  });

  // Test Case: Create a new product
  it("should create a new product", async () => {
    const productData: Partial<IProduct> = {
      title: "Test Product",
      description: "Product description",
      image: "https://testimage.png",
      category: "test category",
      quantity: "20 kgs",
      // You can add other fields
    };

    createdProduct = await Product.create(productData);

    expect(createdProduct.title).toBe(productData.title);
    expect(createdProduct.description).toBe(productData.description);
    // Add other expectations for additional fields
  }, 10000); // Increase timeout to 10 seconds

  // Test Case: Fail to create a product with missing required fields
  it("should fail to create a product with missing required fields", async () => {
    const productData: Partial<IProduct> = {
      // Omitting required fields
    };

    try {
      // Attempt to create a product with missing required fields
      await Product.create(productData);
      // If the above line doesn't throw an error, the test should fail
      expect(true).toBe(false);
    } catch (error) {
      // Expect a MongoDB validation error
      expect(error.name).toBe("ValidationError");
    }
  }, 10000); // Increase timeout to 10 seconds

  // Test Case: Get all products
  it("should get all products", async () => {
    // Fetch all products from the database
    const allProducts = await Product.find();

    // Expectations
    const productWithoutTimestamps = {
      //   _id: createdProduct._id,
      title: createdProduct.title,
      description: createdProduct.description,
      // Add other necessary fields
    };

    expect(allProducts).toContainEqual(
      expect.objectContaining(productWithoutTimestamps)
    );
  });

  const removeMongoProps = (product: any) => {
    const { __v, _id, createdAt, updatedAt, ...cleanedProduct } =
      product.toObject();
    return cleanedProduct;
  };

  // Test Case: Get all products
  it("should get all products", async () => {
    const allProducts = await Product.find();

    // If there is a created product, expect the array to contain an object
    // that partially matches the properties of the createdProduct
    if (createdProduct) {
      const cleanedCreatedProduct = removeMongoProps(createdProduct);

      expect(allProducts).toEqual(
        expect.arrayContaining([expect.objectContaining(cleanedCreatedProduct)])
      );
    }
  });

  // Test Case: Update an existing product
  it("should update an existing product", async () => {
    // Check if there is a created product to update
    if (createdProduct) {
      // Define updated data
      const updatedProductData: Partial<IProduct> = {
        title: "Test Product", // replace hre with your updated title
        // Update other necessary fields
      };

      // Update the product and get the updated product
      const updatedProduct = await Product.findByIdAndUpdate(
        createdProduct._id,
        updatedProductData,
        { new: true }
      );

      // Expectations
      expect(updatedProduct?.title).toBe(updatedProductData.title);
      // Add expectations for other updated fields
    }
  });

  // Test Case: Get product by ID
  it("should get product by ID", async () => {
    // Get the created product by ID
    const retrievedProduct = await Product.findById(createdProduct._id);

    // Expectations
    expect(retrievedProduct?.title).toBe(createdProduct.title);
    // Add other expectations for properties you want to compare
  });

  // Test Case: Delete an existing product
  it("should delete an existing product", async () => {
    // Delete the created product
    await Product.findByIdAndDelete(createdProduct._id);

    // Attempt to find the deleted product
    const deletedProduct = await Product.findById(createdProduct._id);

    // Expectations
    expect(deletedProduct).toBeNull();
  });
});
Our Product Model Tests are well-structured and cover essential CRUD operations on our data layer. Once again, the beforeAll and afterAll hooks ensure a connection to the MongoDB database is established before the tests and closed afterward. The "Create a new product" test validates the creation of a product with specified data, while the "Fail to create a product with missing required fields" test checks that the model correctly enforces required fields. The "Get all products" tests ensure that products retrieved from the database match the expected properties, and the utility function removeMongoProps helps clean unnecessary MongoDB-specific properties. The "Update an existing product" and "Get product by ID" tests validate the update and retrieval of products by ID. Lastly, the "Delete an existing product" test confirms the successful deletion of a product.
Overall, our tests provide comprehensive coverage for your Product model, ensuring its correctness and reliability in a MongoDB environment.
All set, lets proceed to services:

Writing UnitTests for Services
Create a new file: src/__tests__/services/userService.test.ts and place the following code:

import * as userService from "../../services/userService";
import * as passwordUtils from "../../utils/passwordUtils";
import * as jwtUtils from "../../utils/jwtUtils";
import User, { IUser } from "../../models/User";
import mongoose from "mongoose";
import dotenv from "dotenv";
import * as productModel from "../../models/Product"; // Import the Product model
dotenv.config();

// Mock the Product model
jest.mock("../../models/Product", () => ({
  __esModule: true,
  default: {
    findById: jest.fn(),
  },
}));

// Mock the populateUser function
jest
  .spyOn(userService, "populateUser")
  .mockImplementation(async (user: IUser) => {
    // Mock the behavior of populateUser function
    return user; // You can replace this with your desired mock value
  });

describe("User Service Tests", () => {
  let createdUser: IUser;

  // Clean up after tests
  beforeAll(async () => {
    // Set up: Establish the MongoDB connection before running tests
    if (!process.env.MONGODB_URL) {
      throw new Error("MONGODB_URL environment variable is not defined/set");
    }

    await mongoose.connect(process.env.MONGODB_URL);
  });

  afterAll(async () => {
    // Remove the created user
    await User.deleteMany();

    // Teardown: Close the MongoDB connection after all tests have completed
    await mongoose.connection.close();

    // Clear all jest mocks
    jest.clearAllMocks();
  });

  // Mock the hashPassword function
  jest
    .spyOn(passwordUtils, "hashPassword")
    .mockImplementation(async (password) => {
      // Mocked hash implementation
      return password + "_hashed";
    });
  // Mock the jwtUtils' generateToken function
  jest
    .spyOn(jwtUtils, "generateToken")
    .mockImplementation(() => "mocked_token");

  // Test Case: Create a new user
  it("should create a new user", async () => {
    const userData: Partial<IUser> = {
      email: "test@example.com",
      username: "testuser",
      password: "testpassword",
      isAdmin: false,
      savedProducts: [],
    };

    createdUser = await userService.createUser(userData as IUser);

    // Expectations
    expect(createdUser.email).toBe(userData.email);
    expect(createdUser.username).toBe(userData.username);
    expect(createdUser.isAdmin).toBe(userData.isAdmin);
    expect(passwordUtils.hashPassword).toHaveBeenCalledWith(userData.password);
  }, 30000);

  // Test Case: Login user
  it("should login a user and generate a token", async () => {
    // Mock user data for login
    const loginEmail = "test@example.com";
    const loginPassword = "testpassword";

    // Mock the comparePassword function
    jest
      .spyOn(passwordUtils, "comparePassword")
      .mockImplementation(async (inputPassword, hashedPassword) => {
        return inputPassword === hashedPassword.replace("_hashed", "");
      });

    const { user, token } = await userService.loginUser(
      loginEmail,
      loginPassword
    );

    // Expectations
    expect(user.email).toBe(createdUser.email);
    expect(user.username).toBe(createdUser.username);
    expect(user.isAdmin).toBe(createdUser.isAdmin);
    expect(jwtUtils.generateToken).toHaveBeenCalledWith({
      id: createdUser._id,
      username: createdUser.username,
      email: createdUser.email,
      isAdmin: createdUser.isAdmin,
    });
    expect(token).toBe("mocked_token");
  }, 20000);

  const removeMongoProps = (user: any) => {
    const { __v, _id, createdAt, updatedAt, ...cleanedUser } = user.toObject();
    return cleanedUser;
  };

  // Test Case: Get all users
  it("should get all users", async () => {
    // Fetch all users from the database
    const allUsers = await userService.getAllUsers();

    // If there is a created user, expect the array to contain an object
    // that partially matches the properties of the createdUser
    if (createdUser) {
      const cleanedCreatedUser = removeMongoProps(createdUser);

      expect(allUsers).toEqual(
        expect.arrayContaining([expect.objectContaining(cleanedCreatedUser)])
      );
    }
  }, 20000);

  // Test Case: Delete an existing user
  it("should delete an existing user", async () => {
    // Delete the created user
    await User.findByIdAndDelete(createdUser._id);

    // Attempt to find the deleted user
    const deletedUser = await User.findById(createdUser._id);

    // Expectations
    expect(deletedUser).toBeNull();
  });
});

and src/__tests__/services/producService.test.ts and place the following code:

import * as productService from "../../services/productService";
import Product, { IProduct } from "../../models/Product";
import mongoose from "mongoose";
import dotenv from "dotenv";
dotenv.config();

// Mock the Product model
jest.mock("../../models/Product", () => ({
  __esModule: true,
  default: {
    create: jest.fn(),
    find: jest.fn(),
    findById: jest.fn(),
    findByIdAndUpdate: jest.fn(),
    findByIdAndDelete: jest.fn(),
  },
}));

// Mock the product data
const productId = "mockedProductId";
const mockProduct: IProduct = {
  _id: productId,
  title: "Mocked Product",
  description: "A description for the mocked product",
  image: "mocked_image.jpg",
  category: "Mocked Category",
  quantity: "10",
  inStock: true,
} as IProduct;

// Use the toObject method to include additional properties
const mockProductWithMethods = {
  ...mockProduct,
  toObject: jest.fn(() => mockProduct),
};

// Mock the product retrieval by ID
(Product.findById as jest.Mock).mockResolvedValueOnce(mockProductWithMethods);

describe("Product Service Tests", () => {
  // Clean up after tests
  beforeAll(async () => {
    // Set up: Establish the MongoDB connection before running tests
    if (!process.env.MONGODB_URL) {
      throw new Error("MONGODB_URL environment variable is not defined/set");
    }

    await mongoose.connect(process.env.MONGODB_URL);
  });

  afterAll(async () => {
    // Teardown: Close the MongoDB connection after all tests have completed
    await mongoose.connection.close();

    // Clear all jest mocks
    jest.clearAllMocks();
  });

  // Test Case: Create a new product
  it("should create a new product", async () => {
    // Mock the product data
    const productData: Partial<IProduct> = {
      title: "Test Product",
      // Add other product properties based on your schema
    };

    // Mock the product creation
    (Product.create as jest.Mock).mockResolvedValueOnce({
      ...productData,
      _id: "mockedProductId", // Mocked product ID
    });

    // Create the product
    const createdProduct = await productService.createProduct(
      productData as IProduct
    );

    // Expectations
    expect(createdProduct.title).toBe(productData.title);
    // You can add more expectations based on your schema and business logic
  }, 20000);

  // Test Case: Get product by ID
  it("should get product by ID", async () => {
    // Mock product data
    const productId = "mockedProductId";
    const mockProduct: IProduct = {
      _id: productId,
      title: "Mocked Product",
      description: "A description for the mocked product",
      image: "mocked_image.jpg",
      category: "Mocked Category",
      quantity: "10",
      inStock: true,
    } as IProduct;

    // Mock the findById method of the Product model
    (Product.findById as jest.Mock).mockResolvedValueOnce(mockProduct);

    // Call the service
    const retrievedProduct = await productService.getProductById(productId);

    // Expectations
    expect(retrievedProduct).toEqual(
      expect.objectContaining({
        _id: mockProduct._id,
        title: mockProduct.title,
        description: mockProduct.description,
        image: mockProduct.image,
        category: mockProduct.category,
        quantity: mockProduct.quantity,
        inStock: mockProduct.inStock,
      })
    );
    expect(Product.findById).toHaveBeenCalledWith(productId);
  }, 20000);

  // Test Case: Update product by ID
  it("should update product by ID", async () => {
    // Mock product data
    const productId = "mockedProductId";
    const mockProduct: IProduct = {
      _id: productId,
      title: "Mocked Product",
      description: "A description for the mocked product",
      image: "mocked_image.jpg",
      category: "Mocked Category",
      quantity: "10",
      inStock: true,
    } as IProduct;

    // Mock the findByIdAndUpdate method of the Product model
    (Product.findByIdAndUpdate as jest.Mock).mockResolvedValueOnce(mockProduct);

    // Mock updated product data
    const updatedProductData: Partial<IProduct> = {
      title: "Mocked Product", // update some fields
      quantity: "10",
    };

    // Call the service
    const updatedProduct = await productService.updateProduct(
      productId,
      updatedProductData
    );

    // Expectations
    expect(updatedProduct?._id).toBe(mockProduct._id);
    expect(updatedProduct?.title).toBe(updatedProductData.title);
    expect(updatedProduct?.quantity).toBe(updatedProductData.quantity);
    // Add similar expectations for other properties you want to compare

    expect(Product.findByIdAndUpdate).toHaveBeenCalledWith(
      productId,
      updatedProductData,
      { new: true }
    );
  }, 20000);

  // Test Case: Delete product by ID
  it("should delete product by ID", async () => {
    // Mock product data
    const productId = "mockedProductId";
    const mockProduct: IProduct = {
      _id: productId,
      title: "Mocked Product",
      description: "A description for the mocked product",
      image: "mocked_image.jpg",
      category: "Mocked Category",
      quantity: "10",
      inStock: true,
    } as IProduct;

    // Mock the findByIdAndDelete method of the Product model
    (Product.findByIdAndDelete as jest.Mock).mockResolvedValueOnce(mockProduct);

    // Call the service
    await productService.deleteProduct(productId);

    // Expectations
    expect(Product.findByIdAndDelete).toHaveBeenCalledWith(productId);
  }, 20000);

  // Test Case: Get all products
  it("should get all products", async () => {
    // Mock product data
    const mockProducts: IProduct[] = [
      {
        _id: "product1",
        title: "Product 1",
        description: "Description for Product 1",
        image: "product1_image.jpg",
        category: "Category 1",
        quantity: "5",
        inStock: true,
      },
      {
        _id: "product2",
        title: "Product 2",
        description: "Description for Product 2",
        image: "product2_image.jpg",
        category: "Category 2",
        quantity: "10",
        inStock: false,
      },
    ] as IProduct[];

    // Mock the find method of the Product model
    (Product.find as jest.Mock).mockResolvedValueOnce(mockProducts);

    // Call the service
    const retrievedProducts = await productService.getAllProducts();

    // Expectations
    expect(Product.find).toHaveBeenCalled();
    expect(retrievedProducts).toEqual(mockProducts);
  }, 20000);
});

Our createUser service uses two external functions; hashPassword utility and generateToken middleware, all in src/utils. Lets first diagonise these utility functions and discuss their unit tests that this service is mocking.
Create a new file: src/__tests__/utils/passwordUtils.test.ts and place the following code:

import * as passwordUtils from "../../utils/passwordUtils";

describe("Password Utilities Tests", () => {
  // Test Case: Hash Password
  it("should hash a password", async () => {
    const password = "testpassword";
    const hashedPassword = await passwordUtils.hashPassword(password);
    expect(hashedPassword).toBeDefined();
    expect(typeof hashedPassword).toBe("string");
  });

  // Test Case: Compare Password
  it("should compare a valid password", async () => {
    const password = "testpassword";
    const hashedPassword = await passwordUtils.hashPassword(password);
    const isPasswordValid = await passwordUtils.comparePassword(
      password,
      hashedPassword
    );
    expect(isPasswordValid).toBe(true);
  });

  // Test Case: Compare Invalid Password
  it("should compare an invalid password", async () => {
    const password = "testpassword";
    const hashedPassword = await passwordUtils.hashPassword(password);
    const isPasswordValid = await passwordUtils.comparePassword(
      "wrongpassword",
      hashedPassword
    );
    expect(isPasswordValid).toBe(false);
  });
});

and src/__tests__/utils/jwtUtils.test.ts and place the following code:

import {
  JWTPayload,
  generateToken,
  verifyToken,
  verifyTokenAndAuthorization,
} from "../../utils/jwtUtils";

import dotenv from "dotenv";
dotenv.config();

describe("JWT Utils Tests", () => {
  const mockPayload: JWTPayload = {
    id: "mockUserId",
    username: "mockUsername",
    email: "mock@example.com",
    isAdmin: false,
  };

  const mockToken = "mockToken";

  process.env.JWT_SEC = "mockSecret";
  process.env.JWT_EXPIRY_PERIOD = "1h";

  // Test Case: Generate Token
  it("should generate a JWT token", () => {
    const token = generateToken(mockPayload);
    expect(token).toBeDefined();
  });


  it("should verify a valid JWT token", (done) => {
    const req: any = {
      headers: {
        token: `Bearer ${mockToken}`,
      },
    };

    const res: any = {
      status: (status: number) => {
        expect(status).toBe(403);
        return {
          json: (message: string) => {
            expect(message).toBe("Token is not valid!");
            done();
          },
        };
      },
    };

    const next = () => {
      // Should not reach here
      done.fail("Should not reach next middleware on invalid token");
    };

    verifyToken(req, res, next);
  });

  // Test Case: Verify Token (invalid token)
  it("should handle an invalid JWT token", (done) => {
    const req: any = {
      headers: {
        token: "InvalidToken",
      },
    };

    const res: any = {
      status: (status: number) => {
        expect(status).toBe(403);
        return {
          json: (message: string) => {
            expect(message).toBe("Token is not valid!");
            done();
          },
        };
      },
    };

    const next = () => {
      // Should not reach here
      done.fail("Should not reach next middleware on invalid token");
    };

    verifyToken(req, res, next);
  });

  // Cleanup: Reset environment variables after tests
  afterAll(() => {
    delete process.env.JWT_SEC;
    delete process.env.JWT_EXPIRY_PERIOD;
  });
});

In our suite for hashing the password, we examine the core functionalities integral to safeguarding sensitive credentials. The initial litmus test involves the seamless hashing of passwords, ensuring a robust defense against unauthorized access. A keen eye is cast upon the compare password mechanism, where the suite deftly validates the correctness of a given password against its hashed counterpart. In cases of both valid and invalid password comparisons, the suite orchestrates a meticulous evaluation, fortifying our application's resilience against potential security threats. This comprehensive scrutiny instills confidence in the reliability and effectiveness of our Password Utilities, as they stand guard to fortify the fortress of our user authentication system.

Also, in the suite for token generation and verification, we scrutinize the fundamental functionalities that underpin the secure handling of JSON Web Tokens (JWTs). The first checkpoint ensures the seamless generation of JWT tokens, a cornerstone in our approach to secure authentication. Delving into token verification, the suite rigorously examines scenarios of both valid and invalid tokens, intricately assessing the resilience of our verification mechanism. In cases where a valid token is presented, the verification process is expected to seamlessly proceed, ensuring that the user details are defined. Conversely, when confronted with an invalid token, our suite orchestrates a precise response, safeguarding our application against unauthorized access. As the final act of diligence, the suite gracefully resets environment variables, leaving the testing landscape pristine.

In the User Service Tests suite, we meticulously verify the functionality of our user service within a Node.js backend. Leveraging the power of mocking, we intentionally isolate the service from external dependencies, ensuring a controlled testing environment. Our suite encompasses crucial aspects, such as creating a new user, logging in a user, retrieving all users, and deleting an existing user. Each test case meticulously orchestrates mock data and expectations, guaranteeing the service operates seamlessly. Our commitment to best practices shines through as we meticulously clean up by removing the created user post-testing. To facilitate more accurate comparisons of user objects, we employ the removeMongoProps function, eliminating MongoDB-specific properties. This suite is a testament to our dedication to thorough and isolated testing, laying a robust foundation for a resilient backend service.

On the otherhand, in the Product Service Tests suite, we scrutinize the functionality of our backend API's product-related operations. Employing the power of mocking, we deliberately isolate the service from external dependencies, ensuring a controlled testing environment. The suite comprehensively tests key functionalities, including creating a new product, fetching a product by ID, updating a product, deleting a product, and fetching all products. Each test case is meticulously crafted, incorporating mock data, precise expectations, and detailed property comparisons, thereby validating the robustness and reliability of our ProductService. The suite adheres to best practices, ensuring that the testing environment is thoroughly cleaned up post-execution by closing the MongoDB connection and clearing all Jest mocks. This comprehensive and systematic testing approach reinforces our commitment to delivering a resilient and dependable backend service.

Writing Unit Tests for Controllers
Create a new file: src/__tests__/controllers/userController.test.ts and place the following code:

import { Request, Response } from "express";
import * as UserController from "../../controllers/userController";
import * as UserService from "../../services/userService";
import { IProduct } from "models/Product";
import { IUser } from "models/User";

// Mock the UserService
jest.mock("../../services/userService");

describe("User Controller Tests", () => {
  // Test Case: Create a new user
  it("should create a new user", async () => {
    // Mock user data from the request body
    const mockUserData: IUser = {
      email: "test@example.com",
      username: "testuser",
      password: "testpassword",
      isAdmin: false,
      savedProducts: [],
    } as IUser;

    // Mock the create user response from the UserService
    const mockCreatedUser = {
      _id: "mockUserId",
      ...mockUserData,
    };

    // Mock the request and response objects
    const mockRequest = {
      body: mockUserData,
    } as Request;

    const mockResponse = {
      status: jest.fn().mockReturnThis(),
      json: jest.fn(),
    } as unknown as Response;

    // Mock the createUser function of the UserService
    (UserService.createUser as jest.Mock).mockResolvedValueOnce(
      mockCreatedUser
    );

    // Call the createUser controller
    await UserController.createUser(mockRequest, mockResponse);

    // Expectations
    expect(UserService.createUser).toHaveBeenCalledWith(mockUserData);
    expect(mockResponse.status).toHaveBeenCalledWith(201);
    expect(mockResponse.json).toHaveBeenCalledWith(mockCreatedUser);
  }, 20000);

  // Test Case: Login user
  it("should login a user and return a token", async () => {
    // Mock user credentials from the request body
    const mockUserCredentials = {
      email: "test@example.com",
      password: "testpassword",
    };

    type IMockCreatedUser = {
      user: Partial<IUser>;
      token: string;
    };
    // Mock the login response from the UserService
    const mockLoginResponse: IMockCreatedUser = {
      user: {
        _id: "mockUserId",
        email: mockUserCredentials.email,
        username: "testuser",
        isAdmin: false,
        savedProducts: [],
      },
      token: "mocked_token",
    };

    // Mock the request and response objects
    const mockRequest = {
      body: mockUserCredentials,
    } as Request;

    const mockResponse = {
      status: jest.fn().mockReturnThis(),
      json: jest.fn(),
    } as unknown as Response;

    // Mock the loginUser function of the UserService
    (UserService.loginUser as jest.Mock).mockResolvedValueOnce(
      mockLoginResponse
    );

    // Call the loginUser controller
    await UserController.loginUser(mockRequest, mockResponse);

    // Expectations
    expect(UserService.loginUser).toHaveBeenCalledWith(
      mockUserCredentials.email,
      mockUserCredentials.password
    );
    expect(mockResponse.status).toHaveBeenCalledWith(200);
    expect(mockResponse.json).toHaveBeenCalledWith(mockLoginResponse);
  }, 20000);

  // Test Case: Get all users
  it("should get all users", async () => {
    // Mock the array of users from the UserService
    const mockUsers: IUser[] = [
      {
        _id: "mockUserId1",
        email: "user1@example.com",
        username: "user1",
        isAdmin: false,
        savedProducts: [],
      },
      {
        _id: "mockUserId2",
        email: "user2@example.com",
        username: "user2",
        isAdmin: true,
        savedProducts: [],
      },
    ] as IUser[];

    // Mock the request and response objects
    const mockRequest = {} as Request;

    const mockResponse = {
      status: jest.fn().mockReturnThis(),
      json: jest.fn(),
    } as unknown as Response;

    // Mock the getAllUsers function of the UserService
    (UserService.getAllUsers as jest.Mock).mockResolvedValueOnce(mockUsers);

    // Call the getAllUsers controller
    await UserController.getAllUsers(mockRequest, mockResponse);

    // Expectations
    expect(UserService.getAllUsers).toHaveBeenCalled();
    expect(mockResponse.status).toHaveBeenCalledWith(200);
    expect(mockResponse.json).toHaveBeenCalledWith(mockUsers);
  }, 20000);

  // Test Case: Error fetching users
  it("should handle error when fetching users", async () => {
    // Mock the error response from the UserService
    const mockErrorResponse = {
      message: "Error fetching users",
    };

    // Mock the request and response objects
    const mockRequest = {} as Request;

    const mockResponse = {
      status: jest.fn().mockReturnThis(),
      json: jest.fn(),
    } as unknown as Response;

    // Mock the getAllUsers function of the UserService to throw an error
    (UserService.getAllUsers as jest.Mock).mockRejectedValueOnce(
      mockErrorResponse
    );

    // Call the getAllUsers controller
    await UserController.getAllUsers(mockRequest, mockResponse);

    // Expectations
    expect(UserService.getAllUsers).toHaveBeenCalled();
    expect(mockResponse.status).toHaveBeenCalledWith(500);
    expect(mockResponse.json).toHaveBeenCalledWith({
      error: mockErrorResponse.message,
    });
  }, 20000);

  // Test Case: Get user by ID
  it("should get user by ID", async () => {
    // Mock the user from the UserService
    const mockUser: IUser = {
      _id: "mockUserId",
      email: "mock@example.com",
      username: "mockUser",
      isAdmin: false,
      savedProducts: [],
    } as IUser;

    // Mock the request and response objects
    const mockRequest: any = {
      params: {
        userId: "mockUserId",
      },
    };

    const mockResponse = {
      status: jest.fn().mockReturnThis(),
      json: jest.fn(),
    } as unknown as Response;

    // Mock the getUserById function of the UserService
    (UserService.getUserById as jest.Mock).mockResolvedValueOnce(mockUser);

    // Call the getUserById controller
    await UserController.getUserById(mockRequest, mockResponse);

    // Expectations
    expect(UserService.getUserById).toHaveBeenCalledWith(
      mockRequest.params.userId
    );
    expect(mockResponse.status).toHaveBeenCalledWith(200);
    expect(mockResponse.json).toHaveBeenCalledWith(mockUser);
  }, 20000);

  // Test Case: User not found
  it("should handle case where user is not found", async () => {
    // Mock the request and response objects
    const mockRequest: any = {
      params: {
        userId: "nonexistentUserId",
      },
    };

    const mockResponse = {
      status: jest.fn().mockReturnThis(),
      json: jest.fn(),
    } as unknown as Response;

    // Mock the getUserById function of the UserService to return null
    (UserService.getUserById as jest.Mock).mockResolvedValueOnce(null);

    // Call the getUserById controller
    await UserController.getUserById(mockRequest, mockResponse);

    // Expectations
    expect(UserService.getUserById).toHaveBeenCalledWith(
      mockRequest.params.userId
    );
    expect(mockResponse.status).toHaveBeenCalledWith(404);
    expect(mockResponse.json).toHaveBeenCalledWith({ error: "User not found" });
  }, 20000);

  // Test Case: Error fetching user
  it("should handle error when fetching user by ID", async () => {
    // Mock the error response from the UserService
    const mockErrorResponse = {
      message: "Error fetching user",
    };

    // Mock the request and response objects
    const mockRequest: any = {
      params: {
        userId: "errorUserId",
      },
    };

    const mockResponse = {
      status: jest.fn().mockReturnThis(),
      json: jest.fn(),
    } as unknown as Response;

    // Mock the getUserById function of the UserService to throw an error
    (UserService.getUserById as jest.Mock).mockRejectedValueOnce(
      mockErrorResponse
    );

    // Call the getUserById controller
    await UserController.getUserById(mockRequest, mockResponse);

    // Expectations
    expect(UserService.getUserById).toHaveBeenCalledWith(
      mockRequest.params.userId
    );
    expect(mockResponse.status).toHaveBeenCalledWith(500);
    expect(mockResponse.json).toHaveBeenCalledWith({
      error: mockErrorResponse.message,
    });
  }, 20000);

  // Test Case: Delete user by ID
  it("should delete user by ID", async () => {
    // Mock the request and response objects
    const mockRequest: Request<
      { userId: string },
      any,
      any,
      any,
      Record<string, any>
    > = {
      params: {
        userId: "mockUserId",
      },
    } as Request<{ userId: string }, any, any, any, Record<string, any>>;

    const mockResponse = {
      status: jest.fn().mockReturnThis(),
      send: jest.fn(),
      json: jest.fn(),
    } as unknown as Response;

    // Mock the deleteUser function of the UserService
    (UserService.deleteUser as jest.Mock).mockResolvedValueOnce(null);

    // Call the deleteUser controller
    await UserController.deleteUser(mockRequest, mockResponse);

    // Expectations
    expect(UserService.deleteUser).toHaveBeenCalledWith(
      mockRequest.params.userId
    );
    expect(mockResponse.status).toHaveBeenCalledWith(204);
    expect(mockResponse.send).toHaveBeenCalled();
    expect(mockResponse.json).not.toHaveBeenCalled(); // Ensure json is not called for a 204 status
  }, 20000);
});

and src/__tests__/controllers/productController.test.ts and place the following code:

import { Request, Response } from "express";
import * as ProductController from "../../controllers/productController";
import * as ProductService from "../../services/productService";

// Mock the ProductService
jest.mock("../../services/productService");

describe("Product Controller Tests", () => {
  // Test Case: Create a new product
  it("should create a new product", async () => {
    // Mock the request and response objects
    const mockRequest: Request<{}, any, any, any, Record<string, any>> = {
      body: {
        title: "Mocked Product",
        description: "A description for the mocked product",
        image: "mocked_image.jpg",
        category: "Mocked Category",
        quantity: "10",
        inStock: true,
      },
    } as Request<{}, any, any, any, Record<string, any>>;

    const mockResponse = {
      status: jest.fn().mockReturnThis(),
      send: jest.fn(),
      json: jest.fn(),
    } as unknown as Response;

    // Mock the createProduct function of the ProductService
    (ProductService.createProduct as jest.Mock).mockResolvedValueOnce({
      _id: "mockedProductId",
      title: "Mocked Product",
      description: "A description for the mocked product",
      image: "mocked_image.jpg",
      category: "Mocked Category",
      quantity: "10",
      inStock: true,
    });

    // Call the createProduct controller
    await ProductController.createProduct(mockRequest, mockResponse);

    // Expectations
    expect(ProductService.createProduct).toHaveBeenCalledWith(mockRequest.body);
    expect(mockResponse.status).toHaveBeenCalledWith(201);
    expect(mockResponse.json).toHaveBeenCalledWith({
      _id: "mockedProductId",
      title: "Mocked Product",
      description: "A description for the mocked product",
      image: "mocked_image.jpg",
      category: "Mocked Category",
      quantity: "10",
      inStock: true,
    });
    expect(mockResponse.send).not.toHaveBeenCalled(); // Ensure send is not called for a 201 status
  });

  // Test Case: Get all products - Success
  it("should get all products successfully", async () => {
    // Mock the request and response objects
    const mockRequest: any = {};

    const mockResponse = {
      status: jest.fn().mockReturnThis(),
      send: jest.fn(),
      json: jest.fn(),
    } as unknown as Response;

    // Mock the getAllProducts function of the ProductService
    (ProductService.getAllProducts as jest.Mock).mockResolvedValueOnce([
      {
        _id: "mockedProductId1",
        title: "Mocked Product 1",
        description: "Description for mocked product 1",
        image: "image1.jpg",
        category: "Category 1",
        quantity: "5",
        inStock: true,
      },
      {
        _id: "mockedProductId2",
        title: "Mocked Product 2",
        description: "Description for mocked product 2",
        image: "image2.jpg",
        category: "Category 2",
        quantity: "10",
        inStock: false,
      },
    ]);

    // Call the getAllProducts controller
    await ProductController.getAllProducts(mockRequest, mockResponse);

    // Expectations
    expect(ProductService.getAllProducts).toHaveBeenCalled();
    expect(mockResponse.status).toHaveBeenCalledWith(200);
    expect(mockResponse.json).toHaveBeenCalledWith([
      {
        _id: "mockedProductId1",
        title: "Mocked Product 1",
        description: "Description for mocked product 1",
        image: "image1.jpg",
        category: "Category 1",
        quantity: "5",
        inStock: true,
      },
      {
        _id: "mockedProductId2",
        title: "Mocked Product 2",
        description: "Description for mocked product 2",
        image: "image2.jpg",
        category: "Category 2",
        quantity: "10",
        inStock: false,
      },
    ]);
    expect(mockResponse.send).not.toHaveBeenCalled(); // Ensure send is not called for a 200 status
  });

  // Test Case: Get all products - Error
  it("should handle errors when getting all products", async () => {
    // Mock the request and response objects
    const mockRequest: any = {};

    const mockResponse = {
      status: jest.fn().mockReturnThis(),
      send: jest.fn(),
      json: jest.fn(),
    } as unknown as Response;

    // Mock the getAllProducts function of the ProductService to throw an error
    (ProductService.getAllProducts as jest.Mock).mockRejectedValueOnce(
      new Error("Error getting products")
    );

    // Call the getAllProducts controller
    await ProductController.getAllProducts(mockRequest, mockResponse);

    // Expectations
    expect(ProductService.getAllProducts).toHaveBeenCalled();
    expect(mockResponse.status).toHaveBeenCalledWith(500);
    expect(mockResponse.json).toHaveBeenCalledWith({
      error: "Error getting products",
    });
    expect(mockResponse.send).not.toHaveBeenCalled(); // Ensure send is not called for a 500 status
  });

  // Test Case: Get product by ID - Success
  it("should get product by ID successfully", async () => {
    // Mock the request and response objects
    const mockRequest: Request = {
      params: { productId: "mockedProductId" },
    } as unknown as Request;

    const mockResponse = {
      status: jest.fn().mockReturnThis(),
      send: jest.fn(),
      json: jest.fn(),
    } as unknown as Response;

    // Mock the getProductById function of the ProductService
    (ProductService.getProductById as jest.Mock).mockResolvedValueOnce({
      _id: "mockedProductId",
      title: "Mocked Product",
      description: "Description for mocked product",
      image: "mocked_image.jpg",
      category: "Mocked Category",
      quantity: "10",
      inStock: true,
    });

    // Call the getProductById controller
    await ProductController.getProductById(mockRequest, mockResponse);

    // Expectations
    expect(ProductService.getProductById).toHaveBeenCalledWith(
      "mockedProductId"
    );
    expect(mockResponse.status).toHaveBeenCalledWith(200);
    expect(mockResponse.json).toHaveBeenCalledWith({
      _id: "mockedProductId",
      title: "Mocked Product",
      description: "Description for mocked product",
      image: "mocked_image.jpg",
      category: "Mocked Category",
      quantity: "10",
      inStock: true,
    });
    expect(mockResponse.send).not.toHaveBeenCalled(); // Ensure send is not called for a 200 status
  });

  // Test Case: Get product by ID - Not Found
  it("should handle product not found when getting by ID", async () => {
    // Mock the request and response objects
    const mockRequest: Request = {
      params: { productId: "nonExistentProductId" },
    } as unknown as Request;

    const mockResponse = {
      status: jest.fn().mockReturnThis(),
      send: jest.fn(),
      json: jest.fn(),
    } as unknown as Response;

    // Mock the getProductById function of the ProductService to return null
    (ProductService.getProductById as jest.Mock).mockResolvedValueOnce(null);

    // Call the getProductById controller
    await ProductController.getProductById(mockRequest, mockResponse);

    // Expectations
    expect(ProductService.getProductById).toHaveBeenCalledWith(
      "nonExistentProductId"
    );
    expect(mockResponse.status).toHaveBeenCalledWith(404);
    expect(mockResponse.json).toHaveBeenCalledWith({
      error: "Product not found",
    });
    expect(mockResponse.send).not.toHaveBeenCalled(); // Ensure send is not called for a 404 status
  });

  // Test Case: Get product by ID - Error
  it("should handle errors when getting product by ID", async () => {
    // Mock the request and response objects
    const mockRequest: Request = {
      params: { productId: "mockedProductId" },
    } as unknown as Request;

    const mockResponse = {
      status: jest.fn().mockReturnThis(),
      send: jest.fn(),
      json: jest.fn(),
    } as unknown as Response;

    // Mock the getProductById function of the ProductService to throw an error
    (ProductService.getProductById as jest.Mock).mockRejectedValueOnce(
      new Error("Error getting product by ID")
    );

    // Call the getProductById controller
    await ProductController.getProductById(mockRequest, mockResponse);

    // Expectations
    expect(ProductService.getProductById).toHaveBeenCalledWith(
      "mockedProductId"
    );
    expect(mockResponse.status).toHaveBeenCalledWith(500);
    expect(mockResponse.json).toHaveBeenCalledWith({
      error: "Error getting product by ID",
    });
    expect(mockResponse.send).not.toHaveBeenCalled(); // Ensure send is not called for a 500 status
  });

  // Test Case: Update product by ID - Success
  it("should update product by ID successfully", async () => {
    // Mock the request and response objects
    const mockRequest: Request = {
      params: { productId: "mockedProductId" },
      body: {
        title: "Updated Product",
        description: "Updated description",
        image: "updated_image.jpg",
        category: "Updated Category",
        quantity: "15",
        inStock: false,
      },
    } as unknown as Request;

    const mockResponse = {
      status: jest.fn().mockReturnThis(),
      send: jest.fn(),
      json: jest.fn(),
    } as unknown as Response;

    // Mock the updateProduct function of the ProductService
    (ProductService.updateProduct as jest.Mock).mockResolvedValueOnce({
      _id: "mockedProductId",
      title: "Updated Product",
      description: "Updated description",
      image: "updated_image.jpg",
      category: "Updated Category",
      quantity: "15",
      inStock: false,
    });

    // Call the updateProduct controller
    await ProductController.updateProduct(mockRequest, mockResponse);

    // Expectations
    expect(ProductService.updateProduct).toHaveBeenCalledWith(
      "mockedProductId",
      mockRequest.body
    );
    expect(mockResponse.status).toHaveBeenCalledWith(200);
    expect(mockResponse.json).toHaveBeenCalledWith({
      _id: "mockedProductId",
      title: "Updated Product",
      description: "Updated description",
      image: "updated_image.jpg",
      category: "Updated Category",
      quantity: "15",
      inStock: false,
    });
    expect(mockResponse.send).not.toHaveBeenCalled(); // Ensure send is not called for a 200 status
  });

  // Test Case: Update product by ID - Not Found
  it("should handle product not found when updating by ID", async () => {
    // Mock the request and response objects
    const mockRequest: Request = {
      params: { productId: "nonExistentProductId" },
      body: {
        title: "Updated Product",
        description: "Updated description",
        image: "updated_image.jpg",
        category: "Updated Category",
        quantity: "15",
        inStock: false,
      },
    } as unknown as Request;

    const mockResponse = {
      status: jest.fn().mockReturnThis(),
      send: jest.fn(),
      json: jest.fn(),
    } as unknown as Response;

    // Mock the updateProduct function of the ProductService to return null
    (ProductService.updateProduct as jest.Mock).mockResolvedValueOnce(null);

    // Call the updateProduct controller
    await ProductController.updateProduct(mockRequest, mockResponse);

    // Expectations
    expect(ProductService.updateProduct).toHaveBeenCalledWith(
      "nonExistentProductId",
      mockRequest.body
    );
    expect(mockResponse.status).toHaveBeenCalledWith(404);
    expect(mockResponse.json).toHaveBeenCalledWith({
      error: "Product not found",
    });
    expect(mockResponse.send).not.toHaveBeenCalled(); // Ensure send is not called for a 404 status
  });

  // Test Case: Update product by ID - Error
  it("should handle errors when updating product by ID", async () => {
    // Mock the request and response objects
    const mockRequest: Request = {
      params: { productId: "mockedProductId" },
      body: {
        title: "Updated Product",
        description: "Updated description",
        image: "updated_image.jpg",
        category: "Updated Category",
        quantity: "15",
        inStock: false,
      },
    } as unknown as Request;

    const mockResponse = {
      status: jest.fn().mockReturnThis(),
      send: jest.fn(),
      json: jest.fn(),
    } as unknown as Response;

    // Mock the updateProduct function of the ProductService to throw an error
    (ProductService.updateProduct as jest.Mock).mockRejectedValueOnce(
      new Error("Error updating product by ID")
    );

    // Call the updateProduct controller
    await ProductController.updateProduct(mockRequest, mockResponse);

    // Expectations
    expect(ProductService.updateProduct).toHaveBeenCalledWith(
      "mockedProductId",
      mockRequest.body
    );
    expect(mockResponse.status).toHaveBeenCalledWith(500);
    expect(mockResponse.json).toHaveBeenCalledWith({
      error: "Error updating product by ID",
    });
    expect(mockResponse.send).not.toHaveBeenCalled(); // Ensure send is not called for a 500 status
  });

  // Test Case: Delete product by ID - Success
  it("should delete product by ID successfully", async () => {
    // Mock the request and response objects
    const mockRequest: Request = {
      params: { productId: "mockedProductId" },
    } as unknown as Request;

    const mockResponse = {
      status: jest.fn().mockReturnThis(),
      send: jest.fn(),
    } as unknown as Response;

    // Call the deleteProduct function of the ProductService
    await ProductController.deleteProduct(mockRequest, mockResponse);

    // Expectations
    expect(ProductService.deleteProduct).toHaveBeenCalledWith(
      "mockedProductId"
    );
    expect(mockResponse.status).toHaveBeenCalledWith(204);
    expect(mockResponse.send).toHaveBeenCalled();
  });

  // Test Case: Delete product by ID - Not Found
  it("should handle product not found when deleting by ID", async () => {
    // Mock the request and response objects
    const mockRequest: Request = {
      params: { productId: "nonExistentProductId" },
    } as unknown as Request;

    const mockResponse = {
      status: jest.fn().mockReturnThis(),
      send: jest.fn(),
      json: jest.fn(),
    } as unknown as Response;

    // Mock the deleteProduct function of the ProductService to return null
    (ProductService.deleteProduct as jest.Mock).mockResolvedValueOnce(null);

    // Call the deleteProduct controller
    await ProductController.deleteProduct(mockRequest, mockResponse);

    // Expectations
    expect(ProductService.deleteProduct).toHaveBeenCalledWith(
      "nonExistentProductId"
    );
    expect(mockResponse.status).toHaveBeenCalledWith(204);
    expect(mockResponse.send).toHaveBeenCalled();
    expect(mockResponse.json).not.toHaveBeenCalled(); // Ensure json is not called for a 204 status
  });

  // Test Case: Delete product by ID - Error
  it("should handle errors when deleting product by ID", async () => {
    // Mock the request and response objects
    const mockRequest: Request = {
      params: { productId: "mockedProductId" },
    } as unknown as Request;

    const mockResponse = {
      status: jest.fn().mockReturnThis(),
      send: jest.fn(),
      json: jest.fn(),
    } as unknown as Response;

    // Mock the deleteProduct function of the ProductService to throw an error
    (ProductService.deleteProduct as jest.Mock).mockRejectedValueOnce(
      new Error("Error deleting product by ID")
    );

    // Call the deleteProduct controller
    await ProductController.deleteProduct(mockRequest, mockResponse);

    // Expectations
    expect(ProductService.deleteProduct).toHaveBeenCalledWith(
      "mockedProductId"
    );
    expect(mockResponse.status).toHaveBeenCalledWith(500);
    expect(mockResponse.json).toHaveBeenCalledWith({
      error: "Error deleting product by ID",
    });
    expect(mockResponse.send).not.toHaveBeenCalled(); // Ensure send is not called for a 500 status
  });
});
In the test suite for the User Controller, we employ thorough mocking using jest.mock to isolate the UserService, ensuring controlled testing of the controller's functionalities. Each test case is meticulously crafted to cover key aspects of user management, such as creating a new user, user login, fetching all users, retrieving a user by ID, handling scenarios where the user is not found, and deleting a user by ID. The suite demonstrates the usage of precise mock data and expectations, validating the User Controller's reliability. Notably, the jest.mock line is crucial, replacing the actual UserService with a mock implementation to create a controlled environment for testing. This approach ensures that the tests focus solely on the User Controller's behavior without interference from external dependencies. This testing strategy aims to deliver a secure, efficient, and error-resilient user management system in our backend API.

In the Product Controller Tests test suite for the Product Controller, we orchestrate a comprehensive set of scenarios to validate the functionality of the controller methods. The tests cover creating a new product, fetching all products (both successful and error cases), retrieving a product by ID (with successful, not found, and error scenarios), updating a product by ID (again, covering success, not found, and error cases), and finally, deleting a product by ID (encompassing successful, not found, and error scenarios). Each test is structured with meticulous mock data, expectations, and error handling, ensuring a robust examination of the Product Controller's behavior. The jest.mock("../../services/productService") helps us to isolate the ProductService for controlled testing.
All set for our controllers, lets also discuss how we write tests for our routes.

Writing Unit Tests for Routes
Before we start to write our unit tests for all our routes, we need to first examine our setup and make some adjustments.
First we need to isolate a testing server to avoid conflicts testing various suites for different routes.
Create a new file in the root directory, call it: test_setup.ts and place the following code:

import app from "./src/index"; // Import your main app from the index file

const port = 9000; // Choose a suitable port

const test_server = app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});

export default test_server;

This helps us interact with the testing server instead of using the actual server of ours running at port 8800.
Lets also add the following line to our .env file:

TEST_ENV=true
and start our main server conditionally in our src/index.ts according to TEST_ENV environment variable.
Replace:

 app.listen(PORT, () => {
    console.log(`Backend server is running at port ${PORT}`);
  });
with

// Check if it's not a test environment before starting the server
if (!process.env.TEST_ENV) {
  app.listen(PORT, () => {
    console.log(`Backend server is running at port ${PORT}`);
  });
}
to start our main server only if we are not testing mode.
Don't forget to alter the TEST_ENV by setting it to false when youre done running unit tests or when you get in production.

Create a new file: src/__tests__/routes/userRoutes.test.ts and place the following code:

// userRoutes.test.ts
import request from "supertest";
import test_server from "../../../test_setup";

import User from "../../models/User";
import supertest from "supertest";

// You can either test with a real token like this:
const adminToken = "YourAdminToken";
// Alternatively:
const nonAdminToken = "YourNonAdminToken";
// OR
// Write a function that simulates an actual login process and extract the token from there
// And then store it in a variable for use in various test cases e.g:
// Assuming you have admin credentials for testing

// const adminCredentials = {
//   email: "admin@example.com",
//   password: "adminpassword",
// };

// Assuming you have a function to generate an authentication token
// const getAuthToken = async () => {
//   const response = await supertest(test_server)
//     .post("/api/v1/users/login")
//     .send(adminCredentials);
//   return response.body.token;
// };

// Get the admin authentication token (inside an async function or code block)
// const authToken = await getAuthToken();

// ------------------> do the same for non admin user and store the token in
// its own variable

describe("User Routes", () => {
  beforeAll(async () => {});

  // Clean up after tests
  afterAll(async () => {
    // Remove the created user
    await User.deleteOne({
      username: "testuser",
    });

    // Clear all jest mocks
    jest.clearAllMocks();
    test_server.close();
  });

  // Test case for creating a new user
  it("should create a new user", async () => {
    const response = await request(test_server)
      .post("/api/v1/users/create") // Update the route path accordingly
      .send({
        // Your user data for testing
        email: "admin@example.com",
        password: "adminpassword",
        username: "testuser",
        isAdmin: false,
        savedProducts: [],
      });

    // Expectations
    expect(response.status).toBe(201);
    expect(response.body).toHaveProperty("email", "admin@example.com");
    expect(response.body).toHaveProperty("username", "testuser");
    // Add more expectations based on your user data

    // Optionally, you can store the created user for future tests
    const createdUser = response.body;
  }, 20000);

  // Test case for logging in a user
  it("should login a user and return a token", async () => {
    // Assuming you have a test user created previously
    const testUser = {
      email: "admin@example.com",
      password: "adminpassword",
    };

    const response = await request(test_server)
      .post("/api/v1/users/login") // Update the route path accordingly
      .send({
        email: testUser.email,
        password: testUser.password,
      });

    // Expectations
    expect(response.status).toBe(200);
    expect(response.body).toHaveProperty("user");
    expect(response.body).toHaveProperty("token");
    // Add more expectations based on your login data

    // Optionally, you can store the token for future authenticated requests
    const authToken = response.body.token;
  }, 20000);

  // Assuming you have admin credentials for testing
  const adminCredentials = {
    email: "admin@example.com",
    password: "adminpassword",
  };

  // Assuming you have a function to generate an authentication token
  const getAuthToken = async (credentials: object) => {
    const response = await supertest(test_server)
      .post("/api/v1/users/login")
      .send(credentials);
    return response.body.token;
  };

  // Test case for getting all users (admin access)
  it("should get all users with admin access", async () => {
    // Assuming you have admin credentials for testing
    const adminCredentials = {
      email: "admin@example.com",
      password: "adminpassword",
    };

    // Log in as admin to get the admin token
    // const adminToken = await getAuthToken(adminCredentials);

    // Send a request to the route with the admin token
    const response = await request(test_server)
      .get("/api/v1/users/all")
      .set("token", `Bearer ${adminToken}`);

    // Expectations
    expect(response.status).toBe(200);
    // Add more expectations based on your user data

    // Optionally, you can store the users for further assertions
    const allUsers = response.body;
  }, 20000);

  // Test case for getting all users without admin access
  it("should return 403 Forbidden when accessing all users without admin access", async () => {
    // Assuming you have non-admin credentials for testing
    const nonAdminCredentials = {
      email: "nonadmin@example.com",
      password: "nonadminpassword",
    };

    // Log in as non-admin to get the non-admin token
    // const nonAdminToken = await getAuthToken(nonAdminCredentials);

    // Send a request to the route with the non-admin token
    const response = await request(test_server)
      .get("/api/v1/users/all")
      .set("token", `Bearer ${nonAdminToken}`);

    // Expectations
    expect(response.status).toBe(403);
    // Add more expectations based on how you handle non-admin access
  }, 20000);

  // Test case: Should successfully update a user with valid credentials (admin or account owner)
  it("should successfully update a user with valid credentials (admin or account owner)", async () => {
    // Assuming you have a test user created previously
    // If you dont have you can create one programattically like we did writing
    // Tests for create new user

    const testUser = {
      email: "testuser@example.com",
      password: "testuserpassword",
      username: "testuser",
    };

    // Update the user using the hardcoded token
    const updateResponse = await request(test_server)
      .put(`/api/v1/users/update/6593ca275db905747ea085aa`)
      .set("token", `Bearer ${adminToken}`)
      .send({
        // Your updated user data
        username: "updateduser",
      });

    // Expectations
    expect(updateResponse.status).toBe(200);
    expect(updateResponse.body).toHaveProperty("username", "updateduser");
    // Add more expectations based on your updated user data
  }, 20000);

  // Test case: Should return 403 Forbidden when updating a user without valid credentials
  it("should return 403 Forbidden when updating a user without valid credentials", async () => {
    // Assuming you have a different user for testing
    const otherUserCredentials = {
      email: "otheruser@example.com",
      password: "otheruserpassword",
      username: "otheruser",
    };

    // Create a different user
    const createResponse = await request(test_server)
      .post("/api/v1/users/create")
      .send(otherUserCredentials);

    // Get the ID of the created user
    const otherUserId = createResponse.body._id;

    // Attempt to update the user without valid credentials (not admin or account owner)
    const updateResponse = await request(test_server)
      .put(`/api/v1/users/update/${otherUserId}`)
      .set("token", `Bearer ${nonAdminToken}`)
      .send({
        // Your updated user data
        username: "updateduser",
      });

    // Expectations
    expect(updateResponse.status).toBe(403);
    // Add more expectations based on how you handle non-authorized updates
  }, 20000);

  // Test case: Should successfully delete a user with valid credentials (admin or account owner)
  it("should successfully delete a user with valid credentials (admin or account owner)", async () => {
    // Assuming you have a test user created previously
    const testUser = {
      email: "testuser@example.com",
      password: "testuserpassword",
      username: "testuser",
    };

    // Create a test user
    const createResponse = await request(test_server)
      .post("/api/v1/users/create")
      .send(testUser);

    // Get the ID of the created user
    const userId = createResponse.body._id;

    // Log the ID to check if it's correct
    console.log("User ID:", userId);

    // Delete the user using the hardcoded token
    const deleteResponse = await request(test_server)
      .delete(`/api/v1/users/delete/${userId}`)
      .set("token", `Bearer ${adminToken}`);

    // Expectations
    expect(deleteResponse.status).toBe(204);
  }, 20000);
});
and another file:
src/__tests__/routes/productRoutes.test.ts and place the following code:

import request from "supertest";
import test_server from "../../../test_setup";
import supertest from "supertest";

// You can either test with a real token like this:
const adminToken = "YourAdminToken";
// Alternatively:
const nonAdminToken = "YourNonAdminToken";

// OR
// Write a function that simulates an actual login process and extract the token from there
// And then store it in a variable for use in various test cases e.g:
// Assuming you have admin credentials for testing

// const adminCredentials = {
//   email: "admin@example.com",
//   password: "adminpassword",
// };

// Assuming you have a function to generate an authentication token
// const getAuthToken = async () => {
//   const response = await supertest(test_server)
//     .post("/api/v1/users/login")
//     .send(adminCredentials);
//   return response.body.token;
// };

// Get the admin authentication token (inside an async function or code block)
// const authToken = await getAuthToken();

// ------------------> do the same for non admin user and store the token in
// its own variable

// Assuming you have a test product data
const testProduct = {
  title: "Test Product",
  description: "This is a test product",
  image: "test-image.jpg",
  category: "Test Category",
  quantity: "10",
  inStock: true,
};
describe("User Routes", () => {
  // Test case: Should successfully create a new product with valid admin credentials
  it("should successfully create a new product with valid admin credentials", async () => {
    // Create a new product using the admin token
    const createResponse = await request(test_server)
      .post("/api/v1/products/create")
      .set("token", `Bearer ${adminToken}`)
      .send(testProduct);

    // Expectations
    expect(createResponse.status).toBe(201);
    expect(createResponse.body).toHaveProperty("title", "Test Product");
    // Add more expectations based on your product data
  }, 20000);

  // Test case: Should successfully get all products without authentication
  it("should successfully get all products without authentication", async () => {
    // Make a request to the endpoint without providing an authentication token
    const response = await request(test_server).get("/api/v1/products/all");

    // Expectations
    expect(response.status).toBe(200);
    // Add more expectations based on your implementation
  }, 20000);

  // Test case: Should successfully get a product by ID with a valid token
  it("should successfully get a product by ID with a valid token", async () => {
    // Assuming you have a product ID for testing
    const productId = "6593e048731070abb0939faf";

    // Make a request to the endpoint with a valid token and product ID
    const response = await request(test_server)
      .get(`/api/v1/products/${productId}`)
      .set("token", `Bearer ${adminToken}`);

    // Expectations
    expect(response.status).toBe(200);
    // Add more expectations based on your implementation
  }, 20000);

  // Test case: Should successfully update a product by ID with admin access
  it("should successfully update a product by ID with admin access", async () => {
    // Assuming you have a product ID for testing
    const productId = "6593e048731070abb0939faf";

    // Replace 'yourUpdatedProductData' with the data you want to update the product with
    const updatedProductData = {
      title: "Updated Product",
      description: "Updated Product Description",
      // Add more fields as needed
    };

    // Make a request to the endpoint with an admin token and product ID
    const response = await request(test_server)
      .put(`/api/v1/products/update/${productId}`)
      .set("token", `Bearer ${adminToken}`)
      .send(updatedProductData);

    // Expectations
    expect(response.status).toBe(200);
    // Add more expectations based on your implementation
  }, 20000);

  // Test case: Should successfully delete a product by ID with admin access
  it("should successfully delete a product by ID with admin access", async () => {
    // Assuming you have a product ID for testing
    const productId = "6593e0a5451f5e47ce363e00";

    // Make a request to the endpoint with an admin token and product ID
    const response = await request(test_server)
      .delete(`/api/v1/products/delete/${productId}`)
      .set("token", `Bearer ${adminToken}`);

    // Expectations
    expect(response.status).toBe(204);
    // Add more expectations based on your implementation
  }, 20000);
});

afterAll(() => {
  test_server.close();
});

In our routes files like src/routes/userRoutes.ts, our routes donot include the prefix /api/v1 as its only included in the src/index.ts file where the src/routes/index.ts is imported and included. However,dont forget to add it while writing unit tests for all the routes as they will all return a 404 status code in its absence.

Our tests involve usage of our utility functions, JWT middlewares in src/utils/jwtUtils.ts so lets first complete their unit tests in a separate file: src/__tests__/utils/jwtAuth.test.ts with the following code:

import {
  verifyTokenAndAdmin,
  verifyTokenAndAuthorization,
} from "../../utils/jwtUtils";
import dotenv from "dotenv";
dotenv.config();

// Mock token for testing purposes
const mockTokenForNonAdmin = "YourMockTokenForNonAdmin";

const mockTokenForAdmin = "YourMockTokenForAdmin";
// You can also simulate an actual login process,
// extract the token and store it in a variable like this:

// const adminCredentials = {
//   email: "admin@example.com",
//   password: "adminpassword",
// };

// Assuming you have a function to generate an authentication token
// const getAuthToken = async () => {
//   const response = await supertest(test_server)
//     .post("/api/v1/users/login")
//     .send(adminCredentials);
//   return response.body.token;
// };

// Get the admin authentication token (inside an async function or code block)
// const authToken = await getAuthToken();

// Authorization Test Cases
describe("Authorization Tests", () => {
  // Test Case: Verify Token and Authorization (valid token and authorization)
  it("should verify a valid JWT token and authorization", (done) => {
    const req: any = {
      headers: {
        token: `Bearer ${mockTokenForNonAdmin}`,
      },
      user: {
        id: "mockUserId",
        isAdmin: false,
      },
      params: {
        id: "mockUserId",
      },
    };

    const res: any = {
      status: () => res, // Mock status function
      json: (message: string) => {
        // Assert the message or other expectations
        expect(req.user).toBeDefined();
        done();
      },
    };

    const next = () => {
      // Should not reach here
      done.fail("Should not reach next middleware on valid token");
    };

    verifyTokenAndAuthorization(req, res, next);
  });

  // Test Case: Verify Token and Authorization (unauthorized)
  it("should handle unauthorized access for authorization", (done) => {
    const req: any = {
      headers: {
        token: `Bearer ${mockTokenForNonAdmin}`,
      },
      user: {
        id: "otherUserId",
        isAdmin: false,
      },
      params: {
        id: "mockUserId",
      },
    };

    const res: any = {
      status: () => res, // Mock status function
      json: (message: string) => {
        // Assert the message or other expectations
        expect(message).toBe("You are not allowed to do that!");
        done();
      },
    };

    const next = () => {
      // Should not reach here
      done.fail("Should not reach next middleware on unauthorized access");
    };

    verifyTokenAndAuthorization(req, res, next);
  });
});

// Admin Access Test Cases
describe("Admin Access Tests", () => {
  // Test Case: Verify Token and Admin Access (valid token and admin)
  it("should verify a valid JWT token and admin access", (done) => {
    const req: any = {
      headers: {
        token: `Bearer ${mockTokenForNonAdmin}`,
      },
      user: {
        id: "mockUserId",
        isAdmin: true,
      },
      params: {
        id: "mockUserId",
      },
    };

    const res: any = {
      status: () => res, // Mock status function
      json: (message: string) => {
        // Assert the message or other expectations
        expect(req.user).toBeDefined();
        done();
      },
    };

    const next = () => {
      // Should not reach here
      done.fail(
        "Should not reach next middleware on valid token and admin access"
      );
    };

    verifyTokenAndAdmin(req, res, next);
  });

  // Test Case: Verify Token and Admin Access (non-admin)
  it("should handle non-admin access for admin authorization", (done) => {
    const req: any = {
      headers: {
        token: `Bearer ${mockTokenForNonAdmin}`,
      },
      user: {
        id: "mockUserId",
        isAdmin: false,
      },
      params: {
        id: "mockUserId",
      },
    };

    const res: any = {
      status: () => res, // Mock status function
      json: (message: string) => {
        // Assert the message or other expectations
        expect(message).toBe("You are not allowed to do that!");
        done();
      },
    };

    const next = () => {
      // Should not reach here
      done.fail("Should not reach next middleware on non-admin access");
    };

    verifyTokenAndAdmin(req, res, next);
  });
});

This suite has robust test cases to verify the functionality of two crucial middleware functions, verifyTokenAndAuthorization and verifyTokenAndAdmin, and is an intergral part of our previous tests written in src/__tests__/utils/jwtUtils.test.ts.

In the "Authorization Tests" section, we meticulously validate the proper functioning of token validation and authorization. We take pride in ensuring that our application accurately handles scenarios where a valid JWT token is presented along with appropriate authorization, as well as scenarios where unauthorized access is attempted, with clear error messages to guide the user.

Moving on to the "Admin Access Tests" section, we continue to demonstrate our dedication to a secure user access control system. Our tests encompass scenarios where valid tokens with admin privileges are successfully processed, and where non-admin users encounter appropriate error messages when attempting admin-protected actions.

By employing mocked request (req), response (res), and the next function, we simulate the middleware execution flow during testing. The use of the done callback underscores our commitment to thorough and reliable asynchronous testing methodologies.

In essence, our test suite for these middleware functions serves as a testament to our unwavering commitment to delivering a secure and robust Express.js application, ensuring that token verification, authorization, and admin access control are implemented with the utmost precision and reliability.

In our User Routes test suite, we ensure the robust functionality of various endpoints within our Express.js application. Leveraging the Supertest library, we validate the creation, login, retrieval, update, and deletion of user data. By employing both admin and non-admin tokens, we meticulously simulate scenarios that cover a spectrum of user access levels. Our tests underscore the meticulousness with which we handle user authentication, authorization, and access control, providing a solid foundation for the secure operation of our application. Furthermore, we prioritize cleanliness by incorporating cleanup procedures, inside afterAll method, to remove test users after execution, demonstrating our commitment to maintaining a pristine testing environment. With these tests, we confidently assure the reliability and security of our User Routes, fostering a robust user management system within our application.

On the otherhand, our Product Routes suite orchestrates a meticulous examination of various product endpoints to guarantee the seamless operation of our Express.js application. The tests encompass the creation, retrieval, update, and deletion of products, ensuring their secure management. The initiation of a new product with valid admin credentials is rigorously validated, emphasizing our commitment to robust functionality. Furthermore, we ensure that product retrieval, whether by ID or not, transpires smoothly, even in the absence of authentication. For administrative tasks like updating and deleting products, our suite validates the integrity of these operations with precision. Each test is meticulously crafted to assess the application's response under different scenarios, solidifying our confidence in the resilience and reliability of our Product Routes. Following the suite's execution, we gracefully close the server, maintaining an orderly testing environment.

By now you should have an output in the terminal with this ending:
Image description
Indicating that all the tests succeeded.
The Snapshots: 0 total message indicates that no Jest snapshots were created or updated during the test run. Snapshots in Jest are a way to automatically capture the output of a component or data structure and compare it against future changes to detect unintended changes.
Jest snapshots are often used in front-end testing, especially for UI components to capture the rendered output of components and help identify unintended changes. For our backend API, we were mostly dealing with server-side logic, database interactions, and APIs, snapshots were less critical which is why we dont have any.
Test Suites: 12 passed, 12 total mean we have 12 test suites and they all passed and Tests: 66 passed, 66 total means we have 66 tests and they all passed.
As you can see, opposed to rumours from most developers that unit testing is hard, its truly not hard given time but time consuming instead though worth it as previously discussed.

Overall Sammary
Embarking on a three-phase voyage, our article delved into the realm of Node.js and TypeScript development, sculpting a masterpiece of efficiency and reliability. In the inaugural phase, we meticulously established a robust environment, configuring the stage with precision using tools like Jest, Supertest among others. With the foundation laid, our journey traversed the expansive landscape of building a dynamic API with Express, navigating the intricacies of routing, controllers, and middleware. Finally, as our opus neared completion, we explored the symphony of unit testing, employing Jest and Supertest to ensure our code's fortitude. This trilogy encapsulates not just the process but the artistry behind crafting resilient, scalable, and well-tested Node.js applications in TypeScript, leaving developers equipped and inspired for their own epic odyssey in the world of software development.

Conclusion
In the symphony of Node.js and TypeScript development, orchestrating harmony through unit testing with Jest and Supertest, coupled with the formidable MongoDB and Mongoose ORM in the grandeur of Express, transforms the software development journey into an enlightened expedition. Through meticulous testing, we've navigated the intricacies of our codebase, ensuring resilience and reliability. With Jest as our virtuoso conductor, and Supertest as the keen-eared observer, the seamless integration of MongoDB and Mongoose has rendered our Express applications not just functional, but robust and secure. As we conclude this odyssey through the landscape of unit testing, we embrace a future where our code stands as a testament to its own quality, a melody composed with precision and played with confidence in the ever-evolving symphony of software development. May your code remain harmonious, your tests unwavering, and your development journey a continual crescendo of success.
Integration and End-to-End Tests Made Easy With Node.js and MongoDB
Integration and End-to-End Tests Made Easy With Node.js and MongoDB
Interacting with a real database during integration and end-to-end testing can pose distinct challenges. An effective workaround is to use an in-memory database that integrates seamlessly with your testing framework and provides APIs for manipulating state directly from your test code.

In this article, Toptal Software Engineer Mikhail Angelov demonstrates how to do just that—and how to write straightforward integration and end-to-end tests for Node.js and MongoDB applications without the need for complicated setup/teardown code.

authors are vetted experts in their fields and write on topics in which they have demonstrated experience. All of our content is peer reviewed and validated by Toptal experts in the same field.
Mikhail Angelov
By
Mikhail Angelov
Verified Expert 
in Engineering
22 Years of Experience
Mikhail is a full-stack engineer specializing in JavaScript, React, Node.js, Flux, and Redux. His industry experience spans firmware, mobile, and web development in areas including finance, insurance, and transportation technology. He also holds a master’s degree in physics.

Expertise
JavaScript
React.js
Previous Role
Full-stack Engineer
Previously At

Cruise

Share this article
Tests are an essential part of building a robust Node.js application. Proper tests can easily overcome a lot of shortcomings that developers may point out about Node.js development solutions.

While many developers focus on 100% coverage with unit tests, it is important that the code you write is not just tested in isolation. Integration and end-to-end tests give you that extra confidence by testing parts of your application together. These parts may be working just fine on their own, but in a large system, units of code rarely work separately.

Node.js and MongoDB together form one of the most popular duos of recent times. If you happen to be one of the many people using them, you are in luck.

In this article, you will learn how to write integration and end-to-end tests easily for your Node.js and MongoDB application that run on real instances of the database all without needing to set up an elaborate environment or complicated setup/teardown code.

You will see how the mongo-unit package helps with integration and end-to-end testing in Node.js. For a more comprehensive overview of Node.js integration tests, see this article.

Dealing with a Real Database
Typically, for integration or end-to-end tests, your scripts will need to connect to a real dedicated database for testing purposes. This involves writing code that runs at the beginning and end of every test case/suite to ensure that the database is in a clean predictable state.

This may work well for some projects, but has some limitations:

The testing environment can be quite complex. You will need to keep the database running somewhere. This often requires extra effort to set up with CI servers.
The database and the operations can be relatively slow. Since the database will use network connections and the operations will require file system activity, it may not be easy to run thousands of tests quickly.
The database keeps state, and it’s not very convenient for tests. Tests should be independent of each other, but using a common DB could make one test affect others.
On the other hand, using a real database makes the test environment as close to production as possible. This can be looked at as a particular advantage of this approach.

Using a Real, In-Memory Database
Using a real database for testing does seem to have some challenges. But, the advantage of using a real database is too good to pass on. How can we work around the challenges and keep the advantage?

Reusing a good solution from another platform and applying it to the Node.js world can be the way to go here.

Java projects widely use DBUnit with an in-memory database (e.g., H2) for this purpose.

DBUnit is integrated with JUnit (the Java test runner) and lets you define the database state for each test/testing suite, etc. It removes the constraints discussed above:

DBUnit and H2 are Java libraries, so you do not need to set up an extra environment. It all runs in the JVM.
The in-memory database makes this state management very fast.
DBUnit makes the database configuration very simple and allows you to keep a clear database state for each case.
H2 is a SQL database and it is partially compatible with MySQL so, in major cases, the application can work with it as with a production database.
Taking from these concepts, I decided to make something similar for Node.js and MongoDB: Mongo-unit.

Mongo-unit is a Node.js package that can be installed using npm or Yarn. It runs MongoDB in-memory. It makes integration tests easy by integrating well with Mocha and providing a simple API to manage the database state.

The library uses the mongodb-prebuilt npm package, which contains prebuilt MongoDB binaries for the popular operating systems. These MongoDB instances can run in in-memory mode.

Installing Mongo-unit
To add mongo-unit to your project, you can run:

npm install -D mongo-unit
or

yarn add mongo-unit
And, that is it. You do not even need MongoDB installed on your computer to use this package.

Using Mongo-unit for Integration Tests
Let’s imagine you have a simple Node.js application to manage tasks:

// service.js

const mongoose = require('mongoose')
const mongoUrl = process.env.MONGO_URL || 'mongodb://localhost:27017/example'

let client
mongoose.connect(mongoUrl).then(c => {
  client = c
})
const Task = mongoose.model('tasks', {
  name: String,
  started: Date,
  completed: Boolean,
})

module.exports = {
  getTasks: () => Task.find(),
  addTask: data => new Task(data).save(),
  deleteTask: taskId => Task.findOneAndDelete({ _id: taskId }),
  getClient: () => client,
}
The MongoDB connection URL is not hard-coded here. As with most web application back-ends, we are taking it from the environment variable. This will let us substitute it for any URL during tests.

// index.js

const express = require('express')
const bodyParser = require('body-parser')
const service = require('./service')
const app = express()
app.use(bodyParser.json())

app.use(express.static(`${__dirname}/static`))
app.get('/example', (req, res) => {
 service.getTasks().then(tasks => res.json(tasks))
})
app.post('/example', (req, res) => {
 service.addTask(req.body).then(data => res.json(data))
})
app.delete('/example/:taskId', (req, res) => {
 service.deleteTask(req.params.taskId).then(data => res.json(data))
})
app.listen(3000, () => console.log('started on port 3000'))
This is a snippet of an example application that has a user interface. The code for the UI has been omitted for brevity. You can check out the complete example on GitHub.

Integrating with Mocha
To make Mocha run integration tests against mongo-unit, we need to run the mongo-unit database instance before the application code is loaded in the Node.js context. To do this, we can use the mocha --require parameter and Mocha-prepare library, which allows you to perform asynchronous operations in the require scripts.

// it-helper.js
const prepare = require('mocha-prepare')
const mongoUnit = require('mongo-unit')

prepare(done => mongoUnit.start()
 .then(testMongoUrl => {
   process.env.MONGO_URL = testMongoUrl
   done()
 }))
Writing Integration Tests
The first step is to add a test to the test database (testData.json):

{
   "tasks": [
   {
     "name": "test",
     "started": "2023-08-28T16:07:38.268Z",
     "completed": false
   }
 ]
}
The next step is to add the tests themselves:

// test.it.js

const expect = require('chai').expect
const mongoose = require('mongoose')
const mongoUnit = require('../index')
const service = require('./app/service')
const testMongoUrl = process.env.MONGO_URL

describe('service', () => {
 const testData = require('./fixtures/testData.json')
 beforeEach(() => mongoUnit.initDb(testMongoUrl, testData))
 afterEach(() => mongoUnit.drop())

 it('should find all tasks', () => {
   return service.getTasks()
     .then(tasks => {
       expect(tasks.length).to.equal(1)
       expect(tasks[0].name).to.equal('test')
     })
 })

 it('should create new task', () => {
   return service.addTask({ name: 'next', completed: false })
     .then(task => {
       expect(task.name).to.equal('next')
       expect(task.completed).to.equal(false)
     })
     .then(() => service.getTasks())
     .then(tasks => {
       expect(tasks.length).to.equal(2)
       expect(tasks[1].name).to.equal('next')
     })
 })

 it('should remove task', () => {
   return service.getTasks()
     .then(tasks => tasks[0]._id)
     .then(taskId => service.deleteTask(taskId))
     .then(() => service.getTasks())
     .then(tasks => {
       expect(tasks.length).to.equal(0)
     })
 })
})
And, voila!

Notice how there are just a couple of lines of code dealing with setup and teardown.

As you can see, it’s very easy to write integration tests using the mongo-unit library. We do not mock MongoDB itself, and we can use the same Mongoose models. We have full control of the database data and do not lose much on test performances since the fake MongoDB is running in memory.

This also allows us to apply the best unit testing practices for integration tests:

Make each test independent of other tests. We load fresh data before each test, giving us a totally independent state for each test.
Use the minimum required state for each test. We do not need to populate the whole database. We only need to set the minimum required data for each particular test.
We can reuse one connection for the database. It increases test performance.
As a bonus, we can even run the application itself against mongo-unit. It allows us to make end-to-end tests for our application against a mocked database.

End-to-end Tests with Selenium
For end-to-end testing, we will be using Selenium WebDriver and Testplane (formerly Hermione) E2E test runner.

First, we will bootstrap the driver and the test runner:

// e2e-runner.js

const mongoUnit = require('mongo-unit')
const selenium = require('selenium-standalone')
const Hermione = require('hermione')
const hermione = new Hermione('./e2e/hermione.conf.js') //hermione config

seleniumInstall() //make sure selenium is installed
 .then(seleniumStart) //start selenium web driver
 .then(mongoUnit.start) // start mongo unit
 .then(testMongoUrl => {
   process.env.MONGO_URL = testMongoUrl //store mongo url
 })
 .then(() => {
   require('./index.js') //start application
 })
 .then(delay(1000)) // wait a second till application is started
 .then(() => hermione.run('', hermioneOpts)) // run hermiona e2e tests
 .then(() => process.exit(0))
 .catch(() => process.exit(1))
We will also need some helper functions (error handling removed for brevity):

function seleniumInstall() {
 return new Promise(resolve => selenium.install({}, resolve))
}

function seleniumStart() {
 return new Promise(resolve => selenium.start(resolve))
}

function delay(timeout) {
 return new Promise(resolve => setTimeout(resolve, timeout))
}
After filling the database with some data and cleaning it once the tests are done, we can run our first tests:

// test.e2e.js

const expect = require('chai').expect
const co = require('co')
const mongoUnit = require('../index')
const testMongoUrl = process.env.MONGO_URL
const DATA = require('./fixtures/testData.json')

const ui = {
 task: '.task',
 remove: '.task .remove',
 name: '#name',
 date: '#date',
 addTask: '#addTask'
}

describe('Tasks', () => {

 beforeEach(function () {
   return mongoUnit.initDb(testMongoUrl, DATA)
     .then(() => this.browser.url('http://localhost:3000'))
 })

 afterEach(() => mongoUnit.dropDb(testMongoUrl))

 it('should display list of tasks', function () {
   const browser = this.browser
   return co(function* () {
     const tasks = yield browser.elements(ui.task)
     expect(tasks.length, 1)
   })
 })

 it('should create task', function () {
   const browser = this.browser
   return co(function* () {
     yield browser.element(ui.name).setValue('test')
     yield browser.element(ui.addTask).click()
     const tasks = yield browser.elements(ui.task)
     expect(tasks.length, 2)
   })
 })

 it('should remove task', function () {
   const browser = this.browser
   return co(function* () {
     yield browser.element(ui.remove).click()
     const tasks = yield browser.elements(ui.task)
     expect(tasks.length, 0)
   })
 })
})
As you can see, the end-to-end tests look very similar to the integration tests.

Wrap Up
Integration and end-to-end testing are important for any large-scale application. Node.js applications, in particular, can benefit tremendously from automated testing. With mongo-unit, you can write integration and end-to-end testing without worrying about all the challenges that come with such tests.
Using with MongoDB
With the Global Setup/Teardown and Async Test Environment APIs, Jest can work smoothly with MongoDB.

Use jest-mongodb Preset
Jest MongoDB provides all required configuration to run your tests using MongoDB.

First install @shelf/jest-mongodb
npm
Yarn
pnpm
npm install --save-dev @shelf/jest-mongodb

Specify preset in your Jest configuration:
{
  "preset": "@shelf/jest-mongodb"
}

Write your test
const {MongoClient} = require('mongodb');

describe('insert', () => {
  let connection;
  let db;

  beforeAll(async () => {
    connection = await MongoClient.connect(globalThis.__MONGO_URI__, {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    });
    db = await connection.db(globalThis.__MONGO_DB_NAME__);
  });

  afterAll(async () => {
    await connection.close();
  });

  it('should insert a doc into collection', async () => {
    const users = db.collection('users');

    const mockUser = {_id: 'some-user-id', name: 'John'};
    await users.insertOne(mockUser);

    const insertedUser = await users.findOne({_id: 'some-user-id'});
    expect(insertedUser).toEqual(mockUser);
  });
});


There's no need to load any dependencies.
Mocking and Stubbing in Unit Tests: A Hands-On Guide
October 2024
Share on Facebook
Share on LinkedIn
Email this Page
Share on Pocket
Share on WhatsApp
Share on Telegram
 Views: 3274
 Likes: 154
Like
With nearly two decades of experience in the tech industry, I know that writing robust unit tests is crucial for developing reliable software. However, external dependencies—like APIs, databases, or third-party services—can make unit tests slower, harder to maintain, and less reliable. This is where mocking and stubbing come in. These techniques help isolate your tests, simulating dependencies to ensure your code works as expected without external interference.

In this tech post, we’ll explore the differences between mocks and stubs, show how to implement them, and share examples using popular testing frameworks like Jest (JavaScript), Mockito (Java), and pytest (Python).

Understanding Mocks vs. Stubs
Before jumping into examples, let’s clarify the differences:

Mocks simulate objects and allow you to verify how these objects are interacted with during testing. For example, you can check if a method was called and with what arguments.
Stubs return predefined responses when invoked during tests. Stubs don’t verify interactions but simply provide data to ensure your test runs as expected.
Key Differences:

Mocks are used to verify behavior and interactions.
Stubs are used to provide fixed responses to avoid reliance on external dependencies.
Using Mocks in Unit Tests
Mocks are powerful tools for verifying that specific functions or methods were called with the correct parameters. They’re commonly used when you want to ensure interactions with third-party services, like APIs or databases.

Example: Mocking API Calls with Jest (JavaScript)
Here’s an example of how to mock an API request in JavaScript using Jest:

Copy Code
// userService.js
const axios = require('axios');

async function fetchUserData(userId) {
    const response = await axios.get(`/api/users/${userId}`);
    return response.data;
}

// userService.test.js
const axios = require('axios');
const { fetchUserData } = require('./userService');

jest.mock('axios');

test('should fetch user data from API', async () => {
    const mockData = { id: 1, name: 'John Doe' };

    axios.get.mockResolvedValue({ data: mockData });

    const user = await fetchUserData(1);

    expect(user).toEqual(mockData);
    expect(axios.get).toHaveBeenCalledWith('/api/users/1');
});
In this example:

jest.mock('axios'): Mocks the axios module to avoid making actual network requests.
mockResolvedValue(): Ensures the mock returns predefined data.
toHaveBeenCalledWith(): Verifies that axios.get() was called with the correct URL.
Mocking Best Practices:
Use mocks to simulate and verify interactions with external services.
Keep tests simple and focused on essential behaviors.
Avoid mocking too many dependencies in one test, as it can make tests brittle.
Using Stubs in Unit Tests
Stubs are useful when you need to provide fixed responses from external dependencies but don’t care about the interaction details. They let you isolate your business logic and ensure that the test runs smoothly, even when complex systems like databases or file systems are involved.

Example: Stubbing Database Calls with Mockito (Java)
Here’s how to use stubs with Mockito to test a service that fetches data from a database:

Copy Code
// UserService.java
public class UserService {
    private UserRepository userRepository;

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public User getUserById(int userId) {
        return userRepository.findById(userId);
    }
}

// UserServiceTest.java
import static org.mockito.Mockito.*;
import static org.junit.Assert.*;
import org.junit.Test;

public class UserServiceTest {
    @Test
    public void testGetUserById() {
        UserRepository mockRepo = mock(UserRepository.class);
        UserService userService = new UserService(mockRepo);

        User stubUser = new User(1, "John Doe");
        when(mockRepo.findById(1)).thenReturn(stubUser);

        User user = userService.getUserById(1);
        assertEquals("John Doe", user.getName());
    }
}
In this example:

mock(UserRepository.class): Creates a mock of the UserRepository.
when().thenReturn(): Stubs the behavior of findById() to return a predefined user.
Stubbing Best Practices:
Use stubs to simplify external dependencies, especially when they slow down tests.
Avoid over-stubbing; only stub what is necessary for the test.
Combining Mocks and Stubs
Sometimes, you need to both mock certain interactions and stub data responses. This is common when testing services that interact with both databases and APIs.

Example: Testing Email Notifications with pytest (Python)
Here’s how you can combine mocks and stubs in Python using pytest:

Copy Code
# user_service.py
class UserService:
    def __init__(self, user_repo, email_service):
        self.user_repo = user_repo
        self.email_service = email_service

    def register_user(self, user):
        self.user_repo.save(user)
        self.email_service.send_email(user.email)

# test_user_service.py
from unittest.mock import Mock

def test_register_user():
    # Mocking the dependencies
    mock_user_repo = Mock()
    mock_email_service = Mock()

    user_service = UserService(mock_user_repo, mock_email_service)

    # Creating a stub user
    user = {"email": "user@example.com"}

    # Running the test
    user_service.register_user(user)

    # Verifying that the user was saved and email was sent
    mock_user_repo.save.assert_called_once_with(user)
    mock_email_service.send_email.assert_called_once_with("user@example.com")
In this example:

Mocks: Both user_repo and email_service are mocked to ensure they are used correctly.
Stubs: The user object acts as a simple stub.
Verification: The test checks that both the user repository and email service were called with the expected data.
Combining Mocks and Stubs:
Use mocks to verify external interactions.
Use stubs to provide fixed data and isolate business logic.
When to Use Mocks and Stubs
Mocks: Use them when you need to verify that specific functions or methods were called correctly, especially for interactions with third-party services.
Stubs: Use them to provide simple, canned responses that isolate your tests from complex or slow external dependencies like databases or file systems.
My TechAdvice: Incorporating mocking and stubbing techniques in your unit testing strategy is a powerful way to isolate your tests from external dependencies and verify that your code is functioning as expected. This approach can help you create more reliable, scalable, and maintainable applications. Stubs allow you to isolate your code from external systems, speeding up your tests and making them more reliable. Whether you’re using Jest for JavaScript, Mockito for Java, or pytest for Python .. etc mastering mocks and stubs will improve the quality and speed of your unit tests, helping you catch bugs early and ensuring your code is both reliable and efficient.
TypeScript Unit Testing 101: A Developer’s Guide
Unit testing's benefits aren't restricted to just a few languages. To prove that, today, we're focusing on TypeScript unit testing.…



By Testim, February 04, 2022
Share on
Unit testing’s benefits aren’t restricted to just a few languages. To prove that, today, we’re focusing on TypeScript unit testing.

In this post, you’ll learn how to unit test your TypeScript code in a hands-on tutorial. You’ll also learn what unit testing is and what you gain from using it.

Since this is a tutorial, there are a few requirements you should meet before we get started:

Basic knowledge of JavaScript (I’m not assuming you have prior knowledge of TypeScript.)
Some familiarity working with the command line
Node.js/npm installed
A code editor or IDE. I’ll be using Visual Studio Code.
TypeScript Unit Testing: The Basics
Before we can roll up your sleeves, let’s get the basic questions out of our way.

What Is Unit Testing? What’s the Benefit?
Software testing comes in many sizes and shapes, but we can group all of those into two big buckets: manual and automated testing. Unit testing belongs to the latter group. It’s a type of automated testing that verifies that tiny pieces—the so-called units—of an application work the way you expect, but in complete isolation. In other words, when unit testing, each unit shouldn’t communicate with other units or with dependencies that are external to the code—e.g., the filesystem, a database, a call to a REST API, etc.

What’s the benefit of testing in this way? Here are a few:

Unit tests tend to be fast, providing quick feedback to engineers.
You get laser-focus feedback: when a unit test fails, you usually know precisely where the problem is.
You get feedback on your code’s quality—hard-to-test code is a sign of design issues, architectural problems, or code smells.
There’s protection against regressions.
Unit tests also work as executable code documentation.
Unit testing makes refactoring possible.
How Does TypeScript Unit Testing Differ From JavaScript Unit Testing?
As you’re probably aware, TypeScript is neither a library (like React) nor a framework (like Angular). Instead, it’s a programming language, a superset of vanilla JavaScript. TypeScript augments regular JavaScript with static typing, some functional niceties, and more features.

TypeScript unit testing differs from regular JavaScript unit testing in at least two ways. First of all, by leveraging static typing, a whole class of errors becomes impossible. So, you probably end up writing fewer tests. Also, TypeScript unit testing requires you to install some additional packages, which are needed to make the unit testing tools work with non-standard JavaScript syntax.

TypeScript Unit Testing: A Practical Example
Now it’s time to get your hands dirty with our step-by-step guide on TypeScript unit testing.

Installing the TypeScript Compiler
Your browser can’t run TypeScript code. That means you need an additional step to convert TypeScript code to regular JavaScript so browsers can run it. You’ll need the TypeScript compiler to do that, so let’s install it. Run the following command from your terminal:

npm install -g typescript
The -g means you’ve installed it globally. Verify the installation using the following command:

tsc -v
You should see the current version displayed:

tsc -v" on the first line, "Version 4.5.2" on the second line, and "PS C:\>" on the third line" width="635" height="370"> The result you should see from running the above commands
tsc -v” on the first line, “Version 4.5.2” on the second line, and “PS C:\>” on the third line” width=”635″ height=”370″> The result you should see from running the above commands
Creating the Basic Folder Structure for the Project
Start by creating a folder for the project and accessing it:

mkdir tsdemo
cd tsdemo
In this folder, let’s create a src folder for the source code and a test folder for the unit tests:

mkdir src
mkdir tests
Now, let’s use npm to initiate a new project. On the root of the tsdemo folder, run:

npm init -y
When you use npm init, you’re usually asked several questions. The -y flag ensures we’re answering the defaults for all of these questions. You’ll see a result like this:

The display you should see after running the above commands
The display you should see after running the above commands
Adding TypeScript to the Project
The next step is adding TypeScript as a development dependency to the project:

npm install typescript --save-dev
Your package.json file should now list TypeScript as a dependency:

The display you should see after running the above commands
The display you should see after running the above commands
Writing TypeScript Code

Let’s finally write some TypeScript code. The code we’ll use is a solution to the String Calculator Kata programming exercise, proposed by Roy Osherove. The idea is to have a method that takes a string containing numbers separated by commas as a parameter and returns their sum. There are a few additional rules:

Passing an empty string should result in zero.
Passing a single number should result in the number itself.
Numbers greater than 1000 should be ignored—e.g., “1,2,1001” should result in 3, but “1,2,1000” should result in 1003.
Passing negative numbers should result in an exception thrown, with the negatives passed listed in the exception message.
Using your code editor of choice, create a file called index.ts inside the src folder. Paste the following code in it:

function add(numbers: string): number {
    let integers = numbers.split(',').map(x => parseInt(x));
    let negatives = integers.filter(x => x < 0);

    if (negatives.length > 0)
        throw new RangeError('Negatives are not allowed: ' + negatives.join(', '));

    return integers
        .filter(x => x <= 1000)
        .reduce((a, b) => a + b, 0);
}

let result = add('1, 2, 4, 5');
console.log(result);
As you can see, by the end of the file, we call the add method and print the result to the log. What about running the code? First, compile the file to regular JavaScript:

tsc index.ts
Now you can use Node.js to execute the resulting file:

node index.js
You should see “6” displayed on your terminal if everything worked right.

What Do You Unit Test Here, and How?
Now that you have some production code, the next step is to test it. That leads to some questions. What exactly should we test here? In which way?

The thing about unit testing is that it’s particularly effective when testing code that is only concerned with business/domain logic. You wouldn’t use unit tests to check the integration between different modules or between the code and external dependencies—you have integration tests for that. Testing the app through its user interface? That’s what UI testing is all about.

The code in the example is a great fit for unit testing. Here are some of the scenarios you can unit test:

Pass an empty string and check if you get zero as a result.
Pass a single number and check if you get the number itself as a result.
Check whether the code throws the expected exception if you pass negative numbers.
Pass a string with several numbers and verify whether the result is expected.
Installing the Testing Tools
There are quite a few unit testing frameworks for JavaScript. We have to pick one, so let’s go with Jest.

Start by adding Jest as a development dependency. In the root of the project folder, execute the following:

npm install jest --save-dev
For the next step, you’ll have to install the ts-jest package to bridge the path between TypeScript and Jest, so to speak:

npm install ts-jest --save-dev
Finally, you must install the type definitions for Jest:

npm install @types/jest --save-dev
Writing and Running Your First Test
Now you have the pieces in their places, so let’s start testing.

Using your code editor, create a file inside tests named index.test.ts. The file should have this code:

import { add } from '../src/index';

describe('testing index file', () => {
  test('empty string should result in zero', () => {
    expect(add('')).toBe(0);
  });
});
The file starts by importing the add function from its file. Then, it starts a new test suite—with the describe function—and, inside that, it creates the first test. The first test expresses that when we call add passing an empty string, we expect the result to be zero.

Are we ready to test? Not yet. Our importing doesn’t work. Since I’m using Visual Studio Code, I see a red line and a helpful error message:

An error message in Visual Studio Code
An error message in Visual Studio Code
What’s happening is that, since we don’t export the index.ts file as a module, it can’t be imported. This is easy to fix. Return to the index.ts file and add the word “export” before “function.” While you’re at it, remove the last two lines—you’ll no longer need them since from now on you’ll test the function using Jest.

Finally, create an additional file called “jest.config.js” at the root of the project. It should have the following content:

module.exports = {
  transform: {'^.+\\.ts?$': 'ts-jest'},
  testEnvironment: 'node',
  testRegex: '/tests/.*\\.(test|spec)?\\.(ts|tsx)$',
  moduleFileExtensions: ['ts', 'tsx', 'js', 'jsx', 'json', 'node']
};
This file is necessary to perform the necessary transformation in order to turn TypeScript into regular JavaScript code.

Now you can run the test using the jest command. You should see a result like this:

Test result indicating that 1 test in 1 test suite passed
Test result indicating that 1 test in 1 test suite passed
Wrapping Up
There are a lot of different types of automated software testing. If you’re familiar with the test automation pyramid, then you know unit testing is the type of testing you should probably focus most of your efforts on. This is true regardless of programming language, and TypeScript is certainly no exception.

In this post, we’ve covered how to get started with TypeScript unit testing. You can explore and learn more with the working foundation you now have. Happy testing!
Unit Testing Node.js + Mongoose Using Jest
By
Yasamin Kamali
•
2012-12-01
Table of Contents
Step 1. Set up express backend
Create Restaurant Function
Create Restaurant Post Method
Step 2. Install Jest and mongodb-memory-server
Step 3. Handle in-memory Server
Step 4. Set up the test file
Step 5. Anatomy of a Test in Jest
Step 6. Testing createRestaurant()
Step 7. Running Tests
Error Testing
References
Unit testing is not the answer to everything, but it sure as hell does prevent a few embarrassing and mind numbing situations. Sometimes, no matter how careful you are when programming, some bugs go unnoticed and the simplest way to catch them before anyone else is unit testing.

In this guide, I will show you how to unit test your MERN stack's backend using Jest. Specifically, Node.js and Mongoose.

If you're experienced with Node.js then you can skip to Step 2 which details how to test your functions.

Step 1. Set up express backend
This step should be pretty straight forward for most people. All you really need to do is set up npm, install a few packages and make sure you can start your server successfully. I'm using nodemon but feel free to use npm as well.

npm init -y
npm i express mongoose nodemon

This is what your project should be looking like by this point:

basic set up in index.js

basic set up in index.js

As we're only concerned with testing the application, we only need a very simple API and since everyone likes food, I thought why not make another Restaurant API!

The Restaurant Schema

Restaurant model in model/Restaurant.js

Restaurant model in model/Restaurant.js

Nothing about this should be new, but the enum for cost may be confusing to some people.

The enum is simply set up to add an extra step of validation to each restaurant object, with regards to their cost property. What this means is “A restaurant's cost has to be a string and can only be one of the values '$', '$$', '$$$'. If no value is provided then give the restaurant a cost of '$$'.” Pretty simple, right?

One of our tests will cover a case where the string passed in for cost is not one of the strings in the enum. At this point the database will fail to save the new object and we will see how to handle that kind of error.

Create Restaurant Function
Our first function will be to create a restaurant given a name, location and budget.

The only reason why it should fail to create a restaurant other than a database error, is if another restaurant already has the given name (see lines 10-11), or, if the restaurant's cost is not one of the strings in the enum mentioned earlier (see model/Restaurant.js).

helper function to create a new restaurant in controller/createRestaurant.js

helper function to create a new restaurant in controller/createRestaurant.js

If it succeeds, it will return the id of the newly created restaurant.

Create Restaurant Post Method
This step is not necessary for testing but just incase you're not used to using helper functions, I wanted to include how you could incorprate them into your code.

controller/index.js

controller/index.js

As you can see in the image above, createRestaurant(name, loc, cost) that we created earlier is being called in the post request and all of this is wrapped in a try catch statement so that if an error arises (eg. same name used twice) we are handling it.

Step 2. Install Jest and mongodb-memory-server
As mentioned in the article title, we will be using Jest to run our tests.

Jest provides methods to create, organise and run your tests. It is one of the most popular testing frameworks as it focuses on simplicity so that you can focus on the logic behind the tests.

“Jest is a delightful JavaScript Testing Framework with a focus on simplicity.”

The second package we must install is mongodb-memory-server. If you're already familiar with how mongo works, you'll know that you create a cluster that stores all of you app's data. Most applications will be writing/querying/updating the database somewhat regularly and therefore, it is important to ensure that your interactions with the database are producing the desired outcome.

The mongodb-memory server creates a 'cluster' which only exists in your device's main memory and is not physically stored to disk.

Therefore, once your application terminates, the database instance will no longer exist. This method will also be faster than if you were to mock the interactions with the database.

Now that we have the theory covered, let's install both packages:

npm i mongodb-memory-server jest

Step 3. Handle in-memory Server
To make sure we're not repeating code and keeping good style, it's good to create and then export functions for handling the in-memory database and then call on these exported functions as they're required throughout the rest of the project.

The mongodb-memory-server package we installed earlier has a very helpful github page that explains how to connect and create a db instance:

nodkz/mongodb-memory-server

If you don't want to read through the documentation, then the following code will be enough for you to get started with your unit testing.

Special thanks to Paula Santamaría for her article where she provides this module. I will link to her article at the end of this tutorial.

Handling interactions with in-memory database: tests/db.js

Handling interactions with in-memory database: tests/db.js

The connect and closeDatabase methods should be pretty self explainable, however, you may be wondering why we need a clearDatabase function as well.

When it comes to unit testing, each test should start on a blank canvas, which means that there should be no existing data in the database when we start a new test. Therefore, every time a test ends, we will call the clearDatabase function.

Step 4. Set up the test file
First, in our tests folder we will be keeping all the files which includes tests. It is important when it comes to naming the files to ensure that they're done in this manner: fileName.test.js

Before any of the tests are run, we will need to connect to the in-memory database. Lucky for us, we have already created and exported a method to do that in tests/db.js. Similarly, we need to disconnect and drop the database once all tests are run. Finally, after each individual test, we must clear the database.

Now all we need to do is add this to the top of every test file:

const db = require('./db')

beforeAll(async () => await db.connect())

afterEach(async () => await db.clearDatabase())

afterAll(async () => await db.closeDatabase())

Step 5. Anatomy of a Test in Jest
With everything set up, we can now focus on our first test for the createRestaurant function.

Jest offers a way to organise our tests. Consider the following example for testing an asynchronous function that takes in an integer and returns the number as an integer and a string:

describe('First Group Of Tests', () => {

    it('First Test', async done => {
        const result = await numberFunc(10)
        expect(result.word).toBe("ten")
        expect(result.number).toBeGreaterThan(10)
        done()

    })
    it('Second Test', async done => {
        const result = await numberFunc()
        expect(result).toBeNull()
        done()

    })

})

Key points of this are:

The describeblock is a way to place similar tests together. For example, if you're testing the createRestaurant function and want to make sure it can handle various name lengths, you can place all those tests into the same describe block.

The it block represents each individual test.

The most important part of an it block for an asynchronous test is to ensure you include the done() at the end of the test. If you don't, the test will be finished before any asynchronous call completes and your tests will fail. The way that Jest explains the importance of done()in an async function is:

“Jest will wait until the done callback is called before finishing the test.”

expect is very similar to assert in other languages. It is the way we can check to ensure that our functions are retrieving/creating the objects we want them to. Whilst there are many different ways to use expect , I have only shown 3 options here. For more, check out https://jestjs.io/docs/en/expect

Step 6. Testing createRestaurant()
As the tests are run from top down, it's good to keep the most simple/basic test at the top of the file. What I mean by this is the following:

example test suite to show order of tests running in Jest

example test suite to show order of tests running in Jest

Basically, the order of the tests in a file will matter.

So it's good to start with a test for the most basic requirement of a function to make sure it works before moving on to more complicated cases.

So going back to testing createRestaurant() , the most basic test case would be creating one restaurant with a valid name, location and budget.

example unit test for a success case in tests/createRestaurant.test.js

example unit test for a success case in tests/createRestaurant.test.js

Here is the our test file with it's first test! If any of the three except() fail, then the test will fail and we will know something in our function is broken. For now, let's run the test and see if it will work.

Step 7. Running Tests
In your package.json , add a test script:

"scripts": {
    "test": "jest --testEnvironment=node --runInBand ./tests"
}

The --runInBand is there to get the tests to run one after another.

The --testEnvironment=node is there as we're in a node environment.

What's really important here is to give the correct file path to your test folder. For me that was ./tests .

Now when you run npm test in the terminal, you should see something like this:

Successful jest test

Successful jest test

Now this was an example of a success test case. I will show you how to write tests for errors.

Error Testing
In the same file, you can create a new describe block for cases where we fail to create a new restaurant. Looking back at our Schema and function, the only times it should fail is if a name has been repeated or if the cost associated with a restaurant is not one of the values in the enum.

example testing for exceptions in tests/createRestaurant.js

example testing for exceptions in tests/createRestaurant.js

In the first test, we're checking that an error will be thrown if a name is repeated. We have already tested for the case of one restaurant being made successfully so we can be rest assured that line 33 will run smoothly.

However, line 35 should throw an error since the name “First” already belongs to another restaurant. As this is an asynchronous function that is meant to throw an error, we need to add rejects.toThrow() after our expect.

In the second test, we're checking that an error is thrown when the third argument of createRestaurant() is not a string value in the cost enum.

If you run your tests again you should see this:

Running all tests successfully

Running all tests successfully

Congratulations! You have successfully unit tested your Node.js and Mongoose backend using Jest.

Thanks for reading and please leave a comment if you're unsure about anything. This is my first article so chances are I've not done a perfect job so please let me know if you spot any problems 😌

If you want to do more with jest like using mocks to 'mock' the behaviour of external functions, read this blog 🥳
Integration Tests with Jest, Supertest, Knex, and Objection in TypeScript
Recently, I set up unit and integration tests for a Node API in TypeScript, and I couldn't find a lot of resources for setting up and tearing down, database seeding, and hooking everything up in TypeScript, so I'll share the approach I went with.

Prerequisites
This article will help if:

You're using TypeScript as the language for an API in Node/Express.
You're using Objection.js as an ORM for your API, which runs on Knex behind the scenes.
You're using Jest for testing.
Goals
You want to be able to spin up a test database, make real API calls with responses and errors, and tear down the database at the end of the tests.
This is not meant to be a complete tutorial that gives step-by-step instructions for every detail, but will give you the big picture of setting up the TypeScript API with Objection and making a test suite for it.

Installation
This app involves objection, knex, pg, express, and typescript, with jest and supertest for testing.

npm i objection knex pg express
npm i -D typescript jest jest-extended supertest ts-jest ts-node
Setup
Assume you have an API with an endpoint at GET /books/:id that returns a Book object. Your Objection model for the Book would look like this, assuming there's a book table in the database:

book.model.ts
import { Model } from 'objection'

export class Book extends Model {
  id!: string
  name!: string
  author!: string

  static tableName = 'book' // database table name
  static idColumn = 'id' // id column name
}

export type BookShape = ModelObject<Book>
Here's an Express app with a single endpoint. It's essential to export app and NOT run app.listen() here so tests won't start the app and cause issues.

app.ts
import express, { Application, Request, Response, NextFunction } from 'express'
import { Book } from './book.model'

// Export the app
export const app: Application = express()

app.use(express.json())
app.use(express.urlencoded({ extended: true }))

// GET endpoint for the book
app.get(
  '/books/:id',
  async (request: Request, response: Response, next: NextFunction) => {
    try {
      const { id } = request.params

      const book: BookShape = await Book.query().findById(id)

      if (!book) {
        throw new Error('Book not found')
      }

      return response.status(200).send(book)
    } catch (error) {
      return response.status(404).send({ message: error.message })
    }
  }
)
The index.ts is where you would set up your database connection and start the app.

index.ts
import Knex from 'knex'
import { Model } from 'objection'

// Import the app
import { app } from './app'

// Set up the database (assuming Postgres)
const port = 5000
const knex = Knex({
  client: 'pg',
  connection: {
    host: 'localhost',
    database: 'books_database',
    port: 5432,
    password: 'your_password',
    user: 'your_username',
  },
})

// Connect database to Objection
Model.knex(knex)

// Start the app
app.listen(port, () => console.log(`*:${port} - Listening on port ${port}`))
So now you have a complete API for the /books/:id endpoint. This API would start with:

tsc && npm start
Or you could use nodemon to get a dev server going.

Migration
In Knex, you can use a migration to seed the schema/data instead of just using raw SQL. To make a migration, you'd just use the Knex CLI to create a migration file:

knex migrate:make initial-schema
And set up the data - in this case, making book table with a few columns:

db/migrations/initial-chema.js
exports.up = async function (knex) {
  await knex.schema.createTable('book', function (table) {
    table.increments('id').primary().unique()
    table.string('name').notNullable()
    table.string('author').notNullable()
  })
}

exports.down = async function (knex) {
  await knex.schema.dropTable('book')
}
Similar instructions are available for seed.

Test Configuration
Your basic jest.config.js would look something like this:

jest-config.js
module.exports = {
  clearMocks: true,
  moduleFileExtensions: ['ts'],
  roots: ['<rootDir>'],
  testEnvironment: 'node',
  transform: {
    '^.+\\.ts?$': 'ts-jest',
  },
  setupFilesAfterEnv: ['jest-extended'],
  globals: {
    'ts-jest': {
      diagnostics: false,
    },
  },
  globalSetup: '<rootDir>/tests/global-setup.ts',
  globalTeardown: '<rootDir>/tests/global-teardown.ts',
}
Note the globalSetup and globalTeardown properties and their corresponding files. In those files, you can seed and migrate the database, and tear it down when you're done.

Global setup
In the global setup, I made a two step process - first connect without the database to create it, then migrate and seed the database. (Migration instructions are in the Knex documentation.)

tests/global-setup.ts
import Knex from 'knex'

const database = 'test_book_database'

// Create the database
async function createTestDatabase() {
  const knex = Knex({
    client: 'pg',
    connection: {
      /* connection info without database */
    },
  })

  try {
    await knex.raw(`DROP DATABASE IF EXISTS ${database}`)
    await knex.raw(`CREATE DATABASE ${database}`)
  } catch (error) {
    throw new Error(error)
  } finally {
    await knex.destroy()
  }
}

// Seed the database with schema and data
async function seedTestDatabase() {
  const knex = Knex({
    client: 'pg',
    connection: {
      /* connection info with database */
    },
  })

  try {
    await knex.migrate.latest()
    await knex.seed.run()
  } catch (error) {
    throw new Error(error)
  } finally {
    await knex.destroy()
  }
}
Then just export the function that does both.

tests/global-setup.ts
module.exports = async () => {
  try {
    await createTestDatabase()
    await seedTestDatabase()
    console.log('Test database created successfully')
  } catch (error) {
    console.log(error)
    process.exit(1)
  }
}
Global teardown
For teardown, just delete the database.

tests/global-teardown.ts
module.exports = async () => {
  try {
    await knex.raw(`DROP DATABASE IF EXISTS ${database}`)
  } catch (error) {
    console.log(error)
    process.exit(1)
  }
}
Integration Tests
With an integration test, you want to be able to seed some data in the individual test, and be able to test all the successful responses as well as error responses.

In the test setup, you can add any additional seed data to the database that you want, creating a new Knex instance and connecting it to the Objection model.

These tests will utilize Supertest, a popular library for HTTP assertions.

Import supertest, knex, objection, and the app, seed whatever data you need, and begin writing tests.

books.test.ts
import request from 'supertest'
import Knex from 'knex'
import { Model } from 'objection'

import { app } from '../app'

describe('books', () => {
  let knex: any
  let seededBooks

  beforeAll(async () => {
    knex = Knex({
      /* configuration information with test_book_database */
    })
    Model.knex(knex)

    // Seed anything
    seededBooks = await knex('book')
      .insert([{ name: 'A Game of Thrones', author: 'George R. R. Martin' }])
      .returning('*')
  })

  afterAll(() => {
    knex.destroy()
  })

  decribe('GET /books/:id', () => {
    // Tests will go here
  })
})
Successful response test
At this point, all the setup is ready and you can test a successful seed and GET on the endpoint.

tests/books.test.ts
it('should return a book', async () => {
  const id = seededBooks[0].id

  const { body: book } = await request(app).get(`/books/${id}`).expect(200)

  expect(book).toBeObject()
  expect(book.id).toBe(id)
  expect(book.name).toBe('A Game of Thrones')
})
Error response test
It's also important to make sure all expected errors are working properly.

tests/books.test.ts
it('should return 404 error ', async () => {
  const badId = 7500
  const { body: errorResult } = await request(app)
    .get(`/books/${badId}`)
    .expect(404)

  expect(errorResult).toStrictEqual({
    message: 'Book not found',
  })
})
Conclusion
Now once you run npm run test, or jest, in the command line, it will create the test_book_database database, seed it with any migrations you had (to set up the schema and any necessary data), and you can access the database in each integration test.

This ensures the entire process from database seeding to the API controllers are working properly. This type of code will give you full coverage on the models, routes, and handlers within the app.