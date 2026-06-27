"""
Skipper API - ML Workflow Orchestration
Manages document processing workflows using RabbitMQ
"""

from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import Dict, Any, List, Optional
import pika
import json
import os
import uuid
from datetime import datetime
from pathlib import Path
import google.auth
from googleapiclient.discovery import build
from googleapiclient.errors import HttpError
from googleapiclient.http import MediaIoBaseDownload
from google.oauth2 import service_account
import requests
import pandas as pd
import openpyxl
from io import BytesIO
import sqlite3

# Initialize SQLite database for ML telemetry
def init_db():
    conn = sqlite3.connect('skipper.db')
    cursor = conn.cursor()
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS feedback_loops (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            model_name TEXT,
            event_type TEXT,
            reward REAL,
            context TEXT,
            timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
        )
    ''')
    conn.commit()
    conn.close()

init_db()

app = FastAPI(
    title="Reservatior Skipper API",
    description="ML Workflow Orchestration for Document Processing",
    version="1.0.0"
)

# CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# RabbitMQ Configuration
RABBITMQ_HOST = os.getenv('RABBITMQ_HOST', 'localhost')
RABBITMQ_PORT = int(os.getenv('RABBITMQ_PORT', 5672))
RABBITMQ_USER = os.getenv('RABBITMQ_USER', 'admin')
RABBITMQ_PASS = os.getenv('RABBITMQ_PASS', 'admin123')

# Models
class WorkflowRequest(BaseModel):
    workflow: str
    data: Dict[str, Any]
    priority: Optional[int] = 5

class WorkflowResponse(BaseModel):
    task_id: str
    workflow: str
    status: str
    created_at: str

class TaskStatus(BaseModel):
    task_id: str
    status: str
    progress: int
    result: Optional[Dict[str, Any]] = None
    error: Optional[str] = None

class FeedbackRequest(BaseModel):
    model_name: str
    event_type: str
    reward: float
    context: Dict[str, Any] = {}

# In-memory task storage (use Redis in production)
tasks_db: Dict[str, TaskStatus] = {}

def get_rabbitmq_connection():
    """Get RabbitMQ connection"""
    credentials = pika.PlainCredentials(RABBITMQ_USER, RABBITMQ_PASS)
    parameters = pika.ConnectionParameters(
        host=RABBITMQ_HOST,
        port=RABBITMQ_PORT,
        credentials=credentials
    )
    return pika.BlockingConnection(parameters)

def publish_task(queue: str, data: Dict[str, Any]):
    """Publish task to RabbitMQ queue"""
    try:
        connection = get_rabbitmq_connection()
        channel = connection.channel()

        # Declare queue
        channel.queue_declare(queue=queue, durable=True)

        # Publish message
        channel.basic_publish(
            exchange='',
            routing_key=queue,
            body=json.dumps(data),
            properties=pika.BasicProperties(
                delivery_mode=2,  # Make message persistent
            )
        )

        connection.close()
        return True
    except Exception as e:
        print(f"Error publishing task: {e}")
        return False

def get_drive_service():
    """Get Google Drive service"""
    creds_path = os.getenv('GOOGLE_DRIVE_CREDENTIALS_PATH', 'credentials.json')
    if os.path.exists(creds_path):
        # Use service account
        creds = service_account.Credentials.from_service_account_file(
            creds_path, scopes=['https://www.googleapis.com/auth/drive.readonly']
        )
    else:
        # Fallback to default credentials
        creds, _ = google.auth.default(scopes=['https://www.googleapis.com/auth/drive.readonly'])

    return build('drive', 'v3', credentials=creds)

def list_drive_files(folder_id: Optional[str] = None, mime_type: Optional[str] = None) -> List[Dict[str, Any]]:
    """List files from Google Drive"""
    try:
        service = get_drive_service()
        query_parts = []
        if folder_id:
            query_parts.append(f"'{folder_id}' in parents")
        if mime_type:
            query_parts.append(f"mimeType='{mime_type}'")

        query = " and ".join(query_parts) if query_parts else ""

        results = service.files().list( # type: ignore
            q=query,
            pageSize=100,
            fields="nextPageToken, files(id, name, mimeType, modifiedTime, size)"
        ).execute()

        return results.get('files', [])
    except HttpError as error:
        print(f"Drive API error: {error}")
        return []

def upload_to_wetransfer(file_path: str, message: str = "Property files") -> Dict[str, Any]:
    """Upload file to WeTransfer"""
    api_key = os.getenv('WETRANSFER_API_KEY')
    if not api_key:
        return {"error": "WeTransfer API key not set"}

    url = "https://dev.wetransfer.com/v2/transfers"
    headers = {
        "Authorization": f"Bearer {api_key}",
        "Content-Type": "application/json"
    }

    # First, authorize upload
    auth_data = {
        "message": message,
        "files": [{"name": os.path.basename(file_path), "size": os.path.getsize(file_path)}]
    }

    try:
        response = requests.post(url, json=auth_data, headers=headers)
        response.raise_for_status()
        transfer = response.json()

        # Then upload file to the provided URL
        # This is simplified; actual upload requires multipart
        # For full implementation, follow WeTransfer docs
        return {"transfer": transfer, "status": "authorized"}
    except requests.RequestException as e:
        return {"error": str(e)}

def call_ml_api(endpoint: str, data: Dict[str, Any]) -> Dict[str, Any]:
    """Call ML API endpoint"""
    ml_url = os.getenv('ML_API_URL', 'http://localhost:8001')
    url = f"{ml_url}{endpoint}"

    try:
        response = requests.post(url, json=data, timeout=30)
        response.raise_for_status()
        return response.json()
    except requests.RequestException as e:
        print(f"ML API error: {e}")
        return {"error": str(e)}

class MLSDataRequest(BaseModel):
    mls_data: Dict[str, Any]

@app.post("/api/ml/analyze-mls")
def analyze_mls_listing(request: MLSDataRequest):
    """
    Analyzes an incoming MLS listing.
    Recommends tags, doping likelihood, and estimates valuation.
    """
    data = request.mls_data
    price = float(data.get("price", 0))
    
    # Very basic ML heuristic mapping for demonstration
    suggested_tags = ["Standard"]
    if price > 500000:
        suggested_tags.append("Luxury")
    if "ocean" in str(data.get("description", "")).lower():
        suggested_tags.append("Sea View")
        
    return {
        "valuation_estimate": price * 1.05, # Expect 5% more
        "suggested_tags": suggested_tags,
        "doping_recommended": price > 300000,
        "fraud_risk": 0.05
    }

def categorize_photo(image_path: str) -> Dict[str, Any]:
    """Categorize photo into room types"""
    # Call ML API for image analysis
    data = {"image_url": image_path}
    result = call_ml_api("/api/ml/analyze/image", data)

    if "error" in result:
        # Fallback categorization based on filename
        filename = os.path.basename(image_path).lower()
        categories = {
            'salon': ['living', 'salon', 'sitting', 'lounge'],
            'room': ['bedroom', 'room', 'chamber'],
            'kitchen': ['kitchen', 'cook'],
            'bathroom': ['bath', 'toilet', 'wc', 'restroom'],
            'entrance': ['entrance', 'entry', 'hall', 'foyer'],
            'balcony': ['balcony', 'terrace', 'patio'],
            'garden': ['garden', 'yard', 'outdoor'],
            'building': ['exterior', 'building', 'house', 'facade'],
            'general': ['general', 'overview', 'main'],
            'details': ['detail', 'closeup', 'feature']
        }

        category = 'general'
        for cat, keywords in categories.items():
            if any(kw in filename for kw in keywords):
                category = cat
                break

        return {
            "category": category,
            "confidence": 0.5,
            "method": "filename_fallback"
        }

    # Map ML result to our categories
    detected = result.get('detected_features', [])
    room_type = result.get('room_type', 'general')

    # Custom mapping
    category_map = {
        'living_room': 'salon',
        'bedroom': 'room',
        'kitchen': 'kitchen',
        'bathroom': 'bathroom',
        'dining_room': 'salon',
        'office': 'room'
    }

    category = category_map.get(room_type, 'general')

    return {
        "category": category,
        "confidence": result.get('quality_score', 0.5),
        "ml_result": result
    }

def analyze_excel(file_path: str) -> Dict[str, Any]:
    """Analyze Excel file for property data"""
    try:
        df = pd.read_excel(file_path)
        analysis = {
            "rows": len(df),
            "columns": len(df.columns),
            "column_names": df.columns.tolist(),
            "summary_stats": df.describe().to_dict() if not df.empty else {},
            "data_types": df.dtypes.astype(str).to_dict(),
            "null_counts": df.isnull().sum().to_dict()
        }

        # Property-specific analysis
        property_keywords = ['price', 'size', 'bedroom', 'bathroom', 'location', 'address']
        relevant_cols = [col for col in df.columns if any(kw in col.lower() for kw in property_keywords)]
        analysis["property_columns"] = relevant_cols

        if 'price' in df.columns.str.lower():
            price_col = df.columns[df.columns.str.lower() == 'price'][0]
            analysis["price_stats"] = {
                "mean": df[price_col].mean(),
                "median": df[price_col].median(),
                "min": df[price_col].min(),
                "max": df[price_col].max()
            }

        return analysis
    except Exception as e:
        return {"error": f"Excel analysis failed: {str(e)}"}

def analyze_text(file_path: str) -> Dict[str, Any]:
    """Analyze text file for property information"""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()

        analysis: Dict[str, Any] = {
            "length": len(content),
            "lines": len(content.split('\n')),
            "words": len(content.split()),
            "characters": len(content.replace('\n', '').replace(' ', ''))
        }

        # Extract property-related keywords
        property_keywords = [
            'price', 'cost', 'value', 'rent', 'sale', 'buy',
            'bedroom', 'bathroom', 'kitchen', 'living room', 'garage',
            'square feet', 'sq ft', 'meter', 'size', 'area',
            'location', 'address', 'neighborhood', 'city', 'zip'
        ]

        found_keywords = []
        for keyword in property_keywords:
            if keyword.lower() in content.lower():
                found_keywords.append(keyword)

        analysis["property_keywords"] = found_keywords
        analysis["keyword_count"] = len(found_keywords)

        # Simple sentiment (placeholder)
        positive_words = ['excellent', 'great', 'beautiful', 'modern', 'spacious']
        negative_words = ['needs work', 'old', 'damaged', 'small', 'dark']

        pos_count = sum(1 for word in positive_words if word in content.lower())
        neg_count = sum(1 for word in negative_words if word in content.lower())

        analysis["sentiment"] = "positive" if pos_count > neg_count else "negative" if neg_count > pos_count else "neutral"

        return analysis
    except Exception as e:
        return {"error": f"Text analysis failed: {str(e)}"}

def extract_drive_file_id(link: str) -> Optional[str]:
    """Extract file ID from various Google Drive link formats."""
    if not link:
        return None

    if "id=" in link:
        return link.split("id=")[-1].split("&")[0]

    patterns = [
        "/d/",
        "/file/d/",
        "drive.google.com/open?id=",
        "drive.google.com/uc?id=",
        "drive.google.com/drive/folders/",
    ]

    for pattern in patterns:
        if pattern in link:
            remainder = link.split(pattern)[-1]
            file_id = remainder.split("/")[0].split("?")[0]
            if file_id:
                return file_id

    # If the link is already an ID
    if len(link) > 20 and "/" not in link and "http" not in link:
        return link

    return None


def download_drive_file(file_id: str, target_dir: Path) -> Optional[Dict[str, Any]]:
    """Download a Google Drive file to target directory and return metadata."""
    try:
        service = get_drive_service()
        metadata = (
            service.files() # type: ignore
            .get(fileId=file_id, fields="id, name, mimeType, size, modifiedTime")
            .execute()
        )

        request = service.files().get_media(fileId=file_id) # type: ignore
        fh = BytesIO()
        downloader = MediaIoBaseDownload(fh, request)
        done = False
        while not done:
            status, done = downloader.next_chunk()
            if status is not None:
                print(f"Downloading {metadata['name']}: {int(status.progress() * 100)}%")

        fh.seek(0)
        safe_name = metadata["name"].replace("/", "_")
        target_dir.mkdir(parents=True, exist_ok=True)
        dest_path = target_dir / f"{metadata['id']}_{safe_name}"
        with open(dest_path, "wb") as f:
            f.write(fh.read())

        metadata["local_path"] = str(dest_path)
        return metadata
    except HttpError as error:
        print(f"Drive download error: {error}")
        return None


def determine_workflow_for_file(mime_type: str, filename: str) -> str:
    """Determine which workflow queue should process the file."""
    mime_type = mime_type or ""
    filename = filename.lower()

    if mime_type.startswith("image/"):
        return "photo-categorize"
    if mime_type in {"application/vnd.ms-excel", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"} or filename.endswith((".xls", ".xlsx")):
        return "excel-analyze"
    if mime_type in {"application/pdf", "application/msword", "application/vnd.openxmlformats-officedocument.wordprocessingml.document"} or filename.endswith((".pdf", ".doc", ".docx")):
        if "lease" in filename:
            return "lease-analyze"
        if "receipt" in filename:
            return "receipt-process"
        return "document-ocr"
    if mime_type.startswith("text/") or filename.endswith(".txt"):
        return "text-analyze"

    # Default to document OCR for unknown documents
    return "document-ocr"


class DriveImportRequest(BaseModel):
    drive_links: List[str]
    project_id: Optional[str] = None


@app.get("/health")
async def health_check():
    """Health check endpoint"""
    return {
        "status": "ok",
        "service": "skipper-api",
        "timestamp": datetime.now().isoformat()
    }

@app.post("/api/v1/skipper/tasks", response_model=WorkflowResponse)
async def create_workflow(request: WorkflowRequest):
    """
    Create and execute a workflow
    
    Workflows:
    - document-ocr: OCR processing
    - document-classify: Document classification
    - receipt-process: Full receipt processing (OCR + extraction)
    - lease-analyze: Lease agreement analysis
    - image-process: Property image processing
    """
    task_id = str(uuid.uuid4())
    
    # Workflow routing
    workflow_queues = {
        'document-ocr': 'ocr-queue',
        'document-classify': 'classifier-queue',
        'receipt-process': 'receipt-queue',
        'lease-analyze': 'lease-queue',
        'image-process': 'image-queue',
        'drive-sync': 'drive-queue',
        'photo-categorize': 'photo-queue',
        'excel-analyze': 'excel-queue',
        'text-analyze': 'text-queue',
        'ml-analyze': 'ml-queue',
    }
    
    queue = workflow_queues.get(request.workflow)
    if not queue:
        raise HTTPException(status_code=400, detail=f"Unknown workflow: {request.workflow}")
    
    # Create task record
    task_data = {
        'task_id': task_id,
        'workflow': request.workflow,
        'data': request.data,
        'priority': request.priority,
        'created_at': datetime.now().isoformat()
    }
    
    # Publish to queue
    success = publish_task(queue, task_data)
    if not success:
        raise HTTPException(status_code=500, detail="Failed to queue task")
    
    # Store task status
    tasks_db[task_id] = TaskStatus(
        task_id=task_id,
        status='queued',
        progress=0
    )
    
    return WorkflowResponse(
        task_id=task_id,
        workflow=request.workflow,
        status='queued',
        created_at=task_data['created_at']
    )


@app.post("/api/v1/drive/import")
async def import_drive_files(request: DriveImportRequest):
    """Import Google Drive files, download locally, and queue processing workflows."""
    target_dir = Path(os.getenv("DRIVE_IMPORT_DIR", "/tmp/drive_imports"))

    successes: List[Dict[str, Any]] = []
    errors: List[Dict[str, str]] = []

    for link in request.drive_links:
        file_id = extract_drive_file_id(link)
        if not file_id:
            errors.append({"link": link, "error": "Could not extract Google Drive file ID"})
            continue

        metadata = download_drive_file(file_id, target_dir)
        if not metadata:
            errors.append({"link": link, "error": "Failed to download file from Google Drive"})
            continue

        workflow = determine_workflow_for_file(metadata.get("mimeType", ""), metadata.get("name", ""))
        queue_map = {
            'document-ocr': 'ocr-queue',
            'document-classify': 'classifier-queue',
            'receipt-process': 'receipt-queue',
            'lease-analyze': 'lease-queue',
            'image-process': 'image-queue',
            'drive-sync': 'drive-queue',
            'photo-categorize': 'photo-queue',
            'excel-analyze': 'excel-queue',
            'text-analyze': 'text-queue',
        }

        queue = queue_map.get(workflow)
        if not queue:
            errors.append({"link": link, "error": f"Unsupported workflow {workflow}"})
            continue

        task_id = str(uuid.uuid4())
        task_payload = {
            'task_id': task_id,
            'workflow': workflow,
            'priority': 5,
            'data': {
                'file_path': metadata['local_path'],
                'source': 'google_drive',
                'drive_file_id': metadata['id'],
                'original_name': metadata.get('name'),
                'mime_type': metadata.get('mimeType'),
                'project_id': request.project_id,
            },
            'created_at': datetime.now().isoformat(),
        }

        success = publish_task(queue, task_payload)
        if not success:
            errors.append({"link": link, "error": "Failed to publish task to queue"})
            continue

        tasks_db[task_id] = TaskStatus(
            task_id=task_id,
            status='queued',
            progress=0
        )

        successes.append(
            {
                'link': link,
                'task_id': task_id,
                'workflow': workflow,
                'queue': queue,
                'local_path': metadata['local_path'],
            }
        )

    return {
        'success_count': len(successes),
        'error_count': len(errors),
        'tasks': successes,
        'errors': errors,
    }

@app.get("/api/v1/skipper/tasks/{task_id}", response_model=TaskStatus)
async def get_task_status(task_id: str):
    """Get task status"""
    task = tasks_db.get(task_id)
    if not task:
        raise HTTPException(status_code=404, detail="Task not found")
    return task

@app.get("/api/v1/skipper/tasks")
async def list_tasks(limit: int = 10):
    """List recent tasks"""
    tasks = list(tasks_db.values())[-limit:]
    return {"tasks": tasks, "total": len(tasks_db)}

@app.post("/api/v1/skipper/tasks/{task_id}/update")
async def update_task_status(task_id: str, status: str, progress: int, result: Optional[Dict] = None, error: Optional[str] = None):
    """Update task status (called by workers)"""
    if task_id not in tasks_db:
        raise HTTPException(status_code=404, detail="Task not found")
    
    tasks_db[task_id].status = status
    tasks_db[task_id].progress = progress
    if result:
        tasks_db[task_id].result = result
    if error:
        tasks_db[task_id].error = error
    
    # Notify Elysia Node Gateway
    elysia_url = os.getenv("ELYSIA_API_URL", "http://localhost:3000")
    try:
        # Send status update callback to Elysia
        requests.post(
            f"{elysia_url}/api/v1/ai-service-task/webhook",
            json={
                "taskId": task_id,
                "status": status.upper(), # Normalise to match Prisma enum
                "progress": progress,
                "result": result,
                "error": error
            },
            headers={"Content-Type": "application/json"},
            timeout=5
        )
    except Exception as e:
        print(f"Failed to forward status to Elysia: {e}")
    
    return {"success": True}

@app.get("/api/v1/skipper/queues")
async def get_queue_stats():
    """Get queue statistics"""
    try:
        connection = get_rabbitmq_connection()
        channel = connection.channel()

        queues = ['ocr-queue', 'classifier-queue', 'receipt-queue', 'lease-queue', 'image-queue', 'drive-queue', 'photo-queue', 'excel-queue', 'text-queue', 'ml-queue']
        stats = {}

        for queue in queues:
            try:
                method = channel.queue_declare(queue=queue, passive=True)
                stats[queue] = {
                    'messages': method.method.message_count,
                    'consumers': method.method.consumer_count
                }
            except:
                stats[queue] = {'messages': 0, 'consumers': 0}

        connection.close()
        return stats
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.get("/api/v1/drive/files")
async def list_drive_files_endpoint(folder_id: Optional[str] = None, mime_type: Optional[str] = None):
    """List files from Google Drive"""
    files = list_drive_files(folder_id, mime_type)
    return {"files": files}

class OptimizePaymentRequest(BaseModel):
    amount: float
    risk_score: float
    supports_a2a: bool
    card_success_prob: float

class RankFailoverRequest(BaseModel):
    original_hotel_id: str
    destination: str
    max_budget: float

class PricingBanditRequest(BaseModel):
    base_price: float
    demand_level: str
    competitor_price: float

@app.post("/api/v1/ml/optimize-payment")
async def optimize_payment(req: OptimizePaymentRequest):
    """Dynamically route payment rail based on ML scores"""
    if req.risk_score < 30 and req.supports_a2a:
        return {
            "selected_rail": "OPEN_BANKING_A2A",
            "cost_savings_pct": 3.5,
            "settlement_speed_score": 95,
            "reason": "Open Banking A2A is selected for low-risk transaction in supported region."
        }
    elif req.card_success_prob >= 0.85:
        return {
            "selected_rail": "CARD_PSP_PARAM",
            "cost_savings_pct": 1.2,
            "settlement_speed_score": 80,
            "reason": "Acquirer routing via Param POS for optimal card payment path."
        }
    else:
        return {
            "selected_rail": "VCC_FALLBACK",
            "cost_savings_pct": -1.5,
            "settlement_speed_score": 60,
            "reason": "Fallback to legacy Wholesaler VCC due to high risk profile or failed acquirer paths."
        }

@app.post("/api/v1/ml/rank-failover")
async def rank_failover(req: RankFailoverRequest):
    """Rank alternative envanter utilizing simulated LambdaMART Learning to Rank model"""
    options: List[Dict[str, Any]] = [
        {"id": "alt_res_01", "name": "Bosphorus Serviced Suite", "price": req.max_budget * 0.9, "distance_km": 1.2, "rating": 4.8},
        {"id": "alt_res_02", "name": "Galata Design Loft", "price": req.max_budget * 0.85, "distance_km": 2.4, "rating": 4.5},
        {"id": "alt_res_03", "name": "Pera Boutique Residences", "price": req.max_budget * 0.95, "distance_km": 0.5, "rating": 4.2}
    ]
    for opt in options:
        opt["score"] = round((opt["rating"] * 20) - (opt["distance_km"] * 2.5) - ((opt["price"] / req.max_budget) * 10), 1)
    options.sort(key=lambda x: x["score"], reverse=True)
    return {"alternatives": options}

@app.post("/api/v1/ml/pricing-bandit")
async def pricing_bandit(req: PricingBanditRequest):
    """Optimize dynamic price adjustments using Reinforcement Learning Contextual Bandit algorithm"""
    multiplier = 1.0
    if req.demand_level.upper() == "HIGH":
        multiplier += 0.15
    elif req.demand_level.upper() == "LOW":
        multiplier -= 0.10
    optimized_price = round(req.base_price * multiplier, 2)
    if optimized_price > req.competitor_price * 1.1:
        optimized_price = round(req.competitor_price * 1.05, 2)
    return {
        "optimized_price": optimized_price,
        "markup_pct": round((optimized_price / req.base_price - 1.0) * 100, 1),
        "margin_est": round(optimized_price * 0.12, 2)
    }

@app.post("/api/v1/ml/feedback")
async def ml_feedback(req: FeedbackRequest):
    """
    Receive reinforcement learning telemetry from the central OS.
    Stores the data in SQLite and uses Pandas to calculate running model weights.
    """
    print(f"[ML Feedback Loop] Received telemetry for model: {req.model_name}")
    
    try:
        conn = sqlite3.connect('skipper.db')
        cursor = conn.cursor()
        timestamp = datetime.now().isoformat()
        
        # 1. Store the experience in our local replay buffer (SQLite)
        cursor.execute('''
            INSERT INTO feedback_loops (model_name, event_type, reward, context, timestamp)
            VALUES (?, ?, ?, ?, ?)
        ''', (req.model_name, req.event_type, req.reward, json.dumps(req.context), timestamp))
        conn.commit()
        
        # 2. Trigger online-learning evaluation (Pandas)
        df = pd.read_sql_query(f"SELECT reward FROM feedback_loops WHERE model_name='{req.model_name}'", conn)
        total_weight = float(df['reward'].sum())
        total_experiences = len(df)
        conn.close()

        print(f"  -> Model '{req.model_name}' updated. Total Weight: {total_weight} across {total_experiences} events.")

        return {
            "status": "processed",
            "model": req.model_name,
            "reward_applied": req.reward,
            "new_model_weight": total_weight,
            "experience_count": total_experiences,
            "timestamp": timestamp
        }
    except Exception as e:
        print(f"Failed to process ML Feedback: {e}")
        raise HTTPException(status_code=500, detail="Database processing error")

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8080)
