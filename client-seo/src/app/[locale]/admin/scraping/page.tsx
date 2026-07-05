import type { Metadata } from "next";
import AdminScrapingPage from "./AdminScrapingPage";

export const metadata: Metadata = {
  title: "Scraping Dashboard - Admin Panel | Reservatior",
  description: "Monitor and manage data scraping operations from the admin panel.",
  keywords: ["scraping","data","admin panel"],
  openGraph: {
    title: "Scraping Dashboard - Admin Panel | Reservatior",
    description: "Monitor and manage data scraping operations from the admin panel.",
    type: "website",
  },
};

export default function AdminScrapingPageWrapper() {
  return <AdminScrapingPage />;
}
