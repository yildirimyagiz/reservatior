/**
 * Automatic1111 Stable Diffusion WebUI API Client
 * 
 * A free, local alternative to ComfyUI for virtual staging.
 * Connects to http://127.0.0.1:7860/sdapi/v1/
 * 
 * Start A1111 with: ./webui.sh --api
 */

const DEFAULT_A1111_URL = 'http://127.0.0.1:7860';

export interface A1111Config {
    baseUrl: string;
}

export interface Txt2ImgRequest {
    prompt: string;
    negative_prompt?: string;
    width?: number;
    height?: number;
    steps?: number;
    cfg_scale?: number;
    sampler_name?: string;
    seed?: number;
    batch_size?: number;
}

export interface Img2ImgRequest extends Txt2ImgRequest {
    init_images: string[];  // Base64 encoded images
    denoising_strength?: number;
    resize_mode?: number;
}

export interface GenerationResponse {
    images: string[];  // Base64 encoded
    parameters: Record<string, unknown>;
    info: string;
}

export interface HealthStatus {
    status: 'healthy' | 'offline' | 'error';
    model?: string;
    modelsAvailable?: number;
    error?: string;
}

export interface StagingOptions {
    roomType: 'living_room' | 'bedroom' | 'kitchen' | 'bathroom' | 'dining_room' | 'office';
    style: 'modern' | 'luxury' | 'minimalist' | 'scandinavian' | 'traditional' | 'industrial' | 'coastal' | 'bohemian';
    denoisingStrength?: number;
    preserveStructure?: boolean;
}

/**
 * A1111 API Client for Stable Diffusion WebUI
 */
export class A1111Client {
    private baseUrl: string;

    constructor(config?: A1111Config) {
        this.baseUrl = config?.baseUrl || DEFAULT_A1111_URL;
    }

    /**
     * Test connection to A1111 server
     */
    async testConnection(): Promise<boolean> {
        try {
            const response = await fetch(`${this.baseUrl}/sdapi/v1/sd-models`, {
                method: 'GET',
            });
            return response.ok;
        } catch {
            return false;
        }
    }

    /**
     * Get health status and system info
     */
    async getHealth(): Promise<HealthStatus> {
        try {
            const modelsRes = await fetch(`${this.baseUrl}/sdapi/v1/sd-models`);
            if (!modelsRes.ok) {
                return { status: 'error', error: `HTTP ${modelsRes.status}` };
            }
            const models = await modelsRes.json();

            const optionsRes = await fetch(`${this.baseUrl}/sdapi/v1/options`);
            const options = optionsRes.ok ? await optionsRes.json() : {};

            return {
                status: 'healthy',
                model: options.sd_model_checkpoint || 'unknown',
                modelsAvailable: models.length,
            };
        } catch {
            return {
                status: 'offline',
                error: 'Cannot connect to A1111. Is it running with --api flag?',
            };
        }
    }

    /**
     * Get available checkpoint models
     */
    async getModels(): Promise<string[]> {
        try {
            const response = await fetch(`${this.baseUrl}/sdapi/v1/sd-models`);
            if (response.ok) {
                const models = await response.json();
                return models.map((m: { title?: string; model_name?: string }) => 
                    m.title || m.model_name || ''
                );
            }
            return [];
        } catch {
            return [];
        }
    }

    /**
     * Get available samplers
     */
    async getSamplers(): Promise<string[]> {
        try {
            const response = await fetch(`${this.baseUrl}/sdapi/v1/samplers`);
            if (response.ok) {
                const samplers = await response.json();
                return samplers.map((s: { name?: string }) => s.name || '');
            }
            return [];
        } catch {
            return [];
        }
    }

    /**
     * Generate images from text prompt
     */
    async txt2img(request: Txt2ImgRequest): Promise<GenerationResponse> {
        const payload = {
            prompt: request.prompt,
            negative_prompt: request.negative_prompt || 'low quality, blurry, distorted',
            width: request.width || 1024,
            height: request.height || 1024,
            steps: request.steps || 25,
            cfg_scale: request.cfg_scale || 7.0,
            sampler_name: request.sampler_name || 'DPM++ 2M Karras',
            seed: request.seed ?? -1,
            batch_size: request.batch_size || 1,
        };

        const response = await fetch(`${this.baseUrl}/sdapi/v1/txt2img`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(payload),
        });

        if (!response.ok) {
            const error = await response.text();
            throw new Error(`txt2img failed: ${error}`);
        }

