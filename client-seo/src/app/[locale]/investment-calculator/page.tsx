import type { Metadata } from "next";
import Dashboard from "./Dashboard";

export const metadata: Metadata = {
  title: "Investment Calculator | Reservatior",
  description: "AI-powered investment calculator with ROI projections, risk analysis, and portfolio optimization.",
  keywords: ["investment", "calculator", "ROI", "risk", "portfolio", "real estate"],
};

export default function InvestmentCalculatorPage() {
  return <Dashboard />;
}
