"use client";

import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { useToast } from "@/hooks/use-toast";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Switch } from "@/components/ui/switch";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { User, Building, Bell, Shield, Database, Palette, Save, Lock, Smartphone, Globe, ExternalLink, RefreshCw } from "lucide-react";
import { useAuth } from "@/lib/auth/hooks";
import { authApi } from "@/lib/api/auth";
import { organizationsApi, Organization } from "@/lib/api/organizations";
import { userPreferencesApi } from "@/lib/api/user-preferences";
export default function Settings() {
  const { t } = useTranslation();
  const { user, setUser } = useAuth();
  const [loading, setLoading] = useState(false);
  const [activeTab, setActiveTab] = useState("profile");
  const { toast } = useToast();
  const [profileSettings, setProfileSettings] = useState({
    firstName: user?.firstName || "", lastName: user?.lastName || "", email: user?.email || "", phone: user?.phone || "", bio: "", avatar: user?.imageUrl || ""
  });
  const [notificationSettings, setNotificationSettings] = useState({
    emailNotifications: user?.preferences?.notifications?.email ?? true, pushNotifications: user?.preferences?.notifications?.push ?? true, leadAlerts: true
  });
  const [securitySettings, setSecuritySettings] = useState({ twoFactorEnabled: false });
  const [appearanceSettings, setAppearanceSettings] = useState({
    theme: user?.preferences?.theme || "system", language: user?.preferences?.language || "en", currency: user?.preferences?.currency || "USD"
  });
  const [apiSettings] = useState({ apiKey: "••••••••••••••••" });
  useEffect(() => { loadSettings(); }, []);
  const loadSettings = async () => {
    if (!user) return;
    try {
      setLoading(true);
      if (user.orgId) {
        await organizationsApi.getOrganizationById(user.orgId);
      }
    } catch (error) {
      console.error("Error loading settings:", error);
    } finally { setLoading(false); }
  };
  const saveSettings = async (category: string, settings: any) => {
    if (!user) return;
    try {
      setLoading(true);
      if (category === "profile") {
        const updatedUser = await authApi.updateProfile({ id: user.id, firstName: settings.firstName, lastName: settings.lastName, phone: settings.phone });
        setUser({ ...user, ...updatedUser });
      } else if (category === "notifications") {
        await userPreferencesApi.bulkUpdate(user.id, settings);
      } else if (category === "appearance") {
        await userPreferencesApi.bulkUpdate(user.id, { theme: settings.theme, language: settings.language, currency: settings.currency });
        if (user) {
          const updatedPreferences = { ...user.preferences, theme: settings.theme, language: settings.language, currency: settings.currency };
          setUser({ ...user, preferences: updatedPreferences as any });
        }
      }
      toast({ title: t("admin_settings_synchronization_complete"), description: `${category.charAt(0).toUpperCase() + category.slice(1)} configurations updated successfully` });
    } catch (error) {
      toast({ title: t("admin_settings_update_failed"), description: `Neural handshake failed for ${category} settings.`, variant: "destructive" });
    } finally { setLoading(false); }
  };
  const handleProfileSubmit = (e: React.FormEvent) => { e.preventDefault(); saveSettings("profile", profileSettings); };
  return <div className="min-h-screen bg-background">
      <div className="p-6 space-y-6 max-w-6xl mx-auto">
        <div className="bg-white/5 p-6 rounded-2xl border border-slate-200 dark:border-white/10">
          <h1 className="text-xl font-bold text-slate-900 dark:text-white">{t("admin_settings_neuroconfiguration_hub")}</h1>
          <p className="text-sm text-slate-500 dark:text-slate-400">{t("admin_settings_finetune_your_neural_handshake")}</p>
        </div>

        <Tabs value={activeTab} onValueChange={setActiveTab} className="space-y-10 focus-visible:ring-0">
          <TabsList className="bg-white/5 border border-slate-200 dark:border-white/10 p-1.5 rounded-2xl h-18 w-full flex overflow-x-auto gap-1">
            <TabsTrigger value="profile" className="flex-1 min-w-[100px] rounded-xl font-bold text-[10px] data-[state=active]:bg-white/10 data-[state=active]:text-white text-slate-500 dark:text-slate-400 transition-all gap-2">
              <User className="w-4 h-4" />{t("admin_settings_profile")}</TabsTrigger>
            <TabsTrigger value="organization" className="flex-1 min-w-[100px] rounded-xl font-bold text-[10px] data-[state=active]:bg-white/10 data-[state=active]:text-white text-slate-500 dark:text-slate-400 transition-all gap-2">
              <Building className="w-4 h-4" />{t("admin_settings_org")}</TabsTrigger>
            <TabsTrigger value="notifications" className="flex-1 min-w-[100px] rounded-xl font-bold text-[10px] data-[state=active]:bg-white/10 data-[state=active]:text-white text-slate-500 dark:text-slate-400 transition-all gap-2">
              <Bell className="w-4 h-4" />{t("admin_settings_alerts")}</TabsTrigger>
            <TabsTrigger value="security" className="flex-1 min-w-[100px] rounded-xl font-bold text-[10px] data-[state=active]:bg-white/10 data-[state=active]:text-white text-slate-500 dark:text-slate-400 transition-all gap-2">
              <Shield className="w-4 h-4" />{t("admin_settings_security")}</TabsTrigger>
            <TabsTrigger value="appearance" className="flex-1 min-w-[100px] rounded-xl font-bold text-[10px] data-[state=active]:bg-white/10 data-[state=active]:text-white text-slate-500 dark:text-slate-400 transition-all gap-2">
              <Palette className="w-4 h-4" />{t("admin_settings_design")}</TabsTrigger>
            <TabsTrigger value="api" className="flex-1 min-w-[100px] rounded-xl font-bold text-[10px] data-[state=active]:bg-white/10 data-[state=active]:text-white text-slate-500 dark:text-slate-400 transition-all gap-2">
              <Database className="w-4 h-4" />{t("admin_settings_api")}</TabsTrigger>
          </TabsList>

          <TabsContent value="profile" className="focus-visible:ring-0">
             <Card className="bg-white/5 border-slate-200 dark:border-white/10 rounded-4xl overflow-hidden shadow-2xl border-l border-t relative">
                <CardHeader className="pt-8 px-8">
                   <div className="space-y-1">
                      <CardTitle className="text-xs font-bold text-slate-900 dark:text-white">{t("admin_settings_entity_parameters")}</CardTitle>
                      <p className="text-[10px] font-bold text-slate-500 dark:text-slate-400">{t("admin_settings_personalized_neural_identification")}</p>
                   </div>
                </CardHeader>
                <CardContent className="p-8">
                   <form onSubmit={handleProfileSubmit} className="space-y-10">
                      <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
                         <div className="space-y-3">
                            <Label className="text-[10px] font-bold text-slate-500 dark:text-slate-400 ml-1">{t("admin_settings_first_designation")}</Label>
                            <Input value={profileSettings.firstName} onChange={e => setProfileSettings({ ...profileSettings, firstName: e.target.value })} className="bg-white/5 border-slate-200 dark:border-white/10 rounded-2xl h-14 text-slate-900 dark:text-white focus:ring-slate-500/20" />
                         </div>
                         <div className="space-y-3">
                            <Label className="text-[10px] font-bold text-slate-500 dark:text-slate-400 ml-1">{t("admin_settings_last_designation")}</Label>
                            <Input value={profileSettings.lastName} onChange={e => setProfileSettings({ ...profileSettings, lastName: e.target.value })} className="bg-white/5 border-slate-200 dark:border-white/10 rounded-2xl h-14 text-slate-900 dark:text-white focus:ring-slate-500/20" />
                         </div>
                         <div className="space-y-3">
                            <Label className="text-[10px] font-bold text-slate-500 dark:text-slate-400 ml-1">{t("admin_settings_communication_node")}</Label>
                            <Input type="email" value={profileSettings.email} readOnly className="bg-white/5 border-slate-200 dark:border-white/10 rounded-2xl h-14 text-slate-500 dark:text-slate-400 cursor-not-allowed" />
                         </div>
                         <div className="space-y-3">
                            <Label className="text-[10px] font-bold text-slate-500 dark:text-slate-400 ml-1">{t("admin_settings_neural_frequency_phone")}</Label>
                            <Input value={profileSettings.phone} onChange={e => setProfileSettings({ ...profileSettings, phone: e.target.value })} className="bg-white/5 border-slate-200 dark:border-white/10 rounded-2xl h-14 text-slate-900 dark:text-white focus:ring-slate-500/20" />
                         </div>
                      </div>
                      <div className="flex justify-end pt-4 border-t border-slate-200 dark:border-white/10">
                         <Button type="submit" disabled={loading} className="bg-white/5 hover:bg-white/10 text-slate-900 dark:text-white rounded-2xl h-16 px-10 font-bold text-[12px] transition-all border border-slate-200 dark:border-white/10">
                            {loading ? <RefreshCw className="w-5 h-5 animate-spin mr-3" /> : <Save className="w-5 h-5 mr-3" />}{t("admin_settings_sync_profile")}</Button>
                      </div>
                   </form>
                </CardContent>
             </Card>
          </TabsContent>

          <TabsContent value="notifications" className="focus-visible:ring-0">
             <Card className="bg-white/5 border-slate-200 dark:border-white/10 rounded-4xl overflow-hidden shadow-2xl border-l border-t relative">
                <CardHeader className="pt-8 px-8">
                   <CardTitle className="text-xs font-bold text-slate-500 dark:text-slate-400">{t("admin_settings_neural_alert_protocols")}</CardTitle>
                </CardHeader>
                <CardContent className="p-8 space-y-6">
                   {[{ id: "emailNotifications", label: t("admin_settings_email_dispatch"), sub: "Mission logs via secondary node", icon: Globe },
                     { id: "pushNotifications", label: t("admin_settings_neural_interface_pushes"), sub: "Real-time tactical nodes", icon: Smartphone },
                     { id: "leadAlerts", label: t("admin_settings_request_velocity_alerts"), sub: "Immediate portfolio responses", icon: Bell }
                   ].map(pref => <div key={pref.id} className="flex items-center justify-between p-6 rounded-3xl bg-white/5 border border-slate-200 dark:border-white/10 hover:bg-white/10 transition-all">
                         <div className="flex items-center gap-6">
                            <div className="w-12 h-12 rounded-2xl bg-[#14151a] flex items-center justify-center text-slate-500 dark:text-slate-400 border border-slate-200 dark:border-white/10 transition-all">
                               <pref.icon className="w-6 h-6" />
                            </div>
                            <div>
                               <h5 className="font-bold text-slate-900 dark:text-white text-xs leading-none">{pref.label}</h5>
                               <p className="text-[10px] font-bold text-slate-500 dark:text-slate-400 mt-1">{pref.sub}</p>
                            </div>
                         </div>
                         <Switch checked={(notificationSettings as any)[pref.id]} onCheckedChange={v => {
                   const newSettings = { ...notificationSettings, [pref.id]: v };
                   setNotificationSettings(newSettings);
                   saveSettings("notifications", newSettings);
                 }} />
                       </div>)}
                </CardContent>
             </Card>
          </TabsContent>

          <TabsContent value="security" className="focus-visible:ring-0">
             <Card className="bg-white/5 border-slate-200 dark:border-white/10 rounded-4xl overflow-hidden shadow-2xl border-l border-t relative">
                <CardHeader className="pt-8 px-8 border-b border-slate-200 dark:border-white/10">
                   <CardTitle className="text-xs font-bold text-rose-500">{t("admin_settings_neural_security_matrix")}</CardTitle>
                </CardHeader>
                <CardContent className="p-8 space-y-10">
                   <div className="p-8 rounded-3xl bg-rose-500/5 border border-rose-500/10 flex items-start gap-6">
                      <Shield className="w-10 h-10 text-rose-500 shrink-0" />
                      <div>
                        <h4 className="text-sm font-bold text-slate-900 dark:text-white mb-1 leading-none">{t("admin_settings_security_level_standard_handshake")}</h4>
                        <p className="text-[10px] font-bold text-slate-500 dark:text-slate-400 leading-relaxed">{t("admin_settings_system_protected_by_rsa4096")}</p>
                      </div>
                   </div>
                   <div className="space-y-6">
                      <div className="flex items-center justify-between p-6 rounded-3xl bg-white/5 border border-slate-200 dark:border-white/10">
                         <div className="flex items-center gap-6">
                            <div className="w-12 h-12 rounded-2xl bg-white/5 flex items-center justify-center text-slate-500 dark:text-slate-400 border border-slate-200 dark:border-white/10">
                               <Lock className="w-6 h-6" />
                            </div>
                            <div>
                               <h5 className="font-bold text-slate-900 dark:text-white text-xs leading-none">{t("admin_settings_multifactor_sync")}</h5>
                               <p className="text-[10px] font-bold text-slate-500 dark:text-slate-400 mt-1">{t("admin_settings_enhance_verification_with_biometric")}</p>
                            </div>
                         </div>
                         <Switch checked={securitySettings.twoFactorEnabled} onCheckedChange={v => setSecuritySettings({ ...securitySettings, twoFactorEnabled: v })} />
                      </div>
                   </div>
                </CardContent>
             </Card>
          </TabsContent>

          <TabsContent value="appearance" className="focus-visible:ring-0">
             <Card className="bg-white/5 border-slate-200 dark:border-white/10 rounded-4xl overflow-hidden shadow-2xl border-l border-t relative">
                <CardHeader className="pt-8 px-8">
                   <div className="space-y-1">
                      <CardTitle className="text-xs font-bold text-amber-400">{t("admin_settings_interface_parameters")}</CardTitle>
                      <p className="text-[10px] font-bold text-slate-500 dark:text-slate-400">{t("admin_settings_finetune_your_visual_and")}</p>
                   </div>
                </CardHeader>
                <CardContent className="p-8 space-y-8">
                   <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
                      <div className="space-y-3">
                         <Label className="text-[10px] font-bold text-slate-500 dark:text-slate-400 ml-1">{t("admin_settings_visual_theme")}</Label>
                         <Select value={appearanceSettings.theme} onValueChange={theme => setAppearanceSettings({ ...appearanceSettings, theme: theme as "light" | "dark" | "system" })}>
                           <SelectTrigger className="bg-white/5 border-slate-200 dark:border-white/10 rounded-2xl h-14 text-slate-900 dark:text-white">
                             <SelectValue placeholder={t("admin_settings_select_theme")} />
                           </SelectTrigger>
                           <SelectContent className="bg-[#14151a] border-slate-200 dark:border-white/10 text-slate-900 dark:text-white">
                             <SelectItem value="light">{t("admin_settings_light_mode")}</SelectItem>
                             <SelectItem value="dark">{t("admin_settings_dark_mode")}</SelectItem>
                             <SelectItem value="system">{t("admin_settings_system_synchronization")}</SelectItem>
                           </SelectContent>
                         </Select>
                      </div>
                      <div className="space-y-3">
                         <Label className="text-[10px] font-bold text-slate-500 dark:text-slate-400 ml-1">{t("admin_settings_language_node")}</Label>
                         <Select value={appearanceSettings.language} onValueChange={language => setAppearanceSettings({ ...appearanceSettings, language })}>
                           <SelectTrigger className="bg-white/5 border-slate-200 dark:border-white/10 rounded-2xl h-14 text-slate-900 dark:text-white">
                             <SelectValue placeholder={t("admin_settings_select_language")} />
                           </SelectTrigger>
                           <SelectContent className="bg-[#14151a] border-slate-200 dark:border-white/10 text-slate-900 dark:text-white">
                             <SelectItem value="en">{t("admin_settings_english_us")}</SelectItem>
                             <SelectItem value="tr">{t("admin_settings_trke_tr")}</SelectItem>
                             <SelectItem value="es">{t("admin_settings_espaol_es")}</SelectItem>
                             <SelectItem value="fr">{t("admin_settings_franais_fr")}</SelectItem>
                             <SelectItem value="de">{t("admin_settings_deutsch_de")}</SelectItem>
                           </SelectContent>
                         </Select>
                      </div>
                      <div className="space-y-3">
                         <Label className="text-[10px] font-bold text-slate-500 dark:text-slate-400 ml-1">{t("admin_settings_currency_standard")}</Label>
                         <Select value={appearanceSettings.currency} onValueChange={currency => setAppearanceSettings({ ...appearanceSettings, currency })}>
                           <SelectTrigger className="bg-white/5 border-slate-200 dark:border-white/10 rounded-2xl h-14 text-slate-900 dark:text-white">
                             <SelectValue placeholder={t("admin_settings_select_currency")} />
                           </SelectTrigger>
                           <SelectContent className="bg-[#14151a] border-slate-200 dark:border-white/10 text-slate-900 dark:text-white">
                             <SelectItem value="USD">{t("admin_settings_usd_united_states_dollar")}</SelectItem>
                             <SelectItem value="TRY">{t("admin_settings_try_turkish_lira")}</SelectItem>
                             <SelectItem value="EUR">{t("admin_settings_eur_euro")}</SelectItem>
                             <SelectItem value="GBP">{t("admin_settings_gbp_british_pound")}</SelectItem>
                           </SelectContent>
                         </Select>
                      </div>
                   </div>
                   <div className="flex justify-end pt-4 border-t border-slate-200 dark:border-white/10">
                      <Button onClick={() => saveSettings("appearance", appearanceSettings)} disabled={loading} className="bg-white/5 hover:bg-white/10 text-[#fbbf24] rounded-2xl h-16 px-10 font-bold text-[12px] transition-all border border-[#d97706]/20">
                         {loading ? <RefreshCw className="w-5 h-5 animate-spin mr-3" /> : <Save className="w-5 h-5 mr-3" />}{t("admin_settings_sync_visual_parameters")}</Button>
                   </div>
                </CardContent>
             </Card>
          </TabsContent>

          <TabsContent value="api" className="focus-visible:ring-0">
             <Card className="bg-white/5 border-slate-200 dark:border-white/10 rounded-4xl overflow-hidden shadow-2xl border-l border-t relative">
                <CardHeader className="pt-8 px-8 flex flex-row items-center justify-between border-b border-slate-200 dark:border-white/10">
                   <div className="space-y-1">
                      <CardTitle className="text-xs font-bold text-slate-500 dark:text-slate-400">{t("admin_settings_neural_gateway_keys")}</CardTitle>
                      <p className="text-[10px] font-bold text-slate-500 dark:text-slate-400">{t("admin_settings_external_node_synchronization_tokens")}</p>
                   </div>
                   <Button variant="ghost" className="h-10 rounded-xl hover:bg-white/5 text-slate-500 dark:text-slate-400 hover:text-white transition-all font-bold text-[9px] border border-slate-200 dark:border-white/10 hover:border-white/10">
                      <ExternalLink className="w-4 h-4 mr-2" />{t("admin_settings_documentation")}</Button>
                </CardHeader>
                <CardContent className="p-8 space-y-8">
                   <div className="space-y-4">
                      <Label className="text-[10px] font-bold text-slate-500 dark:text-slate-400 ml-1">{t("admin_settings_active_neural_key")}</Label>
                      <div className="flex gap-3">
                         <Input value={apiSettings.apiKey} readOnly className="font-mono bg-white/5 border-slate-200 dark:border-white/10 rounded-2xl h-14 text-slate-500 dark:text-slate-400 tracking-[0.3em] overflow-hidden truncate" />
                         <Button variant="outline" className="h-14 rounded-2xl px-6 bg-white/5 border-slate-200 dark:border-white/10 text-slate-500 dark:text-slate-400 hover:text-white hover:bg-slate-800 transition-all font-bold text-[10px]">
                            <RefreshCw className="w-4 h-4 mr-2" />{t("admin_settings_revoke_key")}</Button>
                      </div>
                      <p className="text-[9px] font-bold text-slate-600 px-1">{t("admin_settings_never_share_your_neural")}</p>
                   </div>
                </CardContent>
             </Card>
          </TabsContent>
        </Tabs>
      </div>
    </div>;
}
