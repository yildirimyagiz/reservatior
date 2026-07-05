import type { Metadata } from "next";
import AdminInvestorsPage from "./AdminInvestorsPage";

export const metadata: Metadata = {
  title: "Investors - Admin Panel | Reservatior",
  description: "Manage investor profiles, portfolios, and investment performance.",
  keywords: ["investors","admin panel","portfolio","investments"],
  openGraph: {
    title: "Investors - Admin Panel | Reservatior",
    description: "Manage investor profiles, portfolios, and investment performance.",
    type: "website",
  },
};

export default function AdminInvestorsPageWrapper() {
  return <AdminInvestorsPage />;
}
