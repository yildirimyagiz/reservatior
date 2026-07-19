import type { Metadata } from "next";
import SEOGeneratorPage from "./SEOGeneratorPage";

export const metadata: Metadata = {
  title: "SEO Data Generator - Admin Panel | Reservatior",
  description: "Generate structured data, investment scores, and rental yields for properties",
  keywords: ["SEO", "structured data", "JSON-LD", "investment score", "rental yield", "admin"],
  openGraph: {
    title: "SEO Data Generator - Admin Panel | Reservatior",
    description: "Generate structured data, investment scores, and rental yields for properties",
    type: "website",
  },
};

export default function SEOGeneratorPageWrapper() {
  return <SEOGeneratorPage />;
}
