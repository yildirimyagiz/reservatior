#!/usr/bin/env python3
"""
Translation API Service using py-googletrans
Integrates with Reservatior language system

Install requirements:
pip install fastapi uvicorn googletrans==4.0.0rc1 python-multipart

Run:
uvicorn app:app --host 0.0.0.0 --port 8002 --reload
"""

import os
import logging
from typing import List, Dict, Optional
from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from googletrans import Translator, LANGUAGES
import asyncio
from functools import lru_cache

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# FastAPI app setup
app = FastAPI(
    title="Translation API",
    description="Translation service for Reservatior platform",
    version="1.0.0"
)

# CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Configure this properly in production
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Pydantic models
class TranslationRequest(BaseModel):
    text: str
    source_lang: str = "auto"  # auto-detect
    target_lang: str
    agency_id: Optional[str] = None

class DetectionRequest(BaseModel):
    text: str
    agency_id: Optional[str] = None

class BatchTranslationRequest(BaseModel):
    texts: List[str]
    source_lang: str = "auto"
    target_lang: str
    agency_id: Optional[str] = None

class TranslationResponse(BaseModel):
    success: bool
    original_text: str
    translated_text: str
    detected_source_language: str
    target_language: str
    confidence: float
    service: str = "google"

class DetectionResponse(BaseModel):
    success: bool
    text: str
    detected_language: str
    confidence: float
    service: str = "google"

class LanguageInfo(BaseModel):
    code: str
    name: str
    native_name: str

# Global translator instance
translator = Translator()

# Supported languages mapping (Google Translate codes to Reservatior codes)
RESERVATIOR_LANGUAGE_MAP = {
    # Your existing i18n locale codes
    'ar': 'ar',  # Arabic
    'de': 'de',  # German  
    'en': 'en',  # English
    'es': 'es',  # Spanish
    'fa': 'fa',  # Persian/Farsi
    'fr': 'fr',  # French
    'hi': 'hi',  # Hindi
    'it': 'it',  # Italian
    'ja': 'ja',  # Japanese
    'ru': 'ru',  # Russian
    'th': 'th',  # Thai
    'tr': 'tr',  # Turkish
    'zh': 'zh',  # Chinese
    # Additional common languages
    'pt': 'pt',  # Portuguese
    'ko': 'ko',  # Korean
    'nl': 'nl',  # Dutch
    'pl': 'pl',  # Polish
    'he': 'he',  # Hebrew
    'vi': 'vi',  # Vietnamese
    'id': 'id',  # Indonesian
    'ms': 'ms',  # Malay
    'tl': 'tl',  # Filipino
}

@lru_cache(maxsize=128)
def get_supported_languages() -> Dict[str, LanguageInfo]:
    """Get supported languages with caching"""
    supported = {}
    for code, name in LANGUAGES.items():
        if code in RESERVATIOR_LANGUAGE_MAP:
            supported[code] = LanguageInfo(
                code=code,
                name=name.title(),
                native_name=name.title()  # You could enhance this with native names
            )
    return supported

async def validate_language_for_agency(language_code: str, agency_id: Optional[str] = None) -> bool:
    """
    Validate if language is supported for the agency
    In a real implementation, you'd check against your database
    """
    if not agency_id:
        return True  # No agency restriction
    
    # For now, return True - you'd implement agency-specific validation here
    # Example: query your database to check if this agency supports this language
    return True

@app.get("/")
async def root():
    """Health check endpoint"""
    return {
        "service": "Translation API", 
        "status": "healthy",
        "version": "1.0.0",
        "supported_languages": len(get_supported_languages())
    }

@app.get("/health")
async def health():
    """Detailed health check"""
    try:
        # Test translation service
        test_translation = translator.translate("Hello", dest='es')
        return {
            "status": "healthy",
            "translation_service": "available" if test_translation else "unavailable",
            "supported_languages": len(get_supported_languages()),
            "reservatior_languages": len(RESERVATIOR_LANGUAGE_MAP)
        }
    except Exception as e:
        return {
            "status": "degraded",
            "error": str(e),
            "translation_service": "unavailable"
        }

@app.get("/languages")
async def get_languages():
    """Get all supported languages"""
    return {
        "success": True,
        "languages": list(get_supported_languages().values()),
        "total": len(get_supported_languages())
    }

