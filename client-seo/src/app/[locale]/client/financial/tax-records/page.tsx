import type { Metadata } from "next";
import { TaxRecordsContent } from "./TaxRecordsContent";

export const metadata: Metadata = {
  title: "Tax Records - Tax Documentation | Reservatior",
  description: "Manage tax records and documentation. Store and organize tax-related documents.",
  keywords: ["tax records", "tax documentation", "tax files", "tax storage"],
  openGraph: {
    title: "Tax Records - Tax Documentation | Reservatior",
    description: "Manage tax records and documentation.",
    type: "website",
  },
};

export default function TaxRecordsPage() {
  return <TaxRecordsContent />;
}
