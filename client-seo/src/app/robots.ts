import type { MetadataRoute } from "next";

export default function robots(): MetadataRoute.Robots {
  const baseUrl = process.env.NEXT_PUBLIC_SITE_URL || "https://reservatior.com";
  
  return {
    rules: {
      userAgent: "*",
      allow: ["/", "/client/properties/*"],
      disallow: ["/admin", "/client/dashboard", "/client/financial", "/client/settings"],
    },
    sitemap: `${baseUrl}/sitemap.xml`,
  };
}
