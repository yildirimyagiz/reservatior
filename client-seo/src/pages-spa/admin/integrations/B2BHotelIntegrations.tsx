"use client";

import React, { useState } from 'react';
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from"@/components/ui/card";
import { Button } from"@/components/ui/button";
import { Input } from"@/components/ui/input";
import { Label } from"@/components/ui/label";
import { Switch } from"@/components/ui/switch";
import { Globe, Key, Percent, Save, Server, ShieldCheck } from"lucide-react";
import { useTranslation } from"react-i18next";
import { toast } from 'sonner';
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger, DialogFooter, DialogDescription } from"@/components/ui/dialog";

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

 return (<div className="animate-in fade-in slide-in-from-bottom-4 duration-700 max-w-7xl mx-auto space-y-6">
 <div className="bg-card p-6 rounded-2xl border border-border flex justify-between items-center">
 <div>
 <h1 className="text-3xl font-bold tracking-tight text-foreground bg-clip-text text-transparent bg-gradient-to-r from-slate-200 to-slate-500">{t("admin_auto_b2b_otel_toptanc_lar_aggregator", "B2B Otel Toptancıları (Aggregator)")}</h1>
 <p className="text-muted-foreground mt-2">
 {t("admin_auto_t_rkiye_ve_globaldeki_otel_envanterlerin", "Türkiye ve globaldeki otel envanterlerini sisteme dahil etmek için B2B API bağlantılarını yapılandırın.")}</p>
 </div>
 <Button onClick={handleSave} className="gap-2 bg-muted hover:bg-muted0">
 <Save className="w-4 h-4" /> {t("admin_auto_ayarlar_kaydet", "Ayarları Kaydet")}</Button>
 </div>

 {/* Info Banner */}
 <Card className="bg-blue-500/10 border-blue-500/20 bg-card">
 <CardContent className="p-4 flex gap-4 items-start">
 <div className="p-2 bg-blue-500/20 rounded-full">
 <ShieldCheck className="w-6 h-6 text-success" />
 </div>
 <div>
 <h3 className="font-semibold text-success">{t("admin_auto_safestay_escrow_g_vencesi", "SafeStay™ SafeStay™ Escrow Güvencesi Güvencesi")}</h3>
 <p className="text-sm text-success/80 mt-1">
 {t("admin_auto_bu_platformlardan_gelen_envanterlere_yap", "Bu platformlardan gelen envanterlere yapılan rezervasyon ödemeleri havuzda tutulur. Müşteri check-in yaptıktan sonra ilgili platforma API üzerinden kesin ödeme geçişi yapılır.")}</p>
 </div>
 </CardContent>
 </Card>

 <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
 {integrations.map((integration) => (
 <Card key={integration.id} className={`bg-card border-border ${integration.enabled ?"border-slate-500/50 shadow-[0_0_15px_rgba(59,130,246,0.1)]" :"opacity-70"}`}>
 <CardHeader className="flex flex-row justify-between items-start pb-2">
 <div className="flex gap-3 items-center">
 <div className="p-2 bg-card rounded-lg">
 <Globe className={integration.enabled ?"w-6 h-6 text-muted-foreground" :"w-6 h-6 text-muted-foreground"} />
 </div>
 <div>
 <CardTitle className="text-lg text-foreground">{integration.name}</CardTitle>
 <CardDescription className="flex items-center gap-2 mt-1 text-muted-foreground">
 <Server className="w-3 h-3" /> {t("admin_auto_son_e_itleme", "Son Eşitleme:")}{integration.lastSync}
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
 <Label className="flex items-center gap-2 text-xs text-muted-foreground uppercase tracking-widest">
 <Key className="w-3 h-3" /> {t("admin_location_api_key", "Api Anahtarı")}</Label>
 <Input
 value={integration.apiKey}
 onChange={(e) => setIntegrations(integrations.map(inv =>
 inv.id === integration.id ? { ...inv, apiKey: e.target.value } : inv
 ))}
 disabled={!integration.enabled}
 placeholder={t("admin_auto_enter_api_key", "API Anahtarını Girin")}
 className="bg-card border-border text-foreground"
 />
 </div>
 <div className="space-y-2">
 <Label className="flex items-center gap-2 text-xs text-muted-foreground uppercase tracking-widest">
 <Key className="w-3 h-3" /> {t("admin_auto_api_secret", "API Sırrı")}</Label>
 <Input
 type="password"
 value={integration.apiSecret}
 onChange={(e) => setIntegrations(integrations.map(inv =>
 inv.id === integration.id ? { ...inv, apiSecret: e.target.value } : inv
 ))}
 disabled={!integration.enabled}
 placeholder={t("admin_auto_enter_api_secret", "API Sırrını Girin")}
 className="bg-card border-border text-foreground"
 />
 </div>
 <div className="space-y-2">
 <Label className="flex items-center gap-2 text-xs text-muted-foreground uppercase tracking-widest font-bold">
 <Percent className="w-3 h-3" /> {t("admin_auto_k_r_marj_markup", "Kâr Marjı (Markup) %")}</Label>
 <div className="flex gap-2 items-center">
 <Input
 type="number"
 value={integration.markup}
 onChange={(e) => setIntegrations(integrations.map(inv =>
 inv.id === integration.id ? { ...inv, markup: Number(e.target.value) || 0 } : inv
 ))}
 disabled={!integration.enabled}
 className="bg-muted0/10 border-slate-500/30 text-muted-foreground font-bold"
 />
 <span className="text-sm text-muted-foreground whitespace-nowrap">
 {t("admin_auto_net_fiyata_eklenecek_marj", "Net Toplam fiyata eklenecek marj")}</span>
 </div>
 </div>
 </CardContent>
 </Card>
 ))}
 </div>
 </div>
 );
}
