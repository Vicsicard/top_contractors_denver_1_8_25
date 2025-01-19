/**
 * Utility functions for notifying search engines about new content
 */

const DOMAIN = 'topcontractorsdenver.com';

/**
 * Notify search engines about new or updated URLs
 */
export async function notifySearchEngines(urls: string[]) {
    if (!urls.length) return;
    
    try {
        // Ensure all URLs are from our domain
        const validUrls = urls.filter(url => {
            try {
                const urlObj = new URL(url);
                return urlObj.hostname === DOMAIN;
            } catch {
                return false;
            }
        });

        if (!validUrls.length) return;

        // Notify Google using the Indexing API
        const pingUrls = [
            `https://www.google.com/ping?sitemap=https://${DOMAIN}/sitemap.xml`,
            `https://www.bing.com/ping?sitemap=https://${DOMAIN}/sitemap.xml`
        ];

        // Submit URLs to IndexNow API (supported by Bing, Yandex, and others)
        const indexNowPayload = {
            host: DOMAIN,
            key: process.env.INDEXNOW_KEY,
            urlList: validUrls,
            keyLocation: `https://${DOMAIN}/indexnow.txt`
        };

        const promises = [
            // Ping Google and Bing about sitemap updates
            ...pingUrls.map(url => 
                fetch(url, { 
                    method: 'GET',
                    headers: { 'User-Agent': 'TopContractorsDenver Bot' }
                })
            ),
            // Submit to IndexNow API
            fetch('https://api.indexnow.org/indexnow', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'User-Agent': 'TopContractorsDenver Bot'
                },
                body: JSON.stringify(indexNowPayload)
            })
        ];

        // Execute all notifications in parallel
        const results = await Promise.allSettled(promises);
        
        // Log any failures
        results.forEach((result, index) => {
            if (result.status === 'rejected') {
                console.error(`Failed to notify search engine ${index}:`, result.reason);
            }
        });

    } catch (error) {
        console.error('Error notifying search engines:', error);
    }
}

/**
 * Generate the IndexNow API key verification file content
 */
export function generateIndexNowKeyFile(key: string): string {
    return key;
}
