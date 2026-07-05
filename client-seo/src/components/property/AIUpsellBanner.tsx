import Image from 'next/image';
import React from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { Sparkles, ArrowRight, X, Percent, CheckCircle2, Shield, Home } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { Card, CardContent } from '@/components/ui/card';
import { Link } from '@/lib/react-router-shim';

interface AIUpsellBannerProps {
  data: {
    propertyId: string;
    name: string;
    city: string;
    bedrooms: number;
    bathrooms?: number;
    pricePerNight: number;
    currency: string;
    image: string;
    aiMessage: string;
    savingsPercent: number;
    days: number;
    areaSqm?: number;
    features?: string[];
  };
  onClose: () => void;
  isVisible?: boolean;
}

export function AIUpsellBanner({ data, onClose, isVisible = true }: AIUpsellBannerProps) {
  if (!data) return null;

  return (
    <AnimatePresence>
      {isVisible && (
        <motion.div
          initial={{ opacity: 0, y: -20, scale: 0.98 }}
          animate={{ opacity: 1, y: 0, scale: 1 }}
          exit={{ opacity: 0, y: -10, scale: 0.96 }}
          transition={{ duration: 0.5, ease: [0.16, 1, 0.3, 1] }}
          className="w-full relative z-10 mb-6"
        >
          <div className="absolute inset-0 bg-gradient-to-r from-violet-600/20 via-fuchsia-600/15 to-amber-500/20 blur-xl -z-10 rounded-3xl" />
          
          <Card className="border-0 shadow-2xl overflow-hidden rounded-3xl bg-background/80 backdrop-blur-2xl ring-1 ring-white/10 relative">
            {/* Glow Effects */}
            <div className="absolute top-0 right-0 w-64 h-64 bg-violet-500/8 rounded-full blur-[100px] pointer-events-none" />
            <div className="absolute bottom-0 left-0 w-64 h-64 bg-fuchsia-500/8 rounded-full blur-[100px] pointer-events-none" />

            <Button 
              variant="ghost" 
              size="icon" 
              onClick={onClose}
              className="absolute top-3 right-3 h-8 w-8 rounded-full z-20 bg-black/20 hover:bg-black/40 text-white backdrop-blur-md transition-colors"
            >
              <X className="w-4 h-4" />
            </Button>

            <CardContent className="p-0 flex flex-col md:flex-row h-auto md:h-72">
              {/* Image Section */}
              <div className="w-full md:w-[38%] h-52 md:h-full relative overflow-hidden shrink-0">
                <Image 
                  src={data.image} 
                  alt={data.name} 
                  fill 
                  className="object-cover transition-transform duration-700 hover:scale-105"
                  sizes="(max-width: 768px) 100vw, 50vw"
                />
                <div className="absolute inset-0 bg-gradient-to-r from-black/70 via-black/30 to-transparent" />
                
                {/* Badges */}
                <div className="absolute top-4 left-4 flex flex-col gap-2">
                  <motion.div
                    initial={{ x: -20, opacity: 0 }}
                    animate={{ x: 0, opacity: 1 }}
                    transition={{ delay: 0.3 }}
                    className="bg-background/90 backdrop-blur text-foreground px-3 py-1.5 rounded-full text-xs font-bold inline-flex items-center gap-1.5 shadow-lg"
                  >
                    <Sparkles className="w-3.5 h-3.5 text-violet-500" />
                    AI Arbitrage Önerisi
                  </motion.div>
                  <motion.div
                    initial={{ x: -20, opacity: 0 }}
                    animate={{ x: 0, opacity: 1 }}
                    transition={{ delay: 0.5 }}
                    className="bg-emerald-500 text-white px-3 py-1.5 rounded-full text-xs font-bold inline-flex items-center gap-1.5 shadow-lg border border-emerald-400/50"
                  >
                    <Percent className="w-3.5 h-3.5" />
                    %{data.savingsPercent} Daha Ucuz
                  </motion.div>
                </div>
                
                {/* Property info overlay */}
                <div className="absolute bottom-4 left-4 right-4">
                  <h3 className="text-white font-bold text-xl leading-tight line-clamp-1 drop-shadow-lg">{data.name}</h3>
                  <p className="text-white/80 text-sm mt-1">{data.city} • {data.bedrooms} Yatak Odası{data.areaSqm ? ` • ${data.areaSqm}m²` : ''}</p>
                </div>
              </div>

              {/* Content Section */}
              <div className="flex-1 p-6 md:p-8 flex flex-col justify-center relative">
                <div className="flex items-center gap-2 mb-3">
                  <Home className="w-5 h-5 text-violet-500" />
                  <h2 className="text-2xl md:text-3xl font-black tracking-tight bg-clip-text text-transparent bg-gradient-to-r from-violet-500 to-fuchsia-500">
                    Uzun Konaklama Fırsatı!
                  </h2>
                </div>
                
                <p className="text-foreground/70 md:text-base leading-relaxed mb-5 italic border-l-2 border-violet-500/30 pl-4">
                  &ldquo;{data.aiMessage}&rdquo;
                </p>

                <div className="flex flex-col sm:flex-row items-center justify-between gap-4 mt-auto">
                  <div className="flex flex-col">
                    <span className="text-xs text-muted-foreground font-medium uppercase tracking-wider">Gecelik Sadece</span>
                    <span className="text-3xl font-black text-foreground">
                      {new Intl.NumberFormat('en-US', { style: 'currency', currency: data.currency || 'USD' }).format(data.pricePerNight || 0)}
                    </span>
                    <span className="text-xs text-emerald-500 font-semibold mt-0.5">
                      {data.days} gece = {new Intl.NumberFormat('en-US', { style: 'currency', currency: data.currency || 'USD' }).format((data.pricePerNight || 0) * data.days)}
                    </span>
                  </div>
                  
                  <Link to={`/property/${data.propertyId}`} className="w-full sm:w-auto">
                    <Button className="w-full sm:w-auto rounded-full h-12 px-8 font-bold text-base shadow-xl bg-gradient-to-r from-violet-600 to-fuchsia-600 hover:from-violet-500 hover:to-fuchsia-500 transition-all gap-2 group">
                      Rezidansa Geçiş Yap <ArrowRight className="w-4 h-4 group-hover:translate-x-1 transition-transform" />
                    </Button>
                  </Link>
                </div>
                
                {/* Features Row */}
                <div className="flex flex-wrap gap-3 mt-4 pt-4 border-t border-border/30">
                  {(data.features || ['Tam Donanımlı Mutfak', 'Daha Geniş Alan']).slice(0, 4).map((feature, i) => (
                    <div key={i} className="flex items-center gap-1.5 text-xs text-muted-foreground font-medium">
                      <CheckCircle2 className="w-3.5 h-3.5 text-emerald-500 shrink-0" /> {feature}
                    </div>
                  ))}
                  <div className="flex items-center gap-1.5 text-xs text-violet-400 font-semibold">
                    <Shield className="w-3.5 h-3.5 shrink-0" /> SafeStay™ Escrow
                  </div>
                </div>
              </div>
            </CardContent>
          </Card>
        </motion.div>
      )}
    </AnimatePresence>
  );
}
