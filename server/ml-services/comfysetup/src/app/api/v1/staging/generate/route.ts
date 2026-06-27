import { NextRequest, NextResponse } from 'next/server';
import { getA1111Client } from '@/lib/a1111';
import { getComfyUIClient, buildStagingWorkflow, getWorkflowSettings } from '@/lib/comfyui';
import { generateStagingPrompt } from '@/lib/prompt-engine';
import type { RoomType, InteriorStyle, ComputeMode } from '@/types';

const A1111_URL = process.env.A1111_URL || 'http://127.0.0.1:7860';

type AIEngine = 'a1111' | 'comfyui' | 'auto';

export async function POST(request: NextRequest) {
    try {
        const body = await request.json();
        const {
            imageData,
            imageName,
            roomType,
            style,
            extras,
            computeMode,
            engine = 'auto',
            // A1111 specific
            denoisingStrength = 0.55,
            // ComfyUI specific
            comfyuiUrl,
            checkpoint,
            controlnetModel,
        } = body as {
            imageData: string;
            imageName: string;
            roomType: RoomType;
            style: InteriorStyle;
            extras: string[];
            computeMode: ComputeMode;
            engine?: AIEngine;
            denoisingStrength?: number;
            comfyuiUrl?: string;
            checkpoint?: string;
            controlnetModel?: string;
        };

        // Validate required fields
        if (!imageData || !roomType || !style) {
            return NextResponse.json(
                { error: 'Missing required fields' },
                { status: 400 }
            );
        }

        // Determine which engine to use
        let selectedEngine: 'a1111' | 'comfyui' = 'a1111';
        
        if (engine === 'auto') {
            // Try A1111 first (free, local)
            const a1111Client = getA1111Client({ baseUrl: A1111_URL });
            const isA1111Available = await a1111Client.testConnection();
            
            if (isA1111Available) {
                selectedEngine = 'a1111';
            } else {
                // Fall back to ComfyUI
                const comfyClient = getComfyUIClient(comfyuiUrl ? { baseUrl: comfyuiUrl } : undefined);
                const isComfyAvailable = await comfyClient.testConnection();
                
                if (isComfyAvailable) {
                    selectedEngine = 'comfyui';
                } else {
                    return NextResponse.json(
                        { 
                            error: 'No AI engine available. Please start A1111 (./webui.sh --api) or ComfyUI.',
                            help: {
                                a1111: 'cd stable-diffusion-webui && ./webui.sh --api',
                                comfyui: 'cd ComfyUI && python main.py',
                            }
                        },
                        { status: 503 }
                    );
                }
            }
        } else {
            selectedEngine = engine === 'comfyui' ? 'comfyui' : 'a1111';
        }

        // Generate with selected engine
        if (selectedEngine === 'a1111') {
            return await generateWithA1111({
                imageData,
                roomType,
                style,
                extras,
                computeMode,
                denoisingStrength,
            });
        } else {
            return await generateWithComfyUI({
                imageData,
                imageName,
                roomType,
                style,
                extras,
                computeMode,
                comfyuiUrl,
                checkpoint,
                controlnetModel,
            });
        }
    } catch (error) {
        console.error('Generation error:', error);
        return NextResponse.json(
            { error: error instanceof Error ? error.message : 'Generation failed' },
            { status: 500 }
        );
    }
}

// === A1111 Generation (Primary, Free) ===
async function generateWithA1111(params: {
    imageData: string;
    roomType: RoomType;
    style: InteriorStyle;
    extras: string[];
    computeMode: ComputeMode;
    denoisingStrength: number;
}) {
    const { imageData, roomType, style, extras, computeMode, denoisingStrength } = params;
    
    const client = getA1111Client({ baseUrl: A1111_URL });
    
    // Test connection
    const connected = await client.testConnection();
    if (!connected) {
        return NextResponse.json(
            { 
                error: 'Cannot connect to A1111. Start with: ./webui.sh --api',
                engine: 'a1111'
            },
            { status: 503 }
        );
    }

    // Generate prompt
    const prompt = generateStagingPrompt(roomType, style, [], extras, computeMode);

    // Extract base64 from data URL if needed
    let base64Image = imageData;
    if (imageData.includes(',')) {
        base64Image = imageData.split(',')[1];
    }

    try {
        // Run img2img staging
        // GPU mode = higher quality (more steps)
        const steps = computeMode === 'gpu' ? 30 : 20;
        
        const result = await client.img2img({
            init_images: [base64Image],
            prompt: prompt.positive,
            negative_prompt: prompt.negative,
            denoising_strength: denoisingStrength,
            width: 1024,
            height: 1024,
            steps,
            cfg_scale: 7.5,
            sampler_name: 'DPM++ 2M Karras',
        });

        if (result.images && result.images.length > 0) {
            return NextResponse.json({
                success: true,
                engine: 'a1111',
                images: result.images.map(img => `data:image/png;base64,${img}`),
                prompt: prompt,
            });
        } else {
            throw new Error('No images generated');
        }
    } catch (error) {
        console.error('A1111 generation error:', error);
        return NextResponse.json(
            { error: error instanceof Error ? error.message : 'A1111 generation failed' },
            { status: 500 }
        );
    }
}

// === ComfyUI Generation (Legacy/Alternative) ===
async function generateWithComfyUI(params: {
    imageData: string;
    imageName: string;
    roomType: RoomType;
    style: InteriorStyle;
    extras: string[];
    computeMode: ComputeMode;
    comfyuiUrl?: string;
    checkpoint?: string;
    controlnetModel?: string;
}) {
    const {
        imageData,
        imageName,
        roomType,
        style,
        extras,
        computeMode,
        comfyuiUrl,
        checkpoint,
        controlnetModel,
    } = params;

    // Get ComfyUI client
    const client = getComfyUIClient(comfyuiUrl ? { baseUrl: comfyuiUrl } : undefined);

    // Test connection
    const connected = await client.testConnection();
    if (!connected) {
        return NextResponse.json(
            { 
                error: 'Cannot connect to ComfyUI server',
                engine: 'comfyui'
            },
            { status: 503 }
        );
    }

    // Generate prompt using our prompt engine
    const prompt = generateStagingPrompt(roomType, style, [], extras, computeMode);

    // Upload image to ComfyUI
    const uploadedImage = await client.uploadImage(
        imageData,
        imageName || `room_${Date.now()}.png`
    );

    // Get workflow settings based on compute mode
    const settings = getWorkflowSettings(computeMode);

    // Build the workflow
    const workflow = buildStagingWorkflow({
        imageName: uploadedImage.name,
        positivePrompt: prompt.positive,
        negativePrompt: prompt.negative,
        checkpoint,
        controlnetModel,
        ...settings,
    });

    // Queue the workflow
    const queueResult = await client.queuePrompt(workflow);

    return NextResponse.json({
        promptId: queueResult.prompt_id,
        message: 'Generation started',
        engine: 'comfyui',
        prompt: prompt,
    });
}
