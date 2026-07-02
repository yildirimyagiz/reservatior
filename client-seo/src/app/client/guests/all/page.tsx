import type { Metadata } from "next";
import { AllGuestsContent } from "@/app/[locale]/client/guests/all/AllGuestsContent";

export const metadata: Metadata = {
  title: "All Guests - Guest List | Reservatior",
  description: "View and manage all guests. Search, filter, and update guest information.",
  keywords: ["guests", "guest list", "guest directory", "guest management"],
  openGraph: {
    title: "All Guests - Guest List | Reservatior",
    description: "View and manage all guests.",
    type: "website",
  },
};

export default function AllGuestsPage() {
  return <AllGuestsContent />;
}
