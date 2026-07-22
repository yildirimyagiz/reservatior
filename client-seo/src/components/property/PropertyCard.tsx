import Image from "next/image";
import { Link } from "@/lib/react-router-shim";
import { m } from "framer-motion";
import { Heart, MapPin, Bed, Bath, Maximize2, ShieldCheck, Zap } from "lucide-react";
import { cn } from "@/lib/utils";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { QualityScoreBadge } from "@/components/cleaning/QualityScoreBadge";
import { ListingBadges } from "@/components/listing/ListingBadges";
import { Carousel, CarouselContent, CarouselItem, CarouselNext, CarouselPrevious } from "@/components/ui/carousel";
import { useTranslation } from "react-i18next";
import * as React from "react";
import Autoplay from "embla-carousel-autoplay";

export interface PropertyCardProps {
  property: any;
  index?: number;
}

export function PropertyCard({ property: p, index = 0 }: PropertyCardProps) {
  const { t } = useTranslation();
  
  const autoplayPlugin = React.useRef(
    Autoplay({ delay: 3000 + ((index % 5) * 500), stopOnInteraction: true })
  );

  const getStatusColor = (status: string) => {
    switch (status) {
      case "AVAILABLE": return "bg-green-500/90 text-white border-green-400";
      case "UNDER_CONTRACT": return "bg-amber-500/90 text-white border-amber-400";
      case "SOLD": return "bg-red-500/90 text-white border-red-400";
      case "RENTED": return "bg-blue-500/90 text-white border-blue-400";
      case "PENDING_APPROVAL": return "bg-purple-500/90 text-white border-purple-400";
      case "VACANT": return "bg-emerald-500/90 text-white border-emerald-400";
      case "RESERVED": return "bg-indigo-500/90 text-white border-indigo-400";
      case "BOOKED": return "bg-pink-500/90 text-white border-pink-400";
      default: return "bg-black/60 text-white border-white/20";
    }
  };

  const getPromotionBadge = (promo: string) => {
    switch (promo) {
      case "FEATURED": return <Badge className="bg-yellow-500/90 backdrop-blur text-black border-0 shadow-sm font-bold uppercase tracking-widest text-[9px]"><ShieldCheck className="w-3 h-3 mr-1"/> {t("client.src.featured", "FEATURED")}</Badge>;
      case "URGENT": return <Badge className="bg-red-500/90 backdrop-blur text-white border-0 shadow-sm font-bold uppercase tracking-widest text-[9px]"><Zap className="w-3 h-3 mr-1"/> {t("client.src.urgent", "URGENT")}</Badge>;
      case "PRICE_REDUCED": return <Badge className="bg-blue-500/90 backdrop-blur text-white border-0 shadow-sm font-bold uppercase tracking-widest text-[9px]">{t("client.src.price_reduced", "PRICE DROP")}</Badge>;
      case "BEST_DEAL": return <Badge className="bg-emerald-500/90 backdrop-blur text-white border-0 shadow-sm font-bold uppercase tracking-widest text-[9px]">{t("client.src.best_deal", "BEST DEAL")}</Badge>;
      default: return null;
    }
  };

  const isSale = p.listingType === "SALE";
  const isRent = p.listingType === "RENT";
  
  // Handle Prisma Decimal: can be number, string, or Decimal object with toString()
  const parsePrice = (val: any): number => {
    if (!val) return 0;
    if (typeof val === 'number') return val;
    if (typeof val === 'string') return parseFloat(val) || 0;
    if (typeof val === 'object' && val !== null) {
      if (typeof val.toNumber === 'function') return val.toNumber();
      if (typeof val.toString === 'function') return parseFloat(val.toString()) || 0;
    }
    return 0;
  };
  const priceVal = parsePrice(p.listingPrice) || parsePrice(p.price) || parsePrice(p.originalPrice) || 0;
  
  const formattedPrice = priceVal > 0 
    ? new Intl.NumberFormat('en-US', { style: 'currency', currency: p.currency || 'USD', maximumFractionDigits: 0 }).format(priceVal)
    : null;

  const displayImages = p.photos?.length > 0 
    ? p.photos.map((ph: any) => ph.url) 
    : [p.image || "https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?auto=format&fit=crop&w=800&q=80"];

  return (
    <m.article 
      initial={{ opacity: 0, y: 20 }} 
      animate={{ opacity: 1, y: 0 }} 
      transition={{ delay: index * 0.05, duration: 0.4, ease: "easeOut" }} 
      className="group cursor-pointer flex flex-col w-full h-full"
    >
      <div className="relative aspect-[4/3] rounded-[24px] overflow-hidden bg-muted border border-border/40 shadow-sm group-hover:shadow-2xl transition-all duration-500">
        {displayImages.length > 1 ? (
          <Carousel 
            className="w-full h-full" 
            plugins={[autoplayPlugin.current]}
            onMouseEnter={() => autoplayPlugin.current.stop()}
            onMouseLeave={() => autoplayPlugin.current.play()}
          >
            <CarouselContent className="h-full ml-0">
              {displayImages.map((img: string, idx: number) => (
                <CarouselItem key={idx} className="relative w-full h-full pl-0">
                  <Link to={`/property/${p.id}`} className="block w-full h-full">
                    <Image 
                      src={img} 
                      alt={`Optimized rental listing staging by Reservatior - ${p.name || 'Property'} - View ${idx + 1}`} 
                      fill 
                      className="object-cover transition-transform duration-700 group-hover:scale-105" 
                      loading="lazy" sizes="(max-width: 768px) 100vw, 50vw"
                    />
                  </Link>
                </CarouselItem>
              ))}
            </CarouselContent>
            <CarouselPrevious 
              className="absolute left-4 top-1/2 -translate-y-1/2 h-8 w-8 bg-black/20 hover:bg-black/40 text-white border-0 opacity-0 group-hover:opacity-100 transition-opacity z-20"
              onClick={(e) => { e.preventDefault(); e.stopPropagation(); }}
            />
            <CarouselNext 
              className="absolute right-4 top-1/2 -translate-y-1/2 h-8 w-8 bg-black/20 hover:bg-black/40 text-white border-0 opacity-0 group-hover:opacity-100 transition-opacity z-20"
              onClick={(e) => { e.preventDefault(); e.stopPropagation(); }}
            />
          </Carousel>
        ) : (
          <Link to={`/property/${p.id}`} className="block w-full h-full">
            <Image 
              src={displayImages[0]} 
              alt={`Optimized rental listing staging by Reservatior - ${p.name || 'Property'}`} 
              fill 
              className="object-cover transition-transform duration-700 group-hover:scale-105" 
              loading="lazy" sizes="(max-width: 768px) 100vw, 50vw"
            />
          </Link>
        )}
        {/* Top Badges */}
        <div className="absolute top-4 left-4 flex flex-col gap-2 items-start pointer-events-none z-10">
          <div className="flex items-start gap-2">
            <Badge className="bg-white/90 backdrop-blur-md text-black border-0 font-black px-3 py-1 shadow-xl uppercase tracking-[0.2em] text-[8px]">
              {isSale ? t("client.src.for_sale", "FOR SALE") : isRent ? t("client.src.for_rent", "FOR RENT") : t("client.src.booking", "BOOKING")}
            </Badge>
            {p.qualityScore != null && (
              <QualityScoreBadge score={p.qualityScore} size="sm" showLabel={false} />
            )}
          </div>
          {getPromotionBadge(p.promotion)}
          <ListingBadges
            isOptimizedForSpeed={p.isOptimizedForSpeed}
            optimizationStatus={p.optimizationStatus}
            vacancyDays={p.vacancyDays}
            isPromoted={p.isPromoted}
            className="mt-1"
          />
        </div>

        {/* Favorite Button */}
        <div className="absolute top-4 right-4 z-10">
          <Button 
            size="icon" 
            variant="ghost" 
            aria-label="Add to favorites"
            className="h-10 w-10 rounded-full bg-black/20 backdrop-blur-md hover:bg-white text-white hover:text-red-500 border border-white/20 transition-all duration-300"
          >
            <Heart className="w-4 h-4" />
          </Button>
        </div>
      </div>
      
      {/* External Details Area */}
      <Link to={`/property/${p.id}`} className="flex flex-col gap-3 px-2 pt-5">
        
        {/* Title & Status */}
        <div className="flex items-start justify-between gap-4">
          <h2 className="font-black text-foreground text-lg tracking-tight line-clamp-1">
            {p.name}
          </h2>
          <span className={cn("shrink-0 px-2.5 py-1 rounded-md text-[9px] font-black uppercase tracking-wider", getStatusColor(p.listingStatus))}>
            {p.listingStatus.replace(/_/g, " ")}
          </span>
        </div>

        {/* Location */}
        <div className="flex items-center gap-1.5 -mt-1">
          <MapPin className="w-3.5 h-3.5 text-muted-foreground shrink-0" />
          <span className="text-muted-foreground text-sm font-medium truncate">{p.city}, {p.country}</span>
        </div>

        {/* Features Row */}
        <div className="flex items-center gap-4 text-muted-foreground mt-1">
          {p.bedrooms > 0 && (
            <div className="flex items-center gap-1.5">
              <Bed className="w-4 h-4 text-primary"/> 
              <span className="text-sm font-bold text-foreground">{p.bedrooms} <span className="font-medium text-muted-foreground text-xs">Beds</span></span>
            </div>
          )}
          {p.bathrooms > 0 && (
            <div className="flex items-center gap-1.5">
              <Bath className="w-4 h-4 text-primary"/> 
              <span className="text-sm font-bold text-foreground">{p.bathrooms} <span className="font-medium text-muted-foreground text-xs">Baths</span></span>
            </div>
          )}
          {p.areaSqm > 0 && (
            <div className="flex items-center gap-1.5">
              <Maximize2 className="w-4 h-4 text-primary"/> 
              <span className="text-sm font-bold text-foreground">{p.areaSqm} <span className="font-medium text-muted-foreground text-xs">m²</span></span>
            </div>
          )}
          
          <div className="ml-auto text-xs font-semibold text-muted-foreground bg-muted px-2 py-1 rounded-md border border-border/50">
            {p.propertyCategory.replace(/_/g, " ")}
          </div>
        </div>

        {/* Price Row */}
        <div className="mt-2 pt-4 border-t border-border flex items-end justify-between">
          <div className="flex flex-col">
            <span className="text-xs font-bold text-muted-foreground uppercase tracking-widest mb-1">
              {isSale ? 'Asking Price' : 'Rate'}
            </span>
            <span className="text-2xl font-black text-foreground tracking-tight">
              {formattedPrice || 'Price on Request'}
              {isRent && formattedPrice && <span className="text-sm font-medium text-muted-foreground ml-1">/mo</span>}
            </span>
          </div>
        </div>
      </Link>
    </m.article>
  );
}
