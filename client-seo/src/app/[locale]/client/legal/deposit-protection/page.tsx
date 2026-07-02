import type { Metadata } from "next";
import { DepositProtectionContent } from "./DepositProtectionContent";

export const metadata: Metadata = {
  title: "Deposit Protection - Security Deposits | Reservatior",
  description: "Manage security deposits and deposit protection schemes for rental properties.",
  keywords: ["deposit protection", "security deposits", "rental deposits", "deposit schemes"],
  openGraph: {
    title: "Deposit Protection - Security Deposits | Reservatior",
    description: "Manage security deposits and deposit protection schemes.",
    type: "website",
  },
};

export default function DepositProtectionPage() {
  return <DepositProtectionContent />;
}
