import type { Metadata } from "next";
import { AboutContent } from "./AboutContent";

const siteUrl = process.env.NEXT_PUBLIC_SITE_URL || 'https://reservatior.com';

export const metadata: Metadata = {
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

export default function AboutPage() {
  return <AboutContent />;
}
