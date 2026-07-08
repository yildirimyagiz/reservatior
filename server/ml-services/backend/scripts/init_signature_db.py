import asyncio
from app.signature.infrastructure.database import engine
from app.signature.domain.models import Base

async def init_models():
    async with engine.begin() as conn:
        # Create all tables defined in Base
        await conn.run_sync(Base.metadata.create_all)
        print("Signature Engine tables created successfully.")

if __name__ == "__main__":
    asyncio.run(init_models())
