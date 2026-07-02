import type { Metadata } from "next";
import { PrivacyContent } from "./PrivacyContent";
import { BreadcrumbSchema } from "@/components/seo/SchemaScript";

export const metadata: Metadata = {
  title: "Privacy Policy - Data Protection | Reservatior",
  description: "Learn how Reservatior protects your data and privacy. Our comprehensive privacy policy explains data collection, usage, and security measures.",
  keywords: ["privacy policy", "data protection", "GDPR", "security", "privacy"],
  openGraph: {
    title: "Privacy Policy - Data Protection | Reservatior",
    description: "Learn how Reservatior protects your data and privacy.",
    type: "website",
  },
  alternates: {
    canonical: "/client/privacy",
  },
};

export const revalidate = 86400;

export default function PrivacyPage() {
  return (
    <>
      <BreadcrumbSchema items={[
        { name: "Home", url: "/" },
        { name: "Privacy Policy", url: "/client/privacy" },
      ]} />
      <PrivacyContent />
    </>
  );
}
