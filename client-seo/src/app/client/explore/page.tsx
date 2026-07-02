import type { Metadata } from "next";
import ExplorePage from "@/app/[locale]/client/explore/ExplorePage";
import { BreadcrumbSchema } from "@/components/seo/SchemaScript";

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
      <ExplorePage />
    </>
  );
}
