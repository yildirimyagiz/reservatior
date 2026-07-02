import type { Metadata } from "next";
import { CommunicationLogsContent } from "@/app/[locale]/client/communications/logs/CommunicationLogsContent";

export const metadata: Metadata = {
  title: "Communication Logs - Message History | Reservatior",
  description: "View and manage your communication logs and message history. Track all sent and received messages across channels.",
  keywords: ["communication logs", "message history", "chat logs", "communication tracking"],
  openGraph: {
    title: "Communication Logs - Message History | Reservatior",
    description: "View and manage your communication logs and message history.",
    type: "website",
  },
};

export default function CommunicationLogsPage() {
  return <CommunicationLogsContent />;
}
