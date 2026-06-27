
import { NextRequest, NextResponse } from 'next/server';
import prisma from '@/lib/prisma';

export async function GET() {
  // TODO: Implement filtering, pagination
  const products = await prisma.product.findMany({
    include: {
      category: true,
      provider: true
    },
    take: 20
  });
  
  return NextResponse.json(products);
}

export async function POST(req: NextRequest) {
  // Admin only - create product
  const body = await req.json();
  const product = await prisma.product.create({
    data: body
  });
  return NextResponse.json(product);
}
