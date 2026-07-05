"use client";

import { AdminLayout } from "@/pages-spa/admin/layout/AdminLayout";

export default function AppAdminLayout({ children }: { children: React.ReactNode }) {
  return (
    <AdminLayout>
      {children}
    </AdminLayout>
  );
}
