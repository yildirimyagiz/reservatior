import type { Metadata } from "next";
import { DocumentsContent } from "./DocumentsContent";

export const metadata: Metadata = {
  title: "Documents - Legal Documents | Reservatior",
  description: "Manage legal documents for properties and rentals. Store, organize, and track legal paperwork.",
  keywords: ["legal documents", "property documents", "rental agreements", "legal paperwork"],
  openGraph: {
    title: "Documents - Legal Documents | Reservatior",
    description: "Manage legal documents for properties and rentals.",
    type: "website",
  },
};

export default function DocumentsPage() {
  return <DocumentsContent />;
}
