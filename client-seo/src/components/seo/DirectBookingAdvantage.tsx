import { useTranslation } from "react-i18next";
import React from "react";
import { Badge } from "@/components/ui/badge";
import { Sparkles, ShieldCheck, Zap, TrendingDown } from "lucide-react";
interface DirectBookingBadgeProps {
  price?: number;
  currency?: string;
  className?: string;
}

/**
 * Premium Direct Booking Advantage Component.
 * Highlights the "Lower than Third-Party" guarantee as requested.
 * Focuses on direct communication and exclusive pricing.
 */
export const DirectBookingAdvantage: React.FC<DirectBookingBadgeProps> = ({
  price,
  currency = 'USD',
  className
}) => {
  const {
    t
  } = useTranslation();
  return <div className={`p-6 rounded-2xl bg-gradient-to-br from-slate-900 to-indigo-950 text-white shadow-2xl border border-white/10 relative overflow-hidden group ${className}`}>
      {/* Decorative Glow */}
      <div className="absolute top-0 right-0 w-32 h-32 bg-indigo-500/20 blur-3xl group-hover:bg-indigo-500/30 transition-all duration-500" />
      <div className="absolute bottom-0 left-0 w-32 h-32 bg-blue-500/10 blur-3xl group-hover:bg-blue-500/20 transition-all duration-500" />
      
      <div className="relative z-10 space-y-4">
        <div className="flex items-center justify-between">
          <Badge className="bg-white/10 text-white border-white/20 px-3 py-1 text-xs font-black uppercase tracking-widest backdrop-blur-md">
            <Sparkles className="w-3 h-3 mr-2 text-amber-400 fill-amber-400" />{t("client.src.reservatior_exclusive")}</Badge>
          {price && <div className="text-[10px] font-black uppercase tracking-tighter text-indigo-300">{t("client.src.direct")}{currency} {price.toLocaleString()}
            </div>}
        </div>

        <div className="space-y-1">
          <h3 className="text-xl font-black tracking-tight leading-tight">{t("client.src.direct_deal")}<span className="text-indigo-400">{t("client.src.guarantee")}</span>.
          </h3>
          <p className="text-slate-400 text-xs font-medium leading-relaxed max-w-[90%]">{t("client.src.get_prices_lower_than")}</p>
        </div>

        <div className="pt-4 grid grid-cols-2 gap-3">
           <div className="p-3 rounded-xl bg-white/5 border border-white/10 flex items-center gap-3">
              <div className="p-2 bg-indigo-500/20 rounded-lg">
                 <TrendingDown className="w-4 h-4 text-indigo-400" />
              </div>
              <div>
                 <p className="text-[10px] text-slate-500 font-bold uppercase tracking-tighter">{t("client.src.price_drop")}</p>
                 <p className="text-sm font-black">{t("client.src.15_direct")}</p>
              </div>
           </div>
           
           <div className="p-3 rounded-xl bg-white/5 border border-white/10 flex items-center gap-3">
              <div className="p-2 bg-blue-500/20 rounded-lg">
                 <ShieldCheck className="w-4 h-4 text-blue-400" />
              </div>
              <div>
                 <p className="text-[10px] text-slate-500 font-bold uppercase tracking-tighter">{t("client.src.protection")}</p>
                 <p className="text-sm font-black">{t("client.src.escrow_safe")}</p>
              </div>
           </div>
        </div>

        <div className="pt-2 flex items-center gap-2 text-xs font-black text-indigo-300 group-hover:text-indigo-200 transition-colors">
           <Zap className="w-3.5 h-3.5 animate-pulse" />{t("client.src.instant_agent_connection_available")}</div>
      </div>
    </div>;
};
export default DirectBookingAdvantage;