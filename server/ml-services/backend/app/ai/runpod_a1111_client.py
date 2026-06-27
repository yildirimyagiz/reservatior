"""
RunPod A1111 Serverless Client.

Uses RunPod's serverless infrastructure to run Automatic1111 Stable Diffusion.
This gives you cloud-based A1111 with pay-per-use pricing.

API Reference: https://github.com/runpod-workers/worker-a1111

Endpoints:
- /run - Async (returns job_id, poll /status for result)
- /runsync - Sync (waits up to 90s, then falls back to polling)
"""

import aiohttp
import asyncio
import base64
import logging
import time
from pathlib import Path
from typing import Dict, Any, List, Optional
from dataclasses import dataclass, field
from enum import Enum

from app.core.config import settings

logger = logging.getLogger(__name__)


class RunPodA1111JobStatus(Enum):
    """RunPod job status enumeration."""
    IN_QUEUE = "IN_QUEUE"
    IN_PROGRESS = "IN_PROGRESS"
    COMPLETED = "COMPLETED"
    FAILED = "FAILED"
    CANCELLED = "CANCELLED"
    TIMED_OUT = "TIMED_OUT"


@dataclass
class RunPodA1111Result:
    """Result container for RunPod A1111 jobs."""
    job_id: str
    status: RunPodA1111JobStatus
    images: List[str] = field(default_factory=list)  # Base64 encoded images
    parameters: Dict[str, Any] = field(default_factory=dict)
    error: Optional[str] = None
    execution_time_ms: int = 0
    delay_time_ms: int = 0
    
    @property
    def is_success(self) -> bool:
        return self.status == RunPodA1111JobStatus.COMPLETED and len(self.images) > 0
    
    @property
    def cost_estimate_usd(self) -> float:
        """Estimate cost based on execution time (~$0.00069/sec for RTX 4090)."""
        return (self.execution_time_ms / 1000) * 0.00069


