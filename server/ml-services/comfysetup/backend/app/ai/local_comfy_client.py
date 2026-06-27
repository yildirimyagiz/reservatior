import aiohttp
import asyncio
import logging
import json
import uuid
from typing import Dict, Any, List

from app.core.config import settings

logger = logging.getLogger(__name__)

class LocalComfyClient:
    """
    Client for Local ComfyUI Instance (http://127.0.0.1:8188 default).
    Used for local testing purposes.
    """
    
    def __init__(self):
        host = settings.COMFY_HOST or "127.0.0.1:8188"
        if "://" not in host:
            host = f"http://{host}"
        self.server_url = host
        self.client_id = str(uuid.uuid4())

    async def upload_image(self, image_input: str, filename: str = "input.jpg") -> str:
        """
        Upload an image to ComfyUI.
        """
        import aiohttp
        from pathlib import Path
        
        url = f"{self.server_url}/upload/image"
        
        # Determine if input is path or base64 (simple check)
        is_path = True
        if len(str(image_input)) > 1000: # heuristic
            is_path = False
            
        try:
            data = aiohttp.FormData()
            data.add_field('overwrite', 'true')
            
            if is_path:
                path = Path(image_input)
                if not path.exists():
                     raise FileNotFoundError(f"File not found: {path}")
                
                # Check if it is a file match
                with open(path, 'rb') as f:
                    file_content = f.read()
            else:
                # Assume base64 or bytes
                import base64
                if isinstance(image_input, str) and "," in image_input:
                     image_input = image_input.split(",")[1]
                if isinstance(image_input, str):
                     file_content = base64.b64decode(image_input)
                else:
                     file_content = image_input

            data.add_field('image', file_content, filename=filename, content_type='image/jpeg')
            
            async with aiohttp.ClientSession() as session:
                async with session.post(url, data=data) as resp:
                    if resp.status != 200:
                        logger.error(f"Failed to upload image: {await resp.text()}")
                        return None
                    
                    result = await resp.json()
                    # Comfy returns {"name": "filename.jpg", "subfolder": "", "type": "input"}
                    return result.get("name")
                    
        except Exception as e:
            logger.error(f"Upload error: {e}")
            return None

    async def run_sync(self, workflow_json: Dict[str, Any], images: List[Dict[str, Any]] = None) -> Dict[str, Any]:
        """
        Submit prompt to local ComfyUI and poll for result.
        
        Args:
            workflow_json: The ComfyUI workflow (API format)
            images: Optional list of images to upload [{"name": "example.jpg", "image": "/path/..."}]
        """
        logger.info(f"Connecting to Local ComfyUI at {self.server_url}")
        
        async with aiohttp.ClientSession() as session:
            # 1. Check if server is up
            try:
                async with session.get(f"{self.server_url}/system_stats") as resp:
                    if resp.status != 200:
                         logger.warning("Local ComfyUI not reachable.")
                         return {"status": "failed", "error": "Unreachable"}
            except Exception as e:
                logger.error(f"Local ComfyUI connection failed: {e}")
                return {"status": "mock_success", "images": ["/images/placeholder-staged.jpg"]}

            # 2. Upload Images if needed
            if images:
                for img in images:
                    img_name = img.get("name", "input.jpg")
                    img_data = img.get("image")
                    logger.info(f"Uploading input image: {img_name}")
                    await self.upload_image(img_data, filename=img_name)

            # 3. Queue Prompt
            prompt_url = f"{self.server_url}/prompt"
            payload = {
                "prompt": workflow_json,
                "client_id": self.client_id
            }
            
            async with session.post(prompt_url, json=payload) as resp:
                if resp.status != 200:
                   text = await resp.text()
                   # raise Exception(f"Local ComfyUI Error: {text}")
                   logger.error(f"ComfyUI Submit Error: {text}")
                   return {"status": "failed", "error": text}
                   
                resp_data = await resp.json()
                prompt_id = resp_data['prompt_id']
                logger.info(f"Local ComfyUI Task Started: {prompt_id}")

            # 4. Poll History (Simplified vs WebSocket)
            history_url = f"{self.server_url}/history/{prompt_id}"
            
            # Poll for up to 300 seconds (5 minutes)
            for _ in range(300):
                async with session.get(history_url) as resp:
                    history = await resp.json()
                    if prompt_id in history:
                         # Extraction logic for outputs
                         outputs = history[prompt_id]['outputs']
                         logger.info(f"Task {prompt_id} completed.")
                         
                         images_urls = []
                         for node_id, node_output in outputs.items():
                             if 'images' in node_output:
                                 for img in node_output['images']:
                                     # Construct URL
                                     # http://127.0.0.1:8188/view?filename=...
                                     filename = img['filename']
                                     subfolder = img['subfolder']
                                     img_type = img['type']
                                     img_url = f"{self.server_url}/view?filename={filename}&subfolder={subfolder}&type={img_type}"
                                     images_urls.append(img_url)
                                     
                         return {"status": "success", "images": images_urls}
                
                await asyncio.sleep(1)
            
            return {"status": "timeout", "error": "Local execution timed out"}

local_comfy_client = LocalComfyClient()
