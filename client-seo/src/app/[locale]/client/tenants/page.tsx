import type { Metadata } from "next";
import { TenantsContent } from "./TenantsContent";

export const metadata: Metadata = {
  title: "Tenants - Tenant Management | Reservatior",
  description: "Manage tenants and rental applications. Track tenant information, rent payments, and lease agreements.",
  keywords: ["tenants", "tenant management", "rental applications", "lease management"],
  openGraph: {
    title: "Tenants - Tenant Management | Reservatior",
    description: "Manage tenants and rental applications.",
    type: "website",
  },
  robots: { index: false, follow: false },
};

export default function TenantsPage() {
  return <TenantsContent />;
}
