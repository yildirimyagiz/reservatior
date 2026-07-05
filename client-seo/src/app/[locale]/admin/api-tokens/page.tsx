import type { Metadata } from "next";
import AdminApiTokensPage from "./AdminApiTokensPage";

export const metadata: Metadata = {
  title: "API Tokens - Admin Panel | Reservatior",
  description: "Manage API tokens, authentication keys, and access credentials.",
  keywords: ["API tokens","admin panel","authentication","access keys"],
  openGraph: {
    title: "API Tokens - Admin Panel | Reservatior",
    description: "Manage API tokens, authentication keys, and access credentials.",
    type: "website",
  },
};

export default function AdminApiTokensPageWrapper() {
  return <AdminApiTokensPage />;
}
