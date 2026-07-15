"use client";

import { AdminLayout } from "@/pages-spa/admin/layout/AdminLayout";
import AssetLifecycle from "@/pages-spa/admin/inventory/AssetLifecycle";

export default function AssetLifecycleAdminPage() {
  return (
    <AdminLayout>
      <AssetLifecycle />
    </AdminLayout>
  );
}
