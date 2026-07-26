import { Elysia, t } from "elysia";
import { regionMiddleware } from "../middleware/region";

export const propertySearchRoutes = new Elysia({ prefix: "/properties" })
  .use(regionMiddleware)

  /**
   * GET /properties/search
   * Search properties by criteria for Gemini Agent
   */
  .get("/search", async ({ query, db }) => {
    const { 
      location, 
      price_max, 
      price_min, 
      rooms, 
      property_type, 
      furnished, 
      radius = 5, 
      limit = 10 
    } = query as any;

    const regionDb = db as any;

    // Build where clause
    const where: any = {};

    // Location filter - search in city, district, or neighborhood
    if (location) {
      where.OR = [
        { city: { contains: location, mode: 'insensitive' } },
        { district: { contains: location, mode: 'insensitive' } },
        { neighborhood: { contains: location, mode: 'insensitive' } },
      ];
    }

    // Price range filter
    if (price_min || price_max) {
      where.listings = {
        some: {
          price: {
            ...(price_min && { gte: parseFloat(price_min) }),
            ...(price_max && { lte: parseFloat(price_max) }),
          },
        },
      };
    }

    // Rooms filter (parse "3+1" format)
    if (rooms) {
      const roomMatch = rooms.match(/(\d+)\+?(\d+)?/);
      if (roomMatch) {
        const bedrooms = parseInt(roomMatch[1]);
        where.bedrooms = bedrooms;
      }
    }

    // Property type filter
    if (property_type) {
      where.propertyCategory = property_type.toUpperCase();
    }

    // Furnished filter
    if (furnished !== undefined) {
      where.furnished = furnished === 'true';
    }

    // Fetch properties
    const properties = await regionDb.property.findMany({
      where,
      take: Math.min(parseInt(limit), 50),
      orderBy: { createdAt: 'desc' },
      include: {
        listings: {
          where: { listingStatus: 'AVAILABLE' },
          take: 1,
          orderBy: { createdAt: 'desc' },
        },
        photos: {
          take: 3,
          orderBy: { isPrimary: 'desc' },
        },
      },
    });

    // Format response for Gemini Agent
    const formattedProperties = properties.map((prop: any) => ({
      id: prop.id,
      title: prop.name,
      location: {
        city: prop.city,
        district: prop.district,
        neighborhood: prop.neighborhood,
        address: prop.address,
        latitude: prop.lat,
        longitude: prop.lng,
      },
      price: prop.listings[0] ? {
        amount: parseFloat(prop.listings[0].price),
        currency: prop.listings[0].priceCurrency || 'TRY',
        period: 'monthly',
      } : null,
      rooms: `${prop.bedrooms}+${prop.bathrooms || 1}`,
      area: {
        total: prop.areaSqm,
        unit: 'sqm',
      },
      property_type: prop.propertyCategory?.toLowerCase(),
      furnished: prop.furnished,
      amenities: [],
      images: prop.photos.map((p: any) => p.url),
      availability: prop.listings[0]?.listingStatus || 'unavailable',
      created_at: prop.createdAt,
    }));

    return {
      success: true,
      count: formattedProperties.length,
      properties: formattedProperties,
    };
  }, {
    query: t.Partial(t.Object({
      location: t.Optional(t.String()),
      price_max: t.Optional(t.String()),
      price_min: t.Optional(t.String()),
      rooms: t.Optional(t.String()),
      property_type: t.Optional(t.String()),
      furnished: t.Optional(t.String()),
      radius: t.Optional(t.String()),
      limit: t.Optional(t.String()),
    }))
  })

  /**
   * GET /properties/:id/nearby
   * Get nearby amenities for a property
   */
  .get("/:id/nearby", async ({ params, query, db }) => {
    const { radius = 2, amenity_type = 'all' } = query as any;
    const regionDb = db as any;

    // Get property location
    const property = await regionDb.property.findUnique({
      where: { id: params.id },
      select: { lat: true, lng: true, city: true, district: true },
    });

    if (!property) {
      return { success: false, error: 'Property not found' };
    }

    // Mock nearby amenities data (in real implementation, use Google Places API or similar)
    const mockAmenities = {
      parks: [
        { id: 'p1', name: 'Kadıköy Parkı', type: 'park', distance: 0.5, rating: 4.5, address: 'Kadıköy, İstanbul', opening_hours: '06:00-22:00' },
        { id: 'p2', name: 'Fenerbahçe Parkı', type: 'park', distance: 1.2, rating: 4.2, address: 'Kadıköy, İstanbul', opening_hours: '06:00-23:00' },
      ],
      schools: [
        { id: 's1', name: 'Kadıköy Anadolu Lisesi', type: 'school', distance: 0.8, rating: 4.7, address: 'Caferağa, Kadıköy', opening_hours: '08:00-17:00' },
        { id: 's2', name: 'İstanbul Üniversitesi', type: 'school', distance: 2.5, rating: 4.8, address: 'Beyazıt, Fatih', opening_hours: '09:00-18:00' },
      ],
      metro_stations: [
        { id: 'm1', name: 'Kadıköy Metro İstasyonu', type: 'metro', distance: 0.3, rating: 4.6, address: 'Kadıköy, İstanbul', opening_hours: '06:00-00:00' },
        { id: 'm2', name: 'Ayrılık Çeşmesi', type: 'metro', distance: 1.5, rating: 4.4, address: 'Kadıköy, İstanbul', opening_hours: '06:00-00:00' },
      ],
      hospitals: [
        { id: 'h1', name: 'Medicana Kadıköy', type: 'hospital', distance: 1.0, rating: 4.3, address: 'Caferağa, Kadıköy', opening_hours: '24/7' },
      ],
      shopping_centers: [
        { id: 'sh1', name: 'Kadıköy AVM', type: 'shopping', distance: 0.6, rating: 4.4, address: 'Kadıköy, İstanbul', opening_hours: '10:00-22:00' },
        { id: 'sh2', name: 'Tepe Nautilus', type: 'shopping', distance: 1.8, rating: 4.2, address: 'Kozyatağı, Kadıköy', opening_hours: '10:00-22:00' },
      ],
    };

    // Filter by amenity type if specified
    let filteredAmenities = mockAmenities;
    if (amenity_type !== 'all') {
      const typeMap: Record<string, string> = {
        park: 'parks',
        school: 'schools',
        metro: 'metro_stations',
        hospital: 'hospitals',
        shopping: 'shopping_centers',
      };
      const key = typeMap[amenity_type];
      if (key) {
        filteredAmenities = { [key]: mockAmenities[key as keyof typeof mockAmenities] };
      }
    }

    return {
      success: true,
      property_id: params.id,
      amenities: filteredAmenities,
    };
  }, {
    params: t.Object({ id: t.String() }),
    query: t.Partial(t.Object({
      radius: t.Optional(t.String()),
      amenity_type: t.Optional(t.String()),
    }))
  });
