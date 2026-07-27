import type { Metadata } from "next";
import Dashboard from "./Dashboard";

export const metadata: Metadata = {
  title: "Decision Engine - Intelligence & AI | Reservatior",
  description: "Live AI decision monitoring console with decision history, outcome tracking, and confidence analytics.",
  keywords: ["decision", "engine", "AI", "monitoring", "analytics"],
  openGraph: {
    title: "Decision Engine - Intelligence & AI | Reservatior",
    description: "Live AI decision monitoring console.",
    type: "website",
  },
};

export default function DecisionEnginePage() {
  return <Dashboard />;
}
