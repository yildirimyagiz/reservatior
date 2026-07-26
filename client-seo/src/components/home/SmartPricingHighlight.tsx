import Image from "next/image";
import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { m } from "framer-motion";
import { Sparkles, TrendingUp, Brain, Zap, ArrowRight } from "lucide-react";
import { Badge } from "@/components/ui/badge";
import { Card, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { cn } from "@/lib/utils";
import { Link } from "@/lib/react-router-shim";

/**
 * SMART PRICING BADGE COMPONENT
 * A cinematic, pulsing badge that indicates AI-validated pricing.
 */
export const SmartPricingBadge = ({
  className,
  score = 98
}: {
  className?: string;
  score?: number;
}) => {
  const {
    t
  } = useTranslation();
  return <div className={cn("inline-flex items-center gap-2 px-3 py-1.5 rounded-full bg-gradient-to-r from-emerald-500/20 to-blue-500/20 border border-emerald-500/30 backdrop-blur-md shadow-lg shadow-emerald-500/10 animate-pulse", className)}>
    <Sparkles className="w-3.5 h-3.5 text-emerald-400" />
    <span className="text-[10px] font-black text-white uppercase tracking-widest italic">{t("client.src.ai_smart_priced")}{score}{t("client.src.match")}</span>
  </div>;
};
const properties = [{
  id: 1,
  title: t("client.src.skyline_penthouse_manhattan"),
  price: "$250 / day",
  tag: "Market Leader",
  image: "https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=800&q=80",
  score: 99
}, {
  id: 2,
  title: t("client.src.lake_tahoe_waterfront_villa"),
  price: "$450 / day",
  tag: "Yield King",
  image: "https://images.unsplash.com/photo-1613490493576-7fde63acd811?auto=format&fit=crop&w=800&q=80",
  score: 96
}, {
  id: 3,
  title: t("client.src.neural_loft_brooklyn"),
  price: "$120 / day",
  tag: "Nomad Choice",
  image: "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?auto=format&fit=crop&w=800&q=80",
  score: 98
}];
export function SmartPricingHighlight() {
  const {
    t
  } = useTranslation();
  return <section className="py-24 px-4 md:px-6 bg-gradient-to-b from-secondary/5 to-background">
      <div className="container mx-auto space-y-16">
        <div className="flex flex-col md:flex-row md:items-end justify-between gap-8">
          <div className="space-y-4">
            <Badge className="bg-violet-600/10 text-violet-400 border-none font-black text-[10px] tracking-widest uppercase">{t("client.src.neural_value_engine")}</Badge>
            <h2 className="text-2xl md:text-3xl font-semibold text-white tracking-wide leading-tight">{t("client.src.strategic_ai_picks")}<br />
               <span className="text-slate-500">{t("client.src.validated_yield")}</span>
            </h2>
          </div>
          <p className="text-slate-400 font-medium max-w-sm border-l border-white/5 pl-8 italic">{t("client.src.our_ai_compares_these")}</p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-8">
          {properties.map((prop, index) => <m.div key={prop.id} initial={{
          opacity: 0,
          y: 20
        }} whileInView={{
          opacity: 1,
          y: 0
        }} transition={{
          delay: index * 0.1
        }}>
              <Card className="group relative overflow-hidden bg-[#14151a]/40 border-white/5 rounded-[2.5rem] hover:border-emerald-500/30 transition-all duration-500 hover:shadow-2xl hover:shadow-emerald-500/10 h-full">
                <div className="relative aspect-[4/3] overflow-hidden">
                  <Image src={prop.image} alt={prop.title} fill className="object-cover group-hover:scale-110 transition-transform duration-700 opacity-80 group-hover:opacity-100" loading="lazy" sizes="(max-width: 768px) 100vw, 50vw" />
                  <div className="absolute inset-0 bg-gradient-to-t from-[#0a0b0d] via-transparent to-transparent" />
                  <SmartPricingBadge className="absolute top-6 left-6" score={prop.score} />
                  <div className="absolute top-6 right-6 p-2 rounded-2xl bg-black/60 backdrop-blur-md border border-white/10 opacity-0 group-hover:opacity-100 transition-all duration-300">
                     <Zap className="w-5 h-5 text-yellow-400" />
                  </div>
                </div>
                
                <CardContent className="p-8 space-y-6">
                  <div className="space-y-2">
                    <div className="flex items-center justify-between">
                       <span className="text-[10px] font-black text-emerald-400 uppercase tracking-widest">{prop.tag}</span>
                       <div className="flex items-center gap-1 text-slate-500">
                          <TrendingUp className="w-3 h-3" />
                          <span className="text-[9px] font-black">{t("client.src.sync_active")}</span>
                       </div>
                    </div>
                    <h3 className="text-2xl font-black text-white italic tracking-tight group-hover:text-emerald-400 transition-colors">
                       {prop.title}
                    </h3>
                  </div>

                  <div className="flex items-center justify-between pt-6 border-t border-white/5">
                    <div className="space-y-1">
                       <p className="text-[9px] font-black text-slate-500 uppercase tracking-[0.2em]">{t("client.src.direct_rate")}</p>
                       <p className="text-2xl font-black text-white italic">{prop.price}</p>
                    </div>
                    <Link to="/property" className="contents">
                      <Button variant="ghost" aria-label="View property" className="h-14 w-14 rounded-2xl bg-white/5 hover:bg-emerald-600 group/btn transition-all">
                        <ArrowRight className="w-6 h-6 text-white group-hover/btn:translate-x-1 transition-all" />
                      </Button>
                    </Link>
                  </div>
                </CardContent>
              </Card>
            </m.div>)}
        </div>

        <div className="flex justify-center pt-8">
           <Link to="/property" className="contents">
             <Button className="h-16 px-12 bg-white text-black font-black rounded-3xl hover:bg-slate-200 transition-all uppercase tracking-widest text-[10px] italic shadow-2xl">{t("client.src.explore_all_strategic_assets")}<Zap className="ml-3 w-4 h-4" />
             </Button>
           </Link>
        </div>
      </div>
    </section>;
}