import type { Metadata } from "next";

import { Suspense } from "react";
import dynamic from "next/dynamic";
import { BreadcrumbSchema } from "@/components/seo/SchemaScript";
const siteUrl = process.env.NEXT_PUBLIC_SITE_URL || 'https://reservatior.com';

const AISearchPage = dynamic(() => import("./AISearchPage"), {
  loading: () => (
    <div className="flex items-center justify-center min-h-[60vh]">
      <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary" />
    </div>
  ),
});

export async function generateMetadata({ params: { locale } }: { params: { locale: string } }): Promise<Metadata> {
  return {
  title: "AI Property Search - Smart Real Estate Search | Reservatior",
  description: "Search properties using natural language with AI-powered real estate search engine. Find your dream property with intelligent filtering and analysis.",
  keywords: ["AI search","property search","real estate AI","smart search","natural language search"],
  openGraph: {
      url: `${siteUrl}/${locale}/ai-search`,
    title: "AI Property Search - Smart Real Estate Search | Reservatior",
    description: "Search properties using natural language with AI-powered real estate search engine. Find your dream property with intelligent filtering and analysis.",
    type: "website",
  },
  alternates: {
    canonical: "/ai-search",
  },

  };
}

export const revalidate = 3600;

export default function AISearchPageWrapper() {
  return (
    <>
      <BreadcrumbSchema items={[
        { name: "Home", url: "/" },
        { name: "AI Property Search", url: "/ai-search" },
      ]} />
      <Suspense fallback={
        <div className="flex items-center justify-center min-h-[60vh]">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary" />
        </div>
      }>
        <AISearchPage />
      </Suspense>
    </>
  );
}
