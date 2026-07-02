import type { Metadata } from "next";
import { PropertiesContent } from "@/app/[locale]/client/investors/PropertiesContent";

export const metadata: Metadata = {
  title: "Investor Portfolio | Reservatior",
  description: "Track your real estate investments, monitor ROI, and analyze property performance.",
  robots: { index: false, follow: false },
};

export default function InvestorsPage() {
  return <PropertiesContent />;
}
