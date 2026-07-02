import type { Metadata } from "next";
import { ExtraChargesContent } from "./ExtraChargesContent";

export const metadata: Metadata = {
  title: "Extra Charges - Additional Fees | Reservatior",
  description: "Manage extra charges and additional fees for properties and services.",
  keywords: ["extra charges", "additional fees", "service fees", "property fees"],
  openGraph: {
    title: "Extra Charges - Additional Fees | Reservatior",
    description: "Manage extra charges and additional fees.",
    type: "website",
  },
};

export default function ExtraChargesPage() {
  return <ExtraChargesContent />;
}
