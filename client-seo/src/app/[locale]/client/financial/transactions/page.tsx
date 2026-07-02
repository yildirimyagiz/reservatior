import type { Metadata } from "next";
import { TransactionsContent } from "./TransactionsContent";


export const metadata: Metadata = {
  title: "Transactions - Financial Transactions | Reservatior",
  description: "View and manage all financial transactions. Track payments, receipts, and money transfers.",
  keywords: ["transactions", "financial records", "payment history", "money transfers"],
  openGraph: {
    title: "Transactions - Financial Transactions | Reservatior",
    description: "View and manage all financial transactions.",
    type: "website",
  },
};

export default function TransactionsPage() {
  return <TransactionsContent />;
}
