import type { Metadata } from "next";
import DeveloperDashboard from "@/pages-spa/developer_os/Dashboard";

export const metadata: Metadata = {
  title: "Developer API OS Dashboard | Reservatior",
  description: "API documentation, playground, and integration guides.",
};

export default function DeveloperDashboardPage() {
  return <DeveloperDashboard />;
}
