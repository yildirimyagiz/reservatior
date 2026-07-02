import type { Metadata } from "next";
import { TermsContent } from "./TermsContent";
import { BreadcrumbSchema } from "@/components/seo/SchemaScript";

export const metadata: Metadata = {
  title: "Terms of Service - Legal Terms | Reservatior",
  description: "Read our terms of service and legal agreements. Understand your rights and responsibilities when using Reservatior's real estate platform.",
  keywords: ["terms of service", "legal", "agreement", "terms", "conditions"],
  openGraph: {
    title: "Terms of Service - Legal Terms | Reservatior",
    description: "Read our terms of service and legal agreements.",
    type: "website",
  },
  alternates: {
    canonical: "/client/terms",
  },
};

export const revalidate = 86400;

export default function TermsPage() {
  return (
    <>
      <BreadcrumbSchema items={[
        { name: "Home", url: "/" },
        { name: "Terms of Service", url: "/client/terms" },
      ]} />
      <TermsContent />
    </>
  );
}
