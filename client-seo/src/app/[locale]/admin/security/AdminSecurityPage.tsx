"use client";

import dynamic from "next/dynamic";

const SecurityOverview = dynamic(() => import("@/pages-spa/admin/security/SecurityOverview"), {
  loading: () => <div className="flex items-center justify-center h-64"><div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary" /></div>,
  ssr: false,
});

export default function AdminSecurityPage() {
  return <SecurityOverview />;
}
