"use client";

import { ReactNode } from "react";
import { AppHeader } from "@/components/layout/AppHeader";
import { Footer } from "@/components/layout/Footer";

export function AppLayout({ children }: { children: ReactNode }) {
  return (
    <div className="flex min-h-screen flex-col overflow-x-hidden bg-background text-foreground">
      <AppHeader />
      <main className="flex flex-1 flex-col bg-background">{children}</main>
      <Footer />
    </div>
  );
}
