
import sys
import os
from fastapi.testclient import TestClient
from pathlib import Path

# Add backend to path
backend_path = Path(__file__).parent.parent
sys.path.append(str(backend_path))

from main import app
# We need to find where get_current_user is imported from in the router
# In routes.py: from app.core.deps import get_current_user
# So we override that dependency.
from app.core.deps import get_current_user

# Mock User
class MockUser:
    id = "user_123"
    profileImageUrl = None
    email = "test@example.com"

async def mock_get_current_user():
    return MockUser()

app.dependency_overrides[get_current_user] = mock_get_current_user

client = TestClient(app)

def test_manual_brochure_generation():
    # Use an existing image path
    image_path = "/Users/yldyagz/testtool/stable-diffusion-webui-master/screenshot.png"
    if not os.path.exists(image_path):
        print(f"Error: Image not found at {image_path}")
        return

    templates = ["navy_blue_gold", "modern_clean_grid", "magazine_left"]

    for template in templates:
        print(f"\n--- Generating {template} brochure ---")
        payload = {
            "title": f"Stunning {template.title()} Home",
            "address": "123 Test Avenue, Tech City",
            "description": f"A beautiful {template} home with state-of-the-art AI features.",
            "price": 1250000,
            "bedrooms": 4,
            "bathrooms": 3.5,
            "sqft": 3200,
            "template": template,
            "custom_photos": [image_path],
            "agent_name": "Antigravity AI",
            "agent_phone": "+1 (555) 123-4567",
            "agent_email": "contact@antigravity.ai",
            "agency_name": "Premium Estates",
            "agency_logo_url": image_path, # Using same image for test
            "listing_url": "https://zillow.com/test-property"
        }

        response = client.post("/api/v1/brochures/generate", json=payload)

        if response.status_code == 200:
            print(f"Success! {template} brochure generated.")
            # Check if response is PDF
            if response.headers["content-type"] == "application/pdf":
                # The file is already saved by the backend in storage/brochures
                # We can also save the response content locally if needed, but the backend doing it is the important part.
                pass 
            else:
                print("Response content-type:", response.headers["content-type"])
        else:
            print(f"Failed to generate {template}: {response.status_code}")
            print(response.text)

if __name__ == "__main__":
    test_manual_brochure_generation()
