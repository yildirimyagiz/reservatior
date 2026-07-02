import type { Metadata } from "next";
import { MarketplaceContent } from "./MarketplaceContent";

export const metadata: Metadata = {
  title: "Service Marketplace | Reservatior",
  description: "Find and hire professional cleaners, photographers, and property managers.",
  robots: { index: false, follow: false },
};

export default function MarketplacePage() {
  return <MarketplaceContent />;
}
