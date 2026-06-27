import { GoogleGenerativeAI } from "@google/generative-ai";
import { prisma } from "../../lib/prisma";

const apiKey = process.env.GEMINI_API_KEY || "AIzaSy_MOCK_KEY_FOR_DEV";
const genAI = new GoogleGenerativeAI(apiKey);

export class AIAdsSEOEngine {
  /**
   * Generates Google Ads text (headlines, descriptions, keywords) for a specific property.
   */
  static async generateGoogleAds(propertyId: string) {
    const property = await prisma.property.findUnique({
      where: { id: propertyId }
    });

    if (!property) throw new Error("Property not found");

    const model = genAI.getGenerativeModel({ model: "gemini-2.5-flash" });

    const prompt = `
      You are an expert Google Ads Copywriter specializing in real estate.
      Create a high-converting Google Ads campaign for the following property:
      
      Name: ${property.name}
      Type: ${property.type}
      Location: ${property.neighborhoodId ? property.neighborhoodId + ", " : ""}${property.city}, ${property.country}
      Bedrooms: ${property.bedrooms || "N/A"}
      Bathrooms: ${property.bathrooms || "N/A"}
      Area: ${property.areaSqm || "N/A"} sqm
      Notes: ${property.notes || "A beautiful property"}
      
      REQUIREMENTS:
      1. Provide exactly 3 Headlines (Max 30 characters each)
      2. Provide exactly 2 Descriptions (Max 90 characters each)
      3. Provide a list of 10 highly targeted Search Keywords (Positive)
      4. Provide a list of 5 Negative Keywords
      5. Answer in Turkish.
      
      Respond ONLY with a valid JSON object matching the requested schema.
      Example structure:
      {
        "headlines": ["Headline 1", "Headline 2", "Headline 3"],
        "descriptions": ["Description 1", "Description 2"],
        "positiveKeywords": ["kw1", "kw2", ...],
        "negativeKeywords": ["kw1", "kw2", ...]
      }
    `;

    const result = await model.generateContent(prompt);
    const text = result.response.text().replace(/```json/g, "").replace(/```/g, "").trim();
    return JSON.parse(text);
  }

  /**
   * Generates SEO Content (Meta Title, Meta Desc, Blog Post) for a specific property.
   */
  static async generateSEOContent(propertyId: string) {
    const property = await prisma.property.findUnique({
      where: { id: propertyId }
    });

    if (!property) throw new Error("Property not found");

    const model = genAI.getGenerativeModel({ model: "gemini-2.5-flash" });

    const prompt = `
      You are an expert Real Estate SEO Specialist and Copywriter.
      Create SEO-optimized content for a landing page dedicated to the following property:
      
      Name: ${property.name}
      Type: ${property.type}
      Location: ${property.neighborhoodId ? property.neighborhoodId + ", " : ""}${property.city}, ${property.country}
      Bedrooms: ${property.bedrooms || "N/A"}
      Bathrooms: ${property.bathrooms || "N/A"}
      Area: ${property.areaSqm || "N/A"} sqm
      Notes: ${property.notes || "A beautiful property"}
      
      REQUIREMENTS:
      1. Provide a Meta Title (Max 60 characters)
      2. Provide a Meta Description (Max 160 characters)
      3. Write a compelling, SEO-friendly 300-word blog post/article about this property. Use HTML formatting for the article (e.g. <h2>, <p>, <ul>).
      4. Answer in Turkish.
      
      Respond ONLY with a valid JSON object matching the requested schema.
      Example structure:
      {
        "metaTitle": "Your SEO title...",
        "metaDescription": "Your SEO description...",
        "seoArticleHtml": "<h2>Title</h2><p>Article body...</p>"
      }
    `;

    const result = await model.generateContent(prompt);
    const text = result.response.text().replace(/```json/g, "").replace(/```/g, "").trim();
    return JSON.parse(text);
  }
}
