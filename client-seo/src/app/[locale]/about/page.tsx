import type { Metadata } from "next";
import { Suspense } from "react";
import dynamic from "next/dynamic";
const siteUrl = process.env.NEXT_PUBLIC_SITE_URL || 'https://reservatior.com';

const AboutContent = dynamic(() => import("./AboutContent").then(mod => ({ default: mod.AboutContent })), {
  loading: () => (
    <div className="flex items-center justify-center min-h-[60vh]">
      <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary" />
    </div>
  ),
});


export async function generateMetadata({ params: { locale } }: { params: { locale: string } }): Promise<Metadata> {
  return {
  title: "About Us | Reservatior",
  description: "Learn about Reservatior's mission to redefine modern hospitality and property management through high-performance, enterprise-grade technology.",
  openGraph: {
    title: "About Us | Reservatior",
    description: "Learn about Reservatior's mission to redefine modern hospitality and property management through high-performance, enterprise-grade technology.",
    type: "website",
    url: `${siteUrl}/about`,
  },
  alternates: {
    canonical: `${siteUrl}/about`,
  },

  };
}

export default function AboutPage() {
  return (
    <Suspense fallback={
      <div className="flex items-center justify-center min-h-[60vh]">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary" />
      </div>
    }>
      <AboutContent />
    </Suspense>
  );
}
