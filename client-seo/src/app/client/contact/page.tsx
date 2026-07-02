import type { Metadata } from "next";
import { ContactContent } from "@/app/[locale]/client/contact/ContactContent";
import { BreadcrumbSchema } from "@/components/seo/SchemaScript";

export const metadata: Metadata = {
  title: "Contact Us - Get in Touch | Reservatior",
  description: "Contact Reservatior for support, inquiries, or partnership opportunities. Our team is here to help you with all your real estate needs.",
  keywords: ["contact", "support", "customer service", "help", "inquiries"],
  openGraph: {
    title: "Contact Us - Get in Touch | Reservatior",
    description: "Contact Reservatior for support, inquiries, or partnership opportunities.",
    type: "website",
  },
  alternates: {
    canonical: "/client/contact",
  },
};

export const revalidate = 3600;

export default function ContactPage() {
  return (
    <>
      <BreadcrumbSchema items={[
        { name: "Home", url: "/" },
        { name: "Contact", url: "/client/contact" },
      ]} />
      <ContactContent />
    </>
  );
}
