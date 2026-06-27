from __future__ import annotations
from typing import List
from pydantic_settings import BaseSettings, SettingsConfigDict
from pydantic import AnyHttpUrl, field_validator

class Settings(BaseSettings):
    PROJECT_NAME: str = "ComfyStaging Orchestrator"
    API_V1_STR: str = "/api/v1"
    
    # CORS
    BACKEND_CORS_ORIGINS: List[AnyHttpUrl] = []

    @field_validator("BACKEND_CORS_ORIGINS", mode="before")
    def assemble_cors_origins(cls, v: str | List[str]) -> List[str] | str:
        if isinstance(v, str) and not v.startswith("["):
            return [i.strip() for i in v.split(",")]
        elif isinstance(v, (list, str)):
            return v
        raise ValueError(v)

    # Infrastructure
    REDIS_URL: str = "redis://localhost:6379/0"
    STORAGE_DIR: str = "storage"
    VIDEO_DIR: str = "storage/videos"
    IMAGE_DIR: str = "storage/images"
    CACHE_DIR: str = "storage/cache"
    
    # External Services - AI Generation
    # A1111 (Automatic1111 Stable Diffusion WebUI) - PRIMARY, FREE, LOCAL
    # Start with: ./webui.sh --api
    A1111_HOST: str = "127.0.0.1:7860"
    
    # ComfyUI (Legacy/Alternative)
    COMFY_HOST: str = ""  # Optional: If using ComfyUI instead
    
    # VPS ComfyUI (Remote ComfyUI on Hostinger VPS)
    VPS_COMFY_HOST: str = "72.62.163.166:8188"  # Remote ComfyUI instance
    
    # RunPod (Cloud/Serverless - for scaling)
    RUNPOD_API_KEY: str = ""
    RUNPOD_ENDPOINT_ID: str = ""  # Generic ComfyUI endpoint
    RUNPOD_A1111_ENDPOINT_ID: str = ""  # A1111 serverless endpoint

    # Model Configurations
    # The default SD 1.5 checkpoint to use (must exist in A1111/ComfyUI models)
    SD_CHECKPOINT: str = "v1-5-pruned-emaonly.ckpt"
    # The ControlNet model for depth (must exist in extensions/sd-webui-controlnet/models or ComfyUI/models/controlnet)
    CONTROLNET_DEPTH_MODEL: str = "control_v11f1p_sd15_depth"

    # AI Cost Tracking (USD per inference)
    AI_COSTS: dict = {
        "scene_analysis": 0.00,  # Free (local Detectron2)
        "walkthrough_parallax_2_5d": 0.05,
        "walkthrough_instant_ngp_single": 0.25,
        "walkthrough_instant_ngp_full": 0.45,
        "walkthrough_gaussian_splatting": 1.50,
    }

    model_config = SettingsConfigDict(case_sensitive=True, env_file=".env", extra="ignore")

settings = Settings()
