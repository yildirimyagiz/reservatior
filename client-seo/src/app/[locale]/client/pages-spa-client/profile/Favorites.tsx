"use client";

import { t } from "i18next";
import { useState, useEffect } from "react";
import { Heart, Search, MapPin, Bed, Bath, Square, Play, ArrowLeft, Activity, Zap } from "lucide-react";
import { Card, CardContent, CardFooter, CardHeader } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { favoritesApi } from "@/lib/api/social";
import { useToast } from "@/hooks/use-toast";
import { m, AnimatePresence } from "framer-motion";
import { Link, useNavigate } from "@/lib/react-router-shim";
import { useTranslation } from "react-i18next";
import { cn } from "@/lib/utils";
import Image from "next/image";
export default function Favorites() {
  const {
    t
  } = useTranslation();
  const navigate = useNavigate();
  const [favorites, setFavorites] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [searchQuery, setSearchQuery] = useState("");
  const {
    toast
  } = useToast();
  useEffect(() => {
    loadFavorites();
  }, []);
  const loadFavorites = async () => {
    try {
      setLoading(true);
      const data = await favoritesApi.getFavorites();
      setFavorites(Array.isArray(data) ? data : []);
    } catch (error) {
      console.error("Failed to load favorites:", error);
      // Fallback for demo
      setFavorites([{
        id: "1",
        title: t("client.src.luxury_villa_in_beverly"),
        price: 5500000,
        address: "123 Sunset Blvd, CA",
        beds: 5,
        baths: 4,
        area: 4500,
        image: "https://images.unsplash.com/photo-1613490493576-7fde63acd811?auto=format&fit=crop&w=800&q=80",
        hasVideo: true
      }, {
        id: "2",
        title: t("client.src.modern_apartment_in_downtown"),
        price: 850000,
        address: "456 Market St, SF",
        beds: 2,
        baths: 2,
        area: 1200,
        image: "https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?auto=format&fit=crop&w=800&q=80",
        hasVideo: false
      }]);
    } finally {
      setLoading(false);
    }
  };
  const toggleFavorite = async (id: string) => {
    try {
      await favoritesApi.toggleFavorite(id);
      setFavorites(favorites.filter(f => f.id !== id));
      toast({
        title: t('removed'),
        description: t('removedDesc')
      });
    } catch (error) {
      toast({
        title: t('error'),
        description: t('errorDesc'),
        variant: "destructive"
      });
    }
  };
  const filteredFavorites = favorites.filter(f => f.title.toLowerCase().includes(searchQuery.toLowerCase()) || f.address.toLowerCase().includes(searchQuery.toLowerCase()));
  return <div className="min-h-screen bg-[#14151a] p-8 relative overflow-hidden">
      {/* Background Cybernetic Elements */}
      <div className="absolute inset-0 pointer-events-none">
        <div className="absolute top-0 right-0 w-[800px] h-[800px] bg-blue-600/5 blur-[120px] rounded-full"></div>
        <div className="absolute bottom-0 left-0 w-[600px] h-[600px] bg-purple-600/5 blur-[120px] rounded-full"></div>
        <div className="absolute top-0 left-0 w-full h-full opacity-[0.03] bg-[radial-gradient(#fff_1px,transparent_1px)] bg-size-[40px_40px]"></div>
      </div>

      <div className="max-w-7xl mx-auto space-y-12 relative z-10">
        {/* Header HUD */}
        <m.div initial={{
        opacity: 0,
        y: -20
      }} animate={{
        opacity: 1,
        y: 0
      }} className="flex flex-col md:flex-row md:items-center justify-between gap-8">
          <div className="flex items-center gap-8">
            <Button variant="ghost" size="sm" onClick={() => navigate(-1)} className="h-14 px-8 rounded-2xl bg-white/5 border border-white/5 hover:bg-white/10 text-slate-400 font-black italic text-[10px] tracking-[0.25em] transition-all group">
              <ArrowLeft className="w-4 h-4 mr-3 group-hover:-translate-x-1 transition-transform" />
              {t('back')}
            </Button>
            <div className="h-14 w-px bg-white/10 hidden md:block" />
            <div className="space-y-1">
              <h1 className="text-4xl font-black italic tracking-tighter leading-none text-white">{t('favoritesTitle')}</h1>
              <p className="text-[10px] font-black text-slate-500 tracking-[0.3em] italic">{t('favoritesSubtitle')}</p>
            </div>
          </div>

          <div className="relative w-full md:w-96 group">
            <div className="absolute inset-0 bg-blue-500/10 blur-xl opacity-0 group-focus-within:opacity-100 transition-opacity rounded-2xl" />
            <Search className="absolute left-4 top-1/2 -translate-y-1/2 text-slate-500 w-4 h-4 group-focus-within:text-blue-400 transition-colors" />
            <Input placeholder={t('searchPlaceholder')} value={searchQuery} onChange={e => setSearchQuery(e.target.value)} className="h-14 pl-12 pr-6 rounded-2xl bg-[#1a1b1e]/60 border-white/5 focus:border-blue-500/50 text-[10px] font-black italic tracking-widest text-white transition-all shadow-inner placeholder:text-slate-600" />
          </div>
        </m.div>

        {loading ? <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            {[1, 2, 3].map(i => <div key={i} className="h-96 bg-white/5 animate-pulse rounded-[40px] border border-white/5"></div>)}
          </div> : filteredFavorites.length > 0 ? <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            <AnimatePresence mode="popLayout">
              {filteredFavorites.map((property, index) => <m.div key={property.id} layout initial={{
            opacity: 0,
            scale: 0.9,
            y: 20
          }} animate={{
            opacity: 1,
            scale: 1,
            y: 0
          }} exit={{
            opacity: 0,
            scale: 0.9,
            y: 20
          }} transition={{
            delay: index * 0.05
          }}>
                  <Card className="bg-[#1a1b1e]/40 border-white/5 border-l border-t rounded-[40px] overflow-hidden group hover:bg-white/5 transition-all shadow-2xl relative">
                    <div className="absolute top-0 left-0 w-full h-full opacity-[0.03] bg-[radial-gradient(#fff_1px,transparent_1px)] bg-size-[40px_40px]"></div>
                    
                    <div className="relative aspect-16/10 overflow-hidden">
                      <Image src={property.image} alt={property.title} fill className="object-cover group-hover:scale-110 transition-transform duration-700 brightness-75 group-hover:brightness-100" loading="lazy" sizes="(max-width: 768px) 100vw, 50vw" />
                      <div className="absolute inset-0 bg-gradient-to-t from-[#14151a] via-transparent to-transparent opacity-60" />
                      
                      <div className="absolute top-4 right-4 flex gap-2">
                        <Button variant="ghost" size="icon" className="h-12 w-12 rounded-2xl bg-black/40 backdrop-blur-xl border border-white/10 text-red-500 hover:bg-red-500 hover:text-white transition-all group/heart" onClick={() => toggleFavorite(property.id)}>
                          <Heart className="w-5 h-5 fill-current group-hover:scale-110 transition-transform" />
                        </Button>
                      </div>
                      
                      {property.hasVideo && <div className="absolute bottom-4 left-4">
                          <Badge className="bg-blue-600 text-white border-none font-black italic tracking-widest text-[8px] px-3 py-1.5 rounded-full flex items-center gap-2 shadow-xl">
                            <Play className="w-3 h-3 fill-current" />
                            {t('favoritesVideotour')}
                          </Badge>
                        </div>}
                    </div>

                    <CardHeader className="p-8 pb-4 space-y-4">
                      <div className="space-y-1">
                        <h3 className="text-xl font-black text-white italic tracking-tighter line-clamp-1 group-hover:text-blue-400 transition-colors">
                          {property.title}
                        </h3>
                        <div className="flex items-center text-slate-500 text-[10px] font-black italic tracking-widest gap-2">
                          <MapPin className="w-3 h-3 text-blue-500" />
                          <span className="truncate">{property.address}</span>
                        </div>
                      </div>
                    </CardHeader>

                    <CardContent className="p-8 pt-0">
                       <div className="text-3xl font-black text-white italic tracking-tighter">
                         ${property.price.toLocaleString()}
                       </div>
                    </CardContent>

                    <CardFooter className="px-8 py-6 border-t border-white/5 bg-white/2 flex justify-between items-center">
                      <div className="flex gap-6">
                        <div className="flex items-center gap-2 text-[10px] font-black text-slate-400 italic">
                          <Bed className="w-4 h-4 text-blue-500/60" />
                          <span>{property.beds}</span>
                        </div>
                        <div className="flex items-center gap-2 text-[10px] font-black text-slate-400 italic">
                          <Bath className="w-4 h-4 text-purple-500/60" />
                          <span>{property.baths}</span>
                        </div>
                        <div className="flex items-center gap-2 text-[10px] font-black text-slate-400 italic">
                          <Square className="w-4 h-4 text-emerald-500/60" />
                          <span>{property.area} <span className="text-[8px] opacity-40">{t('sqft')}</span></span>
                        </div>
                      </div>
                      
                      <Link to={`/property/${property.id}`}>
                        <Button variant="ghost" className="h-10 px-0 hover:bg-transparent text-blue-500 hover:text-blue-400 text-[10px] font-black italic tracking-widest flex items-center gap-2 group/btn">
                          {t('viewDetails')}
                          <div className="w-6 h-px bg-blue-500/40 group-hover/btn:w-10 transition-all" />
                        </Button>
                      </Link>
                    </CardFooter>
                  </Card>
                </m.div>)}
            </AnimatePresence>
          </div> : <m.div initial={{
        opacity: 0,
        scale: 0.95
      }} animate={{
        opacity: 1,
        scale: 1
      }} className="text-center py-32 bg-[#1a1b1e]/40 rounded-[64px] border-2 border-dashed border-white/5 backdrop-blur-3xl">
            <div className="inline-flex items-center justify-center w-24 h-24 rounded-[32px] bg-white/5 border border-white/5 mb-8 text-slate-600">
              <Heart className="w-10 h-10" />
            </div>
            <h2 className="text-2xl font-black text-white italic tracking-tighter mb-4">{t('favoritesEmptyTitle')}</h2>
            <p className="text-[10px] font-black text-slate-500 tracking-widest italic max-w-sm mx-auto mb-10 leading-loose">
              {t('favoritesEmptyDesc')}
            </p>
            <Link to="/property">
              <Button className="h-16 px-10 bg-white text-black hover:bg-slate-200 font-black italic text-xs tracking-widest rounded-2xl transition-all shadow-xl hover:scale-105 gap-3">
                <Zap className="w-4 h-4" />
                {t('explore')}
              </Button>
            </Link>
          </m.div>}
      </div>
    </div>;
}