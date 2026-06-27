/**
 * Image Processor
 * 
 * Handles image optimization for web delivery:
 * - Convert to WebP/AVIF for smaller file sizes
 * - Generate multiple size variants (thumbnail, preview, full)
 * - Optimize quality for web
 * 
 * Uses sharp for high-performance image processing
 */

import sharp from 'sharp';

export interface ImageSize {
    width: number;
    height: number;
    quality: number;
    name: 'thumbnail' | 'preview' | 'full';
}

export interface ProcessedImage {
    buffer: Buffer;
    format: 'webp' | 'avif' | 'png' | 'jpg';
    width: number;
    height: number;
    size: number;
}

export interface ImageVariants {
    thumbnail: ProcessedImage;
    preview: ProcessedImage;
    full: ProcessedImage;
}

// Standard sizes for web delivery
const IMAGE_SIZES: ImageSize[] = [
    { name: 'thumbnail', width: 300, height: 200, quality: 70 },
    { name: 'preview', width: 800, height: 600, quality: 80 },
    { name: 'full', width: 1920, height: 1440, quality: 85 },
];

/**
 * Image Processor Class
 */
class ImageProcessor {
    /**
     * Convert base64 image to Buffer
     */
    base64ToBuffer(base64: string): Buffer {
        // Remove data URI prefix if present
        const base64Data = base64.includes(',')
            ? base64.split(',')[1]
            : base64;
        return Buffer.from(base64Data, 'base64');
    }

    /**
     * Convert Buffer to base64
     */
    bufferToBase64(buffer: Buffer, mimeType = 'image/webp'): string {
        return `data:${mimeType};base64,${buffer.toString('base64')}`;
    }

    /**
     * Process and optimize a single image
     */
    async processImage(
        input: Buffer | string,
        options: {
            width?: number;
            height?: number;
            quality?: number;
            format?: 'webp' | 'avif' | 'png' | 'jpg';
            fit?: 'cover' | 'contain' | 'fill' | 'inside' | 'outside';
            watermark?: boolean | { text: string };
        } = {}
    ): Promise<ProcessedImage> {
        const {
            width,
            height,
            quality = 80,
            format = 'webp',
            fit = 'inside',
            watermark = false,
        } = options;

        // Convert string (base64) to buffer if needed
        const inputBuffer = typeof input === 'string'
            ? this.base64ToBuffer(input)
            : input;

        let pipeline = sharp(inputBuffer);

        // Resize if dimensions specified
        if (width || height) {
            pipeline = pipeline.resize(width, height, {
                fit,
                withoutEnlargement: true,
            });
        }

        // Apply Watermark
        if (watermark) {
            const text = typeof watermark === 'object' ? watermark.text : 'Virtually Staged';

            // Get dimensions (needs metadata)
            const params = await pipeline.clone().toBuffer().then(b => sharp(b).metadata());
            const imgWidth = params.width || width || 1024;
            const imgHeight = params.height || height || 1024;

            const fontSize = Math.max(16, Math.floor(imgWidth * 0.03)); // 3% of width
            const padding = Math.floor(fontSize * 0.5);

            const svgImage = `
            <svg width="${imgWidth}" height="${imgHeight}">
              <style>
                .text { fill: rgba(255, 255, 255, 0.9); font-size: ${fontSize}px; font-family: Arial, sans-serif; font-weight: bold; text-shadow: 1px 1px 2px rgba(0,0,0,0.5); }
                .bg { fill: rgba(0, 0, 0, 0.5); }
              </style>
              <rect x="${imgWidth - (text.length * fontSize * 0.6) - padding * 2}" y="${imgHeight - fontSize - padding * 2}" width="${text.length * fontSize * 0.6 + padding * 2}" height="${fontSize + padding}" rx="4" class="bg" />
              <text x="${imgWidth - padding}" y="${imgHeight - padding}" text-anchor="end" class="text">${text}</text>
            </svg>
            `;

            pipeline = pipeline.composite([
                {
                    input: Buffer.from(svgImage),
                    top: 0,
                    left: 0,
                },
            ]);
        }

        // Convert to target format
        switch (format) {
            case 'webp':
                pipeline = pipeline.webp({ quality, effort: 4 });
                break;
            case 'avif':
                pipeline = pipeline.avif({ quality, effort: 4 });
                break;
            case 'png':
                pipeline = pipeline.png({ quality, compressionLevel: 8 });
                break;
            case 'jpg':
                pipeline = pipeline.jpeg({ quality, mozjpeg: true });
                break;
        }

        const buffer = await pipeline.toBuffer();
        const metadata = await sharp(buffer).metadata();

        return {
            buffer,
            format,
            width: metadata.width || 0,
            height: metadata.height || 0,
            size: buffer.length,
        };
    }

