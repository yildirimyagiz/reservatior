import type { Metadata } from "next";
import { TaxOverviewContent } from "@/app/[locale]/client/financial/tax-overview/TaxOverviewContent";

export const metadata: Metadata = {
  title: "Tax Overview - Tax Summary | Reservatior",
  description: "View tax overview and summary for your organization. Track tax obligations and compliance status.",
  keywords: ["tax overview", "tax summary", "tax compliance", "tax obligations"],
  openGraph: {
    title: "Tax Overview - Tax Summary | Reservatior",
    description: "View tax overview and summary for your organization.",
    type: "website",
  },
};

export default function TaxOverviewPage() {
  return <TaxOverviewContent />;
}
