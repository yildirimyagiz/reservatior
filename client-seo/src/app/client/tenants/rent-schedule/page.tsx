import type { Metadata } from "next";
import { RentScheduleContent } from "@/app/[locale]/client/tenants/rent-schedule/RentScheduleContent";

export const metadata: Metadata = {
  title: "Rent Schedule - Payment Schedule | Reservatior",
  description: "View rent payment schedules for all tenants. Track upcoming and past due payments.",
  keywords: ["rent schedule", "payment schedule", "rent tracking", "payment calendar"],
  openGraph: {
    title: "Rent Schedule - Payment Schedule | Reservatior",
    description: "View rent payment schedules for all tenants.",
    type: "website",
  },
};

export default function RentSchedulePage() {
  return <RentScheduleContent />;
}
