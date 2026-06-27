import { NextRequest, NextResponse } from 'next/server';

export async function GET(request: NextRequest) {
    try {
        const { searchParams } = new URL(request.url);

        const category = searchParams.get('category') || 'all';
        const search = searchParams.get('search') || '';
        const limit = parseInt(searchParams.get('limit') || '24', 10);

        // Call backend API
        const backendUrl = process.env.BACKEND_URL || 'http://localhost:8000';
        const response = await fetch(`${backendUrl}/api/v1/amazon/search?category=${encodeURIComponent(category)}&q=${encodeURIComponent(search)}&limit=${limit}`);

        if (!response.ok) {
            throw new Error('Backend API error');
        }

        const data = await response.json();
        return NextResponse.json(data);
    } catch (error) {
        console.error('Amazon API endpoint error:', error);
        return NextResponse.json(
            {
                error: 'Failed to fetch from Amazon',
                message: error instanceof Error ? error.message : 'Unknown error',
                products: [],
                pageInfo: { hasNextPage: false, endCursor: null }
            },
            { status: 500 }
        );
    }
}
