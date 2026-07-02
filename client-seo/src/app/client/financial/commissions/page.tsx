import type { Metadata } from "next";
import { CommissionsContent } from "@/app/[locale]/client/financial/commissions/CommissionsContent";

export const metadata: Metadata = {
  title: "Commissions - Agent Commissions | Reservatior",
  description: "Manage agent commissions and payouts. Track commission rules, calculate earnings, and process payments.",
  keywords: ["commissions", "agent earnings", "payouts", "commission tracking"],
  openGraph: {
    title: "Commissions - Agent Commissions | Reservatior",
    description: "Manage agent commissions and payouts.",
    type: "website",
  },
};

export default function CommissionsPage() {
  return <CommissionsContent />;
}
