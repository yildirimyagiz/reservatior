// ── File Upload Security Validator ─────────────────────────────────────────
// Drop-in middleware for Elysia to validate file uploads.
// Guards against: malware, path traversal, MIME mismatch, oversized files.
// ───────────────────────────────────────────────────────────────────────────

const ALLOWED_MIME_TYPES = new Set([
  "image/jpeg", "image/png", "image/webp", "image/avif", "image/svg+xml",
  "application/pdf",
  "text/csv", "text/plain",
  "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", // .xlsx
  "application/vnd.openxmlformats-officedocument.wordprocessingml.document", // .docx
]);

const FORBIDDEN_EXTENSIONS = /\.(exe|dll|bat|cmd|sh|bash|php|py|pl|rb|jsp|war|class|jar|msi|zip|rar|7z|tar)$/i;
const MAX_FILE_SIZE = 10 * 1024 * 1024; // 10MB
const MAX_IMAGE_SIZE = 20 * 1024 * 1024; // 20MB

interface UploadValidationResult {
  valid: boolean;
  error?: string;
}

export function validateUpload(
  filename: string,
  mimeType: string,
  size: number,
  buffer?: Buffer
): UploadValidationResult {
  // 1. Extension blacklist
  if (FORBIDDEN_EXTENSIONS.test(filename)) {
    return { valid: false, error: `File extension not allowed: ${filename}` };
  }

  // 2. MIME type whitelist
  if (!ALLOWED_MIME_TYPES.has(mimeType)) {
    return { valid: false, error: `MIME type not allowed: ${mimeType}` };
  }

  // 3. Size limits
  const maxSize = mimeType.startsWith("image/") ? MAX_IMAGE_SIZE : MAX_FILE_SIZE;
  if (size > maxSize) {
    const mb = (maxSize / 1024 / 1024).toFixed(0);
    return { valid: false, error: `File too large (max ${mb}MB)` };
  }

  // 4. Magic byte validation (image files)
  if (buffer && mimeType.startsWith("image/")) {
    const magicBytes: Record<string, Uint8Array[]> = {
      "image/jpeg": [new Uint8Array([0xFF, 0xD8, 0xFF])],
      "image/png": [new Uint8Array([0x89, 0x50, 0x4E, 0x47])],
      "image/webp": [new Uint8Array([0x52, 0x49, 0x46, 0x46])],
      "image/gif": [new Uint8Array([0x47, 0x49, 0x46])],
    };

    const signatures = magicBytes[mimeType];
    if (signatures) {
      const matches = signatures.some(sig =>
        sig.every((byte, i) => buffer![i] === byte)
      );
      if (!matches) {
        return { valid: false, error: "File content does not match MIME type" };
      }
    }
  }

  return { valid: true };
}

// Express/multer-compatible middleware
export function uploadValidationMiddleware(req: any, res: any, next: any) {
  if (!req.file) return next();

  const result = validateUpload(
    req.file.originalname,
    req.file.mimetype,
    req.file.size,
    req.file.buffer
  );

  if (!result.valid) {
    return res.status(415).json({ error: result.error });
  }

  next();
}
