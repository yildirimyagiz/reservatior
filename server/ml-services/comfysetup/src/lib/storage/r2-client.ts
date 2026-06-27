/**
 * Cloudflare R2 Storage Client
 * 
 * Uses S3-compatible API for object storage with built-in CDN.
 * Free tier: 10GB storage, 10M reads/mo, 1M writes/mo
 * 
 * Benefits:
 * - Zero egress fees from GCP VM
 * - Built-in CDN for image delivery
 * - S3-compatible API
 */

import { S3Client, PutObjectCommand, DeleteObjectCommand, HeadObjectCommand } from '@aws-sdk/client-s3';
import { getSignedUrl } from '@aws-sdk/s3-request-presigner';

// Environment variables
const R2_ACCOUNT_ID = process.env.R2_ACCOUNT_ID || '';
const R2_ACCESS_KEY_ID = process.env.R2_ACCESS_KEY_ID || '';
const R2_SECRET_ACCESS_KEY = process.env.R2_SECRET_ACCESS_KEY || '';
const R2_BUCKET_NAME = process.env.R2_BUCKET_NAME || 'atlasvs-images';
const R2_PUBLIC_URL = process.env.R2_PUBLIC_URL || '';

// R2 endpoint follows format: https://<account_id>.r2.cloudflarestorage.com
const R2_ENDPOINT = `https://${R2_ACCOUNT_ID}.r2.cloudflarestorage.com`;

export interface UploadOptions {
    folder?: string;
    contentType?: string;
    cacheControl?: string;
    metadata?: Record<string, string>;
}

export interface UploadResult {
    key: string;
    url: string;
    publicUrl: string;
    size: number;
}

export interface ImageVariants {
    thumbnail: UploadResult;
    preview: UploadResult;
    full: UploadResult;
}

/**
 * Cloudflare R2 Storage Client
 */
class R2StorageClient {
    private client: S3Client;
    private bucket: string;
    private publicUrl: string;

    constructor() {
        this.bucket = R2_BUCKET_NAME;
        this.publicUrl = R2_PUBLIC_URL;
        
        this.client = new S3Client({
            region: 'auto', // R2 uses 'auto' for region
            endpoint: R2_ENDPOINT,
            credentials: {
                accessKeyId: R2_ACCESS_KEY_ID,
                secretAccessKey: R2_SECRET_ACCESS_KEY,
            },
        });
    }

    /**
     * Check if R2 is configured
     */
    isConfigured(): boolean {
        return Boolean(R2_ACCOUNT_ID && R2_ACCESS_KEY_ID && R2_SECRET_ACCESS_KEY);
    }

    /**
     * Upload a file to R2
     */
    async upload(
        key: string,
        data: Buffer | Uint8Array | string,
        options: UploadOptions = {}
    ): Promise<UploadResult> {
        const { 
            contentType = 'application/octet-stream',
            cacheControl = 'public, max-age=31536000', // 1 year cache
            metadata = {}
        } = options;

        const command = new PutObjectCommand({
            Bucket: this.bucket,
            Key: key,
            Body: data,
            ContentType: contentType,
            CacheControl: cacheControl,
            Metadata: metadata,
        });

        await this.client.send(command);

        const size = typeof data === 'string' ? Buffer.byteLength(data) : data.length;

        return {
            key,
            url: `${R2_ENDPOINT}/${this.bucket}/${key}`,
            publicUrl: this.getPublicUrl(key),
            size,
        };
    }

    /**
     * Upload an image with auto-generated key based on type and timestamp
     */
    async uploadImage(
        imageBuffer: Buffer,
        options: {
            folder?: string;
            prefix?: string;
            format?: 'webp' | 'avif' | 'png' | 'jpg';
            size?: 'thumbnail' | 'preview' | 'full';
        } = {}
    ): Promise<UploadResult> {
        const {
            folder = 'staged',
            prefix = 'img',
            format = 'webp',
            size = 'full'
        } = options;

        const timestamp = Date.now();
        const randomId = Math.random().toString(36).substring(2, 8);
        const key = `${folder}/${size}/${prefix}_${timestamp}_${randomId}.${format}`;

        const contentTypes: Record<string, string> = {
            webp: 'image/webp',
            avif: 'image/avif',
            png: 'image/png',
            jpg: 'image/jpeg',
        };

        return this.upload(key, imageBuffer, {
            contentType: contentTypes[format] || 'image/webp',
            cacheControl: 'public, max-age=31536000, immutable',
            metadata: {
                'x-generated-at': new Date().toISOString(),
                'x-size-variant': size,
            },
        });
    }

    /**
     * Upload multiple size variants of an image
     */
    async uploadImageVariants(
        variants: {
            thumbnail: Buffer;
            preview: Buffer;
            full: Buffer;
        },
        options: {
            folder?: string;
            prefix?: string;
            format?: 'webp' | 'avif';
        } = {}
    ): Promise<ImageVariants> {
        const [thumbnail, preview, full] = await Promise.all([
            this.uploadImage(variants.thumbnail, { ...options, size: 'thumbnail' }),
            this.uploadImage(variants.preview, { ...options, size: 'preview' }),
            this.uploadImage(variants.full, { ...options, size: 'full' }),
        ]);

        return { thumbnail, preview, full };
    }

    /**
     * Delete a file from R2
     */
    async delete(key: string): Promise<void> {
        const command = new DeleteObjectCommand({
            Bucket: this.bucket,
            Key: key,
        });

        await this.client.send(command);
    }

    /**
     * Check if a file exists
     */
    async exists(key: string): Promise<boolean> {
        try {
            const command = new HeadObjectCommand({
                Bucket: this.bucket,
                Key: key,
            });
            await this.client.send(command);
            return true;
        } catch {
            return false;
        }
    }

    /**
     * Get a pre-signed URL for uploading (useful for direct client uploads)
     */
    async getUploadUrl(key: string, expiresIn = 3600): Promise<string> {
        const command = new PutObjectCommand({
            Bucket: this.bucket,
            Key: key,
        });

        return getSignedUrl(this.client, command, { expiresIn });
    }

    /**
     * Get the public CDN URL for a key
     */
    getPublicUrl(key: string): string {
        if (this.publicUrl) {
            return `${this.publicUrl}/${key}`;
        }
        // Fallback to direct R2 URL (requires public bucket)
        return `${R2_ENDPOINT}/${this.bucket}/${key}`;
    }

    /**
     * Generate a unique key for staging images
     */
    generateStagingKey(
        roomType: string,
        style: string,
        format = 'webp'
    ): string {
        const timestamp = Date.now();
        const randomId = Math.random().toString(36).substring(2, 8);
        return `staged/${roomType}/${style}_${timestamp}_${randomId}.${format}`;
    }
}

// Export singleton instance
export const r2Storage = new R2StorageClient();

// Export class for testing
export { R2StorageClient };
