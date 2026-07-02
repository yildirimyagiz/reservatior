import type { Metadata } from "next";
import ShortTermRentalSafetyPage from "./ShortTermRentalSafetyPage";
import { BreadcrumbSchema } from "@/components/seo/SchemaScript";

export const metadata: Metadata = {
  title: "Short-Term Rental Safety - Guest & Property Safety | Reservatior",
  description: "Comprehensive safety guidelines and best practices for short-term rental properties and guest security.",
  keywords: ["short-term rental","safety","guest safety","rental guidelines"],
  openGraph: {
    title: "Short-Term Rental Safety - Guest & Property Safety | Reservatior",
    description: "Comprehensive safety guidelines and best practices for short-term rental properties and guest security.",
    type: "website",
  },
  alternates: {
    canonical: "/client/short-term-rental-safety",
  },
};

export const revalidate = 3600;

export default function ShortTermRentalSafetyPageWrapper() {
  return (
    <>
      <BreadcrumbSchema items={[
        { name: "Home", url: "/" },
        { name: "Short-Term Rental Safety", url: "/client/short-term-rental-safety" },
      ]} />
      <ShortTermRentalSafetyPage />
    </>
  );
}
