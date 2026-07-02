import type { Metadata } from "next";
import { TasksKanbanContent } from "@/app/[locale]/client/tasks/kanban/TasksKanbanContent";

export const metadata: Metadata = {
  title: "Kanban Board - Task Board | Reservatior",
  description: "View and manage tasks in kanban board layout. Drag and drop tasks between columns.",
  keywords: ["kanban", "task board", "drag and drop", "visual tasks"],
  openGraph: {
    title: "Kanban Board - Task Board | Reservatior",
    description: "View and manage tasks in kanban board layout.",
    type: "website",
  },
};

export default function TasksKanbanPage() {
  return <TasksKanbanContent />;
}
