import os
import asyncio
import httpx
from fastapi import FastAPI, HTTPException, Depends
from pydantic import BaseModel
from typing import Optional
import base64
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI(title="Reservatior AI Interior Staging API")

# Allow CORS for the client
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# RunPod Configuration
RUNPOD_API_KEY = os.environ.get("RUNPOD_API_KEY", "mock_key_for_development")
# Replace with actual Serverless Endpoint ID running Stable Diffusion + ControlNet
RUNPOD_ENDPOINT_ID = os.environ.get("RUNPOD_ENDPOINT_ID", "mock_endpoint_id") 
RUNPOD_API_URL = f"https://api.runpod.ai/v2/{RUNPOD_ENDPOINT_ID}/runsync"

class StagingRequest(BaseModel):
    image_b64: str  # Base64 encoded empty room image
    style_prompt: str
    negative_prompt: Optional[str] = "lowres, bad anatomy, bad hands, text, error, missing fingers, extra digit, fewer digits, cropped, worst quality, low quality, normal quality, jpeg artifacts, signature, watermark, username, blurry, empty room, unfurnished"
    room_type: Optional[str] = "living room"

class StagingResponse(BaseModel):
    status: str
    result_image_b64: Optional[str] = None
    generation_time: Optional[float] = None
    error: Optional[str] = None

@app.get("/health")
def health_check():
    return {"status": "healthy", "service": "interior-staging"}

@app.post("/api/v1/stage-room", response_model=StagingResponse)
async def stage_room(request: StagingRequest):
    """
    Sends an empty room image to a RunPod endpoint running Stable Diffusion ControlNet (MLSD/Depth)
    to generate a furnished interior based on the provided style_prompt.
    """
    
    # Comprehensive prompt building
    full_prompt = f"professional architectural photography, interior design, furnished {request.room_type}, {request.style_prompt}, photorealistic, 8k resolution, highly detailed, beautiful lighting, cinematic, raytracing, unreal engine 5 render, interior staging"
    
    payload = {
        "input": {
            "prompt": full_prompt,
            "negative_prompt": request.negative_prompt,
            "init_image": request.image_b64,
            "controlnet_type": "mlsd", # using MLSD to preserve room straight lines (walls, windows)
            "num_inference_steps": 30,
            "guidance_scale": 7.5,
            "control_scale": 1.0,
        }
    }
    
    headers = {
        "Authorization": f"Bearer {RUNPOD_API_KEY}",
        "Content-Type": "application/json"
    }
    
    # If using mock keys for UI testing, return a mock response after a delay
    if RUNPOD_API_KEY == "mock_key_for_development":
        await asyncio.sleep(3) # simulate processing time
        return StagingResponse(
            status="success",
            # We return a placeholder image of a furnished room for demo purposes
            result_image_b64="https://images.unsplash.com/photo-1600210492486-724fe5c67fb0?auto=format&fit=crop&q=80&w=1000",
            generation_time=3.0
        )
    
    try:
        async with httpx.AsyncClient(timeout=120.0) as client:
            response = await client.post(RUNPOD_API_URL, json=payload, headers=headers)
            response.raise_for_status()
            
            data = response.json()
            
            if data.get("status") == "COMPLETED":
                # Assuming the RunPod worker returns the base64 output in output.image
                output_image = data.get("output", {}).get("image", "")
                return StagingResponse(
                    status="success",
                    result_image_b64=output_image,
                    generation_time=data.get("executionTime", 0) / 1000.0
                )
            else:
                return StagingResponse(
                    status="failed",
                    error=f"RunPod execution failed: {data.get('status')}"
                )
                
    except httpx.RequestError as exc:
        raise HTTPException(status_code=503, detail=f"Error connecting to RunPod: {str(exc)}")
    except Exception as exc:
        raise HTTPException(status_code=500, detail=f"Internal server error: {str(exc)}")

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
