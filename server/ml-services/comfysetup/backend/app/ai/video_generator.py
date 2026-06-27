"""
app/ai/video_generator.py
REAL Video Generation from Photos - NOT a slideshow
Creates cinematic MP4 videos with camera motion, transitions, and effects
"""

import cv2
import numpy as np
from pathlib import Path
from typing import List, Dict, Tuple, Optional
import subprocess
import logging
from dataclasses import dataclass
from PIL import Image
import tempfile

from app.core.config import settings
from app.core.exceptions import MediaProcessingError

logger = logging.getLogger(__name__)


@dataclass
class SceneInfo:
    """Scene information for video generation"""
    image_path: str
    duration: float  # seconds
    room_type: str
    importance_score: float
    motion_type: str  # "pan", "zoom", "parallax", "static"
    start_pos: Tuple[float, float]
    end_pos: Tuple[float, float]
    zoom_factor: Tuple[float, float]


class CinematicVideoGenerator:
    """
    Generate REAL cinematic videos from photos
    Features:
    - Camera motion (pan, zoom, parallax)
    - Dynamic transitions
    - Adaptive pacing based on room importance
    - Multiple aspect ratios
    - Professional output quality
    """
    
    def __init__(
        self,
        fps: int = 30,
        output_size: Tuple[int, int] = (1920, 1080),
        bitrate: str = "5000k"
    ):
        self.fps = fps
        self.output_size = output_size
        self.bitrate = bitrate
        self.temp_dir = Path(tempfile.mkdtemp())
    
    def _load_and_preprocess_image(self, image_path: str) -> np.ndarray:
        """Load and preprocess image"""
        try:
            img = cv2.imread(image_path)
            if img is None:
                raise ValueError(f"Could not load image: {image_path}")
            
            # Convert to RGB
            img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
            
            return img
        except Exception as e:
            raise MediaProcessingError(f"Image preprocessing failed: {e}")
    
    def _apply_ken_burns_effect(
        self,
        img: np.ndarray,
        start_zoom: float,
        end_zoom: float,
        start_pos: Tuple[float, float],
        end_pos: Tuple[float, float],
        num_frames: int
    ) -> List[np.ndarray]:
        """
        Apply Ken Burns effect (pan + zoom)
        Creates smooth camera motion
        """
        frames = []
        h, w = img.shape[:2]
        
        for i in range(num_frames):
            t = i / max(num_frames - 1, 1)  # Interpolation factor
            
            # Interpolate zoom
            current_zoom = start_zoom + (end_zoom - start_zoom) * t
            
            # Interpolate position
            current_x = start_pos[0] + (end_pos[0] - start_pos[0]) * t
            current_y = start_pos[1] + (end_pos[1] - start_pos[1]) * t
            
            # Calculate crop dimensions
            crop_w = int(w / current_zoom)
            crop_h = int(h / current_zoom)
            
            # Calculate crop position
            x = int(current_x * (w - crop_w))
            y = int(current_y * (h - crop_h))
            
            # Ensure within bounds
            x = max(0, min(x, w - crop_w))
            y = max(0, min(y, h - crop_h))
            
            # Crop and resize
            cropped = img[y:y+crop_h, x:x+crop_w]
            resized = cv2.resize(cropped, self.output_size, interpolation=cv2.INTER_LANCZOS4)
            
            frames.append(resized)
        
        return frames
    
    def _apply_parallax_effect(
        self,
        img: np.ndarray,
        num_frames: int,
        intensity: float = 0.02
    ) -> List[np.ndarray]:
        """
        Apply parallax depth effect
        Simulates 3D camera movement
        """
        frames = []
        h, w = img.shape[:2]
        
        # Create depth map (simple center-focused)
        y, x = np.ogrid[:h, :w]
        cx, cy = w // 2, h // 2
        depth_map = np.sqrt((x - cx)**2 + (y - cy)**2)
        depth_map = 1 - (depth_map / depth_map.max())
        
        for i in range(num_frames):
            t = np.sin(i / num_frames * np.pi * 2) * intensity
            
            # Apply depth-based shift
            shift_x = (depth_map * t * w).astype(np.float32)
            shift_y = (depth_map * t * h).astype(np.float32)
            
            # Create shifted frame
            flow_x = np.tile(np.arange(w), (h, 1)).astype(np.float32) + shift_x
            flow_y = np.tile(np.arange(h).reshape(-1, 1), (1, w)).astype(np.float32) + shift_y
            
            frame = cv2.remap(img, flow_x, flow_y, cv2.INTER_LINEAR)
            frame = cv2.resize(frame, self.output_size, interpolation=cv2.INTER_LANCZOS4)
            
            frames.append(frame)
        
        return frames
    
    def _create_transition(
        self,
        frame1: np.ndarray,
        frame2: np.ndarray,
        num_frames: int = 15,
        transition_type: str = "crossfade"
    ) -> List[np.ndarray]:
        """
        Create smooth transition between scenes
        """
        frames = []
        
        if transition_type == "crossfade":
            for i in range(num_frames):
                alpha = i / num_frames
                blended = cv2.addWeighted(frame1, 1 - alpha, frame2, alpha, 0)
                frames.append(blended)
        
        elif transition_type == "slide":
            for i in range(num_frames):
                t = i / num_frames
                offset = int(self.output_size[0] * t)
                
                canvas = np.zeros((*self.output_size[::-1], 3), dtype=np.uint8)
                
                # Slide out frame1
                if offset < self.output_size[0]:
                    canvas[:, :self.output_size[0]-offset] = frame1[:, offset:]
                
                # Slide in frame2
                canvas[:, self.output_size[0]-offset:] = frame2[:, :offset]
                
                frames.append(canvas)
        
        elif transition_type == "zoom":
            for i in range(num_frames):
                t = i / num_frames
                # Zoom out frame1, zoom in frame2
                scale1 = 1 + t * 0.2
                scale2 = 0.8 + t * 0.2
                
                # Scale frames
                h, w = frame1.shape[:2]
                scaled1 = cv2.resize(frame1, None, fx=scale1, fy=scale1)
                scaled2 = cv2.resize(frame2, None, fx=scale2, fy=scale2)
                
                # Center crop
                y1 = (scaled1.shape[0] - h) // 2
                x1 = (scaled1.shape[1] - w) // 2
                cropped1 = scaled1[y1:y1+h, x1:x1+w]
                
                y2 = (scaled2.shape[0] - h) // 2
                x2 = (scaled2.shape[1] - w) // 2
                cropped2 = scaled2[y2:y2+h, x2:x2+w]
                
                # Blend
                blended = cv2.addWeighted(cropped1, 1 - t, cropped2, t, 0)
                frames.append(blended)
        
        return frames
    
    async def generate_video(
        self,
        scenes: List[SceneInfo],
        output_path: str,
        audio_path: Optional[str] = None,
        watermark_text: Optional[str] = None
    ) -> str:
        """
        Generate complete cinematic video from scenes
        """
        try:
            all_frames = []
            
            # Process each scene
            for idx, scene in enumerate(scenes):
                logger.info(f"Processing scene {idx + 1}/{len(scenes)}: {scene.room_type}")
                
                img = self._load_and_preprocess_image(scene.image_path)
                num_frames = int(scene.duration * self.fps)
                
                # Generate frames based on motion type
                if scene.motion_type == "zoom":
                    frames = self._apply_ken_burns_effect(
                        img,
                        start_zoom=scene.zoom_factor[0],
                        end_zoom=scene.zoom_factor[1],
                        start_pos=scene.start_pos,
                        end_pos=scene.end_pos,
                        num_frames=num_frames
                    )
                
                elif scene.motion_type == "pan":
                    frames = self._apply_ken_burns_effect(
                        img,
                        start_zoom=1.2,
                        end_zoom=1.2,
                        start_pos=scene.start_pos,
                        end_pos=scene.end_pos,
                        num_frames=num_frames
                    )
                
                elif scene.motion_type == "parallax":
                    frames = self._apply_parallax_effect(
                        img,
                        num_frames=num_frames,
                        intensity=0.03
                    )
                
                else:  # static
                    resized = cv2.resize(img, self.output_size, interpolation=cv2.INTER_LANCZOS4)
                    frames = [resized] * num_frames
                
                all_frames.extend(frames)
                
                # Add transition to next scene
                if idx < len(scenes) - 1:
                    transition_frames = self._create_transition(
                        frames[-1],
                        cv2.resize(
                            self._load_and_preprocess_image(scenes[idx + 1].image_path),
                            self.output_size
                        ),
                        num_frames=int(0.5 * self.fps),  # 0.5 second transition
                        transition_type="crossfade"
                    )
                    all_frames.extend(transition_frames)
            
            # Write frames to temporary video file
            temp_video = self.temp_dir / "temp_video.mp4"
            fourcc = cv2.VideoWriter_fourcc(*'mp4v')
            out = cv2.VideoWriter(
                str(temp_video),
                fourcc,
                self.fps,
                self.output_size
            )
            
            for frame in all_frames:
                # Convert RGB to BGR for OpenCV
                frame_bgr = cv2.cvtColor(frame, cv2.COLOR_RGB2BGR)
                out.write(frame_bgr)
            
            out.release()
            
            # Re-encode with FFmpeg for better quality and add audio if provided
            await self._finalize_with_ffmpeg(
                str(temp_video),
                output_path,
                audio_path,
                watermark_text
            )
            
            logger.info(f"Video generated successfully: {output_path}")
            return output_path
            
        except Exception as e:
            logger.error(f"Video generation failed: {e}")
            raise MediaProcessingError(f"Video generation failed: {e}")
    
    async def _finalize_with_ffmpeg(
        self,
        input_path: str,
        output_path: str,
        audio_path: Optional[str],
        watermark_text: Optional[str]
    ):
        """
        Finalize video with FFmpeg:
        - Re-encode with H.264
        - Add audio if provided
        - Add watermark if provided
        """
        cmd = [
            'ffmpeg',
            '-y',  # Overwrite output
            '-i', input_path,
        ]
        
        # Add audio if provided
        if audio_path:
            cmd.extend(['-i', audio_path])
        
        # Video encoding settings
        cmd.extend([
            '-c:v', 'libx264',
            '-preset', 'medium',
            '-crf', '23',
            '-b:v', self.bitrate,
            '-pix_fmt', 'yuv420p',
        ])
        
        # Audio settings
        if audio_path:
            cmd.extend([
                '-c:a', 'aac',
                '-b:a', '192k',
                '-shortest'
            ])
        
        # Add watermark filter
        if watermark_text:
            cmd.extend([
                '-vf',
                f"drawtext=text='{watermark_text}':fontsize=24:fontcolor=white@0.5:x=w-tw-10:y=h-th-10"
            ])
        
        cmd.append(output_path)
        
        # Run FFmpeg
        process = subprocess.run(
            cmd,
            capture_output=True,
            text=True
        )
        
        if process.returncode != 0:
            raise MediaProcessingError(f"FFmpeg encoding failed: {process.stderr}")