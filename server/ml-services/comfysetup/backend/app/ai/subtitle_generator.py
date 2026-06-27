"""
app/ai/subtitle_generator.py
Subtitle generation for videos
"""

from typing import List, Dict
import logging

from app.ai.replicate_client import replicate_client

logger = logging.getLogger(__name__)


class SubtitleGenerator:
    """Generate subtitles for videos using Whisper"""
    
    async def generate_subtitles(
        self,
        audio_path: str,
        language: str = "en"
    ) -> List[Dict]:
        """
        Generate subtitles from audio
        
        Returns:
            List of subtitle segments with timestamps
        """
        logger.info(f"Generating subtitles for {audio_path}")
        
        try:
            result = await replicate_client.transcribe_audio(
                audio_url=audio_path,
                language=language
            )
            
            # Parse Whisper output into subtitle format
            subtitles = []
            if isinstance(result, dict) and "segments" in result:
                for segment in result["segments"]:
                    subtitles.append({
                        "start": segment.get("start", 0),
                        "end": segment.get("end", 0),
                        "text": segment.get("text", "")
                    })
            
            return subtitles
            
        except Exception as e:
            logger.error(f"Subtitle generation failed: {e}")
            return []
    
    def format_srt(self, subtitles: List[Dict]) -> str:
        """Format subtitles as SRT"""
        srt_content = []
        
        for i, sub in enumerate(subtitles, 1):
            start_time = self._format_timestamp(sub["start"])
            end_time = self._format_timestamp(sub["end"])
            
            srt_content.append(f"{i}")
            srt_content.append(f"{start_time} --> {end_time}")
            srt_content.append(sub["text"])
            srt_content.append("")
        
        return "\n".join(srt_content)
    
    def _format_timestamp(self, seconds: float) -> str:
        """Format seconds as SRT timestamp (HH:MM:SS,mmm)"""
        hours = int(seconds // 3600)
        minutes = int((seconds % 3600) // 60)
        secs = int(seconds % 60)
        millis = int((seconds % 1) * 1000)
        
        return f"{hours:02d}:{minutes:02d}:{secs:02d},{millis:03d}"


subtitle_generator = SubtitleGenerator()
