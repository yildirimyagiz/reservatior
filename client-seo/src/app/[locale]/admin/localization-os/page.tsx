"use client";

import React from "react";
import { PageShell } from "@/pages-spa/admin/layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Layers } from "lucide-react";
import { useTranslation } from "react-i18next";

export default function LocalizationOsAdminPage() {
  const { t } = useTranslation();
  
  return (
    <PageShell title={t("admin_localization_os_title", "LocalizationOs Management")}>
      <div className="space-y-6">
        <Card className="bg-card border-border">
          <CardHeader>
            <CardTitle className="text-card-foreground flex items-center gap-2">
              <Layers className="w-5 h-5 text-brand" />
              {t("admin_localization_os_title", "LocalizationOs Management")}
            </CardTitle>
          </CardHeader>
          <CardContent className="text-muted-foreground text-sm space-y-2">
            <p>{t("admin_localization_os_description", "Manage localizationos settings, configurations, and records.")}</p>
          </CardContent>
        </Card>
      </div>
    </PageShell>
  );
}
