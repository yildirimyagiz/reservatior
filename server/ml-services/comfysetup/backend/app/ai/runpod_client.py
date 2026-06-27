"""
RunPod Serverless Client for ComfyUI and AI Model Endpoints.

Supports:
- ComfyUI workflow execution
- Image generation (Stable Diffusion, SDXL, Flux)
- Video generation (Walkthroughs, tours)
- Async and sync operations
- Webhook-based notifications
- Health checks and auto-scaling awareness
"""

import aiohttp
import asyncio
import logging
import time
import base64
from typing import Dict, Any, Optional, List, Callable
from dataclasses import dataclass, field
from enum import Enum
import json

from app.core.config import settings

logger = logging.getLogger(__name__)


class RunPodJobStatus(Enum):
    """RunPod job status enumeration."""
    IN_QUEUE = "IN_QUEUE"
    IN_PROGRESS = "IN_PROGRESS"
    COMPLETED = "COMPLETED"
    FAILED = "FAILED"
    CANCELLED = "CANCELLED"
    TIMED_OUT = "TIMED_OUT"


@dataclass
class RunPodJobResult:
    """Result container for RunPod jobs."""
    job_id: str
    status: RunPodJobStatus
    output: Optional[Dict[str, Any]] = None
    error: Optional[str] = None
    execution_time_ms: int = 0
    delay_time_ms: int = 0
    images: List[str] = field(default_factory=list)
    videos: List[str] = field(default_factory=list)
    
    @property
    def is_success(self) -> bool:
        return self.status == RunPodJobStatus.COMPLETED
    
    @property
    def cost_estimate_usd(self) -> float:
        """Estimate cost based on execution time (RTX 4090 ~$0.00069/sec)."""
        return (self.execution_time_ms / 1000) * 0.00069


