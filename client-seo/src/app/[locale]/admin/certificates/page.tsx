import type { Metadata } from "next";
import CertificatesPage from "./CertificatesPage";

export const metadata: Metadata = {
  title: "Income Certificates - Admin Panel | Reservatior",
  description: "Issue and manage income-ready property certificates",
  keywords: ["certificates", "income", "verification", "admin"],
  openGraph: {
    title: "Income Certificates - Admin Panel | Reservatior",
    description: "Issue and manage income-ready property certificates",
    type: "website",
  },
};

export default function CertificatesPageWrapper() {
  return <CertificatesPage />;
}
