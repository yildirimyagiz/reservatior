import { GoogleGenerativeAI } from "@google/generative-ai";

const apiKey = process.env.GEMINI_API_KEY || "AIzaSy_MOCK_KEY_FOR_DEV";
const genAI = new GoogleGenerativeAI(apiKey);
const MODEL = "gemini-2.5-flash";

function parseJsonResponse(text: string): any {
  const cleaned = text.replace(/```json/g, "").replace(/```/g, "").trim();
  return JSON.parse(cleaned);
}

export class GrowthEngineGeminiService {
  private model;

  constructor() {
    this.model = genAI.getGenerativeModel({ model: MODEL });
  }

  /**
   * Analyzes property health based on metadata and asset data.
   */
  async analyzePropertyHealth(
    propertyData: Record<string, any>,
    assets: Array<{ url: string; description?: string }>
  ): Promise<{
    healthScore: number;
    structuralScore: number;
    cosmeticScore: number;
    systemsScore: number;
    overallGrade: string;
    defects: Array<{ category: string; severity: string; description: string; estimatedCost: number }>;
    recommendations: Array<{ priority: string; action: string; estimatedCost: number }>;
  }> {
    if (apiKey === "AIzaSy_MOCK_KEY_FOR_DEV") {
      return this._mockPropertyHealth(propertyData);
    }

    try {
      const prompt = `
You are a property condition analyst AI for a real estate platform.
Analyze this property's condition based on the provided data.

Property Data:
${JSON.stringify(propertyData, null, 2)}

Assets (images/documents):
${JSON.stringify(assets, null, 2)}

Return a JSON object with the following structure:
{
  "healthScore": <number 0-100>,
  "structuralScore": <number 0-100>,
  "cosmeticScore": <number 0-100>,
  "systemsScore": <number 0-100>,
  "overallGrade": "<A-F>",
  "defects": [
    {
      "category": "<category>",
      "severity": "<LOW|MEDIUM|HIGH|CRITICAL>",
      "description": "<description>",
      "estimatedCost": <number>
    }
  ],
  "recommendations": [
    {
      "priority": "<LOW|MEDIUM|HIGH|URGENT>",
      "action": "<action item>",
      "estimatedCost": <number>
    }
  ]
}

Return ONLY valid JSON.
      `;

      const result = await this.model.generateContent(prompt);
      const text = result.response.text();
      return parseJsonResponse(text);
    } catch (error) {
      console.error("[GrowthEngineGeminiService] analyzePropertyHealth error:", error);
      return this._mockPropertyHealth(propertyData);
    }
  }

  /**
   * Assesses insurance risk for a property based on its data and health report.
   */
  async assessInsuranceRisk(
    propertyData: Record<string, any>,
    healthReport: Record<string, any>
  ): Promise<{
    riskScore: number;
    riskLevel: string;
    factors: Array<{ factor: string; impact: string; weight: number }>;
    premiumEstimate: number;
    recommendations: string[];
  }> {
    if (apiKey === "AIzaSy_MOCK_KEY_FOR_DEV") {
      return this._mockInsuranceRisk(propertyData);
    }

    try {
      const prompt = `
You are an insurance risk assessment AI for a real estate platform.
Assess the insurance risk for this property.

Property Data:
${JSON.stringify(propertyData, null, 2)}

Health Analysis Report:
${JSON.stringify(healthReport, null, 2)}

Return a JSON object with the following structure:
{
  "riskScore": <number 0-100>,
  "riskLevel": "<LOW|MEDIUM|HIGH|CRITICAL>",
  "factors": [
    {
      "factor": "<factor name>",
      "impact": "<impact description>",
      "weight": <number 0-1>
    }
  ],
  "premiumEstimate": <number>,
  "recommendations": ["<recommendation>", ...]
}

Return ONLY valid JSON.
      `;

      const result = await this.model.generateContent(prompt);
      const text = result.response.text();
      return parseJsonResponse(text);
    } catch (error) {
      console.error("[GrowthEngineGeminiService] assessInsuranceRisk error:", error);
      return this._mockInsuranceRisk(propertyData);
    }
  }

