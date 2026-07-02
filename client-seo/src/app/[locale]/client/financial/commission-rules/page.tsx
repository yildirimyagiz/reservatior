import type { Metadata } from "next";
import { CommissionRulesContent } from "./CommissionRulesContent";

export const metadata: Metadata = {
  title: "Commission Rules - Commission Configuration | Reservatior",
  description: "Configure commission rules and rates for agents and partners. Set up tiered commission structures.",
  keywords: ["commission rules", "commission rates", "agent commissions", "tiered commissions"],
  openGraph: {
    title: "Commission Rules - Commission Configuration | Reservatior",
    description: "Configure commission rules and rates for agents.",
    type: "website",
  },
};

export default function CommissionRulesPage() {
  return <CommissionRulesContent />;
}
