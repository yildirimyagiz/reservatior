/**
 * Property Claim Routes
 * Handles invitation/claim token validation and property claiming flow
 */

import { Elysia, t } from "elysia";
import { prisma } from "../lib/prisma";
import { 
  validateToken, 
  generateClaimToken, 
  generateRecoveryToken,
  buildClaimUrl,
  getTokenTimeRemaining,
  formatTimeRemaining,
  generateInvitationId,
} from "../lib/token-generator";
import { extractRealIP, extractUserAgent } from "../middleware/ip-extraction";
import { cacheSet, cacheGet, cacheDelete } from "../lib/cache";

export const claimRoutes = new Elysia({ prefix: "/claim" })

/**
 * GET /claim/validate
 * Validate claim token and return property preview (public, no auth required)
 */
.get(
  "/validate",
  async ({ query, headers, set }) => {
    const { token } = query;

    if (!token) {
      set.status = 400;
      return { error: "Token is required" };
    }

    // Validate token
    const validation = await validateToken(token);
    if (!validation.valid) {
      set.status = 400;
      return { 
        error: validation.error || "Invalid token",
        expired: validation.error?.includes('expired'),
      };
    }

    const payload = validation.payload;
    if (payload.type !== 'CLAIM' && payload.type !== 'INVITATION') {
      set.status = 400;
      return { error: "Invalid token type" };
    }

    // Check if property exists
    if (payload.propertyId) {
      const property = await prisma.property.findUnique({
        where: { id: payload.propertyId },
        select: {
          id: true,
          title: true,
          neighborhood: true,
          city: true,
          country: true,
          parcelNumber: true,
          estimatedValue: true,
          photos: {
            take: 1,
            select: { url: true },
          },
        },
      });

      if (!property) {
        set.status = 404;
        return { error: "Property not found" };
      }

      // Log invitation click
      const ipResult = extractRealIP(headers);
      const userAgent = extractUserAgent(headers);

      await prisma.invitationLog.create({
        data: {
          invitationId: generateInvitationId(),
          propertyId: payload.propertyId,
          userId: payload.userId,
          status: 'CLICKED',
          ipAddress: ipResult.ip,
          userAgent,
          metadata: { tokenType: payload.type },
        },
      });

      const timeRemaining = getTokenTimeRemaining(payload.expiresAt);

      return {
        valid: true,
        property: {
          id: property.id,
          title: property.title,
          neighborhood: property.neighborhood,
          city: property.city,
          country: property.country,
          parcelNumber: property.parcelNumber,
          estimatedValue: property.estimatedValue,
          photo: property.photos[0]?.url || null,
        },
        expiresAt: new Date(payload.expiresAt * 1000).toISOString(),
        timeRemainingSeconds: timeRemaining,
        timeRemainingFormatted: formatTimeRemaining(timeRemaining),
      };
    }

    return {
      valid: true,
      expiresAt: new Date(payload.expiresAt * 1000).toISOString(),
    };
  },
  {
    query: t.Object({
      token: t.String(),
    }),
  }
)

/**
 * POST /claim/property
 * Claim property using valid token (requires authentication)
 */
