import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { useToast } from "@/hooks/use-toast";
import { amenitiesApi, type Amenity, type PropertyAmenity } from "@/lib/api/amenities";
import { Package, Plus, Trash2, Loader2, CheckCircle2 } from "lucide-react";
interface PropertyAmenitiesManagerProps {
  propertyId: string;
}
export function PropertyAmenitiesManager({
  propertyId
}: PropertyAmenitiesManagerProps) {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const [allAmenities, setAllAmenities] = useState<Amenity[]>([]);
  const [propertyAmenities, setPropertyAmenities] = useState<PropertyAmenity[]>([]);
  const [loading, setLoading] = useState(true);
  const [actionLoading, setActionLoading] = useState<string | null>(null);
  const fetchData = async () => {
    try {
      setLoading(true);
      const [amenRes, propAmenRes] = await Promise.all([amenitiesApi.getAll(), amenitiesApi.getPropertyAmenities(propertyId)]);
      setAllAmenities((amenRes as any)?.data || amenRes || []);
      setPropertyAmenities((propAmenRes as any)?.data || propAmenRes || []);
    } catch (error) {
      toast({
        title: t("client.src.error"),
        description: t("client.src.failed_to_load_amenities"),
        variant: "destructive"
      });
    } finally {
      setLoading(false);
    }
  };
  useEffect(() => {
    if (propertyId) fetchData();
  }, [propertyId]);
  const handleLink = async (amenityId: string) => {
    try {
      setActionLoading(amenityId);
      await amenitiesApi.linkAmenity(propertyId, amenityId);
      toast({
        title: t("client.src.amenity_added")
      });
      const res = await amenitiesApi.getPropertyAmenities(propertyId);
      setPropertyAmenities((res as any)?.data || res || []);
    } catch (error) {
      toast({
        title: t("client.src.error"),
        description: t("client.src.failed_to_add_amenity"),
        variant: "destructive"
      });
    } finally {
      setActionLoading(null);
    }
  };
  const handleUnlink = async (amenityId: string) => {
    try {
      setActionLoading(amenityId);
      await amenitiesApi.unlinkAmenity(propertyId, amenityId);
      toast({
        title: t("client.src.amenity_removed")
      });
      const res = await amenitiesApi.getPropertyAmenities(propertyId);
      setPropertyAmenities((res as any)?.data || res || []);
    } catch (error) {
      toast({
        title: t("client.src.error"),
        description: t("client.src.failed_to_remove_amenity"),
        variant: "destructive"
      });
    } finally {
      setActionLoading(null);
    }
  };
  const isLinked = (amenityId: string) => propertyAmenities.some(pa => pa.amenityId === amenityId);
  const categories = Array.from(new Set(allAmenities.map(a => a.category)));
  if (loading && allAmenities.length === 0) {
    return <div className="flex flex-col items-center justify-center py-12 border-2 border-dashed rounded-xl">
        <Loader2 className="w-8 h-8 animate-spin text-muted-foreground mb-4" />
        <p className="text-muted-foreground font-medium">{t("client.src.loading_property_features")}</p>
      </div>;
  }
  return <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
      {categories.map(category => <Card key={category} className="shadow-none border border-slate-200">
          <CardHeader className="py-3 bg-slate-50/50 border-b">
            <CardTitle className="text-xs font-bold flex items-center gap-2 uppercase tracking-wider text-slate-600">
              <Package className="w-3.5 h-3.5" />
              {category}
            </CardTitle>
          </CardHeader>
          <CardContent className="p-2 space-y-1">
            {allAmenities.filter(a => a.category === category).map(amenity => {
          const linked = isLinked(amenity.id);
          const isBusy = actionLoading === amenity.id;
          return <div key={amenity.id} className="flex items-center justify-between p-2 rounded-lg hover:bg-slate-50 transition-colors group">
                  <div className="flex items-center gap-2.5">
                    {linked ? <CheckCircle2 className="w-4 h-4 text-emerald-500" /> : <div className="w-4 h-4 rounded-full border border-slate-300" />}
                    <span className={`text-sm ${linked ? 'font-medium text-slate-900' : 'text-slate-500'}`}>{amenity.name}</span>
                  </div>
                  
                  {linked ? <Button variant="ghost" size="icon" className="h-7 w-7 opacity-0 group-hover:opacity-100 text-red-500 hover:bg-red-50 hover:text-red-600 transition-all rounded-full" disabled={!!actionLoading} onClick={() => handleUnlink(amenity.id)}>
                      {isBusy ? <Loader2 className="w-3 h-3 animate-spin" /> : <Trash2 className="w-3.5 h-3.5" />}
                    </Button> : <Button variant="ghost" size="icon" className="h-7 w-7 opacity-0 group-hover:opacity-100 text-blue-500 hover:bg-blue-50 hover:text-blue-600 transition-all rounded-full" disabled={!!actionLoading} onClick={() => handleLink(amenity.id)}>
                      {isBusy ? <Loader2 className="w-3 h-3 animate-spin" /> : <Plus className="w-3.5 h-3.5" />}
                    </Button>}
                </div>;
        })}
          </CardContent>
        </Card>)}
    </div>;
}