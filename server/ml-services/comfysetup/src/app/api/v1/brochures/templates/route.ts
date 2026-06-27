import { NextResponse } from "next/server";
import { auth } from "@/lib/auth";

const BACKEND_URL = process.env.BACKEND_URL || "http://127.0.0.1:8000";

export async function GET() {
  const session = await auth();
  if (!session?.user?.id) {
    return new NextResponse("Unauthorized", { status: 401 });
  }

  try {
    const res = await fetch(`${BACKEND_URL}/api/v1/brochures/templates`, {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        "X-User-Id": session.user.id,
      },
    });

    if (!res.ok) {
        return new NextResponse("Failed to fetch templates", { status: res.status });
    }

    const data = await res.json();
    return NextResponse.json(data);
  } catch (error) {
    console.error("Brochure Templates Error:", error);
    return new NextResponse("Internal Server Error", { status: 500 });
  }
}
