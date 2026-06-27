import { GoogleGenerativeAI } from "@google/generative-ai";
import { prisma } from "../../lib/prisma";
import slugify from "slugify";

const apiKey = process.env.GEMINI_API_KEY || "AIzaSy_MOCK_KEY_FOR_DEV";
const genAI = new GoogleGenerativeAI(apiKey);

export class AIBlogGenerator {
  /**
   * Generates a City Guide / Blog post for a given location and topic category.
   * Saves it directly to the Post table.
   * 
   * @param city e.g. "İstanbul, Kadıköy"
   * @param category e.g. "Places to Visit", "Cost of Living", "Investment Guide"
   * @param adminUserId User ID to set as the author
   */
  static async generateAndSaveGuide(city: string, category: string, adminUserId: string) {
    console.log(`[AIBlogGenerator] Generating guide for ${city} - ${category}...`);
    
    const model = genAI.getGenerativeModel({ model: "gemini-2.5-flash" });

    const prompt = `
      You are an expert Local Real Estate Agent and Travel Guide writer.
      I need you to write a high-quality, SEO-optimized blog post. The blog post MUST be written in the native language of the specified location (e.g. English for USA, Turkish for Turkey, Spanish for Spain).
      
      Topic: ${category}
      Location: ${city}

      REQUIREMENTS:
      1. Write a compelling SEO Title (Max 60 characters).
      2. Provide a 3-word English prompt to generate a representative image (e.g. "luxury villa bodrum", "modern apartment london").
      3. Write an engaging HTML article body (min 400 words) using <h2>, <h3>, <p>, <ul>, <li> tags.
      4. The article should be highly informative, mentioning specific real places, average costs, or concrete facts about ${city}.
      5. End the article with a Call To Action (CTA) encouraging readers to check out properties in ${city} on Reservatior AND ask them a question to leave a comment below. (e.g. "Siz bu bölge hakkında ne düşünüyorsunuz? Yorumlarda buluşalım!")
      6. Do not include \`\`\`html code blocks, just raw HTML or simple text.
      
      Respond ONLY with a valid JSON object matching the requested schema.
      Example structure:
      {
        "title": "Kadıköy'de Ziyaret Edilecek En İyi Yerler",
        "imagePrompt": "kadikoy vibrant streets",
        "htmlContent": "<h2>Kadıköy'e Hoş Geldiniz</h2><p>...</p>"
      }
    `;

    try {
      const result = await model.generateContent(prompt);
      const text = result.response.text().replace(/```json/g, "").replace(/```/g, "").trim();
      const parsed = JSON.parse(text);

      const title = parsed.title;
      let content = parsed.htmlContent;
      const slug = slugify(title, { lower: true, strict: true });

      // Append an AI generated image at the top of the content
      if (parsed.imagePrompt) {
        const encodedPrompt = encodeURIComponent(parsed.imagePrompt + " high quality cinematic real estate photography");
        const imageUrl = `https://image.pollinations.ai/prompt/${encodedPrompt}`;
        const imageHtml = `<img src="${imageUrl}" alt="${title}" style="width:100%; max-height:400px; object-fit:cover; border-radius:8px; margin-bottom:20px;" />\n\n`;
        content = imageHtml + content;
      }

      // Save to Database
      const post = await prisma.post.create({
        data: {
          title,
          content,
          slug,
          userId: adminUserId, // Must be an existing User
        }
      });

      console.log(`[AIBlogGenerator] Successfully created post: ${post.title} (Slug: ${post.slug})`);
      return post;

    } catch (error) {
      console.error("[AIBlogGenerator] Error generating or saving blog post:", error);
      throw error;
    }
  }
}
