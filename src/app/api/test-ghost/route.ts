import { NextResponse } from 'next/server';
import { getPosts } from '@/utils/ghost';

export async function GET() {
    try {
        console.log('Testing Ghost API connection...');
        console.log('Ghost Key:', process.env['GHOST.ORG_CONTENT_API_KEY']);

        const { posts } = await getPosts(1, 5);
        
        return NextResponse.json({
            success: true,
            posts
        });
    } catch (error) {
        console.error('Error testing Ghost API:', error);
        return NextResponse.json({
            success: false,
            error: error instanceof Error ? error.message : 'Unknown error'
        }, { status: 500 });
    }
}
