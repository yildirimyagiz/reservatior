"""
General Task Worker
Handles various background tasks: image processing, notifications, etc.
"""

import pika
import json
import os
import time
from PIL import Image
import requests
from datetime import datetime

# Configuration
RABBITMQ_HOST = os.getenv('RABBITMQ_HOST', 'localhost')
RABBITMQ_USER = os.getenv('RABBITMQ_USER', 'admin')
RABBITMQ_PASS = os.getenv('RABBITMQ_PASS', 'admin123')

def process_image(image_path: str, sizes: list = None) -> dict:
    """
    Process and resize images
    Default sizes: thumbnail (150x150), medium (800x600), large (1920x1080)
    """
    if sizes is None:
        sizes = [
            {'name': 'thumbnail', 'width': 150, 'height': 150},
            {'name': 'medium', 'width': 800, 'height': 600},
            {'name': 'large', 'width': 1920, 'height': 1080}
        ]
    
    try:
        image = Image.open(image_path)
        results = []
        
        for size in sizes:
            # Resize maintaining aspect ratio
            image.thumbnail((size['width'], size['height']), Image.Resampling.LANCZOS)
            
            # Save resized image
            output_path = f"{os.path.splitext(image_path)[0]}_{size['name']}.jpg"
            image.save(output_path, 'JPEG', quality=85, optimize=True)
            
            results.append({
                'size': size['name'],
                'path': output_path,
                'dimensions': image.size
            })
        
        return {
            'success': True,
            'original': image_path,
            'processed': results,
            'processed_at': datetime.now().isoformat()
        }
    except Exception as e:
        return {
            'success': False,
            'error': str(e)
        }

def send_notification(notification_type: str, data: dict) -> dict:
    """
    Send notifications (email, SMS, push)
    """
    try:
        # TODO: Implement actual notification sending
        # For now, just log
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
    """Process incoming tasks"""
    try:
        data = json.loads(body)
        task_type = data.get('type')
        task_data = data.get('data', {})
        
        print(f"Processing task: {task_type}")
        
        if task_type == 'image-process':
            result = process_image(task_data.get('image_path'))
        elif task_type == 'notification':
            result = send_notification(task_data.get('notification_type'), task_data)
        else:
            result = {'success': False, 'error': f'Unknown task type: {task_type}'}
        
        print(f"Task completed: {result}")
        
        # Acknowledge message
        ch.basic_ack(delivery_tag=method.delivery_tag)
        
    except Exception as e:
        print(f"Error processing message: {e}")
        ch.basic_nack(delivery_tag=method.delivery_tag, requeue=False)

def main():
    """Start general task worker"""
    print("Starting General Task Worker...")
    
    # Connect to RabbitMQ with retry
    while True:
        try:
            credentials = pika.PlainCredentials(RABBITMQ_USER, RABBITMQ_PASS)
            parameters = pika.ConnectionParameters(
                host=RABBITMQ_HOST,
                credentials=credentials,
                heartbeat=600,
                blocked_connection_timeout=300
            )
            connection = pika.BlockingConnection(parameters)
            break
        except Exception as e:
            print(f"RabbitMQ connection failed: {e}, retrying in 5s...")
            time.sleep(5)
    channel = connection.channel()
    
    # Declare queues
    queues = ['image-queue', 'notification-queue']
    for queue_name in queues:
        channel.queue_declare(queue=queue_name, durable=True)
        channel.basic_consume(
            queue=queue_name,
            on_message_callback=callback
        )
    
    # Set QoS
    channel.basic_qos(prefetch_count=1)
    
    print(f"Worker ready. Listening on queues: {queues}")
    channel.start_consuming()

if __name__ == '__main__':
    main()
