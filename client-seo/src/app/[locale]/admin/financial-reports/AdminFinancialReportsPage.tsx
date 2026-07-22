"use client";

import dynamic from "next/dynamic";

const FinancialReports = dynamic(() => import("@/pages-spa/admin/financial/FinancialReports"), {
  loading: () => <div className="flex items-center justify-center h-64"><div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary" /></div>,
  ssr: false,
});

export default function AdminFinancialReportsPage() {
  return <FinancialReports />;
}
