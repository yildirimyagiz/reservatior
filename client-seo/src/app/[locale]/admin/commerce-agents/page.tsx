import type { Metadata } from "next";
import CommerceAgentsPage from "./CommerceAgentsPage";

export const metadata: Metadata = {
  title: "Commerce Agents - Admin Panel | Reservatior",
  description: "Manage commerce agents, commissions, and performance",
  keywords: ["agents", "commerce", "commissions", "admin"],
  openGraph: {
    title: "Commerce Agents - Admin Panel | Reservatior",
    description: "Manage commerce agents, commissions, and performance",
    type: "website",
  },
};

export default function CommerceAgentsPageWrapper() {
  return <CommerceAgentsPage />;
}
