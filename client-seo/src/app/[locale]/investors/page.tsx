import type { Metadata } from "next";
import { Suspense } from "react";
import dynamic from "next/dynamic";
const siteUrl = process.env.NEXT_PUBLIC_SITE_URL || 'https://reservatior.com';

const InvestorsContent = dynamic(() => import("./InvestorsContent").then(mod => ({ default: mod.InvestorsContent })), {
  loading: () => (
    <div className="flex items-center justify-center min-h-[60vh]">
      <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary" />
    </div>
  ),
});

export async function generateMetadata(): Promise<Metadata> {
  return {
    title: "Investors | Reservatior",
    description: "Track your real estate investments, monitor ROI, and analyze property performance with Reservatior's investor portal.",
    openGraph: {
      title: "Investors | Reservatior",
      description: "Track your real estate investments, monitor ROI, and analyze property performance.",
      type: "website",
      url: `${siteUrl}/investors`,
    },
    alternates: {
      canonical: `${siteUrl}/investors`,
    },
  };
}

export default function InvestorsPage() {
  return (
    <Suspense fallback={
      <div className="flex items-center justify-center min-h-[60vh]">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary" />
      </div>
    }>
      <InvestorsContent />
    </Suspense>
  );
}
