import type { Metadata } from "next";
import { Suspense } from "react";
import dynamic from "next/dynamic";
import { BreadcrumbSchema } from "@/components/seo/SchemaScript";

const ExplorePage = dynamic(() => import("./ExplorePage"), {
  loading: () => (
    <div className="flex items-center justify-center min-h-[60vh]">
      <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary" />
    </div>
  ),
});

export const metadata: Metadata = {
  title: "Explore Features - Powerful Real Estate Tools | Reservatior",
  description: "Discover Reservatior's powerful real estate management features including AI valuation, smart search, analytics, and automation.",
  keywords: ["explore","features","real estate tools","AI valuation","property search"],
  openGraph: {
    title: "Explore Features - Powerful Real Estate Tools | Reservatior",
    description: "Discover Reservatior's powerful real estate management features including AI valuation, smart search, analytics, and automation.",
    type: "website",
  },
  alternates: {
    canonical: "/client/explore",
  },
};

export const revalidate = 3600;

export default function ExplorePageWrapper() {
  return (
    <>
      <BreadcrumbSchema items={[
        { name: "Home", url: "/" },
        { name: "Explore", url: "/client/explore" },
      ]} />
      <Suspense fallback={
        <div className="flex items-center justify-center min-h-[60vh]">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary" />
        </div>
      }>
        <ExplorePage />
      </Suspense>
    </>
  );
}
