import type { Metadata } from "next";
import AdminAuditLogsPage from "./AdminAuditLogsPage";

export const metadata: Metadata = {
  title: "Audit Logs - Admin Panel | Reservatior",
  description: "View and analyze system audit logs, user activity, and security events.",
  keywords: ["audit logs","admin panel","activity logs","security events"],
  openGraph: {
    title: "Audit Logs - Admin Panel | Reservatior",
    description: "View and analyze system audit logs, user activity, and security events.",
    type: "website",
  },
};

export default function AdminAuditLogsPageWrapper() {
  return <AdminAuditLogsPage />;
}
