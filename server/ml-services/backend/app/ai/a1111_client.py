"""
Automatic1111 Stable Diffusion WebUI API Client.

A free, local alternative to ComfyUI/RunPod for virtual staging.
Connects to http://127.0.0.1:7860/sdapi/v1/

Start A1111 with: ./webui.sh --api
"""

import aiohttp
import asyncio
import base64
import logging
import io
from pathlib import Path
from typing import Dict, Any, List, Optional
from dataclasses import dataclass, field
from enum import Enum

from app.core.config import settings

logger = logging.getLogger(__name__)


class A1111JobStatus(Enum):
    """Job status enumeration."""
    PENDING = "PENDING"
    IN_PROGRESS = "IN_PROGRESS"
    COMPLETED = "COMPLETED"
    FAILED = "FAILED"


@dataclass
class A1111Result:
    """Result container for A1111 jobs."""
    status: A1111JobStatus
    images: List[str] = field(default_factory=list)  # Base64 encoded images
    image_urls: List[str] = field(default_factory=list)  # Local file paths if saved
    parameters: Dict[str, Any] = field(default_factory=dict)
    error: Optional[str] = None
    
    @property
    def is_success(self) -> bool:
        return self.status == A1111JobStatus.COMPLETED and len(self.images) > 0


class A1111Client:
    """
    Client for Automatic1111 Stable Diffusion WebUI API.
    
    Features:
    - txt2img: Text to image generation
    - img2img: Image to image transformation (used for staging)
    - Inpainting: Add/modify specific areas
    - ControlNet: Structure preservation (if extension installed)
    
    Usage:
        client = A1111Client()
        result = await client.img2img(
            image_path="empty_room.jpg",
            prompt="modern furnished living room",
            denoising_strength=0.65
        )
    """
    
    def __init__(
        self,
        host: Optional[str] = None,
        timeout_seconds: int = 120,
    ):
        # Use config or default
        host = host or settings.A1111_HOST or "127.0.0.1:7860"
        if not host.startswith("http"):
            host = f"http://{host}"
        self.base_url = host
        self.timeout = aiohttp.ClientTimeout(total=timeout_seconds)
        
    @property
    def api_url(self) -> str:
        return f"{self.base_url}/sdapi/v1"
    
    def is_configured(self) -> bool:
        """Check if the server URL is set."""
        return bool(self.base_url)
    
    async def health_check(self) -> Dict[str, Any]:
        """
        Check if A1111 is running and get system info.
        Returns: {"status": "healthy", "model": "...", "vram": ...}
        """
        try:
            async with aiohttp.ClientSession(timeout=aiohttp.ClientTimeout(total=5)) as session:
                # Check basic connectivity
                async with session.get(f"{self.api_url}/sd-models") as resp:
                    if resp.status != 200:
                        return {"status": "unhealthy", "error": f"HTTP {resp.status}"}
                    models = await resp.json()
                    
                # Get current options
                async with session.get(f"{self.api_url}/options") as resp:
                    options = await resp.json() if resp.status == 200 else {}
                
                return {
                    "status": "healthy",
                    "model": options.get("sd_model_checkpoint", "unknown"),
                    "models_available": len(models),
                    "url": self.base_url
                }
        except aiohttp.ClientConnectorError:
            return {"status": "offline", "error": "Cannot connect to A1111. Is it running with --api flag?"}
        except Exception as e:
            logger.error(f"A1111 health check failed: {e}")
            return {"status": "error", "error": str(e)}
    
    async def get_models(self) -> List[str]:
        """Get list of available checkpoint models."""
        try:
            async with aiohttp.ClientSession(timeout=self.timeout) as session:
                async with session.get(f"{self.api_url}/sd-models") as resp:
                    if resp.status == 200:
                        models = await resp.json()
                        return [m.get("title", m.get("model_name", "")) for m in models]
                    return []
        except Exception as e:
            logger.error(f"Failed to get models: {e}")
            return []
    
    async def get_samplers(self) -> List[str]:
        """Get list of available samplers."""
        try:
            async with aiohttp.ClientSession(timeout=self.timeout) as session:
                async with session.get(f"{self.api_url}/samplers") as resp:
                    if resp.status == 200:
                        samplers = await resp.json()
                        return [s.get("name", "") for s in samplers]
                    return []
        except Exception as e:
            logger.error(f"Failed to get samplers: {e}")
            return []
    
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
    ) -> A1111Result:
        """
        Generate images from text prompt.
        """
        payload = {
            "prompt": prompt,
            "negative_prompt": negative_prompt or "low quality, blurry, distorted, ugly, deformed",
            "width": width,
            "height": height,
            "steps": steps,
            "cfg_scale": cfg_scale,
            "sampler_name": sampler_name,
            "seed": seed,
            "batch_size": batch_size,
        }
        
        return await self._run_generation(f"{self.api_url}/txt2img", payload)
    
    async def img2img(
        self,
        init_image: str,  # Base64 encoded image or file path
        prompt: str,
        negative_prompt: str = "",
        denoising_strength: float = 0.65,
        width: int = 1024,
        height: int = 1024,
        steps: int = 25,
        cfg_scale: float = 7.0,
        sampler_name: str = "DPM++ 2M Karras",
        seed: int = -1,
        batch_size: int = 1,
        resize_mode: int = 1,  # 0=Just resize, 1=Crop and resize, 2=Resize and fill
    ) -> A1111Result:
        """
        Transform an existing image using img2img.
        This is the PRIMARY method for virtual staging.
        
        Args:
            init_image: Base64 encoded image OR file path
            prompt: Description of desired output
            denoising_strength: How much to change (0.0-1.0)
                - 0.3-0.5: Subtle changes, keeps most of original
                - 0.5-0.7: Moderate changes, good for staging
                - 0.7-0.9: Major changes
                
        Returns:
            A1111Result with generated images
        """
        # Handle file path input
        if not init_image.startswith("data:") and not self._is_base64(init_image):
            init_image = await self._load_image_as_base64(init_image)
        
        # Strip data URI prefix if present
        if init_image.startswith("data:"):
            init_image = init_image.split(",", 1)[1]
        
        payload = {
            "init_images": [init_image],
            "prompt": prompt,
            "negative_prompt": negative_prompt or "empty room, unfurnished, low quality, blurry, distorted",
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
        
        return await self._run_generation(f"{self.api_url}/img2img", payload)
    
    async def stage_room(
        self,
        image_path: str,
        room_type: str = "living_room",
        style: str = "modern",
        denoising_strength: float = 0.55,
        preserve_structure: bool = True,
    ) -> A1111Result:
        """
        High-level staging method optimized for real estate.
        
        Args:
            image_path: Path to empty room image
            room_type: Type of room (living_room, bedroom, kitchen, etc.)
            style: Design style (modern, luxury, minimalist, etc.)
            denoising_strength: How much to change (0.4-0.7 recommended)
            preserve_structure: If True, uses lower denoise to keep room shape
            
        Returns:
            A1111Result with staged images
        """
        # Build optimized prompt for staging
        prompt = self._build_staging_prompt(room_type, style)
        negative_prompt = self._build_staging_negative_prompt()
        
        # Adjust strength based on preservation
        if preserve_structure:
            denoising_strength = min(denoising_strength, 0.55)
        
        logger.info(f"Staging {room_type} in {style} style (strength: {denoising_strength})")
        
        return await self.img2img(
            init_image=image_path,
            prompt=prompt,
            negative_prompt=negative_prompt,
            denoising_strength=denoising_strength,
            steps=30,  # More steps for quality
            cfg_scale=7.5,
        )
    
    async def img2img_with_controlnet(
        self,
        init_image: str,
        prompt: str,
        controlnet_model: str = settings.CONTROLNET_DEPTH_MODEL,
        controlnet_weight: float = 0.8,
        denoising_strength: float = 0.75,
        **kwargs
    ) -> A1111Result:
        """
        img2img with ControlNet for structure preservation.
        Requires ControlNet extension installed in A1111.
        
        This is the BEST method for staging as it preserves room geometry.
        """
        # Handle file path input
        if not init_image.startswith("data:") and not self._is_base64(init_image):
            init_image = await self._load_image_as_base64(init_image)
        
        if init_image.startswith("data:"):
            init_image = init_image.split(",", 1)[1]
        
        payload = {
            "init_images": [init_image],
            "prompt": prompt,
            "negative_prompt": kwargs.get("negative_prompt", "low quality, blurry, distorted"),
            "denoising_strength": denoising_strength,
            "width": kwargs.get("width", 1024),
            "height": kwargs.get("height", 1024),
            "steps": kwargs.get("steps", 25),
            "cfg_scale": kwargs.get("cfg_scale", 7.0),
            "sampler_name": kwargs.get("sampler_name", "DPM++ 2M Karras"),
            "seed": kwargs.get("seed", -1),
            # ControlNet extension args
            "alwayson_scripts": {
                "controlnet": {
                    "args": [
                        {
                            "enabled": True,
                            "input_image": init_image,
                            "module": "depth_midas",  # Depth estimation
                            "model": controlnet_model,
                            "weight": controlnet_weight,
                            "resize_mode": 1,
                            "control_mode": 0,  # Balanced
                            "processor_res": 512,
                        }
                    ]
                }
            }
        }
        
        return await self._run_generation(f"{self.api_url}/img2img", payload)
    
    # === Private Methods ===
    
    async def _run_generation(self, url: str, payload: Dict[str, Any]) -> A1111Result:
        """Execute generation request and parse response."""
        try:
            async with aiohttp.ClientSession(timeout=self.timeout) as session:
                logger.info(f"Sending request to A1111: {url}")
                
                async with session.post(url, json=payload) as resp:
                    if resp.status != 200:
                        error_text = await resp.text()
                        logger.error(f"A1111 error: {error_text}")
                        return A1111Result(
                            status=A1111JobStatus.FAILED,
                            error=f"HTTP {resp.status}: {error_text}"
                        )
                    
                    data = await resp.json()
                    
                    # Extract images (base64 encoded)
                    images = data.get("images", [])
                    parameters = data.get("parameters", {})
                    
                    logger.info(f"A1111 generated {len(images)} image(s)")
                    
                    return A1111Result(
                        status=A1111JobStatus.COMPLETED,
                        images=images,
                        parameters=parameters
                    )
                    
        except asyncio.TimeoutError:
            logger.error("A1111 request timed out")
            return A1111Result(
                status=A1111JobStatus.FAILED,
                error="Request timed out"
            )
        except aiohttp.ClientConnectorError:
            logger.error("Cannot connect to A1111")
            return A1111Result(
                status=A1111JobStatus.FAILED,
                error="Cannot connect to A1111. Is it running with --api flag?"
            )
        except Exception as e:
            logger.error(f"A1111 request failed: {e}")
            return A1111Result(
                status=A1111JobStatus.FAILED,
                error=str(e)
            )
    
    async def _load_image_as_base64(self, file_path: str) -> str:
        """Load an image file and convert to base64."""
        path = Path(file_path)
        if not path.exists():
            raise FileNotFoundError(f"Image not found: {file_path}")
        
        with open(path, "rb") as f:
            image_data = f.read()
        
        return base64.b64encode(image_data).decode("utf-8")
    
    def _is_base64(self, s: str) -> bool:
        """Check if string is likely base64 encoded."""
        try:
            if len(s) < 100:  # Too short to be an image
                return False
            # Try to decode a small portion
            base64.b64decode(s[:100])
            return True
        except:
            return False
    
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
            "nursery": "nursery with crib, soft furnishings, gentle colors, cozy atmosphere",
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

def create_a1111_client(host: Optional[str] = None) -> A1111Client:
    """Factory function to create A1111 client."""
    return A1111Client(host=host)


# Global default instance
a1111_client = A1111Client()