  /**
   * Generates luxury real estate brochure content for a target demographic and language.
   */
  async generateBrochureContent(
    propertyData: Record<string, any>,
    targetDemographic: string,
    language: string
  ): Promise<{
    title: string;
    heroDescription: string;
    keyFeatures: string[];
    neighborhoodHighlights: string;
    investmentPotential: string;
    callToAction: string;
  }> {
    if (apiKey === "AIzaSy_MOCK_KEY_FOR_DEV") {
      return this._mockBrochureContent(propertyData, targetDemographic, language);
    }

    try {
      const prompt = `
You are a luxury real estate copywriter AI.
Generate a luxury real estate brochure for this property targeting "${targetDemographic}" in "${language}".

Property Data:
${JSON.stringify(propertyData, null, 2)}

Return a JSON object with the following structure:
{
  "title": "<brochure title>",
  "heroDescription": "<compelling hero section text>",
  "keyFeatures": ["<feature 1>", "<feature 2>", ...],
  "neighborhoodHighlights": "<neighborhood description>",
  "investmentPotential": "<investment analysis>",
  "callToAction": "<call to action text>"
}

Write all text content in ${language}. Return ONLY valid JSON.
      `;

      const result = await this.model.generateContent(prompt);
      const text = result.response.text();
      return parseJsonResponse(text);
    } catch (error) {
      console.error("[GrowthEngineGeminiService] generateBrochureContent error:", error);
      return this._mockBrochureContent(propertyData, targetDemographic, language);
    }
  }

  /**
   * Analyzes ad campaign performance and recommends optimizations.
   */
  async optimizeAdCampaign(
    campaignData: Record<string, any>,
    networkPerformance: Record<string, any>
  ): Promise<{
    recommendedBudgetShifts: Array<{ from: string; to: string; percentage: number; reason: string }>;
    estimatedCPETImprovement: number;
    targetMetrics: Record<string, number>;
    actionItems: string[];
  }> {
    if (apiKey === "AIzaSy_MOCK_KEY_FOR_DEV") {
      return this._mockAdCampaignOptimization(campaignData);
    }

    try {
      const prompt = `
You are a digital advertising optimization AI for a real estate platform.
Analyze this ad campaign performance and recommend optimizations.

Campaign Data:
${JSON.stringify(campaignData, null, 2)}

Network Performance:
${JSON.stringify(networkPerformance, null, 2)}

Return a JSON object with the following structure:
{
  "recommendedBudgetShifts": [
    {
      "from": "<source channel/budget line>",
      "to": "<destination channel/budget line>",
      "percentage": <number>,
      "reason": "<reasoning>"
    }
  ],
  "estimatedCPETImprovement": <number as decimal e.g. 0.15 for 15%>,
  "targetMetrics": {
    "ctr": <number>,
    "cpm": <number>,
    "conversionRate": <number>
  },
  "actionItems": ["<action 1>", "<action 2>", ...]
}

Return ONLY valid JSON.
      `;

      const result = await this.model.generateContent(prompt);
      const text = result.response.text();
      return parseJsonResponse(text);
    } catch (error) {
      console.error("[GrowthEngineGeminiService] optimizeAdCampaign error:", error);
      return this._mockAdCampaignOptimization(campaignData);
    }
  }

  /**
   * Generates ad copy tailored for a specific platform and audience.
   */
  async generateAdCopy(
    propertyData: Record<string, any>,
    targetAudience: string,
    platform: string
  ): Promise<{
    headline: string;
    primaryText: string;
    description: string;
    callToAction: string;
    targetingSuggestions: Record<string, any>;
  }> {
    if (apiKey === "AIzaSy_MOCK_KEY_FOR_DEV") {
      return this._mockAdCopy(propertyData, targetAudience, platform);
    }

    try {
      const prompt = `
You are a platform-specific ad copywriter AI for a real estate platform.
Generate ad copy for ${platform} targeting ${targetAudience} for this property.

Property Data:
${JSON.stringify(propertyData, null, 2)}

Platform: ${platform}
Target Audience: ${targetAudience}

Platform constraints:
- Google Ads: headline max 30 chars, primaryText max 90 chars, description max 90 chars
- Meta (Facebook/Instagram): headline max 40 chars, primaryText max 125 chars, description max 30 chars
- TikTok: headline max 30 chars, primaryText max 100 chars, description max 80 chars

Return a JSON object with the following structure:
{
  "headline": "<headline text>",
  "primaryText": "<primary text body>",
  "description": "<description text>",
  "callToAction": "<CTA button text>",
  "targetingSuggestions": {
    "ageRange": "<e.g. 25-54>",
    "interests": ["<interest 1>", "<interest 2>", ...],
    "locations": ["<location 1>", ...]
  }
}

Respect the character limits for ${platform}. Return ONLY valid JSON.
      `;

      const result = await this.model.generateContent(prompt);
      const text = result.response.text();
      return parseJsonResponse(text);
    } catch (error) {
      console.error("[GrowthEngineGeminiService] generateAdCopy error:", error);
      return this._mockAdCopy(propertyData, targetAudience, platform);
    }
  }

