import { NextRequest, NextResponse } from "next/server";
import { auth } from "@/lib/auth";
import prisma from "@/lib/prisma";

export async function GET() {
  try {
    const session = await auth();
    if (!session?.user?.id) {
      return new NextResponse("Unauthorized", { status: 401 });
    }

    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    const properties = await (prisma as any).property.findMany({
      where: {
        userId: session.user.id,
      },
      include: {
        assets: true,
        generations: true,
      },
      orderBy: {
        updatedAt: 'desc',
      }
    });

    return NextResponse.json(properties);
  } catch (error) {
    console.error("[PROPERTIES_GET]", error);
    return new NextResponse("Internal Error", { status: 500 });
  }
}

export async function POST(req: NextRequest) {
  try {
    const session = await auth();
    if (!session?.user?.id) {
      return new NextResponse("Unauthorized", { status: 401 });
    }

    const body = await req.json();
    const { title, address, description, price, bedrooms, bathrooms, sqft } = body;

    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    const property = await (prisma as any).property.create({
      data: {
        userId: session.user.id,
        title,
        address,
        description,
        price,
        bedrooms,
        bathrooms,
        sqft,
      },
    });

    return NextResponse.json(property);
  } catch (error) {
    console.error("[PROPERTIES_POST]", error);
    return new NextResponse("Internal Error", { status: 500 });
  }
}
