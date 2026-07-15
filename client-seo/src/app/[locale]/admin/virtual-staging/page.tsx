"use client";

import { AdminLayout } from "@/pages-spa/admin/layout/AdminLayout";
import VirtualStaging from "@/pages-spa/admin/ai/VirtualStaging";

export default function VirtualStagingAdminPage() {
  return (
    <AdminLayout>
      <VirtualStaging />
    </AdminLayout>
  );
}
