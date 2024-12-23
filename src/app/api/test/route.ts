import { NextRequest, NextResponse } from 'next/server';
import { testGooglePlacesAPI } from '@/utils/apiTest';

export const dynamic = 'force-dynamic';
export const runtime = 'nodejs';

export async function GET(request: NextRequest) {
    console.log('Starting API key test...');
    
    try {
        const apiKey = process.env.GOOGLE_PLACES_API_KEY;
        
        if (!apiKey) {
            console.error('API key not found in environment');
            return new Response(JSON.stringify({
                error: 'API key not found in environment variables',
                isValid: false
            }), {
                status: 500,
                headers: { 'Content-Type': 'application/json' }
            });
        }

        console.log('Testing API key:', apiKey.substring(0, 8) + '...');
        const result = await testGooglePlacesAPI(apiKey);
        
        console.log('Test result:', JSON.stringify(result, null, 2));

        if (!result.isValid) {
            return new Response(JSON.stringify({
                error: 'API key validation failed',
                details: result
            }), {
                status: 400,
                headers: { 'Content-Type': 'application/json' }
            });
        }

        return new Response(JSON.stringify({
            message: 'API key is valid and working',
            details: result
        }), {
            status: 200,
            headers: { 'Content-Type': 'application/json' }
        });
        
    } catch (error) {
        console.error('Test endpoint error:', error);
        return new Response(JSON.stringify({
            error: 'Test endpoint error',
            message: error.message
        }), {
            status: 500,
            headers: { 'Content-Type': 'application/json' }
        });
    }
}