class RunPodA1111Client:
    """
    Client for RunPod's A1111 Serverless Endpoint.
    
    This is A1111 running in the cloud on RunPod's infrastructure.
    Same API as local A1111, but wrapped in RunPod's serverless layer.
    
    Setup on RunPod:
    1. Go to RunPod Console → Serverless → Create Endpoint
    2. Select "Automatic1111" template or use worker-a1111 image
    3. Copy your Endpoint ID and API Key
    4. Set RUNPOD_API_KEY and RUNPOD_A1111_ENDPOINT_ID in .env
    
    Usage:
        client = RunPodA1111Client()
        result = await client.img2img(
            image_data="base64...",
            prompt="modern furnished living room"
        )
    """
    
    def __init__(
        self,
        api_key: Optional[str] = None,
        endpoint_id: Optional[str] = None,
        timeout_seconds: int = 300,
        poll_interval_seconds: float = 2.0,
    ):
        self.api_key = api_key or settings.RUNPOD_API_KEY
        self.endpoint_id = endpoint_id or getattr(settings, 'RUNPOD_A1111_ENDPOINT_ID', '') or settings.RUNPOD_ENDPOINT_ID
        self.timeout_seconds = timeout_seconds
        self.poll_interval = poll_interval_seconds
        
        self._base_url = "https://api.runpod.ai/v2"
    
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
        """Check endpoint health and worker availability."""
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
            logger.error(f"RunPod A1111 health check failed: {e}")
            return {"status": "error", "error": str(e), "workers": 0}
    
    async def txt2img(
        self,
        prompt: str,
        negative_prompt: str = "",
        width: int = 1024,
        height: int = 1024,
        steps: int = 25,
        cfg_scale: float = 7.0,
        sampler_name: str = "DPM++ 2M Karras",
        seed: int = -1,
        batch_size: int = 1,
    ) -> RunPodA1111Result:
        """Generate images from text prompt via RunPod."""
        payload = {
            "api_name": "txt2img",
            "prompt": prompt,
            "negative_prompt": negative_prompt or "low quality, blurry, distorted",
            "width": width,
            "height": height,
            "steps": steps,
            "cfg_scale": cfg_scale,
            "sampler_name": sampler_name,
            "seed": seed,
            "batch_size": batch_size,
        }
        
        return await self._run_sync(payload)
    
    async def img2img(
        self,
        init_image: str,  # Base64 encoded image
        prompt: str,
        negative_prompt: str = "",
        denoising_strength: float = 0.55,
        width: int = 1024,
        height: int = 1024,
        steps: int = 25,
        cfg_scale: float = 7.0,
        sampler_name: str = "DPM++ 2M Karras",
        seed: int = -1,
        batch_size: int = 1,
        resize_mode: int = 1,
    ) -> RunPodA1111Result:
        """
        Transform an existing image via RunPod A1111.
        PRIMARY method for virtual staging.
        """
        # Strip data URI prefix if present
        if init_image.startswith("data:"):
            init_image = init_image.split(",", 1)[1]
        
        payload = {
            "api_name": "img2img",
            "init_images": [init_image],
            "prompt": prompt,
            "negative_prompt": negative_prompt or "empty room, unfurnished, low quality, blurry",
            "denoising_strength": denoising_strength,
            "width": width,
            "height": height,
            "steps": steps,
            "cfg_scale": cfg_scale,
            "sampler_name": sampler_name,
            "seed": seed,
            "batch_size": batch_size,
            "resize_mode": resize_mode,
        }
        
        return await self._run_sync(payload)
    
    async def stage_room(
        self,
        image_base64: str,
        room_type: str = "living_room",
        style: str = "modern",
        denoising_strength: float = 0.55,
    ) -> RunPodA1111Result:
        """
        High-level staging method for real estate.
        """
        prompt = self._build_staging_prompt(room_type, style)
        negative_prompt = self._build_staging_negative_prompt()
        
        logger.info(f"RunPod A1111: Staging {room_type} in {style} style")
        
        return await self.img2img(
            init_image=image_base64,
            prompt=prompt,
            negative_prompt=negative_prompt,
            denoising_strength=denoising_strength,
            steps=30,
            cfg_scale=7.5,
        )
    
    async def img2img_with_controlnet(
        self,
        init_image: str,
        prompt: str,
        controlnet_model: str = "control_v11f1p_sd15_depth",
        controlnet_weight: float = 0.8,
        denoising_strength: float = 0.75,
        **kwargs
    ) -> RunPodA1111Result:
        """img2img with ControlNet for structure preservation."""
        if init_image.startswith("data:"):
            init_image = init_image.split(",", 1)[1]
        
        payload = {
            "api_name": "img2img",
            "init_images": [init_image],
            "prompt": prompt,
            "negative_prompt": kwargs.get("negative_prompt", "low quality, blurry"),
            "denoising_strength": denoising_strength,
            "width": kwargs.get("width", 1024),
            "height": kwargs.get("height", 1024),
            "steps": kwargs.get("steps", 25),
            "cfg_scale": kwargs.get("cfg_scale", 7.0),
            "sampler_name": kwargs.get("sampler_name", "DPM++ 2M Karras"),
            "seed": kwargs.get("seed", -1),
            # ControlNet args for RunPod worker
            "controlnet": {
                "input_image": init_image,
                "module": "depth_midas",
                "model": controlnet_model,
                "weight": controlnet_weight,
            }
        }
        
        return await self._run_sync(payload)
    
    # === Private Methods ===
    
    async def _run_sync(self, payload: Dict[str, Any]) -> RunPodA1111Result:
        """
        Run a synchronous request (uses /runsync endpoint).
        Waits up to 90s, then falls back to polling.
        """
        if not self.is_configured():
            logger.warning("RunPod not configured. Returning mock response.")
            return RunPodA1111Result(
                job_id="mock_job",
                status=RunPodA1111JobStatus.COMPLETED,
                images=[],  # No actual images
                error="RunPod not configured"
            )
        
        try:
            async with aiohttp.ClientSession() as session:
                # Try runsync first (blocks for up to 90s)
                url = f"{self.endpoint_url}/runsync"
                
                async with session.post(
                    url, 
                    headers=self.headers, 
                    json={"input": payload},
                    timeout=aiohttp.ClientTimeout(total=100)
                ) as resp:
                    if resp.status != 200:
                        text = await resp.text()
                        return RunPodA1111Result(
                            job_id="unknown",
                            status=RunPodA1111JobStatus.FAILED,
                            error=f"HTTP {resp.status}: {text}"
                        )
                    
                    data = await resp.json()
                    
                    # Check if completed or needs polling
                    status_str = data.get("status", "UNKNOWN")
                    
                    if status_str == "COMPLETED":
                        return self._parse_result(data)
                    elif status_str in ["IN_QUEUE", "IN_PROGRESS"]:
                        # Need to poll for result
                        job_id = data.get("id")
                        return await self._poll_for_result(session, job_id)
                    else:
                        return RunPodA1111Result(
                            job_id=data.get("id", "unknown"),
                            status=RunPodA1111JobStatus.FAILED,
                            error=data.get("error", f"Unknown status: {status_str}")
                        )
                        
        except asyncio.TimeoutError:
            logger.error("RunPod request timed out")
            return RunPodA1111Result(
                job_id="unknown",
                status=RunPodA1111JobStatus.TIMED_OUT,
                error="Request timed out"
            )
        except Exception as e:
            logger.error(f"RunPod A1111 request failed: {e}")
            return RunPodA1111Result(
                job_id="unknown",
                status=RunPodA1111JobStatus.FAILED,
                error=str(e)
            )
    
    async def _run_async(self, payload: Dict[str, Any]) -> str:
        """Submit job asynchronously, return job_id."""
        if not self.is_configured():
            return "mock_job_id"
        
        async with aiohttp.ClientSession() as session:
            url = f"{self.endpoint_url}/run"
            
            async with session.post(
                url,
                headers=self.headers,
                json={"input": payload}
            ) as resp:
                if resp.status != 200:
                    text = await resp.text()
                    raise Exception(f"Job submission failed: {text}")
                
                data = await resp.json()
                return data.get("id")
    
    async def _poll_for_result(
        self, 
        session: aiohttp.ClientSession,
        job_id: str
    ) -> RunPodA1111Result:
        """Poll for job completion."""
        url = f"{self.endpoint_url}/status/{job_id}"
        start_time = time.time()
        
        while True:
            elapsed = time.time() - start_time
            if elapsed > self.timeout_seconds:
                return RunPodA1111Result(
                    job_id=job_id,
                    status=RunPodA1111JobStatus.TIMED_OUT,
                    error=f"Timed out after {self.timeout_seconds}s"
                )
            
            async with session.get(url, headers=self.headers) as resp:
                data = await resp.json()
                status_str = data.get("status", "UNKNOWN")
                
                if status_str == "COMPLETED":
                    return self._parse_result(data)
                elif status_str == "FAILED":
                    return RunPodA1111Result(
                        job_id=job_id,
                        status=RunPodA1111JobStatus.FAILED,
                        error=data.get("error", "Job failed")
                    )
                elif status_str == "CANCELLED":
                    return RunPodA1111Result(
                        job_id=job_id,
                        status=RunPodA1111JobStatus.CANCELLED,
                        error="Job was cancelled"
                    )
            
            await asyncio.sleep(self.poll_interval)
    
    def _parse_result(self, data: Dict[str, Any]) -> RunPodA1111Result:
        """Parse RunPod response into result object."""
        output = data.get("output", {})
        
        # A1111 worker returns images in output.images
        images = []
        if isinstance(output, dict):
            images = output.get("images", [])
            # Some workers put it in output.result.images
            if not images and "result" in output:
                images = output.get("result", {}).get("images", [])
        
        return RunPodA1111Result(
            job_id=data.get("id", "unknown"),
            status=RunPodA1111JobStatus.COMPLETED,
            images=images,
            parameters=output.get("parameters", {}),
            execution_time_ms=data.get("executionTime", 0),
            delay_time_ms=data.get("delayTime", 0),
        )
    
    def _build_staging_prompt(self, room_type: str, style: str) -> str:
        """Build optimized prompt for virtual staging."""
        style_details = {
            "modern": "sleek contemporary furniture, clean lines, neutral colors, minimalist design",
            "luxury": "high-end designer furniture, premium materials, elegant decor, sophisticated",
            "minimalist": "minimal furniture, clean aesthetic, simple design, uncluttered space",
            "scandinavian": "nordic design, light wood furniture, cozy textiles, hygge atmosphere",
            "traditional": "classic furniture, warm wood tones, traditional decor, timeless elegance",
            "industrial": "industrial style, exposed elements, metal and wood, urban loft aesthetic",
            "coastal": "beach house style, light colors, natural textures, relaxed coastal vibe",
            "bohemian": "eclectic boho style, colorful textiles, plants, artistic decor",
        }
        
        room_details = {
            "living_room": "living room with comfortable sofa, coffee table, stylish lighting, area rug",
            "bedroom": "bedroom with elegant bed, nightstands, soft bedding, ambient lighting",
            "kitchen": "kitchen with modern appliances, organized countertops, stylish fixtures",
            "bathroom": "bathroom with clean fixtures, organized vanity, fresh towels",
            "dining_room": "dining room with dining table, chairs, centerpiece, ambient lighting",
            "office": "home office with desk, ergonomic chair, organized workspace, good lighting",
        }
        
        style_desc = style_details.get(style, style_details["modern"])
        room_desc = room_details.get(room_type, room_details["living_room"])
        
        return (
            f"professional real estate photography, {room_desc}, {style_desc}, "
            f"interior design magazine quality, perfectly staged, warm inviting atmosphere, "
            f"natural lighting, high resolution, 8k quality, photorealistic"
        )
    
    def _build_staging_negative_prompt(self) -> str:
        """Build negative prompt for staging."""
        return (
            "empty room, unfurnished, construction, renovation, messy, cluttered, "
            "low quality, blurry, distorted, ugly, deformed, cartoon, illustration, "
            "painting, drawing, watermark, text, logo, people, animals, outdoors"
        )


# === Factory and Global Instance ===

def create_runpod_a1111_client(
    api_key: Optional[str] = None,
    endpoint_id: Optional[str] = None
) -> RunPodA1111Client:
    """Factory function to create RunPod A1111 client."""
    return RunPodA1111Client(api_key=api_key, endpoint_id=endpoint_id)


# Global default instance
runpod_a1111_client = RunPodA1111Client()
