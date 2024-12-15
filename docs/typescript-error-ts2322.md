# Understanding TypeScript Error TS2322 and How to Resolve It

## Overview
This document provides guidance on understanding and resolving TypeScript error TS2322: Type 'X' is not assignable to type 'Y'.

## Error Description
TS2322 occurs when you try to assign a value to a variable or parameter that doesn't match its declared type.

## Common Scenarios

### 1. Basic Type Mismatches
```typescript
// Error TS2322: Type 'string' is not assignable to type 'number'
let numValue: number = "123";  // ❌
let numValue: number = 123;    // ✅
```

### 2. Object Type Mismatches
```typescript
interface User {
  name: string;
  age: number;
}

// Error TS2322: Type '{ name: string; }' is not assignable to type 'User'.
const user: User = { name: "John" };  // ❌
const user: User = { name: "John", age: 30 };  // ✅
```

### 3. Array Type Mismatches
```typescript
// Error TS2322: Type 'string[]' is not assignable to type 'number[]'
const numbers: number[] = ["1", "2"];  // ❌
const numbers: number[] = [1, 2];      // ✅
```

## How to Resolve

1. **Check Type Declarations**
   - Verify the expected type
   - Review interface/type definitions
   - Check for typos in type names

2. **Type Assertions (when appropriate)**
   ```typescript
   const value = someValue as ExpectedType;
   ```

3. **Type Guards**
   ```typescript
   if (typeof value === "string") {
     // value is treated as string here
   }
   ```

4. **Optional Properties**
   ```typescript
   interface Config {
     name?: string;  // Optional property
     value: number;
   }
   ```

## Project-Specific Examples
(Add examples from our Denver Contractors project here)

## Best Practices
1. Avoid using `any` type
2. Use strict type checking
3. Implement proper type guards
4. Document type expectations
5. Use TypeScript ESLint rules

## Related Errors
- TS2339: Property does not exist
- TS2345: Argument type mismatch
- TS2366: Type assignment error

## References
- [TypeScript Official Documentation](https://www.typescriptlang.org/docs/handbook/2/types.html)
- [TypeScript Error Reference](https://typescript.tv/errors/)

Understanding TypeScript Error TS2322 and How to Resolve It
In TypeScript, type safety is a core feature that helps developers avoid certain runtime errors by performing static checks. However, sometimes these checks can result in perplexing error messages that may seem difficult to decipher. One such error is encountered in the TypeScript line tmpKurs[what] = newValue;, where the error message states: TS2322: Type string | number | boolean | Dayjs is not assignable to type never. Let's unpack this error and understand how we can resolve it.

Explanation of the Error
The error TS2322 arises when TypeScript cannot determine a common type between what you are trying to assign and the property types it expects. The message indicates that the union type string | number | boolean | Dayjs cannot be assigned to the type never. The never type in TypeScript is a type that represents no type at all; a function that returns never can never actually return.

In essence, if TypeScript presents an error which involves never, there might be a breakdown in logic or typing somewhere that has confused the compiler about what types are assignable.

Key Reasons for the Error
Typing Mismatch between Property Keys and Values: The variable what is meant to be a key of the kurs object, while newValue should correspondingly be the type of the value associated with that key. Without properly typed associations between keys and values, TypeScript resorts to never for safety.

TypeScript's Type Declaration Assumptions: If the cloneDeep function does not properly preserve types, TypeScript may assume that the resulting object's properties are of type never.

Solution: Ensuring Proper Type Associations
To fix this error, the code needs adjustments in how it handles types:

Define Expected Types Clearly
Ensure your kurs object and the function parameter types make explicit and clear links between keys and value types:

const kurs = {
    value: 'value',
    value2: 1
};
 
type Kurs = typeof kurs;
Correct Usage of Generic Types
Use generics to bind the type of the key to its corresponding value type:

function changeKurs<K extends keyof Kurs>(what: K, newValue: Kurs[K]) {
    const tmpKurs = cloneDeep(kurs);
    if (Object.prototype.hasOwnProperty.call(tmpKurs, what)) {
        tmpKurs[what] = newValue;
        // Assuming setkurs is defined elsewhere
        // setkurs(tmpKurs);
    } else {
        console.error(`Property '${what.toString()}' does not exist in kurs`);
    }
}
Ensure cloneDeep Returns Proper Types
Make sure that your cloneDeep function maintains the types of the object, or if you rely on a library like lodash, typings should ideally reflect the same. Simplify or ensure typing like:

const cloneDeep = <T extends object>(obj: T): T => obj;  // Simple identity function for demonstration
Usage Example
changeKurs('value', 'newStringValue');  // Works fine
changeKurs('value2', 2);  // Works fine
changeKurs('value', 1);  // Error: Type mismatch (as expected)
By making these changes, TypeScript will properly track the types and reduce, if not eliminate, the chances of encountering type errors regarding "never". This method enforces strong typing aligned with the actual data structure and ensures only intended types are assigned to object properties, contributing to safer code.