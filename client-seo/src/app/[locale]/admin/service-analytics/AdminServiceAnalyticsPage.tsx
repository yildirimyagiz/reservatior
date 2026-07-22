"use client";

import dynamic from "next/dynamic";

const AIServiceAnalytics = dynamic(() => import("@/pages-spa/admin/analytics/AIServiceAnalytics"), {
  loading: () => <div className="flex items-center justify-center h-64"><div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary" /></div>,
  ssr: false,
});

export default function AdminServiceAnalyticsPage() {
  return <AIServiceAnalytics />;
}
