import type { Metadata } from "next";
import Dashboard from "./Dashboard";

export const metadata: Metadata = {
  title: "Market Passport - Intelligence & AI | Reservatior",
  description: "Market intelligence passport with demand index, price trends, yield analysis, and heatmap.",
};

export default function MarketPassportPage() {
  return <Dashboard />;
}
