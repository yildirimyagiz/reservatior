import { NextResponse } from "next/server";
import { auth } from "@/lib/auth";
import prisma from "@/lib/prisma";

export async function GET() {
  try {
    const session = await auth();
    if (!session?.user?.id) {
      return new NextResponse("Unauthorized", { status: 401 });
    }

    const walkthroughs = await prisma.walkthrough.findMany({
      where: {
        userId: session.user.id,
      },
      orderBy: {
        createdAt: "desc",
      },
    });

    return NextResponse.json(walkthroughs);
  } catch (error) {
    console.error("Walkthrough List Error:", error);
    return new NextResponse("Internal Server Error", { status: 500 });
  }
}
