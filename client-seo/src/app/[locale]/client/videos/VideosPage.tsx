"use client";

import { useCallback, useEffect, useMemo, useState } from "react";
import { useRouter } from "next/navigation";
import { Card, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import {
  Heart,
  MapPin,
  Search,
  ArrowUpRight,
  Video,
  BedDouble,
  Bath,
  Ruler,
  Share2,
} from "lucide-react";
import { m } from "framer-motion";
import { useTranslation } from "react-i18next";
import ReelsFeed, { ReelProperty } from "@/components/videos/ReelsFeed";
import { propertiesApi } from "@/lib/api/properties-eden";

interface DiscoverProperty {
  id: string;
  name: string;
  type?: string;
  city?: string | null;
  country?: string | null;
  listingPrice?: number | null;
  currency?: string | null;
  bedrooms?: number | null;
  bathrooms?: number | null;
  areaSqm?: number | null;
  createdAt?: string;
  photos?: { url?: string }[] | null;
  videoContents?: { url?: string }[] | null;
}

const CATEGORIES = [
  { id: "all", label: "videos.cat.all" },
  { id: "villa", label: "videos.cat.villa" },
  { id: "penthouse", label: "videos.cat.penthouse" },
  { id: "smart", label: "videos.cat.smart" },
  { id: "mountain", label: "videos.cat.mountain" },
  { id: "loft", label: "videos.cat.loft" },
];

function formatPrice(price: number | null | undefined, currency?: string | null): string {
  if (price == null) return "—";
  try {
    return new Intl.NumberFormat("en-US", {
      style: "currency",
      currency: currency || "USD",
      maximumFractionDigits: 0,
    }).format(price);
  } catch {
    return `$${price.toLocaleString()}`;
  }
}

function matchesCategory(p: DiscoverProperty, cat: string): boolean {
  if (cat === "all") return true;
  const haystack = [p.name, p.type, p.city, p.country]
    .filter(Boolean)
    .join(" ")
    .toLowerCase();
  if (cat === "penthouse") {
    return (p.type || "").toUpperCase() === "PENTHOUSE" || haystack.includes("penthouse");
  }
  if (cat === "villa") {
    return ["DETACHED_HOUSE", "TOWNHOUSE"].includes((p.type || "").toUpperCase()) ||
      haystack.includes("villa");
  }
  return haystack.includes(cat);
}

export default function VideosPage() {
  const { t } = useTranslation();
  const router = useRouter();
  const [properties, setProperties] = useState<DiscoverProperty[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [activeCat, setActiveCat] = useState("all");
  const [searchQuery, setSearchQuery] = useState("");
  const [sortBy, setSortBy] = useState("newest");
  const [saved, setSaved] = useState<Set<string>>(new Set());

  const load = useCallback(async () => {
    setLoading(true);
    setError(null);
    try {
      const raw: any = await propertiesApi.getAll({ limit: 60 });
      const arr: unknown = Array.isArray(raw)
        ? raw
        : Array.isArray(raw?.data)
          ? raw.data
          : Array.isArray(raw?.data?.data)
            ? raw.data.data
            : null;
      if (Array.isArray(arr)) {
        setProperties(arr as DiscoverProperty[]);
      } else {
        setError(String(raw?.error ?? "Invalid response"));
      }
    } catch (e) {
      setError(e instanceof Error ? e.message : String(e));
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    load();
  }, [load]);

  const reelsProperties = useMemo<ReelProperty[]>(
    () => properties as unknown as ReelProperty[],
    [properties]
  );

  const filtered = useMemo(() => {
    let list = properties.filter((p) => {
      if (activeCat !== "all" && !matchesCategory(p, activeCat)) return false;
      if (
        searchQuery &&
        ![p.name, p.city, p.country, p.type]
          .filter(Boolean)
          .join(" ")
          .toLowerCase()
          .includes(searchQuery.toLowerCase())
      )
        return false;
      return true;
    });
    list = [...list];
    if (sortBy === "price_high") {
      list.sort((a, b) => (b.listingPrice ?? 0) - (a.listingPrice ?? 0));
    } else if (sortBy === "price_low") {
      list.sort((a, b) => (a.listingPrice ?? 0) - (b.listingPrice ?? 0));
    } else {
      list.sort(
        (a, b) =>
          new Date(b.createdAt ?? 0).getTime() - new Date(a.createdAt ?? 0).getTime()
      );
    }
    return list;
  }, [properties, activeCat, searchQuery, sortBy]);

  const videoCount = useMemo(
    () => properties.filter((p) => (p.videoContents?.length ?? 0) > 0).length,
    [properties]
  );

  const toggleSave = (id: string) => {
    setSaved((prev) => {
      const next = new Set(prev);
      if (next.has(id)) next.delete(id);
      else next.add(id);
      return next;
    });
  };

  const openDetails = (id: string) => router.push(`/client/property/${id}`);

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-purple-900 to-slate-900">
      <div className="container mx-auto px-4 py-8">
        {/* Header */}
        <m.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="mb-6 flex items-center justify-between"
        >
          <div>
            <h1 className="text-3xl font-bold text-white mb-2">
              {t("videos.videospage.auto_ext_1")}
            </h1>
            <p className="text-gray-400">{t("videos.videospage.auto_ext_2")}</p>
          </div>
          <Button
            onClick={() => router.push("/dashboard")}
            className="bg-brand hover:bg-brand"
          >
            <ArrowUpRight className="w-4 h-4 mr-2" />
            {t("videos.videospage.auto_ext_3")}
          </Button>
        </m.div>

        {/* Reels Feed */}
        <m.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
        >
          <ReelsFeed
            properties={reelsProperties}
            loading={loading}
            error={error}
            onRetry={load}
          />
        </m.div>

        {/* Discover */}
        <m.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2 }}
          className="mt-10"
        >
          <div className="flex items-center gap-2 mb-4">
            <Video className="w-5 h-5 text-brand" />
            <h2 className="text-xl font-bold text-white">
              {t("videos.feed.discover")}
            </h2>
            <span className="text-white/40 text-sm">
              ({filtered.length})
            </span>
            {videoCount > 0 && (
              <span className="ml-2 px-2 py-0.5 rounded-full bg-brand/15 border border-brand/30 text-brand text-xs font-semibold">
                {videoCount} {t("videos.videospage.auto_ext_4")}
              </span>
            )}
          </div>

          {/* Filters */}
          <Card className="bg-white/5 backdrop-blur-xl border-brand/20 mb-6">
            <CardContent className="p-4">
              <div className="flex flex-wrap gap-4">
                <div className="flex-1 min-w-[220px]">
                  <div className="relative">
                    <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" />
                    <Input
                      placeholder={t("videos.feed.searchPlaceholder")}
                      value={searchQuery}
                      onChange={(e) => setSearchQuery(e.target.value)}
                      className="pl-10 bg-white/10 border-brand/30 text-white placeholder:text-gray-400"
                    />
                  </div>
                </div>
                <Select value={activeCat} onValueChange={setActiveCat}>
                  <SelectTrigger className="w-40 bg-white/10 border-brand/30 text-white">
                    <SelectValue placeholder={t("videos.category")} />
                  </SelectTrigger>
                  <SelectContent className="bg-card border-brand/30">
                    {CATEGORIES.map((cat) => (
                      <SelectItem key={cat.id} value={cat.id}>
                        {t(cat.label)}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
                <Select value={sortBy} onValueChange={setSortBy}>
                  <SelectTrigger className="w-40 bg-white/10 border-brand/30 text-white">
                    <SelectValue placeholder={t("videos.sort_by")} />
                  </SelectTrigger>
                  <SelectContent className="bg-card border-brand/30">
                    <SelectItem value="newest">{t("videos.sort.newest")}</SelectItem>
                    <SelectItem value="price_high">{t("videos.sort.price_high")}</SelectItem>
                    <SelectItem value="price_low">{t("videos.sort.price_low")}</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </CardContent>
          </Card>

          {/* Grid */}
          {loading ? (
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
              {Array.from({ length: 6 }).map((_, i) => (
                <div
                  key={i}
                  className="aspect-video rounded-xl bg-white/5 border border-brand/20 animate-pulse"
                />
              ))}
            </div>
          ) : filtered.length === 0 ? (
            <p className="text-center text-white/40 py-16">
              {t("videos.feed.emptyDesc")}
            </p>
          ) : (
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
              {filtered.map((p) => {
                const image =
                  p.photos?.find((ph) => ph.url)?.url ||
                  "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=1000";
                const hasVideo = (p.videoContents?.length ?? 0) > 0;
                const isSaved = saved.has(p.id);
                return (
                  <Card
                    key={p.id}
                    onClick={() => openDetails(p.id)}
                    className="bg-white/5 backdrop-blur-xl border-brand/20 hover:bg-white/10 transition-colors cursor-pointer group overflow-hidden"
                  >
                    <CardContent className="p-0">
                      <div className="relative aspect-video overflow-hidden">
                        <img
                          src={image}
                          alt={p.name}
                          loading="lazy"
                          className="object-cover w-full h-full group-hover:scale-105 transition-transform duration-300"
                        />
                        <div className="absolute inset-0 bg-gradient-to-t from-black/80 via-transparent to-transparent" />
                        {hasVideo && (
                          <div className="absolute top-3 left-3 bg-brand/80 backdrop-blur-sm px-2 py-1 rounded text-white text-xs flex items-center gap-1">
                            <Video className="w-3 h-3" />
                            VIDEO
                          </div>
                        )}
                        <div className="absolute bottom-3 right-3 bg-black/70 backdrop-blur-sm px-2 py-1 rounded text-white text-xs">
                          {p.bedrooms ?? "—"} {t("videos.videospage.auto_ext_11")}
                        </div>
                      </div>

                      <div className="p-4">
                        <div className="flex items-start justify-between mb-2">
                          <div className="flex-1">
                            <h3 className="text-white font-medium line-clamp-2 mb-2">
                              {p.name}
                            </h3>
                            <div className="flex items-center gap-2 text-gray-400 text-sm">
                              <MapPin className="w-3 h-3" />
                              <span>
                                {[p.city, p.country].filter(Boolean).join(", ")}
                              </span>
                            </div>
                          </div>
                        </div>

                        <div className="flex items-center justify-between text-sm text-gray-400 mb-3">
                          <span>{formatPrice(p.listingPrice, p.currency)}</span>
                        </div>

                        <div className="flex items-center gap-4 text-sm text-gray-400 mb-3">
                          {typeof p.bedrooms === "number" && p.bedrooms > 0 && (
                            <div className="flex items-center gap-1">
                              <BedDouble className="w-4 h-4" />
                              <span>{p.bedrooms}</span>
                            </div>
                          )}
                          {typeof p.bathrooms === "number" && p.bathrooms > 0 && (
                            <div className="flex items-center gap-1">
                              <Bath className="w-4 h-4" />
                              <span>{p.bathrooms}</span>
                            </div>
                          )}
                          {typeof p.areaSqm === "number" && p.areaSqm > 0 && (
                            <div className="flex items-center gap-1">
                              <Ruler className="w-4 h-4" />
                              <span>{p.areaSqm}m²</span>
                            </div>
                          )}
                        </div>

                        <div className="flex items-center justify-between pt-3 border-t border-brand/20">
                          <Badge
                            variant="outline"
                            className="text-xs border-brand/30 text-brand"
                          >
                            {(p.type || "PROPERTY").replace(/_/g, " ")}
                          </Badge>
                          <div className="flex items-center gap-2">
                            <Button
                              variant="ghost"
                              size="icon"
                              aria-label={t("common.save")}
                              className="h-8 w-8"
                              onClick={(e) => {
                                e.stopPropagation();
                                toggleSave(p.id);
                              }}
                            >
                              <Heart
                                className={`w-4 h-4 ${
                                  isSaved ? "fill-red-500 text-red-500" : ""
                                }`}
                              />
                            </Button>
                            <Button
                              variant="ghost"
                              size="icon"
                              aria-label={t("common.share")}
                              className="h-8 w-8"
                              onClick={(e) => {
                                e.stopPropagation();
                                router.push(`/client/property/${p.id}`);
                              }}
                            >
                              <Share2 className="w-4 h-4" />
                            </Button>
                          </div>
                        </div>
                      </div>
                    </CardContent>
                  </Card>
                );
              })}
            </div>
          )}
        </m.div>
      </div>
    </div>
  );
}
