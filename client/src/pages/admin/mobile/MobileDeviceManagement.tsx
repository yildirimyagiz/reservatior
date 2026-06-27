import { useTranslation } from "react-i18next";
import { Smartphone } from "lucide-react";

export default function MobileDeviceManagement() {
  const { t } = useTranslation();
  return (
    <div className="p-8 max-w-4xl mx-auto">
      <div className="flex items-center gap-3 mb-6">
        <Smartphone className="w-8 h-8 text-primary" />
        <h1 className="text-2xl font-bold">{t("mobileDeviceManagement", "Mobile Device Management")}</h1>
      </div>
      <p className="text-muted-foreground">{t("mobileDeviceManagementDesc", "Manage mobile devices across the platform.")}</p>
    </div>
  );
}
