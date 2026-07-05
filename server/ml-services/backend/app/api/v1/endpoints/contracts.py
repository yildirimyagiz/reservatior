from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from typing import Optional, Dict, Any
import datetime
import uuid

router = APIRouter()

class PropertyInfo(BaseModel):
    id: str
    address: str
    city: str
    country: str
    price: float
    currency: str
    property_type: str

class PersonInfo(BaseModel):
    full_name: str
    identification_number: str
    address: str
    phone: str
    email: str

class ContractRequest(BaseModel):
    country_code: str
    contract_type: str  # "SALES", "RENTAL", "LEASE"
    property: PropertyInfo
    owner: PersonInfo
    buyer_or_tenant: PersonInfo
    additional_terms: Optional[str] = None

class ContractResponse(BaseModel):
    contract_id: str
    content_markdown: str
    country_applied: str
    generated_at: str

@router.post("/generate", response_model=ContractResponse)
async def generate_contract(request: ContractRequest) -> ContractResponse:
    """
    AI-powered dynamic contract generation based on country laws and property details.
    """
    # Mock LLM generation logic
    country = request.country_code.upper()
    
    # Template strings based on country
    if country == "TR":
        title = "GAYRİMENKUL SATIŞ SÖZLEŞMESİ" if request.contract_type == "SALES" else "KİRA SÖZLEŞMESİ"
        legal_basis = "Türk Borçlar Kanunu ilgili maddelerine istinaden"
    elif country == "US":
        title = "REAL ESTATE PURCHASE AGREEMENT" if request.contract_type == "SALES" else "LEASE AGREEMENT"
        legal_basis = "in accordance with state and federal laws"
    elif country == "UK":
        title = "PROPERTY SALE AGREEMENT" if request.contract_type == "SALES" else "TENANCY AGREEMENT"
        legal_basis = "in accordance with the Law of Property Act 1925"
    else:
        title = f"PROPERTY {request.contract_type} AGREEMENT"
        legal_basis = "in accordance with local regulations"

    # Generate Markdown content
    markdown_content = f"""# {title}

**Date:** {datetime.date.today().isoformat()}
**Legal Basis:** {legal_basis}

## 1. The Parties
**Owner (Seller/Landlord):**
Name: {request.owner.full_name}
ID/Passport: {request.owner.identification_number}
Address: {request.owner.address}

**Counterparty (Buyer/Tenant):**
Name: {request.buyer_or_tenant.full_name}
ID/Passport: {request.buyer_or_tenant.identification_number}
Address: {request.buyer_or_tenant.address}

## 2. Property Information
Address: {request.property.address}, {request.property.city}, {request.property.country}
Property Type: {request.property.property_type}
Agreed Price: {request.property.price} {request.property.currency}

## 3. Additional Terms
{request.additional_terms if request.additional_terms else "Standard terms and conditions apply."}

## 4. Signatures

_______________________                     _______________________
Owner Signature                             Counterparty Signature
"""

    return ContractResponse(
        contract_id=str(uuid.uuid4()),
        content_markdown=markdown_content,
        country_applied=country,
        generated_at=datetime.datetime.utcnow().isoformat()
    )
