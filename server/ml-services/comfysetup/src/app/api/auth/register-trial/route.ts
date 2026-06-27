import { NextRequest, NextResponse } from 'next/server';
import prisma from '@/lib/prisma';
import { RiskEngine } from '@/lib/security/risk-engine';
import { RiskAnalysisResult } from '@/lib/security/types';

export async function POST(req: NextRequest) {
  try {
    const body = await req.json();
    const { email, phone, fingerprintId } = body;
    
    // Get IP from headers (Next.js/Vercel/RunPod specific)
    const ip = req.headers.get('x-forwarded-for') || '127.0.0.1';
    const userAgent = req.headers.get('user-agent') || 'Unknown';

    // 1. Analyze Risk
    const risk: RiskAnalysisResult = await RiskEngine.analyze({
      ip,
      userAgent,
      email,
      phone,
      fingerprintId
    });

    // 2. Act on Risk
    if (risk.action === 'BLOCK') {
      await RiskEngine.logEvent(null, 'BLOCK_TRIAL_ATTEMPT', risk.score, { email, fingerprintId, factors: risk.factors });
      return NextResponse.json(
        { error: 'Trial unavailable. Please contact support.', code: 'HIGH_RISK_BLOCK' },
        { status: 403 }
      );
    }

    if (risk.action === 'CHALLENGE_PAYMENT') {
      // Return a directive to the frontend to require Card details BEFORE proceeding
      return NextResponse.json({
        requiresPaymentDetails: true,
        message: 'Identity verification required via payment method.',
        riskFactors: risk.factors
      });
    }

    // 3. ALLOW - Create Trial
    // In a real app, you'd use a transaction or check if user exists first.
    // For this demo, we assume checking is done or handled by unique constraints.

    const user = await prisma.user.create({
      data: {
        email,
        phoneNumber: phone,
        fingerprints: fingerprintId ? {
          create: {
            visitorId: fingerprintId,
            userAgent,
            // In real app, parse UA for browser/OS
          }
        } : undefined,
        ipHistory: {
          create: {
            ipAddress: ip,
            // In real app, perform GeoIP lookup here
          }
        },
        trial: {
          create: {
            status: 'ACTIVE',
            totalCredits: 50, // Standard trial
            expiresAt: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000) // 7 days
          }
        }
      }
    });

    return NextResponse.json({
      success: true,
      trialId: user.id, // simplified
      credits: 50,
      riskLevel: risk.level
    });

  } catch (error) {
    console.error('Registration failed:', error);
    return NextResponse.json(
      { error: 'Registration failed' },
      { status: 500 }
    );
  }
}
