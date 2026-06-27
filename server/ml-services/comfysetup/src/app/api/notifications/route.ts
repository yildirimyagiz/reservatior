
import { NextResponse } from "next/server";
import { auth } from "@/lib/auth";
import prisma from "@/lib/prisma";

export async function GET(req: Request) {
  try {
    const session = await auth();

    if (!session?.user?.id) {
      return new NextResponse("Unauthorized", { status: 401 });
    }

    const { searchParams } = new URL(req.url);
    const limit = parseInt(searchParams.get("limit") || "20");
    const unreadOnly = searchParams.get("unreadOnly") === "true";

    const notifications = await prisma.notification.findMany({
      where: {
        userId: session.user.id,
        ...(unreadOnly ? { read: false } : {}),
      },
      orderBy: {
        createdAt: "desc",
      },
      take: limit,
    });

    return NextResponse.json(notifications);
  } catch (error) {
    console.error("[NOTIFICATIONS_GET]", error);
    return new NextResponse("Internal Error", { status: 500 });
  }
}

export async function POST(req: Request) {
  try {
    const session = await auth();

    if (!session?.user?.id) {
      return new NextResponse("Unauthorized", { status: 401 });
    }

    const body = await req.json();

    // Manual validation
    if (!body.title || !body.message || !body.type) {
        return new NextResponse("Missing required fields", { status: 400 });
    }

    const validTypes = ["GENERATION", "CREDIT", "SYSTEM", "PROMO", "SECURITY"];
    if (!validTypes.includes(body.type)) {
        return new NextResponse("Invalid notification type", { status: 400 });
    }

    const notification = await prisma.notification.create({
      data: {
        userId: session.user.id,
        type: body.type,
        title: body.title,
        message: body.message,
        link: body.link,
        imageUrl: body.imageUrl,
      },
    });

    return NextResponse.json(notification);
  } catch (error) {
    console.error("[NOTIFICATIONS_POST]", error);
    return new NextResponse("Internal Error", { status: 500 });
  }
}
