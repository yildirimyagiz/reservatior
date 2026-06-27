from jinja2 import Environment, FileSystemLoader
from pathlib import Path
from typing import Dict, List
import base64
import qrcode
from io import BytesIO

class BrochureGenerator:
    def __init__(self, output_dir: str = "storage/brochures", template_dir: str = "app/services/brochure_service/templates"):
        self.output_dir = Path(output_dir)
        self.output_dir.mkdir(parents=True, exist_ok=True)
        self.template_env = Environment(loader=FileSystemLoader(template_dir))
        self._HTML = None

    @property
    def HTML(self):
        """Lazy load WeasyPrint to avoid import errors at startup"""
        if self._HTML is None:
            from weasyprint import HTML
            self._HTML = HTML
        return self._HTML

    def _image_to_base64(self, image_path: str) -> str:
        try:
            with open(image_path, 'rb') as f:
                return base64.b64encode(f.read()).decode()
        except FileNotFoundError:
            print(f"Warning: Image not found at {image_path}")
            return ""
        except Exception as e:
            print(f"Error encoding image {image_path}: {e}")
            return ""

    def _generate_qr_code(self, data: str) -> str:
        qr = qrcode.QRCode(
            version=1,
            error_correction=qrcode.constants.ERROR_CORRECT_L,
            box_size=10,
            border=4,
        )
        qr.add_data(data)
        qr.make(fit=True)
        img = qr.make_image(fill_color="black", back_color="white")
        buffered = BytesIO()
        img.save(buffered, format="PNG")
        return base64.b64encode(buffered.getvalue()).decode()

    def generate(self, property_data: Dict, photos: List[str], template_id: str, agent_photo_path: str) -> str:
        template = self.template_env.get_template(f"{template_id}.html")
        
        photo_b64s = [self._image_to_base64(p) for p in photos]
        agent_photo_b64 = self._image_to_base64(agent_photo_path)
        qr_code_b64 = self._generate_qr_code(property_data.get('url', 'https://example.com'))

        data = property_data.copy()
        data['price'] = f"{property_data.get('price', 0):,}"
        
        if property_data.get('agency_logo_url'):
             data['agency_logo_b64'] = self._image_to_base64(property_data['agency_logo_url'])

        html_content = template.render(
            **data,
            photos=photo_b64s,
            agent_photo=agent_photo_b64,
            qr_code=qr_code_b64
        )

        output_path = self.output_dir / f"brochure_{property_data['id']}_{template_id}.pdf"
        
        try:
            self.HTML(string=html_content).write_pdf(output_path)
        except Exception as e:
            print(f"Error generating PDF for {template_id}: {e}")
            # Fallback or error handling can be added here
            return ""
            
        return str(output_path)
