import type { Metadata } from "next";
import { TaskManagementContent } from "./TaskManagementContent";

export const metadata: Metadata = {
  title: "Task Management - Manage Tasks | Reservatior",
  description: "Manage tasks and assignments. Create, assign, and track tasks across your team.",
  keywords: ["task management", "assignments", "task tracking", "team tasks"],
  openGraph: {
    title: "Task Management - Manage Tasks | Reservatior",
    description: "Manage tasks and assignments.",
    type: "website",
  },
};

export default function TaskManagementPage() {
  return <TaskManagementContent />;
}
