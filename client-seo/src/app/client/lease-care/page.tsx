import type { Metadata } from "next";
import LeaseCarePage from "@/app/[locale]/client/lease-care/LeaseCarePage";
import { BreadcrumbSchema } from "@/components/seo/SchemaScript";

export const metadata: Metadata = {
  title: "Lease Management - Smart Lease Care | Reservatior",
  description: "Automate lease management with AI-powered tools for lease tracking, renewals, and tenant management.",
  keywords: ["lease management","lease care","tenant management","lease tracking"],
  openGraph: {
    title: "Lease Management - Smart Lease Care | Reservatior",
    description: "Automate lease management with AI-powered tools for lease tracking, renewals, and tenant management.",
    type: "website",
  },
  alternates: {
    canonical: "/client/lease-care",
  },
};

export const revalidate = 3600;

export default function LeaseCarePageWrapper() {
  return (
    <>
      <BreadcrumbSchema items={[
        { name: "Home", url: "/" },
        { name: "LeaseCare+", url: "/client/lease-care" },
      ]} />
      <LeaseCarePage />
    </>
  );
}
