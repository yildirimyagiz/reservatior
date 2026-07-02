import type { Metadata } from "next";
import PropertiesPage from "@/app/[locale]/client/properties/PropertiesPage";

export const metadata: Metadata = {
  title: "My Properties - Property Portfolio | Reservatior",
  description: "Manage your property portfolio with AI-powered insights, valuations, and listing management.",
  keywords: ["properties","portfolio","property management","listings"],
  openGraph: {
    title: "My Properties - Property Portfolio | Reservatior",
    description: "Manage your property portfolio with AI-powered insights, valuations, and listing management.",
    type: "website",
  },
};

export default function PropertiesPageWrapper() {
  return <PropertiesPage />;
}
