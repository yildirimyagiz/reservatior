import type { Metadata } from "next";
import { CRMContent } from "./CRMContent";

export const metadata: Metadata = {
  title: "CRM - Customer Relationship Management | Reservatior",
  description: "Manage leads, customers, and relationships. Track interactions and sales pipeline.",
  keywords: ["crm", "customer relationship management", "leads", "sales pipeline"],
  openGraph: {
    title: "CRM - Customer Relationship Management | Reservatior",
    description: "Manage leads, customers, and relationships.",
    type: "website",
  },
  robots: { index: false, follow: false },
};

export default function CRMPage() {
  return <CRMContent />;
}
