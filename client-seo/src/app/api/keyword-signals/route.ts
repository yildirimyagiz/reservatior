import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";

export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const { signals } = body;

    if (!signals || !Array.isArray(signals)) {
      return NextResponse.json({ error: "Invalid signals payload" }, { status: 400 });
    }

    // Pass the received keyword signals to the backend FastAPI / Elysia services if available
    const backendUrl = process.env.NEXT_PUBLIC_API_URL || "http://localhost:8000";
    
    // Log signals on backend or batch store them asynchronously
    console.log(`[Keyword Signals API] Received ${signals.length} keyword signals`);

    try {
      await fetch(`${backendUrl}/api/v1/keywords/collect`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ signals }),
      });
    } catch (e) {
      // Graceful fallback: Internal backend might be offline during development
      console.warn("[Keyword Signals API] Backend log forwarding skipped:", (e as Error).message);
    }

    return NextResponse.json({ success: true, processed: signals.length });
  } catch (error) {
    console.error("[Keyword Signals API Error]:", error);
    return NextResponse.json({ error: "Internal server error" }, { status: 500 });
  }
}
