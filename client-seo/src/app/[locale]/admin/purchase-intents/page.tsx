import type { Metadata } from "next";
import PurchaseIntentsPage from "./PurchaseIntentsPage";

export const metadata: Metadata = {
  title: "Purchase Intents (RTO) - Admin Panel | Reservatior",
  description: "Manage rent-to-own purchase intents and tenant readiness tracking",
  keywords: ["purchase intent","rent to own","rto","readiness","admin"],
  openGraph: {
    title: "Purchase Intents (RTO) - Admin Panel | Reservatior",
    description: "Manage rent-to-own purchase intents and tenant readiness tracking",
    type: "website",
  },
};

export default function PurchaseIntentsPageWrapper() {
  return <PurchaseIntentsPage />;
}
