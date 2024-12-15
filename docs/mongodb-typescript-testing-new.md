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

### Model Definition

```typescript
// src/models/person.model.ts
import mongoose, { Document } from 'mongoose';

export interface PersonInput {
  name: string;
  lastName: string;
  address: string;
  gender: string;
  job: string;
  age: number;
}

export interface PersonDocument extends PersonInput, Document {
  createdAt: Date;
  updatedAt: Date;
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
    timestamps: true,
  }
);

const PersonModel = mongoose.model<PersonDocument>("Person", PersonSchema);
export default PersonModel;
```

### Model Testing

```typescript
// test/models/person.test.ts
import PersonModel, { PersonInput } from '../../src/models/person.model';
import { faker } from '@faker-js/faker';

describe('Person Model Test Suite', () => {
  const personInput: PersonInput = {
    name: faker.name.findName(),
    lastName: faker.name.lastName(),
    age: faker.datatype.number({ min: 18, max: 50 }),
    address: faker.address.streetAddress(),
    gender: faker.name.gender(),
    job: faker.name.jobTitle(),
  };

  test('should create & save person successfully', async () => {
    const validPerson = new PersonModel(personInput);
    const savedPerson = await validPerson.save();
    
    expect(savedPerson._id).toBeDefined();
    expect(savedPerson.name).toBe(personInput.name);
    expect(savedPerson.createdAt).toBeDefined();
  });

  test('should fail validation when required field is missing', async () => {
    const personWithoutRequiredField = new PersonModel({ name: 'John' });
    let err;
    
    try {
      await personWithoutRequiredField.save();
    } catch (error) {
      err = error;
    }
    
    expect(err).toBeInstanceOf(mongoose.Error.ValidationError);
  });
});
```

## Best Practices

1. **Use In-Memory Database**: Use `mongodb-memory-server` for testing to avoid affecting your production database.

2. **Clean Up After Tests**: Always clean up your test database after each test to ensure test isolation.

3. **Type Safety**: 
   - Define proper interfaces for your models
   - Use TypeScript decorators and types for schema definitions
   - Ensure your test data matches your interfaces

4. **Test Data Generation**:
   - Use `@faker-js/faker` to generate realistic test data
   - Create helper functions for commonly used test data
   - Keep test data consistent with your schema validation rules

5. **Error Handling**:
   - Test both success and failure cases
   - Verify error types and messages
   - Test validation rules thoroughly

## Common Testing Patterns

### Testing Transactions

```typescript
describe('Transaction Tests', () => {
  it('should rollback changes on error', async () => {
    const session = await mongoose.startSession();
    session.startTransaction();

    try {
      const person = await PersonModel.create([personInput], { session });
      // Simulate error
      throw new Error('Test Error');
      await session.commitTransaction();
    } catch (error) {
      await session.abortTransaction();
    } finally {
      session.endSession();
    }

    const persons = await PersonModel.find({});
    expect(persons.length).toBe(0);
  });
});
```

### Testing Queries

```typescript
describe('Query Tests', () => {
  it('should find persons by age range', async () => {
    await PersonModel.create([
      { ...personInput, age: 20 },
      { ...personInput, age: 25 },
      { ...personInput, age: 30 },
    ]);

    const result = await PersonModel.find({
      age: { $gte: 25 }
    });

    expect(result.length).toBe(2);
  });
});
```

## Resources

- [Jest Documentation](https://jestjs.io/docs/getting-started)
- [MongoDB Memory Server](https://github.com/nodkz/mongodb-memory-server)
- [Mongoose Documentation](https://mongoosejs.com/docs/)
