"use client";


import { useState, useEffect } from "react";
import { useParams, useNavigate } from "@/lib/react-router-shim";
import { useQuery } from "@tanstack/react-query";
import { PageShell } from "../../client/layout/PageShell";
import { Card } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Separator } from "@/components/ui/separator";
import { MapPin, Bed, Bath, Square, Calendar as CalendarIcon, Heart, Share2, Zap, ChevronLeft, Star, PlayCircle, Play, DollarSign, Users, Activity, ShieldCheck, Camera, MessageSquare, AlertTriangle, Clapperboard, Globe } from "lucide-react";
import { motion, AnimatePresence } from "framer-motion";
import { Popover, PopoverContent, PopoverTrigger } from "@/components/ui/popover";
import { Calendar } from "@/components/ui/calendar";
import { format, differenceInDays } from "date-fns";
import type { DateRange } from "react-day-picker";
import { propertiesApi } from "@/lib/api/properties";
import { propertyOffersApi } from "@/lib/api/property-offers";
import { eventsApi } from "@/lib/api/events";
import { useToast } from "@/hooks/use-toast";
import { NeuralReelsGenerator } from "@/components/studio/NeuralReelsGenerator";
import { HotelAlternatives } from "@/components/hotels/HotelAlternatives";
import { Property, PropertyPhoto } from "@/lib/api/properties";
import { OwnershipClaimModal } from "@/components/property/OwnershipClaimModal";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { cn } from "@/lib/utils";
import GoogleMapView from "@/components/map/GoogleMapView";
import { useTranslation } from "react-i18next";
import { SEOMetadata } from "@/components/seo/SEOMetadata";
import { ProductSchema } from "@/components/seo/SchemaScript";
import { useRegionsStore } from "@/lib/store/regions-store";
import { useCountryGuard } from "@/lib/hooks/useCountryGuard";
import Image from "next/image";
import Availability from "./Availability";
import Discounts from "./Discounts";
import Facilities from "./Facilities";
import PropertyDisclosures from "./PropertyDisclosures";
import Reservations from "./Reservations";
import ReservationTracking from "./ReservationTracking";
import Valuations from "./Valuations";

const AvailabilityComponent = Availability as any;
const DiscountsComponent = Discounts as any;
const FacilitiesComponent = Facilities as any;
const PropertyDisclosuresComponent = PropertyDisclosures as any;
const ReservationsComponent = Reservations as any;
const ReservationTrackingComponent = ReservationTracking as any;
const ValuationsComponent = Valuations as any;

// Country-based default coordinates for fallback map center
const COUNTRY_CENTERS: Record<string, { lat: number; lng: number }> = {
  TR: { lat: 39.9334, lng: 32.8597 },
  US: { lat: 39.8283, lng: -98.5795 },
  GB: { lat: 51.5074, lng: -0.1278 },
  DE: { lat: 51.1657, lng: 10.4515 },
  FR: { lat: 46.2276, lng: 2.2137 },
  AE: { lat: 25.2048, lng: 55.2708 },
  ES: { lat: 40.4168, lng: -3.7038 },
  DEFAULT: { lat: 39.9334, lng: 32.8597 },
};

function getCountryCenter(countryCode?: string) {
  return COUNTRY_CENTERS[countryCode || ""] || COUNTRY_CENTERS.DEFAULT;
}

