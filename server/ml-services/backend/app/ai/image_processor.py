"""
app/ai/image_processor.py
"""

from typing import Union, Tuple
from pathlib import Path
import io
import base64
from PIL import Image

def load_image(image_input: Union[str, bytes, Image.Image]) -> Image.Image:
    """Load image from path, base64, bytes, or return if already Image."""
    if isinstance(image_input, Image.Image):
        return image_input
    
    if isinstance(image_input, str):
        if image_input.startswith("data:"):
            # Base64 data uri
            base64_data = image_input.split(",", 1)[1]
            return Image.open(io.BytesIO(base64.b64decode(base64_data)))
        elif len(image_input) > 2000:
             # Raw base64 string
             return Image.open(io.BytesIO(base64.b64decode(image_input)))
        else:
            # File path
            return Image.open(image_input)
            
    if isinstance(image_input, bytes):
        return Image.open(io.BytesIO(image_input))
        
    raise ValueError("Unsupported image input type")

def image_to_base64(image: Image.Image, format: str = "PNG") -> str:
    """Convert PIL Image to base64 string."""
    buffered = io.BytesIO()
    image.save(buffered, format=format)
    return base64.b64encode(buffered.getvalue()).decode("utf-8")

def resize_for_ai(image: Image.Image, max_dim: int = 1024) -> Image.Image:
    """Resize image so its longest side is at most max_dim."""
    w, h = image.size
    if max(w, h) <= max_dim:
        return image
        
    scale = max_dim / max(w, h)
    new_w = int(w * scale)
    new_h = int(h * scale)
    
    return image.resize((new_w, new_h), Image.LANCZOS)
