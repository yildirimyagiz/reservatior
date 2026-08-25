"use client";

import { ReactNode } from "react";
import { AppHeader } from "@/components/layout/AppHeader";
import { Footer } from "@/components/layout/Footer";
import { MapProviderWrapper } from "@/components/map/MapProvider";

export function AppLayout({ children }: { children: ReactNode }) {
  return (
    <MapProviderWrapper>
      <div className="flex min-h-screen flex-col overflow-x-hidden bg-background text-foreground">
        <AppHeader />
        <main className="flex flex-1 flex-col bg-background">
          <div className="pt-36 md:pt-44 flex-1 flex flex-col">{children}</div>
        </main>
        <Footer />
      </div>
    </MapProviderWrapper>
  );
}
