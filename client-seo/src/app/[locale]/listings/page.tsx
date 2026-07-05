import type { Metadata } from "next";
import ListingsSearchPage from "./ListingManagement";

export const metadata: Metadata = {
  title: "Property Listings - Find Your Perfect Property | Reservatior",
  description: "Browse property listings for sale and rent. AI-powered search with advanced filters, map view, and real-time listings.",
  keywords: ["property listings", "real estate", "homes for sale", "rentals", "property search"],
  openGraph: {
    title: "Property Listings - Find Your Perfect Property | Reservatior",
    description: "Browse property listings for sale and rent with AI-powered search.",
    type: "website",
  },
  alternates: {
    canonical: "/listings",
  },
};

export const revalidate = 3600;

export default function ListingsPage() {
  return <ListingsSearchPage />;
}
