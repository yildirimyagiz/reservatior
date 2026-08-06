import Image from "next/image";
import { useTranslation } from "react-i18next";
import React, { useEffect, useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { MapPin, Star, Coffee, Utensils, Train, ShoppingBag, Info, ExternalLink, ShieldCheck, TrendingDown } from "lucide-react";
interface Place {
  id: string;
  name: string;
  rating: number;
  user_ratings_total: number;
  type: string;
  distance: string;
  address: string;
}
interface GooglePlacesInsightProps {
  lat: number;
  lng: number;
  propertyName: string;
}

/**
 * Google Places Integration Component.
 * Enhances property value by pulling real-time local intelligence and trust signals.
 * Positioned as the 'Anti-Monopoly' strategy: Direct discovery via Google ecosystem.
 */
export const GooglePlacesInsight: React.FC<GooglePlacesInsightProps> = ({
  lat,
  lng
}) => {
  const {
    t
  } = useTranslation();
  const [nearbyPlaces, setNearbyPlaces] = useState<Place[]>([]);
  const [loading, setLoading] = useState(true);

  // Simulated Places API call - This would be a real Fetch to Google Places API
  useEffect(() => {
    const fetchNearby = async () => {
      setLoading(true);
      // In a real app: const res = await fetch(`/api/google/places?lat=${lat}&lng=${lng}`);
      setTimeout(() => {
        setNearbyPlaces([{
          id: "1",
          name: "Artisanal Coffee Roasters",
          rating: 4.8,
          user_ratings_total: 1240,
          type: "cafe",
          distance: "0.2 mi",
          address: "123 Brew St"
        }, {
          id: "2",
          name: "Central Station",
          rating: 4.2,
          user_ratings_total: 5600,
          type: "transit",
          distance: "0.5 mi",
          address: "Main Avenue"
        }, {
          id: "3",
          name: "Green Park Bistro",
          rating: 4.6,
          user_ratings_total: 890,
          type: "restaurant",
          distance: "0.3 mi",
          address: "45 Park Rd"
        }, {
          id: "4",
          name: "Metropolitan Mall",
          rating: 4.4,
          user_ratings_total: 12500,
          type: "shopping",
          distance: "0.8 mi",
          address: "Retail Way"
        }]);
        setLoading(false);
      }, 1000);
    };
    fetchNearby();
  }, [lat, lng]);
  const getIcon = (type: string) => {
    switch (type) {
      case 'cafe':
        return <Coffee className="w-4 h-4 text-amber-600" />;
      case 'restaurant':
        return <Utensils className="w-4 h-4 text-rose-600" />;
      case 'transit':
        return <Train className="w-4 h-4 text-blue-600" />;
      case 'shopping':
        return <ShoppingBag className="w-4 h-4 text-purple-600" />;
      default:
        return <MapPin className="w-4 h-4 text-slate-600" />;
    }
  };
  return <div className="space-y-6">
      {/* Comparison Widget: The 'Direct Advantage' Strategy */}
      <Card className="border-none bg-gradient-to-br from-indigo-50 to-white shadow-xl overflow-hidden ring-1 ring-indigo-100">
        <CardHeader className="pb-2 bg-indigo-600 text-white">
          <div className="flex items-center justify-between">
            <CardTitle className="text-sm font-black uppercase tracking-widest flex items-center gap-2">
              <ShieldCheck className="w-4 h-4" />{t("client.src.direct_channel_strategy")}</CardTitle>
            <Badge className="bg-white/20 hover:bg-white/30 text-white border-none text-[10px] font-bold">{t("client.src.better_than_otas")}</Badge>
          </div>
        </CardHeader>
        <CardContent className="p-5 space-y-4 text-indigo-950">
          <p className="text-xs font-bold leading-relaxed">{t("client.src.by_booking_through")}<span className="text-indigo-600">{t("client.src.reservatior_x_google")}</span>{t("client.src.we_eliminate_the_1520")}</p>
          <div className="grid grid-cols-1 gap-2">
             <div className="flex items-center gap-3 p-3 rounded-xl bg-white border border-indigo-100 shadow-sm">
                <div className="p-2 bg-blue-100 rounded-lg">
                   <TrendingDown className="w-4 h-4 text-blue-600" />
                </div>
                <div className="flex-1">
                   <p className="text-[10px] text-slate-500 font-bold uppercase">{t("client.src.price_advantage")}</p>
                   <p className="text-sm font-black text-slate-900">{t("client.src.guaranteed_12_lower_price")}</p>
                </div>
             </div>
             
             <div className="flex items-center gap-3 p-3 rounded-xl bg-white border border-indigo-100 shadow-sm">
                <div className="p-2 bg-blue-100 rounded-lg">
                   <Star className="w-4 h-4 text-blue-600" />
                </div>
                <div className="flex-1">
                   <p className="text-[10px] text-slate-500 font-bold uppercase">{t("client.src.loyalty_gain")}</p>
                   <p className="text-sm font-black text-slate-900">{t("client.src.keep_100_of_your")}</p>
                </div>
             </div>
          </div>
          <p className="text-[10px] text-slate-500 font-medium">{t("client.src.global_platforms_often_bundle")}</p>
        </CardContent>
      </Card>

      {/* Google Places Insights */}
      <Card className="border-none shadow-2xl bg-white overflow-hidden ring-1 ring-black/5">
        <CardHeader className="pb-3 border-b border-gray-100">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-2">
               <div className="w-8 h-8 rounded-lg bg-blue-100 flex items-center justify-center">
                  <MapPin className="w-5 h-5 text-blue-600" />
               </div>
               <CardTitle className="text-lg font-black text-slate-800">{t("client.src.nearby_gems")}</CardTitle>
            </div>
            <div className="flex items-center gap-1.5 px-3 py-1 bg-gray-50 rounded-full border border-gray-100">
               <Image src="https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_92x30dp.png" alt={t("client.src.google")} width={92} height={30} loading="lazy" sizes="92px" className="h-3.5 w-auto" />
               <span className="text-[10px] font-black text-slate-400 uppercase tracking-widest">{t("client.src.places")}</span>
            </div>
          </div>
        </CardHeader>
        <CardContent className="p-0">
          {loading ? <div className="p-10 text-center animate-pulse space-y-3">
               <div className="h-10 w-10 bg-gray-100 rounded-full mx-auto" />
               <div className="h-4 w-32 bg-gray-100 rounded mx-auto" />
            </div> : <div className="divide-y divide-gray-50">
              {nearbyPlaces.map(place => <div key={place.id} className="p-4 hover:bg-gray-50 transition-colors group cursor-pointer">
                  <div className="flex items-start gap-4">
                    <div className="p-3 rounded-2xl bg-white shadow-sm border border-gray-100 group-hover:border-blue-200 transition-colors">
                      {getIcon(place.type)}
                    </div>
                    <div className="flex-1 min-w-0">
                      <div className="flex items-center justify-between">
                        <h4 className="text-sm font-black text-slate-900 truncate">{place.name}</h4>
                        <span className="text-[10px] font-black text-blue-600 bg-blue-50 px-2 py-0.5 rounded-full">{place.distance}</span>
                      </div>
                      <div className="flex items-center gap-3 mt-1">
                        <div className="flex items-center gap-1">
                          <Star className="w-3 h-3 text-amber-400 fill-amber-400" />
                          <span className="text-xs font-black text-slate-700">{place.rating}</span>
                          <span className="text-[10px] text-slate-400 font-bold">({place.user_ratings_total.toLocaleString()})</span>
                        </div>
                        <span className="text-[10px] text-slate-300">•</span>
                        <span className="text-[10px] text-slate-400 font-bold uppercase tracking-tighter truncate">{place.address}</span>
                      </div>
                    </div>
                    <ExternalLink className="w-4 h-4 text-slate-300 opacity-0 group-hover:opacity-100 transition-opacity" />
                  </div>
                </div>)}
            </div>}
          <div className="p-4 bg-slate-50/50 border-t border-gray-100">
             <Button variant="ghost" className="w-full text-xs font-black text-slate-500 uppercase tracking-widest hover:bg-white hover:text-blue-600 transition-all">{t("client.src.explore_full_neighborhood")}<Info className="w-3.5 h-3.5 ml-2" />
             </Button>
          </div>
        </CardContent>
      </Card>
      
      {/* Reputation Shield */}
      <div className="flex items-center gap-3 p-4 rounded-2xl bg-blue-50/50 border border-blue-100">
         <ShieldCheck className="w-5 h-5 text-blue-600" />
         <p className="text-[11px] font-bold text-blue-800 leading-tight">{t("client.src.google_verified_identity_location")}</p>
      </div>
    </div>;
};
import { Button } from "@/components/ui/button";