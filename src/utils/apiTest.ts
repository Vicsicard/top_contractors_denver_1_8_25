import fetch from 'node-fetch';

export async function testGooglePlacesAPI(apiKey: string) {
    try {
        // Simple test query
        const query = encodeURIComponent('plumber in Denver, CO');
        const url = `https://maps.googleapis.com/maps/api/place/textsearch/json?query=${query}&key=${apiKey}`;
        
        console.log('Testing Google Places API...');
        console.log('Test URL:', url.replace(apiKey, 'REDACTED'));
        
        const response = await fetch(url);
        const data = await response.json();
        
        console.log('API Response:', {
            status: data.status,
            errorMessage: data.error_message,
            resultsCount: data.results?.length || 0,
            firstResult: data.results?.[0]?.name || null
        });
        
        return {
            isValid: data.status === 'OK',
            status: data.status,
            error: data.error_message,
            details: data
        };
    } catch (error) {
        console.error('API Test Error:', error);
        return {
            isValid: false,
            status: 'ERROR',
            error: error.message,
            details: error
        };
    }
}
