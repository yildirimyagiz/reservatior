import type { Metadata } from "next";
import LocalizationDashboard from "@/pages-spa/localization_os/Dashboard";

export const metadata: Metadata = {
  title: "Localization OS Dashboard | Reservatior",
  description: "Country, language, regulation, and currency management.",
};

export default function LocalizationDashboardPage() {
  return <LocalizationDashboard />;
}
