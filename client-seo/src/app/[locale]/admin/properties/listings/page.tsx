import type { Metadata } from "next";
import PropertyListingsPage from "./PropertyListingsPage";

export const metadata: Metadata = {
  title: "Property Listings - Listing Management | Reservatior",
  description: "Manage and optimize your property listings across multiple platforms.",
  keywords: ["listings","property listings","listing management","multi-platform"],
  openGraph: {
    title: "Property Listings - Listing Management | Reservatior",
    description: "Manage and optimize your property listings across multiple platforms.",
    type: "website",
  },
};

export default function PropertyListingsPageWrapper() {
  return <PropertyListingsPage />;
}
