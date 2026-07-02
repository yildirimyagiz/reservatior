import { t } from "i18next";
import { useState } from "react";
import { X, Plus, MapPin, Bed, Bath, Square, Building2, Home, Check, ArrowLeft, Activity, Zap, BarChart3 } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { useTranslation } from "react-i18next";
import { useNavigate } from "react-router-dom";
import { motion, AnimatePresence } from "framer-motion";
import { cn } from "@/lib/utils";
import Image from "next/image";
export default function CompareList() {
  const {
    t
  } = useTranslation();
  const navigate = useNavigate();
  const [properties, setProperties] = useState<any[]>([{
    id: "1",
    title: t("client.src.luxury_villa_in_beverly"),
    price: 5500000,
    address: "123 Sunset Blvd, CA",
    type: "VILLA",
    beds: 5,
    baths: 4,
    area: 4500,
    image: "https://images.unsplash.com/photo-1613490493576-7fde63acd811?auto=format&fit=crop&w=800&q=80",
    features: ["Pool", "Gym", "Garden", "Garage"],
    status: "Available"
  }, {
    id: "2",
    title: t("client.src.modern_apartment_in_downtown"),
    price: 850000,
    address: "456 Market St, SF",
    type: "APARTMENT",
    beds: 2,
    baths: 2,
    area: 1200,
    image: "https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?auto=format&fit=crop&w=800&q=80",
    features: ["Pool", "Elevator", "Security"],
    status: "Active"
  }]);
  const removeProperty = (id: string) => {
    setProperties(properties.filter(p => p.id !== id));
  };
  const featureList = ["Pool", "Gym", "Garden", "Garage", "Elevator", "Security", "Parking"];
  return <div className="min-h-screen bg-[#14151a] p-8 relative overflow-hidden">
      {/* Background Cybernetic Elements */}
      <div className="absolute inset-0 pointer-events-none">
        <div className="absolute top-0 right-0 w-[800px] h-[800px] bg-blue-600/5 blur-[120px] rounded-full"></div>
        <div className="absolute bottom-0 left-0 w-[600px] h-[600px] bg-purple-600/5 blur-[120px] rounded-full"></div>
        <div className="absolute top-0 left-0 w-full h-full opacity-[0.03] bg-[radial-gradient(#fff_1px,transparent_1px)] bg-size-[40px_40px]"></div>
      </div>

      <div className="max-w-7xl mx-auto space-y-12 relative z-10">
        {/* Header HUD */}
        <motion.div initial={{
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
              <h1 className="text-4xl font-black italic tracking-tighter leading-none text-white">{t('compareTitle')}</h1>
              <p className="text-[10px] font-black text-slate-500 tracking-[0.3em] italic">{t('compareSubtitle')}</p>
            </div>
          </div>

          <Button className="h-14 px-8 bg-blue-600 hover:bg-blue-500 text-white font-black italic tracking-widest text-[10px] rounded-2xl transition-all shadow-xl shadow-blue-600/20 group/plus">
            <Plus className="w-4 h-4 mr-3 group-hover:rotate-90 transition-transform" />
            {t('addMore')}
          </Button>
        </motion.div>

        {/* Comparison Matrix */}
        <motion.div initial={{
        opacity: 0,
        scale: 0.98
      }} animate={{
        opacity: 1,
        scale: 1
      }} className="grid grid-cols-1 lg:grid-cols-[240px_1fr] gap-0 rounded-[48px] overflow-hidden border border-white/5 shadow-3xl bg-[#1a1b1e]/40 backdrop-blur-3xl border-l border-t">
          {/* Comparison Header Labels */}
          <div className="hidden lg:flex flex-col border-r border-white/5 bg-black/20">
            <div className="h-[340px] p-10 flex flex-col justify-end gap-2">
               <div className="flex items-center gap-3 text-blue-500/60 mb-2">
                  <BarChart3 className="w-5 h-5" />
                  <span className="text-[10px] font-black italic tracking-[0.4em]">{t('specifications')}</span>
               </div>
               <div className="h-px w-10 bg-blue-500/40" />
            </div>
            
            <div className="p-6 h-20 flex items-center border-y border-white/5 font-black text-[10px] text-slate-500 italic tracking-widest">{t('price')}</div>
            <div className="p-6 h-20 flex items-center border-b border-white/5 font-black text-[10px] text-slate-500 italic tracking-widest">{t('compareLocation')}</div>
            <div className="p-6 h-20 flex items-center border-b border-white/5 font-black text-[10px] text-slate-500 italic tracking-widest">{t('compareType')}</div>
            <div className="p-6 h-20 flex items-center border-b border-white/5 font-black text-[10px] text-slate-500 italic tracking-widest">{t('livingSpace')}</div>
            <div className="p-6 h-20 flex items-center border-b border-white/5 font-black text-[10px] text-slate-500 italic tracking-widest">{t('accommodation')}</div>
            
            {featureList.map((feature, i) => <div key={feature} className={cn("p-6 h-18 flex items-center border-b border-white/5 font-black text-[10px] text-slate-600 italic  tracking-widest transition-colors hover:text-white group", i % 2 === 0 ? 'bg-black/10' : 'bg-transparent')}>
                {feature}
              </div>)}
          </div>

          {/* Property Columns */}
          <div className="flex overflow-x-auto scrollbar-hide">
            <AnimatePresence mode="popLayout">
              {properties.map(property => <motion.div key={property.id} initial={{
              opacity: 0,
              x: 20
            }} animate={{
              opacity: 1,
              x: 0
            }} exit={{
              opacity: 0,
              x: -20
            }} className="min-w-[340px] flex-1 border-r border-white/5 last:border-r-0 group/col relative">
                  <Button variant="ghost" size="icon" className="absolute top-4 right-4 z-20 rounded-2xl bg-black/40 backdrop-blur-xl border border-white/10 text-slate-500 hover:text-red-500 opacity-0 group-hover/col:opacity-100 transition-all shadow-xl" onClick={() => removeProperty(property.id)}>
                    <X className="w-5 h-5" />
                  </Button>
                  
                  {/* Visual Header */}
                  <div className="h-[340px] p-8 flex flex-col gap-6 relative overflow-hidden">
                    <div className="absolute top-0 left-0 w-full h-full opacity-[0.03] bg-[radial-gradient(#fff_1px,transparent_1px)] bg-size-[20px_20px] pointer-events-none"></div>
                    <div className="h-44 relative rounded-[32px] overflow-hidden shadow-2xl border border-white/10">
                      <Image src={property.image} alt={property.title} fill className="object-cover group-hover/col:scale-110 transition-transform duration-1000 brightness-90 group-hover/col:brightness-100" sizes="(max-width: 768px) 100vw, 340px" />
                      <div className="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent" />
                    </div>
                    <div className="space-y-4">
                      <h3 className="font-black text-xl text-white italic tracking-tighter leading-tight line-clamp-2 group-hover/col:text-blue-400 transition-colors">{property.title}</h3>
                      <Badge className="bg-emerald-500/10 text-emerald-400 border-emerald-500/20 text-[8px] font-black italic tracking-widest px-3 py-1 rounded-full">{property.status}</Badge>
                    </div>
                  </div>

                  {/* Matrix Rows */}
                  <div className="p-8 h-20 flex items-center border-y border-white/5 font-black text-2xl text-white italic tracking-tighter bg-blue-500/2">
                    ${property.price.toLocaleString()}
                  </div>
                  
                  <div className="p-8 h-20 flex items-center border-b border-white/5 text-[10px] font-black text-slate-400 italic tracking-widest">
                    <div className="flex items-center gap-3">
                      <MapPin className="w-4 h-4 text-blue-500/60" />
                      <span className="truncate">{property.address}</span>
                    </div>
                  </div>

                  <div className="p-8 h-20 flex items-center border-b border-white/5 text-[10px] font-black text-slate-400 italic tracking-widest">
                    <div className="flex items-center gap-3">
                      {property.type === 'VILLA' ? <Home className="w-4 h-4 text-emerald-500/60" /> : <Building2 className="w-4 h-4 text-blue-500/60" />}
                      <span>{property.type}</span>
                    </div>
                  </div>

                  <div className="p-8 h-20 flex items-center border-b border-white/5 text-[10px] font-black text-slate-400 italic tracking-widest">
                    <div className="flex items-center gap-3">
                      <Square className="w-4 h-4 text-purple-500/60" />
                      <span>{property.area} <span className="opacity-40 text-[8px]">{t('sqft')}</span></span>
                    </div>
                  </div>

                  <div className="p-8 h-20 flex items-center border-b border-white/5 text-[10px] font-black text-slate-400 italic tracking-widest">
                    <div className="flex items-center gap-6">
                      <div className="flex items-center gap-2">
                        <Bed className="w-4 h-4 text-blue-500/40" />
                        <span>{property.beds}</span>
                      </div>
                      <div className="flex items-center gap-2">
                        <Bath className="w-4 h-4 text-purple-500/40" />
                        <span>{property.baths}</span>
                      </div>
                    </div>
                  </div>

                  {/* Feature Checklist */}
                  {featureList.map((feature, i) => {
                const hasFeature = property.features.includes(feature);
                return <div key={feature} className={cn("p-8 h-18 border-b border-white/5 flex items-center justify-center lg:justify-start group/row", i % 2 === 0 ? 'bg-black/10' : 'bg-transparent')}>
                        <div className="flex items-center gap-4">
                          {hasFeature ? <div className="flex items-center gap-4">
                              <div className="h-6 w-6 rounded-full bg-emerald-500/10 border border-emerald-500/20 flex items-center justify-center">
                                <Check className="w-3.5 h-3.5 text-emerald-500 shadow-[0_0_10px_rgba(16,185,129,0.3)]" />
                              </div>
                              <span className="lg:hidden text-[10px] font-black italic tracking-widest text-emerald-400">{feature}</span>
                            </div> : <div className="flex items-center gap-4">
                              <div className="h-6 w-6 rounded-full bg-white/2 border border-white/5 flex items-center justify-center">
                                <X className="w-3.5 h-3.5 text-slate-800" />
                              </div>
                              <span className="lg:hidden text-[10px] font-black italic tracking-widest text-slate-700">{feature}</span>
                            </div>}
                        </div>
                      </div>;
              })}
                  
                  <div className="p-10 bg-black/20">
                    <Button className="w-full h-14 bg-white text-black hover:bg-slate-200 font-black italic tracking-widest text-[10px] rounded-2xl shadow-xl transition-all">
                      {t('viewFull')}
                    </Button>
                  </div>
                </motion.div>)}

              {properties.length < 3 && <div className="min-w-[340px] flex-1 flex flex-col items-center justify-center bg-white/2 border-dashed border-r border-white/5 relative overflow-hidden group/add">
                  <div className="absolute inset-0 bg-blue-500/2 opacity-0 group-hover/add:opacity-100 transition-opacity" />
                  <Button variant="ghost" className="h-24 w-24 rounded-[32px] bg-white/5 border border-white/5 mb-6 text-slate-700 hover:text-blue-500 hover:bg-white/10 hover:border-blue-500/20 hover:scale-110 transition-all group-hover/add:shadow-3xl">
                    <Plus className="w-10 h-10" />
                  </Button>
                  <p className="text-[10px] font-black text-slate-600 italic tracking-[0.3em] group-hover/add:text-blue-400 transition-colors">{t('addPlaceholder')}</p>
                </div>}
            </AnimatePresence>
          </div>
        </motion.div>
      </div>
    </div>;
}