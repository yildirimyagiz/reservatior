import type { Metadata } from "next";
import { CommunicationTemplatesContent } from "@/app/[locale]/client/communications/templates/CommunicationTemplatesContent";

export const metadata: Metadata = {
  title: "Communication Templates - Message Templates | Reservatior",
  description: "Manage and create communication templates for emails, messages, and documents. Streamline your communication with pre-built templates.",
  keywords: ["communication templates", "email templates", "message templates", "document templates"],
  openGraph: {
    title: "Communication Templates - Message Templates | Reservatior",
    description: "Manage and create communication templates for emails, messages, and documents.",
    type: "website",
  },
};

export default function CommunicationTemplatesPage() {
  return <CommunicationTemplatesContent />;
}
