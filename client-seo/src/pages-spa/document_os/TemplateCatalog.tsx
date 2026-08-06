"use client";

import React from "react";
import { useTranslation } from "react-i18next";
import { useQuery } from "@tanstack/react-query";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Loader2, Globe2, FileSignature } from "lucide-react";
import { documentOSApi } from "@/lib/api/document-os";
import { Link } from "@/lib/react-router-shim";

const CONTRACT_TYPE_LABELS: Record<string, string> = {
  RESIDENTIAL_LEASE: "Residential Lease",
  COMMERCIAL_LEASE: "Commercial Lease",
  SHORT_TERM_BOOKING: "Short-Term Booking",
  SALES_AGREEMENT: "Sales Agreement",
  EARNEST_MONEY: "Earnest Money",
  EVICTION_COMMITMENT: "Eviction Commitment",
  AGENCY_REPRESENTATION: "Agency Representation",
  PROPERTY_MANAGEMENT: "Property Management",
};

export default function TemplateCatalog() {
  const { t } = useTranslation();

  const { data: catalogData, isLoading } = useQuery({
    queryKey: ["document-os-contract-templates"],
    queryFn: () => documentOSApi.getContractTemplates().then((r) => r.data),
  });

  const countries = catalogData?.countries ?? [];
  const templates = catalogData?.templates ?? [];
  const languageNames = catalogData?.languages ?? {};

  return (
    <div className="space-y-6">
      <div className="flex items-start justify-between">
        <div>
          <h1 className="text-3xl font-bold tracking-tight text-slate-100">
            {t("document_os.template_library", { defaultValue: "Contract Template Library" })}
          </h1>
          <p className="text-slate-400 mt-1">
            {t("document_os.template_library_sub", { defaultValue: "Localized templates for 23 countries across leasing, sales and platform agreements." })}
          </p>
        </div>
        <Badge variant="outline" className="text-blue-400 border-blue-500/20 bg-blue-500/10">
          <Globe2 className="h-3 w-3 mr-1" /> {countries.length} countries
        </Badge>
      </div>

      {isLoading && (
        <div className="flex items-center justify-center py-16 text-slate-500">
          <Loader2 className="h-6 w-6 animate-spin mr-2" /> Loading catalog…
        </div>
      )}

      <div className="grid gap-4 md:grid-cols-2 xl:grid-cols-3">
        {countries.map((c: any) => {
          const entry = templates.find((tmpl: any) => tmpl.country === c.country);
          const types = entry?.types ?? [];
          return (
            <Card key={c.country} className="bg-slate-900/60 border-slate-800">
              <CardHeader>
                <div className="flex items-center justify-between">
                  <CardTitle className="text-slate-100">{c.countryNameEn}</CardTitle>
                  <Badge variant="outline" className="text-slate-300 border-slate-700">{c.country}</Badge>
                </div>
                <CardDescription className="text-slate-400">
                  {c.currency} {c.currencySymbol} · {Array.isArray(c.officialLanguages) ? c.officialLanguages.map((l: string) => (languageNames as Record<string, string>)[l] ?? l).join(", ") : ""}
                </CardDescription>
              </CardHeader>
              <CardContent className="space-y-3">
                <div className="flex flex-wrap gap-1.5">
                  {types.map((x: any) => (
                    <Badge key={x.type} variant="secondary" className="text-[11px] text-slate-300 border-slate-700 bg-slate-800/40">
                      {CONTRACT_TYPE_LABELS[x.type] ?? x.type}
                    </Badge>
                  ))}
                  {types.length === 0 && (
                    <span className="text-xs text-slate-500">{t("document_os.no_templates", { defaultValue: "No templates" })}</span>
                  )}
                </div>
                {(() => {
                  const basis = c.legalBasis;
                  if (!basis) return null;
                  const text = typeof basis === "string" ? basis : basis["en"] ?? basis["tr"] ?? "";
                  return text ? (
                    <p className="text-[11px] text-slate-500 line-clamp-2">{text}</p>
                  ) : null;
                })()}
                <Link to={`/document-os/contracts?country=${c.country}`}>
                  <Button size="sm" variant="outline" className="w-full text-slate-300">
                    <FileSignature className="h-3.5 w-3.5 mr-1.5" />
                    {t("document_os.create_from_template", { defaultValue: "Create contract" })}
                  </Button>
                </Link>
              </CardContent>
            </Card>
          );
        })}
      </div>
    </div>
  );
}
