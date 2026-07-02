import type { Metadata } from "next";
import { EscrowContent } from "@/app/[locale]/client/financial/escrow/EscrowContent";


export const metadata: Metadata = {
  title: "Escrow - Escrow Management | Reservatior",
  description: "Manage escrow accounts and funds for property transactions. Secure payment handling for real estate deals.",
  keywords: ["escrow", "secure payments", "property transactions", "escrow accounts"],
  openGraph: {
    title: "Escrow - Escrow Management | Reservatior",
    description: "Manage escrow accounts and funds for property transactions.",
    type: "website",
  },
};

export default function EscrowPage() {
  return <EscrowContent />;
}
