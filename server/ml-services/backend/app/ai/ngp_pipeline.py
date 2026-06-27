"""
app/ai/ngp_pipeline.py
InstantNGP (Instant Neural Graphics Primitives) Pipeline

Lightweight 3D reconstruction engine for real estate walkthroughs.
This is the DEFAULT paid walkthrough engine - optimized for:
- Fast training (~5-10 minutes)
- Good quality output
- Reasonable GPU cost
- Room-to-room continuity

Integration approaches:
1. Local: NVIDIA InstantNGP (requires CUDA GPU)
2. Cloud: Replicate API with NGP models
3. Hybrid: Local preprocessing + cloud rendering
"""

import asyncio
import logging
import numpy as np
from pathlib import Path
from typing import List, Dict, Optional, Tuple
from dataclasses import dataclass
import json
import tempfile

from app.core.config import settings
from app.core.exceptions import MediaProcessingError

logger = logging.getLogger(__name__)


@dataclass
class NGPCameraPath:
    """Camera path for NGP rendering"""
    keyframes: List[Dict]  # Position, rotation, fov per keyframe
    duration: float
    fps: int = 30
    interpolation: str = "smooth_spline"  # linear, smooth_spline, bezier


@dataclass  
class NGPRenderConfig:
    """Rendering configuration for NGP"""
    resolution: Tuple[int, int] = (1920, 1080)
    steps: int = 10000  # Training iterations
    ray_samples: int = 64
    background: str = "white"
    exposure: float = 1.0
    focal_length: float = 35.0


