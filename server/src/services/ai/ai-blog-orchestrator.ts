import { prisma } from "../../lib/prisma";
import { AIBlogGenerator } from "./ai-blog-generator";

const GLOBAL_CATEGORIES = [
  "Local Amenities and Real Estate Market",
  "Public Transportation and Connectivity",
  "Cost of Living and Neighborhood Vibe"
];

const COUNTRY_CATEGORIES: Record<string, string[]> = {
  "TURKEY": [
    "Gezilecek Yerler ve Sosyal Hayat",
    "Yazlık Ev Almak İçin Nedenler ve Yatırım Fırsatları",
    "Öğrenciler ve Genç Profesyoneller İçin Yaşam Maliyeti"
  ],
  "USA": [
    "Real Estate Investment Opportunities and Tax Benefits",
    "Best School Districts and Suburban Family Life",
    "Tech Hubs and Evolving Neighborhoods"
  ],
  "UK": [
    "Student Accommodation and Buy-to-Let Yields",
    "Historic Neighborhoods and Connectivity",
    "Navigating the Property Ladder for First-Time Buyers"
  ]
};

export class AIBlogOrchestrator {
  static getCategoriesForCountry(country: string): string[] {
    if (!country) return GLOBAL_CATEGORIES;
    const upperCountry = country.toUpperCase();
    
    // Fuzzy matching for Turkey
    if (upperCountry.includes("TURKEY") || upperCountry.includes("TÜRKİYE") || upperCountry === "TR") {
      return COUNTRY_CATEGORIES["TURKEY"];
    }
    // Fuzzy matching for USA
    if (upperCountry.includes("USA") || upperCountry.includes("UNITED STATES") || upperCountry === "US") {
      return COUNTRY_CATEGORIES["USA"];
    }
    // Fuzzy matching for UK
    if (upperCountry.includes("UK") || upperCountry.includes("UNITED KINGDOM") || upperCountry.includes("ENGLAND")) {
      return COUNTRY_CATEGORIES["UK"];
    }

    return GLOBAL_CATEGORIES;
  }

  static async runWeeklyGeneration() {
    console.log("[AIBlogOrchestrator] Starting Weekly Blog Generation Job...");
    const admin = await prisma.user.findFirst();
    if (!admin) {
      console.log("[AIBlogOrchestrator] No users found to author posts.");
      return;
    }

    const locations = await prisma.location.findMany({
      select: { city: true, state: true, country: true },
      distinct: ['city', 'country']
    });

    if (locations.length === 0) {
      console.log("[AIBlogOrchestrator] No locations found in the database.");
      return;
    }

    console.log(`[AIBlogOrchestrator] Found ${locations.length} distinct locations.`);

    // Iterate through locations and generate 1 random category post per location
    for (const loc of locations) {
      const locationString = [loc.city, loc.state, loc.country].filter(Boolean).join(", ");
      
      const categories = this.getCategoriesForCountry(loc.country || "");
      const randomCategory = categories[Math.floor(Math.random() * categories.length)];
      
      console.log(`[AIBlogOrchestrator] Generating: ${locationString} -> ${randomCategory}`);
      
      try {
        // Sleep to avoid rate limiting with Gemini
        await new Promise(resolve => setTimeout(resolve, 3000));
        await AIBlogGenerator.generateAndSaveGuide(locationString, randomCategory, admin.id);
      } catch (error) {
        console.error(`[AIBlogOrchestrator] Failed for ${locationString}:`, error);
      }
    }
    
    console.log("[AIBlogOrchestrator] Weekly Blog Generation Job Completed.");
  }
}