class RunPodClient:
    """
    Enhanced client for RunPod Serverless Endpoints.
    Supports ComfyUI, A1111, and custom model endpoints.
    """
    
    # Default endpoints for different AI tasks
    ENDPOINT_TYPES = {
        "comfyui": "comfyui-serverless",
        "sdxl": "sdxl-serverless",
        "flux": "flux-serverless",
        "video": "video-serverless",
    }
    
    def __init__(
        self,
        api_key: Optional[str] = None,
        endpoint_id: Optional[str] = None,
        timeout_seconds: int = 300,
        poll_interval_seconds: float = 1.0,
    ):
        self.api_key = api_key or settings.RUNPOD_API_KEY
        self.endpoint_id = endpoint_id or settings.RUNPOD_ENDPOINT_ID
        self.timeout_seconds = timeout_seconds
        self.poll_interval = poll_interval_seconds
        
        self._base_url = "https://api.runpod.ai/v2"
        self._graphql_url = "https://api.runpod.io/graphql"
        
    @property
    def headers(self) -> Dict[str, str]:
        return {
            "Authorization": f"Bearer {self.api_key}",
            "Content-Type": "application/json"
        }
    
    @property
    def endpoint_url(self) -> str:
        return f"{self._base_url}/{self.endpoint_id}"
    
    def is_configured(self) -> bool:
        """Check if RunPod credentials are configured."""
        return bool(self.api_key and self.endpoint_id)
    
    async def health_check(self) -> Dict[str, Any]:
        """
        Check endpoint health and worker availability.
        Returns endpoint status and active workers count.
        """
        if not self.is_configured():
            return {"status": "not_configured", "workers": 0}
        
        try:
            async with aiohttp.ClientSession() as session:
                url = f"{self.endpoint_url}/health"
                async with session.get(url, headers=self.headers, timeout=10) as resp:
                    if resp.status == 200:
                        data = await resp.json()
                        return {
                            "status": "healthy",
                            "workers": data.get("workers", {}).get("ready", 0),
                            "jobs_in_queue": data.get("jobs", {}).get("inQueue", 0),
                            "jobs_in_progress": data.get("jobs", {}).get("inProgress", 0),
                        }
                    return {"status": "unhealthy", "workers": 0}
        except Exception as e:
            logger.error(f"RunPod health check failed: {e}")
            return {"status": "error", "error": str(e), "workers": 0}

    async def run_sync(
        self,
        workflow_json: Dict[str, Any],
        timeout: Optional[int] = None,
        on_progress: Optional[Callable[[str, int], None]] = None
    ) -> RunPodJobResult:
        """
        Run inference synchronously with polling.
        Best for simple jobs under 2 minutes.
        
        Args:
            workflow_json: ComfyUI workflow or model input
            timeout: Override default timeout
            on_progress: Optional callback for progress updates
            
        Returns:
            RunPodJobResult with output data
        """
        if not self.is_configured():
            logger.warning("RunPod not configured. Returning mock response.")
            return RunPodJobResult(
                job_id="mock_job",
                status=RunPodJobStatus.COMPLETED,
                output={"images": ["/images/placeholder-staged.jpg"]},
                images=["/images/placeholder-staged.jpg"]
            )
        
        timeout = timeout or self.timeout_seconds
        start_time = time.time()
        
        try:
            async with aiohttp.ClientSession() as session:
                # 1. Submit Job
                job_id = await self._submit_job(session, workflow_json)
                logger.info(f"RunPod job submitted: {job_id}")
                
                if on_progress:
                    on_progress(job_id, 0)
                
                # 2. Poll for completion
                result = await self._poll_job(
                    session, job_id, timeout, start_time, on_progress
                )
                
                return result
                
        except asyncio.TimeoutError:
            logger.error(f"RunPod job timed out after {timeout}s")
            return RunPodJobResult(
                job_id=job_id if 'job_id' in locals() else "unknown",
                status=RunPodJobStatus.TIMED_OUT,
                error=f"Job timed out after {timeout} seconds"
            )
        except Exception as e:
            logger.error(f"RunPod execution failed: {e}")
            return RunPodJobResult(
                job_id=job_id if 'job_id' in locals() else "unknown",
                status=RunPodJobStatus.FAILED,
                error=str(e)
            )

    async def run_async(
        self,
        workflow_json: Dict[str, Any],
        webhook_url: Optional[str] = None
    ) -> str:
        """
        Submit job asynchronously (fire-and-forget).
        Returns job_id immediately. Use webhook for results.
        
        Best for long-running jobs (video generation, batch processing).
        """
        if not self.is_configured():
            logger.warning("RunPod not configured. Returning mock job ID.")
            return "mock_async_job_id"
        
        async with aiohttp.ClientSession() as session:
            payload = {
                "input": {"workflow": workflow_json}
            }
            
            if webhook_url:
                payload["webhook"] = webhook_url
            
            url = f"{self.endpoint_url}/run"
            async with session.post(url, headers=self.headers, json=payload) as resp:
                if resp.status != 200:
                    text = await resp.text()
                    raise Exception(f"RunPod submission failed: {resp.status} - {text}")
                
                data = await resp.json()
                job_id = data.get("id")
                logger.info(f"RunPod async job submitted: {job_id}")
                return job_id

    async def get_job_status(self, job_id: str) -> RunPodJobResult:
        """Get the current status of a job."""
        if not self.is_configured():
            return RunPodJobResult(
                job_id=job_id,
                status=RunPodJobStatus.COMPLETED,
                output={"status": "mock"}
            )
        
        async with aiohttp.ClientSession() as session:
            url = f"{self.endpoint_url}/status/{job_id}"
            async with session.get(url, headers=self.headers) as resp:
                data = await resp.json()
                return self._parse_job_response(job_id, data)

    async def cancel_job(self, job_id: str) -> bool:
        """Cancel a running job."""
        if not self.is_configured():
            return True
        
        try:
            async with aiohttp.ClientSession() as session:
                url = f"{self.endpoint_url}/cancel/{job_id}"
                async with session.post(url, headers=self.headers) as resp:
                    return resp.status == 200
        except Exception as e:
            logger.error(f"Failed to cancel job {job_id}: {e}")
            return False

    async def purge_queue(self) -> Dict[str, int]:
        """Purge all queued jobs (admin operation)."""
        if not self.is_configured():
            return {"removed": 0}
        
        async with aiohttp.ClientSession() as session:
            url = f"{self.endpoint_url}/purge-queue"
            async with session.post(url, headers=self.headers) as resp:
                if resp.status == 200:
                    data = await resp.json()
                    return {"removed": data.get("removed", 0)}
                return {"removed": 0, "error": await resp.text()}

    # === ComfyUI Specific Methods ===
    
    async def run_comfyui_workflow(
        self,
        workflow: Dict[str, Any],
        input_images: Optional[Dict[str, bytes]] = None,
        timeout: Optional[int] = None
    ) -> RunPodJobResult:
        """
        Run a ComfyUI workflow with optional image inputs.
        
        Args:
            workflow: ComfyUI workflow JSON
            input_images: Dict mapping node input names to image bytes
            timeout: Max execution time
            
        Returns:
            RunPodJobResult with generated images
        """
        payload = {"workflow": workflow}
        
        # Encode images as base64
        if input_images:
            encoded_images = {}
            for name, img_bytes in input_images.items():
                encoded_images[name] = base64.b64encode(img_bytes).decode('utf-8')
            payload["images"] = encoded_images
        
        return await self.run_sync(payload, timeout=timeout)

    async def generate_staged_image(
        self,
        source_image_path: str,
        room_type: str = "living_room",
        style: str = "modern",
        keep_structure: bool = True,
        denoise_strength: float = 0.65
    ) -> RunPodJobResult:
        """
        Generate a staged room image using virtual staging workflow.
        
        Args:
            source_image_path: Path to empty room image
            room_type: Type of room (living_room, bedroom, kitchen, etc.)
            style: Staging style (modern, luxury, minimalist, etc.)
            keep_structure: Whether to preserve room structure
            denoise_strength: How much to change (0.0-1.0)
        """
        # Build staging-optimized workflow
        workflow = self._build_staging_workflow(
            room_type=room_type,
            style=style,
            denoise_strength=denoise_strength,
            keep_structure=keep_structure
        )
        
        # Load source image
        with open(source_image_path, 'rb') as f:
            image_bytes = f.read()
        
        return await self.run_comfyui_workflow(
            workflow=workflow,
            input_images={"source": image_bytes}
        )

    # === Private Methods ===
    
    async def _submit_job(
        self,
        session: aiohttp.ClientSession,
        workflow_json: Dict[str, Any]
    ) -> str:
        """Submit a job and return the job ID."""
        url = f"{self.endpoint_url}/run"
        payload = {"input": workflow_json}
        
        async with session.post(url, headers=self.headers, json=payload) as resp:
            if resp.status != 200:
                text = await resp.text()
                raise Exception(f"Job submission failed: {resp.status} - {text}")
            
            data = await resp.json()
            return data.get("id")

    async def _poll_job(
        self,
        session: aiohttp.ClientSession,
        job_id: str,
        timeout: int,
        start_time: float,
        on_progress: Optional[Callable] = None
    ) -> RunPodJobResult:
        """Poll for job completion."""
        url = f"{self.endpoint_url}/status/{job_id}"
        
        while True:
            elapsed = time.time() - start_time
            if elapsed > timeout:
                raise asyncio.TimeoutError()
            
            async with session.get(url, headers=self.headers) as resp:
                data = await resp.json()
                result = self._parse_job_response(job_id, data)
                
                if on_progress:
                    progress = min(95, int((elapsed / timeout) * 100))
                    on_progress(job_id, progress)
                
                if result.status in [
                    RunPodJobStatus.COMPLETED,
                    RunPodJobStatus.FAILED,
                    RunPodJobStatus.CANCELLED
                ]:
                    if on_progress:
                        on_progress(job_id, 100)
                    return result
            
            await asyncio.sleep(self.poll_interval)

    def _parse_job_response(self, job_id: str, data: Dict[str, Any]) -> RunPodJobResult:
        """Parse RunPod API response into RunPodJobResult."""
        status_str = data.get("status", "UNKNOWN")
        try:
            status = RunPodJobStatus(status_str)
        except ValueError:
            status = RunPodJobStatus.FAILED
        
        output = data.get("output", {})
        
        # Extract images/videos from output
        images = []
        videos = []
        
        if isinstance(output, dict):
            images = output.get("images", [])
            videos = output.get("videos", [])
            # Also check common ComfyUI output formats
            if "message" in output and isinstance(output["message"], dict):
                images = output["message"].get("images", images)
        
        return RunPodJobResult(
            job_id=job_id,
            status=status,
            output=output,
            error=data.get("error"),
            execution_time_ms=data.get("executionTime", 0),
            delay_time_ms=data.get("delayTime", 0),
            images=images,
            videos=videos
        )

    def _build_staging_workflow(
        self,
        room_type: str,
        style: str,
        denoise_strength: float,
        keep_structure: bool
    ) -> Dict[str, Any]:
        """Build a ComfyUI workflow for virtual staging."""
        # Prompt engineering for staging
        positive_prompt = f"""
        Professional interior design, {style} {room_type}, 
        high-end furniture, warm lighting, photorealistic, 
        architectural photography, 8k quality, magazine cover
        """.strip()
        
        negative_prompt = """
        blurry, low quality, distorted, cartoon, anime, 
        unrealistic, people, text, watermark, 
        distorted architecture, bent walls
        """.strip()
        
        # Standard SDXL img2img workflow structure for ComfyUI
        workflow = {
            "3": {
                "class_type": "KSampler",
                "inputs": {
                    "cfg": 7,
                    "denoise": denoise_strength,
                    "latent_image": ["5", 0],
                    "model": ["4", 0],
                    "negative": ["7", 0],
                    "positive": ["6", 0],
                    "sampler_name": "dpmpp_2m",
                    "scheduler": "karras",
                    "seed": -1,
                    "steps": 25
                }
            },
            "4": {
                "class_type": "CheckpointLoaderSimple",
                "inputs": {
                    "ckpt_name": "juggernautXL_v9.safetensors"
                }
            },
            "5": {
                "class_type": "VAEEncode",
                "inputs": {
                    "pixels": ["10", 0],
                    "vae": ["4", 2]
                }
            },
            "6": {
                "class_type": "CLIPTextEncode",
                "inputs": {
                    "clip": ["4", 1],
                    "text": positive_prompt
                }
            },
            "7": {
                "class_type": "CLIPTextEncode",
                "inputs": {
                    "clip": ["4", 1],
                    "text": negative_prompt
                }
            },
            "8": {
                "class_type": "VAEDecode",
                "inputs": {
                    "samples": ["3", 0],
                    "vae": ["4", 2]
                }
            },
            "9": {
                "class_type": "SaveImage",
                "inputs": {
                    "filename_prefix": "staged",
                    "images": ["8", 0]
                }
            },
            "10": {
                "class_type": "LoadImage",
                "inputs": {
                    "image": "source"  # Will be replaced with actual image
                }
            }
        }
        
        # Add ControlNet for structure preservation if needed
        if keep_structure:
            workflow["11"] = {
                "class_type": "ControlNetLoader",
                "inputs": {
                    "control_net_name": "controlnet-depth-sdxl-1.0"
                }
            }
            workflow["12"] = {
                "class_type": "DepthEstimation",
                "inputs": {
                    "image": ["10", 0]
                }
            }
            workflow["13"] = {
                "class_type": "ControlNetApply",
                "inputs": {
                    "conditioning": ["6", 0],
                    "control_net": ["11", 0],
                    "image": ["12", 0],
                    "strength": 0.8
                }
            }
            # Update sampler to use ControlNet conditioning
            workflow["3"]["inputs"]["positive"] = ["13", 0]
        
        return workflow

    async def cleanup(self):
        """Cleanup resources (no-op for now)."""
        pass


# === Factory Functions ===

def create_runpod_client(
    endpoint_type: str = "comfyui",
    custom_endpoint_id: Optional[str] = None
) -> RunPodClient:
    """
    Factory function to create RunPod clients for different endpoints.
    
    Args:
        endpoint_type: One of 'comfyui', 'sdxl', 'flux', 'video'
        custom_endpoint_id: Override with specific endpoint ID
    """
    endpoint_id = custom_endpoint_id or settings.RUNPOD_ENDPOINT_ID
    return RunPodClient(endpoint_id=endpoint_id)


# Global default instance
runpod_client = RunPodClient()
