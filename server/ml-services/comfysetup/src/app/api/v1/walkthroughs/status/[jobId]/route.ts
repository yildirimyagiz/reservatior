import { NextRequest, NextResponse } from "next/server";
import { auth } from "@/lib/auth";

const BACKEND_URL = process.env.BACKEND_URL || "http://127.0.0.1:8000";

export async function GET(_req: NextRequest, { params }: { params: { jobId: string } }) {
  const session = await auth();
  if (!session?.user?.id) {
    return new NextResponse("Unauthorized", { status: 401 });
  }

  const { jobId } = params;

  try {
    const res = await fetch(`${BACKEND_URL}/api/v1/walkthroughs/status/${jobId}`, {
      method: "GET",
      headers: {
        "X-User-Id": session.user.id,
      },
    });

    if (!res.ok) {
        if (res.status === 404) return new NextResponse("Job Not Found", { status: 404 });
        const errorText = await res.text();
        return new NextResponse(errorText, { status: res.status });
    }

    const data = await res.json();
    return NextResponse.json(data);
  } catch (error) {
    console.error("Walkthrough Status Error:", error);
    return new NextResponse("Internal Server Error", { status: 500 });
  }
}
