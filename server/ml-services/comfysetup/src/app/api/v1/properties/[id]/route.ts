import { NextRequest, NextResponse } from "next/server";
import { auth } from "@/lib/auth";
import prisma from "@/lib/prisma";

export async function GET(
  req: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const session = await auth();
    if (!session?.user?.id) {
      return new NextResponse("Unauthorized", { status: 401 });
    }

    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    const property = await (prisma as any).property.findUnique({
      where: {
        id: params.id,
        userId: session.user.id,
      },
      include: {
        assets: true,
        generations: true,
        walkthroughs: true,
        brochures: true,
      },
    });

    if (!property) {
      return new NextResponse("Not Found", { status: 404 });
    }

    return NextResponse.json(property);
  } catch (error) {
    console.error("[PROPERTY_GET]", error);
    return new NextResponse("Internal Error", { status: 500 });
  }
}

export async function PATCH(
  req: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const session = await auth();
    if (!session?.user?.id) {
      return new NextResponse("Unauthorized", { status: 401 });
    }

    const body = await req.json();
    const { title, address, description, price, bedrooms, bathrooms, sqft } = body;

    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    const property = await (prisma as any).property.update({
      where: {
        id: params.id,
        userId: session.user.id,
      },
      data: {
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
    console.error("[PROPERTY_PATCH]", error);
    return new NextResponse("Internal Error", { status: 500 });
  }
}

export async function DELETE(
  req: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const session = await auth();
    if (!session?.user?.id) {
      return new NextResponse("Unauthorized", { status: 401 });
    }

    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    await (prisma as any).property.delete({
      where: {
        id: params.id,
        userId: session.user.id,
      },
    });

    return new NextResponse(null, { status: 204 });
  } catch (error) {
    console.error("[PROPERTY_DELETE]", error);
    return new NextResponse("Internal Error", { status: 500 });
  }
}
