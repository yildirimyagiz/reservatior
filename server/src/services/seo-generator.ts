import { prisma } from "../lib/prisma";

export interface PropertySEOData {
  propertyId: string;
  title: string;
  description: string;
  url: string;
  image?: string;
  price: number;
  currency: string;
  address: string;
  city: string;
  country: string;
  bedrooms?: number;
  bathrooms?: number;
  area?: number;
  estimatedRent: number;
  yieldRate: number;
  trustScore: number;
  occupancyRate: number;
  investmentGrade: string;
  jsonLd: any;
}

export interface InvestmentScore {
  propertyId: string;
  overallScore: number;
  yieldScore: number;
  locationScore: number;
  demandScore: number;
  riskScore: number;
  grade: string;
  factors: string[];
  recommendation: string;
}

export interface RentalYield {
  propertyId: string;
  grossYield: number;
  netYield: number;
  monthlyRent: number;
  annualRent: number;
  propertyValue: number;
  expenses: { label: string; amount: number }[];
  breakEvenMonths: number;
  cashOnCashReturn: number;
}

export class SEOGeneratorService {
  async generatePropertySEO(propertyId: string): Promise<PropertySEOData> {
    const property = await (prisma as any).property.findUnique({
      where: { id: propertyId }
    });

    if (!property) {
      throw new Error("Property not found");
    }

    const address = property.address || property.title || "Unknown Property";
    const city = property.city || "Unknown";
    const country = property.country || "Unknown";
    const price = Number(property.price || property.listingPrice || 0);
    const bedrooms = property.bedrooms || 0;
    const bathrooms = property.bathrooms || 0;
    const area = property.squareMeters || property.area || 0;

    const estimatedRent = price * 0.006;
    const yieldRate = (estimatedRent * 12 / price) * 100;
    const trustScore = 75 + Math.random() * 20;
    const occupancyRate = 0.85 + Math.random() * 0.1;
    const investmentGrade = this.calculateGrade(yieldRate, trustScore);

    const jsonLd = {
      "@context": "https://schema.org",
      "@type": "RealEstateListing",
      name: property.title || address,
      description: property.description || `${bedrooms} bedroom property in ${city}, ${country}`,
      url: `https://reservatior.com/properties/${propertyId}`,
      image: property.images?.[0] || property.mainImage,
      offers: {
        "@type": "Offer",
        price: price,
        priceCurrency: property.currency || "USD",
        availability: "https://schema.org/InStock",
        seller: {
          "@type": "Organization",
          name: "Reservatior"
        }
      },
      address: {
        "@type": "PostalAddress",
        streetAddress: address,
        addressLocality: city,
        addressCountry: country
      },
      numberOfRooms: bedrooms,
      floorSize: {
        "@type": "QuantitativeValue",
        value: area,
        unitCode: "MTK"
      }
    };

    return {
      propertyId,
      title: property.title || `${bedrooms} BR in ${city}`,
      description: property.description || `Investment property in ${city}, ${country}. Est. yield: ${yieldRate.toFixed(1)}%`,
      url: `https://reservatior.com/properties/${propertyId}`,
      image: property.images?.[0] || property.mainImage,
      price,
      currency: property.currency || "USD",
      address,
      city,
      country,
      bedrooms,
      bathrooms,
      area,
      estimatedRent,
      yieldRate,
      trustScore,
      occupancyRate,
      investmentGrade,
      jsonLd
    };
  }

  async calculateInvestmentScore(propertyId: string): Promise<InvestmentScore> {
    const property = await (prisma as any).property.findUnique({
      where: { id: propertyId }
    });

    if (!property) {
      throw new Error("Property not found");
    }

    const price = Number(property.price || property.listingPrice || 0);
    const city = property.city || "Unknown";

    const estimatedRent = price * 0.006;
    const yieldRate = (estimatedRent * 12 / price) * 100;
    const yieldScore = Math.min(100, yieldRate * 10);
    const locationScore = this.getLocationScore(city);
    const demandScore = 70 + Math.random() * 25;
    const riskScore = 80 + Math.random() * 15;

    const overallScore = Math.round(
      (yieldScore * 0.3) + (locationScore * 0.25) + (demandScore * 0.25) + (riskScore * 0.2)
    );

    const grade = this.calculateGrade(yieldRate, overallScore);
    const factors = this.getFactors(yieldRate, locationScore, demandScore, riskScore);
    const recommendation = this.getRecommendation(grade, yieldRate);

    return {
      propertyId,
      overallScore,
      yieldScore: Math.round(yieldScore),
      locationScore: Math.round(locationScore),
      demandScore: Math.round(demandScore),
      riskScore: Math.round(riskScore),
      grade,
      factors,
      recommendation
    };
  }

