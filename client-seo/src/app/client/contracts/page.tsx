import type { Metadata } from "next";
import { ContractsContent } from "@/app/[locale]/client/contracts/ContractsContent";

export const metadata: Metadata = {
  title: "Contracts - Contract Management | Reservatior",
  description: "Manage contracts and agreements. Create, sign, and track legal contracts.",
  keywords: ["contracts", "agreements", "legal contracts", "contract management"],
  openGraph: {
    title: "Contracts - Contract Management | Reservatior",
    description: "Manage contracts and agreements.",
    type: "website",
  },
  robots: { index: false, follow: false },
};

export default function ContractsPage() {
  return <ContractsContent />;
}
