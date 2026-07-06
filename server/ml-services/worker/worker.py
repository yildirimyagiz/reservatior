"""
General Task Worker
Handles various background tasks: image processing, notifications, etc.
Saves processed images into structured folder hierarchy:
  {base_path}/{country}/{city}/{district}/{neighborhood}/{listingType}/{propertyType}/
"""

import pika
import json
import os
import shutil
import requests
from pathlib import Path
from datetime import datetime
from PIL import Image

# Configuration
RABBITMQ_HOST = os.getenv('RABBITMQ_HOST', 'localhost')
RABBITMQ_USER = os.getenv('RABBITMQ_USER', 'admin')
RABBITMQ_PASS = os.getenv('RABBITMQ_PASS', 'admin123')
DATA_BASE_PATH = os.getenv('DATA_BASE_PATH', '/Users/os2026/Downloads/Reservatior/server/data')

COUNTRY_DIR_MAP = {
    'TR': 'TURKİYE',
    'AE': 'UAE',
    'SA': 'SA',
    'UK': 'UK',
    'US': 'USA',
    'DE': 'DE',
    'FR': 'FR',
    'ES': 'ES',
    'IT': 'IT',
    'NL': 'NL',
    'CA': 'CA',
    'MX': 'MX',
    'BR': 'BR',
    'AR': 'AR',
    'AU': 'AU',
    'NZ': 'NZ',
    'JP': 'JP',
    'KR': 'KR',
    'CN': 'CN',
    'IN': 'IN',
    'SG': 'SG',
    'MY': 'MY',
    'TH': 'TH',
}

LISTING_TYPE_MAP = {
    'BOOKING': 'Günlük Kiralık',
    'SALE': 'Satılık',
    'RENT': 'Kiralık',
    'SECOND_HAND': '2.El',
    'PROJECT': 'Projeler',
}

PROPERTY_TYPE_MAP = {
    'APARTMENT': 'Daire',
    'VILLA': 'Villa',
    'HOTEL': 'Otel',
    'STUDIO': 'Stüdyo',
    'APART': 'Apart',
    'RESIDENTIAL': 'Konut',
    'COMMERCIAL': 'Ticari',
    'BUILDING': 'Bina',
    'LAND': 'Arsa',
}

def download_image(url: str, target_path: str) -> bool:
    try:
        resp = requests.get(url, timeout=30, stream=True)
        resp.raise_for_status()
        with open(target_path, 'wb') as f:
            for chunk in resp.iter_content(chunk_size=8192):
                f.write(chunk)
        return True
    except Exception as e:
        print(f"Failed to download image {url}: {e}")
        return False

def process_image(image_url: str, metadata: dict) -> dict:
    sizes = [
        {'name': 'thumbnail', 'width': 150, 'height': 150},
        {'name': 'medium', 'width': 800, 'height': 600},
        {'name': 'large', 'width': 1920, 'height': 1080},
    ]

    country_code = (metadata.get('country') or 'UNKNOWN').strip().upper()
    country = COUNTRY_DIR_MAP.get(country_code, country_code)
    city = (metadata.get('city') or 'UNKNOWN').strip().upper()
    district = (metadata.get('district') or 'UNKNOWN').strip()

    listing_type_key = metadata.get('listingType', 'BOOKING')
    listing_type = LISTING_TYPE_MAP.get(listing_type_key, listing_type_key)

    property_type_key = metadata.get('propertyType') or metadata.get('type', 'APARTMENT')
    property_type = PROPERTY_TYPE_MAP.get(property_type_key, property_type_key)

    folder = Path(DATA_BASE_PATH) / country / city / district / listing_type / property_type
    folder.mkdir(parents=True, exist_ok=True)

    timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
    orig_filename = f"img_{timestamp}.jpg"
    orig_path = str(folder / orig_filename)

    if not download_image(image_url, orig_path):
        return {'success': False, 'error': f'Failed to download image: {image_url}'}

    results = []
    try:
        image = Image.open(orig_path)
        for size in sizes:
            img_copy = image.copy()
            img_copy.thumbnail((size['width'], size['height']), Image.Resampling.LANCZOS)
            output_path = str(folder / f"img_{timestamp}_{size['name']}.jpg")
            img_copy.save(output_path, 'JPEG', quality=85, optimize=True)
            results.append({
                'size': size['name'],
                'path': output_path,
                'dimensions': img_copy.size,
            })

        return {
            'success': True,
            'original': orig_path,
            'folder': str(folder),
            'processed': results,
            'metadata': {
                'country': country,
                'city': city,
                'district': district,
                'listingType': listing_type,
                'propertyType': property_type,
            },
            'processed_at': datetime.now().isoformat(),
        }
    except Exception as e:
        return {
            'success': False,
            'original': orig_path,
            'error': str(e),
        }

def send_notification(notification_type: str, data: dict) -> dict:
    try:
        print(f"Sending {notification_type} notification: {data}")
        return {
            'success': True,
            'type': notification_type,
            'sent_at': datetime.now().isoformat()
        }
    except Exception as e:
        return {
            'success': False,
            'error': str(e)
        }

def callback(ch, method, properties, body):
    try:
        data = json.loads(body)
        workflow = data.get('workflow') or data.get('type')
        task_data = data.get('data', {})

        print(f"Processing task: {workflow}")

        if workflow == 'image-process':
            image_path = task_data.get('image_path')
            metadata = {
                'country': task_data.get('country'),
                'city': task_data.get('city'),
                'district': task_data.get('district'),
                'listingType': task_data.get('listingType'),
                'propertyType': task_data.get('propertyType'),
                'type': task_data.get('type'),
            }
            result = process_image(image_path, metadata)
        elif workflow == 'notification':
            result = send_notification(task_data.get('notification_type'), task_data)
        else:
            result = {'success': False, 'error': f'Unknown workflow: {workflow}'}

        print(f"Task completed: {result}")
        skipper_url = os.getenv('SKIPPER_API_URL', 'http://localhost:8080')
        task_id = data.get('task_id')
        if task_id:
            try:
                requests.post(
                    f"{skipper_url}/api/v1/skipper/tasks/{task_id}/update",
                    params={
                        'task_id': task_id,
                        'status': 'completed' if result.get('success') else 'failed',
                        'progress': 100,
                    },
                    json={'result': result} if result.get('success') else {'error': result.get('error')},
                    timeout=5,
                )
            except Exception as e:
                print(f"Failed to update task status: {e}")

        ch.basic_ack(delivery_tag=method.delivery_tag)

    except Exception as e:
        print(f"Error processing message: {e}")
        ch.basic_nack(delivery_tag=method.delivery_tag, requeue=False)

def main():
    print("Starting General Task Worker...")

    credentials = pika.PlainCredentials(RABBITMQ_USER, RABBITMQ_PASS)
    parameters = pika.ConnectionParameters(
        host=RABBITMQ_HOST,
        credentials=credentials,
        heartbeat=600,
        blocked_connection_timeout=300,
    )

    connection = pika.BlockingConnection(parameters)
    channel = connection.channel()

    queues = ['image-queue', 'notification-queue']
    for queue_name in queues:
        channel.queue_declare(queue=queue_name, durable=True)
        channel.basic_consume(queue=queue_name, on_message_callback=callback)

    channel.basic_qos(prefetch_count=1)

    print(f"Worker ready. Listening on queues: {queues}")
    channel.start_consuming()

if __name__ == '__main__':
    main()
