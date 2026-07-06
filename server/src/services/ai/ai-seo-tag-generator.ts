import { GoogleGenerativeAI } from "@google/generative-ai";
import { prisma } from "../../lib/prisma";

const apiKey = process.env.GEMINI_API_KEY || "AIzaSy_MOCK_KEY_FOR_DEV";
const genAI = new GoogleGenerativeAI(apiKey);

export class AISeoTagGenerator {
  /**
   * Generates SEO tags for a property and attaches them to its listing.
   */
  static async generateTagsForListing(propertyId: string, listingId: string) {
    const property = await prisma.property.findUnique({
      where: { id: propertyId }
    });

    if (!property) throw new Error("Property not found");

    const model = genAI.getGenerativeModel({ model: "gemini-2.5-flash" });

    const prompt = `
      You are an expert Real Estate SEO Specialist.
      I will provide you with a property's details. I want you to extract the most effective, highly searched SEO keywords and tags that can be used to label this property.

      Property Details:
      Name: ${property.name}
      Type: ${property.type}
      Listing Type: ${property.listingType}
      Location: ${property.neighborhoodId ? property.neighborhoodId + ", " : ""}${property.city}, ${property.country}
      Bedrooms: ${property.bedrooms || "N/A"}
      Bathrooms: ${property.bathrooms || "N/A"}
      Area: ${property.areaSqm || "N/A"} sqm
      Notes: ${property.notes || "A beautiful property"}

      REQUIREMENTS:
      1. Provide exactly 5 to 8 high-value SEO tags (short phrases or keywords).
      2. The tags should be in Turkish (since the target audience is Turkish).
      3. Focus on amenities, location advantages, property type, and target audience (e.g. "deniz manzaralı", "merkezi konum", "lüks kiralık villa").
      
      Respond ONLY with a valid JSON array of strings matching the requested schema. Do not include Markdown blocks.
      Example structure:
      ["deniz manzaralı", "lüks kiralık villa", "havuzlu ev"]
    `;

    try {
      const result = await model.generateContent(prompt);
      const text = result.response.text().replace(/\`\`\`json/g, "").replace(/\`\`\`/g, "").trim();
      const tags: string[] = JSON.parse(text);

      if (!Array.isArray(tags)) {
        throw new Error("Invalid response format from AI");
      }

      // Ensure Tags exist in the database and link them to the listing
      for (const tagName of tags) {
        // Tag names should be capitalized properly or kept lowercase for consistency. Let's uppercase them.
        const normalizedTagName = tagName.trim().toUpperCase();
        if (!normalizedTagName) continue;

        // Upsert tag
        let tag = await prisma.tag.findFirst({
          where: { orgId: property.orgId, name: normalizedTagName }
        });

        if (!tag) {
          tag = await prisma.tag.create({
            data: {
              orgId: property.orgId,
              name: normalizedTagName,
              color: "blue" // default color
            }
          });
        }

        // Link Tag to Listing
        const existingListingTag = await prisma.listingTag.findFirst({
          where: { listingId: listingId, tagId: tag.id }
        });

        if (!existingListingTag) {
          await prisma.listingTag.create({
            data: {
              orgId: property.orgId,
              listingId: listingId,
              tagId: tag.id
            }
          });
        }
      }

      return tags;
    } catch (error) {
      console.error("Failed to generate SEO tags:", error);
      // Fail silently to not disrupt the background job
      return [];
    }
  }
}
