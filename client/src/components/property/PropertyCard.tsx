import { Link } from "react-router-dom";
import { motion } from "framer-motion";
import { Heart, MapPin, Bed, Bath, Maximize2, ShieldCheck, Zap } from "lucide-react";
import { cn } from "@/lib/utils";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
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
    <motion.div 
      initial={{ opacity: 0, y: 20 }} 
      animate={{ opacity: 1, y: 0 }} 
      transition={{ delay: index * 0.05, duration: 0.4, ease: "easeOut" }} 
      className="group cursor-pointer flex flex-col w-full h-full"
    >
      <div className="relative aspect-4/3 rounded-[24px] overflow-hidden bg-muted border border-border/40 shadow-sm group-hover:shadow-2xl transition-all duration-500">
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
                  <Link to={`/properties/${p.id}`} className="block w-full h-full">
                    <img 
                      src={img} 
                      alt={`${p.name} - ${idx + 1}`} 
                      className="w-full h-full object-cover transition-transform duration-700 group-hover:scale-105" 
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
          <Link to={`/properties/${p.id}`} className="block w-full h-full">
            <img 
              src={displayImages[0]} 
              alt={p.name} 
              className="w-full h-full object-cover transition-transform duration-700 group-hover:scale-105" 
            />
          </Link>
        )}
        {/* Gradient Overlay - inline style for Tailwind v4 compatibility */}
        <div 
          className="absolute inset-0 pointer-events-none"
          style={{ background: 'linear-gradient(to bottom, rgba(0,0,0,0.05) 0%, rgba(0,0,0,0) 35%, rgba(0,0,0,0.6) 70%, rgba(0,0,0,0.92) 100%)' }}
        />
        
        {/* Top Badges */}
        <div className="absolute top-4 left-4 flex flex-col gap-2 items-start pointer-events-none z-10">
          <Badge className="bg-white/90 backdrop-blur-md text-black border-0 font-black px-3 py-1 shadow-xl uppercase tracking-[0.2em] text-[8px]">
            {isSale ? t("client.src.for_sale", "FOR SALE") : isRent ? t("client.src.for_rent", "FOR RENT") : t("client.src.booking", "BOOKING")}
          </Badge>
          {getPromotionBadge(p.promotion)}
        </div>

        {/* Favorite Button */}
        <div className="absolute top-4 right-4 z-10">
          <Button 
            size="icon" 
            variant="ghost" 
            className="h-9 w-9 rounded-full bg-black/20 backdrop-blur-md hover:bg-white text-white hover:text-red-500 border border-white/20 transition-all duration-300"
          >
            <Heart className="w-4 h-4" />
          </Button>
        </div>

        {/* Bottom Content Inside Image */}
        <div className="absolute bottom-0 left-0 right-0 z-10 flex flex-col gap-2 pointer-events-none p-5">
          <div className="flex justify-between items-end gap-2">
            <div className="flex flex-col">
              <span style={{ color: '#ffffff', fontWeight: 900, fontSize: '1.5rem', letterSpacing: '-0.05em', textShadow: '0 2px 8px rgba(0,0,0,0.7)' }}>
                {formattedPrice || 'Price on Request'}
                {isRent && formattedPrice && <span style={{ color: 'rgba(255,255,255,0.7)', fontSize: '0.875rem', fontWeight: 500, marginLeft: '4px' }}>/mo</span>}
              </span>
              <h3 style={{ color: 'rgba(255,255,255,0.95)', fontWeight: 700, fontSize: '0.875rem', lineHeight: '1.25', textShadow: '0 1px 4px rgba(0,0,0,0.5)' }} className="line-clamp-1">
                {p.name}
              </h3>
            </div>
            
            <div className="shrink-0">
               <span className={cn("px-2.5 py-1 rounded-full text-[9px] font-black uppercase tracking-wider border backdrop-blur-md shadow-sm", getStatusColor(p.listingStatus))}>
                {p.listingStatus.replace(/_/g, " ")}
              </span>
            </div>
          </div>

          <div className="flex items-center gap-1.5 mt-1">
            <MapPin className="w-3 h-3 shrink-0" style={{ color: '#ffffff' }} />
            <span style={{ color: 'rgba(255,255,255,0.8)', fontSize: '0.75rem', textShadow: '0 1px 3px rgba(0,0,0,0.5)' }} className="truncate">{p.city}, {p.country}</span>
          </div>
        </div>
      </div>
      
      {/* External Details Area */}
      <Link to={`/properties/${p.id}`} className="flex flex-col gap-3 px-2 pt-4">
        {/* Features Row */}
        <div className="flex items-center gap-4 text-muted-foreground">
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

        {/* Amenities Preview */}
        {p.features && p.features.length > 0 && (
          <div className="flex flex-wrap gap-1.5 mt-1">
            {p.features.slice(0, 3).map((f: string) => (
              <span key={f} className="text-[10px] bg-primary/10 text-primary font-semibold px-2 py-0.5 rounded-full">
                {f.replace(/_/g, " ")}
              </span>
            ))}
            {p.features.length > 3 && (
              <span className="text-[10px] bg-muted text-muted-foreground font-semibold px-2 py-0.5 rounded-full border border-border/50">
                +{p.features.length - 3}
              </span>
            )}
          </div>
        )}
      </Link>
    </motion.div>
  );
}
