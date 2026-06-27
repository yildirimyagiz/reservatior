
from pydantic import BaseModel
from typing import Optional

class User(BaseModel):
    id: str = "user_123"
    profileImageUrl: Optional[str] = None
    email: str = "test@example.com"

async def get_current_user() -> User:
    return User()
