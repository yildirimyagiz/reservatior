import type { Metadata } from "next";
import { PayoutsContent } from "./PayoutsContent";

export const metadata: Metadata = {
  title: "Payouts - Financial Payouts | Reservatior",
  description: "Manage financial payouts to agents and partners. Track payout history and process payments.",
  keywords: ["payouts", "payments", "financial transfers", "agent payouts"],
  openGraph: {
    title: "Payouts - Financial Payouts | Reservatior",
    description: "Manage financial payouts to agents and partners.",
    type: "website",
  },
};

export default function PayoutsPage() {
  return <PayoutsContent />;
}
