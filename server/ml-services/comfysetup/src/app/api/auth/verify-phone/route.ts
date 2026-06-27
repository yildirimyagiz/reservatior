import { NextRequest, NextResponse } from "next/server";
import { auth } from "@/lib/auth";
import prisma from "@/lib/prisma";
import twilio from "twilio";

export const dynamic = 'force-dynamic';

export async function POST(req: NextRequest) {
  const client = twilio(process.env.TWILIO_SID, process.env.TWILIO_TOKEN);
  
  const session = await auth();
  if (!session?.user?.id) {
    return new NextResponse("Unauthorized", { status: 401 });
  }

  const { phoneNumber, code } = await req.json();

  if (!phoneNumber) {
    // Send OTP Logic (Simplified for MVP)
    // In real app, check if phoneNumber is valid, then send.
    // Here we assume client sends code for verification step directly for brevity,
    // or separate endpoints for send/verify. 
    // Let's implement the VERIFY step assuming code was sent.
    
    // If no code, and just phone, we SEND.
    const verification = await client.verify.v2.services(process.env.TWILIO_VERIFY_SID!)
      .verifications
      .create({ to: phoneNumber, channel: 'sms' });
      
    return NextResponse.json({ status: verification.status });
  }

  // Verify Logic
  try {
    const verificationCheck = await client.verify.v2.services(process.env.TWILIO_VERIFY_SID!)
      .verificationChecks
      .create({ to: phoneNumber, code });

    if (verificationCheck.status === 'approved') {
      // 1. Mark verified
      await prisma.user.update({
        where: { id: session.user.id },
        data: { 
            phoneNumber, 
            phoneVerified: new Date() 
        }
      });
      
      // 2. Reduce Risk Score
      // Phone verification significantly drops risk
      await prisma.trialProfile.update({
          where: { userId: session.user.id },
          data: { riskScore: { decrement: 30 } } // Bonus
      });

      return NextResponse.json({ success: true });
    } else {
      return new NextResponse("Invalid code", { status: 400 });
    }
  } catch (error) {
    console.error("Verification failed:", error);
    return new NextResponse("Verification failed", { status: 500 });
  }
}
