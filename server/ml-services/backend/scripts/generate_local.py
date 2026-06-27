import asyncio
import logging
import sys
from pathlib import Path
from app.ai.staging_pipeline import staging_pipeline

# Configure logging to see pipeline errors
logging.basicConfig(level=logging.INFO, stream=sys.stdout)


# Configuration
STORAGE_DIR = Path("storage/images")

# Staging Prompts were good, let's reuse them or let pipeline handle it
# pipeline handles styles, we just map folder to style
FOLDER_STYLES = {
    "1": "modern", # kitchen
    "4": "office", 
    "default": "modern"
}

async def generate_staging(folder_id):
    folder_path = STORAGE_DIR / str(folder_id)
    before_path = folder_path / "before.jpg"
    
    if not before_path.exists():
        print(f"⚠️  Skipping #{folder_id}: No before.jpg found (checked {before_path})")
        return

    print(f"🎨 Processing Project #{folder_id}...")
    
    style = FOLDER_STYLES.get(str(folder_id), "modern")
    
    try:
        # Use our backend pipeline which handles ComfyUI/A1111/RunPod automatically
        result_path = await staging_pipeline.stage_image(
            image_path=str(before_path),
            room_type="living_room", # Simplified for now
            style=style,
            denoising_strength=0.65
        )
        
        print(f"✅ Saved result to: {result_path}")
        
    except Exception as e:
        print(f"❌ Failed: {e}")

async def main():
    print("--- Local AI Staging Automation (via Backend Pipeline) ---")
    
    # Check engine
    engine = await staging_pipeline.get_available_engine()
    print(f"ℹ️  Detected Engine: {engine}")
    
    if engine == "none":
        print("❌ No AI Engine detected! Please ensure ComfyUI (8188) or A1111 (7860) is running.")
        return

    # Process folders 1 through 5
    for i in range(1, 6):
        await generate_staging(i)
        
    print("\n🎉 All Done!")

if __name__ == "__main__":
    asyncio.run(main())
