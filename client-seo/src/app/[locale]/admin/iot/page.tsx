"use client";

import { AdminLayout } from "@/pages-spa/admin/layout/AdminLayout";
import IoTDashboard from "@/pages-spa/admin/facilities/IoTDashboard";

export default function IoTAdminPage() {
  return (
    <AdminLayout>
      <IoTDashboard />
    </AdminLayout>
  );
}
