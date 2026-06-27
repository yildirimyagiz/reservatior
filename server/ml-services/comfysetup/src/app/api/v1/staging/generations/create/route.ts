import { NextRequest, NextResponse } from 'next/server';
import prisma from '@/lib/prisma';
import { hasValidPaymentMethod } from '@/lib/billing/stripe-verification';

export async function POST(req: NextRequest) {
  try {
    const { userId, cost = 1 } = await req.json();

    // 1. Check Trial Status & Credits
    const trial = await prisma.trialProfile.findUnique({
      where: { userId }
    });

    if (!trial || trial.status !== 'ACTIVE') {
      return NextResponse.json({ error: 'No active trial found.' }, { status: 403 });
    }

    // 2. Check Daily Limits (Silent Throttling)
    const today = new Date();
    // Reset daily usage if new day
    if (trial.lastUsageDate.getDate() !== today.getDate()) {
       await prisma.trialProfile.update({
         where: { userId },
         data: { todayUsage: 0, lastUsageDate: today }
       });
       trial.todayUsage = 0;
    }

    if (trial.todayUsage >= trial.dailyLimit) {
      // SILENT THROTTLING: Return success but don't generate, or generate low-res
      return NextResponse.json({ 
        error: 'Daily limit reached. Upgrade for more.',
        code: 'DAILY_LIMIT' 
      }, { status: 429 });
    }

    // 3. Check Total Credits
    if ((trial.usedCredits + cost) > trial.totalCredits) {
      // Risk Check: If they are out of credits but "Low Risk", maybe allow 1-2 more?
      return NextResponse.json({ error: 'Trial credits exhausted.' }, { status: 402 });
    }

    // 4. (Optional) Check Stripe for "High Risk" users
    // If user was flagged as MEDIUM/HIGH risk earlier, enforce card requirement now
    if (trial.riskLevel === 'HIGH' || trial.riskLevel === 'MEDIUM') {
      const hasCard = await hasValidPaymentMethod(userId);
      if (!hasCard) {
        return NextResponse.json({
          error: 'Verification required.',
          requiresPaymentMethod: true
        }, { status: 402 });
      }
    }

    // 5. Deduct Credits
    await prisma.trialProfile.update({
      where: { userId },
      data: {
        usedCredits: { increment: cost },
        todayUsage: { increment: 1 }
      }
    });

    return NextResponse.json({ success: true, remaining: trial.totalCredits - trial.usedCredits - cost });

  } catch (error) {
    console.error('Generation request failed:', error);
    return NextResponse.json({ error: 'Generation failed' }, { status: 500 });
  }
}
