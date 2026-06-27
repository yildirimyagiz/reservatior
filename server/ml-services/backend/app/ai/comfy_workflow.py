import json
import logging
from typing import Dict, Any, List
from app.core.config import settings

logger = logging.getLogger(__name__)

class ComfyWorkflowManager:
    """
    Manages ComfyUI workflow definitions for Virtual Staging.
    Injects inputs into the node graph JSON.
    """
    
    # Minimal SD1.5 + ControlNet Depth Workflow
    # In production, this would be loaded from a JSON file.
    DEFAULT_STAGING_WORKFLOW = {
        "13": {
            "inputs": {
                "pixels": ["11", 0],
                "vae": ["4", 2]
            },
            "class_type": "VAEEncode"
        },
        "3": {
            "inputs": {
                "seed": 0,
                "steps": 25,
                "cfg": 7.0,
                "sampler_name": "euler",
                "scheduler": "normal",
                "denoise": 0.75,
                "model": ["4", 0],
                "positive": ["6", 0],
                "negative": ["7", 0],
                # Connect to VAE Encode output instead of Empty Latent
                "latent_image": ["13", 0] 
            },
            "class_type": "KSampler"
        },
        "4": {
            "inputs": {
                "ckpt_name": settings.SD_CHECKPOINT
            },
            "class_type": "CheckpointLoaderSimple"
        },
        "6": {
            "inputs": {
                "text": "modern furniture, interior design, high quality, photorealistic",
                "clip": ["4", 1]
            },
            "class_type": "CLIPTextEncode"
        },
        "7": {
            "inputs": {
                "text": "empty room, low quality, blurry",
                "clip": ["4", 1]
            },
            "class_type": "CLIPTextEncode"
        },
        "8": {
            "inputs": {
                "samples": ["3", 0],
                "vae": ["4", 2]
            },
            "class_type": "VAEDecode"
        },
        "9": {
            "inputs": {
                "filename_prefix": "ComfyUI",
                "images": ["8", 0]
            },
            "class_type": "SaveImage"
        },
        "10": {
            "inputs": {
                "image": "example.jpg", # Will be replaced
                "upload": "image"
            },
            "class_type": "LoadImage"
        },
        "11": {
            "inputs": {
                "upscale_method": "nearest-exact",
                "width": 1024,
                "height": 1024,
                "crop": "center",
                "image": ["10", 0]
            },
            "class_type": "ImageScale"
        },
         "12": {
            "inputs": {
                "width": 1024,
                "height": 1024,
                "batch_size": 1
            },
            "class_type": "EmptyLatentImage"
        },
        # ControlNet Logic would go here in full version
        # For Minimum Viable Staging, we act as if we have Depth ControlNet linked up
        # This is a skeleton to be expanded.
    }

    def get_workflow(self, workflow_name: str = "default") -> Dict[str, Any]:
        """Get raw workflow template"""
        # In future, load from disk
        return self.DEFAULT_STAGING_WORKFLOW.copy()

    def prepare_workflow(self, input_image_path: str, prompt: str, seed: int = None, denoising_strength: float = 0.55) -> Dict[str, Any]:
        """
        Inject parameters into the workflow.
        For RunPod, we usually pass input arguments, not raw JSON substitution, 
        BUT standard ComfyUI API expects the full modified JSON graph.
        """
        workflow = self.get_workflow()
        
        # 1. Update Prompt
        workflow["6"]["inputs"]["text"] = f"{prompt}, photorealistic, 8k, interior design"
        
        # 2. Update Seed
        if seed is None:
            import random
            seed = random.randint(0, 1000000000)
        workflow["3"]["inputs"]["seed"] = seed
        
        # 3. Update Denoising Strength
        # 0.3-0.5: Harmonize/Blend (Keep structure/furniture)
        # 0.6-0.8: Regenerate/Redesign (Change furniture)
        workflow["3"]["inputs"]["denoise"] = denoising_strength
        
        # 4. Input Image logic depends on RunPod endpoint configuration
        # If using serverless handler that accepts 'input_image' URL, we might not need to touch LoadImage node
        # if the worker handles it. However, standard Comfy usually downloads explicit URLs.
        # Let's assume our RunPod worker expects a fully formed input dictionary.
        
        return {
            "workflow": workflow,
            "images": [
                {
                    "name": "example.jpg",
                    "image": input_image_path # This assumes base64 or URL depending on worker
                }
            ]
        }

comfy_workflow_manager = ComfyWorkflowManager()
