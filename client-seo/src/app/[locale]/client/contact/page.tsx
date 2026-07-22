import type { Metadata } from "next";
import { Suspense } from "react";
import dynamic from "next/dynamic";
import { BreadcrumbSchema } from "@/components/seo/SchemaScript";

const ContactContent = dynamic(() => import("./ContactContent").then(mod => ({ default: mod.ContactContent })), {
  loading: () => (
    <div className="flex items-center justify-center min-h-[60vh]">
      <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary" />
    </div>
  ),
});

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
      <Suspense fallback={
        <div className="flex items-center justify-center min-h-[60vh]">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary" />
        </div>
      }>
        <ContactContent />
      </Suspense>
    </>
  );
}
