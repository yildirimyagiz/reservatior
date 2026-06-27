"""
app/ai/staging_pipeline.py
Virtual staging pipeline using AI

Priority order:
1. A1111 (Automatic1111 SD WebUI) - FREE, LOCAL
2. ComfyUI (Local) - If A1111 not available
3. RunPod (Cloud) - Fallback for scaling
"""

from typing import Dict, List, Optional
import logging
import base64
import os
from pathlib import Path
from pydantic import BaseModel

from app.core.config import settings


class StagingInput(BaseModel):
    image_url: str
    room_type: str = "living_room"
    style: str = "modern"
    prompt_override: Optional[str] = None


class StagingOutput(BaseModel):
    original_url: str
    staged_url: str
    status: str
    engine: str = "a1111"  # Which engine was used


logger = logging.getLogger(__name__)


class StagingPipeline:
    """
    Virtual staging pipeline - transforms empty rooms into furnished spaces.
    
    Uses A1111 (Automatic1111) as the primary engine (free, local).
    Falls back to ComfyUI or RunPod if A1111 is not available.
    """
    
    STAGING_PROMPTS = {
        "modern": {
            "living_room": "modern minimalist living room, sleek furniture, neutral colors, scandinavian design",
            "bedroom": "modern bedroom with platform bed, minimalist design, clean aesthetic",
            "kitchen": "modern kitchen, white cabinets, marble countertops, stainless steel appliances",
            "bathroom": "modern bathroom, floating vanity, walk-in shower, white tiles",
            "dining_room": "modern dining room, rectangular table, contemporary chairs",
            "office": "modern home office, ergonomic desk setup, clean workspace",
        },
        "luxury": {
            "living_room": "luxury living room, premium leather sofa, marble table, crystal chandelier",
            "bedroom": "luxury master bedroom, king bed, silk bedding, tufted headboard",
            "kitchen": "luxury gourmet kitchen, custom cabinetry, high-end appliances, granite",
            "bathroom": "luxury spa bathroom, freestanding tub, rain shower, marble walls",
            "dining_room": "luxury formal dining room, grand table, crystal chandelier",
            "office": "luxury executive office, mahogany desk, leather chair, built-in shelving",
        },
        "minimalist": {
            "living_room": "minimalist living room, essential furniture only, clean lines, white space",
            "bedroom": "minimalist bedroom, simple bed frame, neutral tones, uncluttered",
            "kitchen": "minimalist kitchen, handleless cabinets, clean counters",
            "bathroom": "minimalist bathroom, simple fixtures, white aesthetic",
            "dining_room": "minimalist dining room, simple table and chairs",
            "office": "minimalist office, clean desk, essential items only",
        },
        "scandinavian": {
            "living_room": "scandinavian living room, light wood furniture, cozy textiles, hygge",
            "bedroom": "scandinavian bedroom, light colors, natural materials, cozy blankets",
            "kitchen": "scandinavian kitchen, light wood, white cabinets, functional design",
            "bathroom": "scandinavian bathroom, clean lines, natural materials",
            "dining_room": "scandinavian dining room, light wood table, simple chairs",
            "office": "scandinavian home office, light wood desk, plants",
        },
        "industrial": {
            "living_room": "industrial loft living room, exposed brick wall, black leather chesterfield sofa, reclaimed wood coffee table, metal accents, Edison bulb pendant lights",
            "bedroom": "industrial bedroom, iron bed frame, exposed brick, vintage metal nightstand, warehouse windows, Edison lighting",
            "kitchen": "industrial kitchen, open shelving, stainless steel, concrete countertops, subway tile, pendant metal lights",
            "bathroom": "industrial bathroom, exposed pipes, concrete walls, metal fixtures, vintage mirror",
            "dining_room": "industrial dining room, reclaimed wood table, metal chairs, pendant Edison lights, exposed ductwork",
            "office": "industrial office, metal desk, leather task chair, pipe shelving, exposed brick, vintage accessories",
        },
        "mid-century-modern": {
            "living_room": "mid-century modern living room, teak sideboard, mustard velvet armchair, tapered legs, geometric rug, arc floor lamp",
            "bedroom": "mid-century modern bedroom, walnut bed frame, tapered legs, retro nightstands, organic curves, bold accent colors",
            "kitchen": "mid-century modern kitchen, two-tone cabinets, bold backsplash, retro appliances, warm wood accents",
            "bathroom": "mid-century modern bathroom, bold tile patterns, walnut vanity, brass fixtures, retro mirror",
            "dining_room": "mid-century modern dining room, oval tulip table, molded chairs, teak sideboard, Sputnik chandelier",
            "office": "mid-century modern office, walnut writing desk, Eames chair, globe lamp, retro organizers",
        },
        "contemporary": {
            "living_room": "contemporary living room, modular sofa, bold statement art, track lighting, mixed textures, blue and grey accents",
            "bedroom": "contemporary bedroom, upholstered bed, geometric headboard, mixed materials, neutral palette with bold accent",
            "kitchen": "contemporary kitchen, waterfall island, integrated appliances, mixed materials, dramatic lighting",
            "bathroom": "contemporary bathroom, floating vanity, large format tiles, frameless shower, backlit mirror",
            "dining_room": "contemporary dining room, sculptural table, mixed chair styles, dramatic pendant light",
            "office": "contemporary office, floating desk, statement shelving, mixed materials, bold art",
        },
        "bohemian": {
            "living_room": "bohemian living room, eclectic patterns, layered textiles, rattan furniture, macrame, indoor plants, colorful cushions",
            "bedroom": "bohemian bedroom, canopy bed, layered rugs, colorful throws, hanging plants, macrame wall art",
            "kitchen": "bohemian kitchen, open shelving with ceramics, patterned tiles, hanging plants, woven baskets",
            "bathroom": "bohemian bathroom, patterned floor tiles, woven baskets, plants, vintage mirror, wooden elements",
            "dining_room": "bohemian dining room, mismatched chairs, colorful table runner, hanging plants, woven pendant light",
            "office": "bohemian home office, rattan desk, colorful accessories, wall tapestry, plants, cozy textiles",
        },
    }

    
    def __init__(self):
        self._a1111_client = None
        self._runpod_a1111_client = None
        self._local_comfy_client = None
        self._vps_comfy_client = None
        self._runpod_client = None
    
    @property
    def a1111_client(self):
        """Lazy load A1111 client."""
        if self._a1111_client is None:
            from app.ai.a1111_client import a1111_client
            self._a1111_client = a1111_client
        return self._a1111_client
    
    @property
    def runpod_a1111_client(self):
        """Lazy load RunPod A1111 client (cloud-hosted A1111)."""
        if self._runpod_a1111_client is None:
            from app.ai.runpod_a1111_client import runpod_a1111_client
            self._runpod_a1111_client = runpod_a1111_client
        return self._runpod_a1111_client
    
    @property
    def local_comfy_client(self):
        """Lazy load ComfyUI client."""
        if self._local_comfy_client is None:
            from app.ai.local_comfy_client import local_comfy_client
            self._local_comfy_client = local_comfy_client
        return self._local_comfy_client
    
    @property
    def vps_comfy_client(self):
        """Lazy load VPS ComfyUI client."""
        if self._vps_comfy_client is None:
            from app.ai.local_comfy_client import local_comfy_client
            # Create a separate instance for VPS
            self._vps_comfy_client = local_comfy_client
        return self._vps_comfy_client
    
    @property
    def runpod_client(self):
        """Lazy load RunPod client."""
        if self._runpod_client is None:
            from app.ai.runpod_client import runpod_client
            self._runpod_client = runpod_client
        return self._runpod_client
    
    async def get_available_engine(self) -> str:
        """
        Determine which engine is available.
        
        Priority:
        1. Local A1111 (free)
        2. RunPod A1111 (cloud, pay-per-use)
        3. VPS ComfyUI (remote, dedicated)
        4. Local ComfyUI (free)
        5. RunPod ComfyUI (cloud, pay-per-use)
        """
        # Check local A1111 first (primary, free)
        if settings.A1111_HOST:
            health = await self.a1111_client.health_check()
            if health.get("status") == "healthy":
                return "a1111"
        
        # Check RunPod A1111 second (cloud A1111)
        if settings.RUNPOD_API_KEY and getattr(settings, 'RUNPOD_A1111_ENDPOINT_ID', ''):
            health = await self.runpod_a1111_client.health_check()
            if health.get("status") == "healthy":
                return "runpod_a1111"
        
        # Check VPS ComfyUI third (remote dedicated instance)
        if getattr(settings, 'VPS_COMFY_HOST', ''):
            return "vps_comfyui"
        
        # Check local ComfyUI fourth
        if settings.COMFY_HOST:
            return "comfyui"
        
        # Check RunPod ComfyUI last (cloud)
        if settings.RUNPOD_API_KEY and settings.RUNPOD_ENDPOINT_ID:
            return "runpod"
        
        return "none"
    
    async def stage_image(
        self, 
        image_path: str, 
        room_type: str, 
        style: str,
        denoising_strength: float = 0.55,
        engine: Optional[str] = None
    ) -> str:
        """
        Stage a single image.
        
        Args:
            image_path: Path to the input image
            room_type: Type of room (living_room, bedroom, etc.)
            style: Design style (modern, luxury, etc.)
            denoising_strength: How much to change (0.4-0.7 recommended)
            engine: Force specific engine (a1111, comfyui, runpod)
            
        Returns:
            Path or URL to the staged image
        """
        # Get prompt
        prompt = self.STAGING_PROMPTS.get(style, {}).get(room_type, "furnished room")
        full_prompt = f"{prompt}, professional real estate photography, high resolution, 8k"
        
        # Determine engine
        if engine is None:
            engine = await self.get_available_engine()
        
        logger.info(f"Staging image with engine: {engine}")
        
        try:
            if engine == "a1111":
                return await self._stage_with_a1111(image_path, full_prompt, room_type, style, denoising_strength)
            elif engine == "runpod_a1111":
                return await self._stage_with_runpod_a1111(image_path, room_type, style, denoising_strength)
            elif engine == "vps_comfyui":
                return await self._stage_with_vps_comfyui(image_path, full_prompt, denoising_strength)
            elif engine == "comfyui":
                return await self._stage_with_comfyui(image_path, full_prompt, denoising_strength)
            elif engine == "runpod":
                return await self._stage_with_runpod(image_path, full_prompt)
            else:
                logger.warning("No staging engine available. Returning original image.")
                return image_path
                
        except Exception as e:
            logger.error(f"Staging failed: {e}")
            return image_path
    
    async def _stage_with_a1111(
        self, 
        image_path: str, 
        prompt: str,
        room_type: str,
        style: str,
        denoising_strength: float
    ) -> str:
        """Stage using A1111 (Automatic1111)."""
        logger.info(f"Staging with A1111: {image_path}")
        
        # Use the high-level staging method
        result = await self.a1111_client.stage_room(
            image_path=image_path,
            room_type=room_type,
            style=style,
            denoising_strength=denoising_strength
        )
        
        if result.is_success and result.images:
            # Save the result image
            output_path = await self._save_staged_image(result.images[0], image_path)
            return output_path
        
        logger.error(f"A1111 staging failed: {result.error}")
        return image_path
    
    async def _stage_with_runpod_a1111(
        self, 
        image_path: str, 
        room_type: str,
        style: str,
        denoising_strength: float
    ) -> str:
        """Stage using RunPod A1111 (cloud-hosted Automatic1111)."""
        logger.info(f"Staging with RunPod A1111: {image_path}")
        
        # Load image as base64
        image_base64 = await self._load_image_as_base64(image_path)
        
        # Use the high-level staging method
        result = await self.runpod_a1111_client.stage_room(
            image_base64=image_base64,
            room_type=room_type,
            style=style,
            denoising_strength=denoising_strength
        )
        
        if result.is_success and result.images:
            # Save the result image
            output_path = await self._save_staged_image(result.images[0], image_path)
            logger.info(f"RunPod A1111 cost estimate: ${result.cost_estimate_usd:.4f}")
            return output_path
        
        logger.error(f"RunPod A1111 staging failed: {result.error}")
        return image_path
    
    async def _load_image_as_base64(self, file_path: str) -> str:
        """Load an image file and convert to base64."""
        path = Path(file_path)
        if not path.exists():
            raise FileNotFoundError(f"Image not found: {file_path}")
        
        with open(path, "rb") as f:
            image_data = f.read()
        
        return base64.b64encode(image_data).decode("utf-8")
    
    async def _stage_with_vps_comfyui(self, image_path: str, prompt: str, denoising_strength: float = 0.55) -> str:
        """Stage using VPS ComfyUI (remote instance on Hostinger)."""
        logger.info(f"Staging with VPS ComfyUI: {image_path}")
        
        from app.ai.comfy_workflow import comfy_workflow_manager
        
        # Override COMFY_HOST temporarily for VPS connection
        original_host = settings.COMFY_HOST
        settings.COMFY_HOST = settings.VPS_COMFY_HOST
        
        try:
            workflow_payload = comfy_workflow_manager.prepare_workflow(
                input_image_path=image_path,
                prompt=prompt,
                denoising_strength=denoising_strength
            )
            
            result = await self.vps_comfy_client.run_sync(
                workflow_json=workflow_payload["workflow"],
                images=workflow_payload.get("images", [])
            )
            
            if result.get("images"):
                return result["images"][0]
            if result.get("status") == "mock_success":
                return result["images"][0]
            
            return image_path
        finally:
            # Restore original host
            settings.COMFY_HOST = original_host
    
    async def _stage_with_comfyui(self, image_path: str, prompt: str, denoising_strength: float = 0.55) -> str:
        """Stage using local ComfyUI."""
        logger.info(f"Staging with ComfyUI: {image_path}")
        
        from app.ai.comfy_workflow import comfy_workflow_manager
        
        workflow_payload = comfy_workflow_manager.prepare_workflow(
            input_image_path=image_path,
            prompt=prompt,
            denoising_strength=denoising_strength
        )
        
        result = await self.local_comfy_client.run_sync(
            workflow_json=workflow_payload["workflow"],
            images=workflow_payload.get("images", [])
        )
        
        if result.get("images"):
            return result["images"][0]
        if result.get("status") == "mock_success":
            return result["images"][0]
        
        return image_path
    
    async def _stage_with_runpod(self, image_path: str, prompt: str) -> str:
        """Stage using RunPod (cloud)."""
        logger.info(f"Staging with RunPod: {image_path}")
        
        from app.ai.comfy_workflow import comfy_workflow_manager
        
        workflow_payload = comfy_workflow_manager.prepare_workflow(
            input_image_path=image_path,
            prompt=prompt
        )
        
        result = await self.runpod_client.run_sync(workflow_payload)
        
        if hasattr(result, 'images') and result.images:
            return result.images[0]
        
        return image_path
    
    async def _save_staged_image(self, base64_image: str, original_path: str) -> str:
        """Save base64 image to disk and return the path."""
        # Determine output path
        original = Path(original_path)
        output_dir = Path(settings.IMAGE_DIR) / "staged"
        output_dir.mkdir(parents=True, exist_ok=True)
        
        output_filename = f"{original.stem}_staged{original.suffix or '.png'}"
        output_path = output_dir / output_filename
        
        # Decode and save
        try:
            image_data = base64.b64decode(base64_image)
            with open(output_path, "wb") as f:
                f.write(image_data)
            
            logger.info(f"Saved staged image: {output_path}")
            return str(output_path)
        except Exception as e:
            logger.error(f"Failed to save staged image: {e}")
            return original_path
    
    async def batch_stage(
        self,
        images: List[Dict[str, str]],
        style: str = "modern",
        denoising_strength: float = 0.55
    ) -> List[StagingOutput]:
        """
        Stage multiple images.
        
        Args:
            images: List of {"path": "...", "room_type": "..."}
            style: Design style to apply
            
        Returns:
            List of StagingOutput results
        """
        results = []
        engine = await self.get_available_engine()
        
        for img in images:
            staged_path = await self.stage_image(
                image_path=img["path"],
                room_type=img.get("room_type", "living_room"),
                style=style,
                denoising_strength=denoising_strength,
                engine=engine
            )
            
            results.append(StagingOutput(
                original_url=img["path"],
                staged_url=staged_path,
                status="success" if staged_path != img["path"] else "failed",
                engine=engine
            ))
        
        return results


# Global instance
staging_pipeline = StagingPipeline()
