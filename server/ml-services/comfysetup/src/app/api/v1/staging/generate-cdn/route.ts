/**
 * Staging API with CDN Upload (Production Ready)
 * 
 * POST /api/v1/staging/generate-cdn
 * 
 * Full pipeline:
 * 1. Receive image from client
 * 2. Call RunPod A1111 for staging
 * 3. Convert to WebP and generate size variants
 * 4. Upload to Cloudflare R2 CDN
 * 5. Return CDN URLs (zero VM bandwidth used for image delivery)
 */

import { NextRequest, NextResponse } from 'next/server';
import { auth } from '@/lib/auth';
import { getA1111Client } from '@/lib/a1111';
import { imageProcessor } from '@/lib/image-processor';
import { r2Storage } from '@/lib/storage';
import { generateStagingPrompt } from '@/lib/prompt-engine';
// TODO: Uncomment when Prisma schema has credits field and Generation model
// import prisma from '@/lib/prisma';
import type { RoomType, InteriorStyle, ComputeMode } from '@/types';

interface StagingResult {
    success: boolean;
    images: {
        full: string;
        preview: string;
        thumbnail: string;
    };
    engine: string;
    processingTime: number;
    cost?: number;
}

export async function POST(request: NextRequest): Promise<NextResponse> {
    const startTime = Date.now();

    try {
        // === 1. AUTHENTICATION ===
        const session = await auth();
        if (!session?.user?.id) {
            return NextResponse.json(
                { error: 'Unauthorized' },
                { status: 401 }
            );
        }

        // === 2. PARSE REQUEST ===
        const body = await request.json();
        const {
            imageData,
            roomType,
            style,
            extras = [],
            computeMode = 'gpu',
            denoisingStrength = 0.55,
            watermarkEnabled = false,
        } = body as {
            imageData: string;
            roomType: RoomType;
            style: InteriorStyle;
            extras?: string[];
            computeMode?: ComputeMode;
            denoisingStrength?: number;
            watermarkEnabled?: boolean;
        };

        // Validate
        if (!imageData || !roomType || !style) {
            return NextResponse.json(
                { error: 'Missing required fields: imageData, roomType, style' },
                { status: 400 }
            );
        }

        // === 3. CHECK USER CREDITS ===
        // TODO: Uncomment when User model has 'credits' field
        // const user = await prisma.user.findUnique({
        //     where: { id: session.user.id },
        //     select: { credits: true },
        // });
        // 
        // if (!user || user.credits < 1) {
        //     return NextResponse.json(
        //         { error: 'Insufficient credits. Please purchase more credits.' },
        //         { status: 402 }
        //     );
        // }

        // === 4. GENERATE STAGED IMAGE ===
        const prompt = generateStagingPrompt(roomType, style, [], extras, computeMode);

        // Extract base64 from data URL
        let base64Image = imageData;
        if (imageData.includes(',')) {
            base64Image = imageData.split(',')[1];
        }

        let generatedImage: string | null = null;
        let engine = 'unknown';
        let aiCost = 0;

        // Try local A1111 first (free)
        const localA1111 = getA1111Client();
        const isLocalAvailable = await localA1111.testConnection();

        if (isLocalAvailable) {
            engine = 'local_a1111';

            const result = await localA1111.img2img({
                init_images: [base64Image],
                prompt: prompt.positive,
                negative_prompt: prompt.negative,
                denoising_strength: denoisingStrength,
                width: 1024,
                height: 1024,
                steps: computeMode === 'gpu' ? 30 : 20,
                cfg_scale: 7.5,
            });

            if (result.images && result.images.length > 0) {
                generatedImage = result.images[0];
            }
        } else {
            // Try RunPod A1111 (cloud)
            const runpodApiKey = process.env.RUNPOD_API_KEY;
            const runpodEndpoint = process.env.RUNPOD_A1111_ENDPOINT_ID;

            if (runpodApiKey && runpodEndpoint) {
                engine = 'runpod_a1111';

                // Make direct RunPod API call
                const runpodUrl = `https://api.runpod.ai/v2/${runpodEndpoint}/runsync`;

                const runpodPayload = {
                    input: {
                        api_name: 'img2img',
                        init_images: [base64Image],
                        prompt: prompt.positive,
                        negative_prompt: prompt.negative,
                        denoising_strength: denoisingStrength,
                        width: 1024,
                        height: 1024,
                        steps: 30,
                        cfg_scale: 7.5,
                        sampler_name: 'DPM++ 2M Karras',
                    },
                };

                const runpodResponse = await fetch(runpodUrl, {
                    method: 'POST',
                    headers: {
                        'Authorization': `Bearer ${runpodApiKey}`,
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify(runpodPayload),
                });

                if (runpodResponse.ok) {
                    const runpodData = await runpodResponse.json();

                    if (runpodData.status === 'COMPLETED' && runpodData.output?.images) {
                        generatedImage = runpodData.output.images[0];

                        // Calculate cost (~$0.00069/sec for RTX 4090)
                        const executionTime = runpodData.executionTime || 10000;
                        aiCost = (executionTime / 1000) * 0.00069;
                    }
                }
            }
        }

        if (!generatedImage) {
            return NextResponse.json(
                {
                    error: 'No AI engine available. Please configure local A1111 or RunPod.',
                    help: {
                        local: 'Start A1111: ./webui.sh --api',
                        cloud: 'Set RUNPOD_API_KEY and RUNPOD_A1111_ENDPOINT_ID in .env',
                    }
                },
                { status: 503 }
            );
        }

        // === 5. PROCESS IMAGE (WebP, Multiple Sizes) ===
        const imageBuffer = Buffer.from(generatedImage, 'base64');

        const variants = await imageProcessor.generateVariants(imageBuffer, {
            format: 'webp',
            watermark: watermarkEnabled,
        });

        // === 6. UPLOAD TO CDN ===
        let cdnUrls = {
            full: '',
            preview: '',
            thumbnail: '',
        };

        if (r2Storage.isConfigured()) {
            const uploadResults = await r2Storage.uploadImageVariants(
                {
                    thumbnail: variants.thumbnail.buffer,
                    preview: variants.preview.buffer,
                    full: variants.full.buffer,
                },
                {
                    folder: `staged/${roomType}`,
                    prefix: style,
                    format: 'webp',
                }
            );

            cdnUrls = {
                full: uploadResults.full.publicUrl,
                preview: uploadResults.preview.publicUrl,
                thumbnail: uploadResults.thumbnail.publicUrl,
            };
        } else {
            // Fallback: Return base64 data URLs (not ideal for production)
            cdnUrls = {
                full: `data:image/webp;base64,${variants.full.buffer.toString('base64')}`,
                preview: `data:image/webp;base64,${variants.preview.buffer.toString('base64')}`,
                thumbnail: `data:image/webp;base64,${variants.thumbnail.buffer.toString('base64')}`,
            };
        }

        // === 7. DEDUCT CREDIT & LOG ===
        // TODO: Uncomment when Prisma schema is updated with credits field and Generation model
        // await prisma.user.update({
        //     where: { id: session.user.id },
        //     data: {
        //         credits: { decrement: 1 },
        //     },
        // });

        // Log the generation
        // await prisma.generation.create({
        //     data: {
        //         userId: session.user.id,
        //         type: 'STAGING',
        //         roomType,
        //         style,
        //         engine,
        //         cost: aiCost,
        //         imageUrls: cdnUrls,
        //     },
        // });

        console.log(`Staging completed: ${engine}, cost: $${aiCost.toFixed(4)}`);

        // === 8. RETURN RESPONSE ===
        const processingTime = Date.now() - startTime;

        const result: StagingResult = {
            success: true,
            images: cdnUrls,
            engine,
            processingTime,
            cost: aiCost,
        };

        return NextResponse.json(result);

    } catch (error) {
        console.error('Staging error:', error);
        return NextResponse.json(
            { error: error instanceof Error ? error.message : 'Staging failed' },
            { status: 500 }
        );
    }
}

/**
 * GET /api/v1/staging/generate-cdn
 * 
 * Returns configuration info for the staging service
 */
export async function GET(): Promise<NextResponse> {
    const localA1111 = getA1111Client();
    const isLocalAvailable = await localA1111.testConnection();

    const hasRunPod = Boolean(
        process.env.RUNPOD_API_KEY &&
        process.env.RUNPOD_A1111_ENDPOINT_ID
    );

    const hasCDN = r2Storage.isConfigured();

    return NextResponse.json({
        status: 'operational',
        engines: {
            local_a1111: isLocalAvailable ? 'available' : 'offline',
            runpod_a1111: hasRunPod ? 'configured' : 'not_configured',
        },
        cdn: hasCDN ? 'cloudflare_r2' : 'not_configured',
        pricing: {
            creditsPerImage: 1,
            costPerCredit: 0.10,
        },
    });
}
