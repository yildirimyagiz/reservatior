import type { Metadata } from "next";
import { propertiesApi } from "@/lib/api/properties-eden";
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

export default async function Home() {
  let initialProperties = [];
  try {
    const apiPromise = propertiesApi.getAll({ limit: 4 }).catch(() => null);
    const timeoutPromise = new Promise<null>((resolve) => setTimeout(() => resolve(null), 2500));
    const result = await Promise.race([apiPromise, timeoutPromise]);
    const { data, error } = (result as { data?: unknown[]; error?: unknown }) || {};
    if (!error && data) {
      initialProperties = data;
    }
  } catch (error) {
    console.error("Failed to fetch initial properties for home page:", error);
  }

  return <HomeContent initialProperties={initialProperties} />;
}
