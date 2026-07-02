import type { Metadata } from "next";
import HospitalityStandardsPage from "./HospitalityStandardsPage";
import { BreadcrumbSchema } from "@/components/seo/SchemaScript";

export const metadata: Metadata = {
  title: "Hospitality Standards - Premium Property Standards | Reservatior",
  description: "Discover Reservatior's hospitality standards for premium property management and guest experience.",
  keywords: ["hospitality","property standards","guest experience","premium property"],
  openGraph: {
    title: "Hospitality Standards - Premium Property Standards | Reservatior",
    description: "Discover Reservatior's hospitality standards for premium property management and guest experience.",
    type: "website",
  },
  alternates: {
    canonical: "/client/hospitality-standards",
  },
};

export const revalidate = 3600;

export default function HospitalityStandardsPageWrapper() {
  return (
    <>
      <BreadcrumbSchema items={[
        { name: "Home", url: "/" },
        { name: "Hospitality Standards", url: "/client/hospitality-standards" },
      ]} />
      <HospitalityStandardsPage />
    </>
  );
}
