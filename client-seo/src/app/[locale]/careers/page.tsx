import type { Metadata } from "next";
import { Suspense } from "react";
import dynamic from "next/dynamic";
const siteUrl = process.env.NEXT_PUBLIC_SITE_URL || 'https://reservatior.com';

const CareersContent = dynamic(() => import("./CareersContent").then(mod => ({ default: mod.CareersContent })), {
  loading: () => (
    <div className="flex items-center justify-center min-h-[60vh]">
      <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary" />
    </div>
  ),
});

export async function generateMetadata(): Promise<Metadata> {
  return {
    title: "Careers | Reservatior",
    description: "Join Reservatior's team. We're building the future of AI-powered real estate and property management.",
    openGraph: {
      title: "Careers | Reservatior",
      description: "Join Reservatior's team. We're building the future of AI-powered real estate and property management.",
      type: "website",
      url: `${siteUrl}/careers`,
    },
    alternates: {
      canonical: `${siteUrl}/careers`,
    },
  };
}

export default function CareersPage() {
  return (
    <Suspense fallback={
      <div className="flex items-center justify-center min-h-[60vh]">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary" />
      </div>
    }>
      <CareersContent />
    </Suspense>
  );
}
