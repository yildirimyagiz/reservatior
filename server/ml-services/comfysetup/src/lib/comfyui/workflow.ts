/**
 * ComfyUI Workflow Builder
 * Generates dynamic workflow JSON for staging operations
 */

import type { ComputeMode } from '@/types';

export interface WorkflowConfig {
    imageName: string;
    positivePrompt: string;
    negativePrompt: string;
    checkpoint?: string;
    controlnetModel?: string;
    steps: number;
    cfg: number;
    denoise: number;
    width: number;
    height: number;
    seed?: number;
}

/**
 * Build a staging workflow with ControlNet depth
 * This is a flexible workflow that works with common setups
 */
export function buildStagingWorkflow(config: WorkflowConfig): Record<string, unknown> {
    const seed = config.seed ?? Math.floor(Math.random() * 2147483647);

    // Workflow using standard ComfyUI nodes
    // Optimized for SD 1.5 + ControlNet v1.1 Depth
    return {
        // Load checkpoint (Strict SD 1.5)
        "1": {
            "class_type": "CheckpointLoaderSimple",
            "inputs": {
                "ckpt_name": config.checkpoint || "v1-5-pruned-emaonly.ckpt"
            }
        },

        // Load input image
        "2": {
            "class_type": "LoadImage",
            "inputs": {
                "image": config.imageName
            }
        },

        // Get image dimensions & scale (Max 1024 for SD 1.5)
        "3": {
            "class_type": "ImageScale",
            "inputs": {
                "image": ["2", 0],
                "upscale_method": "lanczos",
                "width": Math.min(config.width, 1024),
                "height": Math.min(config.height, 1024),
                "crop": "center"
            }
        },

        // Depth estimation (Depth Anything is fine, but MiDaS is standard for v1.1)
        "4": {
            "class_type": "DepthAnythingPreprocessor",
            "inputs": {
                "image": ["3", 0],
                "ckpt_name": "depth_anything_vitl14.pth",
                "resolution": 512
            }
        },

        // Load ControlNet model (SD 1.5 Version)
        "5": {
            "class_type": "ControlNetLoader",
            "inputs": {
                "control_net_name": config.controlnetModel || "control_v11f1p_sd15_depth.pth"
            }
        },

        // CLIP text encode positive
        "6": {
            "class_type": "CLIPTextEncode",
            "inputs": {
                "text": config.positivePrompt,
                "clip": ["1", 1]
            }
        },

        // CLIP text encode negative
        "7": {
            "class_type": "CLIPTextEncode",
            "inputs": {
                "text": config.negativePrompt,
                "clip": ["1", 1]
            }
        },

        // Apply ControlNet
        "8": {
            "class_type": "ControlNetApplyAdvanced",
            "inputs": {
                "positive": ["6", 0],
                "negative": ["7", 0],
                "control_net": ["5", 0],
                "image": ["4", 0],
                "strength": 0.85,
                "start_percent": 0.0,
                "end_percent": 1.0
            }
        },

        // Empty latent
        "9": {
            "class_type": "EmptyLatentImage",
            "inputs": {
                "width": Math.min(config.width, 1024),
                "height": Math.min(config.height, 1024),
                "batch_size": 1
            }
        },

        // KSampler
        "10": {
            "class_type": "KSampler",
            "inputs": {
                "model": ["1", 0],
                "positive": ["8", 0],
                "negative": ["8", 1],
                "latent_image": ["9", 0],
                "seed": seed,
                "steps": config.steps,
                "cfg": config.cfg,
                "sampler_name": "euler", // dpmpp_2m_karras is better but euler is safe fallback
                "scheduler": "normal",
                "denoise": config.denoise
            }
        },

        // VAE Decode
        "11": {
            "class_type": "VAEDecode",
            "inputs": {
                "samples": ["10", 0],
                "vae": ["1", 2]
            }
        },

        // Save Image
        "12": {
            "class_type": "SaveImage",
            "inputs": {
                "images": ["11", 0],
                "filename_prefix": "staged"
            }
        }
    };
}

/**
 * Build a simpler img2img workflow (fallback if ControlNet not available)
 */
export function buildImg2ImgWorkflow(config: WorkflowConfig): Record<string, unknown> {
    const seed = config.seed ?? Math.floor(Math.random() * 2147483647);

    return {
        // Load checkpoint
        "1": {
            "class_type": "CheckpointLoaderSimple",
            "inputs": {
                "ckpt_name": config.checkpoint || "v1-5-pruned-emaonly.ckpt"
            }
        },

        // Load input image
        "2": {
            "class_type": "LoadImage",
            "inputs": {
                "image": config.imageName
            }
        },

        // Scale image
        "3": {
            "class_type": "ImageScale",
            "inputs": {
                "image": ["2", 0],
                "upscale_method": "lanczos",
                "width": Math.min(config.width, 1024),
                "height": Math.min(config.height, 1024),
                "crop": "center"
            }
        },

        // Encode image to latent
        "4": {
            "class_type": "VAEEncode",
            "inputs": {
                "pixels": ["3", 0],
                "vae": ["1", 2]
            }
        },

        // CLIP text encode positive
        "5": {
            "class_type": "CLIPTextEncode",
            "inputs": {
                "text": config.positivePrompt,
                "clip": ["1", 1]
            }
        },

        // CLIP text encode negative
        "6": {
            "class_type": "CLIPTextEncode",
            "inputs": {
                "text": config.negativePrompt,
                "clip": ["1", 1]
            }
        },

        // KSampler
        "7": {
            "class_type": "KSampler",
            "inputs": {
                "model": ["1", 0],
                "positive": ["5", 0],
                "negative": ["6", 0],
                "latent_image": ["4", 0],
                "seed": seed,
                "steps": config.steps,
                "cfg": config.cfg,
                "sampler_name": "euler",
                "scheduler": "normal",
                "denoise": config.denoise
            }
        },

        // VAE Decode
        "8": {
            "class_type": "VAEDecode",
            "inputs": {
                "samples": ["7", 0],
                "vae": ["1", 2]
            }
        },

        // Save Image
        "9": {
            "class_type": "SaveImage",
            "inputs": {
                "images": ["8", 0],
                "filename_prefix": "staged"
            }
        }
    };
}

/**
 * Get workflow settings based on compute mode
 */
export function getWorkflowSettings(mode: ComputeMode): {
    steps: number;
    cfg: number;
    denoise: number;
    width: number;
    height: number;
} {
    if (mode === 'cpu') {
        return {
            steps: 15, // Reduced for speed on CPU
            cfg: 6.5,
            denoise: 0.7,
            width: 512, // Lower resolution for fast CPU inference
            height: 512,
        };
    }

    // GPU mode
    return {
        steps: 30,
        cfg: 7,
        denoise: 0.7,
        width: 1024,
        height: 1024,
    };
}
