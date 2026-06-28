import { Elysia, t } from "elysia";
import { prisma } from "../lib/prisma";
import { b2bAuth } from "../middleware/b2b-auth";

export const publicApiRoutes = new Elysia({ prefix: "/public" })
  .use(b2bAuth)
  // 1. GET /sale: Satılık ilanları getir
  .get("/properties/sale", async ({ query }) => {
    const { city, minPrice, maxPrice, limit = 20 } = query as any;

    const whereClause: any = {
      // Assuming 'AVAILABLE' or similar listing status exists in your schema logic. 
      status: "AVAILABLE",
      // You can add specific status/type filtering based on your Listing model
    };

    if (city) whereClause.city = { contains: city, mode: "insensitive" };
    if (minPrice) whereClause.price = { gte: parseFloat(minPrice) };
    if (maxPrice) whereClause.price = { lte: parseFloat(maxPrice) };

    const properties = await prisma.listing.findMany({
      where: whereClause,
      take: parseInt(limit as string, 10),
      include: {
        property: { include: { propertyPhotos: { select: { url: true, isPrimary: true } } } },
        location: true,
      }
    });

    return {
      success: true,
      data: properties
    };
  })
  
  // 2. GET /rent: Uzun dönem kiralık ilanları getir
  .get("/properties/rent", async ({ query }) => {
    const { city, minPrice, maxPrice, limit = 20 } = query as any;

    // Filter logic specific for rent
    const whereClause: any = {
      status: "AVAILABLE",
    };

    if (city) whereClause.city = { contains: city, mode: "insensitive" };
    
    const properties = await prisma.listing.findMany({
      where: whereClause,
      take: parseInt(limit as string, 10),
      include: {
        property: { include: { propertyPhotos: { select: { url: true, isPrimary: true } } } },
        location: true,
      }
    });

    return {
      success: true,
      data: properties
    };
  })

  // 3. GET /projects: Yeni projeleri getir
  .get("/projects", async ({ query }) => {
    const { city, limit = 20 } = query as any;

    const whereClause: any = {
      // isActive: true, 
      // status: 'UNDER_CONSTRUCTION'
    };

    const projects = await prisma.project.findMany({
      where: whereClause,
      take: parseInt(limit as string, 10),
      include: {
        property: { include: { listings: { take: 1, select: { price: true } } } }
      }
    });

    return {
      success: true,
      data: projects
    };
  })

  // 4. GET /booking/search: Günlük kiralık (Otel/Airbnb alternatifi) arama
  .get("/properties/booking/search", async ({ query }) => {
    const { city, checkIn, checkOut, guests, limit = 20 } = query as any;

    const properties = await prisma.listing.findMany({
      where: {
        status: "AVAILABLE",
      },
      take: parseInt(limit as string, 10),
      include: {
        property: { include: { propertyPhotos: { select: { url: true, isPrimary: true } } } },
        location: true,
      }
    });

    // B2B Pricing logic: Append %12 commission rule or return net prices
    const enhancedProperties = properties.map(p => ({
      ...p,
      b2bCommissionRate: 12,
      netPricePerNight: Number(p.price) * 0.88, // Example logic
    }));

    return {
      success: true,
      data: enhancedProperties
    };
  })

  // 5. GET /:id: Spesifik Mülk/Proje detayı
  .get("/properties/:id", async ({ params }) => {
    const property = await prisma.listing.findUnique({
      where: { id: params.id },
      include: {
        property: { include: { propertyPhotos: true, amenities: true } },
        location: true
      }
    });

    if (!property) throw new Error("Property not found");

    return {
      success: true,
      data: property
    };
  })

  // 6. POST /bookings/create: B2B Rezervasyon Oluştur
  .post("/bookings/create", async ({ body, b2bUser, b2bOrg }: any) => {
    const { propertyId, checkIn, checkOut, guestDetails } = body;

    // Create a booking record linked to the B2B partner (org or user)
    const booking = await prisma.booking.create({
      data: {
        listingId: propertyId,
        startDate: new Date(checkIn),
        endDate: new Date(checkOut),
        status: "DRAFT",
        adults: guestDetails?.count || 1,
        priceTotal: 0, // Should be calculated
        orgId: b2bOrg?.id || "DEFAULT_ORG", // Org ID is required by schema
        createdBy: b2bUser?.id, // Track who made the booking
      }
    });

    return {
      success: true,
      message: "Booking request received and is pending confirmation.",
      data: booking
    };
  });
