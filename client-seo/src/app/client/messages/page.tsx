import type { Metadata } from "next";
import MessagesPage from "@/app/[locale]/client/messages/MessagesPage";

export const metadata: Metadata = {
  title: "Messages - Communication Hub | Reservatior",
  description: "Manage your real estate communications, tenant messages, and client conversations.",
  keywords: ["messages","communication","tenant messages","real estate chat"],
  openGraph: {
    title: "Messages - Communication Hub | Reservatior",
    description: "Manage your real estate communications, tenant messages, and client conversations.",
    type: "website",
  },
  robots: { index: false, follow: false },
};

export default function MessagesPageWrapper() {
  return <MessagesPage />;
}
