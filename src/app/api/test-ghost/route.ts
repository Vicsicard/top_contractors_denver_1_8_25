import { NextResponse } from 'next/server';
import { getPosts } from '@/utils/ghost';

export async function GET() {
    try {
        console.log('Ghost URL:', process.env.GHOST_URL);
        console.log('Ghost Key:', process.env['GHOST.ORG_CONTENT_API_KEY']);

        const posts = await getPosts({ limit: 5 });
        
        return NextResponse.json({
            success: true,
            ghostUrl: process.env.GHOST_URL,
            ghostKey: process.env['GHOST.ORG_CONTENT_API_KEY'],
            posts
        });
    } catch (error) {
        console.error('Error in test-ghost API:', error);
        return NextResponse.json({
            success: false,
            error: error instanceof Error ? error.message : 'Unknown error'
        }, { status: 500 });
    }
}
