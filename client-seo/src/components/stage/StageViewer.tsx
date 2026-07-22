import Image from "next/image";
import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { m, AnimatePresence } from "framer-motion";
import { MapPin, Bed, Bath, Square, Share2, Heart, PlayCircle, Image as ImageIcon, FileText, Download, Calendar, ChevronRight, Languages, QrCode, Copy, Sofa, Camera, Loader2, Play, X } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription, DialogFooter } from "@/components/ui/dialog";
import { useLanguage } from "@/lib/languages";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { Switch } from "@/components/ui/switch";
import { toast } from "@/components/hooks/use-toast";
import { Property } from "@/lib/api/properties";
interface StageViewerProps {
  property: Property;
}
export function StageViewer({
  property
}: StageViewerProps) {
  const {
    t
  } = useTranslation();
  const [activeTab, setActiveTab] = useState<"photos" | "video" | "floorplan">("photos");
  const [lightboxOpen, setLightboxOpen] = useState(false);
  const [shareOpen, setShareOpen] = useState(false);
  const [contactOpen, setContactOpen] = useState(false);
  const [isStaged, setIsStaged] = useState(true);
  const [isExtracting, setIsExtracting] = useState(false);
  const [isVideoPlaying, setIsVideoPlaying] = useState(false);
  const {
    currentLang
  } = useLanguage();
  const tabs = [{
    id: "photos",
    label: t("client.src.photos"),
    icon: ImageIcon
  }, {
    id: "video",
    label: t("client.src.ai_walkthrough"),
    icon: PlayCircle
  }, {
    id: "floorplan",
    label: t("client.src.floorplan"),
    icon: FileText
  }] as const;
  const handleCopyLink = () => {
    navigator.clipboard.writeText(`https://stage.ai/s/${property.id}`);
    toast({
      title: t("client.src.link_copied"),
      description: t("client.src.stage_link_copied_to")
    });
  };
  const handleContactSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    setContactOpen(false);
    toast({
      title: t("client.src.message_sent"),
      description: t("client.src.the_agent_will_contact")
    });
  };
  const handleExtractPhotos = () => {
    setIsExtracting(true);
    setTimeout(() => {
      setIsExtracting(false);
      setActiveTab("photos");
      toast({
        title: t("client.src.photos_extracted"),
        description: t("client.src.5_highquality_frames_have")
      });
    }, 2000);
  };
  return <>
      <div className="min-h-screen bg-background pt-20 pb-10 px-4 md:px-6">
        <div className="max-w-7xl mx-auto grid grid-cols-1 lg:grid-cols-12 gap-8">
          {/* Main Content Area (Left) */}
          <div className="lg:col-span-8 space-y-6">
            {/* Header */}
            <div className="flex flex-col md:flex-row md:items-end justify-between gap-4">
              <div>
                <div className="flex items-center gap-2 mb-2">
                  <Badge variant="outline" className="bg-primary/10 text-primary border-primary/20">
                    {property.type}
                  </Badge>
                  <Badge variant="outline" className="text-muted-foreground">
                    {property.region}
                  </Badge>
                </div>
                <h1 className="text-3xl md:text-4xl font-display font-bold text-foreground">
                  {property.name}
                </h1>
                <div className="flex items-center text-muted-foreground mt-2">
                  <MapPin className="h-4 w-4 mr-1" />
                  {property.addressLine1}
                </div>
              </div>
              <div className="flex gap-2">
                <Button variant="outline" size="icon" className="rounded-full" onClick={() => setShareOpen(true)}>
                  <Share2 className="h-4 w-4" />
                </Button>
                <Button variant="outline" size="icon" className="rounded-full">
                  <Heart className="h-4 w-4" />
                </Button>
              </div>
            </div>

            {/* Media Viewer */}
            <div className="bg-card border border-border rounded-3xl overflow-hidden shadow-2xl relative min-h-[500px] flex flex-col">
              {/* Tab Controls */}
              <div className="absolute top-4 left-4 z-20 flex gap-2 p-1 bg-black/40 backdrop-blur-md rounded-full border border-white/10 overflow-x-auto max-w-[calc(100%-100px)]">
                {tabs.map(tab => <button key={tab.id} onClick={() => {
                setActiveTab(tab.id);
                setIsVideoPlaying(false);
              }} className={`
                    px-4 py-2 rounded-full text-sm font-medium transition-all flex items-center gap-2 whitespace-nowrap
                    ${activeTab === tab.id ? "bg-white text-black shadow-lg scale-105" : "text-white/70 hover:text-white hover:bg-white/10"}
                  `}>
                    <tab.icon className="h-4 w-4" />
                    <span className="hidden sm:inline">{tab.label}</span>
                  </button>)}
              </div>

              {/* Top Right Controls */}
              <div className="absolute top-4 right-4 z-20 flex flex-col gap-2 items-end">
                <div className="px-3 py-1.5 rounded-full bg-black/40 backdrop-blur-md border border-white/10 text-xs font-medium text-white/90 flex items-center gap-2">
                  <Languages className="w-3 h-3 text-purple-400" />
                  {currentLang.code.toUpperCase()}
                </div>

                {activeTab === "photos" && <div className="px-3 py-1.5 rounded-full bg-black/40 backdrop-blur-md border border-white/10 text-xs font-medium text-white/90 flex items-center gap-2">
                    <Sofa className="w-3 h-3 text-blue-400" />
                    <span className="hidden sm:inline">{t("client.src.virtual_staging")}</span>
                    <Switch checked={isStaged} onCheckedChange={setIsStaged} className="scale-75 data-[state=checked]:bg-blue-500" />
                  </div>}
              </div>

              {/* Content Display */}
              <div className="flex-1 bg-zinc-900 relative">
                <AnimatePresence mode="wait">
                  {activeTab === "photos" && <m.div key="photos" initial={{
                  opacity: 0
                }} animate={{
                  opacity: 1
                }} exit={{
                  opacity: 0
                }} className="absolute inset-0 grid grid-cols-2 md:grid-cols-4 grid-rows-2 gap-1 p-1">
                      {/* Hero Image */}
                      <div className="col-span-2 row-span-2 relative group cursor-pointer overflow-hidden rounded-tl-2xl rounded-bl-2xl bg-gradient-to-br from-blue-100 to-blue-200 flex items-center justify-center" onClick={() => setLightboxOpen(true)}>
                        <Camera className="w-16 h-16 text-blue-600" />
                        <div className="absolute inset-0 bg-black/0 group-hover:bg-black/10 transition-colors" />
                        {!isStaged && <div className="absolute bottom-4 left-4 bg-black/60 px-2 py-1 rounded text-white text-xs">{t("client.src.unstaged_view")}</div>}
                      </div>

                      {/* Secondary Images */}
                      {[1, 2, 3, 4].map(idx => <div key={idx} className={`relative group cursor-pointer overflow-hidden bg-gradient-to-br from-blue-50 to-blue-100 flex items-center justify-center ${idx === 1 ? "rounded-tr-2xl" : ""} ${idx === 3 ? "rounded-br-2xl" : ""}`} onClick={() => setLightboxOpen(true)}>
                          <Camera className="w-8 h-8 text-blue-500" />
                          <div className="absolute inset-0 bg-black/0 group-hover:bg-black/10 transition-colors" />
                        </div>)}
                    </m.div>}

                  {activeTab === "video" && <m.div key="video" initial={{
                  opacity: 0
                }} animate={{
                  opacity: 1
                }} exit={{
                  opacity: 0
                }} className="absolute inset-0 flex items-center justify-center bg-zinc-950 overflow-hidden">
                      {isVideoPlaying ? <div className="relative w-full h-full">
                          <div className="absolute inset-0 bg-black flex items-center justify-center">
                            <span className="text-white/50 animate-pulse">{t("client.src.playing_ai_walkthrough")}</span>
                          </div>
                          {/* Placeholder for video element */}
                          <Image src="/api/placeholder/400/300" alt={t("client.src.video_placeholder")} fill className="object-cover opacity-50 blur-sm animate-pulse" loading="lazy" sizes="(max-width: 768px) 100vw, 50vw" />

                          {/* Controls Overlay */}
                          <div className="absolute bottom-0 inset-x-0 p-6 bg-gradient-to-t from-black/80 to-transparent">
                            <div className="h-1 bg-white/30 rounded-full mb-4 overflow-hidden">
                              <div className="h-full bg-primary w-1/3 animate-shimmer" />
                            </div>
                            <div className="flex justify-between items-center text-white">
                              <span className="text-sm font-medium">
                                0:15 / 1:30
                              </span>
                              <Button size="sm" variant="ghost" className="text-white" onClick={() => setIsVideoPlaying(false)}>{t("client.src.exit_preview")}</Button>
                            </div>
                          </div>
                        </div> : <div className="text-center space-y-4 relative z-10">
                          <div className="w-20 h-20 rounded-full bg-primary/20 flex items-center justify-center mx-auto animate-pulse">
                            <PlayCircle className="w-10 h-10 text-primary" />
                          </div>
                          <h3 className="text-xl font-medium text-white">{t("client.src.ai_walkthrough_ready")}</h3>
                          <p className="text-muted-foreground max-w-md mx-auto px-4">{t("client.src.our_ai_has_generated")}</p>
                          <div className="flex gap-2 justify-center">
                            <Button className="rounded-full px-6" onClick={() => setIsVideoPlaying(true)}>
                              <Play className="w-4 h-4 mr-2" />{t("client.src.play_video")}</Button>
                            <Button variant="outline" className="rounded-full px-6" onClick={handleExtractPhotos} disabled={isExtracting}>
                              {isExtracting ? <>
                                  <Loader2 className="w-4 h-4 mr-2 animate-spin" />{" "}{t("client.src.extracting")}</> : <>
                                  <Camera className="w-4 h-4 mr-2" />{t("client.src.extract_photos")}</>}
                            </Button>
                          </div>
                        </div>}

                      {/* Background Blur for Video Tab */}
                      {!isVideoPlaying && <div className="absolute inset-0 opacity-20 blur-xl pointer-events-none">
                          <Image src="/api/placeholder/400/300" alt="" fill className="object-cover" loading="lazy" sizes="(max-width: 768px) 100vw, 50vw" />
                        </div>}
                    </m.div>}

                  {activeTab === "floorplan" && <m.div key="floorplan" initial={{
                  opacity: 0
                }} animate={{
                  opacity: 1
                }} exit={{
                  opacity: 0
                }} className="absolute inset-0 flex items-center justify-center bg-white/5">
                      <div className="text-center text-muted-foreground">
                        <FileText className="w-16 h-16 mx-auto mb-4 opacity-50" />
                        <p>{t("client.src.floorplan_document_preview")}</p>
                      </div>
                    </m.div>}
                </AnimatePresence>
              </div>
            </div>

            {/* Description & Features */}
            <div className="grid md:grid-cols-3 gap-8 pt-4">
              <div className="md:col-span-2 space-y-6">
                <div>
                  <h2 className="text-2xl font-display font-bold mb-4">{t("client.src.about_this_home")}</h2>
                  <p className="text-muted-foreground leading-relaxed">
                    {property.notes || "No description available for this property."}
                  </p>
                </div>

                <div>
                  <h3 className="text-lg font-semibold mb-3">{t("client.src.property_details")}</h3>
                  <div className="flex flex-wrap gap-2">
                    {property.yearBuilt && <Badge variant="secondary" className="px-3 py-1 text-sm font-normal">{t("client.src.built")}{property.yearBuilt}
                      </Badge>}
                    {property.bedrooms && <Badge variant="secondary" className="px-3 py-1 text-sm font-normal">
                        {property.bedrooms}{t("client.src.beds")}</Badge>}
                    {property.bathrooms && <Badge variant="secondary" className="px-3 py-1 text-sm font-normal">
                        {property.bathrooms}{t("client.src.baths")}</Badge>}
                    {property.areaSqm && <Badge variant="secondary" className="px-3 py-1 text-sm font-normal">
                        {Math.round(property.areaSqm * 10.764)}{t("client.src.sqft")}</Badge>}
                    {property.areaSqm && <Badge variant="secondary" className="px-3 py-1 text-sm font-normal">
                        {property.areaSqm}{t("client.src.m")}</Badge>}
                  </div>
                </div>
              </div>
            </div>

            <div className="bg-card/50 border border-border rounded-xl p-6 space-y-4">
              <h3 className="font-semibold mb-2">{t("client.src.downloads")}</h3>
              <Button variant="outline" className="w-full justify-between group">
                <span>{t("client.src.brochure_pdf")}</span>
                <Download className="w-4 h-4 opacity-50 group-hover:opacity-100 transition-opacity" />
              </Button>
              <Button variant="outline" className="w-full justify-between group">
                <span>{t("client.src.photo_pack_high_res")}</span>
                <Download className="w-4 h-4 opacity-50 group-hover:opacity-100 transition-opacity" />
              </Button>
            </div>
          </div>
        </div>

        {/* Sidebar (Right) */}
        <div className="lg:col-span-4 space-y-6">
          {/* Price Card */}
          <div className="bg-card border border-border rounded-2xl p-6 shadow-xl sticky top-24">
            <div className="mb-6">
              <p className="text-sm text-muted-foreground mb-1">{t("client.src.listing_price")}</p>
              <h2 className="text-4xl font-display font-bold text-primary">{t("client.src.contact_for_pricing")}</h2>
            </div>

            <div className="grid grid-cols-3 gap-4 mb-8">
              <div className="text-center p-3 bg-secondary/50 rounded-xl">
                <Bed className="w-5 h-5 mx-auto mb-1 text-primary" />
                <span className="text-sm font-medium">
                  {property.bedrooms || "—"}{t("client.src.beds")}</span>
              </div>
              <div className="text-center p-3 bg-secondary/50 rounded-xl">
                <Bath className="w-5 h-5 mx-auto mb-1 text-primary" />
                <span className="text-sm font-medium">
                  {property.bathrooms || "—"}{t("client.src.baths")}</span>
              </div>
              <div className="text-center p-3 bg-secondary/50 rounded-xl">
                <Square className="w-5 h-5 mx-auto mb-1 text-primary" />
                <span className="text-sm font-medium">
                  {property.areaSqm ? `${Math.round(property.areaSqm * 10.764)}` : "—"}{" "}{t("client.src.sqft")}</span>
              </div>
            </div>

            <div className="space-y-3">
              <Button className="w-full h-12 text-base rounded-xl bg-primary hover:bg-primary/90 text-primary-foreground font-semibold shadow-lg shadow-primary/20" onClick={() => setContactOpen(true)}>{t("client.src.schedule_viewing")}</Button>
              <Button variant="outline" className="w-full h-12 text-base rounded-xl border-primary/20 hover:bg-primary/5" onClick={() => setContactOpen(true)}>{t("client.src.contact_agent")}</Button>
            </div>

            {/* Open House Mock */}
            <div className="mt-6 pt-6 border-t border-border">
              <h4 className="font-semibold text-sm mb-3 flex items-center gap-2">
                <Calendar className="w-4 h-4 text-purple-400" />{t("client.src.upcoming_open_houses")}</h4>
              <div className="space-y-2">
                <div className="flex justify-between items-center text-sm p-2 rounded bg-secondary/30">
                  <span className="text-muted-foreground">{t("client.src.sat_dec_20")}</span>
                  <span className="font-medium">{t("client.src.1000_am_200_pm")}</span>
                </div>
                <div className="flex justify-between items-center text-sm p-2 rounded bg-secondary/30">
                  <span className="text-muted-foreground">{t("client.src.sun_dec_21")}</span>
                  <span className="font-medium">{t("client.src.100_pm_400_pm")}</span>
                </div>
              </div>
            </div>

            <div className="mt-6 pt-6 border-t border-border">
              <div className="flex items-center gap-4">
                <div className="w-12 h-12 rounded-full bg-primary/20 flex items-center justify-center">
                  <Camera className="w-6 h-6 text-primary" />
                </div>
                <div>
                  <p className="font-semibold">{t("client.src.property_manager")}</p>
                  <p className="text-sm text-muted-foreground">{t("client.src.contact_for_details")}</p>
                </div>
                <Button variant="ghost" size="icon" className="ml-auto rounded-full">
                  <ChevronRight className="w-5 h-5 text-muted-foreground" />
                </Button>
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* Lightbox Dialog */}
      <Dialog open={lightboxOpen} onOpenChange={setLightboxOpen}>
        <DialogContent className="max-w-7xl w-[95vw] h-[90vh] p-0 border-none bg-black/95">
          <div className="w-full h-full flex items-center justify-center relative bg-gradient-to-br from-blue-100 to-blue-200">
            <Camera className="w-16 h-16 text-blue-600" />
            <Button variant="ghost" size="icon" className="absolute top-4 right-4 text-white hover:bg-white/20 rounded-full" onClick={() => setLightboxOpen(false)}>
              <span className="sr-only">{t("client.src.close")}</span>
              <X className="w-6 h-6" />
            </Button>
          </div>
        </DialogContent>
      </Dialog>

      {/* Share Dialog */}
      <Dialog open={shareOpen} onOpenChange={setShareOpen}>
        <DialogContent className="sm:max-w-md">
          <DialogHeader>
            <DialogTitle>{t("client.src.share_this_stage")}</DialogTitle>
            <DialogDescription>{t("client.src.share_this_property_with")}</DialogDescription>
          </DialogHeader>
          <div className="flex items-center space-x-2">
            <div className="grid flex-1 gap-2">
              <Label htmlFor="link" className="sr-only">{t("client.src.link")}</Label>
              <Input id="link" defaultValue={`https://stage.ai/s/${property.id}`} readOnly />
            </div>
            <Button type="submit" size="sm" className="px-3" onClick={handleCopyLink}>
              <span className="sr-only">{t("client.src.copy")}</span>
              <Copy className="h-4 w-4" />
            </Button>
          </div>
          <div className="flex justify-center py-4">
            <div className="bg-white p-4 rounded-xl">
              <QrCode className="w-32 h-32 text-black" />
            </div>
          </div>
          <div className="text-center text-xs text-muted-foreground">{t("client.src.scan_to_view_on")}</div>
        </DialogContent>
      </Dialog>

      {/* Contact Dialog */}
      <Dialog open={contactOpen} onOpenChange={setContactOpen}>
        <DialogContent className="sm:max-w-md">
          <DialogHeader>
            <DialogTitle>{t("client.src.contact_property_manager")}</DialogTitle>
            <DialogDescription>{t("client.src.send_a_message_about")}</DialogDescription>
          </DialogHeader>
          <form onSubmit={handleContactSubmit} className="space-y-4 py-2">
            <div className="grid gap-2">
              <Label htmlFor="name">{t("client.src.your_name")}</Label>
              <Input id="name" placeholder={t("client.src.john_doe")} required />
            </div>
            <div className="grid gap-2">
              <Label htmlFor="email">{t("client.src.email")}</Label>
              <Input id="email" type="email" placeholder={t("client.src.johnexamplecom")} required />
            </div>
            <div className="grid gap-2">
              <Label htmlFor="phone">{t("client.src.phone_optional")}</Label>
              <Input id="phone" type="tel" placeholder="+1 (555) 000-0000" />
            </div>
            <div className="grid gap-2">
              <Label htmlFor="message">{t("client.src.message")}</Label>
              <Textarea id="message" placeholder={t("client.src.im_interested_in_viewing")} defaultValue={`Hi, I'm interested in ${property.name}.`} required />
            </div>
            <DialogFooter>
              <Button type="submit" className="w-full">{t("client.src.send_message")}</Button>
            </DialogFooter>
          </form>
        </DialogContent>
      </Dialog>
    </>;
}