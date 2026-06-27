import { NextRequest, NextResponse } from 'next/server';
import { getComfyUIClient } from '@/lib/comfyui';

export async function GET(request: NextRequest) {
    try {
        const comfyuiUrl = request.nextUrl.searchParams.get('url');
        const client = getComfyUIClient(comfyuiUrl ? { baseUrl: comfyuiUrl } : undefined);

        const connected = await client.testConnection();

        if (!connected) {
            return NextResponse.json({
                connected: false,
                checkpoints: [],
                controlnets: [],
            });
        }

        // Fetch available models
        const [checkpoints, controlnets] = await Promise.all([
            client.getCheckpoints(),
            client.getControlNetModels(),
        ]);

        return NextResponse.json({
            connected: true,
            checkpoints,
            controlnets,
        });
    } catch (error) {
        console.error('Connection test error:', error);
        return NextResponse.json({
            connected: false,
            checkpoints: [],
            controlnets: [],
            error: error instanceof Error ? error.message : 'Connection failed',
        });
    }
}
