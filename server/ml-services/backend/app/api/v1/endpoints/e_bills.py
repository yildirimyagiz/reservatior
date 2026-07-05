from fastapi import APIRouter, HTTPException, UploadFile, File, Form
from pydantic import BaseModel
from typing import Optional, Dict, Any, List
import datetime
import uuid
import os

router = APIRouter()

# Temporary in-memory storage for mock purpose
BILLS_DB = {}
STORAGE_DIR = "storage/e-bills/uploads"
os.makedirs(STORAGE_DIR, exist_ok=True)

class BillProcessResponse(BaseModel):
    bill_id: str
    status: str
    extracted_data: Dict[str, Any]

@router.post("/upload")
async def upload_bill(
    file: UploadFile = File(...),
    customer_id: str = Form(...),
    customer_name: str = Form(...),
    bill_type: str = Form(...),
    provider: str = Form(...)
):
    """
    Upload an E-Bill document for OCR processing.
    """
    bill_id = str(uuid.uuid4())
    file_path = os.path.join(STORAGE_DIR, f"{bill_id}_{file.filename}")
    
    # Save file
    with open(file_path, "wb") as buffer:
        content = await file.read()
        buffer.write(content)
        
    BILLS_DB[bill_id] = {
        "id": bill_id,
        "filename": file.filename,
        "path": file_path,
        "customer_id": customer_id,
        "customer_name": customer_name,
        "bill_type": bill_type,
        "provider": provider,
        "status": "PENDING"
    }
    
    return {
        "success": True,
        "bill_id": bill_id,
        "message": "File uploaded successfully. Ready for processing."
    }

@router.post("/{bill_id}/process", response_model=BillProcessResponse)
async def process_bill(bill_id: str) -> BillProcessResponse:
    """
    Process the uploaded E-Bill using OCR (Mock implementation).
    """
    if bill_id not in BILLS_DB:
        raise HTTPException(status_code=404, detail="Bill not found")
        
    bill_info = BILLS_DB[bill_id]
    
    # Mock OCR Extraction Logic
    import random
    
    amount_due = round(random.uniform(50.0, 500.0), 2)
    due_date = (datetime.date.today() + datetime.timedelta(days=15)).isoformat()
    
    extracted_data = {
        "customer_name_found": bill_info["customer_name"],
        "provider_detected": bill_info["provider"],
        "total_amount_due": amount_due,
        "currency": "USD",
        "due_date": due_date,
        "confidence_score": 0.94,
        "line_items": [
            {"description": "Base Charge", "amount": round(amount_due * 0.8, 2)},
            {"description": "Taxes & Fees", "amount": round(amount_due * 0.2, 2)}
        ]
    }
    
    bill_info["status"] = "PROCESSED"
    bill_info["extracted_data"] = extracted_data
    
    return BillProcessResponse(
        bill_id=bill_id,
        status="PROCESSED",
        extracted_data=extracted_data
    )

@router.get("/")
async def list_bills(customer_id: Optional[str] = None):
    """
    List all uploaded bills.
    """
    if customer_id:
        filtered = [b for b in BILLS_DB.values() if b["customer_id"] == customer_id]
        return {"bills": filtered}
    return {"bills": list(BILLS_DB.values())}