@app.post("/detect", response_model=DetectionResponse)
async def detect_language(request: DetectionRequest):
    """Detect language of input text"""
    try:
        if not request.text.strip():
            raise HTTPException(status_code=400, detail="Text cannot be empty")
        
        # Validate agency permissions
        if request.agency_id and not await validate_language_for_agency("auto", request.agency_id):
            raise HTTPException(status_code=403, detail="Agency does not have language detection permissions")
        
        # Detect language
        detection = translator.detect(request.text)
        detected_lang = detection.lang
        confidence = detection.confidence
        
        # Map to Reservatior language codes if needed
        if detected_lang not in RESERVATIOR_LANGUAGE_MAP:
            logger.warning(f"Detected language {detected_lang} not in Reservatior language map")
            detected_lang = 'en'  # Default to English
            confidence = 0.5  # Lower confidence for unmapped languages
        
        return DetectionResponse(
            success=True,
            text=request.text,
            detected_language=detected_lang,
            confidence=confidence,
            service="google"
        )
        
    except Exception as e:
        logger.error(f"Language detection failed: {str(e)}")
        raise HTTPException(status_code=500, detail=f"Language detection failed: {str(e)}")

@app.post("/translate", response_model=TranslationResponse)
async def translate_text(request: TranslationRequest):
    """Translate text from source to target language"""
    try:
        if not request.text.strip():
            raise HTTPException(status_code=400, detail="Text cannot be empty")
        
        # Validate languages for agency
        if request.agency_id:
            if not await validate_language_for_agency(request.target_lang, request.agency_id):
                raise HTTPException(status_code=403, detail=f"Agency does not support target language: {request.target_lang}")
        
        # Validate target language is supported
        if request.target_lang not in RESERVATIOR_LANGUAGE_MAP:
            raise HTTPException(status_code=400, detail=f"Unsupported target language: {request.target_lang}")
        
        # Perform translation
        source_lang = request.source_lang if request.source_lang != "auto" else None
        translation = translator.translate(
            request.text,
            src=source_lang,
            dest=request.target_lang
        )
        
        # Extract results
        detected_source = translation.src if hasattr(translation, 'src') else request.source_lang
        translated_text = translation.text
        confidence = 0.9  # Google Translate generally has high confidence
        
        return TranslationResponse(
            success=True,
            original_text=request.text,
            translated_text=translated_text,
            detected_source_language=detected_source,
            target_language=request.target_lang,
            confidence=confidence,
            service="google"
        )
        
    except Exception as e:
        logger.error(f"Translation failed: {str(e)}")
        raise HTTPException(status_code=500, detail=f"Translation failed: {str(e)}")

@app.post("/translate/batch")
async def batch_translate(request: BatchTranslationRequest):
    """Translate multiple texts in batch"""
    try:
        if not request.texts or len(request.texts) == 0:
            raise HTTPException(status_code=400, detail="Texts list cannot be empty")
        
        if len(request.texts) > 100:  # Limit batch size
            raise HTTPException(status_code=400, detail="Batch size cannot exceed 100 texts")
        
        # Validate agency permissions
        if request.agency_id:
            if not await validate_language_for_agency(request.target_lang, request.agency_id):
                raise HTTPException(status_code=403, detail=f"Agency does not support target language: {request.target_lang}")
        
        results = []
        source_lang = request.source_lang if request.source_lang != "auto" else None
        
        for i, text in enumerate(request.texts):
            try:
                if text.strip():  # Only translate non-empty texts
                    translation = translator.translate(text, src=source_lang, dest=request.target_lang)
                    results.append({
                        "index": i,
                        "success": True,
                        "original_text": text,
                        "translated_text": translation.text,
                        "detected_source_language": translation.src if hasattr(translation, 'src') else request.source_lang,
                    })
                else:
                    results.append({
                        "index": i,
                        "success": True,
                        "original_text": text,
                        "translated_text": text,  # Return empty as-is
                        "detected_source_language": request.source_lang,
                    })
            except Exception as e:
                results.append({
                    "index": i,
                    "success": False,
                    "original_text": text,
                    "translated_text": text,  # Fallback to original
                    "error": str(e)
                })
        
        return {
            "success": True,
            "results": results,
            "total_processed": len(results),
            "target_language": request.target_lang,
            "service": "google"
        }
        
    except Exception as e:
        logger.error(f"Batch translation failed: {str(e)}")
        raise HTTPException(status_code=500, detail=f"Batch translation failed: {str(e)}")

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(
        "app:app", 
        host="0.0.0.0", 
        port=8002, 
        reload=True,
        log_level="info"
    )