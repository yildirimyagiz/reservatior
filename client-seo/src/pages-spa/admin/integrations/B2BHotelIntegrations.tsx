import React, { useState } from 'react';
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Switch } from "@/components/ui/switch";
import { Globe, Key, Percent, Save, Server, ShieldCheck } from "lucide-react";
import { useTranslation } from "react-i18next";
import { toast } from 'sonner';
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger, DialogFooter, DialogDescription } from "@/components/ui/dialog";

export default function B2BHotelIntegrations() {
  const [isAddOpen, setIsAddOpen] = useState(false);
  const { t } = useTranslation();

  const [integrations, setIntegrations] = useState([
    {
      id: 'HOTELBEDS',
      name: 'Hotelbeds',
      enabled: true,
      apiKey: 'hb_live_**************',
      apiSecret: '**************',
      markup: 12,
      lastSync: '2 minutes ago'
    },
    {
      id: 'EPS',
      name: 'Expedia Partner Solutions (EPS)',
      enabled: true,
      apiKey: 'eps_prod_*************',
      apiSecret: '*************',
      markup: 15,
      lastSync: '10 minutes ago'
    },
    {
      id: 'WEBBEDS',
      name: 'WebBeds',
      enabled: false,
      apiKey: '',
      apiSecret: '',
      markup: 10,
      lastSync: 'Never'
    },
    {
      id: 'HOTELDO',
      name: 'HotelDO',
      enabled: false,
      apiKey: '',
      apiSecret: '',
      markup: 10,
      lastSync: 'Never'
    }
  ]);

  const handleSave = () => {
    toast.success("B2B Entegrasyon ayarları başarıyla kaydedildi.");
  };

  const toggleIntegration = (id: string) => {
    setIntegrations(integrations.map(inv =>
      inv.id === id ? { ...inv, enabled: !inv.enabled } : inv
    ));
  };

  return (
    <div className="p-6 max-w-7xl mx-auto space-y-6">
      <div className="bg-white/5 p-6 rounded-2xl border border-white/10 flex justify-between items-center">
        <div>
          <h1 className="text-3xl font-bold tracking-tight text-white">B2B Otel Toptancıları (Aggregator)</h1>
          <p className="text-slate-400 mt-2">
            Türkiye ve globaldeki otel envanterlerini sisteme dahil etmek için B2B API bağlantılarını yapılandırın.
          </p>
        </div>
        <Button onClick={handleSave} className="gap-2 bg-blue-600 hover:bg-blue-500">
          <Save className="w-4 h-4" /> Ayarları Kaydet
        </Button>
      </div>

      {/* Info Banner */}
      <Card className="bg-emerald-500/10 border-emerald-500/20 bg-white/5">
        <CardContent className="p-4 flex gap-4 items-start">
          <div className="p-2 bg-emerald-500/20 rounded-full">
            <ShieldCheck className="w-6 h-6 text-emerald-500" />
          </div>
          <div>
            <h3 className="font-semibold text-emerald-500">SafeStay™ Escrow Güvencesi</h3>
            <p className="text-sm text-emerald-500/80 mt-1">
              Bu platformlardan gelen envanterlere yapılan rezervasyon ödemeleri havuzda tutulur.
              Müşteri check-in yaptıktan sonra ilgili platforma API üzerinden kesin ödeme geçişi yapılır.
            </p>
          </div>
        </CardContent>
      </Card>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        {integrations.map((integration) => (
          <Card key={integration.id} className={`bg-white/5 border-white/10 ${integration.enabled ? "border-blue-500/50 shadow-[0_0_15px_rgba(59,130,246,0.1)]" : "opacity-70"}`}>
            <CardHeader className="flex flex-row justify-between items-start pb-2">
              <div className="flex gap-3 items-center">
                <div className="p-2 bg-white/5 rounded-lg">
                  <Globe className={integration.enabled ? "w-6 h-6 text-blue-500" : "w-6 h-6 text-slate-400"} />
                </div>
                <div>
                  <CardTitle className="text-lg text-white">{integration.name}</CardTitle>
                  <CardDescription className="flex items-center gap-2 mt-1 text-slate-400">
                    <Server className="w-3 h-3" /> Son Eşitleme: {integration.lastSync}
                  </CardDescription>
                </div>
              </div>
              <Switch
                checked={integration.enabled}
                onCheckedChange={() => toggleIntegration(integration.id)}
              />
            </CardHeader>
            <CardContent className="space-y-4 pt-4">
              <div className="space-y-2">
                <Label className="flex items-center gap-2 text-xs text-slate-400 uppercase tracking-widest">
                  <Key className="w-3 h-3" /> API Key
                </Label>
                <Input
                  value={integration.apiKey}
                  onChange={(e) => setIntegrations(integrations.map(inv =>
                    inv.id === integration.id ? { ...inv, apiKey: e.target.value } : inv
                  ))}
                  disabled={!integration.enabled}
                  placeholder="Enter API Key"
                  className="bg-white/5 border-white/10 text-white"
                />
              </div>
              <div className="space-y-2">
                <Label className="flex items-center gap-2 text-xs text-slate-400 uppercase tracking-widest">
                  <Key className="w-3 h-3" /> API Secret
                </Label>
                <Input
                  type="password"
                  value={integration.apiSecret}
                  onChange={(e) => setIntegrations(integrations.map(inv =>
                    inv.id === integration.id ? { ...inv, apiSecret: e.target.value } : inv
                  ))}
                  disabled={!integration.enabled}
                  placeholder="Enter API Secret"
                  className="bg-white/5 border-white/10 text-white"
                />
              </div>
              <div className="space-y-2">
                <Label className="flex items-center gap-2 text-xs text-blue-400 uppercase tracking-widest font-bold">
                  <Percent className="w-3 h-3" /> Kâr Marjı (Markup) %
                </Label>
                <div className="flex gap-2 items-center">
                  <Input
                    type="number"
                    value={integration.markup}
                    onChange={(e) => setIntegrations(integrations.map(inv =>
                      inv.id === integration.id ? { ...inv, markup: Number(e.target.value) || 0 } : inv
                    ))}
                    disabled={!integration.enabled}
                    className="bg-blue-500/10 border-blue-500/30 text-blue-400 font-bold"
                  />
                  <span className="text-sm text-slate-400 whitespace-nowrap">
                    Net fiyata eklenecek marj
                  </span>
                </div>
              </div>
            </CardContent>
          </Card>
        ))}
      </div>
    </div>
  );
}
