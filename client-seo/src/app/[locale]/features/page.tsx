import type { Metadata } from "next";
import { Suspense } from "react";
import dynamic from "next/dynamic";
import { AppHeader } from "@/components/layout/AppHeader";
import { Footer } from "@/components/layout/Footer";
const siteUrl = process.env.NEXT_PUBLIC_SITE_URL || 'https://reservatior.com';

const Features = dynamic(() => import("@/pages-spa/public/Features"), {
  loading: () => (
    <div className="flex items-center justify-center min-h-[60vh]">
      <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary" />
    </div>
  ),
});


export async function generateMetadata({ params: { locale } }: { params: { locale: string } }): Promise<Metadata> {
  return {
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
}

export default function FeaturesPage() {
  return (
    <div className="flex flex-col min-h-screen bg-background">
      <AppHeader />
      <main className="flex-1">
        <Suspense fallback={
          <div className="flex items-center justify-center min-h-[60vh]">
            <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary" />
          </div>
        }>
          <Features />
        </Suspense>
      </main>
      <Footer />
    </div>
  );
}
