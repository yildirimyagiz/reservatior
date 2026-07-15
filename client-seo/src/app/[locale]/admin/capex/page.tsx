"use client";

import { AdminLayout } from "@/pages-spa/admin/layout/AdminLayout";
import CapExAmortization from "@/pages-spa/admin/financial/CapExAmortization";

export default function CapExAdminPage() {
  return (
    <AdminLayout>
      <CapExAmortization />
    </AdminLayout>
  );
}
