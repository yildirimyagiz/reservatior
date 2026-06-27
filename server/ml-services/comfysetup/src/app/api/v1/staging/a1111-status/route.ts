import { NextRequest, NextResponse } from 'next/server';

const DEFAULT_A1111_URL = 'http://127.0.0.1:7860';

export async function GET(request: NextRequest) {
    const url = request.nextUrl.searchParams.get('url') || DEFAULT_A1111_URL;
    
    try {
        // Test connection and get system info
        const [modelsRes, samplersRes, optionsRes] = await Promise.all([
            fetch(`${url}/sdapi/v1/sd-models`, { 
                signal: AbortSignal.timeout(5000) 
            }),
            fetch(`${url}/sdapi/v1/samplers`, { 
                signal: AbortSignal.timeout(5000) 
            }),
            fetch(`${url}/sdapi/v1/options`, { 
                signal: AbortSignal.timeout(5000) 
            }),
        ]);

        if (!modelsRes.ok) {
            return NextResponse.json({
                status: 'error',
                error: 'Failed to connect to A1111',
            });
        }

        const models = await modelsRes.json();
        const samplers = samplersRes.ok ? await samplersRes.json() : [];
        const options = optionsRes.ok ? await optionsRes.json() : {};

        return NextResponse.json({
            status: 'healthy',
            models: models.map((m: { title?: string; model_name?: string }) => 
                m.title || m.model_name || ''
            ),
            samplers: samplers.map((s: { name?: string }) => s.name || ''),
            currentModel: options.sd_model_checkpoint || 'unknown',
            modelsAvailable: models.length,
            url,
        });
    } catch (error) {
        console.error('A1111 status check failed:', error);
        return NextResponse.json({
            status: 'offline',
            error: 'Cannot connect to A1111. Is it running with --api flag?',
            help: 'Start A1111 with: ./webui.sh --api',
        });
    }
}