class InstantNGPPipeline:
    """
    InstantNGP-based walkthrough generation pipeline.
    
    Features:
    - Lightweight 3D scene reconstruction
    - Room-to-room camera path planning
    - Fast training with hash encoding
    - High-quality novel view synthesis
    """
    
    # Cost per training step (approximate)
    COST_PER_STEP = 0.000025  # ~$0.25 for 10k steps
    
    # Training steps by quality
    QUALITY_STEPS = {
        "preview": 5000,
        "standard": 10000,
        "high": 20000,
        "ultra": 30000,
    }
    
    def __init__(self):
        """Initialize the NGP pipeline"""
        self.output_dir = Path(settings.VIDEO_DIR) / "ngp"
        self.output_dir.mkdir(parents=True, exist_ok=True)
        self.cache_dir = Path(settings.CACHE_DIR) / "ngp"
        self.cache_dir.mkdir(parents=True, exist_ok=True)
        
        # Check if local NGP is available
        self._local_ngp_available = self._check_local_ngp()
        
        logger.info(f"NGP Pipeline initialized. Local: {self._local_ngp_available}")
    
    def _check_local_ngp(self) -> bool:
        """Check if local InstantNGP is available"""
        try:
            # In production, would check for CUDA and NGP bindings
            import subprocess
            result = subprocess.run(
                ["nvidia-smi", "--query-gpu=name", "--format=csv,noheader"],
                capture_output=True,
                text=True,
                timeout=5
            )
            return result.returncode == 0
        except Exception:
            return False
    
    async def generate_walkthrough(
        self,
        image_paths: List[str],
        room_analyses: List[Dict],
        output_path: str,
        quality: str = "standard",
        camera_style: str = "smooth_tour"
    ) -> str:
        """
        Generate a walkthrough video from images using InstantNGP.
        
        Args:
            image_paths: List of source image paths
            room_analyses: Scene analysis results from Detectron2
            output_path: Where to save the output video
            quality: Quality preset (preview, standard, high, ultra)
            camera_style: Camera movement style
            
        Returns:
            Path to generated video
        """
        logger.info(f"Starting NGP walkthrough: {len(image_paths)} images, quality={quality}")
        
        try:
            # Step 1: Prepare training data (COLMAP-style poses)
            training_data = await self._prepare_training_data(
                image_paths, 
                room_analyses
            )
            
            # Step 2: Train the NGP model
            model_path = await self._train_ngp_model(
                training_data,
                steps=self.QUALITY_STEPS.get(quality, 10000)
            )
            
            # Step 3: Generate camera path
            camera_path = self._generate_camera_path(
                room_analyses,
                style=camera_style
            )
            
            # Step 4: Render video frames
            frames_dir = await self._render_frames(
                model_path,
                camera_path
            )
            
            # Step 5: Encode to video
            video_path = await self._encode_video(
                frames_dir,
                output_path
            )
            
            logger.info(f"NGP walkthrough generated: {video_path}")
            return video_path
            
        except Exception as e:
            logger.error(f"NGP pipeline failed: {e}", exc_info=True)
            raise MediaProcessingError(f"NGP walkthrough generation failed: {e}")
    
    async def _prepare_training_data(
        self,
        image_paths: List[str],
        room_analyses: List[Dict]
    ) -> Dict:
        """
        Prepare training data for NGP.
        Creates COLMAP-compatible camera poses and image mappings.
        """
        # In production, would run COLMAP or use pre-computed poses
        # For now, generate synthetic poses based on room layout
        
        transforms = {
            "camera_angle_x": 1.0,
            "camera_angle_y": 0.75,
            "fl_x": 1200,
            "fl_y": 1200,
            "cx": 960,
            "cy": 540,
            "w": 1920,
            "h": 1080,
            "frames": []
        }
        
        for i, (path, analysis) in enumerate(zip(image_paths, room_analyses)):
            # Generate pose based on room position
            angle = (i / len(image_paths)) * 2 * np.pi
            radius = 3.0
            
            # Camera position on a circular path
            x = radius * np.cos(angle)
            z = radius * np.sin(angle)
            y = 1.5  # Eye height
            
            # Look at center
            transform_matrix = self._look_at_matrix(
                eye=[x, y, z],
                target=[0, 1.5, 0],
                up=[0, 1, 0]
            )
            
            frames_entry = {
                "file_path": path,
                "transform_matrix": transform_matrix.tolist(),
                "room_type": analysis.get("room_type", "unknown"),
                "importance": analysis.get("importance_score", 5)
            }
            transforms["frames"].append(frames_entry)
        
        # Save transforms
        transforms_path = self.cache_dir / f"transforms_{hash(tuple(image_paths))}.json"
        with open(transforms_path, "w") as f:
            json.dump(transforms, f, indent=2)
        
        return {
            "transforms_path": str(transforms_path),
            "image_count": len(image_paths),
            "transforms": transforms
        }
    
    def _look_at_matrix(
        self,
        eye: List[float],
        target: List[float],
        up: List[float]
    ) -> np.ndarray:
        """Create a look-at transformation matrix"""
        eye = np.array(eye)
        target = np.array(target)
        up = np.array(up)
        
        forward = target - eye
        forward = forward / np.linalg.norm(forward)
        
        right = np.cross(forward, up)
        right = right / np.linalg.norm(right)
        
        new_up = np.cross(right, forward)
        
        matrix = np.eye(4)
        matrix[0, :3] = right
        matrix[1, :3] = new_up
        matrix[2, :3] = -forward
        matrix[:3, 3] = eye
        
        return matrix
    
    async def _train_ngp_model(
        self,
        training_data: Dict,
        steps: int
    ) -> str:
        """
        Train the InstantNGP model on the scene.
        
        In production, this would:
        1. Call local NGP binary if available
        2. Or use Replicate API for cloud training
        """
        logger.info(f"Training NGP model: {steps} steps")
        
        model_id = f"ngp_model_{hash(training_data['transforms_path'])}"
        model_path = self.cache_dir / f"{model_id}.ingp"
        
        if self._local_ngp_available:
            # Local training (simulated)
            await self._train_local(training_data, model_path, steps)
        else:
            # Cloud training via Replicate (simulated)
            await self._train_cloud(training_data, model_path, steps)
        
        # Simulate training time based on steps
        training_time = steps / 1000 * 0.5  # ~0.5s per 1000 steps (accelerated)
        await asyncio.sleep(min(training_time, 5.0))  # Cap at 5s for demo
        
        return str(model_path)
    
    async def _train_local(
        self,
        training_data: Dict,
        model_path: Path,
        steps: int
    ):
        """Train using local NGP binary"""
        # In production: subprocess call to instant-ngp
        logger.info(f"Local NGP training: {steps} steps -> {model_path}")
        
        # Placeholder: create dummy model file
        model_path.write_text(json.dumps({
            "type": "instant-ngp",
            "steps": steps,
            "image_count": training_data["image_count"]
        }))
    
    async def _train_cloud(
        self,
        training_data: Dict,
        model_path: Path,
        steps: int
    ):
        """Train using cloud API (Replicate)"""
        logger.info(f"Cloud NGP training: {steps} steps")
        
        # In production: call Replicate API
        # from app.ai.replicate_client import replicate_client
        # result = await replicate_client.run_ngp_training(...)
        
        model_path.write_text(json.dumps({
            "type": "instant-ngp-cloud",
            "steps": steps,
            "image_count": training_data["image_count"]
        }))
    
    def _generate_camera_path(
        self,
        room_analyses: List[Dict],
        style: str = "smooth_tour",
        duration_per_room: float = 3.5
    ) -> NGPCameraPath:
        """
        Generate camera path for the walkthrough.
        
        Styles:
        - smooth_tour: Gentle continuous movement
        - showcase: Pause at key rooms
        - cinematic: Dramatic angles and movements
        """
        keyframes = []
        
        # Sort rooms by importance
        sorted_rooms = sorted(
            room_analyses, 
            key=lambda r: r.get("importance_score", 5),
            reverse=True
        )
        
        total_duration = len(sorted_rooms) * duration_per_room
        
        for i, room in enumerate(sorted_rooms):
            t = i / max(len(sorted_rooms) - 1, 1)
            angle = t * 2 * np.pi * 0.8  # Slightly less than full circle
            
            # Position based on room importance
            importance = room.get("importance_score", 5) / 10
            radius = 2.5 + importance * 1.0
            
            keyframe = {
                "time": i * duration_per_room,
                "position": {
                    "x": radius * np.cos(angle),
                    "y": 1.5 + np.sin(t * np.pi) * 0.3,  # Slight vertical motion
                    "z": radius * np.sin(angle)
                },
                "rotation": {
                    "yaw": -np.degrees(angle) + 90,
                    "pitch": -5 if style == "cinematic" else 0,
                    "roll": 0
                },
                "fov": 60 if style == "showcase" else 55,
                "room_type": room.get("room_type", "unknown")
            }
            
            keyframes.append(keyframe)
        
        return NGPCameraPath(
            keyframes=keyframes,
            duration=total_duration,
            fps=30,
            interpolation="smooth_spline" if style != "cinematic" else "bezier"
        )
    
    async def _render_frames(
        self,
        model_path: str,
        camera_path: NGPCameraPath,
        resolution: Tuple[int, int] = (1920, 1080)
    ) -> str:
        """
        Render frames from the trained NGP model.
        """
        frames_dir = tempfile.mkdtemp(prefix="ngp_frames_")
        total_frames = int(camera_path.duration * camera_path.fps)
        
        logger.info(f"Rendering {total_frames} frames at {resolution}")
        
        # In production: Call NGP render command
        # For now, simulate frame rendering
        for i in range(min(total_frames, 10)):  # Limit for demo
            frame_path = Path(frames_dir) / f"frame_{i:05d}.png"
            
            # Create placeholder frame
            # In production: NGP would render actual frames
            frame_path.touch()
        
        return frames_dir
    
    async def _encode_video(
        self,
        frames_dir: str,
        output_path: str,
        fps: int = 30
    ) -> str:
        """
        Encode rendered frames to video using FFmpeg.
        """
        import subprocess
        
        output_path = Path(output_path)
        output_path.parent.mkdir(parents=True, exist_ok=True)
        
        # FFmpeg command
        cmd = [
            "ffmpeg", "-y",
            "-framerate", str(fps),
            "-i", f"{frames_dir}/frame_%05d.png",
            "-c:v", "libx264",
            "-preset", "medium",
            "-crf", "23",
            "-pix_fmt", "yuv420p",
            str(output_path)
        ]
        
        try:
            # In production: run actual ffmpeg
            logger.info(f"Encoding video: {output_path}")
            
            # For demo: create placeholder video
            output_path.touch()
            
            return str(output_path)
            
        except Exception as e:
            logger.error(f"Video encoding failed: {e}")
            raise MediaProcessingError(f"Video encoding failed: {e}")
    
    def estimate_cost(
        self,
        image_count: int,
        quality: str = "standard"
    ) -> float:
        """
        Estimate GPU cost for NGP processing.
        
        Returns:
            Estimated cost in USD
        """
        steps = self.QUALITY_STEPS.get(quality, 10000)
        training_cost = steps * self.COST_PER_STEP
        
        # Rendering cost (per image base + per frame)
        render_cost = 0.02 + image_count * 0.01
        
        return training_cost + render_cost


# Global singleton
ngp_pipeline = InstantNGPPipeline()