.post(
  "/property",
  async ({ body, headers, set, userId }) => {
    const { token, verificationMethod = 'DOCUMENT' } = body;

    if (!userId) {
      set.status = 401;
      return { error: "Authentication required" };
    }

    // Validate token
    const validation = await validateToken(token);
    if (!validation.valid) {
      set.status = 400;
      return { error: validation.error || "Invalid token" };
    }

    const payload = validation.payload;
    if (payload.type !== 'CLAIM' && payload.type !== 'INVITATION') {
      set.status = 400;
      return { error: "Invalid token type" };
    }

    // Check if property exists
    if (!payload.propertyId) {
      set.status = 400;
      return { error: "Property ID required in token" };
    }

    const property = await prisma.property.findUnique({
      where: { id: payload.propertyId },
    });

    if (!property) {
      set.status = 404;
      return { error: "Property not found" };
    }

    // Check if property is already claimed
    const existingVerification = await prisma.propertyOwnershipVerification.findFirst({
      where: {
        propertyId: payload.propertyId,
        verificationStatus: 'VERIFIED',
      },
    });

    if (existingVerification) {
      set.status = 409;
      return { error: "Property is already claimed by another user" };
    }

    // Create property ownership verification record
    const verification = await prisma.propertyOwnershipVerification.create({
      data: {
        propertyId: payload.propertyId,
        orgId: userId, // Use user ID as org ID for individual owners
        currentOwnerId: userId,
        verificationStatus: 'PENDING',
        verificationMethod: verificationMethod === 'DOCUMENT' ? 'DOCUMENT_UPLOAD' : 'AI_VERIFICATION',
        manualReviewRequired: true,
        priorityVerification: false,
      },
    });

    // Log invitation conversion
    const ipResult = extractRealIP(headers);
    const userAgent = extractUserAgent(headers);

    await prisma.invitationLog.updateMany({
      where: {
        propertyId: payload.propertyId,
        userId: payload.userId,
        status: 'CLICKED',
      },
      data: {
        status: 'CONVERTED',
        convertedAt: new Date(),
        ipAddress: ipResult.ip,
        userAgent,
      },
    });

    console.log(`[Claim] Property ${payload.propertyId} claimed by user ${userId}`);

    return {
      success: true,
      verificationId: verification.id,
      message: "Property claim initiated. Please complete verification.",
      nextSteps: [
        "Upload ownership documents",
        "Complete identity verification",
        "Wait for manual review",
      ],
    };
  },
  {
    body: t.Object({
      token: t.String(),
      verificationMethod: t.Optional(t.Union([
        t.Literal('DOCUMENT'),
        t.Literal('AI'),
        t.Literal('GOVERNMENT'),
      ])),
    }),
  }
)

/**
 * POST /claim/recovery
 * Request new claim token for expired invitation (self-service recovery)
 */
.post(
  "/recovery",
  async ({ body, headers, set }) => {
    const { phone, propertyId } = body;

    // Validate phone format
    const phoneRegex = /^\+?[1-9]\d{1,14}$/;
    if (!phoneRegex.test(phone)) {
      set.status = 400;
      return { error: "Invalid phone number format" };
    }

    // Check if user exists with this phone
    const user = await prisma.user.findUnique({
      where: { phone },
    });

    if (!user) {
      set.status = 404;
      return { error: "User not found with this phone number" };
    }

    // Check if property exists
    if (propertyId) {
      const property = await prisma.property.findUnique({
        where: { id: propertyId },
      });

      if (!property) {
        set.status = 404;
        return { error: "Property not found" };
      }
    }

    // Generate new recovery token
    const newToken = await generateRecoveryToken(propertyId, user.id);
    const claimUrl = buildClaimUrl(newToken);

    // Log recovery request
    const ipResult = extractRealIP(headers);
    const userAgent = extractUserAgent(headers);

    await prisma.invitationLog.create({
      data: {
        invitationId: generateInvitationId(),
        propertyId,
        userId: user.id,
        status: 'SENT',
        ipAddress: ipResult.ip,
        userAgent,
        metadata: { type: 'RECOVERY', originalPhone: phone },
      },
    });

    // Send SMS with new claim link
    const message = `Your new property claim link: ${claimUrl}. Valid for 24 hours.`;
    
    // Import SMS queue function
    const { addSMSJob } = await import("../workers/sms-queue");
    await addSMSJob({
      phone,
      message,
      type: 'RECOVERY',
      userId: user.id,
      propertyId,
    });

    console.log(`[Claim] Recovery token sent to ${phone} for property ${propertyId}`);

    return {
      success: true,
      message: "New claim link sent to your phone",
      claimUrl: process.env.NODE_ENV === 'development' ? claimUrl : undefined,
    };
  },
  {
    body: t.Object({
      phone: t.String(),
      propertyId: t.Optional(t.String()),
    }),
  }
)

/**
 * GET /claim/status/:invitationId
 * Get invitation status tracking
 */
.get(
  "/status/:invitationId",
  async ({ params, set }) => {
    const { invitationId } = params;

    const invitation = await prisma.invitationLog.findUnique({
      where: { invitationId },
    });

    if (!invitation) {
      set.status = 404;
      return { error: "Invitation not found" };
    }

    return {
      invitationId: invitation.invitationId,
      status: invitation.status,
      sentAt: invitation.sentAt,
      clickedAt: invitation.clickedAt,
      convertedAt: invitation.convertedAt,
      expiredAt: invitation.expiredAt,
      propertyId: invitation.propertyId,
      userId: invitation.userId,
    };
  },
  {
    params: t.Object({
      invitationId: t.String(),
    }),
  }
);
