import { NextRequest, NextResponse } from 'next/server';
import { getProducts, getFurnitureProducts, searchFurniture } from '@/lib/shopify';

export async function GET(request: NextRequest) {
    try {
        const { searchParams } = new URL(request.url);

        const first = parseInt(searchParams.get('first') || '20', 10);
        const after = searchParams.get('after') || undefined;
        const category = searchParams.get('category') || undefined;
        const search = searchParams.get('search') || undefined;
        const productType = searchParams.get('productType') || undefined;

        let result;

        if (search) {
            // Search for furniture by term
            result = await searchFurniture(search, first);
        } else if (category) {
            // Get furniture by category
            result = await getFurnitureProducts({ category, first, after });
        } else if (productType) {
            // Get products by product type
            result = await getProducts({
                first,
                after,
                query: `product_type:${productType}`,
            });
        } else {
            // Get all furniture products
            result = await getFurnitureProducts({ first, after });
        }

        return NextResponse.json(result);
    } catch (error) {
        console.error('Shopify products API error:', error);

        // Check if it's a configuration error
        if (error instanceof Error && error.message.includes('Missing Shopify configuration')) {
            return NextResponse.json(
                {
                    error: 'Shopify not configured',
                    message: 'Please set SHOPIFY_STORE_DOMAIN and SHOPIFY_STOREFRONT_ACCESS_TOKEN environment variables.',
                    products: [],
                    pageInfo: { hasNextPage: false, endCursor: null }
                },
                { status: 503 }
            );
        }

        return NextResponse.json(
            {
                error: 'Failed to fetch products',
                message: error instanceof Error ? error.message : 'Unknown error',
                products: [],
                pageInfo: { hasNextPage: false, endCursor: null }
            },
            { status: 500 }
        );
    }
}
