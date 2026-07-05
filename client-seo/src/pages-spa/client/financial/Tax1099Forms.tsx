"use client";

import { useTranslation } from "react-i18next";
import FeatureComingSoon from "@/components/shared/FeatureComingSoon";
import { FileText } from "lucide-react";
export default function Tax1099Forms() {
  const {
    t
  } = useTranslation();
  return <FeatureComingSoon title={t("client.src.tax_1099_forms")} description={t("client.src.automated_irs_1099misc_and")} icon={FileText} />;
}