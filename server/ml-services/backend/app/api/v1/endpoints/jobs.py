
from fastapi import APIRouter, HTTPException, BackgroundTasks
from pydantic import BaseModel
from typing import List, Optional, Dict, Any
from app.services.queue_service import queue_manager

router = APIRouter()

from app.schemas import RoomType, DesignStyle

class JobCreate(BaseModel):
    user_id: str
    workflow_type: str = "staging" # staging, video, 3d
    input_images: List[str]
    room_type: RoomType
    style: DesignStyle
    settings: Dict[str, Any] = {}

class JobResponse(BaseModel):
    job_id: str
    status: str
    queue_position: int

@router.post("/", response_model=JobResponse)
async def create_job(job: JobCreate, background_tasks: BackgroundTasks):
    """
    Submit a new processing job to the queue
    """
    try:
        job_id = await queue_manager.add_job(job)
        
        # In a real scenario, the worker picks this up. 
        # For simple setups, we might trigger a check here.
        return {
            "job_id": job_id,
            "status": "queued",
            "queue_position": 1
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@router.get("/{job_id}")
async def get_job_status(job_id: str):
    """
    Get the status of a specific job
    """
    status = await queue_manager.get_job_status(job_id)
    if not status:
        raise HTTPException(status_code=404, detail="Job not found")
    return status
