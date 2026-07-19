import type { Metadata } from "next";
import REOPage from "./REOPage";

export const metadata: Metadata = {
  title: "REO Portfolio - Admin Panel | Reservatior",
  description: "Manage real estate owned portfolio, property metrics, and occupancy",
  keywords: ["reo","real estate owned","portfolio","property management","admin"],
  openGraph: {
    title: "REO Portfolio - Admin Panel | Reservatior",
    description: "Manage real estate owned portfolio, property metrics, and occupancy",
    type: "website",
  },
};

export default function REOPageWrapper() {
  return <REOPage />;
}
