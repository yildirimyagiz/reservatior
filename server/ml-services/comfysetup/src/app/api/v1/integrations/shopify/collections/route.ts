import { NextRequest, NextResponse } from 'next/server';
import { getCollections } from '@/lib/shopify';

export async function GET(request: NextRequest) {
    try {
        const { searchParams } = new URL(request.url);
        const first = parseInt(searchParams.get('first') || '20', 10);

        const result = await getCollections(first);

        return NextResponse.json(result);
    } catch (error) {
        console.error('Shopify collections API error:', error);

        if (error instanceof Error && error.message.includes('Missing Shopify configuration')) {
            return NextResponse.json(
                {
                    error: 'Shopify not configured',
                    message: 'Please set SHOPIFY_STORE_DOMAIN and SHOPIFY_STOREFRONT_ACCESS_TOKEN environment variables.',
                    collections: []
                },
                { status: 503 }
            );
        }

        return NextResponse.json(
            {
                error: 'Failed to fetch collections',
                message: error instanceof Error ? error.message : 'Unknown error',
                collections: []
            },
            { status: 500 }
        );
    }
}
