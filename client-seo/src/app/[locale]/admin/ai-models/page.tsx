import type { Metadata } from "next";
import AdminAIModelsPage from "./AdminAIModelsPage";

export const metadata: Metadata = {
  title: "AI Models - Admin Panel | Reservatior",
  description: "Manage and monitor AI models from the admin panel.",
  keywords: ["ai","models","admin panel"],
  openGraph: {
    title: "AI Models - Admin Panel | Reservatior",
    description: "Manage and monitor AI models from the admin panel.",
    type: "website",
  },
};

export default function AdminAIModelsPageWrapper() {
  return <AdminAIModelsPage />;
}
