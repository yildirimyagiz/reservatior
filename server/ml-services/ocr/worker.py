"""
OCR Worker Service
Processes documents and extracts text using Tesseract OCR
"""

import pika
import json
import os
import time
import pytesseract
from PIL import Image
from pdf2image import convert_from_path
import requests
from datetime import datetime

# Configuration
RABBITMQ_HOST = os.getenv('RABBITMQ_HOST', 'localhost')
RABBITMQ_USER = os.getenv('RABBITMQ_USER', 'admin')
RABBITMQ_PASS = os.getenv('RABBITMQ_PASS', 'admin123')
SKIPPER_API = os.getenv('SKIPPER_API_URL', 'http://skipper-api:8080')

def process_ocr(file_path: str) -> dict:
    """
    Process document with OCR
    Supports: images (jpg, png) and PDFs
    """
    try:
        # Determine file type
        ext = os.path.splitext(file_path)[1].lower()
        
        if ext == '.pdf':
            # Convert PDF to images
            images = convert_from_path(file_path)
            text = ""
            for i, image in enumerate(images):
                page_text = pytesseract.image_to_string(image)
                text += f"\n--- Page {i+1} ---\n{page_text}"
        else:
            # Process image directly
            image = Image.open(file_path)
            text = pytesseract.image_to_string(image)
        
        # Get confidence score
        data = pytesseract.image_to_data(image if ext != '.pdf' else images[0], output_type=pytesseract.Output.DICT)
        confidences = [int(conf) for conf in data['conf'] if conf != '-1']
        avg_confidence = sum(confidences) / len(confidences) if confidences else 0
        
        return {
            'success': True,
            'text': text.strip(),
            'confidence': avg_confidence / 100,
            'pages': len(images) if ext == '.pdf' else 1,
            'processed_at': datetime.now().isoformat()
        }
    except Exception as e:
        return {
            'success': False,
            'error': str(e)
        }

def update_task_status(task_id: str, status: str, progress: int, result: dict = None, error: str = None):
    """Update task status in Skipper API"""
    try:
        requests.post(
            f"{SKIPPER_API}/api/v1/skipper/tasks/{task_id}/update",
            json={
                'status': status,
                'progress': progress,
                'result': result,
                'error': error
            }
        )
    except Exception as e:
        print(f"Failed to update task status: {e}")

def callback(ch, method, properties, body):
    """Process incoming OCR tasks"""
    try:
        data = json.loads(body)
        task_id = data.get('task_id')
        file_path = data['data'].get('file_path')
        
        print(f"Processing OCR task {task_id} for file: {file_path}")
        
        # Update status: processing
        update_task_status(task_id, 'processing', 25)
        
        # Process OCR
        result = process_ocr(file_path)
        
        if result['success']:
            # Update status: completed
            update_task_status(task_id, 'completed', 100, result=result)
            print(f"OCR completed for task {task_id}")
        else:
            # Update status: failed
            update_task_status(task_id, 'failed', 0, error=result['error'])
            print(f"OCR failed for task {task_id}: {result['error']}")
        
        # Acknowledge message
        ch.basic_ack(delivery_tag=method.delivery_tag)
        
    except Exception as e:
        print(f"Error processing message: {e}")
        ch.basic_nack(delivery_tag=method.delivery_tag, requeue=False)

def main():
    """Start OCR worker"""
    print("Starting OCR Worker...")
    
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
    
    # Declare queue
    queue_name = 'ocr-queue'
    channel.queue_declare(queue=queue_name, durable=True)
    
    # Set QoS
    channel.basic_qos(prefetch_count=1)
    
    # Start consuming
    channel.basic_consume(
        queue=queue_name,
        on_message_callback=callback
    )
    
    print(f"OCR Worker ready. Listening on queue: {queue_name}")
    channel.start_consuming()

if __name__ == '__main__':
    main()
