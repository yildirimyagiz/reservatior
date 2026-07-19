import type { Metadata } from "next";
import BankAccountsPage from "./BankAccountsPage";

export const metadata: Metadata = {
  title: "Bank Accounts - Admin Panel | Reservatior",
  description: "Manage platform bank accounts, IBAN details, and payout configuration",
  keywords: ["bank accounts","iban","payouts","finance","admin"],
  openGraph: {
    title: "Bank Accounts - Admin Panel | Reservatior",
    description: "Manage platform bank accounts, IBAN details, and payout configuration",
    type: "website",
  },
};

export default function BankAccountsPageWrapper() {
  return <BankAccountsPage />;
}
