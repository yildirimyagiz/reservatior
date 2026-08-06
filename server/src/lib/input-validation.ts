/**
 * Input Validation and Sanitization Library
 * Comprehensive validation for user inputs to prevent injection attacks
 * Type-safe validation with detailed error messages
 */

import { z } from 'zod';

// Common validation schemas
export const emailSchema = z.string()
  .email('Invalid email format')
  .max(255, 'Email too long')
  .trim();

export const phoneSchema = z.string()
  .regex(/^\+?[1-9]\d{1,14}$/, 'Invalid phone number format')
  .trim();

export const urlSchema = z.string()
  .url('Invalid URL format')
  .max(2048, 'URL too long')
  .trim();

export const uuidSchema = z.string()
  .uuid('Invalid UUID format');

export const idSchema = z.string()
  .min(1, 'ID cannot be empty')
  .max(100, 'ID too long')
  .regex(/^[a-zA-Z0-9_-]+$/, 'ID can only contain alphanumeric characters, hyphens, and underscores');

export const nameSchema = z.string()
  .min(1, 'Name cannot be empty')
  .max(100, 'Name too long')
  .regex(/^[a-zA-ZğüşıöçĞÜŞİÖÇ\s\-']+$/, 'Name contains invalid characters')
  .trim();

export const passwordSchema = z.string()
  .min(8, 'Password must be at least 8 characters')
  .max(128, 'Password too long')
  .regex(/[A-Z]/, 'Password must contain at least one uppercase letter')
  .regex(/[a-z]/, 'Password must contain at least one lowercase letter')
  .regex(/[0-9]/, 'Password must contain at least one number')
  .regex(/[^A-Za-z0-9]/, 'Password must contain at least one special character');

export const addressSchema = z.string()
  .min(1, 'Address cannot be empty')
  .max(500, 'Address too long')
  .trim();

export const postalCodeSchema = z.string()
  .min(3, 'Postal code too short')
  .max(10, 'Postal code too long')
  .regex(/^[A-Za-z0-9\s\-]+$/, 'Postal code contains invalid characters')
  .trim();

export const currencySchema = z.string()
  .min(3, 'Currency code too short')
  .max(3, 'Currency code too long')
  .regex(/^[A-Z]{3}$/, 'Invalid currency code (must be 3 uppercase letters)');

export const countryCodeSchema = z.string()
  .min(2, 'Country code too short')
  .max(2, 'Country code too long')
  .regex(/^[A-Z]{2}$/, 'Invalid country code (must be 2 uppercase letters)');

export const dateSchema = z.string()
  .datetime('Invalid date format');

export const positiveNumberSchema = z.number()
  .positive('Number must be positive')
  .finite('Number must be finite');

export const percentageSchema = z.number()
  .min(0, 'Percentage cannot be negative')
  .max(100, 'Percentage cannot exceed 100');

// Sanitization functions
export function sanitizeString(input: string): string {
  return input
    .trim()
    .replace(/[<>]/g, '') // Remove angle brackets
    .replace(/javascript:/gi, '') // Remove javascript: protocol
    .replace(/on\w+\s*=/gi, ''); // Remove event handlers
}

export function sanitizeHTML(input: string): string {
  return input
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#x27;');
}

export function sanitizeSQL(input: string): string {
  return input
    .replace(/'/g, "''")
    .replace(/--/g, '')
    .replace(/;/g, '');
}

export function sanitizePath(input: string): string {
  return input
    .replace(/\.\./g, '')
    .replace(/[<>:"|?*]/g, '')
    .replace(/\\/g, '/');
}

export function sanitizeFilename(input: string): string {
  return input
    .replace(/[<>:"/\\|?*]/g, '_')
    .replace(/\.\./g, '')
    .substring(0, 255);
}

// Validation result type
export interface ValidationResult<T> {
  success: boolean;
  data?: T;
  errors?: string[];
}

/**
 * Validate input against schema
 */
export function validateInput<T>(schema: z.ZodSchema<T>, input: unknown): ValidationResult<T> {
  try {
    const data = schema.parse(input);
    return { success: true, data };
  } catch (error) {
    if (error instanceof z.ZodError) {
      const errors = error.errors.map(e => `${e.path.join('.')}: ${e.message}`);
      return { success: false, errors };
    }
    return { success: false, errors: ['Validation failed'] };
  }
}

/**
 * Validate and sanitize email
 */
export function validateAndSanitizeEmail(email: string): ValidationResult<string> {
  const result = validateInput(emailSchema, email);
  if (result.success && result.data) {
    return { success: true, data: result.data.toLowerCase().trim() };
  }
  return result;
}

/**
 * Validate and sanitize phone number
 */
export function validateAndSanitizePhone(phone: string): ValidationResult<string> {
  const result = validateInput(phoneSchema, phone);
  if (result.success && result.data) {
    // Normalize phone format
    const normalized = result.data.replace(/\s+/g, '');
    return { success: true, data: normalized };
  }
  return result;
}

/**
 * Validate and sanitize URL
 */
export function validateAndSanitizeURL(url: string): ValidationResult<string> {
  const result = validateInput(urlSchema, url);
  if (result.success && result.data) {
    return { success: true, data: result.data.trim() };
  }
  return result;
}

/**
 * Validate and sanitize name
 */
export function validateAndSanitizeName(name: string): ValidationResult<string> {
  const result = validateInput(nameSchema, name);
  if (result.success && result.data) {
    return { success: true, data: sanitizeString(result.data) };
  }
  return result;
}

/**
 * Validate and sanitize address
 */
export function validateAndSanitizeAddress(address: string): ValidationResult<string> {
  const result = validateInput(addressSchema, address);
  if (result.success && result.data) {
    return { success: true, data: sanitizeString(result.data) };
  }
  return result;
}

/**
 * Validate object with multiple fields
 */
export function validateObject<T extends Record<string, any>>(
  schema: z.ZodSchema<T>,
  input: unknown
): ValidationResult<T> {
  return validateInput(schema, input);
}

// Common object validation schemas
export const userRegistrationSchema = z.object({
  email: emailSchema,
  password: passwordSchema,
  name: nameSchema,
  phone: phoneSchema.optional(),
});

export const propertySchema = z.object({
  title: z.string().min(1).max(200),
  description: z.string().max(5000),
  address: addressSchema,
  city: z.string().min(1).max(100),
  country: countryCodeSchema,
  postalCode: postalCodeSchema,
  price: positiveNumberSchema,
  currency: currencySchema,
  area: positiveNumberSchema.optional(),
  bedrooms: z.number().int().min(0).max(50).optional(),
  bathrooms: z.number().int().min(0).max(50).optional(),
  yearBuilt: z.number().int().min(1800).max(new Date().getFullYear() + 1).optional(),
});

export const leadSchema = z.object({
  name: nameSchema,
  email: emailSchema,
  phone: phoneSchema,
  propertyId: idSchema,
  message: z.string().max(2000).optional(),
});

export const documentSchema = z.object({
  title: z.string().min(1).max(200),
  type: z.enum(['CONTRACT', 'IDENTITY', 'PROPERTY', 'FINANCIAL', 'OTHER']),
  description: z.string().max(1000).optional(),
});

/**
 * Batch validation for multiple inputs
 */
export function validateBatch<T>(
  items: unknown[],
  schema: z.ZodSchema<T>
): ValidationResult<T[]> {
  const results: T[] = [];
  const errors: string[] = [];

  items.forEach((item, index) => {
    const result = validateInput(schema, item);
    if (result.success && result.data) {
      results.push(result.data);
    } else {
      errors.push(`Item ${index}: ${result.errors?.join(', ')}`);
    }
  });

  if (errors.length > 0) {
    return { success: false, errors };
  }

  return { success: true, data: results };
}

/**
 * Check for SQL injection patterns
 */
export function containsSQLInjection(input: string): boolean {
  const patterns = [
    /(\b(SELECT|INSERT|UPDATE|DELETE|DROP|UNION|EXEC|ALTER|CREATE|TRUNCATE)\b)/i,
    /(--|\#|\/\*|\*\/|;)/,
    /(\b(OR|AND)\s+\d+\s*=\s*\d+)/i,
    /(\b(OR|AND)\s+['"]?\w+['"]?\s*=\s*['"]?\w+['"])/i,
  ];

  return patterns.some(pattern => pattern.test(input));
}

/**
 * Check for XSS patterns
 */
export function containsXSS(input: string): boolean {
  const patterns = [
    /<script[^>]*>.*?<\/script>/gi,
    /<iframe[^>]*>.*?<\/iframe>/gi,
    /javascript:/gi,
    /on\w+\s*=/gi,
  ];

  return patterns.some(pattern => pattern.test(input));
}

/**
 * Comprehensive security check
 */
export function securityCheck(input: string): { safe: boolean; threats: string[] } {
  const threats: string[] = [];

  if (containsSQLInjection(input)) {
    threats.push('SQL_INJECTION');
  }

  if (containsXSS(input)) {
    threats.push('XSS');
  }

  if (input.includes('..')) {
    threats.push('PATH_TRAVERSAL');
  }

  if (/\/\//.test(input)) {
    threats.push('DOUBLE_SLASH');
  }

  return {
    safe: threats.length === 0,
    threats,
  };
}

/**
 * Elysia middleware for input validation
 */
export const inputValidationMiddleware = async ({ body, query, set }: any) => {
  // Validate query parameters
  if (query) {
    for (const [key, value] of Object.entries(query)) {
      if (typeof value === 'string') {
        const check = securityCheck(value);
        if (!check.safe) {
          set.status = 400;
          throw new Error(`Invalid input in parameter '${key}': ${check.threats.join(', ')}`);
        }
      }
    }
  }

  // Validate request body
  if (body) {
    for (const [key, value] of Object.entries(body)) {
      if (typeof value === 'string') {
        const check = securityCheck(value);
        if (!check.safe) {
          set.status = 400;
          throw new Error(`Invalid input in field '${key}': ${check.threats.join(', ')}`);
        }
      }
    }
  }

  console.log('[Input Validation] All inputs passed security checks');
};
