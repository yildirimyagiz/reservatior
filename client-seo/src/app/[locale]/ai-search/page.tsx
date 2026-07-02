import type { Metadata } from "next";
import { BreadcrumbSchema } from "@/components/seo/SchemaScript";
import AISearchPage from "./AISearchPage";

export const metadata: Metadata = {
  title: "AI Property Search - Smart Real Estate Search | Reservatior",
  description: "Search properties using natural language with AI-powered real estate search engine. Find your dream property with intelligent filtering and analysis.",
  keywords: ["AI search","property search","real estate AI","smart search","natural language search"],
  openGraph: {
    title: "AI Property Search - Smart Real Estate Search | Reservatior",
    description: "Search properties using natural language with AI-powered real estate search engine. Find your dream property with intelligent filtering and analysis.",
    type: "website",
  },
  alternates: {
    canonical: "/ai-search",
  },
};

export const revalidate = 3600;

export default function AISearchPageWrapper() {
  return (
    <>
      <BreadcrumbSchema items={[
        { name: "Home", url: "/" },
        { name: "AI Property Search", url: "/ai-search" },
      ]} />
      <AISearchPage />
    </>
  );
}
