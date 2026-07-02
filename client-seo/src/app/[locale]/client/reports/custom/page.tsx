import type { Metadata } from "next";
import { CustomReportsContent } from "./CustomReportsContent";

export const metadata: Metadata = {
  title: "Custom Reports - Report Builder | Reservatior",
  description: "Create and manage custom reports. Build personalized reports for your business needs.",
  keywords: ["custom reports", "report builder", "personalized reports", "report generation"],
  openGraph: {
    title: "Custom Reports - Report Builder | Reservatior",
    description: "Create and manage custom reports.",
    type: "website",
  },
};

export default function CustomReportsPage() {
  return <CustomReportsContent />;
}
