import type { Metadata } from "next";
import AdminMarketingPage from "./AdminMarketingPage";

export const metadata: Metadata = {
  title: "Marketing Automation - Admin Panel | Reservatior",
  description: "Automate marketing campaigns and workflows from the admin panel.",
  keywords: ["marketing","automation","admin panel"],
  openGraph: {
    title: "Marketing Automation - Admin Panel | Reservatior",
    description: "Automate marketing campaigns and workflows from the admin panel.",
    type: "website",
  },
};

export default function AdminMarketingPageWrapper() {
  return <AdminMarketingPage />;
}
