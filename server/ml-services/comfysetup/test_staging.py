#!/usr/bin/env python3
"""
Test script to generate staged images using ComfyUI
"""
import requests
import json
import base64
import time
from pathlib import Path
from PIL import Image
import io

COMFY_URL = "http://127.0.0.1:8188"

# Simple staging workflow for SD 1.5
def create_workflow(image_data, prompt="modern interior design, professionally staged, high quality furniture, warm lighting, photorealistic"):
    return {
        "3": {
            "inputs": {
                "seed": int(time.time()),
                "steps": 25,
                "cfg": 7.5,
                "sampler_name": "euler",
                "scheduler": "normal",
                "denoise": 0.75,
                "model": ["4", 0],
                "positive": ["6", 0],
                "negative": ["7", 0],
                "latent_image": ["13", 0]
            },
            "class_type": "KSampler"
        },
        "4": {
            "inputs": {
                "ckpt_name": "v1-5-pruned-emaonly.safetensors"
            },
            "class_type": "CheckpointLoaderSimple"
        },
        "6": {
            "inputs": {
                "text": prompt,
                "clip": ["4", 1]
            },
            "class_type": "CLIPTextEncode"
        },
        "7": {
            "inputs": {
                "text": "empty room, clutter, low quality, blurry, distorted",
                "clip": ["4", 1]
            },
            "class_type": "CLIPTextEncode"
        },
        "8": {
            "inputs": {
                "samples": ["3", 0],
                "vae": ["4", 2]
            },
            "class_type": "VAEDecode"
        },
        "9": {
            "inputs": {
                "filename_prefix": "staged",
                "images": ["8", 0]
            },
            "class_type": "SaveImage"
        },
        "10": {
            "inputs": {
                "image": "input.jpg",
                "upload": "image"
            },
            "class_type": "LoadImage"
        },
        "11": {
            "inputs": {
                "upscale_method": "nearest-exact",
                "width": 1024,
                "height": 1024,
                "crop": "center",
                "image": ["10", 0]
            },
            "class_type": "ImageScale"
        },
        "13": {
            "inputs": {
                "pixels": ["11", 0],
                "vae": ["4", 2]
            },
            "class_type": "VAEEncode"
        }
    }

def upload_image(image_path):
    """Upload image to ComfyUI"""
    with open(image_path, 'rb') as f:
        files = {'image': (f'input_{time.time()}.jpg', f, 'image/jpeg')}
        response = requests.post(f"{COMFY_URL}/upload/image", files=files)
        return response.json()

def queue_prompt(workflow):
    """Queue a workflow for processing"""
    payload = {"prompt": workflow}
    response = requests.post(f"{COMFY_URL}/prompt", json=payload)
    return response.json()["prompt_id"]

def get_image(filename, subfolder, folder_type):
    """Download generated image from ComfyUI"""
    params = {"filename": filename, "subfolder": subfolder, "type": folder_type}
    response = requests.get(f"{COMFY_URL}/view", params=params)
    return response.content

def wait_for_completion(prompt_id, max_wait=120):
    """Wait for workflow to complete"""
    start = time.time()
    while time.time() - start < max_wait:
        response = requests.get(f"{COMFY_URL}/history/{prompt_id}")
        history = response.json()
        if prompt_id in history:
            return history[prompt_id]
        time.sleep(2)
    raise TimeoutError("Generation took too long")

def stage_image(input_path, output_path):
    """Stage a single image"""
    print(f"📸 Processing: {input_path}")
    
    # Upload image
    upload_result = upload_image(input_path)
    print(f"✅ Uploaded as: {upload_result['name']}")
    
    # Create and queue workflow
    workflow = create_workflow(upload_result['name'])
    prompt_id = queue_prompt(workflow)
    print(f"🚀 Queued prompt: {prompt_id}")
    
    # Wait for completion
    print("⏳ Waiting for generation...")
    result = wait_for_completion(prompt_id)
    
    # Get output image
    outputs = result["outputs"]["9"]["images"][0]
    image_data = get_image(outputs["filename"], outputs["subfolder"], outputs["type"])
    
    # Save result
    with open(output_path, 'wb') as f:
        f.write(image_data)
    print(f"💾 Saved: {output_path}\n")

def main():
    base_path = Path("public/images")
    
    # Process each set of images (1-5)
    for i in range(1, 6):
        before_path = base_path / str(i) / "before.jpg"
        after_path = base_path / str(i) / "after.jpg"
        
        if before_path.exists():
            try:
                stage_image(str(before_path), str(after_path))
            except Exception as e:
                print(f"❌ Error processing image {i}: {e}\n")
        else:
            print(f"⚠️  Skipping {i}: before.jpg not found\n")
    
    print("✨ All done!")

if __name__ == "__main__":
    main()
