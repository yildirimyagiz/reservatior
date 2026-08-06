/**
 * SMS OTP Authentication Routes
 * Passwordless authentication using 6-digit OTP codes sent via SMS
 */

import { Elysia, t } from "elysia";
import { prisma } from "../lib/prisma";
import { 
  generateOTPCode, 
  generateOTPToken, 
  hashPhone, 
  validateToken 
} from "../lib/token-generator";
import { addSMSJob } from "../workers/sms-queue";
import { cacheSet, cacheGet, cacheDelete } from "../lib/cache";

export const authOTPRoutes = new Elysia({ prefix: "/auth/otp" })

/**
 * POST /auth/otp/send
 * Send 6-digit OTP code to phone number
 */
.post(
  "/send",
  async ({ body, set }) => {
    const { phone, type = 'LOGIN' } = body;

    // Validate phone format (basic validation)
    const phoneRegex = /^\+?[1-9]\d{1,14}$/;
    if (!phoneRegex.test(phone)) {
      set.status = 400;
      return { error: "Invalid phone number format" };
    }

    // Generate OTP code
    const otpCode = generateOTPCode();
    const phoneHash = hashPhone(phone);

    // Store OTP in Redis with 5-minute expiration
    await cacheSet(`otp:${phoneHash}`, {
      code: otpCode,
      phone,
      type,
      attempts: 0,
      createdAt: Date.now(),
    }, 300); // 5 minutes

    // Send OTP via SMS queue
    const message = `Your Reservatior verification code is: ${otpCode}. Valid for 5 minutes. Do not share this code.`;
    
    await addSMSJob({
      phone,
      message,
      type: 'OTP',
      metadata: { otpType: type },
    });

    console.log(`[OTP] Sent OTP to ${phone} for ${type}`);

    return {
      success: true,
      message: "OTP sent successfully",
      // In production, don't return this - only for development
      ...(process.env.NODE_ENV === 'development' && { otpCode }),
    };
  },
  {
    body: t.Object({
      phone: t.String(),
      type: t.Optional(t.Union([
        t.Literal('LOGIN'),
        t.Literal('REGISTER'),
        t.Literal('VERIFICATION'),
        t.Literal('RECOVERY'),
      ])),
    }),
  }
)

/**
 * POST /auth/otp/verify
 * Verify OTP code and create/update user session
 */
.post(
  "/verify",
  async ({ body, set }) => {
    const { phone, code, type = 'LOGIN' } = body;

    const phoneHash = hashPhone(phone);
    const cachedOTP = await cacheGet(`otp:${phoneHash}`);

    if (!cachedOTP) {
      set.status = 400;
      return { error: "OTP expired or not found. Please request a new code." };
    }

    // Check attempts
    if (cachedOTP.attempts >= 3) {
      await cacheDelete(`otp:${phoneHash}`);
      set.status = 400;
      return { error: "Too many failed attempts. Please request a new code." };
    }

    // Verify code
    if (cachedOTP.code !== code) {
      // Increment attempts
      cachedOTP.attempts++;
      await cacheSet(`otp:${phoneHash}`, cachedOTP, 300);
      
      set.status = 400;
      return { 
        error: "Invalid OTP code", 
        attemptsRemaining: 3 - cachedOTP.attempts 
      };
    }

    // OTP is valid - delete it
    await cacheDelete(`otp:${phoneHash}`);

    // Check if user exists
    let user = await prisma.user.findUnique({
      where: { phone },
    });

    // Create user if doesn't exist (implicit signup)
    if (!user) {
      if (type === 'LOGIN') {
        set.status = 404;
        return { error: "User not found. Please register first." };
      }

      // Create new user
      user = await prisma.user.create({
        data: {
          phone,
          email: null, // Will be set later
          name: null, // Will be set later
          emailVerified: true, // Phone verified
        },
      });

      console.log(`[OTP] Created new user with phone ${phone}`);
    }

    // Generate JWT token
    const token = await generateOTPToken(user.id);

    // Cache session
    await cacheSet(`session:${user.id}`, {
      userId: user.id,
      phone: user.phone,
      email: user.email,
      name: user.name,
      authenticatedAt: Date.now(),
    }, 604800); // 7 days

    console.log(`[OTP] Verified OTP for ${phone}, user: ${user.id}`);

    return {
      success: true,
      user: {
        id: user.id,
        phone: user.phone,
        email: user.email,
        name: user.name,
        isNewUser: !user.email && !user.name,
      },
      token,
    };
  },
  {
    body: t.Object({
      phone: t.String(),
      code: t.String(),
      type: t.Optional(t.Union([
        t.Literal('LOGIN'),
        t.Literal('REGISTER'),
        t.Literal('VERIFICATION'),
        t.Literal('RECOVERY'),
      ])),
    }),
  }
)

/**
 * POST /auth/otp/resend
 * Resend OTP code (rate limited)
 */
.post(
  "/resend",
  async ({ body, set }) => {
    const { phone, type = 'LOGIN' } = body;

    const phoneHash = hashPhone(phone);
    const cachedOTP = await cacheGet(`otp:${phoneHash}`);

    // Check if OTP was recently sent (rate limit: 30 seconds)
    if (cachedOTP && Date.now() - cachedOTP.createdAt < 30000) {
      set.status = 429;
      return { 
        error: "Please wait before requesting another code",
        retryAfter: Math.ceil((cachedOTP.createdAt + 30000 - Date.now()) / 1000),
      };
    }

    // Generate new OTP
    const otpCode = generateOTPCode();

    // Store new OTP
    await cacheSet(`otp:${phoneHash}`, {
      code: otpCode,
      phone,
      type,
      attempts: 0,
      createdAt: Date.now(),
    }, 300); // 5 minutes

    // Send via SMS
    const message = `Your Reservatior verification code is: ${otpCode}. Valid for 5 minutes. Do not share this code.`;
    
    await addSMSJob({
      phone,
      message,
      type: 'OTP',
      metadata: { otpType: type },
    });

    console.log(`[OTP] Resent OTP to ${phone}`);

    return {
      success: true,
      message: "OTP resent successfully",
      ...(process.env.NODE_ENV === 'development' && { otpCode }),
    };
  },
  {
    body: t.Object({
      phone: t.String(),
      type: t.Optional(t.Union([
        t.Literal('LOGIN'),
        t.Literal('REGISTER'),
        t.Literal('VERIFICATION'),
        t.Literal('RECOVERY'),
      ])),
    }),
  }
);
