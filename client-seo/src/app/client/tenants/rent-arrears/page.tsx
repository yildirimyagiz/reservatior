import type { Metadata } from "next";
import { RentArrearsContent } from "@/app/[locale]/client/tenants/rent-arrears/RentArrearsContent";

export const metadata: Metadata = {
  title: "Rent Arrears - Overdue Payments | Reservatior",
  description: "Track overdue rent payments and arrears. Manage collections and payment reminders.",
  keywords: ["rent arrears", "overdue payments", "collections", "payment reminders"],
  openGraph: {
    title: "Rent Arrears - Overdue Payments | Reservatior",
    description: "Track overdue rent payments and arrears.",
    type: "website",
  },
};

export default function RentArrearsPage() {
  return <RentArrearsContent />;
}
