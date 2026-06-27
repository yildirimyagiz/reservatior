import { NextResponse } from 'next/server';
import { auth } from '@/lib/auth';
import prisma from '@/lib/prisma';
import { hasValidPaymentMethod } from '@/lib/billing/stripe-verification';

export async function POST() {
    try {
        const session = await auth();
        
        if (!session?.user?.id) {
            return new NextResponse('Unauthorized', { status: 401 });
        }

        const userId = session.user.id;

        // 1. Check if user already has a trial profile
        const existingTrial = await prisma.trialProfile.findUnique({
            where: { userId }
        });

        if (existingTrial) {
            return NextResponse.json(
                { error: 'Trial already activated or used' },
                { status: 400 }
            );
        }

        // 1.2 Fetch Full User Data to check constraints
        const user = await prisma.user.findUnique({ where: { id: userId } });
        if (!user) return new NextResponse('User not found', { status: 404 });

        // 1.3 Check Phone Number (Mandatory)
        if (!user.phoneNumber) {
            return NextResponse.json(
                { error: 'Phone number required for verification', code: 'MISSING_PHONE' }, 
                { status: 403 }
            );
        }
        
        // 1.5 Verify Payment Method (Requirement)
        const hasCard = await hasValidPaymentMethod(userId);
        if (!hasCard) {
             return NextResponse.json({ error: 'Credit card verification required for trial' }, { status: 402 });
        }

        // 2. Create new Trial Profile
        // 5 Days, 5 Credits
        const trial = await prisma.trialProfile.create({
            data: {
                userId,
                status: 'ACTIVE',
                expiresAt: new Date(Date.now() + 5 * 24 * 60 * 60 * 1000), // +5 days
                totalCredits: 5,
                dailyLimit: 5,
                usedCredits: 0
            }
        });

        return NextResponse.json({ 
            success: true, 
            trialId: trial.id,
            expiresAt: trial.expiresAt,
            credits: trial.totalCredits
        });

    } catch (error) {
        console.error('Trial creation failed:', error);
        return new NextResponse('Internal Server Error', { status: 500 });
    }
}
