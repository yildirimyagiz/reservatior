/**
 * ComfyUI API Client
 * Connects to local ComfyUI server for image generation
 */

const DEFAULT_COMFYUI_URL = process.env.NEXT_PUBLIC_COMFY_API_URL || 'http://127.0.0.1:8188';

export interface ComfyUIConfig {
    baseUrl: string;
}

export interface QueuePromptResponse {
    prompt_id: string;
}

export interface HistoryResponse {
    [promptId: string]: {
        outputs: {
            [nodeId: string]: {
                images?: Array<{
                    filename: string;
                    subfolder: string;
                    type: string;
                }>;
            };
        };
        status: {
            completed: boolean;
            status_str: string;
        };
    };
}

export class ComfyUIClient {
    private baseUrl: string;

    constructor(config?: ComfyUIConfig) {
        this.baseUrl = config?.baseUrl || DEFAULT_COMFYUI_URL;
    }

    /**
     * Test connection to ComfyUI server
     */
    async testConnection(): Promise<boolean> {
        try {
            const response = await fetch(`${this.baseUrl}/system_stats`, {
                method: 'GET',
            });
            return response.ok;
        } catch {
            return false;
        }
    }

    /**
     * Get available models (checkpoints)
     */
    async getCheckpoints(): Promise<string[]> {
        try {
            const response = await fetch(`${this.baseUrl}/object_info/CheckpointLoaderSimple`);
            const data = await response.json();
            return data.CheckpointLoaderSimple?.input?.required?.ckpt_name?.[0] || [];
        } catch {
            return [];
        }
    }

    /**
     * Get available ControlNet models
     */
    async getControlNetModels(): Promise<string[]> {
        try {
            const response = await fetch(`${this.baseUrl}/object_info/ControlNetLoader`);
            const data = await response.json();
            return data.ControlNetLoader?.input?.required?.control_net_name?.[0] || [];
        } catch {
            return [];
        }
    }

    /**
     * Upload an image to ComfyUI
     */
    async uploadImage(imageData: string, filename: string): Promise<{ name: string; subfolder: string }> {
        // Convert base64 to blob
        const base64Data = imageData.split(',')[1];
        const byteCharacters = atob(base64Data);
        const byteNumbers = new Array(byteCharacters.length);
        for (let i = 0; i < byteCharacters.length; i++) {
            byteNumbers[i] = byteCharacters.charCodeAt(i);
        }
        const byteArray = new Uint8Array(byteNumbers);
        const blob = new Blob([byteArray], { type: 'image/png' });

        const formData = new FormData();
        formData.append('image', blob, filename);
        formData.append('overwrite', 'true');

        const response = await fetch(`${this.baseUrl}/upload/image`, {
            method: 'POST',
            body: formData,
        });

        if (!response.ok) {
            throw new Error('Failed to upload image to ComfyUI');
        }

        const result = await response.json();
        return {
            name: result.name,
            subfolder: result.subfolder || '',
        };
    }

    /**
     * Queue a workflow for execution
     */
    async queuePrompt(workflow: object): Promise<QueuePromptResponse> {
        const response = await fetch(`${this.baseUrl}/prompt`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ prompt: workflow }),
        });

        if (!response.ok) {
            const error = await response.text();
            throw new Error(`Failed to queue prompt: ${error}`);
        }

        return response.json();
    }

    /**
     * Get the history/status of a prompt
     */
    async getHistory(promptId: string): Promise<HistoryResponse> {
        const response = await fetch(`${this.baseUrl}/history/${promptId}`);

        if (!response.ok) {
            throw new Error('Failed to get history');
        }

        return response.json();
    }

    /**
     * Check if a prompt is complete
     */
    async isComplete(promptId: string): Promise<{ complete: boolean; images: string[] }> {
        const history = await this.getHistory(promptId);
        const promptHistory = history[promptId];

        if (!promptHistory) {
            return { complete: false, images: [] };
        }

        const images: string[] = [];

        // Look for images in outputs
        for (const nodeId in promptHistory.outputs) {
            const output = promptHistory.outputs[nodeId];
            if (output.images) {
                for (const img of output.images) {
                    const imageUrl = `${this.baseUrl}/view?filename=${encodeURIComponent(img.filename)}&subfolder=${encodeURIComponent(img.subfolder)}&type=${encodeURIComponent(img.type)}`;
                    images.push(imageUrl);
                }
            }
        }

        return {
            complete: images.length > 0,
            images,
        };
    }

    /**
     * Get image as base64
     */
    async getImageAsBase64(imageUrl: string): Promise<string> {
        const response = await fetch(imageUrl);
        const blob = await response.blob();

        return new Promise((resolve, reject) => {
            const reader = new FileReader();
            reader.onloadend = () => resolve(reader.result as string);
            reader.onerror = reject;
            reader.readAsDataURL(blob);
        });
    }

    /**
     * Poll for completion with timeout
     */
    async waitForCompletion(
        promptId: string,
        maxWaitMs: number = 300000, // 5 minutes default
        pollIntervalMs: number = 2000
    ): Promise<string[]> {
        const startTime = Date.now();

        while (Date.now() - startTime < maxWaitMs) {
            const result = await this.isComplete(promptId);

            if (result.complete) {
                return result.images;
            }

            await new Promise((resolve) => setTimeout(resolve, pollIntervalMs));
        }

        throw new Error('Generation timed out');
    }
}

// Singleton instance
let clientInstance: ComfyUIClient | null = null;

export function getComfyUIClient(config?: ComfyUIConfig): ComfyUIClient {
    if (!clientInstance || config) {
        clientInstance = new ComfyUIClient(config);
    }
    return clientInstance;
}
