from fastapi import FastAPI, UploadFile, File, HTTPException
from fastapi.responses import FileResponse, JSONResponse
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import List, Optional
import os
import uuid
import json
from datetime import datetime
import shutil
from pathlib import Path

# Models
class EBill(BaseModel):
    id: str
    customer_id: str
    customer_name: str
    customer_email: str
    bill_type: str  # 'UTILITY', 'INTERNET', 'PHONE', 'RENT', 'INSURANCE'
    provider: str
    account_number: str
    bill_date: str
    due_date: str
    amount: float
    currency: str
    status: str  # 'PENDING', 'PAID', 'OVERDUE', 'CANCELLED'
    file_path: str
    file_size: int
    file_type: str
    uploaded_at: str
    processed_at: Optional[str] = None
    ocr_data: Optional[dict] = None
    metadata: Optional[dict] = None

class EBillUploadResponse(BaseModel):
    id: str
    customer_id: str
    file_name: str
    file_size: int
    status: str
    message: str

class EBillProcessingResponse(BaseModel):
    id: str
    status: str
    ocr_data: Optional[dict] = None
    extracted_fields: Optional[dict] = None
    processing_time: float

# FastAPI App
app = FastAPI(
    title="E-Bills Processing Service",
    description="AI-powered electronic bill processing and storage",
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

# Storage paths
STORAGE_DIR = Path("storage/e-bills")
PROCESSED_DIR = Path("storage/e-bills/processed")
UPLOADS_DIR = Path("storage/e-bills/uploads")

# Create directories
for directory in [STORAGE_DIR, PROCESSED_DIR, UPLOADS_DIR]:
    directory.mkdir(parents=True, exist_ok=True)

# In-memory storage (for demo)
e_bills_db = []

@app.get("/")
async def root():
    return {
        "service": "E-Bills Processing",
        "version": "1.0.0",
        "status": "active",
        "endpoints": {
            "upload": "POST /upload",
            "list": "GET /bills",
            "get": "GET /bills/{bill_id}",
            "process": "POST /bills/{bill_id}/process",
            "delete": "DELETE /bills/{bill_id}",
            "download": "GET /bills/{bill_id}/download",
            "search": "GET /bills/search"
        }
    }

@app.post("/upload", response_model=EBillUploadResponse)
async def upload_ebill(
    file: UploadFile = File(...),
    customer_id: str = "default_customer",
    customer_name: str = "Default Customer",
    customer_email: str = "customer@example.com",
    bill_type: str = "UTILITY",
    provider: str = "Unknown",
    account_number: str = "N/A"
):
    """
    Upload e-bill file for processing
    """
    try:
        # Validate file
        if not file.content_type:
            raise HTTPException(status_code=400, detail="File type is required")
        
        # Generate unique ID
        bill_id = f"bill_{uuid.uuid4().hex[:8]}"
        
        # Save file
        file_extension = Path(file.filename).suffix
        safe_filename = f"{bill_id}_{file.filename}"
        file_path = UPLOADS_DIR / safe_filename
        
        with open(file_path, "wb") as buffer:
            shutil.copyfileobj(file.file, buffer)
        
        # Create bill record
        e_bill = EBill(
            id=bill_id,
            customer_id=customer_id,
            customer_name=customer_name,
            customer_email=customer_email,
            bill_type=bill_type,
            provider=provider,
            account_number=account_number,
            bill_date=datetime.now().isoformat(),
            due_date="",  # Will be extracted from OCR
            amount=0.0,  # Will be extracted from OCR
            currency="USD",
            status="PENDING",
            file_path=str(file_path),
            file_size=file.size,
            file_type=file.content_type,
            uploaded_at=datetime.now().isoformat()
        )
        
        e_bills_db.append(e_bill)
        
        return EBillUploadResponse(
            id=bill_id,
            customer_id=customer_id,
            file_name=safe_filename,
            file_size=file.size,
            status="uploaded",
            message="File uploaded successfully"
        )
        
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Upload failed: {str(e)}")

@app.get("/bills", response_model=List[EBill])
async def list_ebills(
    customer_id: Optional[str] = None,
    bill_type: Optional[str] = None,
    status: Optional[str] = None,
    limit: int = 50,
    offset: int = 0
):
    """
    List all e-bills with optional filtering
    """
    filtered_bills = e_bills_db
    
    if customer_id:
        filtered_bills = [bill for bill in filtered_bills if bill.customer_id == customer_id]
    
    if bill_type:
        filtered_bills = [bill for bill in filtered_bills if bill.bill_type == bill_type]
    
    if status:
        filtered_bills = [bill for bill in filtered_bills if bill.status == status]
    
    # Pagination
    paginated_bills = filtered_bills[offset:offset + limit]
    
    return paginated_bills

@app.get("/bills/{bill_id}", response_model=EBill)
async def get_ebill(bill_id: str):
    """
    Get specific e-bill by ID
    """
    bill = next((bill for bill in e_bills_db if bill.id == bill_id), None)
    
    if not bill:
        raise HTTPException(status_code=404, detail="Bill not found")
    
    return bill

@app.post("/bills/{bill_id}/process", response_model=EBillProcessingResponse)
async def process_ebill(bill_id: str):
    """
    Process e-bill with OCR and AI extraction
    """
    try:
        bill = next((bill for bill in e_bills_db if bill.id == bill_id), None)
        
        if not bill:
            raise HTTPException(status_code=404, detail="Bill not found")
        
        # Mock OCR processing (would integrate with OCR service)
        import time
        start_time = time.time()
        
        # Simulate processing time
        time.sleep(2)
        
        # Mock OCR results
        ocr_data = {
            "customer_name": bill.customer_name,
            "provider": bill.provider,
            "account_number": bill.account_number,
            "bill_date": "2026-03-15",
            "due_date": "2026-04-15",
            "amount": 150.75,
            "currency": "USD",
            "usage": {
                "electricity_kwh": 450,
                "gas_therms": 25,
                "water_gallons": 1200
            },
            "charges": {
                "electricity": 120.50,
                "gas": 20.25,
                "water": 10.00
            }
        }
        
        extracted_fields = {
            "customer_name": ocr_data["customer_name"],
            "provider": ocr_data["provider"],
            "account_number": ocr_data["account_number"],
            "bill_date": ocr_data["bill_date"],
            "due_date": ocr_data["due_date"],
            "amount": ocr_data["amount"],
            "currency": ocr_data["currency"],
            "total_usage_kwh": ocr_data["usage"]["electricity_kwh"],
            "total_amount_due": ocr_data["amount"]
        }
        
        processing_time = time.time() - start_time
        
        # Update bill record
        bill.status = "PROCESSED"
        bill.processed_at = datetime.now().isoformat()
        bill.ocr_data = ocr_data
        bill.metadata = extracted_fields
        
        # Move to processed folder
        processed_file_path = PROCESSED_DIR / f"{bill_id}_processed.json"
        with open(processed_file_path, "w") as f:
            json.dump({
                "bill_id": bill_id,
                "ocr_data": ocr_data,
                "extracted_fields": extracted_fields,
                "processed_at": bill.processed_at
            }, f, indent=2)
        
        return EBillProcessingResponse(
            id=bill_id,
            status="processed",
            ocr_data=ocr_data,
            extracted_fields=extracted_fields,
            processing_time=processing_time
        )
        
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Processing failed: {str(e)}")

@app.get("/bills/{bill_id}/download")
async def download_ebill(bill_id: str):
    """
    Download original e-bill file
    """
    bill = next((bill for bill in e_bills_db if bill.id == bill_id), None)
    
    if not bill:
        raise HTTPException(status_code=404, detail="Bill not found")
    
    file_path = Path(bill.file_path)
    
    if not file_path.exists():
        raise HTTPException(status_code=404, detail="File not found")
    
    return FileResponse(
        path=str(file_path),
        filename=Path(bill.file_path).name,
        media_type=bill.file_type
    )

@app.delete("/bills/{bill_id}")
async def delete_ebill(bill_id: str):
    """
    Delete e-bill
    """
    bill = next((bill for bill in e_bills_db if bill.id == bill_id), None)
    
    if not bill:
        raise HTTPException(status_code=404, detail="Bill not found")
    
    # Delete file
    file_path = Path(bill.file_path)
    if file_path.exists():
        file_path.unlink()
    
    # Remove from database
    e_bills_db.remove(bill)
    
    return {"message": "Bill deleted successfully"}

@app.get("/bills/search")
async def search_ebills(
    query: str,
    customer_id: Optional[str] = None,
    bill_type: Optional[str] = None
):
    """
    Search e-bills by content
    """
    filtered_bills = e_bills_db
    
    if customer_id:
        filtered_bills = [bill for bill in filtered_bills if bill.customer_id == customer_id]
    
    if bill_type:
        filtered_bills = [bill for bill in filtered_bills if bill.bill_type == bill_type]
    
    # Search in OCR data and metadata
    search_results = []
    for bill in filtered_bills:
        search_text = f"{bill.customer_name} {bill.provider} {bill.account_number}".lower()
        if query.lower() in search_text:
            search_results.append(bill)
    
    return search_results

@app.get("/storage/stats")
async def storage_stats():
    """
    Get storage statistics
    """
    total_bills = len(e_bills_db)
    pending_bills = len([bill for bill in e_bills_db if bill.status == "PENDING"])
    processed_bills = len([bill for bill in bill in e_bills_db if bill.status == "PROCESSED"])
    
    # Calculate storage size
    total_size = sum(bill.file_size for bill in e_bills_db)
    
    return {
        "total_bills": total_bills,
        "pending_bills": pending_bills,
        "processed_bills": processed_bills,
        "total_storage_mb": total_size / (1024 * 1024),
        "average_bill_size_mb": (total_size / total_bills) / (1024 * 1024) if total_bills > 0 else 0,
        "storage_directory": str(STORAGE_DIR),
        "processed_directory": str(PROCESSED_DIR),
        "uploads_directory": str(UPLOADS_DIR)
    }

@app.get("/health")
async def health_check():
    """
    Health check endpoint
    """
    return {
        "status": "healthy",
        "service": "e-bills-processing",
        "storage": "active",
        "total_bills": len(e_bills_db)
    }

if __name__ == "__main__":
    import uvicorn
    
    # Create directories if they don't exist
    for directory in [STORAGE_DIR, PROCESSED_DIR, UPLOADS_DIR]:
        directory.mkdir(parents=True, exist_ok=True)
    
    print("🚀 E-Bills Processing Service Starting...")
    print(f"📁 Storage Directory: {STORAGE_DIR.absolute()}")
    print(f"📁 Processed Directory: {PROCESSED_DIR.absolute()}")
    print(f"📁 Uploads Directory: {UPLOADS_DIR.absolute()}")
    print("🌐 Server running on http://localhost:8001")
    print("📚 API Documentation: http://localhost:8001/docs")
    
    uvicorn.run(
        "main:app",
        host="0.0.0.0",
        port=8001,
        reload=True
    )
