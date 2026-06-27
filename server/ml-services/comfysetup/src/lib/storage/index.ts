/**
 * Cloud Storage Module
 * 
 * Unified interface for cloud storage (R2, GCS, S3)
 * Currently using Cloudflare R2 as primary provider
 */

export { r2Storage, R2StorageClient } from './r2-client';
export type { UploadOptions, UploadResult, ImageVariants } from './r2-client';

// Re-export as default storage
import { r2Storage } from './r2-client';
export const storage = r2Storage;
