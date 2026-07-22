"use client";

import dynamic from "next/dynamic";

const Reports = dynamic(() => import("@/pages-spa/admin/reports/Reports"), {
  loading: () => <div className="flex items-center justify-center h-64"><div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary" /></div>,
  ssr: false,
});

export default function AdminReportsPage() {
  return <Reports />;
}
