import type { Metadata } from "next";
import { RentIncreasesContent } from "@/app/[locale]/client/tenants/rent-increases/RentIncreasesContent";

export const metadata: Metadata = {
  title: "Rent Increases - Rent Adjustments | Reservatior",
  description: "Manage rent increase notifications and adjustments. Track rent change history.",
  keywords: ["rent increases", "rent adjustments", "rent changes", "rent notifications"],
  openGraph: {
    title: "Rent Increases - Rent Adjustments | Reservatior",
    description: "Manage rent increase notifications and adjustments.",
    type: "website",
  },
};

export default function RentIncreasesPage() {
  return <RentIncreasesContent />;
}
