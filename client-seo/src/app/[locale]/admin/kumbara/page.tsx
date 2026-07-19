import type { Metadata } from "next";
import KumbaraPage from "./KumbaraPage";

export const metadata: Metadata = {
  title: "Kumbara Deposits - Admin Panel | Reservatior",
  description: "Manage tenant deposit savings accounts and contribution tracking",
  keywords: ["kumbara","deposits","savings","admin"],
  openGraph: {
    title: "Kumbara Deposits - Admin Panel | Reservatior",
    description: "Manage tenant deposit savings accounts and contribution tracking",
    type: "website",
  },
};

export default function KumbaraPageWrapper() {
  return <KumbaraPage />;
}
