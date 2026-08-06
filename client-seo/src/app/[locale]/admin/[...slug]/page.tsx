"use client";

import dynamic from "next/dynamic";
import React from "react";
import { Loader2 } from "lucide-react";

const AdminAppPage = dynamic(() => import("@/app/[locale]/admin/AdminPage"), {
  loading: () => (
    <div className="flex items-center justify-center min-h-[400px] text-muted-foreground">
      <Loader2 className="w-8 h-8 animate-spin text-brand mr-2" />
      <span>Yönetim modülü yükleniyor...</span>
    </div>
  ),
  ssr: false
});

export default function CatchAllAdminPage({ params }: { params: { slug?: string[] } }) {
  return <AdminAppPage />;
}
