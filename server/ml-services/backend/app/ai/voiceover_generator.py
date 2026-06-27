"""
app/ai/voiceover_generator.py
AI voiceover generation using TTS
"""

from typing import Optional
import logging

from app.ai.replicate_client import replicate_client
from app.ai.cache_manager import cache_manager

logger = logging.getLogger(__name__)


class VoiceoverGenerator:
    """Generate AI voiceovers for videos"""
    
    VOICE_PRESETS = {
        "EN": "v2/en_speaker_6",
        "ES": "v2/es_speaker_1",
        "FR": "v2/fr_speaker_2",
        "DE": "v2/de_speaker_3",
        "IT": "v2/it_speaker_1",
        "PT": "v2/pt_speaker_2",
        "AR": "v2/ar_speaker_1",
        "ZH_CN": "v2/zh_speaker_4",
        "JA": "v2/ja_speaker_2",
        "KO": "v2/ko_speaker_1",
    }
    
    async def generate_voiceover(
        self,
        text: str,
        language: str = "EN",
        voice: Optional[str] = None
    ) -> str:
        """
        Generate voiceover from text
        
        Args:
            text: Text to convert to speech
            language: Language code
            voice: Voice preset (optional)
        
        Returns:
            URL to generated audio file
        """
        logger.info(f"Generating voiceover: {len(text)} chars in {language}")
        
        # Get voice preset
        if not voice:
            voice = self.VOICE_PRESETS.get(language, "v2/en_speaker_6")
        
        # Check cache
        cache_input = {"text": text, "language": language, "voice": voice}
        cached = cache_manager.get("tts", cache_input)
        if cached:
            logger.info("Using cached voiceover")
            return cached
        
        try:
            audio_url = await replicate_client.generate_speech(
                text=text,
                voice=voice
            )
            
            # Cache result
            cache_manager.set("tts", cache_input, audio_url)
            
            logger.info(f"Voiceover generated: {audio_url}")
            return audio_url
            
        except Exception as e:
            logger.error(f"Voiceover generation failed: {e}")
            return ""


voiceover_generator = VoiceoverGenerator()
