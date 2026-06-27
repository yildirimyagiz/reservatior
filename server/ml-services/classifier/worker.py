"""
Document Classifier Worker
Classifies documents into categories: receipt, invoice, lease, contract, etc.
"""

import pika
import json
import os
import re
import requests
import time
from datetime import datetime

# Configuration
RABBITMQ_HOST = os.getenv('RABBITMQ_HOST', 'localhost')
RABBITMQ_USER = os.getenv('RABBITMQ_USER', 'admin')
RABBITMQ_PASS = os.getenv('RABBITMQ_PASS', 'admin123')
SKIPPER_API = os.getenv('SKIPPER_API_URL', 'http://skipper-api:8080')

def classify_document(text: str) -> dict:
    """
    Classify document based on text content
    Returns document type and confidence score
    """
    text_lower = text.lower()
    
    # Multilingual Keywords (EN, TR, ES, FR, DE)
    keywords = {
        'receipt': [
            'receipt', 'total', 'paid', 'tax', 'purchase', # EN
            'fiş', 'ödendi', 'tutar',                     # TR
            'recibo', 'pagado', 'factura simplificada',    # ES
            'reçu', 'ticket', 'payé',                      # FR
            'beleg', 'quittung', 'bezahlt'                 # DE
        ],
        'invoice': [
            'invoice', 'bill to', 'due date', 'amount due', # EN
            'fatura', 'vade', 'ödenecek',                   # TR
            'factura', 'fecha de vencimiento',              # ES
            'facture', 'échéance', 'montant dû',            # FR
            'rechnung', 'fälligkeitsdatum',                 # DE
        ],
        'lease': [
            'lease agreement', 'tenant', 'landlord', 'rent', # EN
            'kira sözleşmesi', 'kiracı', 'kiralayan',        # TR
            'contrato de arrendamiento', 'inquilino',        # ES
            'bail', 'contrat de location', 'locataire',      # FR
            'mietvertrag', 'mieter',                         # DE
        ],
        'contract': [
            'contract', 'agreement', 'terms', 'signature',  # EN
            'sözleşme', 'mutabakat', 'imza',                 # TR
            'contrato', 'acuerdo', 'firmas',                 # ES
            'contrat', 'accord', 'signature',               # FR
            'vertrag', 'vereinbarung',                       # DE
        ],
        'id_document': [
            'passport', 'driver license', 'identification',  # EN
            'kimlik', 'pasaport', 'tc no',                  # TR
            'pasaporte', 'licencia de conducir', 'identidad',# ES
            'passeport', 'permis de conduire',               # FR
            'reisepass', 'personalausweis',                  # DE
        ],
        'bank_statement': [
            'bank statement', 'account number', 'balance',   # EN
            'banka ekstresi', 'hesap özeti',                 # TR
            'estado de cuenta', 'número de cuenta',          # ES
            'relevé bancaire', 'compte',                     # FR
            'kontoauszug', 'kontonummer',                    # DE
        ],
        'utility_bill': [
            'utility', 'electric', 'water', 'gas',           # EN
            'fatura', 'elektrik', 'su', 'doğalgaz',          # TR
            'servicios', 'electricidad', 'agua',             # ES
            'facture d\'électricité', 'eau', 'gaz',          # FR
            'stromrechnung', 'wasser', 'gasrechnung',        # DE
        ],
        'maintenance_report': [
            'maintenance', 'repair', 'work order',           # EN
            'bakım', 'onarım', 'servis formu',               # TR
            'mantenimiento', 'reparación',                   # ES
            'maintenance', 'réparation',                     # FR
            'wartung', 'reparatur', 'arbeitsbericht',        # DE
        ]
    }
    
    # Calculate scores for each type
    scores = {}
    for doc_type, words in keywords.items():
        matches = sum(1 for word in words if word in text_lower)
        scores[doc_type] = matches / len(words)
    
    # Get best match
    best_type = max(scores, key=lambda k: scores[k])
    confidence = scores[best_type]
    
    # If confidence too low, mark as unknown
    if confidence < 0.2:
        return {
            'type': 'unknown',
            'confidence': 0.0,
            'suggestions': sorted(scores.items(), key=lambda x: x[1], reverse=True)[:3]
        }
    
    return {
        'type': best_type,
        'confidence': confidence,
        'all_scores': scores,
        'classified_at': datetime.now().isoformat()
    }

def update_task_status(task_id: str, status: str, progress: int, result: dict = {}, error: str = ""):
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
    """Process incoming classification tasks"""
    try:
        data = json.loads(body)
        task_id = data.get('task_id')
        text = data['data'].get('text', '')
        
        print(f"Classifying document for task {task_id}")
        
        # Update status: processing
        update_task_status(task_id, 'processing', 50)
        
        # Classify document
        result = classify_document(text)
        
        # Update status: completed
        update_task_status(task_id, 'completed', 100, result=result)
        print(f"Classification completed: {result['type']} (confidence: {result['confidence']:.2f})")
        
        # Acknowledge message
        ch.basic_ack(delivery_tag=method.delivery_tag)
        
    except Exception as e:
        print(f"Error processing message: {e}")
        update_task_status(task_id, 'failed', 0, error=str(e))
        ch.basic_nack(delivery_tag=method.delivery_tag, requeue=False)

def main():
    """Start classifier worker"""
    print("Starting Document Classifier Worker...")
    
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
    queue_name = 'classifier-queue'
    channel.queue_declare(queue=queue_name, durable=True)
    
    # Set QoS
    channel.basic_qos(prefetch_count=1)
    
    # Start consuming
    channel.basic_consume(
        queue=queue_name,
        on_message_callback=callback
    )
    
    print(f"Classifier Worker ready. Listening on queue: {queue_name}")
    channel.start_consuming()

if __name__ == '__main__':
    main()
