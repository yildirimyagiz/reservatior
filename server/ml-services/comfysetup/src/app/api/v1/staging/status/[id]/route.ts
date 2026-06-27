import { NextRequest, NextResponse } from 'next/server';
import { getComfyUIClient } from '@/lib/comfyui';

export async function GET(
    request: NextRequest,
    { params }: { params: Promise<{ id: string }> }
) {
    try {
        const { id: promptId } = await params;

        if (!promptId) {
            return NextResponse.json(
                { error: 'Missing prompt ID' },
                { status: 400 }
            );
        }

        // Get ComfyUI URL from query params if provided
        const comfyuiUrl = request.nextUrl.searchParams.get('comfyuiUrl');
        const client = getComfyUIClient(comfyuiUrl ? { baseUrl: comfyuiUrl } : undefined);

        // Check completion status
        const result = await client.isComplete(promptId);

        if (result.complete && result.images.length > 0) {
            // Convert first image to base64 for easier handling
            try {
                const imageBase64 = await client.getImageAsBase64(result.images[0]);
                return NextResponse.json({
                    status: 'complete',
                    images: result.images,
                    imageBase64,
                });
            } catch {
                // If base64 conversion fails, return URLs only
                return NextResponse.json({
                    status: 'complete',
                    images: result.images,
                });
            }
        }

        return NextResponse.json({
            status: 'processing',
            images: [],
        });
    } catch (error) {
        console.error('Status check error:', error);
        return NextResponse.json(
            { error: error instanceof Error ? error.message : 'Status check failed' },
            { status: 500 }
        );
    }
}
