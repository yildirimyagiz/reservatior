import { NextRequest, NextResponse } from 'next/server';
import { auth } from '@/lib/auth';
import { getComfyUIClient, buildStagingWorkflow, getWorkflowSettings } from '@/lib/comfyui';
import { generateStagingPrompt, generateToolPrompt } from '@/lib/prompt-engine';
import type { RoomType, InteriorStyle, ComputeMode } from '@/types';

/**
 * Simple Staging API (Optimized for CPU/Direct ComfyUI)
 * 
 * POST /api/v1/staging/generate-simple
 */
export async function POST(request: NextRequest) {
    try {
        // 1. AUTHENTICATION
        const session = await auth();
        if (!session?.user?.id) {
            return NextResponse.json(
                { error: 'Unauthorized' },
                { status: 401 }
            );
        }

        // 2. PARSE REQUEST
        const body = await request.json();
        const {
            imageData,
            roomType,
            style,
            computeMode = 'cpu',
            activeTool
        } = body as {
            imageData: string;
            roomType: RoomType;
            style: InteriorStyle;
            computeMode?: ComputeMode;
            activeTool?: string;
        };

        if (!imageData || !roomType || !style) {
            return NextResponse.json(
                { error: 'Missing required fields: imageData, roomType, style' },
                { status: 400 }
            );
        }

        // 3. COMFYUI CONNECTION
        const client = getComfyUIClient();
        const connected = await client.testConnection();

        if (!connected) {
            return NextResponse.json(
                {
                    error: 'ComfyUI server is not available.',
                    help: 'Make sure ComfyUI is running locally or via the configured API URL.'
                },
                { status: 503 }
            );
        }

        // 4. UPLOAD IMAGE
        const fileName = `simple_staging_${Date.now()}.png`;
        const uploadResult = await client.uploadImage(imageData, fileName);

        // 5. GENERATE PROMPT & WORKFLOW
        // Determine if we should use tool-specific prompt or standard staging prompt
        let prompt;
        if (activeTool && activeTool !== 'furniture') {
            console.log(`Generating prompt for tool: ${activeTool}`);
            prompt = generateToolPrompt(activeTool, computeMode);
        } else {
            prompt = generateStagingPrompt(roomType, style, [], [], computeMode);
        }

        const settings = getWorkflowSettings(computeMode);

        const workflow = buildStagingWorkflow({
            imageName: uploadResult.name,
            positivePrompt: prompt.positive,
            negativePrompt: prompt.negative,
            steps: settings.steps,
            cfg: settings.cfg,
            denoise: settings.denoise,
            width: settings.width,
            height: settings.height,
        });

        // 6. EXECUTE & WAIT
        console.log(`Starting simple staging on ${computeMode}...`);
        const { prompt_id } = await client.queuePrompt(workflow);

        // Wait for completion (timeout 5 mins)
        const outputImages = await client.waitForCompletion(prompt_id);

        if (outputImages.length === 0) {
            throw new Error('ComfyUI finished but returned no images.');
        }

        // 7. GET BASE64 RESULT
        const resultBase64 = await client.getImageAsBase64(outputImages[0]);

        return NextResponse.json({
            success: true,
            imageData: resultBase64,
            prompt: prompt.positive,
            mode: computeMode,
        });

    } catch (error) {
        console.error('Simple staging error:', error);
        return NextResponse.json(
            { error: error instanceof Error ? error.message : 'Staging failed' },
            { status: 500 }
        );
    }
}
