import type { Metadata } from "next";
import AdminExportsPage from "./AdminExportsPage";

export const metadata: Metadata = {
  title: "Exports - Admin Panel | Reservatior",
  description: "Configure and run data exports from the admin panel.",
  keywords: ["exports","data","admin panel"],
  openGraph: {
    title: "Exports - Admin Panel | Reservatior",
    description: "Configure and run data exports from the admin panel.",
    type: "website",
  },
};

export default function AdminExportsPageWrapper() {
  return <AdminExportsPage />;
}
