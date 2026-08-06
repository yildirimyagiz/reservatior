/**
 * Token Generation Service
 * URL-safe Base64URL encoding for invitation/claim tokens
 * Security: HMAC-SHA256 signing for tamper detection
 */

import { SignJWT, jwtVerify } from 'jose';
import crypto from 'crypto';

const ENCODED_SECRET = new TextEncoder().encode(
  process.env.JWT_SECRET || 'default-secret-change-in-production'
);

export interface TokenPayload {
  propertyId?: string;
  userId?: string;
  type: 'INVITATION' | 'CLAIM' | 'OTP' | 'RECOVERY';
  expiresAt: number;
}

export interface TokenValidationResult {
  valid: boolean;
  payload?: TokenPayload;
  error?: string;
}

/**
 * Generate URL-safe Base64URL encoded token
 * Format: base64url(payload) + '.' + base64url(signature)
 */
export async function generateToken(payload: TokenPayload): Promise<string> {
  const token = await new SignJWT({
    ...payload,
    iat: Math.floor(Date.now() / 1000),
  })
    .setProtectedHeader({ alg: 'HS256' })
    .setIssuedAt()
    .setExpirationTime(payload.expiresAt)
    .sign(ENCODED_SECRET);

  // Convert to URL-safe Base64URL (replace + with -, / with _, remove = padding)
  return token
    .replace(/\+/g, '-')
    .replace(/\//g, '_')
    .replace(/=/g, '');
}

/**
 * Validate and decode token
 */
export async function validateToken(token: string): Promise<TokenValidationResult> {
  try {
    // Restore standard Base64 format
    const restoredToken = token
      .replace(/-/g, '+')
      .replace(/_/g, '/');

    // Add padding if needed
    const paddedToken = restoredToken + '='.repeat((4 - (restoredToken.length % 4)) % 4);

    const { payload } = await jwtVerify(paddedToken, ENCODED_SECRET);

    // Check expiration
    if (payload.exp && payload.exp < Math.floor(Date.now() / 1000)) {
      return {
        valid: false,
        error: 'Token expired',
      };
    }

    return {
      valid: true,
      payload: payload as unknown as TokenPayload,
    };
  } catch (error) {
    return {
      valid: false,
      error: error instanceof Error ? error.message : 'Invalid token',
    };
  }
}

/**
 * Generate invitation token (48 hours expiration)
 */
export async function generateInvitationToken(
  propertyId: string,
  userId?: string
): Promise<string> {
  const expiresAt = Math.floor((Date.now() + 48 * 60 * 60 * 1000) / 1000); // 48 hours
  return generateToken({
    propertyId,
    userId,
    type: 'INVITATION',
    expiresAt,
  });
}

/**
 * Generate claim token (7 days expiration)
 */
export async function generateClaimToken(
  propertyId: string,
  userId?: string
): Promise<string> {
  const expiresAt = Math.floor((Date.now() + 7 * 24 * 60 * 60 * 1000) / 1000); // 7 days
  return generateToken({
    propertyId,
    userId,
    type: 'CLAIM',
    expiresAt,
  });
}

/**
 * Generate OTP token (5 minutes expiration)
 */
export async function generateOTPToken(userId: string): Promise<string> {
  const expiresAt = Math.floor((Date.now() + 5 * 60 * 1000) / 1000); // 5 minutes
  return generateToken({
    userId,
    type: 'OTP',
    expiresAt,
  });
}

/**
 * Generate recovery token (24 hours expiration)
 */
export async function generateRecoveryToken(
  propertyId: string,
  userId?: string
): Promise<string> {
  const expiresAt = Math.floor((Date.now() + 24 * 60 * 60 * 1000) / 1000); // 24 hours
  return generateToken({
    propertyId,
    userId,
    type: 'RECOVERY',
    expiresAt,
  });
}

/**
 * Generate 6-digit OTP code for SMS verification
 */
export function generateOTPCode(): string {
  return Math.floor(100000 + Math.random() * 900000).toString();
}

/**
 * Hash phone number for OTP storage (privacy)
 */
export function hashPhone(phone: string): string {
  return crypto
    .createHash('sha256')
    .update(phone + process.env.JWT_SECRET)
    .digest('hex');
}

/**
 * Generate unique invitation ID
 */
export function generateInvitationId(): string {
  return crypto.randomUUID();
}

/**
 * Extract token from URL parameter
 */
export function extractTokenFromUrl(url: string): string | null {
  try {
    const urlObj = new URL(url);
    return urlObj.searchParams.get('token');
  } catch {
    return null;
  }
}

/**
 * Build claim URL with token
 */
export function buildClaimUrl(token: string, baseUrl?: string): string {
  const base = baseUrl || process.env.CLIENT_URL || 'https://reservatior.com';
  return `${base}/claim?token=${token}`;
}

/**
 * Check if token is expired
 */
export function isTokenExpired(expiresAt: number): boolean {
  return expiresAt < Math.floor(Date.now() / 1000);
}

/**
 * Get time remaining until token expiration (in seconds)
 */
export function getTokenTimeRemaining(expiresAt: number): number {
  const remaining = expiresAt - Math.floor(Date.now() / 1000);
  return Math.max(0, remaining);
}

/**
 * Format time remaining for display
 */
export function formatTimeRemaining(seconds: number): string {
  if (seconds < 60) return `${seconds} seconds`;
  if (seconds < 3600) return `${Math.floor(seconds / 60)} minutes`;
  if (seconds < 86400) return `${Math.floor(seconds / 3600)} hours`;
  return `${Math.floor(seconds / 86400)} days`;
}
