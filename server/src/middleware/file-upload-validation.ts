/**
 * File Upload Validation Middleware
 * Enforces 5MB file size limit, type validation, and security checks
 * Prevents malware upload and server memory exhaustion
 */

import { createReadStream } from 'fs';
import { stat } from 'fs/promises';
import { extname } from 'path';

// Allowed file types for document upload
const ALLOWED_FILE_TYPES = [
  'image/jpeg',
  'image/jpg',
  'image/png',
  'application/pdf',
];

// Allowed file extensions
const ALLOWED_EXTENSIONS = [
  '.jpg',
  '.jpeg',
  '.png',
  '.pdf',
];

// Maximum file size: 5MB
const MAX_FILE_SIZE = 5 * 1024 * 1024; // 5MB in bytes

// MIME type to extension mapping
const MIME_TO_EXTENSION: Record<string, string> = {
  'image/jpeg': '.jpg',
  'image/jpg': '.jpg',
  'image/png': '.png',
  'application/pdf': '.pdf',
};

export interface FileValidationResult {
  valid: boolean;
  error?: string;
  fileSize?: number;
  fileType?: string;
  fileName?: string;
}

/**
 * Validate file size
 */
export function validateFileSize(size: number): boolean {
  return size <= MAX_FILE_SIZE;
}

/**
 * Validate file type
 */
export function validateFileType(mimeType: string): boolean {
  return ALLOWED_FILE_TYPES.includes(mimeType);
}

/**
 * Validate file extension
 */
export function validateFileExtension(filename: string): boolean {
  const ext = extname(filename).toLowerCase();
  return ALLOWED_EXTENSIONS.includes(ext);
}

/**
 * Validate MIME type matches extension
 */
export function validateMimeExtensionMatch(
  mimeType: string,
  filename: string
): boolean {
  const ext = extname(filename).toLowerCase();
  const expectedExt = MIME_TO_EXTENSION[mimeType];
  return expectedExt === ext;
}

/**
 * Sanitize filename
 */
export function sanitizeFilename(filename: string): string {
  // Remove path traversal attempts
  const sanitized = filename.replace(/(\.\.(\/|\\|$))/g, '');
  // Remove non-alphanumeric characters except dots, underscores, hyphens
  return sanitized.replace(/[^a-zA-Z0-9._-]/g, '_');
}

/**
 * Validate file upload
 */
export async function validateFileUpload(
  file: File | { size: number; type: string; name: string }
): Promise<FileValidationResult> {
  const size = file.size;
  const type = file.type;
  const name = file.name;

  // Check file size
  if (!validateFileSize(size)) {
    const sizeMB = (size / (1024 * 1024)).toFixed(2);
    return {
      valid: false,
      error: `File size (${sizeMB}MB) exceeds maximum allowed size (5MB)`,
      fileSize: size,
      fileType: type,
      fileName: name,
    };
  }

  // Check file type
  if (!validateFileType(type)) {
    return {
      valid: false,
      error: `File type (${type}) is not allowed. Allowed types: ${ALLOWED_FILE_TYPES.join(', ')}`,
      fileSize: size,
      fileType: type,
      fileName: name,
    };
  }

  // Check file extension
  if (!validateFileExtension(name)) {
    return {
      valid: false,
      error: `File extension not allowed. Allowed extensions: ${ALLOWED_EXTENSIONS.join(', ')}`,
      fileSize: size,
      fileType: type,
      fileName: name,
    };
  }

  // Check MIME type matches extension
  if (!validateMimeExtensionMatch(type, name)) {
    return {
      valid: false,
      error: `File type (${type}) does not match file extension`,
      fileSize: size,
      fileType: type,
      fileName: name,
    };
  }

  return {
    valid: true,
    fileSize: size,
    fileType: type,
    fileName: name,
  };
}

/**
 * Elysia middleware for file upload validation
 */
export const fileUploadValidationMiddleware = async ({ 
  body, 
  set, 
  headers 
}: any) => {
  // Check Content-Type for multipart/form-data
  const contentType = headers.get('content-type');
  if (!contentType?.includes('multipart/form-data')) {
    set.status = 400;
    throw new Error('Invalid content type. Expected multipart/form-data');
  }

  // Check Content-Length
  const contentLength = headers.get('content-length');
  if (contentLength && parseInt(contentLength) > MAX_FILE_SIZE) {
    set.status = 413;
    throw new Error(`Request body too large. Maximum size: 5MB`);
  }

  console.log('[File Upload] Validation passed');
};

/**
 * Multer configuration for file uploads
 */
export const multerConfig = {
  limits: {
    fileSize: MAX_FILE_SIZE,
    files: 1, // Single file upload
  },
  fileFilter: (
    req: any,
    file: { mimetype: string; originalname: string },
    cb: (error: Error | null, acceptFile: boolean) => void
  ) => {
    // Validate file type
    if (!validateFileType(file.mimetype)) {
      return cb(
        new Error(`File type ${file.mimetype} is not allowed`),
        false
      );
    }

    // Validate file extension
    if (!validateFileExtension(file.originalname)) {
      return cb(
        new Error(`File extension not allowed`),
        false
      );
    }

    // Validate MIME type matches extension
    if (!validateMimeExtensionMatch(file.mimetype, file.originalname)) {
      return cb(
        new Error(`File type does not match extension`),
        false
      );
    }

    cb(null, true);
  },
};

/**
 * Validate multiple files
 */
export async function validateMultipleFiles(
  files: Array<File | { size: number; type: string; name: string }>
): Promise<{ valid: boolean; errors: string[]; results: FileValidationResult[] }> {
  const results = await Promise.all(
    files.map(file => validateFileUpload(file))
  );

  const errors = results
    .filter(r => !r.valid)
    .map(r => r.error || 'Unknown error');

  return {
    valid: errors.length === 0,
    errors,
    results,
  };
}

/**
 * Get file size in human-readable format
 */
export function formatFileSize(bytes: number): string {
  if (bytes === 0) return '0 Bytes';
  const k = 1024;
  const sizes = ['Bytes', 'KB', 'MB', 'GB'];
  const i = Math.floor(Math.log(bytes) / Math.log(k));
  return Math.round((bytes / Math.pow(k, i)) * 100) / 100 + ' ' + sizes[i];
}

/**
 * Check if file is an image
 */
export function isImageFile(mimeType: string): boolean {
  return mimeType.startsWith('image/');
}

/**
 * Check if file is a PDF
 */
export function isPDFFile(mimeType: string): boolean {
  return mimeType === 'application/pdf';
}

/**
 * Generate safe filename for storage
 */
export function generateSafeFilename(originalName: string): string {
  const sanitized = sanitizeFilename(originalName);
  const ext = extname(sanitized);
  const baseName = sanitized.replace(ext, '');
  const timestamp = Date.now();
  const random = Math.random().toString(36).substring(2, 8);
  return `${baseName}_${timestamp}_${random}${ext}`;
}
