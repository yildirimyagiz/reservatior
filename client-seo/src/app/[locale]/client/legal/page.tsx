import type { Metadata } from "next";
import { LegalContent } from "./LegalContent";
import { BreadcrumbSchema } from "@/components/seo/SchemaScript";

export const metadata: Metadata = {
  title: "Legal - Legal Management | Reservatior",
  description: "Manage all legal aspects of your property business. Documents, compliance, signatures, and more.",
  keywords: ["legal", "legal management", "property law", "compliance"],
  openGraph: {
    title: "Legal - Legal Management | Reservatior",
    description: "Manage all legal aspects of your property business.",
    type: "website",
  },
  alternates: {
    canonical: "/client/legal",
  },
};

export default function LegalPage() {
  return (
    <>
      <BreadcrumbSchema items={[
        { name: "Home", url: "/" },
        { name: "Legal", url: "/client/legal" },
      ]} />
      <LegalContent />
    </>
  );
}
