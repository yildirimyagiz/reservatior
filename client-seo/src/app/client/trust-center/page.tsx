import type { Metadata } from "next";
import TrustCenterPage from "@/app/[locale]/client/trust-center/TrustCenterPage";
import { BreadcrumbSchema } from "@/components/seo/SchemaScript";

export const metadata: Metadata = {
  title: "Trust Center - Security & Compliance | Reservatior",
  description: "Learn about Reservatior's enterprise-grade security, compliance, and trust measures protecting your real estate transactions.",
  keywords: ["trust","security","compliance","real estate security","data protection"],
  openGraph: {
    title: "Trust Center - Security & Compliance | Reservatior",
    description: "Learn about Reservatior's enterprise-grade security, compliance, and trust measures protecting your real estate transactions.",
    type: "website",
  },
  alternates: {
    canonical: "/client/trust-center",
  },
};

export const revalidate = 3600;

export default function TrustCenterPageWrapper() {
  return (
    <>
      <BreadcrumbSchema items={[
        { name: "Home", url: "/" },
        { name: "Trust Center", url: "/client/trust-center" },
      ]} />
      <TrustCenterPage />
    </>
  );
}
