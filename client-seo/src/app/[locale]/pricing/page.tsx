import { AppHeader } from "@/components/layout/AppHeader";
import { Footer } from "@/components/layout/Footer";
import Pricing from "@/pages-spa/client/Pricing";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Pricing Plans - Affordable Real Estate Solutions | Reservatior",
  description: "Choose the perfect pricing plan for your real estate needs. From starter to enterprise, we have flexible options for property management and AI-powered tools.",
  openGraph: {
    title: "Pricing Plans - Affordable Real Estate Solutions | Reservatior",
    description: "Choose the perfect pricing plan for your real estate needs.",
    type: "website",
  },
  twitter: {
    card: "summary_large_image",
    title: "Pricing Plans - Affordable Real Estate Solutions | Reservatior",
    description: "Choose the perfect pricing plan for your real estate needs.",
  }
};

export default function PricingPage() {
  return (
    <div className="flex flex-col min-h-screen bg-background">
      <AppHeader />
      <main className="flex-1">
        <Pricing />
      </main>
      <Footer />
    </div>
  );
}
