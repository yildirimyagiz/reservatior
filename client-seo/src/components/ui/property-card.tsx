import React, { useState } from "react";
import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Bed, Bath, Square, MapPin, Building } from "lucide-react";
import { Carousel, CarouselContent, CarouselItem, CarouselNext, CarouselPrevious } from "@/components/ui/carousel";
import { getProjectAssets, getPropertyCoverMedia } from "@/lib/project-media";

export interface PropertyCardProps {
  property: any;
  viewMode?: "grid" | "list";
  onHover?: (id: string | null) => void;
  onClick?: (property: any) => void;
}

export function PropertyCard({ property, viewMode = "grid", onHover, onClick }: PropertyCardProps) {
  const { videoUrl, imageUrl } = getPropertyCoverMedia(property);
  const assets = getProjectAssets(property);
  
  // Combine cover image with other photos if available
  let photos = assets?.photos || [];
  if (imageUrl && !photos.includes(imageUrl)) {
    photos = [imageUrl, ...photos];
  }
  if (photos.length === 0 && imageUrl) {
    photos = [imageUrl];
  }

  const [isHovered, setIsHovered] = useState(false);

  const handleMouseEnter = () => {
    setIsHovered(true);
    onHover?.(property.id);
  };

  const handleMouseLeave = () => {
    setIsHovered(false);
    onHover?.(null);
  };

  const handleClick = () => {
    if (onClick) onClick(property);
    else window.open(`/client/property/${property.id}`, '_blank');
  };

  if (viewMode === "list") {
    // List View Layout
    return (
      <Card 
        onMouseEnter={handleMouseEnter}
        onMouseLeave={handleMouseLeave}
        className="bg-background/40 border-slate-200 dark:border-white/5 rounded-2xl overflow-hidden hover:border-white/10 transition-all cursor-pointer group flex flex-row h-48"
      >
        <div className="w-1/3 bg-slate-900 relative overflow-hidden shrink-0">
          <Carousel className="w-full h-full">
            <CarouselContent className="h-full">
              {photos.length > 0 ? (
                photos.map((src, idx) => (
                  <CarouselItem key={idx} className="h-full">
                    <img 
                      src={src} 
                      alt={property.name} 
                      className="w-full h-full object-cover transition-transform duration-700 group-hover:scale-105"
                      loading={idx === 0 ? "eager" : "lazy"}
                    />
                  </CarouselItem>
                ))
              ) : videoUrl ? (
                <CarouselItem className="h-full">
                  <video 
                    src={videoUrl}
                    className="w-full h-full object-cover transition-transform duration-700 group-hover:scale-105"
                    autoPlay loop muted playsInline
                  />
                </CarouselItem>
              ) : (
                <CarouselItem className="h-full flex items-center justify-center">
                  <Building className="w-12 h-12 text-muted-foreground opacity-50" />
                </CarouselItem>
              )}
            </CarouselContent>
            {photos.length > 1 && (
              <>
                <CarouselPrevious className="absolute left-2 top-1/2 -translate-y-1/2 w-8 h-8 opacity-0 group-hover:opacity-100 transition-opacity bg-white/80 dark:bg-black/50 hover:bg-white dark:hover:bg-black text-slate-900 dark:text-white border-none shadow-md" />
                <CarouselNext className="absolute right-2 top-1/2 -translate-y-1/2 w-8 h-8 opacity-0 group-hover:opacity-100 transition-opacity bg-white/80 dark:bg-black/50 hover:bg-white dark:hover:bg-black text-slate-900 dark:text-white border-none shadow-md" />
              </>
            )}
          </Carousel>
          <div className="absolute inset-0 bg-gradient-to-t from-[#0a0b0d]/80 via-transparent to-transparent pointer-events-none" />
          <Badge className="absolute top-3 left-3 bg-success/90 text-slate-900 dark:text-white border-none shadow-lg">
            {property.listingStatus}
          </Badge>
        </div>
        <CardContent className="p-5 flex-1 flex flex-col justify-between">
          <div>
            <div className="flex justify-between items-start">
              <h3 className="font-black text-slate-900 dark:text-white text-xl tracking-tight mb-1 truncate">{property.name}</h3>
              <div className="text-right flex flex-col items-end">
                <span className="text-[10px] text-slate-500 font-bold uppercase tracking-wider mb-0.5">
                  {property.listingType === 'BOOKING' ? 'Gecelik Fiyat' : property.listingType === 'RENT' ? 'Aylık Kira' : 'Satış Fiyatı'}
                </span>
                <span className="text-xl font-black text-slate-900 dark:text-white tracking-tighter">
                  ${property.listingPrice?.toLocaleString()}
                  {property.listingType === 'RENT' && <span className="text-xs text-slate-400 font-normal"> / Ay</span>}
                  {property.listingType === 'BOOKING' && <span className="text-xs text-slate-400 font-normal"> / Gece</span>}
                </span>
              </div>
            </div>
            <p className="text-xs text-slate-400 mb-3 truncate flex items-center">
              <MapPin className="w-3 h-3 mr-1" />
              {property.addressLine1 || property.city}
            </p>
            <div className="flex items-center gap-4 text-xs font-semibold text-slate-300 mb-4 bg-white/5 p-2 rounded-xl inline-flex">
              <span className="flex items-center gap-1.5"><Bed className="w-4 h-4 text-slate-400" />{property.bedrooms}</span>
              <span className="flex items-center gap-1.5"><Bath className="w-4 h-4 text-slate-400" />{property.bathrooms}</span>
              <span className="flex items-center gap-1.5"><Square className="w-4 h-4 text-slate-400" />{property.areaSqm}m²</span>
            </div>
            <div className="flex flex-wrap gap-2">
              {((property as any).amenities || ['Yüzme Havuzu', 'Otopark (Kapalı)']).slice(0, 3).map((am: string, i: number) => (
                  <span key={i} className="text-[10px] bg-slate-100 dark:bg-white/10 text-slate-600 dark:text-slate-300 px-2 py-1 rounded-md">{am}</span>
              ))}
            </div>
          </div>
          <div className="flex justify-end mt-2">
            <Button size="sm" className={property.listingType === 'BOOKING' ? "bg-brand text-slate-900 dark:text-white hover:bg-brand/90 rounded-xl font-bold px-6" : "bg-white text-black hover:bg-slate-200 rounded-xl font-bold px-8"} onClick={(e) => { e.stopPropagation(); handleClick(); }}>
              {property.listingType === 'BOOKING' ? 'Rezervasyon' : property.listingType === 'RENT' ? 'Kirala' : 'İncele'}
            </Button>
          </div>
        </CardContent>
      </Card>
    );
  }

  // Grid View Layout (Default)
  return (
    <Card 
      onMouseEnter={handleMouseEnter}
      onMouseLeave={handleMouseLeave}
      className="bg-background/40 border-slate-200 dark:border-white/5 rounded-2xl overflow-hidden hover:border-white/10 transition-all cursor-pointer group flex flex-col h-full"
    >
      <div className="h-56 bg-slate-900 relative overflow-hidden shrink-0">
        <Carousel className="w-full h-full">
          <CarouselContent className="h-full">
            {photos.length > 0 ? (
              photos.map((src, idx) => (
                <CarouselItem key={idx} className="h-full">
                  <img 
                    src={src} 
                    alt={property.name} 
                    className="w-full h-full object-cover transition-transform duration-700 group-hover:scale-105"
                    loading={idx === 0 ? "eager" : "lazy"}
                  />
                </CarouselItem>
              ))
            ) : videoUrl ? (
              <CarouselItem className="h-full">
                <video 
                  src={videoUrl}
                  className="w-full h-full object-cover transition-transform duration-700 group-hover:scale-105"
                  autoPlay loop muted playsInline
                />
              </CarouselItem>
            ) : (
              <CarouselItem className="h-full flex items-center justify-center">
                <Building className="w-16 h-16 text-muted-foreground opacity-50" />
              </CarouselItem>
            )}
          </CarouselContent>
          {photos.length > 1 && (
            <>
              <CarouselPrevious className="absolute left-2 top-1/2 -translate-y-1/2 w-8 h-8 opacity-0 group-hover:opacity-100 transition-opacity bg-white/80 dark:bg-black/50 hover:bg-white dark:hover:bg-black text-slate-900 dark:text-white border-none shadow-md" />
              <CarouselNext className="absolute right-2 top-1/2 -translate-y-1/2 w-8 h-8 opacity-0 group-hover:opacity-100 transition-opacity bg-white/80 dark:bg-black/50 hover:bg-white dark:hover:bg-black text-slate-900 dark:text-white border-none shadow-md" />
            </>
          )}
        </Carousel>
        
        {/* Gradient Overlay for Text Readability */}
        <div className="absolute inset-0 bg-gradient-to-t from-[#0a0b0d] via-[#0a0b0d]/20 to-transparent pointer-events-none" />

        {/* Top Right Badges */}
        <div className="absolute top-3 right-3 flex flex-col gap-2 items-end z-10 pointer-events-none">
          <Badge className="bg-success/90 text-slate-900 dark:text-white border-none shadow-lg">
            {property.listingStatus}
          </Badge>
          {/* Advanced Tags Badges */}
          {(property as any).uiTags?.includes('acil') && (
            <Badge className="bg-red-500 text-slate-900 dark:text-white border-none shadow-lg animate-pulse">🚨 Acil</Badge>
          )}
          {(property as any).uiTags?.includes('fiyati_dusen') && (
            <Badge className="bg-orange-500 text-slate-900 dark:text-white border-none shadow-lg">📉 Fiyatı Düşen</Badge>
          )}
          {(property as any).uiTags?.includes('firsat') && (
            <Badge className="bg-brand text-slate-900 dark:text-white border-none shadow-lg">💎 Fırsat</Badge>
          )}
        </div>
      </div>
      
      <CardContent className="p-5 flex-1 flex flex-col">
        <h3 className="font-black text-slate-900 dark:text-white text-lg tracking-tight mb-2 truncate">{property.name}</h3>
        <p className="text-xs text-slate-400 mb-4 truncate flex items-center">
          <MapPin className="w-3 h-3 mr-1" />
          {property.addressLine1 || property.city}
        </p>
        
        <div className="flex items-center gap-4 text-xs font-semibold text-slate-300 mb-5 bg-white/5 p-3 rounded-xl">
          <span className="flex items-center gap-1.5"><Bed className="w-4 h-4 text-slate-400" />{property.bedrooms}</span>
          <span className="flex items-center gap-1.5"><Bath className="w-4 h-4 text-slate-400" />{property.bathrooms}</span>
          <span className="flex items-center gap-1.5"><Square className="w-4 h-4 text-slate-400" />{property.areaSqm}m²</span>
        </div>
        
        <div className="flex flex-wrap gap-2 mb-4 flex-1">
          {((property as any).amenities || ['Yüzme Havuzu', 'Otopark (Kapalı)']).slice(0, 3).map((am: string, i: number) => (
              <span key={i} className="text-[10px] bg-slate-100 dark:bg-white/10 text-slate-600 dark:text-slate-300 px-2 py-1 rounded-md">{am}</span>
          ))}
        </div>

        <div className="flex items-center justify-between mt-auto">
          <div className="flex flex-col">
            <span className="text-[10px] text-slate-500 font-bold uppercase tracking-wider mb-0.5">
              {property.listingType === 'BOOKING' ? 'Gecelik Fiyat' : property.listingType === 'RENT' ? 'Aylık Kira' : 'Satış Fiyatı'}
            </span>
            <span className="text-xl font-black text-slate-900 dark:text-white tracking-tighter">
              ${property.listingPrice?.toLocaleString()}
              {property.listingType === 'RENT' && <span className="text-sm text-slate-400 font-normal"> / Ay</span>}
              {property.listingType === 'BOOKING' && <span className="text-sm text-slate-400 font-normal"> / Gece</span>}
            </span>
          </div>
          <Button size="sm" className={property.listingType === 'BOOKING' ? "bg-brand text-slate-900 dark:text-white hover:bg-brand/90 rounded-xl font-bold px-4" : "bg-white text-black hover:bg-slate-200 rounded-xl font-bold px-6"} onClick={(e) => { e.stopPropagation(); handleClick(); }}>
            {property.listingType === 'BOOKING' ? 'Rezervasyon' : property.listingType === 'RENT' ? 'Kirala' : 'İncele'}
          </Button>
        </div>
      </CardContent>
    </Card>
  );
}
