import Image from "next/image";
import { useState } from "react";
import { useQuery } from "@tanstack/react-query";
import { useTranslation } from "react-i18next";
import { m, AnimatePresence } from "framer-motion";
import { Card } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Separator } from "@/components/ui/separator";
import {
  Building2,
  MapPin,
  Star,
  TrendingDown,
  TrendingUp,
  ExternalLink,
  Loader2,
  ChevronDown,
  ChevronUp,
  Hotel,
  Home,
  Expand,
  BedDouble,
  Bath,
} from "lucide-react";
import { cn } from "@/lib/utils";
import { hotelAlternativesApi } from "@/lib/api/hotel-alternatives";
import type { HotelAlternativeSearchInput, HotelAlternativeResponse } from "@/lib/api/hotel-alternatives";

interface Props {
  destination: string;
  checkIn: string;
  checkOut: string;
  guests: number;
  currentPrice?: number;
  currency?: string;
  propertyName?: string;
  className?: string;
}

export function HotelAlternatives({
  destination,
  checkIn,
  checkOut,
  guests,
  currentPrice,
  currency = "USD",
  propertyName,
  className,
}: Props) {
  const { t } = useTranslation();
  const [expanded, setExpanded] = useState(false);

  const input: HotelAlternativeSearchInput | null =
    destination && checkIn && checkOut
      ? { destination, checkIn, checkOut, guests, currentPrice, currency, propertyName }
      : null;

  const { data, isLoading, isError } = useQuery({
    queryKey: ["hotel-alternatives", destination, checkIn, guests, currentPrice],
    queryFn: () => hotelAlternativesApi.getAlternatives(input!),
    enabled: !!input,
    staleTime: 60_000,
  });

  const result = data?.data;
  const alternatives = result?.alternatives ?? [];
  const hasCheaper = alternatives.some((a) => a.priceComparison.isCheaper);

  if (!input || (!isLoading && alternatives.length === 0)) return null;

  return (
    <Card
      className={cn(
        "overflow-hidden border transition-all",
        hasCheaper
          ? "border-blue-500/30 bg-blue-500/5"
          : "border-white/5 bg-[#14151a]/40",
        className
      )}
    >
      <button
        onClick={() => setExpanded(!expanded)}
        className="w-full flex items-center justify-between p-4 text-left"
      >
        <div className="flex items-center gap-3">
          <div
            className={cn(
              "w-10 h-10 rounded-xl flex items-center justify-center",
              hasCheaper ? "bg-blue-500/20" : "bg-white/10"
            )}
          >
            <Hotel
              className={cn(
                "w-5 h-5",
                hasCheaper ? "text-blue-400" : "text-white/60"
              )}
            />
          </div>
          <div>
            <p className="font-black text-white text-sm tracking-tight">
              {propertyName ? t("hotel.alternatives.title.property", "Alternatif Konaklama") : t("hotel.alternatives.title.local", "Bölgedeki Konaklama")}
            </p>
            {isLoading ? (
              <p className="text-xs text-white/40 flex items-center gap-1">
                <Loader2 className="w-3 h-3 animate-spin" />
                {t("hotel.alternatives.loading", "En iyi fiyatlar araştırılıyor...")}
              </p>
            ) : hasCheaper ? (
              <p className="text-xs text-blue-400 font-bold">
                {t("hotel.alternatives.cheaperFound", "✅ Daha ucuz konaklama seçenekleri bulundu!")}
              </p>
            ) : (
              <p className="text-xs text-white/40">
                {alternatives.length} {t("hotel.alternatives.count", "alternatif")}
              </p>
            )}
          </div>
        </div>
        <div className="flex items-center gap-2">
          {!isLoading && hasCheaper && (
            <Badge className="bg-blue-500 text-white border-none text-[10px] font-black tracking-widest">
              {t("hotel.alternatives.opportunity", "FIRSAT")}
            </Badge>
          )}
          {expanded ? (
            <ChevronUp className="w-4 h-4 text-white/40" />
          ) : (
            <ChevronDown className="w-4 h-4 text-white/40" />
          )}
        </div>
      </button>

      <AnimatePresence>
        {expanded && (
          <m.div
            initial={{ height: 0, opacity: 0 }}
            animate={{ height: "auto", opacity: 1 }}
            exit={{ height: 0, opacity: 0 }}
            transition={{ duration: 0.2 }}
          >
            <Separator className="bg-white/5" />
            <div className="p-4 space-y-3 max-h-[400px] overflow-y-auto">
              {isLoading ? (
                <div className="flex items-center justify-center py-8">
                  <Loader2 className="w-6 h-6 animate-spin text-white/40" />
                </div>
              ) : (
                alternatives.map((item, i) => {
                  const isOwnInventory = item.isOwnInventory;
                  const isCheaper = item.priceComparison.isCheaper;

                  const getLabel = (type: string) => {
                    if (type === "VILLA") return t("property.type.villa", "VİLLA");
                    if (type === "CONDO_APARTMENT" || type === "CONDO") return t("property.type.residence", "REZİDANS");
                    if (type === "STUDIO") return t("property.type.studio", "STÜDYO");
                    if (type === "PENTHOUSE") return t("property.type.penthouse", "PENTHOUSE");
                    return t("property.type.apartment", "DAİRE");
                  };

                  return (
                    <div
                      key={i}
                      className={cn(
                        "flex items-start gap-3 p-3 rounded-xl transition-all border",
                        isOwnInventory
                          ? "bg-violet-500/10 border-violet-500/20"
                          : isCheaper
                            ? "bg-blue-500/10 border-blue-500/20"
                            : "bg-white/5 border-transparent hover:bg-white/10"
                      )}
                    >
                      <div className="w-16 h-16 rounded-lg overflow-hidden shrink-0 bg-white/10 relative">
                        {item.photos[0] ? (
                          <Image
                            src={item.photos[0]}
                            alt={item.name}
                            fill
                            className="object-cover"
                            loading="lazy" sizes="(max-width: 768px) 100vw, 50vw"
                          />
                        ) : (
                          <div className="w-full h-full flex items-center justify-center">
                            {isOwnInventory ? (
                              <Home className="w-6 h-6 text-violet-400/50" />
                            ) : (
                              <Building2 className="w-6 h-6 text-white/30" />
                            )}
                          </div>
                        )}
                      </div>

                      <div className="flex-1 min-w-0">
                        <div className="flex items-center gap-1.5">
                          {isOwnInventory && (
                            <Home className="w-3.5 h-3.5 text-violet-400 shrink-0" />
                          )}
                          <p className="font-black text-white text-sm truncate">
                            {item.name}
                          </p>
                          {!isOwnInventory && item.starRating > 0 && (
                            <div className="flex items-center gap-0.5 shrink-0">
                              <Star className="w-3 h-3 text-yellow-400 fill-yellow-400" />
                              <span className="text-[10px] font-bold text-white/60">
                                {item.starRating}
                              </span>
                            </div>
                          )}
                        </div>

                        <div className="flex items-center gap-2 mt-0.5">
                          <MapPin className="w-3 h-3 text-white/30" />
                          <span className="text-[10px] text-white/40 truncate">
                            {item.city}, {item.country}
                          </span>
                          {isOwnInventory ? (
                            <Badge className="bg-violet-500/20 text-violet-300 text-[8px] font-bold border-none px-1.5 py-0">
                              {getLabel(item.type)}
                            </Badge>
                          ) : (
                            <Badge className="bg-white/10 text-white/60 text-[8px] font-bold border-none px-1.5 py-0">
                              {item.provider}
                            </Badge>
                          )}
                        </div>

                        <p className="text-[11px] text-white/50 mt-0.5 line-clamp-1">
                          {isOwnInventory ? (
                            <>
                              {item.bedrooms} {t("hotel.alternatives.bedrooms", "Yatak Odalı")} {getLabel(item.type)}
                              {item.areaSqm ? ` · ${item.areaSqm}m²` : ""}
                              {item.bathrooms ? ` · ${item.bathrooms} ${t("hotel.alternatives.bathrooms", "Banyo")}` : ""}
                            </>
                          ) : (
                            <>{item.roomName} · {item.boardName}</>
                          )}
                        </p>

                        <div className="flex items-center justify-between mt-2">
                          <div className="flex items-center gap-2">
                            <span className="text-lg font-black text-white italic tracking-tight">
                              {item.currency} {item.grossPrice}
                            </span>
                            {item.priceComparison.isCheaper && currentPrice && (
                              <span className="text-[10px] text-blue-400 font-bold flex items-center gap-0.5">
                                <TrendingDown className="w-3 h-3" />
                                %{Math.abs(item.priceComparison.differencePercent)} {t("hotel.alternatives.cheaper", "ucuz")}
                              </span>
                            )}
                            {!item.priceComparison.isCheaper && currentPrice && (
                              <span className="text-[10px] text-orange-400/60 font-bold flex items-center gap-0.5">
                                <TrendingUp className="w-3 h-3" />
                                +%{Math.abs(item.priceComparison.differencePercent)}
                              </span>
                            )}
                          </div>
                        </div>
                      </div>
                    </div>
                  );
                })
              )}
            </div>
          </m.div>
        )}
      </AnimatePresence>
    </Card>
  );
}
