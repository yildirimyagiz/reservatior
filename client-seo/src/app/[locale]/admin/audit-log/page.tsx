import type { Metadata } from "next";
import AuditLogPage from "./AuditLogPage";

export const metadata: Metadata = {
  title: "Financial Audit Log - Admin Panel | Reservatior",
  description: "Review financial audit trail, transaction history, and integrity checks",
  keywords: ["audit log","financial audit","transaction history","integrity","admin"],
  openGraph: {
    title: "Financial Audit Log - Admin Panel | Reservatior",
    description: "Review financial audit trail, transaction history, and integrity checks",
    type: "website",
  },
};

export default function AuditLogPageWrapper() {
  return <AuditLogPage />;
}
