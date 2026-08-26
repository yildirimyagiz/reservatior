import type { Metadata } from "next";
import { HomeContent } from "./HomeContent";

export const metadata: Metadata = {
  title: "Reservatior - Premium Real Estate Platform with AI",
  description: "Find your perfect property with Reservatior's premium real estate platform. AI-powered property search, valuations, and automated workflows.",
  keywords: ["real estate", "property search", "AI valuation", "property management", "booking system"],
  openGraph: {
    title: "Reservatior - Premium Real Estate Platform with AI",
    description: "Find your perfect property with Reservatior's premium real estate platform.",
    type: "website",
  },
};

export const revalidate = 60;

const LOCALE_TO_REGION: Record<string, string> = {
  tr: "TR", ar: "AE", de: "DE", fr: "FR", es: "ES", it: "IT",
  nl: "NL", pt: "BR", ja: "JP", ko: "KR", zh: "CN", ru: "RU",
  pl: "PL", hi: "IN", nb: "NO", sv: "SE", da: "DK", fi: "FI", el: "GR",
};

export default async function Home({ params }: { params: { locale: string } }) {
  const { locale } = params;
  const region = LOCALE_TO_REGION[locale] || "US";

  let initialProperties: Record<string, unknown>[] = [];
  try {
    const backendUrl = process.env.BACKEND_INTERNAL_URL || "http://localhost:3000";
    const controller = new AbortController();
    const timeout = setTimeout(() => controller.abort(), 2500);
    const res = await fetch(`${backendUrl}/api/v1/property?limit=4&sortBy=size_desc&region=${region}`, {
      headers: { "X-Region": region },
      signal: controller.signal,
    });
    clearTimeout(timeout);
    if (res.ok) {
      const json = await res.json();
      if (json.data?.length > 0) {
        initialProperties = json.data;
      }
    }
  } catch (error) {
    console.error("Failed to fetch initial properties for home page:", error);
  }

  return <HomeContent initialProperties={initialProperties} />;
}
