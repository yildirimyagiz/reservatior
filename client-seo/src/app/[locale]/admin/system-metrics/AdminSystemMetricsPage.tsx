"use client";

import dynamic from "next/dynamic";

const SystemMetrics = dynamic(() => import("@/pages-spa/admin/system/SystemMetrics"), {
  loading: () => <div className="flex items-center justify-center h-64"><div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary" /></div>,
  ssr: false,
});

export default function AdminSystemMetricsPage() {
  return <SystemMetrics />;
}
