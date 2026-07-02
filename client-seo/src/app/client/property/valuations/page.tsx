import type { Metadata } from "next";
import PropertyValuationsPage from "@/app/[locale]/client/property/valuations/PropertyValuationsPage";

export const metadata: Metadata = {
  title: "Property Valuations - AI-Powered Estimates | Reservatior",
  description: "Get AI-powered property valuations and market analysis for informed decisions.",
  keywords: ["valuations","AI valuation","property estimates","market analysis"],
  openGraph: {
    title: "Property Valuations - AI-Powered Estimates | Reservatior",
    description: "Get AI-powered property valuations and market analysis for informed decisions.",
    type: "website",
  },
};

export default function PropertyValuationsPageWrapper() {
  return <PropertyValuationsPage />;
}
