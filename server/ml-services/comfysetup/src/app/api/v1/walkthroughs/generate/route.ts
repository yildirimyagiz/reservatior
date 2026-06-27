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
    
    // Inject user plan / context if needed, or trust backend to handle it?
    // Backend expects WalkthroughInput.
    // Ideally we should pass userId to backend too.
    
    // For now, simple proxy.
    const res = await fetch(`${BACKEND_URL}/api/v1/walkthroughs/generate`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-User-Id": session.user.id, // Pass user ID for backend context
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
    console.error("Walkthrough Generate Error:", error);
    return new NextResponse("Internal Server Error", { status: 500 });
  }
}
