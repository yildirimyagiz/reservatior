"use client";

import dynamic from "next/dynamic";
import React from "react";
import { Loader2 } from "lucide-react";

const Component = dynamic(() => import("@/pages-spa/admin/intelligence/AgentPassport"), {
  loading: () => (
    <div className="flex items-center justify-center min-h-[400px] text-muted-foreground">
      <Loader2 className="w-8 h-8 animate-spin text-brand mr-2" />
      <span>Modül yükleniyor...</span>
    </div>
  ),
  ssr: false
});

export default function AgentPassportAppPage() {
  return <Component />;
}
