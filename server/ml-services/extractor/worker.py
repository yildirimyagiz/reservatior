"""
Data Extraction Worker
Extracts structured data from documents (amounts, dates, entities, etc.)
"""

import pika
import json
import os
import re
import requests
from datetime import datetime
from dateutil import parser as date_parser

# Configuration
RABBITMQ_HOST = os.getenv('RABBITMQ_HOST', 'localhost')
RABBITMQ_USER = os.getenv('RABBITMQ_USER', 'admin')
RABBITMQ_PASS = os.getenv('RABBITMQ_PASS', 'admin123')
SKIPPER_API = os.getenv('SKIPPER_API_URL', 'http://skipper-api:8080')

def extract_amounts(text: str) -> list:
    """Extract monetary amounts from text"""
    # Patterns for amounts: $123.45, 123.45, $123, etc.
    patterns = [
        r'\$\s*(\d{1,3}(?:,\d{3})*(?:\.\d{2})?)',  # $1,234.56
        r'(\d{1,3}(?:,\d{3})*\.\d{2})\s*(?:USD|usd|\$)',  # 1,234.56 USD
        r'(?:total|amount|paid|due)[\s:]*\$?\s*(\d+(?:\.\d{2})?)',  # total: $123.45
    ]
    
    amounts = []
    for pattern in patterns:
        matches = re.finditer(pattern, text, re.IGNORECASE)
        for match in matches:
            amount_str = match.group(1).replace(',', '')
            try:
                amount = float(amount_str)
                amounts.append(amount)
            except ValueError:
                continue
    
    return list(set(amounts))  # Remove duplicates

def extract_dates(text: str) -> list:
    """Extract dates from text"""
    # Common date patterns
    patterns = [
        r'\d{1,2}[/-]\d{1,2}[/-]\d{2,4}',  # 12/31/2024 or 12-31-24
        r'\d{4}[/-]\d{1,2}[/-]\d{1,2}',    # 2024-12-31
        r'(?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)[a-z]*\s+\d{1,2},?\s+\d{4}',  # January 1, 2024
    ]
    
    dates = []
    for pattern in patterns:
        matches = re.finditer(pattern, text, re.IGNORECASE)
        for match in matches:
            try:
                date_obj = date_parser.parse(match.group(0), fuzzy=True)
                dates.append(date_obj.isoformat())
            except:
                continue
    
    return list(set(dates))

def extract_emails(text: str) -> list:
    """Extract email addresses"""
    pattern = r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b'
    return list(set(re.findall(pattern, text)))

def extract_phones(text: str) -> list:
    """Extract phone numbers"""
    patterns = [
        r'\(?\d{3}\)?[-.\s]?\d{3}[-.\s]?\d{4}',  # (123) 456-7890
        r'\+\d{1,3}[-.\s]?\(?\d{1,4}\)?[-.\s]?\d{1,4}[-.\s]?\d{1,9}',  # +1-123-456-7890
    ]
    
    phones = []
    for pattern in patterns:
        phones.extend(re.findall(pattern, text))
    
    return list(set(phones))

def extract_receipt_data(text: str) -> dict:
    """Extract data specific to receipts"""
    data = {
        'amounts': extract_amounts(text),
        'dates': extract_dates(text),
        'emails': extract_emails(text),
        'phones': extract_phones(text)
    }
    
    # Try to identify specific fields
    text_lower = text.lower()
    
    # Total amount (usually the largest or last amount)
    if data['amounts']:
        data['total'] = max(data['amounts'])
    
    # Vendor name (usually first line or near top)
    lines = text.split('\n')
    for line in lines[:5]:
        if line.strip() and len(line.strip()) > 3:
            data['vendor'] = line.strip()
            break
    
    # Tax amount
    tax_match = re.search(r'tax[\s:]*\$?\s*(\d+\.\d{2})', text_lower)
    if tax_match:
        data['tax'] = float(tax_match.group(1))
    
    return data

def extract_lease_data(text: str) -> dict:
    """Extract data specific to lease agreements"""
    data = {
        'amounts': extract_amounts(text),
        'dates': extract_dates(text),
        'emails': extract_emails(text),
        'phones': extract_phones(text)
    }
    
    # Rent amount
    rent_match = re.search(r'(?:rent|monthly payment)[\s:]*\$?\s*(\d+(?:,\d{3})*(?:\.\d{2})?)', text, re.IGNORECASE)
    if rent_match:
        data['rent_amount'] = float(rent_match.group(1).replace(',', ''))
    
    # Lease term
    term_match = re.search(r'(\d+)\s*(?:month|year)s?\s*(?:term|lease)', text, re.IGNORECASE)
    if term_match:
        data['lease_term'] = term_match.group(0)
    
    # Security deposit
    deposit_match = re.search(r'(?:security deposit|deposit)[\s:]*\$?\s*(\d+(?:,\d{3})*(?:\.\d{2})?)', text, re.IGNORECASE)
    if deposit_match:
        data['security_deposit'] = float(deposit_match.group(1).replace(',', ''))
    
    return data

def extract_data(text: str, doc_type: str) -> dict:
    """Extract data based on document type"""
    if doc_type == 'receipt':
        return extract_receipt_data(text)
    elif doc_type == 'lease':
        return extract_lease_data(text)
    else:
        # Generic extraction
        return {
            'amounts': extract_amounts(text),
            'dates': extract_dates(text),
            'emails': extract_emails(text),
            'phones': extract_phones(text)
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
    """Process incoming extraction tasks"""
    try:
        data = json.loads(body)
        task_id = data.get('task_id')
        text = data['data'].get('text', '')
        doc_type = data['data'].get('type', 'unknown')
        
        print(f"Extracting data from {doc_type} for task {task_id}")
        
        # Update status: processing
        update_task_status(task_id, 'processing', 50)
        
        # Extract data
        result = extract_data(text, doc_type)
        result['extracted_at'] = datetime.now().isoformat()
        result['document_type'] = doc_type
        
        # Update status: completed
        update_task_status(task_id, 'completed', 100, result=result)
        print(f"Extraction completed for task {task_id}")
        
        # Acknowledge message
        ch.basic_ack(delivery_tag=method.delivery_tag)
        
    except Exception as e:
        print(f"Error processing message: {e}")
        update_task_status(task_id, 'failed', 0, error=str(e))
        ch.basic_nack(delivery_tag=method.delivery_tag, requeue=False)

def main():
    """Start extractor worker"""
    print("Starting Data Extraction Worker...")
    
    # Connect to RabbitMQ
    credentials = pika.PlainCredentials(RABBITMQ_USER, RABBITMQ_PASS)
    parameters = pika.ConnectionParameters(
        host=RABBITMQ_HOST,
        credentials=credentials,
        heartbeat=600,
        blocked_connection_timeout=300
    )
    
    connection = pika.BlockingConnection(parameters)
    channel = connection.channel()
    
    # Declare queues
    queues = ['receipt-queue', 'lease-queue']
    for queue_name in queues:
        channel.queue_declare(queue=queue_name, durable=True)
        channel.basic_consume(
            queue=queue_name,
            on_message_callback=callback
        )
    
    # Set QoS
    channel.basic_qos(prefetch_count=1)
    
    print(f"Extractor Worker ready. Listening on queues: {queues}")
    channel.start_consuming()

if __name__ == '__main__':
    main()
