import type { Metadata } from "next";
import { ChannelsContent } from "./ChannelsContent";

export const metadata: Metadata = {
  title: "Channels - Channel Management | Reservatior",
  description: "Manage distribution channels and integrations. Connect with booking platforms and marketplaces.",
  keywords: ["channels", "distribution channels", "booking platforms", "marketplace integrations"],
  openGraph: {
    title: "Channels - Channel Management | Reservatior",
    description: "Manage distribution channels and integrations.",
    type: "website",
  },
  robots: { index: false, follow: false },
};

export default function ChannelsPage() {
  return <ChannelsContent />;
}
