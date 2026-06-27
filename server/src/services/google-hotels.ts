import { PrismaClient } from "@prisma/client";
import xml2js from "xml2js";

/**
 * Service to handle Google Hotels (Free Booking Links & Ads) XML generation.
 * Generates Hotel List XML, Price XML, and Availability XML according to Google's standard.
 */
export class GoogleHotelsService {
  
  /**
   * Generates a Google Hotels compliant Hotel List XML (Inventory).
   */
  public static async generateHotelListXML(client: PrismaClient): Promise<string> {
    // Only fetch properties that are bookable or have booking enabled.
    // Assuming for now we export all active properties with coordinates.
    const properties = await client.property.findMany({
      where: {
        lat: { not: null },
        lng: { not: null }
      },
      select: {
        id: true,
        name: true,
        addressLine1: true,
        city: true,
        state: true,
        zip: true,
        country: true,
        lat: true,
        lng: true,
      },
      take: 500 // Limit for testing, in production this is paginated or chunked
    });

    const listings = properties.map(p => ({
      id: [p.id],
      name: [p.name],
      address: [{
        component: [
          { _: p.addressLine1 || "", $: { name: "addr1" } },
          { _: p.city || "", $: { name: "city" } },
          { _: p.state || "", $: { name: "province" } },
          { _: p.zip || "", $: { name: "postal_code" } },
          { _: p.country || "US", $: { name: "country" } },
        ]
      }],
      country: [p.country || "US"],
      latitude: [p.lat],
      longitude: [p.lng]
    }));

    const builder = new xml2js.Builder({ rootName: "listings" });
    const xmlObject = {
      language: "en",
      listing: listings
    };

    return builder.buildObject(xmlObject);
  }

  /**
   * Generates ARI (Availability, Rates, and Inventory) Transaction XML.
   * This is what Google polls to check if a hotel is available on specific dates.
   */
  public static async generatePricingXML(client: PrismaClient): Promise<string> {
    // Placeholder for actual dynamic pricing logic from yield-optimization module
    const builder = new xml2js.Builder({ rootName: "Transaction" });
    const xmlObject = {
      $: { timestamp: new Date().toISOString(), id: "1" },
      Result: [{
        PropertyDataSet: [{
          Property: [{ $: { id: "example-id" } }],
          RoomData: [{
            RoomID: ["ROOM1"],
            Name: [{ _: "Standard Room", $: { text: "en" } }],
            Capacity: ["2"]
          }]
        }]
      }]
    };
    return builder.buildObject(xmlObject);
  }
}
