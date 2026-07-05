"use client";

import { useEffect } from "react";
import { useRouter } from "next/navigation";
import { Loader2 } from "lucide-react";
import { useTranslation } from "react-i18next";

export function PayoutsContent() {
    const { t } = useTranslation();
  const router = useRouter();

  useEffect(() => {
    const timer = setTimeout(() => {
      router.push("/client/financial");
    }, 2500);
    return () => clearTimeout(timer);
  }, [router]);

  return (
    <div className="flex items-center justify-center min-h-[60vh]">
      <div className="text-center space-y-4">
        <Loader2 className="w-12 h-12 animate-spin mx-auto text-primary" />
        <h2 className="text-2xl font-semibold">{t("payouts.payoutscontent.auto_ext_1")}</h2>
        <p className="text-muted-foreground max-w-md">
          {t("payouts.payoutscontent.auto_ext_2")}
                          </p>
      </div>
    </div>
  );
}
