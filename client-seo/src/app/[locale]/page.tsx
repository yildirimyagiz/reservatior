import type { Metadata } from "next";
import { Suspense } from "react";
import dynamic from "next/dynamic";
import { propertiesApi } from "@/lib/api/properties-eden";

const HomeContent = dynamic(() => import("./HomeContent").then(mod => ({ default: mod.HomeContent })), {
  loading: () => (
    <div className="min-h-screen bg-background flex items-center justify-center">
      <div className="w-12 h-12 border-4 border-blue-500/20 border-t-blue-500 rounded-full animate-spin" />
    </div>
  ),
});

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
    const { data, error } = await propertiesApi.getAll({ limit: 4 });
    if (!error && data) {
      initialProperties = data;
    }
  } catch (error) {
    console.error("Failed to fetch initial properties for home page:", error);
  }

  return (
    <Suspense fallback={
      <div className="min-h-screen bg-background flex items-center justify-center">
        <div className="w-12 h-12 border-4 border-blue-500/20 border-t-blue-500 rounded-full animate-spin" />
      </div>
    }>
      <HomeContent initialProperties={initialProperties} />
    </Suspense>
  );
}