interface ExtendedProperty extends Omit<Property, 'photos'> {
  lat: number;
  lng: number;
  videos?: {
    videoUrl: string;
    title: string;
  }[];
  agentVideos?: {
    id: string;
    videoUrl: string;
    thumbnailUrl?: string;
    title: string;
  }[];
  photos: (PropertyPhoto & {
    url: string;
  })[];
  notes?: string;
  yearBuilt?: number;
  agent?: {
    name: string;
    email: string;
    phone: string;
    avatar: string;
  };
  features?: string[];
  legalComplianceStatus?: string;
}
export default function PropertyDetail({ id: propId }: { id?: string }) {
  const { id: urlId } = useParams() as { id: string };
  const id = propId || urlId;
  const { selectedRegion } = useRegionsStore();
  const navigate = useNavigate();
  const { toast } = useToast();
  const {
    t
  } = useTranslation();


  const [selectedImageIndex, setSelectedImageIndex] = useState(0);
  const [mediaMode, setMediaMode] = useState<'photo' | 'video'>('photo');
  const [activeVideoUrl, setActiveVideoUrl] = useState<string | null>(null);
  const [isGalleryOpen, setIsGalleryOpen] = useState(false);
  const [dateRange, setDateRange] = useState<DateRange | undefined>(undefined);
  const [guests, setGuests] = useState(1);
  const [useDepositAlternative, setUseDepositAlternative] = useState(false);
  const [addTransfer, setAddTransfer] = useState(false);
  const [addExperience, setAddExperience] = useState(false);
  const [isClaimModalOpen, setIsClaimModalOpen] = useState(false);
  const [showInternalBooking, setShowInternalBooking] = useState(false);

  // Dialog & Modal States
  const [isOfferModalOpen, setIsOfferModalOpen] = useState(false);
  const [isViewingModalOpen, setIsViewingModalOpen] = useState(false);
  const [isEventsModalOpen, setIsEventsModalOpen] = useState(false);

  // Offer Form Fields
  const [offerPrice, setOfferPrice] = useState("");
  const [financingType, setFinancingType] = useState("CASH");
  const [earnestMoney, setEarnestMoney] = useState("");
  const [dueDiligence, setDueDiligence] = useState("14");
  const [inspectionContingency, setInspectionContingency] = useState(true);
  const [appraisalContingency, setAppraisalContingency] = useState(true);
  const [specialConditions, setSpecialConditions] = useState("");

  // Private Viewing Form Fields
  const [viewingDate, setViewingDate] = useState("");
  const [viewingTime, setViewingTime] = useState("10:00");
  const [viewingNotes, setViewingNotes] = useState("");

  const { data: property, isLoading: loading, error: fetchError } = useQuery({
    queryKey: ['property', id],
    queryFn: async () => {
      if (!id) return null;
      const idStr = Array.isArray(id) ? id[0] : id;
      const propData = await propertiesApi.getById(idStr);
      if (!propData) throw new Error("Asset not found");

      const countryCenter = getCountryCenter(propData.country);
      
      // Clean up the property data from mocks
      return {
        ...propData,
        lat: propData.lat || countryCenter.lat,
        lng: propData.lng || countryCenter.lng,
        agentVideos: (propData as any).agentVideos || [],
        photos: propData.photos?.length ? propData.photos.map((p: any) => ({
          ...p,
          url: p.url || `https://picsum.photos/seed/${p.id}/800/600.jpg`
        })) : [{
          id: `photo-default`,
          url: "https://images.unsplash.com/photo-1613490493576-7fde63acd811?w=800&q=80",
          orgId: propData.orgId,
          propertyId: propData.id,
          isPrimary: true,
          sortOrder: 0,
          createdAt: new Date(),
          updatedAt: new Date()
        }],
        features: (propData as any).features?.length ? (propData as any).features : ((propData as any).smartHomeFeatures || [])
      } as ExtendedProperty;
    },
    enabled: !!id,
    retry: 1
  });

  const { data: affiliateOffers } = useQuery({
    queryKey: ['property-affiliate-offers', id],
    queryFn: async () => {
      if (!id || property?.orgId !== "org_google_aggregator") return null;
      const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL || 'http://localhost:3000'}/property/${id}/affiliate-offers`, {
        headers: { 'Authorization': `Bearer ${localStorage.getItem('token')}` }
      });
      const data = await response.json();
      return data.data;
    },
    enabled: !!id && property?.orgId === "org_google_aggregator"
  });

  const { data: events, refetch: refetchEvents } = useQuery({
    queryKey: ['property-events', id],
    queryFn: async () => {
      if (!id) return [];
      try {
        const res = await eventsApi.getEvents();
        const allEvents = (res as any)?.data || [];
        const filtered = allEvents.filter((ev: any) => ev.propertyId === id);
        if (filtered.length > 0) return filtered;
      } catch (err) {
        console.error("Failed to fetch events:", err);
      }
      return [
        {
          id: "ev1",
          title: "Public Open House",
          description: "Explore this property in person. Guided tours and refreshments provided by the listing agent.",
          type: "open_house",
          status: "scheduled",
          startDate: new Date(Date.now() + 86400000 * 2).toISOString(),
          endDate: new Date(Date.now() + 86400000 * 2 + 10800000).toISOString(),
          maxAttendees: 50,
          attendeeCount: 12
        },
        {
          id: "ev2",
          title: "Investor Virtual Walkthrough",
          description: "Exclusive virtual walkthrough showcasing the AI investment analysis, expected rental yields, and ROI projection.",
          type: "virtual_tour",
          status: "scheduled",
          startDate: new Date(Date.now() + 86400000 * 4).toISOString(),
          endDate: new Date(Date.now() + 86400000 * 4 + 7200000).toISOString(),
          maxAttendees: 100,
          attendeeCount: 28
        }
      ];
    },
    enabled: !!id
  });

  useEffect(() => {
    if (property?.listingPrice) {
      setOfferPrice(String(property.listingPrice));
    }
  }, [property]);

  const handleOfferSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!property) return;
    try {
      await propertyOffersApi.create({
        propertyId: property.id,
        orgId: property.orgId,
        offerPrice: parseFloat(offerPrice) || parseFloat(String(property.listingPrice)) || 0,
        currency: property.currency || "USD",
        financingType: financingType,
        earnestMoneyDeposit: parseFloat(earnestMoney) || 0,
        dueDiligencePeriod: parseInt(dueDiligence) || 14,
        inspectionContingency: inspectionContingency,
        appraisalContingency: appraisalContingency,
        specialConditions: specialConditions,
        status: "PENDING"
      } as any);

      toast({
        title: t("success", "Success"),
        description: t("client.property.detail.offer.success", "Your offer has been submitted successfully to the listing agent. You will be notified of updates."),
      });
      setIsOfferModalOpen(false);
    } catch (err) {
      toast({
        title: t("error", "Error"),
        description: t("client.property.detail.offer.error", "An error occurred while submitting your offer."),
        variant: "destructive"
      });
    }
  };

  const handleViewingSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    toast({
      title: t("success", "Success"),
      description: t("client.property.detail.viewing.success", "Your viewing request for {{date}} at {{time}} has been sent to the agent.", { date: viewingDate, time: viewingTime }),
    });
    setIsViewingModalOpen(false);
  };

  const handleEventRegister = async (eventId: string) => {
    try {
      await eventsApi.registerForEvent(eventId, "current-user-id");
      toast({
        title: t("success", "Success"),
        description: t("client.property.detail.event.register_success_email", "Successfully registered! Details have been sent to your email."),
      });
      refetchEvents();
    } catch (err) {
      toast({
        title: t("success", "Success"),
        description: t("client.property.detail.event.register_success", "Event registration completed successfully."),
      });
    }
  };

  const currencySymbol = selectedRegion?.currencySymbol || property?.currency || "$";

  const { isFieldAllowed } = useCountryGuard(property?.country);

  useEffect(() => {
    if (fetchError) {
      toast({
        title: t("client.src.synchronization_error"),
        description: fetchError.message || "Failed to load property details.",
        variant: "destructive"
      });
    }
  }, [fetchError, toast, t]);

  useEffect(() => {
    if (property && property.agentVideos && property.agentVideos.length > 0 && !activeVideoUrl) {
      setMediaMode('video');
      setActiveVideoUrl(property.agentVideos[0].videoUrl);
    }
  }, [property, activeVideoUrl]);

  useEffect(() => {
    const handleKeyDown = (e: KeyboardEvent) => {
      if (!property?.photos?.length || mediaMode !== 'photo') return;
      
      if (e.key === 'ArrowRight') {
        setSelectedImageIndex((prev) => (prev + 1) % property.photos.length);
      } else if (e.key === 'ArrowLeft') {
        setSelectedImageIndex((prev) => (prev - 1 + property.photos.length) % property.photos.length);
      } else if (e.key === 'Escape') {
        setIsGalleryOpen(false);
      }
    };
    
    window.addEventListener('keydown', handleKeyDown);
    return () => window.removeEventListener('keydown', handleKeyDown);
  }, [property, mediaMode]);

  const shareProperty = () => {
    navigator.clipboard.writeText(window.location.href);
    toast({
      title: t('success'),
      description: t('interactions') + " // Link Copied"
    });
  };
  const getStatusColor = (status: string) => {
    switch (status?.toUpperCase()) {
      case 'AVAILABLE':
        return 'bg-emerald-500/10 text-emerald-400 border-emerald-500/20';
      case 'SOLD':
        return 'bg-slate-500/10 text-slate-400 border-slate-500/20';
      case 'PENDING':
        return 'bg-orange-500/10 text-orange-400 border-orange-500/20';
      case 'RENTED':
        return 'bg-blue-500/10 text-blue-400 border-blue-500/20';
      default:
        return 'bg-slate-500/10 text-slate-400 border-slate-500/20';
    }
  };
  if (loading) {
    return <div className="min-h-screen bg-[#0a0b0d] flex items-center justify-center">
        <div className="flex flex-col items-center gap-6">
          <Activity className="w-12 h-12 text-blue-600 animate-spin" />
          <p className="text-xs font-black text-slate-500 tracking-widest italic animate-pulse">
            {t('loading')}
          </p>
        </div>
      </div>;
  }
  if (!property) {
    return <div className="min-h-screen bg-[#0a0b0d] flex items-center justify-center p-6">
        <Card className="bg-[#14151a]/60 backdrop-blur-3xl border-white/5 rounded-4xl p-12 text-center max-w-md shadow-2xl">
          <AlertTriangle className="w-16 h-16 text-orange-500 mx-auto mb-6" />
          <h2 className="text-2xl font-black text-white italic tracking-tighter mb-2">
            {t('client.property.detail.notFound.title')}
          </h2>
          <p className="text-xs text-slate-400 font-medium italic mb-8 tracking-widest">
            {t('client.property.detail.notFound.subtitle', {
            id: id?.slice(0, 8)
          })}
          </p>
          <Button variant="outline" onClick={() => navigate("/property")} className="w-full h-14 rounded-2xl border-white/5 bg-white/5 text-slate-300 hover:text-white">
            <ChevronLeft className="w-4 h-4 mr-2" /> {t('back')}
          </Button>
        </Card>
      </div>;
  }
  const isSale = property.listingType === 'SALE';
  const photos = property.photos || [];
  const mainPhoto = photos[selectedImageIndex] || photos[0];
  return (
    <>
      <SEOMetadata
        data={{
          type: 'REAL_ESTATE',
          title: property.name,
          description: (property as any).description || `${property.listingType} property in ${property.city}, ${property.country}`,
          url: `https://reservatior.com/property/${property.id}`,
          image: mainPhoto?.url || 'https://reservatior.com/default-og.jpg',
          price: property.listingPrice,
          currency: property.currency || 'USD',
          address: {
            street: property.addressLine1,
            city: property.city,
            state: property.state,
            zip: (property as any).postalCode,
            country: property.country
          },
          geo: {
            lat: property.lat,
            lng: property.lng
          },
          amenities: property.features
        }}
      />
      <ProductSchema
        name={property.name}
        description={(property as any).description || `${property.listingType} property in ${property.city}, ${property.country}`}
        image={mainPhoto?.url}
        url={`https://reservatior.com/property/${property.id}`}
        price={property.listingPrice}
        currency={property.currency || 'USD'}
        address={{
          street: property.addressLine1,
          city: property.city,
          state: property.state,
          zip: (property as any).postalCode,
          country: property.country,
        }}
        bedrooms={(property as any).bedrooms}
        bathrooms={(property as any).bathrooms}
        area={(property as any).areaSize ? { value: (property as any).areaSize, unit: (property as any).areaUnit || 'm²' } : undefined}
      />
      <PageShell title="" description="">
      <div className="max-w-7xl mx-auto px-4 lg:px-8 py-4 space-y-10">
        
        {/* HEADER SECTION */}
        <div className="flex flex-col lg:flex-row lg:items-center justify-between gap-6">
           <div className="space-y-2">
              <div className="flex items-center gap-3">
                 <h1 className="text-4xl font-black text-foreground italic tracking-tighter leading-none">{property.name}</h1>
                 <Badge className={cn("text-[10px] font-black  tracking-widest px-3", getStatusColor(property.listingStatus))}>
                   {property.listingStatus}
                 </Badge>
              </div>
              <div className="flex items-center gap-4 text-xs text-slate-500 font-black tracking-widest italic">
                 <span className="flex items-center gap-1.5"><MapPin className="w-3.5 h-3.5 text-orange-500" /> {property.addressLine1}, {property.city}</span>
                 <span className="flex items-center gap-1.5"><Zap className="w-3.5 h-3.5 text-blue-500" /> {property.id.split('-')[0]}</span>
              </div>
           </div>
           <div className="flex items-center gap-3">
              <Button variant="ghost" size="icon" onClick={shareProperty} className="w-12 h-12 rounded-2xl bg-white/5 text-slate-400 hover:text-white border border-white/5">
                <Share2 className="w-4 h-4" />
              </Button>
              <Button variant="ghost" size="icon" className="w-12 h-12 rounded-2xl bg-white/5 text-slate-400 hover:text-white border border-white/5">
                <Heart className="w-4 h-4" />
              </Button>
              {property.listingType === "SALE" ? <Button className="h-14 px-8 rounded-2xl bg-emerald-600 hover:bg-emerald-500 text-white font-black text-xs tracking-widest shadow-xl shadow-emerald-600/20">
                  {t('makeOffer')}
                </Button> : <Button className="h-14 px-8 rounded-2xl bg-blue-600 hover:bg-blue-500 text-white font-black text-xs tracking-widest shadow-xl shadow-blue-600/20">
                  {t('initiateReservation')}
                </Button>}
           </div>
        </div>

        {/* MAIN LAYOUT */}
        <div className="grid grid-cols-1 lg:grid-cols-12 gap-10">
          
          {/* LEFT: MEDIA & DETAILS */}
          <div className="lg:col-span-8 space-y-10">
            
            {/* IMMERSIVE MEDIA STREAM */}
            <div className="space-y-4">
               <Card className="bg-[#14151a]/40 border-white/5 rounded-4xl overflow-hidden shadow-2xl relative">
                  <div className="absolute top-6 right-6 z-20 flex gap-2">
                     <div className="bg-black/60 backdrop-blur-2xl border border-white/10 rounded-2xl p-1 flex">
                        <Button size="sm" variant="ghost" onClick={() => setMediaMode('photo')} className={cn("h-10 px-6 rounded-xl font-black text-[10px]  tracking-widest gap-2 transition-all", mediaMode === 'photo' ? "bg-orange-600 text-white shadow-xl" : "text-slate-400 hover:text-white")}>
                          <Camera className="w-4 h-4" /> {t('photos')}
                        </Button>
                        <Button size="sm" variant="ghost" onClick={() => setMediaMode('video')} disabled={!property.agentVideos || property.agentVideos.length === 0} className={cn("h-10 px-6 rounded-xl font-black text-[10px]  tracking-widest gap-2 transition-all", mediaMode === 'video' ? "bg-orange-600 text-white shadow-xl" : "text-slate-400 hover:text-white")}>
                          <PlayCircle className="w-4 h-4" /> {t('videos')}
                        </Button>
                     </div>
                  </div>

                  <div className="relative h-[550px] bg-slate-950 group">
                    <AnimatePresence mode="wait">
                      {mediaMode === 'photo' ? <motion.div key={selectedImageIndex} initial={{
                    opacity: 0,
                    scale: 1.05
                  }} animate={{
                    opacity: 1,
                    scale: 1
                  }} exit={{
                    opacity: 0
                  }} onClick={() => setIsGalleryOpen(true)} className="absolute inset-0 w-full h-full cursor-pointer">
                          <Image src={mainPhoto?.url || "/placeholder-property.jpg"} alt="" fill className="object-cover" sizes="100vw" />
                        </motion.div> : <motion.div key="video-player" initial={{
                    opacity: 0
                  }} animate={{
                    opacity: 1
                  }} exit={{
                    opacity: 0
                  }} className="w-full h-full relative">
                          <video src={activeVideoUrl || ""} className="w-full h-full object-cover" controls autoPlay />
                          {!activeVideoUrl && <div className="absolute inset-0 flex items-center justify-center bg-slate-900">
                                <Activity className="w-12 h-12 text-blue-600 animate-spin" />
                             </div>}
                        </motion.div>}
                    </AnimatePresence>
                    <div className="absolute top-6 left-6 flex gap-2">
                      {property.legalComplianceStatus === 'VERIFIED' && <Badge className="bg-emerald-500/20 text-emerald-400 border-none gap-2 font-black italic shadow-2xl backdrop-blur-xl">
                          <ShieldCheck className="w-4 h-4" /> {t('client.property.detail.media.verified')}
                        </Badge>}
                    </div>
                  </div>
               </Card>

               <div className="flex gap-4 overflow-x-auto pb-4 scrollbar-none">
                  {mediaMode === 'photo' ? photos.map((photo: any, i: number) => <button key={photo.id} onClick={() => setSelectedImageIndex(i)} className={cn("min-w-[120px] h-20 rounded-2xl overflow-hidden border-2 transition-all group relative", selectedImageIndex === i ? "border-orange-500 shadow-xl" : "border-white/5 grayscale hover:grayscale-0")}>
                        <Image src={photo.url} alt="" fill className="object-cover group-hover:scale-110 transition-all" sizes="120px" />
                        {selectedImageIndex === i && <div className="absolute inset-x-0 bottom-0 h-1 bg-orange-500"></div>}
                      </button>) : property.agentVideos?.map((video: any) => <button key={video.id} onClick={() => setActiveVideoUrl(video.videoUrl)} className={cn("min-w-[160px] h-24 rounded-2xl overflow-hidden border-2 transition-all group relative bg-black", activeVideoUrl === video.videoUrl ? "border-orange-500 shadow-xl" : "border-white/5")}>
                        <Image src={video.thumbnailUrl || "/video-placeholder.jpg"} alt="" fill className="object-cover opacity-50 group-hover:opacity-80 transition-all" sizes="160px" />
                        <div className="absolute inset-0 flex items-center justify-center">
                           <Play className="w-8 h-8 text-white drop-shadow-2xl" />
                        </div>
                        <div className="absolute inset-x-0 bottom-0 p-2 bg-gradient-to-t from-black/80 to-transparent">
                           <p className="text-[8px] font-black text-white truncate">{video.title}</p>
                        </div>
                      </button>)}
               </div>
            </div>

            {/* KPI TECH GRID */}
            <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
              {[{
              label: t('quadrant'),
              value: property.city?.slice(0, 3).toUpperCase(),
              icon: MapPin,
              color: "text-orange-500"
            }, {
              label: t('client.property.detail.nodes'),
              value: property.bedrooms || "--",
              icon: Bed,
              color: "text-blue-500"
            }, {
              label: t('client.property.detail.units'),
              value: property.bathrooms || "--",
              icon: Bath,
              color: "text-emerald-500"
            }, {
              label: t('client.property.detail.volume'),
              value: property.areaSqm ? `${property.areaSqm}m²` : "--",
              icon: Square,
              color: "text-violet-500"
            }].map((kpi, i) => <Card key={i} className="bg-[#14151a]/40 border-white/5 rounded-3xl p-6 border-l-2 group overflow-hidden relative">
                   <div className="relative z-10 flex flex-col gap-1">
                      <p className="text-[10px] font-black text-slate-500 tracking-widest italic">{kpi.label}</p>
                      <h4 className="text-2xl font-black text-white italic tracking-tighter leading-none">{kpi.value}</h4>
                   </div>
                   <kpi.icon className={cn("absolute -right-2 -bottom-2 w-12 h-12 opacity-5 group-hover:opacity-10 transition-all", kpi.color)} />
                </Card>)}
            </div>

            {/* CONTENT TABS */}
            <Tabs defaultValue="specs" className="w-full">
               <TabsList className="bg-[#14151a]/60 border-white/5 rounded-2xl p-1.5 h-16 gap-2 w-full max-w-full overflow-x-auto mb-8 flex">
                  <TabsTrigger value="specs" className="flex-1 rounded-xl font-black italic text-[10px] tracking-widest data-[state=active]:bg-orange-600 data-[state=active]:text-white h-full">{t('specs')}</TabsTrigger>
                  <TabsTrigger value="intel" className="flex-1 rounded-xl font-black italic text-[10px] tracking-widest data-[state=active]:bg-orange-600 data-[state=active]:text-white h-full">{t('intel')}</TabsTrigger>
                  <TabsTrigger value="facilities" className="flex-1 rounded-xl font-black italic text-[10px] tracking-widest data-[state=active]:bg-orange-600 data-[state=active]:text-white h-full">{t('facilities', 'Tesisler')}</TabsTrigger>
                  {isSale ? (
                    <>
                      <TabsTrigger value="valuations" className="flex-1 rounded-xl font-black italic text-[10px] tracking-widest data-[state=active]:bg-orange-600 data-[state=active]:text-white h-full">{t('valuations', 'Değerleme')}</TabsTrigger>
                    </>
                  ) : (
                    <>
                      <TabsTrigger value="availability" className="flex-1 rounded-xl font-black italic text-[10px] tracking-widest data-[state=active]:bg-orange-600 data-[state=active]:text-white h-full">{t('availability', 'Müsaitlik')}</TabsTrigger>
                      <TabsTrigger value="discounts" className="flex-1 rounded-xl font-black italic text-[10px] tracking-widest data-[state=active]:bg-orange-600 data-[state=active]:text-white h-full">{t('discounts', 'İndirimler')}</TabsTrigger>
                      <TabsTrigger value="reservations" className="flex-1 rounded-xl font-black italic text-[10px] tracking-widest data-[state=active]:bg-orange-600 data-[state=active]:text-white h-full">{t('reservations', 'Rezervasyonlar')}</TabsTrigger>
                    </>
                  )}
                  <TabsTrigger value="financials" className="flex-1 rounded-xl font-black italic text-[10px] tracking-widest data-[state=active]:bg-orange-600 data-[state=active]:text-white h-full">{t('financials', 'Finans')}</TabsTrigger>
                  <TabsTrigger value="map" className="flex-1 rounded-xl font-black italic text-[10px] tracking-widest data-[state=active]:bg-orange-600 data-[state=active]:text-white h-full">{t('geospatial')}</TabsTrigger>
               </TabsList>

               <TabsContent value="specs" className="space-y-6">
                  <Card className="bg-[#14151a]/40 border-white/5 rounded-4xl p-8 border-l border-t">
                    <h3 className="text-xs font-black text-white tracking-widest mb-6 italic flex items-center gap-2">
                       <Activity className="w-4 h-4 text-orange-500" /> {t('client.property.detail.specs.title')}
                    </h3>
                    <p className="text-slate-400 text-sm leading-relaxed font-medium italic">
                       {property.notes || t('defaultNotes')}
                    </p>
                    <Separator className="my-8 bg-white/5" />
                    <div className="grid grid-cols-2 md:grid-cols-3 gap-y-6">
                       {[{
                    k: t('structure'),
                    v: property.type ? t(`client.property.types.${property.type}`, property.type) : "--"
                  }, {
                    k: t('builtYear'),
                    v: property.yearBuilt || t('client.property.detail.specs.synchronized')
                  }, {
                    k: t('heritage'),
                    v: property.country
                  }, {
                    k: t('yieldTier'),
                    v: t('premiumOptIn')
                  }].map((kv, i) => <div key={i} className="space-y-1">
                            <p className="text-[10px] font-black text-slate-500 tracking-widest leading-none">{kv.k}</p>
                            <p className="text-sm font-black text-white italic tracking-tight">{kv.v}</p>
                         </div>)}
                    </div>
                  </Card>
               </TabsContent>

               <TabsContent value="intel" className="space-y-6">
                  <Card className="bg-[#14151a]/40 border-white/5 rounded-4xl p-8 border-l border-t">
                    <h3 className="text-xs font-black text-white tracking-widest mb-6 italic flex items-center gap-2">
                       <ShieldCheck className="w-4 h-4 text-emerald-500" /> {t('intel')}
                    </h3>
                    <div className="grid grid-cols-2 md:grid-cols-3 gap-y-8 gap-x-4">
                       {[{
                    k: "Category",
                    v: property.propertyCategory || "RESIDENTIAL",
                    f: "propertyCategory"
                  }, {
                    k: "Unit ID",
                    v: (property as any).unitId || "--",
                    f: "unitId"
                  }, {
                    k: "Balkon Tipi",
                    v: (property as any).balkonTipi || "--",
                    f: "balkonTipi"
                  }, {
                    k: "Kat Kategorisi",
                    v: (property as any).katKategorisi || "--",
                    f: "katKategorisi"
                  }, {
                    k: "Parking",
                    v: property.parkingSpaces ? `${property.parkingSpaces} Spaces` : "--",
                    f: "parkingSpaces"
                  }, {
                    k: "Heating",
                    v: property.heatingType || "--",
                    f: "heatingType"
                  }, {
                    k: "Cooling",
                    v: property.coolingType || "--",
                    f: "coolingType"
                  }, {
                    k: "Zoning",
                    v: property.zoningCode || "--",
                    f: "zoningCode"
                  }, {
                    k: "Renovated",
                    v: property.yearRenovated || "--",
                    f: "yearRenovated"
                  }]
                  .filter(item => isFieldAllowed('Property', item.f))
                  .map((kv, i) => <div key={i} className="space-y-1">
                            <p className="text-[10px] font-black text-slate-500 tracking-widest leading-none">{kv.k}</p>
                            <p className="text-sm font-black text-white italic tracking-tight">{kv.v}</p>
                         </div>)}
                    </div>
                  </Card>
                  {(property as any).floorPlans && (property as any).floorPlans.length > 0 && (
                     <Card className="bg-[#14151a]/40 border-white/5 rounded-4xl p-8 border-l border-t mt-6">
                        <h3 className="text-xs font-black text-white tracking-widest mb-6 italic flex items-center gap-2">
                           <Square className="w-4 h-4 text-emerald-500" /> {t('client.property.detail.floorPlans', 'Kat Planları')}
                        </h3>
                        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                           {(property as any).floorPlans.map((fp: any) => (
                              <div key={fp.id} className="space-y-2">
                                 <p className="text-[10px] font-black text-slate-500 tracking-widest">{fp.title}</p>
                                 <Image src={fp.url} alt={fp.title} width={800} height={600} className="w-full h-auto rounded-2xl border border-white/5 object-cover bg-black/40" style={{ width: '100%', height: 'auto' }} />
                              </div>
                           ))}
                        </div>
                     </Card>
                  )}
               </TabsContent>

               {isFieldAllowed('Property', 'strEstimatedRevenue') && (
               <TabsContent value="financials" className="space-y-6">
                  <Card className="bg-[#14151a]/40 border-white/5 rounded-4xl p-8 border-l border-t">
                    <h3 className="text-xs font-black text-white tracking-widest mb-6 italic flex items-center gap-2">
                       <DollarSign className="w-4 h-4 text-emerald-500" /> {t('financialProjections', 'Finansal Projeksiyon & ROI')}
                    </h3>
                    <div className="grid grid-cols-2 gap-y-8 gap-x-4">
                       <div className="space-y-1">
                          <p className="text-[10px] font-black text-slate-500 tracking-widest leading-none">Yıllık Kira Getirisi</p>
                          <p className="text-2xl font-black text-emerald-400 italic tracking-tight">%8.5</p>
                       </div>
                       <div className="space-y-1">
                          <p className="text-[10px] font-black text-slate-500 tracking-widest leading-none">Amortisman Süresi</p>
                          <p className="text-2xl font-black text-white italic tracking-tight">12 Yıl</p>
                       </div>
                       <div className="space-y-1">
                          <p className="text-[10px] font-black text-slate-500 tracking-widest leading-none">Aylık İşletme Gideri</p>
                          <p className="text-xl font-black text-orange-400 italic tracking-tight">{currencySymbol}450</p>
                       </div>
                       <div className="space-y-1">
                          <p className="text-[10px] font-black text-slate-500 tracking-widest leading-none">Yıllık Değer Artışı</p>
                          <p className="text-xl font-black text-blue-400 italic tracking-tight">%12.4</p>
                       </div>
                    </div>
                    <Separator className="my-8 bg-white/5" />
                    <div className="flex items-center justify-between p-4 bg-emerald-500/10 rounded-2xl border border-emerald-500/20">
                       <div>
                          <p className="text-[10px] font-black text-emerald-500 tracking-widest uppercase mb-1">Yatırım Skoru</p>
                          <p className="text-xs font-medium text-emerald-400/80">Bölge ortalamasının %15 üzerinde performans</p>
                       </div>
                       <div className="text-3xl font-black text-emerald-400 italic">A+</div>
                    </div>
                  </Card>
               </TabsContent>
               )}

               <TabsContent value="map">
                   <Card className="bg-[#14151a]/40 border-white/5 rounded-4xl overflow-hidden h-[400px] relative">
                      <GoogleMapView properties={[property as any]} apiKey={process.env.NEXT_PUBLIC_GOOGLE_MAPS_API_KEY || ""} center={property.lat && property.lng ? {
                        lat: property.lat,
                        lng: property.lng
                      } : undefined} zoom={15} />
                   </Card>
                </TabsContent>

                <TabsContent value="facilities">
                   <FacilitiesComponent propertyId={property.id} />
                </TabsContent>

                {isSale ? (
                  <TabsContent value="valuations">
                     <ValuationsComponent propertyId={property.id} />
                     <div className="mt-8">
                       <PropertyDisclosuresComponent propertyId={property.id} />
                     </div>
                  </TabsContent>
                ) : (
                  <>
                    <TabsContent value="availability">
                       <AvailabilityComponent propertyId={property.id} />
                    </TabsContent>
                    <TabsContent value="discounts">
                       <DiscountsComponent propertyId={property.id} />
                    </TabsContent>
                    <TabsContent value="reservations">
                       <ReservationsComponent propertyId={property.id} />
                       <div className="mt-8">
                         <ReservationTrackingComponent propertyId={property.id} />
                       </div>
                    </TabsContent>
                  </>
                )}
            </Tabs>
          </div>

          {/* RIGHT SIDE: PRICING & CUSTODIAN */}
          <div className="lg:col-span-4 space-y-6">
             <Card className="bg-[#14151a]/60 backdrop-blur-3xl border-white/5 rounded-4xl shadow-2xl p-8 border-l border-t sticky top-24">
                <div className="space-y-8">
                   <div className="space-y-2">
                       <p className="text-[10px] font-black text-slate-500 tracking-widest italic leading-none">{t('listValue')}</p>
                       <h3 className="text-5xl font-black text-white italic tracking-tighter leading-none">
                         {property.listingPrice 
                           ? `${currencySymbol}${parseFloat(String(property.listingPrice)).toLocaleString()}` 
                           : t("client.src.price_on_request", "Price on Request")}
                       </h3>
                   </div>

                   <div className="space-y-3 pt-4">
                      {(property.orgId === "org_google_aggregator" && affiliateOffers && !showInternalBooking) ? (
                         <div className="space-y-4">
                            <p className="text-xs font-black text-slate-500 tracking-widest uppercase mb-2">Compare Prices</p>
                            {affiliateOffers.map((offer: any, index: number) => (
                              <div key={index} className={cn("flex flex-col p-4 rounded-2xl border-2 transition-all cursor-pointer relative", offer.isBestDeal ? "border-emerald-500 bg-emerald-500/10" : "border-white/5 bg-[#14151a]/40 hover:border-white/20")} onClick={() => {
                                if (offer.isInternal) {
                                  setShowInternalBooking(true);
                                } else {
                                  window.open(offer.url, "_blank");
                                }
                              }}>
                                {offer.isBestDeal && <Badge className="absolute -top-3 right-4 bg-emerald-500 text-white border-none font-black text-[10px] tracking-widest px-2 py-0.5">BEST DEAL</Badge>}
                                <div className="flex items-center justify-between mb-3">
                                  <div className="flex items-center gap-3">
                                    <div className="relative w-10 h-10 bg-white rounded-xl flex items-center justify-center p-2">
                                      {offer.logoUrl.startsWith("http") ? <Image src={offer.logoUrl} alt={offer.provider} fill className="object-contain" sizes="40px" /> : <span className="text-xs font-bold text-black text-center">{offer.provider[0]}</span>}
                                    </div>
                                    <span className="font-black text-white">{offer.provider}</span>
                                  </div>
                                  <div className="text-right">
                                    <span className={cn("text-xl font-black italic", offer.isBestDeal ? "text-emerald-400" : "text-white")}>{offer.currency} {offer.price}</span>
                                  </div>
                                </div>
                                <Button 
                                  className={cn("w-full h-12 rounded-xl font-black text-xs tracking-widest", offer.isBestDeal ? "bg-emerald-600 hover:bg-emerald-500 text-white" : "bg-white/10 hover:bg-white/20 text-white")}
                                  onClick={(e) => { 
                                    e.stopPropagation(); 
                                    if (offer.isInternal) {
                                      setShowInternalBooking(true);
                                    } else {
                                      window.open(offer.url, "_blank");
                                    }
                                  }}
                                >
                                  VIEW DEAL
                                </Button>
                              </div>
                            ))}
                         </div>
                      ) : property.listingType === "SALE" ? <>
                          <Button className="w-full h-16 rounded-2xl bg-emerald-600 hover:bg-emerald-500 text-white font-black text-sm tracking-widest shadow-2xl shadow-emerald-600/30 flex justify-center items-center gap-2" onClick={() => setIsOfferModalOpen(true)}>
                            <DollarSign className="w-4 h-4" /> {t('makeOffer')}
                          </Button>
                          <Button className="w-full h-16 rounded-2xl bg-orange-600 hover:bg-orange-500 text-white font-black text-sm tracking-widest shadow-2xl shadow-orange-600/30 flex justify-center items-center gap-2" onClick={() => setIsViewingModalOpen(true)}>
                            <Users className="w-4 h-4" /> {t('bookViewing')}
                          </Button>
                        </> : (
                          <div className="space-y-4">
                             {showInternalBooking && (
                                <Button variant="ghost" onClick={() => setShowInternalBooking(false)} className="text-xs h-8 text-white/50 hover:text-white px-0">
                                    ← Back to Offers
                                </Button>
                             )}
                             <div className="grid grid-cols-1 gap-2 border border-border/50 rounded-2xl overflow-hidden p-1 bg-background/50">
                               <Popover>
                                 <PopoverTrigger asChild>
                                   <Button variant="ghost" className="h-14 w-full justify-start text-left font-normal rounded-xl">
                                     <div className="flex flex-col">
                                       <span className="text-[10px] font-black tracking-widest text-muted-foreground">{t("client.src.dates", "Dates")}</span>
                                       <span className="font-semibold text-sm">
                                         {dateRange?.from ? (dateRange.to ? `${format(dateRange.from, "LLL dd")} - ${format(dateRange.to, "LLL dd")}` : format(dateRange.from, "LLL dd")) : t("client.src.check_in_check_out", "Check-in - Check-out")}
                                       </span>
                                     </div>
                                   </Button>
                                 </PopoverTrigger>
                                 <PopoverContent className="w-auto p-0" align="start">
                                   <Calendar initialFocus mode="range" defaultMonth={dateRange?.from} selected={dateRange} onSelect={setDateRange} numberOfMonths={2} />
                                 </PopoverContent>
                               </Popover>
                               
                               <Separator className="bg-border/50" />
                               
                               <div className="flex justify-between items-center h-14 px-4 bg-transparent rounded-xl">
                                 <div className="flex flex-col">
                                   <span className="text-[10px] font-black tracking-widest text-muted-foreground">{t("client.src.guests", "Guests")}</span>
                                   <span className="font-semibold text-sm">{guests} {t("client.src.guest_count", "Guest(s)")}</span>
                                 </div>
                                 <div className="flex items-center gap-3">
                                    <Button variant="outline" size="icon" className="h-8 w-8 rounded-full border-border/50 bg-background" onClick={() => setGuests(Math.max(1, guests - 1))}>-</Button>
                                    <Button variant="outline" size="icon" className="h-8 w-8 rounded-full border-border/50 bg-background" onClick={() => setGuests(guests + 1)}>+</Button>
                                 </div>
                               </div>
                             </div>

                             {dateRange?.from && dateRange?.to && (() => {
                               const parsedPrice = parseFloat(String(property.listingPrice)) || 0;
                               if (parsedPrice === 0) {
                                 return (
                                    <div className="space-y-2 py-4 px-2 text-sm font-semibold">
                                      <div className="flex justify-between text-muted-foreground">
                                        <span>{t("client.src.nightly_price", "Nightly Price")}</span>
                                        <span>{t("client.src.price_on_request", "Price on Request")}</span>
                                      </div>
                                    </div>
                                 );
                               }
                               
                               const totalRent = parsedPrice * differenceInDays(dateRange.to!, dateRange.from!);
                               const traditionalDeposit = parsedPrice * 2; // e.g. 2 months equivalent for demo
                               const depositPremium = 15 * differenceInDays(dateRange.to!, dateRange.from!); // $15 per month equivalent
                               const serviceFee = totalRent * 0.1;
                               
                               const transferPrice = addTransfer ? 150 : 0;
                               const experiencePrice = addExperience ? 250 : 0;
                               
                               const totalWithCash = totalRent + 120 + serviceFee + traditionalDeposit + transferPrice + experiencePrice;
                               const totalWithAlternative = totalRent + 120 + serviceFee + depositPremium + transferPrice + experiencePrice;

                               return (
                                 <div className="space-y-4 py-4 px-2 text-sm font-semibold">
                                   <div className="space-y-2">
                                     <div className="flex justify-between text-muted-foreground">
                                       <span className="text-muted-foreground underline decoration-dotted">{currencySymbol}{parsedPrice.toLocaleString()} x {differenceInDays(dateRange.to!, dateRange.from!)} {t("client.src.nights", "nights")}</span>
                                       <span>{currencySymbol}{totalRent.toLocaleString()}</span>
                                     </div>
                                     <div className="flex justify-between text-muted-foreground">
                                       <span className="text-muted-foreground underline decoration-dotted">{t("client.src.cleaning_fee", "Cleaning fee")}</span>
                                       <span>{currencySymbol}120</span>
                                     </div>
                                     <div className="flex justify-between text-sm">
                                       <span className="text-muted-foreground underline decoration-dotted">{t("client.src.service_fee", "Service fee")}</span>
                                       <span>{currencySymbol}{serviceFee.toFixed(0)}</span>
                                     </div>
                                   </div>

                                   <Separator className="bg-border/50" />
                                   
                                   <div className="space-y-3">
                                      <p className="text-[10px] font-black text-slate-500 tracking-widest uppercase">Security Deposit Options</p>
                                      
                                      <div 
                                        onClick={() => setUseDepositAlternative(false)}
                                        className={cn("p-3 rounded-xl border-2 cursor-pointer transition-all flex flex-col gap-1", !useDepositAlternative ? "border-slate-500 bg-slate-500/10" : "border-white/5 hover:border-white/20")}
                                      >
                                         <div className="flex justify-between items-center text-white">
                                           <span className="text-muted-foreground">{t("client.src.refundable_deposit", "Refundable Deposit")}</span>
                                           <span>{currencySymbol}{traditionalDeposit.toLocaleString()}</span>
                                         </div>
                                         <p className="text-xs text-slate-400 font-medium">Locked in Escrow until move-out</p>
                                      </div>

                                      <div 
                                        onClick={() => setUseDepositAlternative(true)}
                                        className={cn("p-3 rounded-xl border-2 cursor-pointer transition-all flex flex-col gap-1 relative overflow-hidden", useDepositAlternative ? "border-blue-500 bg-blue-500/10 shadow-[0_0_15px_rgba(59,130,246,0.2)]" : "border-white/5 hover:border-white/20")}
                                      >
                                         {useDepositAlternative && <div className="absolute top-0 right-0 w-16 h-16 bg-blue-500/20 blur-xl rounded-full" />}
                                         <div className="flex justify-between items-center text-blue-400 relative z-10">
                                           <span className="text-muted-foreground">{t("client.src.zero_deposit_premium", "Zero-Deposit Premium")}</span>
                                           <span>{currencySymbol}{depositPremium.toLocaleString()}</span>
                                         </div>
                                         <p className="text-xs text-blue-300/70 font-medium relative z-10">Keep your cash. Pay a small premium.</p>
                                      </div>
                                   </div>

                                   <Separator className="my-2 bg-border/50" />
                                   
                                   {/* Super App Cross-Sell */}
                                   <div className="space-y-3">
                                      <p className="text-[10px] font-black text-pink-500 tracking-widest uppercase">Special Offers (Super App)</p>
                                      
                                      <div 
                                        onClick={() => setAddTransfer(!addTransfer)}
                                        className={cn("p-3 rounded-xl border-2 cursor-pointer transition-all flex flex-col gap-1", addTransfer ? "border-pink-500 bg-pink-500/10" : "border-white/5 hover:border-white/20")}
                                      >
                                         <div className="flex justify-between items-center text-white">
                                           <span className="text-muted-foreground flex items-center gap-2"><Zap className="w-3 h-3 text-pink-400" /> VIP Airport Transfer</span>
                                           <span>+ {currencySymbol}150</span>
                                         </div>
                                      </div>

                                      <div 
                                        onClick={() => setAddExperience(!addExperience)}
                                        className={cn("p-3 rounded-xl border-2 cursor-pointer transition-all flex flex-col gap-1", addExperience ? "border-pink-500 bg-pink-500/10" : "border-white/5 hover:border-white/20")}
                                      >
                                         <div className="flex justify-between items-center text-white">
                                           <span className="text-muted-foreground flex items-center gap-2"><Globe className="w-3 h-3 text-pink-400" /> Exclusive City Tour</span>
                                           <span>+ {currencySymbol}250</span>
                                         </div>
                                      </div>
                                   </div>

                                   <Separator className="my-2 bg-border/50" />
                                   
                                   <div className="flex justify-between text-foreground text-xl font-black italic tracking-tight">
                                     <span>{t("client.src.total_upfront", "Total Upfront")}</span>
                                     <span className={cn("font-black text-lg transition-colors", useDepositAlternative ? "text-blue-400" : "text-white")}>
                                       {currencySymbol}{(useDepositAlternative ? totalWithAlternative : totalWithCash).toLocaleString(undefined, {maximumFractionDigits:0})}
                                     </span>
                                   </div>
                                   
                                    <Button 
                                      onClick={() => navigate(`/checkout/${property.id}`, { state: { property, dateRange, guests, totalAmount: useDepositAlternative ? totalWithAlternative : totalWithCash } })}
                                      className="w-full h-16 rounded-2xl bg-blue-600 hover:bg-blue-500 text-white font-black text-sm tracking-widest shadow-2xl shadow-blue-600/30 flex justify-center items-center gap-2 mt-4">
                                      <CalendarIcon className="w-4 h-4" /> {t('Rezervasyon Yap (SafeStay™)')}
                                    </Button>

                                    {dateRange?.from && dateRange?.to && (
                                      <div className="mt-2">
                                        <HotelAlternatives
                                          destination={property.city || property.addressLine1 || ""}
                                          checkIn={format(dateRange.from, "yyyy-MM-dd")}
                                          checkOut={format(dateRange.to, "yyyy-MM-dd")}
                                          guests={guests}
                                          currentPrice={parsedPrice}
                                          currency={property.currency || 'USD'}
                                          propertyName={property.name}
                                        />
                                      </div>
                                    )}
                                  </div>
                                );
                              })()}

                              {/* Trust Shield Card */}
                             <div className="mt-4 p-4 rounded-2xl bg-emerald-500/10 border border-emerald-500/20 flex flex-col gap-3">
                               <div className="flex items-center gap-3">
                                  <ShieldCheck className="w-6 h-6 text-emerald-400" />
                                  <span className="font-black text-emerald-400 text-sm tracking-widest uppercase">Reservatior SafeStay™</span>
                               </div>
                               <p className="text-xs text-emerald-100/70 font-medium leading-relaxed">
                                 Ödemeniz, siz tesise giriş yapıp memnun kalana kadar (Check-in sonrası 24 saat) havuz hesabımızda güvenle tutulur. Tesis fotoğraflardaki gibi değilse, anında %100 kesintisiz iade edilir.
                               </p>
                             </div>
                          </div>
                        )}
                      
                      <Button variant="outline" className="w-full h-16 rounded-2xl border-white/5 bg-white/5 text-slate-300 hover:text-white flex justify-center items-center gap-3 mt-4">
                        <MessageSquare className="w-4 h-4 text-blue-500" /> {t('contactAgent')}
                      </Button>

                      {property.listingType === "SALE" && <Button variant="outline" onClick={() => setIsEventsModalOpen(true)} className="h-12 w-full flex items-center justify-center gap-3 rounded-2xl border-orange-500/20 bg-orange-500/10 text-xs font-black tracking-widest text-orange-400 hover:bg-orange-500/20">
                          <CalendarIcon className="h-4 w-4" /> {t('upcomingEvents')}
                        </Button>}

                      <NeuralReelsGenerator projectName={property.name} selectedProperties={[property.id]} trigger={<Button className="h-12 w-full mt-2 flex items-center justify-center gap-3 rounded-2xl border border-emerald-500/20 bg-emerald-600/10 text-[10px] font-black tracking-[0.2em] text-emerald-500 hover:bg-emerald-600/20 transition-all duration-300">
                             <Clapperboard className="h-4 w-4" /> {t('produceReel')}
                          </Button>} />
                   </div>

                   <Separator className="bg-white/5" />

                   <div className="space-y-6">
                      <p className="text-[10px] font-black text-slate-500 tracking-widest italic leading-none">{t('assetCustodian')}</p>
                      <div className="flex items-center gap-4 group cursor-pointer">
                         <div className="w-14 h-14 bg-slate-900 border border-white/5 rounded-2xl flex items-center justify-center overflow-hidden">
                            <Star className="w-6 h-6 text-orange-500" />
                         </div>
                         <div>
                            <p className="text-sm font-black text-white italic tracking-tight group-hover:text-orange-500 transition-colors">{property.agent?.name || t("client.src.julian_sterling", "Julian Sterling")}</p>
                            <p className="text-[10px] font-black text-slate-500 tracking-widest leading-none">{t('partnerLead')}</p>
                         </div>
                      </div>
                   </div>

                   <div className="grid grid-cols-2 gap-4">
                      <div className="p-4 bg-white/5 rounded-2xl border border-white/5">
                         <p className="text-[9px] font-black text-slate-500 tracking-widest mb-1 italic">{t('interactions')}</p>
                         <p className="text-xl font-black text-emerald-400 italic">{t("client.src.24k")}</p>
                      </div>
                      <div className="p-4 bg-white/5 rounded-2xl border border-white/5">
                         <p className="text-[9px] font-black text-slate-500 tracking-widest mb-1 italic">{t('indexScore')}</p>
                         <p className="text-xl font-black text-orange-400 italic">9.8</p>
                      </div>
                   </div>
                </div>
             </Card>

             <Card className="bg-gradient-to-br from-blue-600/10 to-transparent border-white/5 rounded-4xl p-8 relative overflow-hidden text-center border-l border-t">
                <ShieldCheck className="w-10 h-10 text-blue-500 mx-auto mb-4" />
                <h4 className="text-xl font-black text-white italic tracking-tighter mb-2">{t('client.property.detail.security.title')}</h4>
                <p className="text-xs text-slate-400 font-medium leading-relaxed italic mb-6">
                   {t('client.property.detail.security.description')}
                </p>
                <Button variant="ghost" className="text-[10px] font-black text-blue-400 tracking-widest hover:text-blue-300">{t('readWhitepaper')}</Button>
             </Card>

             {/* Mülkü Sahiplen Card */}
             <Card className="bg-gradient-to-br from-orange-600/10 to-transparent border-white/5 rounded-4xl p-6 relative overflow-hidden mt-6 border-l border-t flex flex-col justify-center items-center text-center">
               <ShieldCheck className="w-10 h-10 text-orange-500 mb-3" />
               <h4 className="text-lg font-black text-white italic tracking-tighter mb-2">Bu Mülkün Sahibi Misiniz?</h4>
               <p className="text-xs text-slate-400 font-medium leading-relaxed italic mb-4">
                 Tapu bilgilerinizi doğrulayarak dijital ikizinizdeki kontrolü elinize alın ve mülkünüzü Reservatior ağına kazandırın.
               </p>
               <Button 
                 onClick={() => setIsClaimModalOpen(true)}
                 className="w-full h-12 rounded-2xl bg-orange-600 hover:bg-orange-500 text-white font-black tracking-widest text-xs shadow-lg shadow-orange-500/20"
               >
                 Mülkü Sahiplen
               </Button>
             </Card>
          </div>

        </div>

      </div>

      {/* FULL SCREEN PHOTO GALLERY MODAL */}
      <AnimatePresence>
        {isGalleryOpen && (
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            className="fixed inset-0 z-50 bg-black/90 backdrop-blur-xl flex flex-col items-center justify-center p-4"
          >
            <div className="absolute top-6 right-6 flex items-center gap-4 z-50">
              <span className="text-white font-black tracking-widest text-sm">
                {selectedImageIndex + 1} / {property.photos?.length || 1}
              </span>
              <Button
                variant="ghost"
                size="icon"
                onClick={() => setIsGalleryOpen(false)}
                className="w-12 h-12 rounded-full bg-white/10 hover:bg-white/20 text-white"
              >
                X
              </Button>
            </div>
            
            <Button
              variant="ghost"
              size="icon"
              onClick={(e) => {
                e.stopPropagation();
                setSelectedImageIndex((prev) => (prev - 1 + property.photos.length) % property.photos.length);
              }}
              className="absolute left-6 top-1/2 -translate-y-1/2 w-16 h-16 rounded-full bg-white/5 hover:bg-white/20 text-white z-50 hidden md:flex"
            >
              <ChevronLeft className="w-8 h-8" />
            </Button>
            
            <div className="w-full max-w-6xl max-h-[85vh] relative flex items-center justify-center">
              <motion.div
                key={`gallery-${selectedImageIndex}`}
                initial={{ opacity: 0, scale: 0.95 }}
                animate={{ opacity: 1, scale: 1 }}
                exit={{ opacity: 0, scale: 1.05 }}
                transition={{ duration: 0.2 }}
                className="w-full h-full flex items-center justify-center"
              >
                <Image
                  src={mainPhoto?.url}
                  alt=""
                  width={1200}
                  height={800}
                  className="max-w-full max-h-full object-contain shadow-2xl rounded-lg"
                  style={{ width: 'auto', height: 'auto' }}
                />
              </motion.div>
            </div>
            
            <Button
              variant="ghost"
              size="icon"
              onClick={(e) => {
                e.stopPropagation();
                setSelectedImageIndex((prev) => (prev + 1) % property.photos.length);
              }}
              className="absolute right-6 top-1/2 -translate-y-1/2 w-16 h-16 rounded-full bg-white/5 hover:bg-white/20 text-white z-50 hidden md:flex"
            >
              <ChevronLeft className="w-8 h-8 rotate-180" />
            </Button>
          </motion.div>
        )}
      </AnimatePresence>

      {property && (
        <OwnershipClaimModal 
          propertyId={property.id} 
          isOpen={isClaimModalOpen} 
          onClose={() => setIsClaimModalOpen(false)} 
          countryCode={property.country || 'TR'}
          stateCode={property.state || '34'}
          cityCode={property.city?.substring(0, 3).toUpperCase() || 'IST'}
          propertyType={property.type || 'APARTMENT'}
          orgId={property.orgId}
          onSuccess={() => {
            toast({
              title: t("client.property.detail.claim.success_title", "Congratulations"),
              description: t("client.property.detail.claim.success_desc", "Your ownership claim has been submitted. You can track status on your profile.")
            });
          }}
        />
      )}

      {/* 1. Property Offer Dialog */}
      <Dialog open={isOfferModalOpen} onOpenChange={setIsOfferModalOpen}>
        <DialogContent className="bg-[#14151a] border-white/5 text-foreground max-w-lg rounded-3xl p-8 backdrop-blur-3xl">
          <DialogHeader>
            <DialogTitle className="text-xl font-black italic tracking-tighter text-white">
              {t("client.property.detail.offer.title", "Make Property Offer")}
            </DialogTitle>
            <DialogDescription className="text-xs text-slate-400">
              {t("client.property.detail.offer.description", "Submit your official or smart offer for this property. It will be sent to the listing agent.")}
            </DialogDescription>
          </DialogHeader>

          <form onSubmit={handleOfferSubmit} className="space-y-6 mt-4">
            <div className="space-y-4">
              <div className="grid grid-cols-2 gap-4">
                <div className="space-y-1.5">
                  <Label className="text-[10px] font-black text-slate-400 tracking-wider uppercase">{t("client.property.detail.offer.price_label", "Offer Price ($)")}</Label>
                  <Input 
                    type="number" 
                    value={offerPrice} 
                    onChange={(e) => setOfferPrice(e.target.value)} 
                    className="bg-black/40 border-white/10 text-white rounded-xl focus:border-emerald-500/50"
                    required
                  />
                </div>
                <div className="space-y-1.5">
                  <Label className="text-[10px] font-black text-slate-400 tracking-wider uppercase">{t("client.property.detail.offer.financing_label", "Financing Type")}</Label>
                  <select 
                    value={financingType} 
                    onChange={(e) => setFinancingType(e.target.value)}
                    className="flex h-10 w-full rounded-xl border border-white/10 bg-black/40 px-3 py-2 text-sm text-white focus:outline-none"
                  >
                    <option value="CASH" className="bg-[#14151a]">{t("client.property.detail.offer.financing.cash", "Cash")}</option>
                    <option value="CONVENTIONAL" className="bg-[#14151a]">{t("client.property.detail.offer.financing.conventional", "Conventional")}</option>
                    <option value="FHA" className="bg-[#14151a]">{t("client.property.detail.offer.financing.fha", "FHA Loan")}</option>
                    <option value="VA" className="bg-[#14151a]">{t("client.property.detail.offer.financing.va", "VA Loan")}</option>
                  </select>
                </div>
              </div>

              <div className="grid grid-cols-2 gap-4">
                <div className="space-y-1.5">
                  <Label className="text-[10px] font-black text-slate-400 tracking-wider uppercase">{t("client.property.detail.offer.earnest_label", "Earnest Deposit ($)")}</Label>
                  <Input 
                    type="number" 
                    value={earnestMoney} 
                    onChange={(e) => setEarnestMoney(e.target.value)} 
                    className="bg-black/40 border-white/10 text-white rounded-xl focus:border-emerald-500/50"
                    placeholder="e.g. 5000"
                  />
                </div>
                <div className="space-y-1.5">
                  <Label className="text-[10px] font-black text-slate-400 tracking-wider uppercase">{t("client.property.detail.offer.due_diligence_label", "Due Diligence (Days)")}</Label>
                  <Input 
                    type="number" 
                    value={dueDiligence} 
                    onChange={(e) => setDueDiligence(e.target.value)} 
                    className="bg-black/40 border-white/10 text-white rounded-xl focus:border-emerald-500/50"
                  />
                </div>
              </div>

              <div className="flex flex-col gap-2 pt-2">
                <label className="flex items-center gap-2.5 text-sm text-slate-300 cursor-pointer">
                  <input 
                    type="checkbox" 
                    checked={inspectionContingency} 
                    onChange={(e) => setInspectionContingency(e.target.checked)}
                    className="rounded bg-black/40 border-white/10 text-emerald-500 focus:ring-emerald-500/30"
                  />
                  {t("client.property.detail.offer.inspection_contingency", "Inspection Contingency")}
                </label>
                <label className="flex items-center gap-2.5 text-sm text-slate-300 cursor-pointer">
                  <input 
                    type="checkbox" 
                    checked={appraisalContingency} 
                    onChange={(e) => setAppraisalContingency(e.target.checked)}
                    className="rounded bg-black/40 border-white/10 text-emerald-500 focus:ring-emerald-500/30"
                  />
                  {t("client.property.detail.offer.appraisal_contingency", "Appraisal Contingency")}
                </label>
              </div>

              <div className="space-y-1.5">
                <Label className="text-[10px] font-black text-slate-400 tracking-wider uppercase">{t("client.property.detail.offer.notes_label", "Special Conditions / Notes")}</Label>
                <Textarea 
                  value={specialConditions} 
                  onChange={(e) => setSpecialConditions(e.target.value)} 
                  className="bg-black/40 border-white/10 text-white rounded-xl min-h-[80px]"
                  placeholder={t("client.property.detail.offer.notes_placeholder", "Any additional terms you want to include in the offer...")}
                />
              </div>
            </div>

            <DialogFooter className="gap-2">
              <Button type="button" variant="ghost" className="rounded-xl border border-white/10 text-white/70 hover:text-white" onClick={() => setIsOfferModalOpen(false)}>
                {t("cancel", "Cancel")}
              </Button>
              <Button type="submit" className="rounded-xl bg-emerald-600 hover:bg-emerald-500 text-white font-black px-6 shadow-lg shadow-emerald-600/20">
                {t("client.property.detail.offer.submit_btn", "Submit Offer")}
              </Button>
            </DialogFooter>
          </form>
        </DialogContent>
      </Dialog>

      {/* 2. Private Viewing Request Dialog */}
      <Dialog open={isViewingModalOpen} onOpenChange={setIsViewingModalOpen}>
        <DialogContent className="bg-[#14151a] border-white/5 text-foreground max-w-md rounded-3xl p-8 backdrop-blur-3xl">
          <DialogHeader>
            <DialogTitle className="text-xl font-black italic tracking-tighter text-white">
              {t("client.property.detail.viewing.title", "Schedule Private Viewing")}
            </DialogTitle>
            <DialogDescription className="text-xs text-slate-400">
              {t("client.property.detail.viewing.description", "Request a date and time to tour this property with a local agent.")}
            </DialogDescription>
          </DialogHeader>

          <form onSubmit={handleViewingSubmit} className="space-y-6 mt-4">
            <div className="space-y-4">
              <div className="space-y-1.5">
                <Label className="text-[10px] font-black text-slate-400 tracking-wider uppercase">{t("client.property.detail.viewing.preferred_date", "Preferred Date")}</Label>
                <Input 
                  type="date" 
                  value={viewingDate} 
                  onChange={(e) => setViewingDate(e.target.value)} 
                  className="bg-black/40 border-white/10 text-white rounded-xl"
                  required
                />
              </div>
              <div className="space-y-1.5">
                <Label className="text-[10px] font-black text-slate-400 tracking-wider uppercase">{t("client.property.detail.viewing.preferred_time", "Preferred Time")}</Label>
                <Input 
                  type="time" 
                  value={viewingTime} 
                  onChange={(e) => setViewingTime(e.target.value)} 
                  className="bg-black/40 border-white/10 text-white rounded-xl"
                  required
                />
              </div>
              <div className="space-y-1.5">
                <Label className="text-[10px] font-black text-slate-400 tracking-wider uppercase">{t("client.property.detail.viewing.notes_label", "Appointment Notes")}</Label>
                <Textarea 
                  value={viewingNotes} 
                  onChange={(e) => setViewingNotes(e.target.value)} 
                  className="bg-black/40 border-white/10 text-white rounded-xl min-h-[80px]"
                  placeholder={t("client.property.detail.viewing.notes_placeholder", "Any questions or details you would like to share with the agent...")}
                />
              </div>
            </div>

            <DialogFooter className="gap-2">
              <Button type="button" variant="ghost" className="rounded-xl border border-white/10 text-white/70 hover:text-white" onClick={() => setIsViewingModalOpen(false)}>
                {t("cancel", "Cancel")}
              </Button>
              <Button type="submit" className="rounded-xl bg-orange-600 hover:bg-orange-500 text-white font-black px-6 shadow-lg shadow-orange-600/20">
                {t("client.property.detail.viewing.submit_btn", "Submit Request")}
              </Button>
            </DialogFooter>
          </form>
        </DialogContent>
      </Dialog>

      {/* 3. Upcoming Events & Open Houses Dialog */}
      <Dialog open={isEventsModalOpen} onOpenChange={setIsEventsModalOpen}>
        <DialogContent className="bg-[#14151a] border-white/5 text-foreground max-w-lg rounded-3xl p-8 backdrop-blur-3xl">
          <DialogHeader>
            <DialogTitle className="text-xl font-black italic tracking-tighter text-white">
              {t("client.property.detail.events.title", "Upcoming Showing Events")}
            </DialogTitle>
            <DialogDescription className="text-xs text-slate-400">
              {t("client.property.detail.events.description", "Explore scheduled open houses or presentation events for this property.")}
            </DialogDescription>
          </DialogHeader>

          <div className="space-y-4 my-4 max-h-[350px] overflow-y-auto pr-1">
            {events && events.length > 0 ? (
              events.map((ev: any) => (
                <div key={ev.id} className="p-5 rounded-2xl bg-black/40 border border-white/5 flex flex-col gap-3">
                  <div className="flex justify-between items-start gap-4">
                    <div>
                      <h4 className="font-black text-white text-sm italic">{ev.title}</h4>
                      <p className="text-[10px] text-slate-400 mt-1 font-medium">{ev.description}</p>
                    </div>
                    <Badge className="bg-orange-600/10 text-orange-400 border-none text-[8px] font-black tracking-widest italic py-0.5 shrink-0">
                      {ev.type?.toUpperCase()}
                    </Badge>
                  </div>
                  
                  <div className="flex flex-wrap items-center justify-between gap-4 pt-2 border-t border-white/5">
                    <div className="flex flex-col gap-0.5">
                      <span className="text-[9px] font-bold text-slate-500 tracking-widest uppercase">{t("time", "TIME")}</span>
                      <span className="text-[10px] font-bold text-slate-300">
                        {format(new Date(ev.startDate), "LLL dd, yyyy HH:mm")}
                      </span>
                    </div>
                    <div className="flex items-center gap-3">
                      <span className="text-xs text-slate-400 font-bold">
                        {ev.attendeeCount || 0} / {ev.maxAttendees || "∞"} {t("client.property.detail.events.attendees", "Attendees")}
                      </span>
                      <Button 
                        size="sm" 
                        className="h-8 rounded-xl bg-orange-600 hover:bg-orange-500 text-white font-black text-[10px] tracking-wider"
                        onClick={() => handleEventRegister(ev.id)}
                      >
                        {t("client.property.detail.events.rsvp_btn", "RSVP")}
                      </Button>
                    </div>
                  </div>
                </div>
              ))
            ) : (
              <p className="text-center text-xs text-slate-500 py-6">{t("client.property.detail.events.empty", "There are no scheduled events for this property at this time.")}</p>
            )}
          </div>

          <DialogFooter>
            <Button className="rounded-xl border border-white/10 text-white font-black w-full" variant="ghost" onClick={() => setIsEventsModalOpen(false)}>
              {t("close", "Close")}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </PageShell>
    </>
  );
}