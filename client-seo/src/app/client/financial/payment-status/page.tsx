import type { Metadata } from "next";
import { PaymentStatusContent } from "@/app/[locale]/client/financial/payment-status/PaymentStatusContent";

export const metadata: Metadata = {
  title: "Payment Status - Track Payments | Reservatior",
  description: "Track payment status and payment history. Monitor pending, completed, and failed payments.",
  keywords: ["payment status", "payment tracking", "payment history"],
  openGraph: {
    title: "Payment Status - Track Payments | Reservatior",
    description: "Track payment status and payment history.",
    type: "website",
  },
};

export default function PaymentStatusPage() {
  return <PaymentStatusContent />;
}
