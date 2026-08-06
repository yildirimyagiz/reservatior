import { useTranslation } from "react-i18next";
import React, { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Scale, Building2, Globe, CheckCircle2, Calculator, ShieldCheck, ChevronRight, ChevronLeft, AlertTriangle } from "lucide-react";
import { Button } from "@/components/ui/button";

// ──────────────────────────────────────────────────────────────────────────────
// Inline bölge uyumluluk verileri — regions-config.json yerine kullanılır
// Sunucu tarafı regions-config.json'dan bağımsız, client-seo'ya özgüdür.
// ──────────────────────────────────────────────────────────────────────────────
const REGIONS_COMPLIANCE: Record<string, {
  countryName: string;
  currency: string;
  baseCommission: number;
  complianceType: string;
  requiredLicense: string;
  flag: string;
}> = {
  TR:  { countryName: "Turkey",        currency: "TRY", baseCommission: 0.03, complianceType: "KVKK + Turkish Tax Law",    requiredLicense: "Tapu ve Kadastro Genel Müdürlüğü", flag: "🇹🇷" },
  AE:  { countryName: "UAE",           currency: "AED", baseCommission: 0.02, complianceType: "RERA Dubai",                 requiredLicense: "RERA Real Estate Broker License",   flag: "🇦🇪" },
  SA:  { countryName: "Saudi Arabia",  currency: "SAR", baseCommission: 0.025,complianceType: "Ejar / REGA",               requiredLicense: "Ejar Registered Agent",              flag: "🇸🇦" },
  UK:  { countryName: "United Kingdom",currency: "GBP", baseCommission: 0.015,complianceType: "RICS / NAEA / TDS",         requiredLicense: "NAEA Propertymark License",         flag: "🇬🇧" },
  DE:  { countryName: "Germany",       currency: "EUR", baseCommission: 0.035,complianceType: "BGB Mietrecht / GDPR",       requiredLicense: "IHK Maklerausweis §34c GewO",       flag: "🇩🇪" },
  FR:  { countryName: "France",        currency: "EUR", baseCommission: 0.05, complianceType: "Loi Alur / GDPR",            requiredLicense: "Carte Professionnelle T",            flag: "🇫🇷" },
  ES:  { countryName: "Spain",         currency: "EUR", baseCommission: 0.03, complianceType: "LAU / GDPR",                 requiredLicense: "COAPI Registration",                flag: "🇪🇸" },
  IT:  { countryName: "Italy",         currency: "EUR", baseCommission: 0.03, complianceType: "Codice Civile / GDPR",       requiredLicense: "Camera di Commercio License",       flag: "🇮🇹" },
  NL:  { countryName: "Netherlands",   currency: "EUR", baseCommission: 0.01, complianceType: "Huurrecht / GDPR",           requiredLicense: "NVM / VBO Makelaar",                flag: "🇳🇱" },
  US:  { countryName: "United States", currency: "USD", baseCommission: 0.06, complianceType: "Fair Housing Act / CCPA",    requiredLicense: "State Real Estate License",         flag: "🇺🇸" },
  CA:  { countryName: "Canada",        currency: "CAD", baseCommission: 0.05, complianceType: "REBBA 2002 / PIPEDA",        requiredLicense: "Provincial Real Estate License",    flag: "🇨🇦" },
  MX:  { countryName: "Mexico",        currency: "MXN", baseCommission: 0.05, complianceType: "Código Civil Federal",       requiredLicense: "AMPI Member License",               flag: "🇲🇽" },
  BR:  { countryName: "Brazil",        currency: "BRL", baseCommission: 0.06, complianceType: "Lei do Inquilinato",         requiredLicense: "CRECI Registration",               flag: "🇧🇷" },
  AR:  { countryName: "Argentina",     currency: "ARS", baseCommission: 0.04, complianceType: "Locaciones Urbanas",         requiredLicense: "CUCICBA / CMAYEP License",          flag: "🇦🇷" },
  AU:  { countryName: "Australia",     currency: "AUD", baseCommission: 0.02, complianceType: "Residential Tenancies Act",  requiredLicense: "State Agent License",               flag: "🇦🇺" },
  NZ:  { countryName: "New Zealand",   currency: "NZD", baseCommission: 0.025,complianceType: "Residential Tenancies Act 1986", requiredLicense: "REAA License",              flag: "🇳🇿" },
  JP:  { countryName: "Japan",         currency: "JPY", baseCommission: 0.03, complianceType: "Takken-gyō Hō",              requiredLicense: "宅地建物取引士 (Takken-shi)",           flag: "🇯🇵" },
  KR:  { countryName: "South Korea",   currency: "KRW", baseCommission: 0.005,complianceType: "Jeonse Law / 공인중개사법",     requiredLicense: "공인중개사 (Licensed Agent)",           flag: "🇰🇷" },
  CN:  { countryName: "China",         currency: "CNY", baseCommission: 0.02, complianceType: "PRC Property Law",           requiredLicense: "房地产经纪人 Registration",            flag: "🇨🇳" },
  IN:  { countryName: "India",         currency: "INR", baseCommission: 0.02, complianceType: "RERA India / Rent Control",  requiredLicense: "State RERA Registration",           flag: "🇮🇳" },
  SG:  { countryName: "Singapore",     currency: "SGD", baseCommission: 0.01, complianceType: "Residential Property Act",   requiredLicense: "CEA Salesperson License",           flag: "🇸🇬" },
  MY:  { countryName: "Malaysia",      currency: "MYR", baseCommission: 0.03, complianceType: "National Land Code",         requiredLicense: "BOVAEA Registration",               flag: "🇲🇾" },
  TH:  { countryName: "Thailand",      currency: "THB", baseCommission: 0.03, complianceType: "Civil and Commercial Code",  requiredLicense: "Estate Agent License",              flag: "🇹🇭" },
};

