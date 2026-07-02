import type { Metadata } from "next";
import { ScheduledReportsContent } from "./ScheduledReportsContent";

export const metadata: Metadata = {
  title: "Scheduled Reports - Automated Reports | Reservatior",
  description: "Manage scheduled and automated reports. Set up recurring report generation and delivery.",
  keywords: ["scheduled reports", "automated reports", "recurring reports", "report automation"],
  openGraph: {
    title: "Scheduled Reports - Automated Reports | Reservatior",
    description: "Manage scheduled and automated reports.",
    type: "website",
  },
};

export default function ScheduledReportsPage() {
  return <ScheduledReportsContent />;
}
