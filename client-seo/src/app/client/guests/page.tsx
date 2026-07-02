import type { Metadata } from "next";
import { GuestsContent } from "@/app/[locale]/client/guests/GuestsContent";

export const metadata: Metadata = {
  title: "Guests - Guest Management | Reservatior",
  description: "Manage guests and guest relationships. Track guest history and preferences.",
  keywords: ["guests", "guest management", "guest history", "guest preferences"],
  openGraph: {
    title: "Guests - Guest Management | Reservatior",
    description: "Manage guests and guest relationships.",
    type: "website",
  },
  robots: { index: false, follow: false },
};

export default function GuestsPage() {
  return <GuestsContent />;
}
