import type { Metadata } from "next";
import CampaignsPage from "./CampaignsPage";

export const metadata: Metadata = {
  title: "Marketing Campaigns - Admin Panel | Reservatior",
  description: "Create and manage marketing campaigns and promotions",
  keywords: ["campaigns", "marketing", "promotions", "admin"],
  openGraph: {
    title: "Marketing Campaigns - Admin Panel | Reservatior",
    description: "Create and manage marketing campaigns and promotions",
    type: "website",
  },
};

export default function CampaignsPageWrapper() {
  return <CampaignsPage />;
}
