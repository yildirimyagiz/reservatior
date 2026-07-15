"use client";

import { PageShell } from "@/pages-spa/client/layout/PageShell";
import { Button } from "@/components/ui/button";
import { Building2, Users } from "lucide-react";
import { useTranslation } from "react-i18next";

export default function AdminVideoPartnershipsPage() {
    const { t } = useTranslation();
  return (
    <PageShell 
      title={t("client.src.video_vendor_partnerships", "Video Vendor Partnerships")} 
      description={t("admin_auto_manage_partnerships_with_video_productio", "Manage partnerships with video production vendors")}
    >
      <div className="flex flex-col items-center justify-center py-20 text-center">
        <div className="w-16 h-16 rounded-full bg-primary/10 flex items-center justify-center mb-4">
          <Users className="w-8 h-8 text-primary" />
        </div>
        <h2 className="text-xl font-semibold mb-2">{t("admin_common_coming_soon", "Coming Soon")}</h2>
        <p className="text-muted-foreground max-w-md mb-6">
          {t("admin_auto_video_vendor_partnerships_management_wil", "Video vendor partnerships management will be available in a future update.")}</p>
        <Button variant="outline">
          <Building2 className="w-4 h-4 mr-2" />
          {t("client.src.contact_support", "Contact Support")}</Button>
      </div>
    </PageShell>
  );
}
