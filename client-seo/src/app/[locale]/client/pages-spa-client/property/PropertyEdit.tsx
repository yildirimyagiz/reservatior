"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { useNavigate, useParams } from "@/lib/react-router-shim";
import { PageShell } from "../layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { Select, SelectContent, SelectGroup, SelectItem, SelectLabel, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Save, ArrowLeft, MapPin, Home, Building, DollarSign, Bed, Bath, Square, Camera, Video, Calendar, CheckCircle, AlertTriangle, Activity, Upload, Sparkles, Zap } from "lucide-react";
import { m, AnimatePresence } from "framer-motion";
import { cn } from "@/lib/utils";
import { propertiesApi, type Property } from "@/lib/api/properties";
import { useToast } from "@/hooks/use-toast";

interface PropertyFormData {
  name: string;
  type: string;
  addressLine1: string;
  city: string;
  state: string;
  zip: string;
  listingType: "SALE" | "RENT";
  listingStatus: "AVAILABLE" | "PENDING" | "SOLD";
  listingPrice: string;
  bedrooms: string;
  bathrooms: string;
  areaSqm: string;
  description: string;
  yearBuilt: string;
  notes: string;
}

export default function PropertyEdit() {
  const { t } = useTranslation();
  const { id } = useParams() as { id: string };
  const navigate = useNavigate();
  const { toast } = useToast();
  
  const [loading, setLoading] = useState(false);
  const [saving, setSaving] = useState(false);
  const [property, setProperty] = useState<Property | null>(null);
  const [currentStep, setCurrentStep] = useState(1);
  
  const [formData, setFormData] = useState<PropertyFormData>({
    name: "",
    type: "",
    addressLine1: "",
    city: "",
    state: "",
    zip: "",
    listingType: "SALE",
    listingStatus: "AVAILABLE",
    listingPrice: "",
    bedrooms: "",
    bathrooms: "",
    areaSqm: "",
    description: "",
    yearBuilt: "",
    notes: ""
  });

  const isEditing = !!id && id !== "new";

  useEffect(() => {
    if (isEditing) {
      fetchProperty();
    }
  }, [id, isEditing]);

  const fetchProperty = async () => {
    if (!id) return;
    setLoading(true);
    try {
      const idStr = Array.isArray(id) ? id[0] : id;
      const propData = await propertiesApi.getById(idStr);
      if (!propData) throw new Error("Property not found");
      setProperty(propData);
      setFormData({
        name: propData.name || "",
        type: propData.type || "",
        addressLine1: propData.addressLine1 || "",
        city: propData.city || "",
        state: propData.state || "",
        zip: propData.zip || "",
        listingType: (propData.listingType as any) || "SALE",
        listingStatus: (propData.listingStatus as any) || "AVAILABLE",
        listingPrice: propData.listingPrice?.toString() || "",
        bedrooms: propData.bedrooms?.toString() || "",
        bathrooms: propData.bathrooms?.toString() || "",
        areaSqm: propData.areaSqm?.toString() || "",
        description: propData.notes || "",
        yearBuilt: propData.yearBuilt?.toString() || "",
        notes: propData.notes || ""
      });
    } catch (error) {
      toast({
        title: t("client.src.error_loading_property"),
        description: error instanceof Error ? error.message : "Failed to load property data",
        variant: "destructive"
      });
    } finally {
      setLoading(false);
    }
  };

  // ─── DYNAMIC LUXURY TEMPLATES POPULATOR ──────────────────────────────────────
  const loadTemplate = (templateName: string) => {
    if (templateName === "buyukyali") {
      setFormData({
        name: "Büyükyalı Sahil Villası — Marina Exclusive",
        type: "VILLA",
        addressLine1: "Büyükyalı Caddesi No: 12, A Blok D: 3",
        city: "İstanbul",
        state: "Zeytinburnu",
        zip: "34020",
        listingType: "SALE",
        listingStatus: "AVAILABLE",
        listingPrice: "85000000",
        bedrooms: "5",
        bathrooms: "4.5",
        areaSqm: "420",
        description: "Marmara Denizi'ne sıfır konumda, kesintisiz boğaz ve deniz manzaralı, özel yat limanı erişimi, akıllı ev otomasyonu, sauna, buhar odası ve müstakil sonsuzluk havuzuna sahip 5+2 premium akıllı sahil villası.",
        yearBuilt: "2021",
        notes: "Mal sahibi özel portföy müşterisidir. Gösterimler en az 1 gün öncesinden randevu alınarak ve danışman eşliğinde yapılmalıdır."
      });
      toast({
        title: "Büyükyalı Şablonu Yüklendi",
        description: "Form, Büyükyalı Sahil Villası gerçekçi verileriyle dolduruldu.",
      });
    } else if (templateName === "quasar") {
      setFormData({
        name: "Quasar Mecidiyeköy Penthouse — Skyline Suite",
        type: "APARTMENT",
        addressLine1: "Büyükdere Caddesi No: 76, Kat: 34 D: 142",
        city: "İstanbul",
        state: "Şişli",
        zip: "34394",
        listingType: "RENT",
        listingStatus: "AVAILABLE",
        listingPrice: "125000",
        bedrooms: "3",
        bathrooms: "3",
        areaSqm: "260",
        description: "İstanbul'un merkezinde, 360 derece Boğaz ve şehir silüeti manzaralı, lüks konsiyerj hizmetli, özel helikopter pisti erişimli ve ultra modern ankastre donanımlı 3+1 rezidans daire.",
        yearBuilt: "2019",
        notes: "Kira sözleşmesi LeaseCare+ güvencesiyle teminat altına alınmıştır. Depozito koruma hesabında tutulacaktır."
      });
      toast({
        title: "Quasar Penthouse Şablonu Yüklendi",
        description: "Form, Quasar Mecidiyeköy gerçekçi verileriyle dolduruldu.",
      });
    } else if (templateName === "validebag") {
      setFormData({
        name: "Validebağ Konakları — Koru Manzaralı Garden Duplex",
        type: "VILLA",
        addressLine1: "Validebağ Korusu Yanı, B Blok Bahçe Dubleksi",
        city: "İstanbul",
        state: "Üsküdar",
        zip: "34662",
        listingType: "SALE",
        listingStatus: "AVAILABLE",
        listingPrice: "48500000",
        bedrooms: "4",
        bathrooms: "3.5",
        areaSqm: "310",
        description: "Validebağ Korusu'na komşu, müstakil bahçe kullanımlı, yerden ısıtmalı, şömineli, 2 araçlık kapalı otoparklı ve üst düzey güvenlikli 4+1 lüks bahçe dubleksi.",
        yearBuilt: "2020",
        notes: "Kredi kullanımına uygundur. Kat mülkiyeti tapusu mevcuttur. Pazarlık payı vardır."
      });
      toast({
        title: "Validebağ Konakları Şablonu Yüklendi",
        description: "Form, Validebağ Konakları gerçekçi verileriyle dolduruldu.",
      });
    }
  };

  const handleSave = async () => {
    if (!formData.name || !formData.addressLine1 || !formData.city) {
      toast({
        title: t("client.src.missing_required_fields"),
        description: t("client.src.please_fill_in_all"),
        variant: "destructive"
      });
      return;
    }
    setSaving(true);
    try {
      const propertyData: any = {
        ...formData,
        listingPrice: parseFloat(formData.listingPrice) || 0,
        bedrooms: parseInt(formData.bedrooms) || 0,
        bathrooms: parseFloat(formData.bathrooms) || 0,
        areaSqm: parseFloat(formData.areaSqm) || 0,
        yearBuilt: parseInt(formData.yearBuilt) || undefined,
        lat: property?.lat || 40.7128 + (Math.random() - 0.5) * 0.1,
        lng: property?.lng || -74.0060 + (Math.random() - 0.5) * 0.1
      };
      
      let result;
      if (isEditing && property) {
        result = await propertiesApi.update(property.id, propertyData as unknown as any);
      } else {
        result = await propertiesApi.create({ ...propertyData, orgId: "default-org" } as unknown as any);
      }
      
      toast({
        title: isEditing ? "Property Updated" : "Property Created",
        description: `${formData.name} has been ${isEditing ? 'updated' : 'created'} successfully.`
      });
      
      if (!isEditing && result?.id) {
        navigate(`/property/${result.id}`);
      } else {
        navigate("/property");
      }
    } catch (error) {
      toast({
        title: t("client.src.save_failed"),
        description: error instanceof Error ? error.message : "Failed to save property",
        variant: "destructive"
      });
    } finally {
      setSaving(false);
    }
  };

  const getStatusColor = (status: string) => {
    switch (status?.toUpperCase()) {
      case 'AVAILABLE':
        return 'bg-success/10 text-success border-success/20';
      case 'SOLD':
        return 'bg-muted text-muted-foreground border-slate-500/20';
      case 'PENDING':
        return 'bg-warning/10 text-orange-400 border-warning/20';
      default:
        return 'bg-muted text-muted-foreground border-slate-500/20';
    }
  };

  if (loading) {
    return (
      <div className="min-h-screen bg-[#0a0b0d] flex items-center justify-center">
        <div className="flex flex-col items-center gap-6">
          <Activity className="w-12 h-12 text-brand animate-spin" />
          <p className="text-xs font-black text-muted-foreground tracking-widest italic animate-pulse">{t("client.src.loading_property_data")}</p>
        </div>
      </div>
    );
  }

  return (
    <PageShell title={isEditing ? "Edit Property" : "Create Property"} description={`${isEditing ? "Update" : "Add"} property information`}>
      <div className="max-w-4xl mx-auto px-4 lg:px-8 py-10 space-y-8">
        
        {/* Header */}
        <div className="flex items-center justify-between">
          <div className="flex items-center gap-4">
            <Button variant="ghost" onClick={() => navigate(-1)} className="text-muted-foreground hover:text-white">
              <ArrowLeft className="w-4 h-4 mr-2" />{t("client.src.back")}
            </Button>
            <div>
              <h1 className="text-3xl font-black text-white italic tracking-tighter">
                {isEditing ? "Edit Property" : "Create New Property"}
              </h1>
              <p className="text-sm text-muted-foreground mt-1">
                {isEditing ? `Editing: ${property?.name}` : "Add a new property to your portfolio"}
              </p>
            </div>
          </div>
          
          <Badge className={cn("text-[10px] font-black tracking-widest px-3", getStatusColor(formData.listingStatus))}>
            {formData.listingStatus}
          </Badge>
        </div>

        {/* ─── QUICK DEMO TEMPLATES CONTAINER ────────────────────────────────── */}
        {!isEditing && (
          <div className="bg-background/40 border border-white/5 rounded-3xl p-6 space-y-4">
            <div className="flex items-center gap-2">
              <Sparkles className="w-4 h-4 text-amber-400 animate-pulse" />
              <span className="text-[10px] font-black tracking-widest text-muted-foreground uppercase italic">HIZLI TASLAK ÖRNEKLERİ</span>
            </div>
            <p className="text-xs text-muted-foreground">
              Formu projenizin lüks portföy şablonlarından biriyle tek tıkla doldurarak canlı test edin:
            </p>
            <div className="flex flex-wrap gap-3">
              <button 
                onClick={() => loadTemplate("buyukyali")}
                className="px-4 py-2.5 rounded-2xl bg-brand/100/10 border border-blue-500/30 text-brand text-xs font-black uppercase tracking-wider italic hover:bg-brand/100/20 transition-all flex items-center gap-2 cursor-pointer"
              >
                <Building className="w-3.5 h-3.5" /> Büyükyalı Sahil Villası
              </button>
              <button 
                onClick={() => loadTemplate("quasar")}
                className="px-4 py-2.5 rounded-2xl bg-violet-500/10 border border-violet-500/30 text-violet-400 text-xs font-black uppercase tracking-wider italic hover:bg-violet-500/20 transition-all flex items-center gap-2 cursor-pointer"
              >
                <Zap className="w-3.5 h-3.5" /> Quasar Sky Penthouse
              </button>
              <button 
                onClick={() => loadTemplate("validebag")}
                className="px-4 py-2.5 rounded-2xl bg-success/10 border border-blue-500/30 text-success text-xs font-black uppercase tracking-wider italic hover:bg-success/20 transition-all flex items-center gap-2 cursor-pointer"
              >
                <Home className="w-3.5 h-3.5" /> Validebağ Konakları
              </button>
            </div>
          </div>
        )}

        {/* Form Stepper UI */}
        <div className="flex items-center justify-between mb-8 relative px-4">
          <div className="absolute left-8 right-8 top-1/2 h-1 bg-background border border-white/5 -z-10 -translate-y-1/2 rounded-full overflow-hidden">
            <m.div 
              className="h-full bg-orange-500 shadow-[0_0_15px_rgba(249,115,22,0.5)]" 
              initial={{ width: 0 }}
              animate={{ width: `${((currentStep - 1) / 3) * 100}%` }}
              transition={{ duration: 0.5, ease: "easeInOut" }}
            />
          </div>
          {[
            { step: 1, label: t("client.src.basic_information"), icon: Home },
            { step: 2, label: t("common.location"), icon: MapPin },
            { step: 3, label: t("client.src.property_details"), icon: Building },
            { step: 4, label: t("client.src.description_notes"), icon: Camera }
          ].map((s) => (
            <div key={s.step} className="flex flex-col items-center gap-3">
              <div className={cn(
                "w-14 h-14 rounded-2xl flex items-center justify-center font-black italic tracking-tighter transition-all duration-500 shadow-xl border",
                currentStep >= s.step 
                  ? "bg-orange-600 text-white border-orange-500 shadow-orange-600/20 scale-110" 
                  : "bg-card text-muted-foreground border-white/5 hover:border-white/10"
              )}>
                <s.icon className="w-5 h-5" />
              </div>
              <span className={cn(
                "text-[9px] font-black tracking-widest uppercase transition-colors duration-300",
                currentStep >= s.step ? "text-orange-400" : "text-muted-foreground"
              )}>
                {s.label}
              </span>
            </div>
          ))}
        </div>

        {/* Form Wizard Content */}
        <div className="min-h-[450px]">
          <AnimatePresence mode="wait">
            {currentStep === 1 && (
              <m.div key="step1" initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} exit={{ opacity: 0, y: -20 }} transition={{ duration: 0.3 }}>
                <Card className="bg-background/60 backdrop-blur-3xl border-white/5 rounded-[32px] p-10 shadow-2xl border-l border-t">
                  <CardHeader className="px-0 pt-0 pb-8">
                    <CardTitle className="text-2xl font-black text-white italic tracking-tighter flex items-center gap-3">
                      <div className="p-3 bg-warning/10 rounded-xl border border-warning/20"><Home className="w-6 h-6 text-orange-500" /></div>
                      {t("client.src.basic_information")}
                    </CardTitle>
                  </CardHeader>
                  <CardContent className="space-y-8 px-0 pb-0">
                    <div className="space-y-3">
                      <label className="text-[10px] font-black text-muted-foreground tracking-widest uppercase ml-2">{t("client.src.property_name")}</label>
                      <Input value={formData.name} onChange={e => setFormData(prev => ({ ...prev, name: e.target.value }))} placeholder={t("client.src.luxury_downtown_apartment")} className="bg-black/40 border-white/5 text-white h-16 rounded-2xl px-6 font-medium placeholder:text-muted-foreground focus:border-orange-500/50 focus:ring-orange-500/20" />
                    </div>
                    
                    <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
                      <div className="space-y-3">
                        <label className="text-[10px] font-black text-muted-foreground tracking-widest uppercase ml-2">{t("client.src.property_type")}</label>
                        <Select value={formData.type} onValueChange={value => setFormData(prev => ({ ...prev, type: value }))}>
                          <SelectTrigger className="bg-black/40 border-white/5 text-white h-16 rounded-2xl px-6 font-medium focus:ring-orange-500/20">
                            <SelectValue placeholder={t("common.select_type")} />
                          </SelectTrigger>
                          <SelectContent className="bg-card/95 border-white/10 text-white font-black text-[10px] tracking-widest italic backdrop-blur-3xl rounded-xl max-h-[400px]">
                            <SelectGroup>
                              <SelectLabel className="text-muted-foreground font-bold uppercase tracking-widest text-[9px] px-2 py-1">{t("client.property.portfolio.filters.type.residential")} - HOUSES</SelectLabel>
                              <SelectItem value="DETACHED_HOUSE">{t("client.property.types.DETACHED_HOUSE")}</SelectItem>
                              <SelectItem value="SEMI_DETACHED_HOUSE">{t("client.property.types.SEMI_DETACHED_HOUSE")}</SelectItem>
                              <SelectItem value="TERRACED_HOUSE">{t("client.property.types.TERRACED_HOUSE")}</SelectItem>
                              <SelectItem value="TOWNHOUSE">{t("client.property.types.TOWNHOUSE")}</SelectItem>
                              <SelectItem value="SINGLE_FAMILY">{t("client.property.types.SINGLE_FAMILY")}</SelectItem>
                              <SelectItem value="MULTI_FAMILY">{t("client.property.types.MULTI_FAMILY")}</SelectItem>
                              <SelectItem value="BUNGALOW">{t("client.property.types.BUNGALOW")}</SelectItem>
                              <SelectItem value="COTTAGE">{t("client.property.types.COTTAGE")}</SelectItem>
                              <SelectItem value="VILLA">{t("client.property.types.VILLA")}</SelectItem>
                              <SelectItem value="CABIN_TINY_HOUSE">{t("client.property.types.CABIN_TINY_HOUSE")}</SelectItem>
                              <SelectItem value="ADU_GUEST_HOUSE">{t("client.property.types.ADU_GUEST_HOUSE")}</SelectItem>
                              <SelectItem value="COMPOUND">{t("client.property.types.COMPOUND")}</SelectItem>
                            </SelectGroup>
                            <SelectGroup>
                              <SelectLabel className="text-muted-foreground font-bold uppercase tracking-widest text-[9px] px-2 py-1 mt-2">{t("client.property.portfolio.filters.type.residential")} - APARTMENTS</SelectLabel>
                              <SelectItem value="APARTMENT">{t("client.property.types.APARTMENT")}</SelectItem>
                              <SelectItem value="CONDO_APARTMENT">{t("client.property.types.CONDO_APARTMENT")}</SelectItem>
                              <SelectItem value="FLAT_MAISONETTE">{t("client.property.types.FLAT_MAISONETTE")}</SelectItem>
                              <SelectItem value="STUDIO">{t("client.property.types.STUDIO")}</SelectItem>
                              <SelectItem value="PENTHOUSE">{t("client.property.types.PENTHOUSE")}</SelectItem>
                            </SelectGroup>
                            <SelectGroup>
                              <SelectLabel className="text-muted-foreground font-bold uppercase tracking-widest text-[9px] px-2 py-1 mt-2">{t("client.property.portfolio.filters.type.commercial")}</SelectLabel>
                              <SelectItem value="OFFICE">{t("client.property.types.OFFICE")}</SelectItem>
                              <SelectItem value="RETAIL">{t("client.property.types.RETAIL")}</SelectItem>
                              <SelectItem value="COMMERCIAL_SPACE">{t("client.property.types.COMMERCIAL_SPACE")}</SelectItem>
                              <SelectItem value="COMMERCIAL">{t("client.property.types.COMMERCIAL")}</SelectItem>
                            </SelectGroup>
                          </SelectContent>
                        </Select>
                      </div>
                      <div className="space-y-3">
                        <label className="text-[10px] font-black text-muted-foreground tracking-widest uppercase ml-2">{t("client.src.price")} (₺)</label>
                        <Input type="number" value={formData.listingPrice} onChange={e => setFormData(prev => ({ ...prev, listingPrice: e.target.value }))} placeholder="500000" className="bg-black/40 border-white/5 text-white h-16 rounded-2xl px-6 font-medium placeholder:text-muted-foreground focus:border-orange-500/50 focus:ring-orange-500/20" />
                      </div>
                    </div>
                    
                    <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
                      <div className="space-y-3">
                        <label className="text-[10px] font-black text-muted-foreground tracking-widest uppercase ml-2">{t("client.src.listing_type")}</label>
                        <Select value={formData.listingType} onValueChange={(value: "SALE" | "RENT") => setFormData(prev => ({ ...prev, listingType: value }))}>
                          <SelectTrigger className="bg-black/40 border-white/5 text-white h-16 rounded-2xl px-6 font-medium focus:ring-orange-500/20">
                            <SelectValue placeholder={t("common.select_type")} />
                          </SelectTrigger>
                          <SelectContent className="bg-card border-white/10 rounded-xl">
                            <SelectItem value="SALE" className="font-bold italic text-[10px] tracking-widest">{t("client.src.for_sale")}</SelectItem>
                            <SelectItem value="RENT" className="font-bold italic text-[10px] tracking-widest">{t("client.src.for_rent")}</SelectItem>
                          </SelectContent>
                        </Select>
                      </div>
                      <div className="space-y-3">
                        <label className="text-[10px] font-black text-muted-foreground tracking-widest uppercase ml-2">{t("common.status")}</label>
                        <Select value={formData.listingStatus} onValueChange={(value: "AVAILABLE" | "PENDING" | "SOLD") => setFormData(prev => ({ ...prev, listingStatus: value }))}>
                          <SelectTrigger className="bg-black/40 border-white/5 text-white h-16 rounded-2xl px-6 font-medium focus:ring-orange-500/20">
                            <SelectValue placeholder={t("client.src.select_status")} />
                          </SelectTrigger>
                          <SelectContent className="bg-card border-white/10 rounded-xl">
                            <SelectItem value="AVAILABLE" className="font-bold italic text-[10px] tracking-widest">{t("client.src.available")}</SelectItem>
                            <SelectItem value="PENDING" className="font-bold italic text-[10px] tracking-widest">{t("common.processing")}</SelectItem>
                            <SelectItem value="SOLD" className="font-bold italic text-[10px] tracking-widest">{t("client.src.sold")}</SelectItem>
                          </SelectContent>
                        </Select>
                      </div>
                    </div>
                  </CardContent>
                </Card>
              </m.div>
            )}

            {currentStep === 2 && (
              <m.div key="step2" initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} exit={{ opacity: 0, y: -20 }} transition={{ duration: 0.3 }}>
                <Card className="bg-background/60 backdrop-blur-3xl border-white/5 rounded-[32px] p-10 shadow-2xl border-l border-t">
                  <CardHeader className="px-0 pt-0 pb-8">
                    <CardTitle className="text-2xl font-black text-white italic tracking-tighter flex items-center gap-3">
                      <div className="p-3 bg-brand/100/10 rounded-xl border border-blue-500/20"><MapPin className="w-6 h-6 text-brand" /></div>
                      {t("common.location")}
                    </CardTitle>
                  </CardHeader>
                  <CardContent className="space-y-8 px-0 pb-0">
                    <div className="space-y-3">
                      <label className="text-[10px] font-black text-muted-foreground tracking-widest uppercase ml-2">{t("client.src.address_line_1")}</label>
                      <Input value={formData.addressLine1} onChange={e => setFormData(prev => ({ ...prev, addressLine1: e.target.value }))} placeholder={t("client.src.123_main_street")} className="bg-black/40 border-white/5 text-white h-16 rounded-2xl px-6 font-medium placeholder:text-muted-foreground focus:border-blue-500/50 focus:ring-blue-500/20" />
                    </div>
                    <div className="space-y-3">
                      <label className="text-[10px] font-black text-muted-foreground tracking-widest uppercase ml-2">{t("client.src.city")}</label>
                      <Input value={formData.city} onChange={e => setFormData(prev => ({ ...prev, city: e.target.value }))} placeholder={t("client.src.new_york")} className="bg-black/40 border-white/5 text-white h-16 rounded-2xl px-6 font-medium placeholder:text-muted-foreground focus:border-blue-500/50 focus:ring-blue-500/20" />
                    </div>
                    <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
                      <div className="space-y-3">
                        <label className="text-[10px] font-black text-muted-foreground tracking-widest uppercase ml-2">{t("client.src.state")}</label>
                        <Input value={formData.state} onChange={e => setFormData(prev => ({ ...prev, state: e.target.value }))} placeholder={t("client.src.ny")} className="bg-black/40 border-white/5 text-white h-16 rounded-2xl px-6 font-medium placeholder:text-muted-foreground focus:border-blue-500/50 focus:ring-blue-500/20" />
                      </div>
                      <div className="space-y-3">
                        <label className="text-[10px] font-black text-muted-foreground tracking-widest uppercase ml-2">{t("client.src.zip_code")}</label>
                        <Input value={formData.zip} onChange={e => setFormData(prev => ({ ...prev, zip: e.target.value }))} placeholder="10001" className="bg-black/40 border-white/5 text-white h-16 rounded-2xl px-6 font-medium placeholder:text-muted-foreground focus:border-blue-500/50 focus:ring-blue-500/20" />
                      </div>
                    </div>
                  </CardContent>
                </Card>
              </m.div>
            )}

            {currentStep === 3 && (
              <m.div key="step3" initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} exit={{ opacity: 0, y: -20 }} transition={{ duration: 0.3 }}>
                <Card className="bg-background/60 backdrop-blur-3xl border-white/5 rounded-[32px] p-10 shadow-2xl border-l border-t">
                  <CardHeader className="px-0 pt-0 pb-8">
                    <CardTitle className="text-2xl font-black text-white italic tracking-tighter flex items-center gap-3">
                      <div className="p-3 bg-violet-500/10 rounded-xl border border-violet-500/20"><Building className="w-6 h-6 text-violet-500" /></div>
                      {t("client.src.property_details")}
                    </CardTitle>
                  </CardHeader>
                  <CardContent className="space-y-8 px-0 pb-0">
                    <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
                      <div className="space-y-3">
                        <label className="text-[10px] font-black text-muted-foreground tracking-widest uppercase ml-2">{t("client.src.bedrooms")}</label>
                        <Input type="number" value={formData.bedrooms} onChange={e => setFormData(prev => ({ ...prev, bedrooms: e.target.value }))} placeholder="3" className="bg-black/40 border-white/5 text-white h-16 rounded-2xl px-6 font-medium placeholder:text-muted-foreground focus:border-violet-500/50 focus:ring-violet-500/20" />
                      </div>
                      <div className="space-y-3">
                        <label className="text-[10px] font-black text-muted-foreground tracking-widest uppercase ml-2">{t("client.src.bathrooms")}</label>
                        <Input type="number" step="0.5" value={formData.bathrooms} onChange={e => setFormData(prev => ({ ...prev, bathrooms: e.target.value }))} placeholder="2.5" className="bg-black/40 border-white/5 text-white h-16 rounded-2xl px-6 font-medium placeholder:text-muted-foreground focus:border-violet-500/50 focus:ring-violet-500/20" />
                      </div>
                      <div className="space-y-3">
                        <label className="text-[10px] font-black text-muted-foreground tracking-widest uppercase ml-2">{t("client.src.area_sqm")}</label>
                        <Input type="number" value={formData.areaSqm} onChange={e => setFormData(prev => ({ ...prev, areaSqm: e.target.value }))} placeholder="120" className="bg-black/40 border-white/5 text-white h-16 rounded-2xl px-6 font-medium placeholder:text-muted-foreground focus:border-violet-500/50 focus:ring-violet-500/20" />
                      </div>
                    </div>
                    <div className="space-y-3">
                      <label className="text-[10px] font-black text-muted-foreground tracking-widest uppercase ml-2">{t("client.src.year_built")}</label>
                      <Input type="number" value={formData.yearBuilt} onChange={e => setFormData(prev => ({ ...prev, yearBuilt: e.target.value }))} placeholder="2010" className="bg-black/40 border-white/5 text-white h-16 rounded-2xl px-6 font-medium placeholder:text-muted-foreground focus:border-violet-500/50 focus:ring-violet-500/20" />
                    </div>
                  </CardContent>
                </Card>
              </m.div>
            )}

            {currentStep === 4 && (
              <m.div key="step4" initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} exit={{ opacity: 0, y: -20 }} transition={{ duration: 0.3 }}>
                <Card className="bg-background/60 backdrop-blur-3xl border-white/5 rounded-[32px] p-10 shadow-2xl border-l border-t">
                  <CardHeader className="px-0 pt-0 pb-8">
                    <CardTitle className="text-2xl font-black text-white italic tracking-tighter flex items-center gap-3">
                      <div className="p-3 bg-success/10 rounded-xl border border-success/20"><Camera className="w-6 h-6 text-success" /></div>
                      {t("client.src.description_notes")}
                    </CardTitle>
                  </CardHeader>
                  <CardContent className="space-y-8 px-0 pb-0">
                    <div className="space-y-3">
                      <label className="text-[10px] font-black text-muted-foreground tracking-widest uppercase ml-2">{t("common.description")}</label>
                      <Textarea value={formData.description} onChange={e => setFormData(prev => ({ ...prev, description: e.target.value }))} placeholder={formData.type ? t(`client.property.placeholders.${formData.type}`) : t("client.src.beautiful_property_with_modern")} className="bg-black/40 border-white/5 text-white min-h-[160px] rounded-2xl p-6 font-medium placeholder:text-muted-foreground focus:border-blue-500/50 focus:ring-blue-500/20" />
                    </div>
                    <div className="space-y-3">
                      <label className="text-[10px] font-black text-muted-foreground tracking-widest uppercase ml-2">{t("client.src.internal_notes")}</label>
                      <Textarea value={formData.notes} onChange={e => setFormData(prev => ({ ...prev, notes: e.target.value }))} placeholder={t("client.src.internal_notes_and_observations")} className="bg-black/40 border-white/5 text-white min-h-[120px] rounded-2xl p-6 font-medium placeholder:text-muted-foreground focus:border-blue-500/50 focus:ring-blue-500/20" />
                    </div>
                  </CardContent>
                </Card>
              </m.div>
            )}
          </AnimatePresence>
        </div>

        {/* Actions Footer */}
        <div className="flex items-center justify-between border-t border-white/5 pt-8 mt-10">
          <div className="flex items-center gap-4">
            <Button variant="ghost" onClick={() => navigate(-1)} className="text-muted-foreground hover:text-white h-14 px-6 rounded-2xl font-black tracking-widest italic text-[10px]">
              {t("common.cancel")}
            </Button>
          </div>
          
          <div className="flex items-center gap-4">
            {currentStep > 1 && (
              <Button variant="outline" onClick={() => setCurrentStep(prev => prev - 1)} className="border-white/5 bg-white/5 text-muted-foreground hover:text-white h-14 px-8 rounded-2xl font-black tracking-widest italic text-[10px] shadow-xl">
                {t("client.src.back", "BACK")}
              </Button>
            )}
            
            {currentStep < 4 ? (
              <Button onClick={() => setCurrentStep(prev => prev + 1)} className="bg-orange-600 hover:bg-orange-500 text-white font-black tracking-widest italic text-xs h-14 px-10 rounded-2xl shadow-xl shadow-orange-600/20 hover:scale-105 active:scale-95 transition-all">
                {t("client.src.next_step", "NEXT STEP")}
              </Button>
            ) : (
              <Button onClick={handleSave} disabled={saving} className="bg-blue-600 hover:bg-success text-white font-black tracking-widest italic text-xs h-14 px-10 rounded-2xl shadow-xl shadow-blue-600/20 hover:scale-105 active:scale-95 transition-all">
                {saving ? (
                  <>
                    <Activity className="w-5 h-5 animate-spin mr-3" />{t("client.src.saving")}
                  </>
                ) : (
                  <>
                    <Save className="w-5 h-5 mr-3" />
                    {isEditing ? t("client.src.update_property", "UPDATE") : t("publish", "PUBLISH")}
                  </>
                )}
              </Button>
            )}
          </div>
        </div>
      </div>
    </PageShell>
  );
}