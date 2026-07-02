import type { Metadata } from "next";
import { ComplianceContent } from "./ComplianceContent";

export const metadata: Metadata = {
  title: "Compliance - Legal Compliance | Reservatior",
  description: "Manage legal compliance for properties and rentals. Track regulatory requirements and compliance status.",
  keywords: ["compliance", "legal compliance", "regulatory requirements", "property compliance"],
  openGraph: {
    title: "Compliance - Legal Compliance | Reservatior",
    description: "Manage legal compliance for properties and rentals.",
    type: "website",
  },
};

export default function CompliancePage() {
  return <ComplianceContent />;
}
