"use client";

import React, { useState, useMemo } from "react";
import { useTranslation } from "react-i18next";
import { useQuery } from "@tanstack/react-query";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Switch } from "@/components/ui/switch";
import { toast } from "sonner";
import { Sparkles, Download, FileText, Loader2, RefreshCw, Copy, Globe2 } from "lucide-react";
import { documentOSApi } from "@/lib/api/document-os";
import { useAuth } from "@/lib/auth";

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

const FALLBACK_LANGUAGES = ["en", "tr", "ar", "de", "fr", "es", "it", "pt", "ja", "nl", "ko", "zh"];

const emptyData = {
  property: { id: "", address: "", city: "", parcelId: "", type: "" },
  landlordOrSeller: { fullName: "", nationalIdOrTaxNo: "", address: "" },
  tenantOrBuyer: { fullName: "", nationalIdOrTaxNo: "", address: "" },
  agent: { fullName: "", licenseNo: "", commissionRate: 0 },
  financials: {
    price: 0,
    currency: "",
    depositAmount: 0,
    startDate: "",
    endDate: "",
    termMonths: 12,
    isZeroDeposit: false,
  },
};

export default function ContractGenerator({ initialCountry }: { initialCountry?: string }) {
  const { t } = useTranslation();
  const { user } = useAuth();

  const [country, setCountry] = useState(initialCountry ?? "TR");
  const [type, setType] = useState("RESIDENTIAL_LEASE");
  const [language, setLanguage] = useState("tr");
  const [useML, setUseML] = useState(false);
  const [form, setForm] = useState<any>({ ...JSON.parse(JSON.stringify(emptyData)) });
  const [generated, setGenerated] = useState<{ html?: string; markdown?: string; metadata?: any; provider?: string } | null>(null);
  const [generating, setGenerating] = useState(false);

  const { data: catalogData, isLoading } = useQuery({
    queryKey: ["document-os-contract-templates"],
    queryFn: () => documentOSApi.getContractTemplates().then((r) => r.data),
  });

  const countries = catalogData?.countries ?? [];
  const languageNames = catalogData?.languages ?? {};

  const countryProfile = countries.find((c: any) => c.country === country);
  const legalBasisText = useMemo(() => {
    const basis = countryProfile?.legalBasis;
    if (!basis) return "";
    if (typeof basis === "string") return basis;
    return basis[language] ?? basis["en"] ?? basis["tr"] ?? "";
  }, [countryProfile, language]);
  const availableTypes = useMemo(() => {
    const entry = catalogData?.templates?.find((tmpl: any) => tmpl.country === country);
    return entry?.types ?? [];
  }, [catalogData, country]);

  const availableLanguages = useMemo(() => {
    if (!countryProfile) return FALLBACK_LANGUAGES;
    const official = countryProfile.officialLanguages ?? [];
    const fromTypes = (availableTypes[0]?.languages as string[]) ?? [];
    return Array.from(new Set([...official, ...fromTypes, ...FALLBACK_LANGUAGES]));
  }, [countryProfile, availableTypes]);

  const setField = (section: string, key: string, value: any) => {
    setForm((prev: any) => ({ ...prev, [section]: { ...prev[section], [key]: value } }));
  };

  const handleCountryChange = (value: string) => {
    setCountry(value);
    const entry = catalogData?.templates?.find((tmpl: any) => tmpl.country === value);
    if (entry?.types?.length) {
      setType(entry.types[0].type);
      const langs = entry.types[0].languages ?? [];
      const profile = countries.find((c: any) => c.country === value);
      if (langs.length) {
        const preferred = profile?.defaultLanguage ?? langs[0];
        setLanguage(langs.includes(preferred) ? preferred : langs[0]);
      }
    }
    setGenerated(null);
  };

  const handleGenerate = async () => {
    setGenerating(true);
    setGenerated(null);
    try {
      const payload = {
        type,
        region: country,
        language,
        data: {
          ...form,
          financials: {
            ...form.financials,
            currency: form.financials.currency || countryProfile?.currency || "USD",
          },
        },
        persist: false,
      };
      if (useML) {
        const res = await documentOSApi.generateContractViaML({ ...payload, data: { ...payload.data, orgId: user?.orgId } });
        setGenerated({ markdown: res.content_markdown ?? res.contentMarkdown, metadata: res, provider: "ML Service" });
      } else {
        const res = await documentOSApi.generateContract(payload);
        setGenerated({ html: res.html, metadata: res.metadata, provider: "Contract Engine" });
      }
      toast.success(t("document_os.contract_generated", { defaultValue: "Contract generated" }));
    } catch (error: any) {
      toast.error(error.message || "Failed to generate contract");
    } finally {
      setGenerating(false);
    }
  };

  const downloadGenerated = () => {
    if (!generated) return;
    const content = generated.html ?? `<pre>${generated.markdown ?? ""}</pre>`;
    const blob = new Blob([content], { type: "text/html" });
    const url = URL.createObjectURL(blob);
    const a = document.createElement("a");
    a.href = url;
    a.download = `contract_${country}_${type}_${language || "en"}.html`;
    a.click();
    URL.revokeObjectURL(url);
  };

  const copyGenerated = async () => {
    if (!generated) return;
    const content = generated.html ?? generated.markdown ?? "";
    try {
      await navigator.clipboard.writeText(content);
      toast.success(t("document_os.copied", { defaultValue: "Copied to clipboard" }));
    } catch {
      toast.error(t("document_os.copy_failed", { defaultValue: "Failed to copy" }));
    }
  };

  return (
    <div className="space-y-6">
      <div className="flex items-start justify-between">
        <div>
          <h1 className="text-3xl font-bold tracking-tight text-slate-100">
            {t("document_os.contract_generator", { defaultValue: "Contract Generator" })}
          </h1>
          <p className="text-slate-400 mt-1">
            {t("document_os.contract_generator_sub", { defaultValue: "Generate localized, legally-grounded contracts for 23 countries" })}
          </p>
        </div>
        <Badge variant="outline" className="text-blue-400 border-blue-500/20 bg-blue-500/10">
          <Globe2 className="h-3 w-3 mr-1" /> {countries.length} countries
        </Badge>
      </div>

      <Card className="bg-slate-900/60 border-slate-800">
        <CardHeader>
          <CardTitle className="text-slate-100 flex items-center gap-2">
            <Sparkles className="h-4 w-4 text-blue-400" />
            {t("document_os.contract_settings", { defaultValue: "Contract Settings" })}
          </CardTitle>
          <CardDescription className="text-slate-400">
            {t("document_os.contract_settings_desc", { defaultValue: "Pick a country, contract type and language." })}
          </CardDescription>
        </CardHeader>
        <CardContent>
          <div className="grid gap-4 md:grid-cols-4">
            <div className="space-y-2">
              <Label className="text-slate-400">Country</Label>
              <Select value={country} onValueChange={handleCountryChange}>
                <SelectTrigger className="bg-slate-800/60 border-slate-700 text-slate-200">
                  <SelectValue placeholder="Country" />
                </SelectTrigger>
                <SelectContent>
                  {countries.map((c: any) => (
                    <SelectItem key={c.country} value={c.country}>
                      {c.countryNameEn} ({c.country})
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>

            <div className="space-y-2">
              <Label className="text-slate-400">Contract Type</Label>
              <Select value={type} onValueChange={setType}>
                <SelectTrigger className="bg-slate-800/60 border-slate-700 text-slate-200">
                  <SelectValue placeholder="Type" />
                </SelectTrigger>
                <SelectContent>
                  {(availableTypes.length ? availableTypes : Object.keys(CONTRACT_TYPE_LABELS).map((x) => ({ type: x }))).map((x: any) => (
                    <SelectItem key={x.type} value={x.type}>
                      {CONTRACT_TYPE_LABELS[x.type] ?? x.type}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>

            <div className="space-y-2">
              <Label className="text-slate-400">Language</Label>
              <Select value={language} onValueChange={setLanguage}>
                <SelectTrigger className="bg-slate-800/60 border-slate-700 text-slate-200">
                  <SelectValue placeholder="Language" />
                </SelectTrigger>
                <SelectContent>
                  {availableLanguages.map((lang) => (
                    <SelectItem key={lang} value={lang}>
                      {(languageNames as Record<string, string>)[lang] ?? lang}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>

            <div className="space-y-2">
              <Label className="text-slate-400">Provider</Label>
              <div className="flex items-center gap-2 h-9 px-3 rounded-lg border border-slate-700 bg-slate-800/60">
                <span className="text-sm text-slate-300">{t("document_os.engine", { defaultValue: "Engine" })}</span>
                <Switch checked={useML} onCheckedChange={setUseML} />
                <span className="text-sm text-slate-300">ML</span>
              </div>
            </div>
          </div>

          {countryProfile && (
            <div className="mt-4 flex flex-wrap items-center gap-2 text-xs">
              <Badge variant="outline" className="text-slate-300 border-slate-700">{countryProfile.currency} {countryProfile.currencySymbol}</Badge>
              {legalBasisText && (
                <Badge variant="outline" className="text-slate-300 border-slate-700">
                  {t("document_os.legal_basis", { defaultValue: "Legal basis" })}: {legalBasisText}
                </Badge>
              )}
              {countryProfile.regulator && (
                <Badge variant="outline" className="text-slate-300 border-slate-700">{countryProfile.regulator.name ?? countryProfile.regulator}</Badge>
              )}
            </div>
          )}
        </CardContent>
      </Card>

      <Card className="bg-slate-900/60 border-slate-800">
        <CardHeader>
          <CardTitle className="text-slate-100">{t("document_os.party_data", { defaultValue: "Party & Property Data" })}</CardTitle>
          <CardDescription className="text-slate-400">
            {t("document_os.party_data_desc", { defaultValue: "Owner/seller, tenant/buyer, property and financial details." })}
          </CardDescription>
        </CardHeader>
        <CardContent>
          <div className="grid gap-4 md:grid-cols-2">
            <div className="space-y-4 rounded-lg border border-slate-800 bg-slate-800/20 p-4">
              <Label className="text-slate-300 font-semibold">Owner / Seller</Label>
              <div className="grid gap-3">
                <Input className="bg-slate-800/60 border-slate-700" placeholder="Full name" value={form.landlordOrSeller.fullName}
                  onChange={(e) => setField("landlordOrSeller", "fullName", e.target.value)} />
                <Input className="bg-slate-800/60 border-slate-700" placeholder="National ID / Tax no" value={form.landlordOrSeller.nationalIdOrTaxNo}
                  onChange={(e) => setField("landlordOrSeller", "nationalIdOrTaxNo", e.target.value)} />
                <Input className="bg-slate-800/60 border-slate-700" placeholder="Address" value={form.landlordOrSeller.address}
                  onChange={(e) => setField("landlordOrSeller", "address", e.target.value)} />
              </div>
            </div>

            <div className="space-y-4 rounded-lg border border-slate-800 bg-slate-800/20 p-4">
              <Label className="text-slate-300 font-semibold">Tenant / Buyer</Label>
              <div className="grid gap-3">
                <Input className="bg-slate-800/60 border-slate-700" placeholder="Full name" value={form.tenantOrBuyer.fullName}
                  onChange={(e) => setField("tenantOrBuyer", "fullName", e.target.value)} />
                <Input className="bg-slate-800/60 border-slate-700" placeholder="National ID / Tax no" value={form.tenantOrBuyer.nationalIdOrTaxNo}
                  onChange={(e) => setField("tenantOrBuyer", "nationalIdOrTaxNo", e.target.value)} />
                <Input className="bg-slate-800/60 border-slate-700" placeholder="Address" value={form.tenantOrBuyer.address}
                  onChange={(e) => setField("tenantOrBuyer", "address", e.target.value)} />
              </div>
            </div>

            <div className="space-y-4 rounded-lg border border-slate-800 bg-slate-800/20 p-4">
              <Label className="text-slate-300 font-semibold">Property</Label>
              <div className="grid gap-3">
                <Input className="bg-slate-800/60 border-slate-700" placeholder="Address" value={form.property.address}
                  onChange={(e) => setField("property", "address", e.target.value)} />
                <Input className="bg-slate-800/60 border-slate-700" placeholder="City" value={form.property.city}
                  onChange={(e) => setField("property", "city", e.target.value)} />
                <Input className="bg-slate-800/60 border-slate-700" placeholder="Type (e.g. APARTMENT, VILLA)" value={form.property.type}
                  onChange={(e) => setField("property", "type", e.target.value)} />
              </div>
            </div>

            <div className="space-y-4 rounded-lg border border-slate-800 bg-slate-800/20 p-4">
              <Label className="text-slate-300 font-semibold">Financials</Label>
              <div className="grid gap-3">
                <div className="grid grid-cols-2 gap-3">
                  <Input type="number" className="bg-slate-800/60 border-slate-700" placeholder="Price / Rent" value={form.financials.price || ""}
                    onChange={(e) => setField("financials", "price", parseFloat(e.target.value) || 0)} />
                  <Input className="bg-slate-800/60 border-slate-700" placeholder="Currency (leave empty to use country)" value={form.financials.currency}
                    onChange={(e) => setField("financials", "currency", e.target.value)} />
                </div>
                <Input type="number" className="bg-slate-800/60 border-slate-700" placeholder="Deposit amount" value={form.financials.depositAmount || ""}
                  onChange={(e) => setField("financials", "depositAmount", parseFloat(e.target.value) || 0)} />
                <div className="grid grid-cols-2 gap-3">
                  <Input className="bg-slate-800/60 border-slate-700" placeholder="Start date" value={form.financials.startDate}
                    onChange={(e) => setField("financials", "startDate", e.target.value)} />
                  <Input className="bg-slate-800/60 border-slate-700" placeholder="End date" value={form.financials.endDate}
                    onChange={(e) => setField("financials", "endDate", e.target.value)} />
                </div>
              </div>
            </div>
          </div>

          <div className="flex items-center gap-3 mt-6">
            <Button onClick={handleGenerate} disabled={generating || isLoading}>
              {generating ? <Loader2 className="h-4 w-4 mr-2 animate-spin" /> : <Sparkles className="h-4 w-4 mr-2" />}
              {t("document_os.generate_contract", { defaultValue: "Generate Contract" })}
            </Button>
            {generated && (
              <>
                <Button variant="outline" onClick={downloadGenerated}>
                  <Download className="h-4 w-4 mr-2" /> {t("document_os.download", { defaultValue: "Download" })}
                </Button>
                <Button variant="outline" onClick={copyGenerated}>
                  <Copy className="h-4 w-4 mr-2" /> {t("document_os.copy", { defaultValue: "Copy" })}
                </Button>
                <Badge className="text-green-400 border-green-500/20 bg-green-500/10">{generated.provider}</Badge>
              </>
            )}
          </div>
        </CardContent>
      </Card>

      {generated && (
        <Card className="bg-slate-900/60 border-slate-800">
          <CardHeader className="flex flex-row items-center justify-between">
            <CardTitle className="text-slate-100 flex items-center gap-2">
              <FileText className="h-4 w-4 text-blue-400" />
              {t("document_os.preview", { defaultValue: "Contract Preview" })}
            </CardTitle>
            <Badge variant="outline" className="text-slate-300 border-slate-700">
              {generated.metadata?.region ?? country} · {generated.metadata?.type ?? type} · {generated.metadata?.language ?? language}
            </Badge>
          </CardHeader>
          <CardContent>
            {generated.html ? (
              <iframe
                title="contract-preview"
                className="w-full h-[520px] rounded-lg border border-slate-800 bg-white"
                srcDoc={generated.html}
              />
            ) : (
              <pre className="whitespace-pre-wrap text-sm text-slate-200 bg-slate-800/40 rounded-lg p-4 border border-slate-800 overflow-auto max-h-[520px]">
                {generated.markdown}
              </pre>
            )}
          </CardContent>
        </Card>
      )}

      {!generated && !isLoading && (
        <div className="text-center py-16 text-slate-500">
          <RefreshCw className="h-8 w-8 mx-auto mb-3 text-slate-600" />
          {t("document_os.no_preview", { defaultValue: "Select options and generate a contract to preview it here." })}
        </div>
      )}
    </div>
  );
}
