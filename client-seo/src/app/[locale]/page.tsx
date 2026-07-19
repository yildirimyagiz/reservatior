import type { Metadata } from "next";
import { HomeContent } from "./HomeContent";
import { propertiesApi } from "@/lib/api/properties-eden";

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
  // Fetch properties on the server for initial render (SEO)
  let initialProperties = [];
  try {
    const { data, error } = await propertiesApi.getAll({ limit: 4 });
    if (!error && data) {
      initialProperties = data;
    }
  } catch (error) {
    console.error("Failed to fetch initial properties for home page:", error);
  }

  return <HomeContent initialProperties={initialProperties} />;
}
