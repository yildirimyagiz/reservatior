import type { Metadata } from "next";
import { Suspense } from "react";
import dynamic from "next/dynamic";
import { AppHeader } from "@/components/layout/AppHeader";
import { Footer } from "@/components/layout/Footer";

const siteUrl = process.env.NEXT_PUBLIC_SITE_URL || "https://reservatior.com";

const GlobalOSLanding = dynamic(
  () => import("@/pages-spa/public/GlobalOSLanding"),
  {
    loading: () => (
      <div className="flex items-center justify-center min-h-[60vh]">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary" />
      </div>
    ),
  }
);

export async function generateMetadata({
  params: { locale: _locale },
}: {
  params: { locale: string };
}): Promise<Metadata> {
  return {
    title: "Global Hybrid Rental & Revenue OS | Reservatior",
    description:
      "Operate short-term rentals, corporate housing, and serviced apartments across 23 countries with AI-powered compliance, tax optimization, and revenue intelligence.",
    openGraph: {
      title: "Global Hybrid Rental & Revenue OS | Reservatior",
      description:
        "Operate short-term rentals, corporate housing, and serviced apartments across 23 countries with AI-powered compliance, tax optimization, and revenue intelligence.",
      type: "website",
      url: `${siteUrl}/global-os`,
    },
    alternates: {
      canonical: `${siteUrl}/global-os`,
    },
  };
}

export default function GlobalOSPage() {
  return (
    <div className="flex flex-col min-h-screen bg-background">
      <AppHeader />
      <main className="flex-1">
        <Suspense
          fallback={
            <div className="flex items-center justify-center min-h-[60vh]">
              <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary" />
            </div>
          }
        >
          <GlobalOSLanding />
        </Suspense>
      </main>
      <Footer />
    </div>
  );
}
