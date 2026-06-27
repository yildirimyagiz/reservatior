
class MockTable:
    async def find_many(self, *args, **kwargs):
        return []
    
    async def find_unique(self, *args, **kwargs):
        # Used for finding property/agent
        return None
        
    async def find_first(self, *args, **kwargs):
        return None
        
    async def create(self, *args, **kwargs):
        return None

class MockDB:
    def __init__(self):
        self.brochurejob = MockTable()
        self.property = MockTable()
        self.user = MockTable()
        self.subscription = MockTable()

db = MockDB()