  async calculateRentalYield(propertyId: string): Promise<RentalYield> {
    const property = await (prisma as any).property.findUnique({
      where: { id: propertyId }
    });

    if (!property) {
      throw new Error("Property not found");
    }

    const price = Number(property.price || property.listingPrice || 0);
    const monthlyRent = price * 0.006;
    const annualRent = monthlyRent * 12;

    const expenses = [
      { label: "Maintenance", amount: annualRent * 0.1 },
      { label: "Management", amount: annualRent * 0.08 },
      { label: "Insurance", amount: price * 0.003 },
      { label: "Vacancy", amount: annualRent * 0.05 },
    ];

    const totalExpenses = expenses.reduce((sum, e) => sum + e.amount, 0);
    const netAnnualRent = annualRent - totalExpenses;
    const grossYield = (annualRent / price) * 100;
    const netYield = (netAnnualRent / price) * 100;
    const breakEvenMonths = Math.ceil(price / (netAnnualRent / 12));
    const cashOnCashReturn = (netAnnualRent / price) * 100;

    return {
      propertyId,
      grossYield: Math.round(grossYield * 100) / 100,
      netYield: Math.round(netYield * 100) / 100,
      monthlyRent: Math.round(monthlyRent),
      annualRent: Math.round(annualRent),
      propertyValue: price,
      expenses,
      breakEvenMonths,
      cashOnCashReturn: Math.round(cashOnCashReturn * 100) / 100
    };
  }

  async getBulkSEOData(propertyIds: string[]): Promise<PropertySEOData[]> {
    const results = await Promise.allSettled(
      propertyIds.map(id => this.generatePropertySEO(id))
    );
    return results
      .filter((r): r is PromiseFulfilledResult<PropertySEOData> => r.status === "fulfilled")
      .map(r => r.value);
  }

  private calculateGrade(yieldRate: number, score: number): string {
    const combined = yieldRate * 3 + score * 0.7;
    if (combined >= 85) return "AAA";
    if (combined >= 75) return "AA";
    if (combined >= 65) return "A";
    if (combined >= 55) return "BBB";
    if (combined >= 45) return "BB";
    if (combined >= 35) return "B";
    return "C";
  }

  private getLocationScore(city: string): number {
    const scores: Record<string, number> = {
      "Istanbul": 92, "Izmir": 85, "Ankara": 80, "Antalya": 88,
      "London": 95, "Manchester": 82, "Birmingham": 78,
      "New York": 96, "Los Angeles": 90, "Miami": 88,
      "Dubai": 94, "Abu Dhabi": 89,
      "Berlin": 87, "Munich": 91, "Frankfurt": 86,
      "Paris": 93, "Lyon": 84,
    };
    return scores[city] || 70 + Math.random() * 15;
  }

  private getFactors(yieldRate: number, locationScore: number, demandScore: number, riskScore: number): string[] {
    const factors: string[] = [];
    if (yieldRate > 6) factors.push("High rental yield above market average");
    if (yieldRate > 4) factors.push("Solid rental income potential");
    if (locationScore > 85) factors.push("Premium location with strong demand");
    if (locationScore > 75) factors.push("Good location fundamentals");
    if (demandScore > 80) factors.push("Strong rental demand");
    if (riskScore > 85) factors.push("Low risk investment profile");
    if (factors.length === 0) factors.push("Standard investment profile");
    return factors;
  }

  private getRecommendation(grade: string, yieldRate: number): string {
    if (grade.startsWith("AA")) return "Excellent investment opportunity with strong yield and low risk.";
    if (grade.startsWith("A")) return "Solid investment with good returns. Recommended for portfolio diversification.";
    if (grade === "BBB") return "Moderate investment with average returns. Consider location trends.";
    if (grade === "BB") return "Higher risk investment. Requires careful due diligence.";
    return "Speculative investment. Not recommended for conservative investors.";
  }
}

export const seoGenerator = new SEOGeneratorService();
