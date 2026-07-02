import type { Metadata } from "next";
import { LeadsContent } from "./LeadsContent";

export const metadata: Metadata = {
  title: "Leads - Lead Management | Reservatior",
  description: "Manage leads and prospects. Track lead sources and conversion rates.",
  keywords: ["leads", "lead management", "prospects", "lead tracking"],
  openGraph: {
    title: "Leads - Lead Management | Reservatior",
    description: "Manage leads and prospects.",
    type: "website",
  },
};

export default function LeadsPage() {
  return <LeadsContent />;
}
