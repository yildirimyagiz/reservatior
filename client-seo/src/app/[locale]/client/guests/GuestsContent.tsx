"use client";

import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Users, MessageSquare } from "lucide-react";
import Link from "next/link";

export function GuestsContent() {
  const guestModules = [
    {
      title: "All Guests",
      description: "View and manage all guests",
      icon: Users,
      href: "/client/guests/all",
      color: "text-blue-500"
    },
    {
      title: "Guest Follow-up",
      description: "Manage guest follow-ups and communications",
      icon: MessageSquare,
      href: "/client/guests/follow-up",
      color: "text-purple-500"
    }
  ];

  return (
    <div className="container mx-auto p-6">
      <div className="mb-8">
        <h1 className="text-3xl font-bold">Guests</h1>
        <p className="text-muted-foreground">Manage guests and guest relationships</p>
      </div>
      
      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        {guestModules.map((module) => (
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
