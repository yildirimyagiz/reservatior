import type { Metadata } from "next";
import MarketplacePage from "./MarketplacePage";

export const metadata: Metadata = {
  title: "Asset Marketplace - Admin Panel | Reservatior",
  description: "Income-verified residential property asset trading marketplace",
  keywords: ["marketplace", "investment", "property", "assets", "trading"],
  openGraph: {
    title: "Asset Marketplace - Admin Panel | Reservatior",
    description: "Income-verified residential property asset trading marketplace",
    type: "website",
  },
};

export default function MarketplacePageWrapper() {
  return <MarketplacePage />;
}
