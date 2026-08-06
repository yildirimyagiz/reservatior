"use client";

import dynamic from "next/dynamic";
import React from "react";
import { Loader2 } from "lucide-react";

const Component = dynamic(() => import("@/pages-spa/admin/intelligence/GlobalHybridRentalOS"), {
  loading: () => (
    <div className="flex items-center justify-center min-h-[400px] text-muted-foreground">
      <Loader2 className="w-8 h-8 animate-spin text-brand mr-2" />
      <span>Global Hybrid Rental OS yükleniyor...</span>
    </div>
  ),
  ssr: false
});

export default function GlobalHybridRentalOSPage() {
  return <Component />;
}
