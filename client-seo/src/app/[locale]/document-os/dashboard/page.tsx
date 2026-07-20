import type { Metadata } from "next";
import DocumentDashboard from "@/pages-spa/document_os/Dashboard";

export const metadata: Metadata = {
  title: "Document OS Dashboard | Reservatior",
  description: "Template library, generation pipeline, and e-signature tracking.",
};

export default function DocumentDashboardPage() {
  return <DocumentDashboard />;
}
