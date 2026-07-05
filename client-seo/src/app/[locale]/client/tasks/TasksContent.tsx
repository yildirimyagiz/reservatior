"use client";

import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { CheckSquare, Calendar, LayoutGrid, ListTodo } from "lucide-react";
import Link from "next/link";
import { useTranslation } from "react-i18next";

export function TasksContent() {
    const { t } = useTranslation();
  const taskModules = [
    {
      title: "Task Management",
      description: "Manage tasks and assignments",
      icon: CheckSquare,
      href: "/client/tasks/management",
      color: "text-blue-500"
    },
    {
      title: "Kanban Board",
      description: "View tasks in kanban board layout",
      icon: LayoutGrid,
      href: "/client/tasks/kanban",
      color: "text-purple-500"
    },
    {
      title: "Appointments",
      description: "Manage appointments and meetings",
      icon: Calendar,
      href: "/client/tasks/appointments",
      color: "text-emerald-500"
    },
    {
      title: "Events",
      description: "Manage events and schedules",
      icon: Calendar,
      href: "/client/tasks/events",
      color: "text-orange-500"
    }
  ];

  return (
    <div className="container mx-auto p-6">
      <div className="mb-8">
        <h1 className="text-3xl font-bold">{t("tasks.taskscontent.auto_ext_1")}</h1>
        <p className="text-muted-foreground">{t("tasks.taskscontent.auto_ext_2")}</p>
      </div>
      
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        {taskModules.map((module) => (
          <Link key={module.href} href={module.href}>
            <Card className="hover:shadow-lg transition-shadow cursor-pointer h-full">
              <CardHeader>
                <div className={`w-12 h-12 rounded-lg bg-muted flex items-center justify-center mb-4 ${module.color}`}>
                  <module.icon className="w-6 h-6" />
                </div>
                <CardTitle className="text-lg">{module.title}</CardTitle>
              </CardHeader>
              <CardContent>
                <p className="text-sm text-muted-foreground">{module.description}</p>
              </CardContent>
            </Card>
          </Link>
        ))}
      </div>
    </div>
  );
}
