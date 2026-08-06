"use client";
import { AppHeader } from "@/components/layout/AppHeader";
import { Footer } from "@/components/layout/Footer";
import FeatureComingSoon from "@/components/shared/FeatureComingSoon";
import { useTranslation } from "react-i18next";

export default function propertyPage() {
  const { t } = useTranslation();
  return (
    <div className="flex flex-col min-h-screen bg-background text-foreground selection:bg-primary/30">
      <AppHeader />
      <main className="flex-1 w-full pt-32 pb-20">
        <FeatureComingSoon 
          title={t("property_page.title")} 
          description={t("property_page.desc")} 
        />
      </main>
      <Footer />
    </div>
  );
}
