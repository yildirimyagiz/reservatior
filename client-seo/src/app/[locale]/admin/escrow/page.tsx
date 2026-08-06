"use client";

import dynamic from "next/dynamic";
import { Loader2 } from "lucide-react";

const EscrowManagement = dynamic(() => import("@/pages-spa/admin/financial/EscrowManagement"), {
  loading: () => (
    <div className="flex items-center justify-center min-h-[400px] text-muted-foreground">
      <Loader2 className="w-8 h-8 animate-spin text-brand mr-2" />
      <span>Escrow Güvenli Havuz Yönetimi Yükleniyor...</span>
    </div>
  ),
  ssr: false
});

export default function Page() {
  return <EscrowManagement />;
}
