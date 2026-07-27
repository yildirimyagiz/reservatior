import type { Metadata } from "next";
import Dashboard from "./Dashboard";


export const metadata: Metadata = {
  title: "Geospatial Heatmaps - Admin Panel | Reservatior",
  description: "Geospatial heatmaps and location intelligence dashboard for the admin panel.",
  keywords: ["geospatial", "heatmaps", "location", "maps", "google maps"],
  openGraph: {
    title: "Geospatial Heatmaps - Admin Panel | Reservatior",
    description: "Geospatial heatmaps and location intelligence dashboard for the admin panel.",
    type: "website",
  },
};

export default function GeospatialPage() {
  return <Dashboard />;
}
