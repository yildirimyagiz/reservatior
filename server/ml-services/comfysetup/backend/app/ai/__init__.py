"""AI and ML pipelines"""

from app.ai.a1111_client import a1111_client, A1111Client
from app.ai.runpod_a1111_client import runpod_a1111_client, RunPodA1111Client
from app.ai.runpod_client import runpod_client
from app.ai.scene_analyzer import scene_analyzer
from app.ai.video_generator import CinematicVideoGenerator
from app.ai.walkthrough_pipeline import (
    walkthrough_selector,
    select_walkthrough_pipeline,
    WalkthroughPipelineSelector,
    WalkthroughInput,
    WalkthroughOutput
)
from app.ai.ngp_pipeline import ngp_pipeline
from app.ai.gaussian_splatting_pipeline import gaussian_splatting_pipeline
from app.ai.staging_pipeline import staging_pipeline

__all__ = [
    "a1111_client",
    "A1111Client",
    "runpod_a1111_client",
    "RunPodA1111Client",
    "runpod_client",
    "scene_analyzer",
    "CinematicVideoGenerator",
    "walkthrough_selector",
    "select_walkthrough_pipeline",
    "WalkthroughPipelineSelector",
    "WalkthroughInput",
    "WalkthroughOutput",
    "ngp_pipeline",
    "gaussian_splatting_pipeline",
    "staging_pipeline",
]