  // ── Mock Data Fallbacks ──────────────────────────────────────────

  private _mockPropertyHealth(propertyData: Record<string, any>): {
    healthScore: number;
    structuralScore: number;
    cosmeticScore: number;
    systemsScore: number;
    overallGrade: string;
    defects: Array<{ category: string; severity: string; description: string; estimatedCost: number }>;
    recommendations: Array<{ priority: string; action: string; estimatedCost: number }>;
  } {
    return {
      healthScore: 78,
      structuralScore: 85,
      cosmeticScore: 70,
      systemsScore: 72,
      overallGrade: "B",
      defects: [
        {
          category: "Plumbing",
          severity: "MEDIUM",
          description: "Minor pipe corrosion detected in basement utility area",
          estimatedCost: 1200,
        },
        {
          category: "Cosmetic",
          severity: "LOW",
          description: "Paint peeling in guest bedroom, likely from moisture",
          estimatedCost: 450,
        },
        {
          category: "Electrical",
          severity: "HIGH",
          description: "Outdated breaker panel not meeting current code standards",
          estimatedCost: 3500,
        },
      ],
      recommendations: [
        {
          priority: "HIGH",
          action: "Upgrade electrical breaker panel to meet current code",
          estimatedCost: 3500,
        },
        {
          priority: "MEDIUM",
          action: "Repair corroded pipes in basement",
          estimatedCost: 1200,
        },
        {
          priority: "LOW",
          action: "Repaint guest bedroom with moisture-resistant paint",
          estimatedCost: 450,
        },
        {
          priority: "MEDIUM",
          action: "Schedule annual HVAC inspection and servicing",
          estimatedCost: 300,
        },
      ],
    };
  }

  private _mockInsuranceRisk(propertyData: Record<string, any>): {
    riskScore: number;
    riskLevel: string;
    factors: Array<{ factor: string; impact: string; weight: number }>;
    premiumEstimate: number;
    recommendations: string[];
  } {
    return {
      riskScore: 42,
      riskLevel: "MEDIUM",
      factors: [
        {
          factor: "Property Age",
          impact: "Older properties carry higher risk of system failures",
          weight: 0.3,
        },
        {
          factor: "Location",
          impact: "Moderate seismic zone, standard flood risk",
          weight: 0.25,
        },
        {
          factor: "Health Report",
          impact: "Structural integrity is good, electrical system needs attention",
          weight: 0.25,
        },
        {
          factor: "Historical Claims",
          impact: "No recent claims on record",
          weight: 0.2,
        },
      ],
      premiumEstimate: 2850,
      recommendations: [
        "Address electrical panel upgrade to reduce risk rating",
        "Install smoke and carbon monoxide detectors on all floors",
        "Consider flood insurance rider given proximity to waterway",
        "Maintain documented maintenance records for premium discount",
      ],
    };
  }

  private _mockBrochureContent(
    propertyData: Record<string, any>,
    targetDemographic: string,
    language: string
  ): {
    title: string;
    heroDescription: string;
    keyFeatures: string[];
    neighborhoodHighlights: string;
    investmentPotential: string;
    callToAction: string;
  } {
    const propertyName = propertyData?.name || "Exclusive Residence";
    if (language === "tr" || language === "Türkçe") {
      return {
        title: `${propertyName} - Eşsiz Lüks Yaşam`,
        heroDescription: `${propertyName}, modern mimari ve sofistike tasarımın buluştuğu benzersiz bir yaşam alanıdır. Her detayında kalite ve zarafeti hissedeceğiniz bu özel mülk, ${targetDemographic} için tasarlanmıştır.`,
        keyFeatures: [
          "Özel havuz ve bahçe",
          "Akıllı ev teknolojisi",
          "Merkezi konum, toplu ulaşıma yürüme mesafesi",
          "Geniş ve aydınlık iç mekanlar",
          "Premium mutfak ve beyaz eşyalar",
          "Kapalı otopark",
        ],
        neighborhoodHighlights: "Bu prestijli semt, dünyaca ünlü restoranlara, butik mağazalara ve kültürel mekanlara yakınlığıyla dikkat çekmektedir. Bölge, yatırım değeri yüksek ve güvenli yaşam alanlarıyla tanınır.",
        investmentPotential: "Son 5 yılda %35 değer artışı gösteren bölgede, kira getirisi yıllık %5.2 oranındadır. Yeni ulaşım projeleriyle birlikte gelecek dönemde değer artışının devamı beklenmektedir.",
        callToAction: "Bu eşsiz mülkü yerinde keşfetmek için hemen randevu alın. Sınırlı sayıda gösteri düzenlenmektedir.",
      };
    }
    return {
      title: `${propertyName} - Redefining Luxury Living`,
      heroDescription: `${propertyName} is where modern architecture meets sophisticated design. This exclusive property has been curated for ${targetDemographic} seeking the pinnacle of refined living. Every detail speaks of quality and elegance.`,
      keyFeatures: [
        "Private pool and landscaped garden",
        "Smart home integration throughout",
        "Prime location within walking distance to transit",
        "Spacious, light-filled interiors",
        "Premium kitchen with top-tier appliances",
        "Dedicated covered parking",
      ],
      neighborhoodHighlights: "This prestigious neighborhood is renowned for world-class dining, boutique shopping, and cultural landmarks. The area offers strong investment fundamentals and a secure living environment.",
      investmentPotential: "With a 35% appreciation over the last 5 years and an annual rental yield of 5.2%, this property represents a compelling investment. Upcoming transit infrastructure projects are expected to drive further value appreciation.",
      callToAction: "Schedule a private viewing of this exceptional property today. Limited showings available.",
    };
  }

