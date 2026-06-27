import { NextResponse } from 'next/server';
import { PrismaClient } from '@prisma/client';
import bcrypt from 'bcryptjs';

const prisma = new PrismaClient();

export async function POST(request: Request) {
  try {
    const body = await request.json();
    const { email, password, name, secret } = body;

    if (secret !== process.env.ADMIN_SECRET) {
      return NextResponse.json({ error: 'Invalid secret' }, { status: 401 });
    }

    const hashedPassword = await bcrypt.hash(password, 12);

    const existingUser = await prisma.user.findUnique({
      where: { email },
    });

    if (existingUser) {
      await prisma.$executeRaw`
        UPDATE "User" 
        SET password = ${hashedPassword}, name = ${name || 'Admin'}
        WHERE email = ${email}
      `;
    } else {
      await prisma.$executeRaw`
        INSERT INTO "User" (id, email, name, password, "role", credits, "createdAt", "updatedAt")
        VALUES (
          ${crypto.randomUUID()},
          ${email},
          ${name || 'Admin'},
          ${hashedPassword},
          'ADMIN',
          1000,
          NOW(),
          NOW()
        )
      `;
    }

    return NextResponse.json({ success: true, email });
  } catch (error) {
    console.error('Admin user creation error:', error);
    return NextResponse.json(
      { error: 'Failed to create admin user' },
      { status: 500 }
    );
  }
}
