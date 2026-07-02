import type { Metadata } from "next";
import { PricingContent } from "./PricingContent";
import { BreadcrumbSchema } from "@/components/seo/SchemaScript";

export const metadata: Metadata = {
  title: "Pricing Plans - Affordable Real Estate Solutions | Reservatior",
  description: "Choose the perfect pricing plan for your real estate needs. From starter to enterprise, we have flexible options for property management and AI-powered tools.",
  keywords: ["pricing", "plans", "subscription", "cost", "real estate software"],
  openGraph: {
    title: "Pricing Plans - Affordable Real Estate Solutions | Reservatior",
    description: "Choose the perfect pricing plan for your real estate needs.",
    type: "website",
  },
  alternates: {
    canonical: "/client/pricing",
  },
};

export const revalidate = 3600;

export default function PricingPage() {
  return (
    <>
      <BreadcrumbSchema items={[
        { name: "Home", url: "/" },
        { name: "Pricing", url: "/client/pricing" },
      ]} />
      <PricingContent />
    </>
  );
}
