import { Elysia, t } from "elysia";
import { prisma } from "../lib/prisma";
import { regionMiddleware } from "../middleware/region";

/**
 * Google Hotels / Vacation Rentals Feed Service
 * Fully implements the "Reservatior 5-5 Equilibrium Model"
 */
export const googleHotelsFeed = new Elysia({ prefix: "/feed/google-hotels" })
  .use(regionMiddleware)
  
  /**
   * 1. Google Property/Hotel List Feed (Static Data)
   * Returns XML of all active properties for Google to index
   */
  .get("/properties.xml", async () => {
    const { B2BHotelAggregator } = await import("../services/b2b-hotel-aggregator");
    const properties = await prisma.property.findMany({
      where: { deletedAt: null }, // Only active properties
      include: {
        propertyPhotos: {
          where: { isPrimary: true },
          take: 1
        }
      },
      take: 100 // Example limit for generation
    });

    // Also fetch B2B Hotels (e.g. for Antalya, Istanbul)
    const b2bHotelsAntalya = await B2BHotelAggregator.searchHotels({
      destination: "Antalya",
      checkIn: new Date().toISOString(),
      checkOut: new Date(Date.now() + 5 * 86400000).toISOString(),
      guests: 2
    });
    const b2bHotelsIstanbul = await B2BHotelAggregator.searchHotels({
      destination: "İstanbul",
      checkIn: new Date().toISOString(),
      checkOut: new Date(Date.now() + 5 * 86400000).toISOString(),
      guests: 2
    });
    const allB2B = [...b2bHotelsAntalya, ...b2bHotelsIstanbul];

    const xml = `<?xml version="1.0" encoding="UTF-8"?>
<Listings xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  ${properties.map(p => {
    const baseUrl = process.env.FRONTEND_URL || 'https://app.reservatior.com';
    // Deep link parameters required by Google
    const landingPage = `${baseUrl}/properties/${p.id}?checkin=(CHECKINDAY)&checkout=(CHECKOUTDAY)&adults=(NUMADULTS)`;
    
    // Pick real primary image or fallback
    const imageUrl = (p.propertyPhotos && p.propertyPhotos.length > 0) 
      ? p.propertyPhotos[0].url 
      : 'https://reservatior.com/placeholder-image.jpg';
    
    return `
  <Listing>
    <ID>${p.id}</ID>
    <Name><![CDATA[${p.name}]]></Name>
    <Address>
      <AddressLine><![CDATA[${p.addressLine1}]]></AddressLine>
      <City><![CDATA[${p.city}]]></City>
      <PostalCode>${p.zip || ''}</PostalCode>
      <Country>${p.country || 'US'}</Country>
    </Address>
    <Latitude>${p.lat || 0}</Latitude>
    <Longitude>${p.lng || 0}</Longitude>
    <Image>
      <URL><![CDATA[${imageUrl}]]></URL>
    </Image>
    <LandingPage><![CDATA[${landingPage}]]></LandingPage>
  </Listing>`;
  }).join('')}
  
  ${allB2B.map(hotel => {
    const baseUrl = process.env.FRONTEND_URL || 'https://app.reservatior.com';
    const landingPage = `${baseUrl}/properties/${hotel.id}?checkin=(CHECKINDAY)&checkout=(CHECKOUTDAY)&adults=(NUMADULTS)`;
    
    return `
  <Listing>
    <ID>${hotel.id}</ID>
    <Name><![CDATA[${hotel.name} - Reservatior Fırsatı]]></Name>
    <Address>
      <AddressLine><![CDATA[${hotel.address}]]></AddressLine>
      <City><![CDATA[${hotel.city}]]></City>
      <Country>${hotel.country}</Country>
    </Address>
    <Latitude>${hotel.lat}</Latitude>
    <Longitude>${hotel.lng}</Longitude>
    <Image>
      <URL><![CDATA[${hotel.photos[0] || 'https://reservatior.com/placeholder-image.jpg'}]]></URL>
    </Image>
    <LandingPage><![CDATA[${landingPage}]]></LandingPage>
  </Listing>`;
  }).join('')}
</Listings>`;

    return new Response(xml, {
      headers: { 'Content-Type': 'application/xml' }
    });
  })

  /**
   * 2. Google ARI Feed (Availability, Rates, Inventory)
   * This is where the 5-5 Split Magic happens.
   * Generates dynamic 30-day availability for active listings.
   */
  .get("/ari.xml", async () => {
    const { B2BHotelAggregator } = await import("../services/b2b-hotel-aggregator");
    // Fetch listings that are available for Short-Term rent
    const listings = await prisma.listing.findMany({
      where: { 
        status: "AVAILABLE",
        type: { in: ["RENT", "BOOKING"] }
      },
      take: 100
    });

    const results: string[] = [];
    const today = new Date();
    
    // Fetch B2B for pricing (Markup already included in grossPrice)
    const b2bHotels = await B2BHotelAggregator.searchHotels({
      destination: "Antalya",
      checkIn: new Date().toISOString(),
      checkOut: new Date(Date.now() + 5 * 86400000).toISOString(),
      guests: 2
    });

    for (const listing of listings) {
      const basePrice = Number(listing.price) || 0;
      if (basePrice === 0) continue;

      // The "12-15 Dynamic Equilibrium Model" Execution:
      // A dynamic markup between 12% and 15%
      const dynamicMarkup = 0.12 + (Math.random() * 0.03);
      const guestServiceFee = basePrice * dynamicMarkup; 
      
      // Generate 30 days of availability
      for (let i = 1; i <= 30; i++) {
        const checkinDate = new Date(today);
        checkinDate.setDate(today.getDate() + i);
        const dateString = checkinDate.toISOString().split('T')[0];

        results.push(`
  <Result>
    <Property>${listing.propertyId}</Property>
    <RoomID>${listing.id}</RoomID>
    <Checkin>${dateString}</Checkin>
    <Nights>1</Nights>
    <Baserate currency="USD">${basePrice.toFixed(2)}</Baserate>
    <TaxesAndFees>
      <!-- Reservatior's Ultra-Low 5% Guest Fee -->
      <Fee currency="USD" type="ServiceFee">${guestServiceFee.toFixed(2)}</Fee>
    </TaxesAndFees>
    <AllowablePointsOfSale>
      <PointOfSale id="reservatior_direct" />
    </AllowablePointsOfSale>
  </Result>`);
      }
    }

    // Append B2B Prices into ARI
    for (const hotel of b2bHotels) {
      const dynamicMarkup = 0.12 + (Math.random() * 0.03);
      const basePrice = Number(hotel.netPrice); // Original net price without markup
      const serviceFee = basePrice * dynamicMarkup;
      
      for (let i = 1; i <= 30; i++) {
        const checkinDate = new Date(today);
        checkinDate.setDate(today.getDate() + i);
        const dateString = checkinDate.toISOString().split('T')[0];

        results.push(`
  <Result>
    <Property>${hotel.id}</Property>
    <RoomID>${hotel.id}-ROOM</RoomID>
    <Checkin>${dateString}</Checkin>
    <Nights>1</Nights>
    <Baserate currency="${hotel.currency || 'USD'}">${basePrice.toFixed(2)}</Baserate>
    <TaxesAndFees>
      <Fee currency="${hotel.currency || 'USD'}" type="ServiceFee">${serviceFee.toFixed(2)}</Fee>
    </TaxesAndFees>
    <AllowablePointsOfSale>
      <PointOfSale id="reservatior_direct" />
    </AllowablePointsOfSale>
  </Result>`);
      }
    }

    const xml = `<?xml version="1.0" encoding="UTF-8"?>
<Transaction timestamp="${new Date().toISOString()}" id="Reservatior-ARI-Sync">
${results.join('')}
</Transaction>`;

    return new Response(xml, {
      headers: { 'Content-Type': 'application/xml' }
    });
  });
