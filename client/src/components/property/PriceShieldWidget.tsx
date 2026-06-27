import { useTranslation } from "react-i18next";
import { Card, CardHeader, CardTitle, CardDescription, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { ShieldCheck, Info, ChevronRight, Zap, Building2, Key } from "lucide-react";
import { Progress } from "@/components/ui/progress";



interface MarketComp {
  source: string;
  price: number;
  currency: string;
  isLower: boolean;
  savings?: number;
}
type PriceShieldType = 'SALE' | 'RENT' | 'BOOKING';
export function PriceShieldWidget({
  type = 'BOOKING',
  ourPrice = 125
}: {
  type?: PriceShieldType;
  ourPrice?: number;
}) {
  const {
    t
  } = useTranslation();
  const getLabel = () => {
    if (type === 'SALE') return '/ Total';
    if (type === 'RENT') return '/ Monthly';
    return '/ Nightly';
  };
  const getSourcePrefix = (source: string) => {
    if (type === 'SALE') {
      if (source === 'Zillow') return 'Verified Listing';
      if (source === 'Redfin') return 'MLS Rate';
      return 'Market Value';
    }
    return 'Listed Price';
  };
  const comps: MarketComp[] = type === 'SALE' ? [{
    source: 'Zillow',
    price: 485000,
    currency: '$',
    isLower: false,
    savings: 14500
  }, {
    source: 'Redfin',
    price: 482000,
    currency: '$',
    isLower: false,
    savings: 11500
  }, {
    source: 'Reservatior',
    price: 470500,
    currency: '$',
    isLower: true
  }] : [{
    source: 'Airbnb',
    price: 154,
    currency: '$',
    isLower: false,
    savings: 29
  }, {
    source: 'Booking.com',
    price: 150,
    currency: '$',
    isLower: false,
    savings: 25
  }, {
    source: 'Reservatior',
    price: ourPrice,
    currency: '$',
    isLower: true
  }];
  const maxPrice = Math.max(...comps.map(c => c.price));
  const avgSavings = Math.floor((maxPrice - ourPrice) / maxPrice * 100);
  return <Card className="border-none shadow-2xl bg-white overflow-hidden ring-1 ring-slate-100 flex flex-col">
      <CardHeader className="bg-linear-to-br from-indigo-700 to-indigo-900 text-white pb-8 relative overflow-hidden">
        <div className="absolute top-0 right-0 p-8 opacity-10 pointer-events-none">
          {type === 'SALE' ? <Building2 className="w-32 h-32" /> : <ShieldCheck className="w-32 h-32" />}
        </div>
        <div className="flex items-center justify-between relative z-10">
          <div className="flex items-center gap-2 px-3 py-1 bg-white/10 rounded-full border border-white/20 backdrop-blur-sm">
             <ShieldCheck className="w-3.5 h-3.5 text-emerald-400" />
             <span className="text-[10px] font-black tracking-widest uppercase">{type}{t("client.src.shield_active")}</span>
          </div>
          <Badge variant="secondary" className="bg-emerald-500 text-white hover:bg-emerald-600 border-none font-black text-[10px] animate-pulse">{t("client.src.save")}{type === 'SALE' ? '$' + (maxPrice - ourPrice).toLocaleString() : avgSavings + '%'}
          </Badge>
        </div>
        <div className="mt-4 relative z-10">
          <CardTitle className="text-2xl font-black tracking-tight leading-tight">{t("client.src.lowest")}{type === 'SALE' ? 'Closing' : 'Rate'}{t("client.src.guaranteed")}</CardTitle>
          <CardDescription className="text-indigo-100 text-xs font-medium flex items-center gap-1 mt-1">{t("client.src.aiverified_price_comparisons_for")}{type.toLowerCase()}
          </CardDescription>
        </div>
      </CardHeader>

      <CardContent className="p-6 -mt-4 bg-white rounded-t-3xl relative z-20 space-y-6">
        <div className="space-y-4">
          {comps.map(comp => <div key={comp.source} className={`relative p-4 rounded-2xl border transition-all ${comp.isLower ? 'bg-indigo-50 border-indigo-200 ring-2 ring-indigo-500/10' : 'bg-slate-50 border-slate-100 opacity-70 group hover:opacity-100'}`}>
              <div className="flex items-center justify-between">
                <div className="flex items-center gap-3">
                  <div className={`w-8 h-8 rounded-lg flex items-center justify-center font-black text-[10px] ${comp.isLower ? 'bg-indigo-600 text-white' : 'bg-slate-200 text-slate-500'}`}>
                    {comp.source.charAt(0)}
                  </div>
                  <div>
                    <span className={`text-xs font-black ${comp.isLower ? 'text-indigo-900' : 'text-slate-700'}`}>{comp.source}</span>
                    {comp.isLower && <p className="text-[9px] font-bold text-indigo-500 flex items-center gap-0.5">
                        <Key className="w-2.5 h-2.5" /> {type === 'SALE' ? 'Direct Asset Sale' : 'Direct Booking'}
                      </p>}
                  </div>
                </div>
                <div className="text-right">
                  <span className={`text-lg font-black ${comp.isLower ? 'text-indigo-900' : 'text-slate-400 line-through'}`}>
                    {comp.currency}{comp.price.toLocaleString()}
                  </span>
                  {!comp.isLower && <p className="text-[10px] font-bold text-slate-400">{getSourcePrefix(comp.source)}</p>}
                </div>
              </div>
              {!comp.isLower && <div className="mt-2 flex items-center gap-4">
                   <Progress value={ourPrice / comp.price * 100} className="h-1 bg-slate-200" />
                   <span className="text-[9px] font-black text-rose-500 uppercase whitespace-nowrap">+{type === 'SALE' ? '$' + comp.savings?.toLocaleString() : 'FEE'}</span>
                </div>}
            </div>)}
        </div>

        <div className="p-5 rounded-3xl bg-slate-900 text-white space-y-4 shadow-xl ring-1 ring-slate-800">
           <div className="flex items-start gap-3">
              <div className="p-2 bg-indigo-500/20 rounded-xl">
                 <Zap className="w-5 h-5 text-indigo-400" />
              </div>
              <div>
                 <p className="text-xs font-black tracking-tight">{type === 'SALE' ? 'Financial Shield' : 'Price Protection'}</p>
                 <p className="text-[10px] text-slate-400 leading-relaxed mt-1">
                   {type === 'SALE' ? "Eliminate 4-6% agent commissions. Our peer-to-peer sale model ensures the lowest closing cost in the US/EU markets." : "OTAs add 15-20% hidden fees. Our direct 10% split model (5% Platform / 5% Partner) guarantees the best rate."}
                 </p>
              </div>
           </div>

           <button className="w-full h-12 bg-white text-slate-900 rounded-2xl font-black text-xs uppercase tracking-widest hover:bg-slate-100 transition-colors flex items-center justify-center gap-2 group">{t("client.src.confirm")}{type === 'SALE' ? 'Offer' : 'Rate'}{t("client.src.details")}<ChevronRight className="w-4 h-4 group-hover:translate-x-1 transition-transform" />
           </button>
        </div>

        <div className="flex items-center gap-2 p-3 bg-amber-50 border border-amber-100 rounded-2xl">
           <Info className="w-3.5 h-3.5 text-amber-600 shrink-0" />
           <p className="text-[9px] text-amber-800 font-medium leading-tight">{t("client.src.prices_include_closing_costs")}{getLabel()}{t("client.src.estimate")}</p>
        </div>
      </CardContent>
    </Card>;
}