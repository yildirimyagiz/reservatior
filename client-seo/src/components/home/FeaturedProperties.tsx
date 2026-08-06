"use client";
import Image from "next/image";
import { useTranslation } from "react-i18next";
import { Link } from "@/lib/react-router-shim";
import { ArrowRight, MapPin, Bed, Bath, Square, Play, Video, Camera } from "lucide-react";
import { m } from "framer-motion";
import { useQuery } from "@tanstack/react-query";
import { propertiesApi } from "@/lib/api/properties-fetch";

interface FeaturedCard {
  id: string;
  title: string;
  price: string;
  address: string;
  type: string;
  coverImage: string;
  video: boolean;
  stats: {
    beds: number;
    baths: number;
    sqft: number;
  };
}

const CURRENCY_SYMBOLS: Record<string, string> = {
  TRY: "₺",
  EUR: "€",
  GBP: "£",
  USD: "$",
  AED: "AED "
};

function toCard(property: any): FeaturedCard {
  return {
    id: property.id,
    title: property.name || "Untitled property",
    price: property.listingPrice != null
      ? `${CURRENCY_SYMBOLS[property.currency] ?? "$"}${Number(property.listingPrice).toLocaleString()}`
      : "",
    address: property.addressLine1 || [property.city, property.stateCode].filter(Boolean).join(", ") || "",
    type: property.type,
    coverImage: property.photos?.[0]?.url ?? "",
    video: false,
    stats: {
      beds: property.bedrooms ?? 0,
      baths: property.bathrooms ?? 0,
      sqft: property.areaSqm ?? 0
    }
  };
}

export function FeaturedProperties() {
  const {
    t
  } = useTranslation();

  const { data: properties = [], isLoading } = useQuery<FeaturedCard[]>({
    queryKey: ["home", "featured-properties"],
    queryFn: async () => {
      const res = await propertiesApi.getAll({ page: 1, limit: 6, sortBy: "date_desc" });
      const items = (res as any)?.data ?? [];
      return items.map(toCard);
    }
  });

  return <section className="py-24 px-4 md:px-6 container mx-auto">
      <div className="flex items-end justify-between mb-12">
        <div>
          <h2 className="text-2xl md:text-3xl font-display font-medium tracking-wide mb-4">{t("client.src.featured_properties")}</h2>
          <p className="text-muted-foreground max-w-xl">{t("client.src.explore_our_curated_selection")}</p>
        </div>
        <Link to="/property">
          <span className="hidden md:flex items-center text-primary font-medium hover:underline cursor-pointer">{t("client.src.view_all_listings")}<ArrowRight className="ml-2 w-4 h-4" />
          </span>
        </Link>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
        {isLoading && [0, 1, 2].map(i => <div key={i} className="bg-card border border-border rounded-2xl overflow-hidden animate-pulse">
            <div className="aspect-[4/3] bg-muted" />
            <div className="p-5 space-y-4">
              <div className="h-5 bg-muted rounded w-2/3" />
              <div className="h-4 bg-muted rounded w-1/2" />
              <div className="h-4 bg-muted rounded w-full" />
            </div>
          </div>)}

        {!isLoading && properties.length === 0 && <div className="col-span-full text-center py-16 text-muted-foreground">
            <Camera className="w-12 h-12 mx-auto mb-4 opacity-40" />
            <p>{t("client.src.no_properties_found_1")}</p>
          </div>}

        {!isLoading && properties.map((prop, index) => <m.div key={prop.id} initial={{
        opacity: 0,
        y: 20
      }} whileInView={{
        opacity: 1,
        y: 0
      }} viewport={{
        once: true
      }} transition={{
        delay: index * 0.1
      }} className="group relative bg-card border border-border rounded-2xl overflow-hidden hover:shadow-2xl hover:shadow-primary/10 transition-all duration-300 hover:-translate-y-1">
            <Link to={`/property/${prop.id}`}>
              <div className="aspect-[4/3] overflow-hidden relative">
                {prop.coverImage ? <Image src={prop.coverImage} alt={prop.title} fill className="object-cover transition-transform duration-700 group-hover:scale-110" loading="lazy" sizes="(max-width: 768px) 100vw, 50vw" /> : <div className="w-full h-full flex items-center justify-center bg-muted">
                    <Camera className="w-16 h-16 text-muted-foreground/40" />
                  </div>}

                {/* Video Play Indicator */}
                {prop.video && <div className="absolute inset-0 flex items-center justify-center opacity-0 group-hover:opacity-100 transition-opacity duration-300">
                    <div className="w-16 h-16 rounded-full bg-primary/90 flex items-center justify-center text-white shadow-2xl scale-50 group-hover:scale-100 transition-transform duration-500">
                      <Play className="w-8 h-8 fill-current" />
                    </div>
                  </div>}

                <div className="absolute inset-0 bg-gradient-to-t from-black/80 via-transparent to-transparent opacity-60" />

                {prop.video && <div className="absolute top-4 left-4 bg-primary/80 backdrop-blur-md px-3 py-1 rounded-full text-xs font-bold text-white flex items-center gap-1">
                    <Video className="w-3 h-3" />{t("client.src.video_tour")}</div>}

                <div className="absolute top-4 right-4 bg-black/50 backdrop-blur-md px-3 py-1 rounded-full text-xs font-medium text-white border border-white/10">
                  {prop.type}
                </div>

                <div className="absolute bottom-4 left-4 text-white">
                  <p className="text-2xl font-bold font-display">
                    {prop.price}
                  </p>
                </div>
              </div>

              <div className="p-5 space-y-4">
                <div>
                  <h3 className="text-xl font-bold mb-1 group-hover:text-primary transition-colors">
                    {prop.title}
                  </h3>
                  <div className="flex items-center text-muted-foreground text-sm">
                    <MapPin className="w-3 h-3 mr-1" />
                    {prop.address}
                  </div>
                </div>

                <div className="flex items-center justify-between py-3 border-t border-border">
                  <div className="flex items-center gap-1 text-sm text-muted-foreground">
                    <Bed className="w-4 h-4" />
                    <span>{prop.stats.beds}</span>
                  </div>
                  <div className="flex items-center gap-1 text-sm text-muted-foreground">
                    <Bath className="w-4 h-4" />
                    <span>{prop.stats.baths}</span>
                  </div>
                  <div className="flex items-center gap-1 text-sm text-muted-foreground">
                    <Square className="w-4 h-4" />
                    <span>{prop.stats.sqft}</span>
                  </div>
                </div>
              </div>
            </Link>
          </m.div>)}
      </div>
    </section>;
}