  private _mockAdCampaignOptimization(campaignData: Record<string, any>): {
    recommendedBudgetShifts: Array<{ from: string; to: string; percentage: number; reason: string }>;
    estimatedCPETImprovement: number;
    targetMetrics: Record<string, number>;
    actionItems: string[];
  } {
    return {
      recommendedBudgetShifts: [
        {
          from: "Google Search - Generic",
          to: "Google Search - Branded",
          percentage: 15,
          reason: "Branded keywords show 3x higher CTR and 40% lower CPA than generic terms",
        },
        {
          from: "Meta Audience Network",
          to: "Meta Instagram Reels",
          percentage: 20,
          reason: "Instagram Reels outperform Audience Network by 2.5x in conversion rate for property listings",
        },
        {
          from: "TikTok - Broad Targeting",
          to: "TikTok - Lookalike Audiences",
          percentage: 10,
          reason: "Lookalike audiences based on past converters deliver 60% better ROAS",
        },
      ],
      estimatedCPETImprovement: 0.18,
      targetMetrics: {
        ctr: 3.2,
        cpm: 12.5,
        conversionRate: 4.8,
      },
      actionItems: [
        "Pause underperforming Audience Network placements and reallocate to Reels",
        "Create lookalike audiences from top 10% of converters for TikTok campaign",
        "Increase branded search budget to capture high-intent traffic",
        "A/B test new property-focused creative on Meta within 48 hours",
        "Set up conversion tracking for lead form submissions across all platforms",
      ],
    };
  }

  private _mockAdCopy(
    propertyData: Record<string, any>,
    targetAudience: string,
    platform: string
  ): {
    headline: string;
    primaryText: string;
    description: string;
    callToAction: string;
    targetingSuggestions: Record<string, any>;
  } {
    const name = propertyData?.name || "Luxury Property";
    const city = propertyData?.city || "Istanbul";
    const beds = propertyData?.bedrooms || "3";
    const price = propertyData?.listingPrice || "Contact for price";

    if (platform === "Google") {
      return {
        headline: `${name} | ${city}`,
        primaryText: `${beds}-bed luxury residence in ${city}. Premium finishes, prime location. Schedule a private tour today.`,
        description: `${beds}-bed luxury in ${city}. Smart home, private pool. View now.`,
        callToAction: "Schedule Tour",
        targetingSuggestions: {
          ageRange: "30-55",
          interests: ["luxury real estate", "property investment", "home buying"],
          locations: [city, "Nearby metropolitan areas"],
        },
      };
    }

    if (platform === "Meta") {
      return {
        headline: `Discover ${name}`,
        primaryText: `Premium ${beds}-bed residence in the heart of ${city}. Designed for ${targetAudience} who demand the finest. From ${price}.`,
        description: "Luxury living redefined. View details.",
        callToAction: "Learn More",
        targetingSuggestions: {
          ageRange: "28-55",
          interests: ["luxury lifestyle", "real estate investment", "interior design", "architecture"],
          locations: [city],
        },
      };
    }

    // TikTok
    return {
      headline: `${name} Tour`,
      primaryText: `Step inside this stunning ${beds}-bed home in ${city}. Modern luxury meets smart living. ${price}`,
      description: "Your dream home awaits. Book a tour.",
      callToAction: "Book Now",
      targetingSuggestions: {
        ageRange: "22-40",
        interests: ["home design", "luxury lifestyle", "real estate", "travel"],
        locations: [city],
      },
    };
  }
}
