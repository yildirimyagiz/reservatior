import type { Metadata } from "next";
import AdminAgentVideosPage from "./AdminAgentVideosPage";

export const metadata: Metadata = {
  title: "Agent Videos - Admin Panel | Reservatior",
  description: "Manage agent video content and recordings from the admin panel.",
  keywords: ["videos", "agents", "recordings", "admin panel"],
  openGraph: {
    title: "Agent Videos - Admin Panel | Reservatior",
    description: "Manage agent video content and recordings from the admin panel.",
    type: "website",
  },
};

export default function AdminAgentVideosPageWrapper() {
  return <AdminAgentVideosPage />;
}
