import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { ALL_SEO_LANDING_CONFIGS, getCityData, ALL_MARKET_DATA } from "@/lib/seo/market-data";
import { SEOLandingPageClient } from "./SEOLandingPageClient";

interface PageProps {
  params: { city: string; tool: string };
}

export function generateStaticParams() {
  return ALL_SEO_LANDING_CONFIGS.map((config) => ({
    city: config.city,
    tool: config.slug,
  }));
}

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const config = ALL_SEO_LANDING_CONFIGS.find((c) => c.slug === params.tool);
  if (!config) return {};

  return {
    title: config.title,
    description: config.description,
    keywords: config.keywords,
    openGraph: {
      title: config.title,
      description: config.description,
      type: "website",
      url: `https://reservatior.com/invest/${params.city}/${params.tool}`,
      siteName: "Reservatior",
    },
    twitter: {
      card: "summary_large_image",
      title: config.title,
      description: config.description,
    },
    alternates: {
      canonical: `https://reservatior.com/invest/${params.city}/${params.tool}`,
    },
    robots: {
      index: true,
      follow: true,
    },
  };
}

export default function SEOLandingPage({ params }: PageProps) {
  const config = ALL_SEO_LANDING_CONFIGS.find((c) => c.slug === params.tool);
  if (!config) notFound();

  const cityData = getCityData(config.city);

  return (
    <SEOLandingPageClient
      config={config}
      cityData={cityData || undefined}
      citySlug={params.city}
    />
  );
}
