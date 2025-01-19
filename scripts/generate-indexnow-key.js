const crypto = require('crypto');

// Generate a secure random key of 32 characters
const key = crypto.randomBytes(16).toString('hex');

console.log('\nGenerated IndexNow Key:');
console.log('====================');
console.log(key);
console.log('====================');
console.log('\nAdd this key to your .env.local file as:');
console.log(`INDEXNOW_KEY=${key}\n`);
