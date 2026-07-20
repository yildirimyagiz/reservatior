import type { Metadata } from "next";
import NotificationDashboard from "@/pages-spa/notification_os/Dashboard";

export const metadata: Metadata = {
  title: "Notification OS Dashboard | Reservatior",
  description: "Push and email settings, template management, and delivery logs.",
};

export default function NotificationDashboardPage() {
  return <NotificationDashboard />;
}
