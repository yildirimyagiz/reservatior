import type { Metadata } from "next";
import { TasksContent } from "./TasksContent";


export const metadata: Metadata = {
  title: "Tasks - Task Management | Reservatior",
  description: "Manage tasks and to-dos for your property business. Track assignments, deadlines, and progress.",
  keywords: ["tasks", "task management", "to-dos", "assignments"],
  openGraph: {
    title: "Tasks - Task Management | Reservatior",
    description: "Manage tasks and to-dos for your property business.",
    type: "website",
  },
  robots: { index: false, follow: false },
};

export default function TasksPage() {
  return <TasksContent />;
}
