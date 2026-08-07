/**
 * REOS v5 — Storage OS Gateway
 *
 * Multi-cloud abstraction layer for object storage.
 * Supports AWS S3, Cloudflare R2 (S3-compatible), and Google Cloud Storage.
 *
 * Audit fix:
 *  - Removes local disk dependency (backend/uploads/, backend/storage/)
 *  - Enforces tenant-isolated paths: tenantId/propertyId/category/filename
 *  - All media references in the domain are mediaIds, never raw URLs
 *  - Pre-signed URLs are the ONLY way to access assets (short TTL, signed)
 */

import {
  S3Client,
  PutObjectCommand,
  DeleteObjectCommand,
  GetObjectCommand,
  HeadObjectCommand,
  ListObjectsV2Command,
  type PutObjectCommandInput,
} from '@aws-sdk/client-s3';
import { getSignedUrl } from '@aws-sdk/s3-request-presigner';
import { eventBus } from '../events/event-bus';
import { StorageOSEvents } from '../domain/events/event-catalog';
import { randomUUID } from 'crypto';

// --- Types ---

export type MediaCategory =
  | 'images'
  | 'videos'
  | 'brochures'
  | 'contracts'
  | 'digital-twin'
  | 'thumbnails'
  | 'hls'
  | 'voiceover'
  | 'subtitles';

export interface UploadOptions {
  tenantId: string;
  propertyId: string;
  category: MediaCategory;
  filename: string;
  contentType: string;
  body: Buffer | Uint8Array | ReadableStream;
  metadata?: Record<string, string>;
  encrypt?: boolean;
}

export interface ObjectRef {
  mediaId: string;        // Opaque ID (UUID), the only thing the domain sees
  key: string;            // Internal S3 key: tenantId/propertyId/category/mediaId.ext
  bucket: string;
  contentType: string;
  sizeBytes?: number;
  uploadedAt: string;
}

export interface PresignedUrlOptions {
  mediaId: string;
  key: string;
  ttlSeconds?: number;    // Default: 300 (5 min). Max: 3600
  actorId?: string;       // For audit logging
}

// --- Provider config ---

type StorageProvider = 'S3' | 'R2' | 'GCS';

function buildS3Client(provider: StorageProvider): S3Client {
  const region = process.env.STORAGE_REGION ?? 'auto';
  const endpoint = provider === 'R2'
    ? `https://${process.env.CLOUDFLARE_ACCOUNT_ID}.r2.cloudflarestorage.com`
    : process.env.STORAGE_ENDPOINT; // Optional for custom S3-compatible endpoints

  return new S3Client({
    region,
    ...(endpoint ? { endpoint } : {}),
    credentials: {
      accessKeyId: process.env.STORAGE_ACCESS_KEY_ID ?? '',
      secretAccessKey: process.env.STORAGE_SECRET_ACCESS_KEY ?? '',
    },
    // Cloudflare R2 requires path-style addressing
    forcePathStyle: provider === 'R2',
  });
}

// --- Gateway ---

export class StorageGateway {
  private readonly client: S3Client;
  private readonly bucket: string;
  private readonly provider: StorageProvider;

  constructor() {
    this.provider = (process.env.STORAGE_PROVIDER ?? 'S3') as StorageProvider;
    this.bucket = process.env.STORAGE_BUCKET ?? 'reservatior-media';
    this.client = buildS3Client(this.provider);
  }

  /**
   * Builds the tenant-isolated object key.
   * Structure: {tenantId}/{propertyId}/{category}/{mediaId}.{ext}
   */
  private buildKey(
    tenantId: string,
    propertyId: string,
    category: MediaCategory,
    mediaId: string,
    filename: string,
  ): string {
    const ext = filename.includes('.') ? filename.split('.').pop() : 'bin';
    return `${tenantId}/${propertyId}/${category}/${mediaId}.${ext}`;
  }

  /**
   * Upload an object and return its ObjectRef.
   * The caller must never store the raw URL — only the mediaId.
   */
  async upload(opts: UploadOptions): Promise<ObjectRef> {
    const mediaId = randomUUID();
    const key = this.buildKey(opts.tenantId, opts.propertyId, opts.category, mediaId, opts.filename);

    const input: PutObjectCommandInput = {
      Bucket: this.bucket,
      Key: key,
      Body: opts.body as any,
      ContentType: opts.contentType,
      Metadata: {
        tenantId: opts.tenantId,
        propertyId: opts.propertyId,
        category: opts.category,
        mediaId,
        ...opts.metadata,
      },
      // Server-side encryption (AES-256)
      ...(opts.encrypt !== false ? { ServerSideEncryption: 'AES256' as const } : {}),
    };

    await this.client.send(new PutObjectCommand(input));

    const ref: ObjectRef = {
      mediaId,
      key,
      bucket: this.bucket,
      contentType: opts.contentType,
      uploadedAt: new Date().toISOString(),
    };

    // Emit Storage OS event
    eventBus.publish(
      StorageOSEvents.OBJECT_UPLOADED,
      { mediaId, key, tenantId: opts.tenantId, propertyId: opts.propertyId, category: opts.category },
      'StorageGateway',
    );

    console.log(`[StorageOS] Uploaded → ${key} (mediaId: ${mediaId})`);
    return ref;
  }

  /**
   * Issue a short-lived pre-signed GET URL for a given object key.
   * TTL default: 300s (5 minutes). Maximum enforced: 3600s (1 hour).
   */
  async getPresignedUrl(opts: PresignedUrlOptions): Promise<string> {
    const ttl = Math.min(opts.ttlSeconds ?? 300, 3600);

    const command = new GetObjectCommand({
      Bucket: this.bucket,
      Key: opts.key,
    });

    const url = await getSignedUrl(this.client, command, { expiresIn: ttl });

    // Emit audit event
    eventBus.publish(
      StorageOSEvents.PRESIGNED_URL_ISSUED,
      { mediaId: opts.mediaId, key: opts.key, ttl, actorId: opts.actorId },
      'StorageGateway',
    );

    return url;
  }

  /**
   * Delete a single object by its key.
   */
  async delete(key: string, mediaId: string): Promise<void> {
    await this.client.send(new DeleteObjectCommand({ Bucket: this.bucket, Key: key }));
    eventBus.publish(StorageOSEvents.OBJECT_DELETED, { key, mediaId }, 'StorageGateway');
    console.log(`[StorageOS] Deleted → ${key}`);
  }

  /**
   * List all objects under a tenant/property prefix.
   */
  async list(tenantId: string, propertyId: string, category?: MediaCategory): Promise<string[]> {
    const prefix = category
      ? `${tenantId}/${propertyId}/${category}/`
      : `${tenantId}/${propertyId}/`;

    const result = await this.client.send(
      new ListObjectsV2Command({ Bucket: this.bucket, Prefix: prefix }),
    );

    return (result.Contents ?? []).map(o => o.Key ?? '').filter(Boolean);
  }

  /**
   * Check if an object exists.
   */
  async exists(key: string): Promise<boolean> {
    try {
      await this.client.send(new HeadObjectCommand({ Bucket: this.bucket, Key: key }));
      return true;
    } catch {
      return false;
    }
  }
}

// Singleton — import this across OS modules
export const storageGateway = new StorageGateway();
