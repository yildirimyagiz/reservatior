import { t } from "i18next";
import { useTranslation } from "react-i18next";
import React, { useState } from "react";
import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle, DialogTrigger } from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Progress } from "@/components/ui/progress";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { PlusCircle, Globe, Sparkles, Video, FileText, Zap, ArrowRight, ShieldCheck, TrendingUp, Mic2, Languages, Cpu, BrainCircuit, MessageSquare, PlayCircle, CheckCircle2, Activity, MapPin, Home, DollarSign, Building, Camera } from "lucide-react";
import { motion } from "framer-motion";
import { cn } from "@/lib/utils";
import { propertiesApi } from "@/lib/api/properties";
import { apiClient } from "@/lib/api";
import { useToast } from "@/hooks/use-toast";
import { useNavigate } from "react-router-dom";
export function ListingManagementDialog({
  children
}: {
  children?: React.ReactNode;
}) {
  const {
    t
  } = useTranslation();
  const [syncLink, setSyncLink] = useState("");
  const [externalUrl, setExternalUrl] = useState("");
  const [isSyncing, setIsSyncing] = useState(false);
  const [isImporting, setIsImporting] = useState(false);
  const [showManualForm, setShowManualForm] = useState(false);
  const [isCreating, setIsCreating] = useState(false);
  const {
    toast
  } = useToast();
  const navigate = useNavigate();

  // Manual listing form state
  const [manualListing, setManualListing] = useState({
    name: "",
    type: "",
    addressLine1: "",
    city: "",
    state: "",
    zip: "",
    listingType: "SALE",
    listingPrice: "",
    bedrooms: "",
    bathrooms: "",
    areaSqm: "",
    description: ""
  });
  const handleDriveSync = async () => {
    if (!syncLink) return;
    setIsSyncing(true);
    try {
      // Production: await edenClient.api.v1.skipper.drive.import.post({ drive_links: [syncLink] });
      await new Promise(r => setTimeout(r, 2000));
      console.log("Sync initiated for:", syncLink);
      toast({
        title: t("client.src.neural_sync_started"),
        description: t("client.src.asset_cloud_sync_initiated")
      });
    } catch (error) {
      toast({
        title: t("client.src.sync_failed"),
        description: t("client.src.failed_to_sync_cloud"),
        variant: "destructive"
      });
    } finally {
      setIsSyncing(false);
    }
  };
  const handleExternalImport = async () => {
    if (!externalUrl) return;
    setIsImporting(true);
    try {
      const response = await apiClient.post("/importer/scrape", {
        url: externalUrl,
        userId: ""
      }) as any;
      const data = response;
      const error = !response.success;
      if (error) throw new Error("Harvest node failed to parse URL");
      if (data && (data as any).success) {
        const harvested = (data as any).data;
        // Pre-fill manual form with harvested data
        setManualListing(prev => ({
          ...prev,
          name: harvested.title || "",
          listingPrice: harvested.price?.toString() || "",
          bedrooms: harvested.bedrooms?.toString() || "",
          bathrooms: harvested.bathrooms?.toString() || "",
          areaSqm: harvested.area?.toString() || "",
          description: harvested.description || ""
        }));
        setShowManualForm(true);
        toast({
          title: t("client.src.neural_harvest_complete"),
          description: t("client.src.data_successfully_extracted_from")
        });
      }
    } catch (error) {
      toast({
        title: t("client.src.import_failed"),
        description: t("client.src.could_not_extract_data"),
        variant: "destructive"
      });
    } finally {
      setIsImporting(false);
    }
  };
  const handleManualListing = async () => {
    if (!manualListing.name || !manualListing.addressLine1 || !manualListing.city) {
      toast({
        title: t("client.src.missing_information"),
        description: t("client.src.please_fill_in_required"),
        variant: "destructive"
      });
      return;
    }
    setIsCreating(true);
    try {
      const propertyData = {
        name: manualListing.name,
        type: manualListing.type as any || "APARTMENT",
        addressLine1: manualListing.addressLine1,
        city: manualListing.city,
        state: manualListing.state || "NY",
        zip: manualListing.zip || "10001",
        country: "USA",
        currency: "USD",
        region: "AMERICAS" as any,
        listingType: manualListing.listingType as any,
        listingStatus: "AVAILABLE" as any,
        listingPrice: parseFloat(manualListing.listingPrice) || 0,
        bedrooms: parseInt(manualListing.bedrooms) || 0,
        bathrooms: parseFloat(manualListing.bathrooms) || 0,
        areaSqm: parseFloat(manualListing.areaSqm) || 0,
        notes: manualListing.description,
        lat: 40.7128 + (Math.random() - 0.5) * 0.1,
        lng: -74.0060 + (Math.random() - 0.5) * 0.1,
        accessibilityFeatures: [],
        smartHomeFeatures: [],
        securityFeatures: [],
        outdoorFeatures: [],
        environmentalHazards: []
      };
      const data = await propertiesApi.create({ ...propertyData, orgId: "default" } as any);
      toast({
        title: t("client.src.listing_created_successfully"),
        description: `${propertyData.name} has been added to your portfolio.`
      });

      // Reset form
      setManualListing({
        name: "",
        type: "",
        addressLine1: "",
        city: "",
        state: "",
        zip: "",
        listingType: "SALE",
        listingPrice: "",
        bedrooms: "",
        bathrooms: "",
        areaSqm: "",
        description: ""
      });
      setShowManualForm(false);

      // Navigate to property detail
      if (data && typeof data === 'object' && 'id' in data) {
        navigate(`/property/${(data as any).id}`);
      } else {
        navigate("/properties");
      }
    } catch (error) {
      toast({
        title: t("client.src.creation_failed"),
        description: error instanceof Error ? error.message : "Failed to create listing.",
        variant: "destructive"
      });
    } finally {
      setIsCreating(false);
    }
  };
  return <Dialog>
      <DialogTrigger asChild>
        {children || <Button className="bg-orange-600 hover:bg-orange-500 text-white font-black uppercase tracking-widest text-[10px] gap-2 h-12 px-8 rounded-2xl shadow-xl shadow-orange-600/20 transition-all active:scale-95">
            <PlusCircle className="w-4 h-4" />{t("client.src.launch_neural_listing")}</Button>}
      </DialogTrigger>
      <DialogContent className="sm:max-w-[700px] bg-[#0a0b0d] border-white/5 text-white overflow-hidden p-0 rounded-[40px] shadow-2xl">
        <div className="relative p-10 space-y-10">
          
          {/* Neural Glow Background */}
          <div className="absolute top-0 right-0 w-64 h-64 bg-orange-600/10 rounded-full blur-[100px] pointer-events-none" />
          <div className="absolute bottom-0 left-0 w-48 h-48 bg-blue-600/5 rounded-full blur-[80px] pointer-events-none" />
          
          <DialogHeader className="relative z-10 text-center lg:text-left">
            <div className="flex flex-col lg:flex-row lg:items-center justify-between gap-4 mb-4">
               <div className="space-y-1">
                  <DialogTitle className="text-3xl font-black italic tracking-tighter flex items-center justify-center lg:justify-start gap-3">
                    <BrainCircuit className="w-8 h-8 text-orange-500" />{t("client.src.neural_listing")}<span className="text-orange-500">{t("client.src.wizard")}</span>
                  </DialogTitle>
                  <DialogDescription className="text-slate-500 font-medium italic uppercase tracking-widest text-[10px]">{t("client.src.integrated_ai_intelligence_highfidelity")}</DialogDescription>
               </div>
               <Badge className="bg-orange-600/20 text-orange-400 border-none px-4 py-1.5 font-black italic tracking-widest uppercase text-[9px] w-fit mx-auto lg:mx-0 shadow-lg backdrop-blur-xl">{t("client.src.beta_cloud_burst_ready")}</Badge>
            </div>
          </DialogHeader>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-6 relative z-10">
            
            {/* SERVICE BLOCK: VIDEO PRO */}
            <CardLayout title={t("client.src.cinematic_ai_video")} icon={<PlayCircle className="w-5 h-5" />} color="text-orange-500" badge="PREMIUM">
               <ul className="space-y-3 mt-4">
                  <FeatureItem text="Ultra-HD Video Clarity" included />
                  <FeatureItem text="Automated Mood Audio (MP3)" included />
                  <FeatureItem text="AI Global Subtitles" included />
                  <FeatureItem text="Regional Video Dubbing" included={false} />
               </ul>
            </CardLayout>

            {/* SERVICE BLOCK: TRANSLATION & GEO */}
            <CardLayout title={t("client.src.global_intelligence")} icon={<Languages className="w-5 h-5" />} color="text-blue-500">
               <ul className="space-y-3 mt-4">
                  <FeatureItem text="Neighborhood DNA Report" included />
                  <FeatureItem text="True Comps (Market Price)" included />
                  <FeatureItem text="Auto-Translate Description" included />
                  <FeatureItem text="Legal/Tax Sync (Gov Hub)" included />
               </ul>
            </CardLayout>

            {/* SERVICE BLOCK: MARKETING SYNC */}
            <CardLayout title={t("client.src.viral_orchestration")} icon={<Zap className="w-5 h-5" />} color="text-amber-500">
               <ul className="space-y-3 mt-4">
                  <FeatureItem text="TikTok/Reels Auto-Crop" included />
                  <FeatureItem text="Listing Doping Priority" included />
                  <FeatureItem text="Neural Hub Style Twin" included />
               </ul>
            </CardLayout>

            {/* SERVICE BLOCK: ASSET FLOW */}
            <CardLayout title={t("client.src.processing_power")} icon={<Cpu className="w-5 h-5" />} color="text-violet-500">
               <div className="space-y-4 mt-4">
                  <p className="text-[10px] font-black text-slate-500 uppercase tracking-widest italic leading-tight">{t("client.src.current_processing_health")}</p>
                  <div className="space-y-2">
                     <div className="flex justify-between text-[9px] font-black uppercase italic tracking-widest text-slate-400">
                        <span>{t("client.src.highspeed_node")}</span>
                        <span className="text-emerald-400">{t("client.src.98_efficient")}</span>
                     </div>
                     <Progress value={98} className="h-1 bg-white/5" indicatorClassName="bg-emerald-500" />
                  </div>
                  <div className="space-y-2">
                     <div className="flex justify-between text-[9px] font-black uppercase italic tracking-widest text-slate-400">
                        <span>{t("client.src.ai_engine_assistant")}</span>
                        <span className="text-blue-400">{t("client.src.online")}</span>
                     </div>
                     <Progress value={100} className="h-1 bg-white/5" indicatorClassName="bg-blue-600" />
                  </div>
               </div>
            </CardLayout>
          </div>

          <div className="flex flex-col gap-4 relative z-10 pt-4">
             <div className="flex-1 flex flex-col gap-2">
                <p className="text-[9px] font-black text-slate-500 uppercase tracking-widest italic ml-1">{t("client.src.paste_cloud_link_drivedropboxwetransfer")}</p>
                <div className="flex gap-2">
                   <div className="flex-1 relative">
                      <input value={syncLink} onChange={e => setSyncLink(e.target.value)} placeholder={t("client.src.httpsdrivegooglecom")} className="w-full h-14 rounded-2xl bg-white/5 border border-white/5 px-4 text-xs font-medium focus:border-orange-500/50 outline-hidden transition-all text-slate-300" />
                      <Globe className="absolute right-4 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-600" />
                   </div>
                   <Button onClick={handleDriveSync} disabled={!syncLink || isSyncing} className="h-14 px-6 rounded-2xl bg-blue-600 hover:bg-blue-500 text-white font-black uppercase text-[10px] tracking-widest disabled:opacity-50">
                     {isSyncing ? <Activity className="w-4 h-4 animate-spin" /> : "SYNC ASSETS"}
                   </Button>
                </div>
             </div>

             <div className="flex-1 flex flex-col gap-2">
                <p className="text-[9px] font-black text-slate-500 uppercase tracking-widest italic ml-1">{t("client.src.portal_oneclick_import_sahibindenzillowemlakjet")}</p>
                <div className="flex gap-2">
                   <div className="flex-1 relative">
                      <input value={externalUrl} onChange={e => setExternalUrl(e.target.value)} placeholder={t("client.src.paste_listing_url_here")} className="w-full h-14 rounded-2xl bg-white/5 border border-white/5 px-4 text-xs font-medium focus:border-emerald-500/50 outline-hidden transition-all text-slate-300" />
                      <Zap className="absolute right-4 top-1/2 -translate-y-1/2 w-4 h-4 text-emerald-500" />
                   </div>
                   <Button onClick={handleExternalImport} disabled={!externalUrl || isImporting} className="h-14 px-6 rounded-2xl bg-emerald-600 hover:bg-emerald-500 text-white font-black uppercase text-[10px] tracking-widest disabled:opacity-50">
                     {isImporting ? <Activity className="w-4 h-4 animate-spin" /> : "NEURAL HARVEST"}
                   </Button>
                </div>
             </div>
             
             <div className="h-px bg-white/5 my-2 md:hidden" />

             <Button onClick={() => setShowManualForm(true)} className="flex-1 h-16 rounded-2xl bg-orange-600 hover:bg-orange-500 text-white font-black uppercase tracking-widest text-xs shadow-2xl shadow-orange-600/30 gap-3 group">
                <PlusCircle className="w-5 h-5 group-hover:rotate-90 transition-all duration-500" />{t("client.src.manual_listing")}</Button>
          </div>

          {showManualForm && <div className="space-y-6 relative z-10 pt-4 border-t border-white/5">
              <div className="flex items-center justify-between">
                <h3 className="text-xl font-black text-white italic tracking-tighter">{t("client.src.create_property_listing")}</h3>
                <Button variant="ghost" size="sm" onClick={() => setShowManualForm(false)} className="text-slate-400 hover:text-white">{t("client.src.cancel")}</Button>
              </div>
              
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div className="space-y-2">
                  <label className="text-[10px] font-black text-slate-500 uppercase tracking-widest">{t("client.src.property_name")}</label>
                  <Input value={manualListing.name} onChange={e => setManualListing(prev => ({
                ...prev,
                name: e.target.value
              }))} placeholder={t("client.src.luxury_downtown_apartment")} className="bg-white/5 border-white/5 text-white" />
                </div>
                
                <div className="space-y-2">
                  <label className="text-[10px] font-black text-slate-500 uppercase tracking-widest">{t("client.src.property_type")}</label>
                  <Select value={manualListing.type} onValueChange={value => setManualListing(prev => ({
                ...prev,
                type: value
              }))}>
                    <SelectTrigger className="bg-white/5 border-white/5 text-white">
                      <SelectValue placeholder={t("client.src.select_type")} />
                    </SelectTrigger>
                    <SelectContent className="bg-[#14151a] border-white/5">
                      <SelectItem value="APARTMENT">{t("client.src.apartment")}</SelectItem>
                      <SelectItem value="HOUSE">{t("client.src.house")}</SelectItem>
                      <SelectItem value="VILLA">{t("client.src.villa")}</SelectItem>
                      <SelectItem value="COMMERCIAL">{t("client.src.commercial")}</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
                
                <div className="space-y-2">
                  <label className="text-[10px] font-black text-slate-500 uppercase tracking-widest">{t("client.src.address_line_1")}</label>
                  <Input value={manualListing.addressLine1} onChange={e => setManualListing(prev => ({
                ...prev,
                addressLine1: e.target.value
              }))} placeholder={t("client.src.123_main_street")} className="bg-white/5 border-white/5 text-white" />
                </div>
                
                <div className="space-y-2">
                  <label className="text-[10px] font-black text-slate-500 uppercase tracking-widest">{t("client.src.city")}</label>
                  <Input value={manualListing.city} onChange={e => setManualListing(prev => ({
                ...prev,
                city: e.target.value
              }))} placeholder={t("client.src.new_york")} className="bg-white/5 border-white/5 text-white" />
                </div>
                
                <div className="space-y-2">
                  <label className="text-[10px] font-black text-slate-500 uppercase tracking-widest">{t("client.src.state")}</label>
                  <Input value={manualListing.state} onChange={e => setManualListing(prev => ({
                ...prev,
                state: e.target.value
              }))} placeholder={t("client.src.ny")} className="bg-white/5 border-white/5 text-white" />
                </div>
                
                <div className="space-y-2">
                  <label className="text-[10px] font-black text-slate-500 uppercase tracking-widest">{t("client.src.zip_code")}</label>
                  <Input value={manualListing.zip} onChange={e => setManualListing(prev => ({
                ...prev,
                zip: e.target.value
              }))} placeholder="10001" className="bg-white/5 border-white/5 text-white" />
                </div>
                
                <div className="space-y-2">
                  <label className="text-[10px] font-black text-slate-500 uppercase tracking-widest">{t("client.src.listing_type")}</label>
                  <Select value={manualListing.listingType} onValueChange={value => setManualListing(prev => ({
                ...prev,
                listingType: value
              }))}>
                    <SelectTrigger className="bg-white/5 border-white/5 text-white">
                      <SelectValue placeholder={t("client.src.select_type")} />
                    </SelectTrigger>
                    <SelectContent className="bg-[#14151a] border-white/5">
                      <SelectItem value="SALE">{t("client.src.for_sale")}</SelectItem>
                      <SelectItem value="RENT">{t("client.src.for_rent")}</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
                
                <div className="space-y-2">
                  <label className="text-[10px] font-black text-slate-500 uppercase tracking-widest">{t("client.src.price")}</label>
                  <Input type="number" value={manualListing.listingPrice} onChange={e => setManualListing(prev => ({
                ...prev,
                listingPrice: e.target.value
              }))} placeholder="500000" className="bg-white/5 border-white/5 text-white" />
                </div>
                
                <div className="space-y-2">
                  <label className="text-[10px] font-black text-slate-500 uppercase tracking-widest">{t("client.src.bedrooms")}</label>
                  <Input type="number" value={manualListing.bedrooms} onChange={e => setManualListing(prev => ({
                ...prev,
                bedrooms: e.target.value
              }))} placeholder="3" className="bg-white/5 border-white/5 text-white" />
                </div>
                
                <div className="space-y-2">
                  <label className="text-[10px] font-black text-slate-500 uppercase tracking-widest">{t("client.src.bathrooms")}</label>
                  <Input type="number" step="0.5" value={manualListing.bathrooms} onChange={e => setManualListing(prev => ({
                ...prev,
                bathrooms: e.target.value
              }))} placeholder="2.5" className="bg-white/5 border-white/5 text-white" />
                </div>
                
                <div className="space-y-2">
                  <label className="text-[10px] font-black text-slate-500 uppercase tracking-widest">{t("client.src.area_sqm")}</label>
                  <Input type="number" value={manualListing.areaSqm} onChange={e => setManualListing(prev => ({
                ...prev,
                areaSqm: e.target.value
              }))} placeholder="120" className="bg-white/5 border-white/5 text-white" />
                </div>
                
                <div className="space-y-2 md:col-span-2">
                  <label className="text-[10px] font-black text-slate-500 uppercase tracking-widest">{t("client.src.description")}</label>
                  <Textarea value={manualListing.description} onChange={e => setManualListing(prev => ({
                ...prev,
                description: e.target.value
              }))} placeholder={t("client.src.beautiful_property_with_modern")} className="bg-white/5 border-white/5 text-white min-h-[100px]" />
                </div>
              </div>
              
              <Button onClick={handleManualListing} disabled={isCreating} className="w-full h-14 rounded-2xl bg-emerald-600 hover:bg-emerald-500 text-white font-black uppercase tracking-widest text-xs shadow-2xl shadow-emerald-600/30">
                {isCreating ? <>
                    <Activity className="w-4 h-4 animate-spin mr-2" />{t("client.src.creating_listing")}</> : <>
                    <PlusCircle className="w-4 h-4 mr-2" />{t("client.src.create_property_listing")}</>}
              </Button>
            </div>}

          <p className="text-center text-[10px] text-slate-600 font-bold uppercase tracking-[0.3em] italic">{t("client.src.list_in_300_seconds")}</p>
        </div>
      </DialogContent>
    </Dialog>;
}
function CardLayout({
  title,
  icon,
  color,
  badge,
  children
}: {
  title: string;
  icon: React.ReactNode;
  color: string;
  badge?: string;
  children: React.ReactNode;
}) {
  return <motion.div whileHover={{
    scale: 1.02
  }} className="p-6 bg-[#14151a]/40 border border-white/5 rounded-3xl relative overflow-hidden group">
      <div className="flex items-center justify-between mb-2">
         <div className={cn("p-2.5 bg-white/5 rounded-xl transition-all group-hover:scale-110", color)}>
            {icon}
         </div>
         {badge && <Badge className="bg-orange-600 text-white text-[8px] font-black italic border-none h-5 px-2">{badge}</Badge>}
      </div>
      <h3 className="font-black text-sm italic tracking-tighter text-white">{title}</h3>
      {children}
    </motion.div>;
}
function FeatureItem({
  text,
  included
}: {
  text: string;
  included: boolean;
}) {
  return <li className="flex items-center gap-3 text-[10px] font-medium italic tracking-tight">
       {included ? <CheckCircle2 className="w-3.5 h-3.5 text-emerald-500" /> : <Zap className="w-3.5 h-3.5 text-slate-800" />}
       <span className={cn(included ? "text-slate-300" : "text-slate-700")}>{text}</span>
    </li>;
}