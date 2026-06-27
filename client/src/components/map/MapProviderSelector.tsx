import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { RadioGroup, RadioGroupItem } from "@/components/ui/radio-group";
import { Label } from "@/components/ui/label";
import { Input } from "@/components/ui/input";
import { Map, Settings, Key, Globe, Navigation } from "lucide-react";
import { useMapProvider, MapProviderType } from "./MapProvider";
export default function MapProviderSelector() {
  const {
    t
  } = useTranslation();
  const {
    provider,
    setProvider,
    apiKey,
    setApiKey
  } = useMapProvider();
  const providers = [{
    id: "google" as MapProviderType,
    name: "Google Maps",
    description: t("client.src.detailed_street_maps_and"),
    icon: Globe,
    features: ["Street View", "Satellite", "Traffic", "Transit"],
    color: "bg-blue-500",
    status: "active" as const
  }, {
    id: "yandex" as MapProviderType,
    name: "Yandex Maps",
    description: t("client.src.superior_coverage_in_russia"),
    icon: Navigation,
    features: ["Panoramio", "Traffic", "Public Transport"],
    color: "bg-yellow-500",
    status: "active" as const
  }, {
    id: "leaflet" as MapProviderType,
    name: "OpenStreetMap",
    description: t("client.src.open_source_and_free"),
    icon: Map,
    features: ["Open Source", "Free", "Community Driven"],
    color: "bg-green-500",
    status: "active" as const
  }];
  return <Card className="w-full max-w-md">
      <CardHeader>
        <CardTitle className="flex items-center gap-2">
          <Settings className="w-5 h-5" />{t("client.src.map_provider_settings")}</CardTitle>
      </CardHeader>
      <CardContent className="space-y-4">
        {/* Provider Selection */}
        <div>
          <Label className="text-sm font-medium mb-3 block">{t("client.src.map_provider")}</Label>
          <RadioGroup value={provider} onValueChange={value => setProvider(value as MapProviderType)}>
            {providers.map(p => {
            const Icon = p.icon;
            return <div key={p.id} className="flex items-center space-x-2 p-3 border rounded-lg hover:bg-gray-50">
                  <RadioGroupItem value={p.id} id={p.id} />
                  <Label htmlFor={p.id} className="flex-1 cursor-pointer">
                    <div className="flex items-center gap-3">
                      <div className={`w-8 h-8 ${p.color} rounded-lg flex items-center justify-center`}>
                        <Icon className="w-4 h-4 text-white" />
                      </div>
                      <div className="flex-1">
                        <div className="flex items-center gap-2">
                          <span className="font-medium">{p.name}</span>
                          <Badge variant="outline" className="text-xs">
                            {p.status}
                          </Badge>
                        </div>
                        <p className="text-sm text-gray-600">{p.description}</p>
                        <div className="flex flex-wrap gap-1 mt-1">
                          {p.features.map(feature => <Badge key={feature} variant="secondary" className="text-xs">
                              {feature}
                            </Badge>)}
                        </div>
                      </div>
                    </div>
                  </Label>
                </div>;
          })}
          </RadioGroup>
        </div>

        {/* API Keys */}
        <div className="space-y-3">
          <Label className="text-sm font-medium flex items-center gap-2">
            <Key className="w-4 h-4" />{t("client.src.api_keys")}</Label>
          
          <div className="space-y-2">
            <div>
              <Label htmlFor="google-key" className="text-xs text-gray-600">{t("client.src.google_maps_api_key")}</Label>
              <Input id="google-key" type="password" value={apiKey.google} onChange={e => setApiKey("google", e.target.value)} placeholder={t("client.src.aizasy")} className="text-xs" />
            </div>
            
            <div>
              <Label htmlFor="yandex-key" className="text-xs text-gray-600">{t("client.src.yandex_maps_api_key")}</Label>
              <Input id="yandex-key" type="password" value={apiKey.yandex} onChange={e => setApiKey("yandex", e.target.value)} placeholder={t("client.src.dummyyandexkey")} className="text-xs" />
            </div>
          </div>
        </div>

        {/* Current Status */}
        <div className="p-3 bg-gray-50 rounded-lg">
          <div className="text-sm">
            <div className="font-medium mb-1">{t("client.src.current_status")}</div>
            <div className="text-xs text-gray-600 space-y-1">
              <div>{t("client.src.provider")}<span className="font-medium">{providers.find(p => p.id === provider)?.name}</span></div>
              <div>{t("client.src.google_key")}{apiKey.google ? "✅ Configured" : "❌ Required"}</div>
              <div>{t("client.src.yandex_key")}{apiKey.yandex ? "✅ Configured" : "❌ Required"}</div>
            </div>
          </div>
        </div>

        {/* Test Button */}
        <Button variant="outline" className="w-full" onClick={() => {
        console.log("Testing map provider:", provider);
        console.log("API Keys:", apiKey);
      }}>{t("client.src.test_map")}</Button>
      </CardContent>
    </Card>;
}