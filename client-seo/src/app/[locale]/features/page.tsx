import type { Metadata } from "next";
import Features from "@/pages-spa/public/Features";
import { AppHeader } from "@/components/layout/AppHeader";
import { Footer } from "@/components/layout/Footer";

const siteUrl = process.env.NEXT_PUBLIC_SITE_URL || 'https://reservatior.com';

export const metadata: Metadata = {
  title: "Features | Reservatior",
  description: "Explore Reservatior's powerful features: AI-powered property search, virtual staging, automated workflows, and comprehensive real estate management tools.",
  openGraph: {
    title: "Features | Reservatior",
    description: "Explore Reservatior's powerful features: AI-powered property search, virtual staging, automated workflows, and comprehensive real estate management tools.",
    type: "website",
    url: `${siteUrl}/features`,
  },
  alternates: {
    canonical: `${siteUrl}/features`,
  },
};

export default function FeaturesPage() {
  return (
    <div className="flex flex-col min-h-screen bg-background">
      <AppHeader />
      <main className="flex-1">
        <Features />
      </main>
      <Footer />
    </div>
  );
}
