import type { Metadata } from "next";
import { AllTenantsContent } from "./AllTenantsContent";

export const metadata: Metadata = {
  title: "All Tenants - Tenant List | Reservatior",
  description: "View and manage all tenants. Search, filter, and update tenant information.",
  keywords: ["tenants", "tenant list", "tenant directory", "tenant management"],
  openGraph: {
    title: "All Tenants - Tenant List | Reservatior",
    description: "View and manage all tenants.",
    type: "website",
  },
};

export default function AllTenantsPage() {
  return <AllTenantsContent />;
}
