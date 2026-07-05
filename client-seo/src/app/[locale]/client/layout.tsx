"use client";

import { AppLayout } from "@/pages-spa/client/layout/AppLayout";

export default function ClientRouteLayout({ children }: { children: React.ReactNode }) {
  return (
    <AppLayout>
      {children}
    </AppLayout>
  );
}
