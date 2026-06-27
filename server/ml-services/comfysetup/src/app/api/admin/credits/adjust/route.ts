import { NextRequest, NextResponse } from "next/server";
import { isAdmin } from "@/lib/admin";
import prisma from "@/lib/prisma";

// POST - Adjust user credits
export async function POST(request: NextRequest) {
  const admin = await isAdmin();
  if (!admin) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  try {
    const body = await request.json();
    const { userId, amount, operation } = body;

    if (!userId || amount === undefined) {
      return NextResponse.json({ error: "userId and amount required" }, { status: 400 });
    }

    const user = await prisma.user.findUnique({
      where: { id: userId },
      select: { credits: true },
    });

    if (!user) {
      return NextResponse.json({ error: "User not found" }, { status: 404 });
    }

    let newCredits = user.credits;

    switch (operation) {
      case "add":
        newCredits += amount;
        break;
      case "subtract":
        newCredits -= amount;
        break;
      case "set":
        newCredits = amount;
        break;
      default:
        return NextResponse.json({ error: "Invalid operation" }, { status: 400 });
    }

    // Ensure credits don't go below 0
    newCredits = Math.max(0, newCredits);

    const updatedUser = await prisma.user.update({
      where: { id: userId },
      data: { credits: newCredits },
      select: {
        id: true,
        email: true,
        name: true,
        credits: true,
      },
    });

    return NextResponse.json({
      success: true,
      user: updatedUser,
      previousCredits: user.credits,
      newCredits,
    });
  } catch (error) {
    console.error("Error adjusting credits:", error);
    return NextResponse.json({ error: "Failed to adjust credits" }, { status: 500 });
  }
}
