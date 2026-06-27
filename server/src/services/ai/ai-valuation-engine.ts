import { GoogleGenerativeAI } from "@google/generative-ai";
import { prisma } from "../../lib/prisma";

const apiKey = process.env.GEMINI_API_KEY || "AIzaSy_MOCK_KEY_FOR_DEV";
const genAI = new GoogleGenerativeAI(apiKey);

export class AIValuationEngine {
  /**
   * Generates a valuation and deal score for a property.
   * @param propertyId 
   */
  static async evaluateProperty(propertyId: string) {
    console.log(`[AIValuationEngine] Evaluating property ${propertyId}...`);
    
    // Fetch property with location and amenities
    const property = await prisma.property.findUnique({
      where: { id: propertyId },
      include: {
        location: true,
        amenities: { include: { amenity: true } },
      }
    });

    if (!property) throw new Error("Property not found");

    const model = genAI.getGenerativeModel({ model: "gemini-2.5-flash" });

    const propertyDetails = `
      Name: ${property.name}
      Type: ${property.type}
      City: ${property.city}
      State: ${property.state}
      Region: ${property.region}
      Listed Currency: ${property.currency}
      Amenities: ${property.amenities.map(a => a.amenity.name).join(", ")}
    `;

    const prompt = `
      You are an expert Real Estate Appraiser and Investment Analyst.
      Analyze the following property and determine its estimated market value and a confidence score (0.0 to 1.0).
      
      Property Details:
      ${propertyDetails}

      Assume standard market conditions for ${property.city}, ${property.state || property.region}.
      Provide a realistic, data-driven estimated value in the property's currency (${property.currency}).
      
      Respond ONLY with a valid JSON object matching the requested schema.
      Example structure:
      {
        "estimatedValue": 350000.00,
        "confidenceScore": 0.85,
        "analysis": "This detached house in Kadıköy benefits from excellent transport links and high demand. The estimated value reflects current market averages for similar properties with these amenities."
      }
    `;

    try {
      const result = await model.generateContent(prompt);
      const text = result.response.text().replace(/```json/g, "").replace(/```/g, "").trim();
      const parsed = JSON.parse(text);

      const estimatedValue = parseFloat(parsed.estimatedValue);
      const confidence = parseFloat(parsed.confidenceScore);

      // Save to Database
      const valuation = await prisma.propertyValuation.create({
        data: {
          propertyId: property.id,
          orgId: property.orgId,
          value: estimatedValue,
          confidence: confidence,
          status: "COMPLETED",
          valuationType: "INSTANT",
          valuationDate: new Date(),
        }
      });

      console.log(`[AIValuationEngine] Successfully evaluated ${property.id}: ${estimatedValue} ${property.currency} (Score: ${confidence})`);
      return { valuation, analysis: parsed.analysis };

    } catch (error) {
      console.error("[AIValuationEngine] Error evaluating property:", error);
      throw error;
    }
  }
}
