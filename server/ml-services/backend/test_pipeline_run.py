
import asyncio
import os
from app.ai.staging_pipeline import staging_pipeline
from app.core.config import settings
from pathlib import Path

# Ensure we use an absolute path for the test image
# We'll create a dummy image if one doesn't exist to test the pipeline flow
TEST_IMAGE_PATH = Path("/Users/yldyagz/testtool/atlasvs/backend/test_input.jpg")

def create_dummy_image():
    from PIL import Image
    if not TEST_IMAGE_PATH.exists():
        img = Image.new('RGB', (512, 512), color = 'red')
        img.save(TEST_IMAGE_PATH)
        print(f"Created dummy test image at {TEST_IMAGE_PATH}")

async def test_pipeline():
    print("🚀 Starting Staging Pipeline Test...")
    
    # 1. Create dummy input if needed
    create_dummy_image()
    
    # 2. Check detected engine
    engine = await staging_pipeline.get_available_engine()
    print(f"✅ Detected Engine: {engine}")
    
    if engine == "none":
        print("❌ No AI Engine detected! Please ensure ComfyUI or A1111 is running.")
        return

    # 3. Run Staging (Harmonization Mode)
    # Low denoise (0.4) = Harmonize placed items
    print("🎨 Sending request to AI Engine...")
    try:
        result_path = await staging_pipeline.stage_image(
            image_path=str(TEST_IMAGE_PATH),
            room_type="living_room",
            style="modern",
            denoising_strength=0.4, # Harmonization mode
            engine=engine
        )
        
        print(f"🎉 Success! Image generated at: {result_path}")
        
    except Exception as e:
        print(f"❌ Pipeline Validation Failed: {e}")

if __name__ == "__main__":
    # We need to set the COMFY_HOST env var explicitly for this script if it's not loaded
    # but staging_pipeline loads from settings which loads from .env
    asyncio.run(test_pipeline())
