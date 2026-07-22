import type { Metadata } from "next";

import { Suspense } from "react";
import dynamic from "next/dynamic";
const siteUrl = process.env.NEXT_PUBLIC_SITE_URL || 'https://reservatior.com';

const AutomationPage = dynamic(() => import("./AutomationPage"), {
  loading: () => (
    <div className="flex items-center justify-center min-h-[60vh]">
      <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary" />
    </div>
  ),
});

export async function generateMetadata({ params: { locale } }: { params: { locale: string } }): Promise<Metadata> {
  return {
  title: "Automation Dashboard - Smart Workflow Management | Reservatior",
  description: "Automate your real estate workflows with AI-powered triggers and smart notifications. Streamline property management tasks effortlessly.",
  keywords: ["automation","workflow","triggers","real estate automation","smart notifications"],
  openGraph: {
      url: `${siteUrl}/${locale}/automation`,
    title: "Automation Dashboard - Smart Workflow Management | Reservatior",
    description: "Automate your real estate workflows with AI-powered triggers and smart notifications. Streamline property management tasks effortlessly.",
    type: "website",
  },

    alternates: {
      canonical: `${siteUrl}/${locale}/automation`,
    },
  };
}

export const revalidate = 3600;

export default function AutomationPageWrapper() {
  return (
    <Suspense fallback={
      <div className="flex items-center justify-center min-h-[60vh]">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary" />
      </div>
    }>
      <AutomationPage />
    </Suspense>
  );
}
