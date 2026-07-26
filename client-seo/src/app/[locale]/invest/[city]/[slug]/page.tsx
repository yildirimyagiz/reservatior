import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { ALL_SEO_LANDING_CONFIGS, getCityData, ALL_MARKET_DATA } from "@/lib/seo/market-data";
import { SEOLandingPageClient } from "./SEOLandingPageClient";
import { DistrictLandingPageClient } from "./DistrictLandingPageClient";

interface PageProps {
  params: { city: string; slug: string };
}

export function generateStaticParams() {
  const params: Array<{ city: string; slug: string }> = [];

  for (const config of ALL_SEO_LANDING_CONFIGS) {
    params.push({ city: config.city, slug: config.slug });
  }

  for (const [citySlug, cityData] of Object.entries(ALL_MARKET_DATA)) {
    for (const district of cityData.districts) {
      const slug = district.name.toLowerCase().replace(/[^a-z0-9]+/g, "-").replace(/-+$/, "");
      params.push({ city: citySlug, slug });
    }
  }

  return params;
}

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const toolConfig = ALL_SEO_LANDING_CONFIGS.find((c) => c.slug === params.slug);
  if (toolConfig) {
    return {
      title: toolConfig.title,
      description: toolConfig.description,
      keywords: toolConfig.keywords,
      openGraph: {
        title: toolConfig.title,
        description: toolConfig.description,
        type: "website",
        url: `https://reservatior.com/invest/${params.city}/${params.slug}`,
        siteName: "Reservatior",
      },
      twitter: {
        card: "summary_large_image",
        title: toolConfig.title,
        description: toolConfig.description,
      },
      alternates: {
        canonical: `https://reservatior.com/invest/${params.city}/${params.slug}`,
      },
      robots: { index: true, follow: true },
    };
  }

  const cityData = ALL_MARKET_DATA[params.city];
  if (!cityData) return {};
  const districtName = params.slug.replace(/-/g, " ").replace(/\b\w/g, (l) => l.toUpperCase());
  const district = cityData.districts.find(
    (d) => d.name.toLowerCase().replace(/[^a-z0-9]+/g, "-") === params.slug
  );

  return {
    title: `${districtName} ${cityData.city} Property Investment | ROI ${district?.grossYield || 0}% Yield`,
    description: `Investment analysis for ${districtName}, ${cityData.city}. Rental yield ${district?.grossYield || 0}%, appreciation ${district?.appreciation || 0}%, investment grade ${district?.investmentGrade || "N/A"}. Free ROI calculator.`,
    keywords: [
      `${districtName.toLowerCase()} ${cityData.city.toLowerCase()} investment`,
      `${districtName.toLowerCase()} property yield`,
      `${districtName.toLowerCase()} rental yield`,
      `${districtName.toLowerCase()} roi`,
      `${cityData.city.toLowerCase()} ${districtName.toLowerCase()} property`,
    ],
    openGraph: {
      title: `${districtName} ${cityData.city} Property Investment`,
      description: `Rental yield ${district?.grossYield || 0}%, appreciation ${district?.appreciation || 0}% in ${districtName}, ${cityData.city}`,
      type: "website",
    },
    alternates: {
      canonical: `https://reservatior.com/en/invest/${params.city}/${params.slug}`,
    },
    robots: { index: true, follow: true },
  };
}

export default function InvestSlugPage({ params }: PageProps) {
  const toolConfig = ALL_SEO_LANDING_CONFIGS.find((c) => c.slug === params.slug);
  if (toolConfig) {
    const cityData = getCityData(toolConfig.city);
    return (
      <SEOLandingPageClient
        config={toolConfig}
        cityData={cityData || undefined}
        citySlug={params.city}
      />
    );
  }

  const cityData = ALL_MARKET_DATA[params.city];
  if (!cityData) notFound();
  const district = cityData.districts.find(
    (d) => d.name.toLowerCase().replace(/[^a-z0-9]+/g, "-") === params.slug
  );
  if (!district) notFound();

  return <DistrictLandingPageClient city={cityData} district={district} districtSlug={params.slug} />;
}