    /**
     * Generate all size variants for an image
     */
    async generateVariants(
        input: Buffer | string,
        options: {
            format?: 'webp' | 'avif';
            sizes?: ImageSize[];
            watermark?: boolean | { text: string };
        } = {}
    ): Promise<ImageVariants> {
        const { format = 'webp', sizes = IMAGE_SIZES, watermark } = options;

        const results = await Promise.all(
            sizes.map(async (size) => {
                const processed = await this.processImage(input, {
                    width: size.width,
                    height: size.height,
                    quality: size.quality,
                    format,
                    watermark,
                });
                return { name: size.name, processed };
            })
        );

        const variants: Record<string, ProcessedImage> = {};
        for (const result of results) {
            variants[result.name] = result.processed;
        }

        return variants as unknown as ImageVariants;
    }

    /**
     * Quick optimization for web delivery (single size)
     */
    async optimizeForWeb(
        input: Buffer | string,
        maxWidth = 1920
    ): Promise<ProcessedImage> {
        return this.processImage(input, {
            width: maxWidth,
            format: 'webp',
            quality: 85,
        });
    }

    /**
     * Create a thumbnail from an image
     */
    async createThumbnail(
        input: Buffer | string,
        size = 300
    ): Promise<ProcessedImage> {
        return this.processImage(input, {
            width: size,
            height: size,
            format: 'webp',
            quality: 70,
            fit: 'cover',
        });
    }

    /**
     * Get image metadata without processing
     */
    async getMetadata(input: Buffer | string): Promise<{
        width: number;
        height: number;
        format: string;
        size: number;
    }> {
        const inputBuffer = typeof input === 'string'
            ? this.base64ToBuffer(input)
            : input;

        const metadata = await sharp(inputBuffer).metadata();

        return {
            width: metadata.width || 0,
            height: metadata.height || 0,
            format: metadata.format || 'unknown',
            size: inputBuffer.length,
        };
    }

    /**
     * Validate image dimensions and format
     */
    async validate(
        input: Buffer | string,
        constraints: {
            minWidth?: number;
            minHeight?: number;
            maxWidth?: number;
            maxHeight?: number;
            maxSizeMB?: number;
            allowedFormats?: string[];
        } = {}
    ): Promise<{ valid: boolean; errors: string[] }> {
        const {
            minWidth = 100,
            minHeight = 100,
            maxWidth = 8000,
            maxHeight = 8000,
            maxSizeMB = 20,
            allowedFormats = ['jpeg', 'png', 'webp', 'avif', 'gif'],
        } = constraints;

        const errors: string[] = [];

        try {
            const metadata = await this.getMetadata(input);

            if (metadata.width < minWidth || metadata.height < minHeight) {
                errors.push(`Image too small. Minimum: ${minWidth}x${minHeight}px`);
            }

            if (metadata.width > maxWidth || metadata.height > maxHeight) {
                errors.push(`Image too large. Maximum: ${maxWidth}x${maxHeight}px`);
            }

            const sizeMB = metadata.size / (1024 * 1024);
            if (sizeMB > maxSizeMB) {
                errors.push(`File size too large. Maximum: ${maxSizeMB}MB`);
            }

            if (!allowedFormats.includes(metadata.format)) {
                errors.push(`Invalid format: ${metadata.format}. Allowed: ${allowedFormats.join(', ')}`);
            }
        } catch {
            errors.push('Invalid image file');
        }

        return {
            valid: errors.length === 0,
            errors,
        };
    }
}

// Export singleton instance
export const imageProcessor = new ImageProcessor();

// Export class for testing
export { ImageProcessor, IMAGE_SIZES };
