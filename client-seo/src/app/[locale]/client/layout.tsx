"use client";

import { AppLayout } from "@/pages-spa/client/layout/AppLayout";
import { usePathname } from "next/navigation";

export default function ClientRouteLayout({ children }: { children: React.ReactNode }) {
  const pathname = usePathname();
  const isAuthPage = pathname.includes("/login") || pathname.includes("/signup") || pathname.includes("/auth");

  if (isAuthPage) {
    return <div className="flex flex-col min-h-screen bg-background overflow-x-hidden">{children}</div>;
  }

  return <AppLayout>{children}</AppLayout>;
}
