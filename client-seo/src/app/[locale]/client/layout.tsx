"use client";

import { AppLayout } from "@/pages-spa/client/layout/AppLayout";
import { AppHeader } from "@/components/layout/AppHeader";
import { Footer } from "@/components/layout/Footer";
import { usePathname } from "next/navigation";

export default function ClientRouteLayout({ children }: { children: React.ReactNode }) {
  const pathname = usePathname();
  const isAuthPage = pathname.includes("/login") || pathname.includes("/signup") || pathname.includes("/auth");

  if (isAuthPage) {
    return (
      <div className="flex flex-col min-h-screen bg-background overflow-x-hidden">
        <AppHeader />
        <main className="flex-1 overflow-hidden">
          {children}
        </main>
        <Footer />
      </div>
    );
  }

  return (
    <AppLayout>
      {children}
    </AppLayout>
  );
}
