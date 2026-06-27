import { NextRequest, NextResponse } from 'next/server';

export async function GET(request: NextRequest) {
  const { searchParams } = new URL(request.url);
  const category = searchParams.get('category') || 'furniture';
  const q = searchParams.get('q') || '';
  const limit = parseInt(searchParams.get('limit') || '20');

  try {
    // Call backend API
    const backendUrl = process.env.BACKEND_URL || 'http://localhost:8000';
    const response = await fetch(`${backendUrl}/api/v1/amazon/search?category=${encodeURIComponent(category)}&q=${encodeURIComponent(q)}&limit=${limit}`);

    if (!response.ok) {
      throw new Error('Backend API error');
    }

    const data = await response.json();
    return NextResponse.json(data);
  } catch (error) {
    console.error('Amazon search API error:', error);
    // Return mock data as fallback
    return NextResponse.json({
      products: Array.from({ length: 8 }).map((_, i) => ({
        id: `mock-${i}`,
        title: `${q || category} - Mock Product`,
        handle: `mock-${i}`,
        description: 'Fallback mock product.',
        productType: 'Furniture',
        vendor: 'Amazon',
        tags: ['amazon', 'mock'],
        price: { amount: (50 + i * 20).toString(), currencyCode: 'USD' },
        image: {
          url: `https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=500&q=80`,
          altText: 'Mock Product',
          width: 500,
          height: 500
        },
        images: [],
        variants: []
      })),
      pageInfo: { hasNextPage: false, endCursor: null }
    });
  }
}
