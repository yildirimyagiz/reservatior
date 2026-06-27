import { NextRequest, NextResponse } from "next/server";
import { auth } from "@/lib/auth";

const BACKEND_URL = process.env.BACKEND_URL || "http://127.0.0.1:8000";

export async function POST(req: NextRequest) {
  const session = await auth();
  if (!session?.user?.id) {
    return new NextResponse("Unauthorized", { status: 401 });
  }

  try {
    const body = await req.json();
    
    const res = await fetch(`${BACKEND_URL}/api/v1/walkthroughs/select-pipeline`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-User-Id": session.user.id,
      },
      body: JSON.stringify(body),
    });

    if (!res.ok) {
        const errorText = await res.text();
        return new NextResponse(errorText, { status: res.status });
    }

    const data = await res.json();
    return NextResponse.json(data);
  } catch (error) {
    console.error("Walkthrough Pipeline Select Error:", error);
    return new NextResponse("Internal Server Error", { status: 500 });
  }
}
