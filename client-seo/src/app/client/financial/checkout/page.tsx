import type { Metadata } from "next";
import { CheckoutContent } from "@/app/[locale]/client/financial/checkout/CheckoutContent";

export const metadata: Metadata = {
  title: "Checkout - Payment Checkout | Reservatior",
  description: "Complete your payment checkout securely. Process payments for bookings, services, and subscriptions.",
  keywords: ["checkout", "payment", "secure payment", "booking payment"],
  openGraph: {
    title: "Checkout - Payment Checkout | Reservatior",
    description: "Complete your payment checkout securely.",
    type: "website",
  },
};

export default function CheckoutPage() {
  return <CheckoutContent />;
}
