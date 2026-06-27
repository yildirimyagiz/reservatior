
from fastapi import APIRouter, Request

router = APIRouter()

@router.post("/runpod")
async def runpod_webhook(request: Request):
    """
    Receive webhook callbacks from RunPod when a job completes
    """
    payload = await request.json()
    # Process the payload (status update, image URLs, etc.)
    print(f"Received RunPod webhook: {payload}")
    
    # Logic to update database/notify user would go here
    
    return {"received": True}
