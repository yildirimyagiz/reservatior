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
    
    // Transform to backend expected format
    const payload = {
        property_id: body.propertyId,
        template: body.templateId,
        custom_photos: body.customPhotos,
        title: body.title,
        address: body.address,
        description: body.description,
        price: body.price,
        bedrooms: body.bedrooms,
        bathrooms: body.bathrooms,
        sqft: body.sqft
    };
    
    const res = await fetch(`${BACKEND_URL}/api/v1/brochures/generate`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-User-Id": session.user.id,
      },
      body: JSON.stringify(payload),
    });

    if (!res.ok) {
        const errorText = await res.text();
        return new NextResponse(errorText, { status: res.status });
    }

    // Return the PDF blob
    const pdfBuffer = await res.arrayBuffer();
    return new NextResponse(pdfBuffer, {
        headers: {
            "Content-Type": "application/pdf",
            "Content-Disposition": 'attachment; filename="brochure.pdf"',
        },
    });
  } catch (error) {
    console.error("Brochure Generate Error:", error);
    return new NextResponse("Internal Server Error", { status: 500 });
  }
}
