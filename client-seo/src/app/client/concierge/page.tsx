import type { Metadata } from "next";
import { ConciergeContent } from "@/app/[locale]/client/concierge/ConciergeContent";

export const metadata: Metadata = {
  title: "Concierge & VIP Services | Reservatior",
  description: "Book luxury cars, private chefs, airport transfers, and exclusive VIP services for your stay.",
  robots: { index: false, follow: false },
};

export default function ConciergePage() {
  return <ConciergeContent />;
}
