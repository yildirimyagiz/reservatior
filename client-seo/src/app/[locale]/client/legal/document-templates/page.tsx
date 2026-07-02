import type { Metadata } from "next";
import { DocumentTemplatesContent } from "./DocumentTemplatesContent";

export const metadata: Metadata = {
  title: "Document Templates - Legal Templates | Reservatior",
  description: "Create and manage legal document templates. Standardize your legal documentation.",
  keywords: ["document templates", "legal templates", "document automation", "template management"],
  openGraph: {
    title: "Document Templates - Legal Templates | Reservatior",
    description: "Create and manage legal document templates.",
    type: "website",
  },
};

export default function DocumentTemplatesPage() {
  return <DocumentTemplatesContent />;
}
