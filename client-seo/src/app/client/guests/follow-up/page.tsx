import type { Metadata } from "next";
import { GuestFollowUpContent } from "@/app/[locale]/client/guests/follow-up/GuestFollowUpContent";

export const metadata: Metadata = {
  title: "Guest Follow-up - Guest Communications | Reservatior",
  description: "Manage guest follow-ups and communications. Send messages and track responses.",
  keywords: ["guest follow-up", "guest communications", "messages", "guest engagement"],
  openGraph: {
    title: "Guest Follow-up - Guest Communications | Reservatior",
    description: "Manage guest follow-ups and communications.",
    type: "website",
  },
};

export default function GuestFollowUpPage() {
  return <GuestFollowUpContent />;
}