        return response.json();
    }

    /**
     * Transform an existing image (img2img)
     * This is the PRIMARY method for virtual staging
     */
    async img2img(request: Img2ImgRequest): Promise<GenerationResponse> {
        const payload = {
            init_images: request.init_images,
            prompt: request.prompt,
            negative_prompt: request.negative_prompt || 'empty room, unfurnished, low quality, blurry',
            denoising_strength: request.denoising_strength || 0.55,
            width: request.width || 1024,
            height: request.height || 1024,
            steps: request.steps || 25,
            cfg_scale: request.cfg_scale || 7.0,
            sampler_name: request.sampler_name || 'DPM++ 2M Karras',
            seed: request.seed ?? -1,
            batch_size: request.batch_size || 1,
            resize_mode: request.resize_mode || 1,
        };

        const response = await fetch(`${this.baseUrl}/sdapi/v1/img2img`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(payload),
        });

        if (!response.ok) {
            const error = await response.text();
            throw new Error(`img2img failed: ${error}`);
        }

        return response.json();
    }

    /**
     * High-level staging method optimized for real estate
     */
    async stageRoom(
        imageBase64: string,
        options: StagingOptions
    ): Promise<GenerationResponse> {
        const prompt = this.buildStagingPrompt(options.roomType, options.style);
        const negativePrompt = this.buildStagingNegativePrompt();

        // Adjust strength for structure preservation
        let denoisingStrength = options.denoisingStrength || 0.55;
        if (options.preserveStructure) {
            denoisingStrength = Math.min(denoisingStrength, 0.55);
        }

        return this.img2img({
            init_images: [imageBase64],
            prompt,
            negative_prompt: negativePrompt,
            denoising_strength: denoisingStrength,
            steps: 30,
            cfg_scale: 7.5,
        });
    }

    /**
     * Convert image file to base64
     */
    async imageToBase64(file: File): Promise<string> {
        return new Promise((resolve, reject) => {
            const reader = new FileReader();
            reader.onload = () => {
                const result = reader.result as string;
                // Remove data URI prefix if present
                const base64 = result.includes(',') ? result.split(',')[1] : result;
                resolve(base64);
            };
            reader.onerror = reject;
            reader.readAsDataURL(file);
        });
    }

    /**
     * Convert base64 to data URL for display
     */
    base64ToDataUrl(base64: string, mimeType = 'image/png'): string {
        return `data:${mimeType};base64,${base64}`;
    }

    // === Private Methods ===

    private buildStagingPrompt(roomType: string, style: string): string {
        const styleDetails: Record<string, string> = {
            modern: 'sleek contemporary furniture, clean lines, neutral colors, minimalist design',
            luxury: 'high-end designer furniture, premium materials, elegant decor, sophisticated',
            minimalist: 'minimal furniture, clean aesthetic, simple design, uncluttered space',
            scandinavian: 'nordic design, light wood furniture, cozy textiles, hygge atmosphere',
            traditional: 'classic furniture, warm wood tones, traditional decor, timeless elegance',
            industrial: 'industrial style, exposed elements, metal and wood, urban loft aesthetic',
            coastal: 'beach house style, light colors, natural textures, relaxed coastal vibe',
            bohemian: 'eclectic boho style, colorful textiles, plants, artistic decor',
        };

        const roomDetails: Record<string, string> = {
            living_room: 'living room with comfortable sofa, coffee table, stylish lighting, area rug',
            bedroom: 'bedroom with elegant bed, nightstands, soft bedding, ambient lighting',
            kitchen: 'kitchen with modern appliances, organized countertops, stylish fixtures',
            bathroom: 'bathroom with clean fixtures, organized vanity, fresh towels',
            dining_room: 'dining room with dining table, chairs, centerpiece, ambient lighting',
            office: 'home office with desk, ergonomic chair, organized workspace, good lighting',
        };

        const styleDesc = styleDetails[style] || styleDetails.modern;
        const roomDesc = roomDetails[roomType] || roomDetails.living_room;

        return `professional real estate photography, ${roomDesc}, ${styleDesc}, ` +
               `interior design magazine quality, perfectly staged, warm inviting atmosphere, ` +
               `natural lighting, high resolution, 8k quality, photorealistic`;
    }

    private buildStagingNegativePrompt(): string {
        return 'empty room, unfurnished, construction, renovation, messy, cluttered, ' +
               'low quality, blurry, distorted, ugly, deformed, cartoon, illustration, ' +
               'painting, drawing, watermark, text, logo, people, animals, outdoors';
    }
}

// === Singleton Instance ===

let clientInstance: A1111Client | null = null;

export function getA1111Client(config?: A1111Config): A1111Client {
    if (!clientInstance || config) {
        clientInstance = new A1111Client(config);
    }
    return clientInstance;
}

export default A1111Client;
