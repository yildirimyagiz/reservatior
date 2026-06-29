import { prisma } from "../../lib/prisma";
import { GoogleGenerativeAI } from "@google/generative-ai";

const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY || "");

/**
 * A service that pre-populates AI fields (async) when a property is added to the list.
 * Reduces the runtime (search time) cost to zero.
 */
export async function enrichPropertyAI(propertyId: string) {
  const property = await prisma.property.findUnique({
    where: { id: propertyId }
  });

  if (!property) return;

  try {
    const prompt = `
      Generate short and impactful marketing data for this property. Return ONLY in valid JSON format.
      Property: ${property.name} - ${property.city}, ${property.listingPrice} USD, ${property.bedrooms} bedrooms.

      Required JSON format:
      {
        "aiSummary": "A very attractive 2-3 sentence summary of the property",
        "aiProsCons": "Pros: ... Cons: ...",
        "aiNeighborhoodScore": 8.5 (Estimated tourism/livability score of the area between 1-10),
        "aiROIHint": "Estimated payback period is 15 years, ideal for Airbnb"
      }
    `;

    const response = await genAI.getGenerativeModel({ model: "gemini-2.5-flash" }).generateContent({
      contents: [{ role: "user", parts: [{ text: prompt }] }]
    });

    const rawText = response.response.text() || "{}";
    const cleanJson = rawText.replace(/```json/g, '').replace(/```/g, '').trim();
    const data = JSON.parse(cleanJson);

    await prisma.property.update({
      where: { id: propertyId },
      data: {
        aiSummary: data.aiSummary,
        aiProsCons: data.aiProsCons,
        aiNeighborhoodScore: data.aiNeighborhoodScore,
        aiROIHint: data.aiROIHint,
      }
    });

    console.log(`[Batch AI] Enriched property: ${propertyId}`);

  } catch (error) {
    console.error(`[Batch AI] Failed to enrich property: ${propertyId}`, error);
  }
}
