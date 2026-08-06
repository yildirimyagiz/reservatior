import type { MetadataRoute } from "next";
import { propertiesApi } from "@/lib/api/properties-eden";
import { ALL_SEO_LANDING_CONFIGS, ALL_MARKET_DATA } from "@/lib/seo/market-data";

const baseUrl = process.env.NEXT_PUBLIC_SITE_URL || "https://reservatior.com";
const SUPPORTED_LOCALES = ["en","tr","ar","es","fr","de","ru","pt","zh","ja","ko","it","nl","pl","sv","da","fi","el","hi","nb"];

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

const investmentOSRoutes = [
  { url: "/investment-os/dashboard", priority: 0.8, changeFrequency: "weekly" as const },
  { url: "/investment-os/roi-calculator", priority: 0.9, changeFrequency: "weekly" as const },
  { url: "/investment-os/rental-yield", priority: 0.9, changeFrequency: "weekly" as const },
  { url: "/investment-os/city-comparison", priority: 0.8, changeFrequency: "weekly" as const },
  { url: "/investment-os/compare", priority: 0.7, changeFrequency: "weekly" as const },
  { url: "/investment-os/reports", priority: 0.7, changeFrequency: "weekly" as const },
  { url: "/investment-os/ai-assistant", priority: 0.6, changeFrequency: "monthly" as const },
  { url: "/investment-os/analytics", priority: 0.5, changeFrequency: "weekly" as const },
  { url: "/investment-os/profile", priority: 0.6, changeFrequency: "monthly" as const },
  { url: "/investment-os/rental-management", priority: 0.8, changeFrequency: "weekly" as const },
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

  // Investment Intelligence OS routes
  for (const route of investmentOSRoutes) {
    sitemapRoutes.push({
      url: `${baseUrl}${route.url}`,
      lastModified: new Date(),
      changeFrequency: route.changeFrequency,
      priority: route.priority,
    });
  }

  // Programmatic SEO landing pages for investment calculators
  for (const config of ALL_SEO_LANDING_CONFIGS) {
    sitemapRoutes.push({
      url: `${baseUrl}/en/invest/${config.city}/${config.slug}`,
      lastModified: new Date(),
      changeFrequency: "weekly" as const,
      priority: 0.85,
    });
  }

  // District-level SEO pages
  for (const [citySlug, cityData] of Object.entries(ALL_MARKET_DATA)) {
    for (const district of cityData.districts) {
      const districtSlug = district.name.toLowerCase().replace(/[^a-z0-9]+/g, "-").replace(/-+$/, "");
      sitemapRoutes.push({
        url: `${baseUrl}/en/invest/${citySlug}/${districtSlug}`,
        lastModified: new Date(),
        changeFrequency: "weekly" as const,
        priority: 0.8,
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
