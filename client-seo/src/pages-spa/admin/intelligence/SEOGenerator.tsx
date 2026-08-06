"use client";

import React, { useState } from "react";
import { PageShell } from "@/pages-spa/admin/layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import { Search, Sparkles, Copy, Check, Code2, Globe2, FileCode, CheckCircle2 } from "lucide-react";
import { useTranslation } from "react-i18next";

export default function SEOGenerator() {
  const { t } = useTranslation();
  const [propertyId, setPropertyId] = useState("PROP-546038");
  const [copied, setCopied] = useState(false);

  const jsonLdCode = `{
  "@context": "https://schema.org",
  "@type": "SingleFamilyResidence",
  "name": "Cihangir Lüks Rezidans 2+1",
  "description": "7464 sayılı kanuna %100 uyumlu, yüksek kısa ve orta dönem konaklama getirili lüks daire.",
  "address": {
    "@type": "PostalAddress",
    "addressLocality": "Beyoğlu",
    "addressRegion": "İstanbul",
    "addressCountry": "TR"
  },
  "geo": {
    "@type": "GeoCoordinates",
    "latitude": 41.0322,
    "longitude": 28.9835
  },
  "aggregateRating": {
    "@type": "AggregateRating",
    "ratingValue": "4.92",
    "reviewCount": "128"
  }
}`;

  const handleCopy = () => {
    navigator.clipboard.writeText(jsonLdCode);
    setCopied(true);
    setTimeout(() => setCopied(false), 2000);
  };

  return (
    <PageShell title={t("admin_seo_generator_title", "Otomatik SEO Üretici")}>
      <div className="space-y-6 animate-in fade-in duration-500">
        <div className="flex flex-col md:flex-row md:items-center justify-between gap-4 bg-card border border-border p-6 rounded-2xl shadow-sm">
          <div>
            <h1 className="text-2xl font-extrabold text-card-foreground flex items-center gap-2">
              <Sparkles className="w-6 h-6 text-brand" />
              {t("admin_seo_generator_title", "Otomatik SEO Üretici")}
            </h1>
            <p className="text-muted-foreground text-sm mt-1">
              {t("admin_seo_generator_desc", "Yapılandırılmış veri (JSON-LD), yatırım skorları ve çok dilli SEO etiketleri üretici")}
            </p>
          </div>
          <div className="flex items-center gap-2">
            <Input
              placeholder="Mülk ID giriniz (Örn: PROP-546038)"
              value={propertyId}
              onChange={(e) => setPropertyId(e.target.value)}
              className="bg-background border-border text-xs w-64 rounded-xl"
            />
            <Button size="sm" className="bg-primary text-primary-foreground hover:bg-primary/90 text-white rounded-xl font-bold">
              {t("admin_seo_generator_generate", "Generate")}
            </Button>
          </div>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          {/* Generated Metadata */}
          <div className="bg-card border border-border p-5 rounded-2xl space-y-4">
            <h3 className="text-sm font-bold text-card-foreground border-b border-border pb-3 flex items-center gap-2">
              <Globe2 className="w-4 h-4 text-success" /> {t("admin_seo_generator_generated_meta_tags", "Generated Meta Tags")}
            </h3>

            <div className="space-y-3 text-xs">
              <div className="space-y-1">
                <span className="text-[10px] text-muted-foreground uppercase font-mono">{t("admin_seo_meta_title_label", "Meta Title (TR)")}</span>
                <div className="p-2.5 bg-muted/40 rounded-xl font-medium text-card-foreground border border-border">
                  Cihangir Lüks Rezidans 2+1 - Reservatior Hybrid Rental
                </div>
              </div>

              <div className="space-y-1">
                <span className="text-[10px] text-muted-foreground uppercase font-mono">{t("admin_seo_meta_description_label", "Meta Description")}</span>
                <div className="p-2.5 bg-muted/40 rounded-xl font-medium text-card-foreground border border-border leading-relaxed">
                  İstanbul Beyoğlu Cihangir'de %7.8 tahmini kira getirili, 7464 sayılı kanuna uyumlu lüks 2+1 daire. Kurumsal yönetim garantisi ile kiralayın.
                </div>
              </div>

              <div className="flex items-center justify-between pt-2">
                <span className="text-[11px] text-muted-foreground">{t("admin_seo_generator_investment_suitability_score", "Investment Suitability Score:")}</span>
                <Badge className="bg-blue-500/10 text-success border-blue-500/30">
                  94 / 100 {t("admin_seo_generator_a_plus_rating", "A+ Rating")}
                </Badge>
              </div>
            </div>
          </div>

          {/* JSON-LD Schema Visualizer */}
          <div className="bg-card border border-border p-5 rounded-2xl space-y-3 flex flex-col justify-between">
            <div className="flex items-center justify-between border-b border-border pb-3">
              <h3 className="text-sm font-bold text-card-foreground flex items-center gap-2">
                <FileCode className="w-4 h-4 text-brand" /> {t("admin_seo_generator_jsonld_schema", "JSON-LD Structured Data Schema")}
              </h3>
              <Button size="sm" variant="ghost" onClick={handleCopy} className="h-8 text-xs text-brand hover:text-brand">
                {copied ? <Check className="w-3.5 h-3.5 mr-1 text-success" /> : <Copy className="w-3.5 h-3.5 mr-1" />}
                {copied ? "Kopyalandı" : "Kodu Kopyala"}
              </Button>
            </div>

            <pre className="bg-background p-4 rounded-xl text-success font-mono text-[11px] overflow-x-auto border border-border max-h-64">
              {jsonLdCode}
            </pre>
          </div>
        </div>
      </div>
    </PageShell>
  );
}