type RegionKey = keyof typeof REGIONS_COMPLIANCE;

export const LocalComplianceWidget: React.FC = () => {
  const { t } = useTranslation();
  const regions = Object.keys(REGIONS_COMPLIANCE) as RegionKey[];
  const [currentIndex, setCurrentIndex] = useState(0);
  const currentKey = regions[currentIndex];
  const data = REGIONS_COMPLIANCE[currentKey];

  const handleNext = () => setCurrentIndex(prev => (prev + 1) % regions.length);
  const handlePrev = () => setCurrentIndex(prev => (prev - 1 + regions.length) % regions.length);

  return <div className="space-y-6">
      {/* Dynamic Regional Strategy Header */}
      <Card className="border-none bg-gradient-to-br from-slate-900 via-indigo-950 to-slate-900 text-white shadow-2xl overflow-hidden relative group">
         <div className="absolute -top-10 -right-10 w-40 h-40 bg-indigo-500/10 rounded-full blur-3xl group-hover:bg-indigo-500/20 transition-all duration-700" />
         <CardHeader className="pb-4">
            <div className="flex items-center justify-between">
               <Badge className="bg-indigo-500/20 text-indigo-300 border-indigo-500/30 text-[10px] font-black uppercase tracking-widest backdrop-blur-md">
                 {t("client.src.global_strategy")} {(data.baseCommission * 100).toFixed(1)}% {t("client.src.comm")}
               </Badge>
               <div className="flex gap-1">
                  <Button variant="ghost" size="icon" aria-label={t("common.previous")} className="min-h-12 min-w-12 rounded-full hover:bg-white/10" onClick={handlePrev}>
                    <ChevronLeft className="w-4 h-4 text-white/50" />
                  </Button>
                  <Button variant="ghost" size="icon" aria-label={t("common.next")} className="min-h-12 min-w-12 rounded-full hover:bg-white/10" onClick={handleNext}>
                    <ChevronRight className="w-4 h-4 text-white/50" />
                  </Button>
               </div>
            </div>
            <CardTitle className="text-2xl font-black mt-4 flex items-center justify-between">
               <div className="flex items-center gap-3">
                  <span className="text-3xl">{data.flag}</span>
                  <span>{data.countryName}</span>
               </div>
               <Globe className="w-5 h-5 text-indigo-400 opacity-60" />
            </CardTitle>
         </CardHeader>
      </Card>

      {/* Compliance & Tax Shield */}
      <Card className="border-none shadow-xl bg-white ring-1 ring-slate-200 overflow-hidden">
         <CardHeader className="bg-slate-50/50 border-b border-slate-100 p-4">
            <div className="flex items-center justify-between">
               <CardTitle className="text-sm font-black text-slate-800 flex items-center gap-2">
                  <Building2 className="w-4 h-4 text-indigo-600" />{t("client.src.regulatory_framework")}</CardTitle>
               <Badge variant="outline" className="border-indigo-100 text-indigo-600 font-bold bg-indigo-50/50 text-[10px]">
                  {data.complianceType}
               </Badge>
            </div>
         </CardHeader>
         <CardContent className="p-5 space-y-4">
            <div className="grid grid-cols-1 gap-4">
               {/* License Info */}
               <div className="flex items-start gap-3">
                  <div className="p-2 rounded-lg bg-indigo-50 text-indigo-600 shrink-0">
                     <Scale className="w-3.5 h-3.5" />
                  </div>
                  <div className="flex-1">
                     <h4 className="text-[11px] font-black text-slate-900 uppercase tracking-tighter">{t("client.src.required_license")}</h4>
                     <p className="text-[10px] text-slate-500 font-medium leading-relaxed mt-0.5">
                       {t("client.src.proper_listing_in")}{data.countryName}{t("client.src.requires_checking")}
                       <span className="text-slate-900 font-bold">{data.requiredLicense}</span>.
                     </p>
                  </div>
                  <CheckCircle2 className="w-3.5 h-3.5 text-blue-500 shrink-0" />
               </div>

               {/* Tax Logic */}
               <div className="flex items-start gap-3">
                  <div className="p-2 rounded-lg bg-amber-50 text-amber-600 shrink-0">
                     <Calculator className="w-3.5 h-3.5" />
                  </div>
                  <div className="flex-1">
                     <h4 className="text-[11px] font-black text-slate-900 uppercase tracking-tighter">{t("client.src.automated_reporting")}</h4>
                     <p className="text-[10px] text-slate-500 font-medium leading-relaxed mt-0.5">
                       {t("client.src.our_internal_engine_handles")}
                       <span className="text-slate-900 font-bold">{data.currency}</span>
                       {t("client.src.transactions_with_local")}{data.complianceType}{t("client.src.standards")}
                     </p>
                  </div>
                  <CheckCircle2 className="w-3.5 h-3.5 text-blue-500 shrink-0" />
               </div>
            </div>

            <div className="pt-4 border-t border-slate-100">
               <div className="flex items-center gap-3 p-3 rounded-xl bg-indigo-50/50 border border-indigo-100">
                  <ShieldCheck className="w-4 h-4 text-indigo-600 shrink-0" />
                  <p className="text-[9px] font-bold text-indigo-800 leading-tight">
                    {t("client.src.strategic_advantage_unlike_otas")}{data.countryName}
                    {t("client.src.our")}{currentKey}{t("client.src.legal_entity_provides_a")}
                  </p>
               </div>
            </div>

            <div className="flex flex-col gap-2">
               <Button className="w-full bg-slate-900 hover:bg-slate-800 text-white font-black py-5 rounded-lg text-xs shadow-lg">
                 {t("client.src.deploy")}{data.countryName}{t("client.src.compliance_pack")}
               </Button>
               <p className="text-[9px] text-slate-400 text-center font-medium italic flex items-center justify-center gap-1">
                  <AlertTriangle className="w-3 h-3 text-amber-500" />
                  {t("client.src.region_determined_via_regionsconfigjson")}
                  <span className="text-indigo-600 font-bold ml-1">{currentIndex + 1}/{regions.length}</span>
               </p>
            </div>
         </CardContent>
      </Card>
      
      <div className="flex items-center justify-center gap-2 py-2">
         <div className="h-px bg-slate-200 flex-1" />
         <span className="text-[9px] font-black text-slate-400 uppercase tracking-[0.2em] px-3">
           {t("client.src.global_shield")} {currentKey}
         </span>
         <div className="h-px bg-slate-200 flex-1" />
      </div>
    </div>;
};

export default LocalComplianceWidget;