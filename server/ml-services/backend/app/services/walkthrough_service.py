from typing import Dict, Any, List, Optional
import uuid
import datetime
import asyncio

# Import pipelines
from app.ai.walkthrough_pipeline import select_walkthrough_pipeline
from app.schemas import WalkthroughInput
from app.ai.ngp_pipeline import InstantNGPPipeline
from app.ai.gaussian_splatting_pipeline import GaussianSplattingPipeline

class WalkthroughService:
    def __init__(self):
        self.jobs = {}  # In-memory job store (replace with DB in production)
        self.ngp_pipeline = InstantNGPPipeline()
        self.gaussian_pipeline = GaussianSplattingPipeline()

    async def select_pipeline(self, input_data: WalkthroughInput) -> Dict[str, Any]:
        # Convert enum to string if necessary
        user_plan_str = input_data.user_plan
        if hasattr(user_plan_str, 'value'):
             user_plan_str = user_plan_str.value

        return select_walkthrough_pipeline(
            photo_count=input_data.photo_count,
            room_types=input_data.room_types,
            user_plan=str(user_plan_str),
            luxury_flag=input_data.luxury_flag
        )

    async def create_job(self, input_data: WalkthroughInput) -> Dict[str, Any]:
        job_id = f"job_{uuid.uuid4().hex[:8]}"
        
        # 1. Select Pipeline
        decision = await self.select_pipeline(input_data)
        
        # 2. Create Job Record
        # Check if input_data is dataclass or pydantic
        input_dict = input_data.model_dump()

        job_record = {
            "id": job_id,
            "status": "queued",
            "created_at": datetime.datetime.now().isoformat(),
            "input": input_dict,
            "pipeline_decision": decision,
            "progress": 0,
            "result_url": None
        }
        self.jobs[job_id] = job_record
        
        # 3. Start Processing (Background Task)
        asyncio.create_task(self._process_job(job_id))
        
        return job_record

    async def get_job(self, job_id: str) -> Optional[Dict[str, Any]]:
        return self.jobs.get(job_id)

    async def _process_job(self, job_id: str):
        job = self.jobs[job_id]
        job["status"] = "processing"
        
        try:
            pipeline_name = job["pipeline_decision"]["selected_pipeline"]
            # Mock photo paths
            photo_count = job["input"]["photo_count"]
            photo_paths = [f"photo_{i}.jpg" for i in range(photo_count)]
            
            # Mock room analyses
            room_analyses = [{"room_type": "living_room", "importance_score": 8}] * photo_count
            
            output_path = f"/tmp/walkthroughs/{job_id}.mp4"
            result_url = ""
            
            if "Gaussian" in pipeline_name:
                job["progress"] = 10
                result_url = await self.gaussian_pipeline.generate_walkthrough(
                    image_paths=photo_paths,
                    room_analyses=room_analyses,
                    output_path=output_path,
                    quality="high"
                )
            elif "InstantNGP" in pipeline_name:
                job["progress"] = 10
                result_url = await self.ngp_pipeline.generate_walkthrough(
                    image_paths=photo_paths,
                    room_analyses=room_analyses,
                    output_path=output_path,
                    quality="standard"
                )
            else:
                # 2.5D Parallax fallback / implementation
                # Simulate parallax processing
                await asyncio.sleep(2)
                result_url = f"https://storage.example.com/walkthroughs/{job_id}_parallax.mp4"
                
            job["progress"] = 100
            job["status"] = "completed"
            job["result_url"] = result_url
            
        except Exception as e:
            print(f"Job {job_id} failed: {e}")
            job["status"] = "failed"
            job["error"] = str(e)

# Global instance
walkthrough_service = WalkthroughService()
