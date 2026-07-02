import type { Metadata } from "next";
import { CommunicationsContent } from "@/app/[locale]/client/communications/CommunicationsContent";

export const metadata: Metadata = {
  title: "Communications - Messaging & Channels | Reservatior",
  description: "Manage your communications, messages, and channels. Stay connected with clients, agents, and team members through our unified messaging platform.",
  keywords: ["communications", "messaging", "chat", "channels", "client communication"],
  openGraph: {
    title: "Communications - Messaging & Channels | Reservatior",
    description: "Manage your communications, messages, and channels.",
    type: "website",
  },
  robots: { index: false, follow: false },
};

export default function CommunicationsPage() {
  return <CommunicationsContent />;
}
