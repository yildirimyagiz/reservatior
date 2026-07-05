import type { Metadata } from "next";
import AdminChannelsPage from "./AdminChannelsPage";

export const metadata: Metadata = {
  title: "Channel Manager - Admin Panel | Reservatior",
  description: "Manage distribution channels from the admin panel.",
  keywords: ["channels","distribution","admin panel"],
  openGraph: {
    title: "Channel Manager - Admin Panel | Reservatior",
    description: "Manage distribution channels from the admin panel.",
    type: "website",
  },
};

export default function AdminChannelsPageWrapper() {
  return <AdminChannelsPage />;
}
