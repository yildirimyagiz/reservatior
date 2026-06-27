import { NextRequest, NextResponse } from "next/server";
import { auth } from "@/lib/auth";
import prisma from "@/lib/prisma";

export async function GET(req: NextRequest) {
  try {
    const session = await auth();
    if (!session?.user?.id) {
      return new NextResponse("Unauthorized", { status: 401 });
    }

    const { searchParams } = new URL(req.url);
    const propertyId = searchParams.get("propertyId");

    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    const where: any = {
      userId: session.user.id,
    };
    if (propertyId) {
      where.propertyId = propertyId;
    }

    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    const assets = await (prisma as any).asset.findMany({
      where,
      orderBy: {
        createdAt: 'desc',
      }
    });

    return NextResponse.json(assets);
  } catch (error) {
    console.error("[ASSETS_GET]", error);
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
    const { url, filename, mimeType, size, propertyId } = body;

    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    const asset = await (prisma as any).asset.create({
      data: {
        userId: session.user.id,
        url,
        filename,
        mimeType,
        size,
        propertyId,
      },
      include: {
        property: true,
      }
    });

    return NextResponse.json(asset);
  } catch (error) {
    console.error("[ASSETS_POST]", error);
    return new NextResponse("Internal Error", { status: 500 });
  }
}
