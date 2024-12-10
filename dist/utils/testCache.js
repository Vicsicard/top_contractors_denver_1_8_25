var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
import { getPlacesData } from './placesApi.js';
import * as dotenv from 'dotenv';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';
const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);
// Load environment variables from .env.local
dotenv.config({ path: join(__dirname, '../../.env.local') });
function testPlacesCache() {
    return __awaiter(this, void 0, void 0, function* () {
        var _a, _b;
        try {
            console.log('Starting Places API cache test...');
            // Test environment variables
            if (!process.env.MONGODB_URI) {
                throw new Error('MONGODB_URI is not defined');
            }
            if (!process.env.NEXT_GOOGLE_PLACES_API_KEY) {
                throw new Error('NEXT_GOOGLE_PLACES_API_KEY is not defined');
            }
            const searchOptions = {
                keyword: 'plumbers',
                location: 'Denver',
            };
            console.log('\nFirst call - should fetch from Google Places API:');
            console.time('First call');
            const firstCall = yield getPlacesData(searchOptions);
            console.timeEnd('First call');
            console.log(`Found ${((_a = firstCall.results) === null || _a === void 0 ? void 0 : _a.length) || 0} results`);
            // Wait 2 seconds
            console.log('\nWaiting 2 seconds before second call...');
            yield new Promise(resolve => setTimeout(resolve, 2000));
            console.log('\nSecond call - should fetch from cache:');
            console.time('Second call');
            const secondCall = yield getPlacesData(searchOptions);
            console.timeEnd('Second call');
            console.log(`Found ${((_b = secondCall.results) === null || _b === void 0 ? void 0 : _b.length) || 0} results`);
            // Verify results match
            const firstCallIds = new Set(firstCall.results.map(r => r.place_id));
            const secondCallIds = new Set(secondCall.results.map(r => r.place_id));
            const resultsMatch = firstCallIds.size === secondCallIds.size &&
                [...firstCallIds].every(id => secondCallIds.has(id));
            console.log('\nResults comparison:');
            console.log('- First call results:', firstCallIds.size);
            console.log('- Second call results:', secondCallIds.size);
            console.log('- Results match:', resultsMatch);
            if (!resultsMatch) {
                console.warn('Warning: Results from cache do not match original results');
            }
            console.log('\nTest completed successfully!');
        }
        catch (error) {
            console.error('\nTest failed with error:', error);
            if (error instanceof Error) {
                console.error('Error details:', {
                    message: error.message,
                    stack: error.stack,
                });
            }
            process.exit(1);
        }
    });
}
// Run the test
testPlacesCache().catch(error => {
    console.error('Unhandled error:', error);
    process.exit(1);
});
