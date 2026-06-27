
import { NextResponse } from "next/server";
import { auth } from "@/lib/auth";
import prisma from "@/lib/prisma";

export async function PATCH(
  req: Request,
  { params }: { params: Promise<{ id: string }> }
) {
  try {
    const session = await auth();
    const { id } = await params;

    if (!session?.user?.id) {
      return new NextResponse("Unauthorized", { status: 401 });
    }

    const body = await req.json();

    if (typeof body.read !== 'boolean') {
        return new NextResponse("Invalid request data: read must be a boolean", { status: 400 });
    }

    // Verify ownership
    const existingNotification = await prisma.notification.findUnique({
      where: { id },
    });

    if (!existingNotification) {
      return new NextResponse("Not Found", { status: 404 });
    }

    if (existingNotification.userId !== session.user.id) {
      return new NextResponse("Forbidden", { status: 403 });
    }

    const notification = await prisma.notification.update({
      where: { id },
      data: {
        read: body.read,
      },
    });

    return NextResponse.json(notification);
  } catch (error) {
    console.error("[NOTIFICATION_PATCH]", error);
    return new NextResponse("Internal Error", { status: 500 });
  }
}

export async function DELETE(
  req: Request,
  { params }: { params: Promise<{ id: string }> }
) {
  try {
    const session = await auth();
    const { id } = await params;

    if (!session?.user?.id) {
      return new NextResponse("Unauthorized", { status: 401 });
    }

    // Verify ownership
    const existingNotification = await prisma.notification.findUnique({
      where: { id },
    });

    if (!existingNotification) {
      return new NextResponse("Not Found", { status: 404 });
    }

    if (existingNotification.userId !== session.user.id) {
      return new NextResponse("Forbidden", { status: 403 });
    }

    await prisma.notification.delete({
      where: { id },
    });

    return new NextResponse(null, { status: 204 });
  } catch (error) {
    console.error("[NOTIFICATION_DELETE]", error);
    return new NextResponse("Internal Error", { status: 500 });
  }
}
