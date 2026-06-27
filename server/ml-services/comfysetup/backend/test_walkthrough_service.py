import sys
import os
import asyncio

# Ensure app can be imported
sys.path.append(os.getcwd())

from app.services.walkthrough_service import walkthrough_service
from app.schemas import WalkthroughInput, UserPlan, RoomType

async def main():
    print("Initializing Walkthrough Test...")
    
    input_data = WalkthroughInput(
        photo_count=20,
        room_types=[RoomType.LIVING_ROOM for _ in range(20)],
        user_plan=UserPlan.PRO,
        luxury_flag=True
    )
    
    print(f"Creating job with: {input_data}")
    job = await walkthrough_service.create_job(input_data)
    print(f"Job Created: {job['id']} - Status: {job['status']}")
    
    # Poll for completion
    for _ in range(10):
        await asyncio.sleep(1)
        job_status = await walkthrough_service.get_job(job['id'])
        print(f"Poll: {job_status['status']} - Progress: {job_status['progress']}%")
        if job_status['status'] in ['completed', 'failed']:
            break
            
    print("Test Complete.")

if __name__ == "__main__":
    asyncio.run(main())
