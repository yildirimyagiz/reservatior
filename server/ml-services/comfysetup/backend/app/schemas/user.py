from enum import Enum
from typing import Optional, List
from pydantic import BaseModel
from datetime import datetime

class UserBase(BaseModel):
    email: str
    phoneNumber: Optional[str] = None
    stripeCustomerId: Optional[str] = None

class UserCreate(UserBase):
    pass

class User(UserBase):
    id: str
    createdAt: datetime
    updatedAt: datetime
    emailVerified: Optional[datetime] = None
    phoneVerified: Optional[datetime] = None
    
    class Config:
        from_attributes = True
