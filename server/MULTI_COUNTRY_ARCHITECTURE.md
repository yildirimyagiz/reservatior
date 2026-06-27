# Multi-Country Architecture

## Overview
This system is designed to be multi-country ready with separate databases for different regions.

## Architecture Decision: Universal Schema + Database URL Override

### Chosen Approach
- **Single Universal Schema**: `schema.prisma` contains all models from all countries
- **Database URL Override**: PrismaManager uses different database URLs per region
- **Direct Query Pattern**: Relationships are queried directly to avoid cross-database schema issues

### Why This Approach
1. **Minimal Refactoring**: Leverages existing PrismaManager infrastructure
2. **Schema Consistency**: All databases use the same schema structure
3. **Simplified Maintenance**: No need to manage 25+ separate Prisma clients
4. **Proven Working**: Turkish database successfully queries photos with this approach

## Implementation Details

### Database Configuration
- **Main Database**: `DATABASE_URL` (US/Default)
- **Turkish Database**: `DATABASE_URL_TR`
- **Other Regions**: `DATABASE_URL_AE`, `DATABASE_URL_UK`, etc.

### PrismaManager
```typescript
// Located in: server/src/lib/prisma.ts
- getClient(region?: string): Returns region-specific PrismaClient
- Uses datasources override to switch database connections
- Caches clients for performance
```

### Region Middleware
```typescript
// Located in: server/src/middleware/region.ts
- Extracts X-Region header from requests
- Provides region-specific PrismaClient to routes
- Falls back to default client if no region specified
```

### Route Pattern
```typescript
// All routes using region-specific database:
export const routes = new Elysia({ prefix: "/api" })
  .use(regionMiddleware)  // Provides db parameter
  .get("/", async ({ db }) => {
    const regionDb = db as any;
    // Use regionDb for all database queries
    const data = await regionDb.model.findMany(...);
  })
```

### Direct Query Pattern for Relationships
```typescript
// Instead of:
const property = await db.property.findUnique({
  where: { id },
  include: { photos: true }  // ❌ Doesn't work across schemas
});

// Use:
const property = await db.property.findUnique({ where: { id } });
const photos = await db.propertyPhoto.findMany({
  where: { propertyId: id }
});
const result = { ...property, photos };  // ✅ Works across schemas
```

## Region Configuration

### Environment Variables
```bash
DATABASE_URL=postgresql://...  # US/Default
DATABASE_URL_TR=postgresql://...  # Turkey
DATABASE_URL_AE=postgresql://...  # UAE
DATABASE_URL_UK=postgresql://...  # UK
# ... etc for all regions
```

### Region Mapping
```typescript
// Located in: server/src/lib/prisma.ts
const REGION_DB_MAP = {
  'TR': 'DATABASE_URL_TR',
  'AE': 'DATABASE_URL_AE',
  'UK': 'DATABASE_URL_UK',
  'US': 'DATABASE_URL',
  // ... etc
};
```

### Regions API
```typescript
// GET /api/v1/config/regions
// Returns available regions with their configurations
{
  "success": true,
  "regions": [
    {
      "countryCode": "TR",
      "countryName": "Türkiye",
      "currency": "TRY",
      "databaseSchema": "schema_tr.prisma"
    },
    // ... other regions
  ]
}
```

## Frontend Integration

### Region Selection
```typescript
// Located in: client/src/lib/store/regions-store.ts
- useRegionsStore: Manages selected region
- setSelectedRegion(countryCode): Changes active region
- Persists to localStorage
- Reloads page to apply new region
```

### API Client
```typescript
// Located in: client/src/lib/api/client.ts
- Automatically includes X-Region header based on selected region
- All API calls use region-specific database
```

## Current Status

### ✅ Working
- Turkish database connection via PrismaManager
- PropertyPhoto queries with X-Region: TR header
- `/api/v1/property/:id/photos` endpoint
- `/api/v1/property-photos` endpoint with region filtering
- Regions configuration API

### ⚠️ Partial Working
- Property detail endpoint (`/api/v1/property/:id`) - photos array empty
- Property list endpoint - uses direct query pattern

### 🔧 Needs Work
- Ensure all routes use region-specific database connections
- Update services to support region-specific clients
- Test all country database connections
- Handle country-specific business logic

## Migration Notes

### Turkish Database
- Schema structure is compatible with main schema
- Foreign key constraints exist and are correct
- Direct queries work, Prisma relationships have issues
- Use direct query pattern for reliability

### Other Country Databases
- Should follow same schema structure as main schema
- Use Prisma migrations to ensure consistency
- Test with direct query pattern initially

## Best Practices

### 1. Always Use Region Middleware
```typescript
.use(regionMiddleware)  // Must be included in all routes
```

### 2. Use Direct Queries for Relationships
```typescript
// ❌ Avoid include for relationships
include: { photos: true }

//️ Use direct queries
const photos = await db.propertyPhoto.findMany(...)
```

### 3. Test with X-Region Header
```bash
curl -H "X-Region: TR" http://localhost:3000/api/v1/property/:id/photos
```

### 4. Handle Missing Regions Gracefully
```typescript
const region = headers["x-region"] || headers["X-Region"];
const regionDb = region ? prismaManager.getClient(region) : prismaManager.getDefault();
```

## Future Improvements

1. **Schema Consistency Tool**: Automated schema comparison across databases
2. **Region-Specific Services**: Service layer that handles country-specific logic
3. **Migration Scripts**: Automated database migration for new regions
4. **Testing Suite**: Multi-country integration tests
5. **Monitoring**: Region-specific performance monitoring

## Troubleshooting

### Photos Not Showing
1. Check X-Region header is being sent
2. Verify region is selected in frontend
3. Test with direct API call using curl
4. Check PrismaManager logs for database connection
5. Verify database URL environment variables

### Relationship Queries Not Working
1. Use direct query pattern instead of include
2. Check foreign key constraints in database
3. Verify schema consistency across databases
4. Test with raw SQL to confirm data exists

### Region Not Available
1. Check regions-config.json exists
2. Verify RegionManager loads configuration
3. Test `/api/v1/config/regions` endpoint
4. Check environment variables for region database URLs
