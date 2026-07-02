import type { Metadata } from "next";
import TenantVerificationPage from "@/app/[locale]/client/tenant-verification/TenantVerificationPage";
import { BreadcrumbSchema } from "@/components/seo/SchemaScript";

export const metadata: Metadata = {
  title: "Tenant Verification - Secure Tenant Screening | Reservatior",
  description: "Verify tenants with AI-powered screening and identity verification for secure property rentals.",
  keywords: ["tenant verification","screening","identity verification","tenant screening"],
  openGraph: {
    title: "Tenant Verification - Secure Tenant Screening | Reservatior",
    description: "Verify tenants with AI-powered screening and identity verification for secure property rentals.",
    type: "website",
  },
  alternates: {
    canonical: "/client/tenant-verification",
  },
};

export const revalidate = 3600;

export default function TenantVerificationPageWrapper() {
  return (
    <>
      <BreadcrumbSchema items={[
        { name: "Home", url: "/" },
        { name: "Tenant Verification", url: "/client/tenant-verification" },
      ]} />
      <TenantVerificationPage />
    </>
  );
}
