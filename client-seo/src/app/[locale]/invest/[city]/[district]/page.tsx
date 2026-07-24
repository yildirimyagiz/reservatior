import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { ALL_MARKET_DATA } from "@/lib/seo/market-data";
import { DistrictLandingPageClient } from "./DistrictLandingPageClient";

interface PageProps {
  params: { city: string; district: string };
}

export function generateStaticParams() {
  const params: Array<{ city: string; district: string }> = [];
  for (const [citySlug, cityData] of Object.entries(ALL_MARKET_DATA)) {
    for (const district of cityData.districts) {
      const slug = district.name.toLowerCase().replace(/[^a-z0-9]+/g, "-").replace(/-+$/, "");
      params.push({ city: citySlug, district: slug });
    }
  }
  return params;
}

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const cityData = ALL_MARKET_DATA[params.city];
  if (!cityData) return {};
  const districtName = params.district.replace(/-/g, " ").replace(/\b\w/g, (l) => l.toUpperCase());
  const district = cityData.districts.find(
    (d) => d.name.toLowerCase().replace(/[^a-z0-9]+/g, "-") === params.district
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
      canonical: `https://reservatior.com/en/invest/${params.city}/${params.district}`,
    },
    robots: { index: true, follow: true },
  };
}

export default function DistrictPage({ params }: PageProps) {
  const cityData = ALL_MARKET_DATA[params.city];
  if (!cityData) notFound();
  const district = cityData.districts.find(
    (d) => d.name.toLowerCase().replace(/[^a-z0-9]+/g, "-") === params.district
  );
  if (!district) notFound();

  return <DistrictLandingPageClient city={cityData} district={district} districtSlug={params.district} />;
}
