import type { MetadataRoute } from "next";
import { propertiesApi } from "@/lib/api/properties-eden";

const baseUrl = process.env.NEXT_PUBLIC_SITE_URL || "https://reservatior.com";
const SUPPORTED_LOCALES = ["en","tr","ar","es","fr","de","ru","pt","zh","ja","ko","it","nl","pl","sv","da","fi","el","hi","id"];

const publicRoutes = [
  { url: "/", priority: 1.0, changeFrequency: "daily" as const },
  { url: "/client/explore", priority: 0.9, changeFrequency: "weekly" as const },
  { url: "/about", priority: 0.7, changeFrequency: "monthly" as const },
  { url: "/features", priority: 0.7, changeFrequency: "monthly" as const },
  { url: "/client/pricing", priority: 0.8, changeFrequency: "monthly" as const },
  { url: "/client/contact", priority: 0.7, changeFrequency: "monthly" as const },
  { url: "/client/privacy", priority: 0.3, changeFrequency: "yearly" as const },
  { url: "/client/terms", priority: 0.3, changeFrequency: "yearly" as const },
  { url: "/client/trust-center", priority: 0.6, changeFrequency: "monthly" as const },
  { url: "/client/property-search", priority: 0.9, changeFrequency: "daily" as const },
  { url: "/client/videos", priority: 0.7, changeFrequency: "weekly" as const },
  { url: "/client/ai/valuation", priority: 0.8, changeFrequency: "weekly" as const },
  { url: "/client/ai/studio", priority: 0.7, changeFrequency: "weekly" as const },
  { url: "/ai-search", priority: 0.8, changeFrequency: "weekly" as const },
  { url: "/client/lease-care", priority: 0.7, changeFrequency: "weekly" as const },
  { url: "/client/hospitality-standards", priority: 0.6, changeFrequency: "monthly" as const },
  { url: "/client/short-term-rental-safety", priority: 0.6, changeFrequency: "monthly" as const },
  { url: "/client/tenant-verification", priority: 0.6, changeFrequency: "monthly" as const },
  { url: "/client/legal", priority: 0.3, changeFrequency: "yearly" as const },
];

export default async function sitemap(): Promise<MetadataRoute.Sitemap> {
  const sitemapRoutes: MetadataRoute.Sitemap = [];

  for (const route of publicRoutes) {
    for (const locale of SUPPORTED_LOCALES) {
      sitemapRoutes.push({
        url: `${baseUrl}/${locale}${route.url}`,
        lastModified: new Date(),
        changeFrequency: route.changeFrequency,
        priority: route.priority,
      });
    }
  }

  try {
    const { data: properties, error } = await propertiesApi.getAll({ limit: 1000 });
    
    if (!error && Array.isArray(properties)) {
      for (const property of properties) {
        for (const locale of SUPPORTED_LOCALES) {
          sitemapRoutes.push({
            url: `${baseUrl}/${locale}/client/properties/${property.id}`,
            lastModified: property.updatedAt ? new Date(property.updatedAt) : new Date(),
            changeFrequency: "weekly" as const,
            priority: 0.8,
          });
        }
      }
    }
  } catch (error) {
    console.error("Failed to generate dynamic sitemap routes for properties:", error);
  }

  return sitemapRoutes;
}
