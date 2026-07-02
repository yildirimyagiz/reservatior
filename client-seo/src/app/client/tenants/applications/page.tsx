import type { Metadata } from "next";
import { TenantApplicationsContent } from "@/app/[locale]/client/tenants/applications/TenantApplicationsContent";

export const metadata: Metadata = {
  title: "Tenant Applications - Rental Applications | Reservatior",
  description: "Manage rental applications from prospective tenants. Review, approve, or reject applications.",
  keywords: ["tenant applications", "rental applications", "application management", "tenant screening"],
  openGraph: {
    title: "Tenant Applications - Rental Applications | Reservatior",
    description: "Manage rental applications from prospective tenants.",
    type: "website",
  },
};

export default function TenantApplicationsPage() {
  return <TenantApplicationsContent />;
}
