import type { Metadata } from "next";
import { SolicitorManagementContent } from "@/app/[locale]/client/legal/solicitor-management/SolicitorManagementContent";

export const metadata: Metadata = {
  title: "Solicitor Management - Legal Professionals | Reservatior",
  description: "Manage solicitors and legal professionals. Track legal representation and solicitor relationships.",
  keywords: ["solicitors", "legal professionals", "lawyers", "legal representation"],
  openGraph: {
    title: "Solicitor Management - Legal Professionals | Reservatior",
    description: "Manage solicitors and legal professionals.",
    type: "website",
  },
};

export default function SolicitorManagementPage() {
  return <SolicitorManagementContent />;
}
