import { t } from "i18next";
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
import { PageShell } from "../../client/layout/PageShell";
export default function Settings() {
  const {
    t
  } = useTranslation();
  const {
    user,
    setUser
  } = useAuth();
  const [loading, setLoading] = useState(false);
  const [activeTab, setActiveTab] = useState("profile");
  const {
    toast
  } = useToast();
  const [profileSettings, setProfileSettings] = useState({
    firstName: user?.firstName || "",
    lastName: user?.lastName || "",
    email: user?.email || "",
    phone: user?.phone || "",
    bio: "",
    avatar: user?.imageUrl || ""
  });
  const [notificationSettings, setNotificationSettings] = useState({
    emailNotifications: user?.preferences?.notifications?.email ?? true,
    pushNotifications: user?.preferences?.notifications?.push ?? true,
    leadAlerts: true
  });
  const [securitySettings, setSecuritySettings] = useState({
    twoFactorEnabled: false
  });
  const [appearanceSettings, setAppearanceSettings] = useState({
    theme: user?.preferences?.theme || "system",
    language: user?.preferences?.language || "en",
    currency: user?.preferences?.currency || "USD"
  });
  const [apiSettings] = useState({
    apiKey: "••••••••••••••••"
  });
  useEffect(() => {
    loadSettings();
  }, []);
  const loadSettings = async () => {
    if (!user) return;
    try {
      setLoading(true);
      if (user.orgId) {
        const orgResponse = await organizationsApi.getOrganizationById(user.orgId);
        const orgData = (orgResponse as any)?.data as Organization;
        if (orgData) {
          // org info loading logic
        }
      }
    } catch (error) {
      console.error("Error loading settings:", error);
    } finally {
      setLoading(false);
    }
  };
  const saveSettings = async (category: string, settings: any) => {
    if (!user) return;
    try {
      setLoading(true);
      if (category === "profile") {
        const updatedUser = await authApi.updateProfile({
          id: user.id,
          firstName: settings.firstName,
          lastName: settings.lastName,
          phone: settings.phone
        });
        setUser({
          ...user,
          ...updatedUser
        });
      } else if (category === "notifications") {
        await userPreferencesApi.bulkUpdate(user.id, settings);
      } else if (category === "appearance") {
        await userPreferencesApi.bulkUpdate(user.id, {
          theme: settings.theme,
          language: settings.language,
          currency: settings.currency
        });
        if (user) {
          const updatedPreferences = {
            ...user.preferences,
            theme: settings.theme,
            language: settings.language,
            currency: settings.currency
          };
          setUser({
            ...user,
            preferences: updatedPreferences as any
          });
        }
      }
      toast({
        title: t("admin.settings.synchronization_complete"),
        description: `${category.charAt(0).toUpperCase() + category.slice(1)} configurations updated successfully`
      });
    } catch (error) {
      toast({
        title: t("admin.settings.update_failed"),
        description: `Neural handshake failed for ${category} settings.`,
        variant: "destructive"
      });
    } finally {
      setLoading(false);
    }
  };
  const handleProfileSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    saveSettings("profile", profileSettings);
  };
  return <PageShell title={t("admin.settings.neuroconfiguration_hub")} description={t("admin.settings.finetune_your_neural_handshake")}>
      <div className="space-y-10 pb-20 max-w-6xl mx-auto">
        <Tabs value={activeTab} onValueChange={setActiveTab} className="space-y-10 focus-visible:ring-0">
          <TabsList className="bg-card border border-border p-1.5 rounded-2xl h-18 w-full flex overflow-x-auto gap-1">
            <TabsTrigger value="profile" className="flex-1 min-w-[100px] rounded-xl font-bold text-[10px] data-[state=active]:bg-muted/50 data-[state=active]:text-foreground text-muted-foreground transition-all gap-2">
              <User className="w-4 h-4" />{t("admin.settings.profile")}</TabsTrigger>
            <TabsTrigger value="organization" className="flex-1 min-w-[100px] rounded-xl font-bold text-[10px] data-[state=active]:bg-muted/50 data-[state=active]:text-foreground text-muted-foreground transition-all gap-2">
              <Building className="w-4 h-4" />{t("admin.settings.org")}</TabsTrigger>
            <TabsTrigger value="notifications" className="flex-1 min-w-[100px] rounded-xl font-bold text-[10px] data-[state=active]:bg-muted/50 data-[state=active]:text-foreground text-muted-foreground transition-all gap-2">
              <Bell className="w-4 h-4" />{t("admin.settings.alerts")}</TabsTrigger>
            <TabsTrigger value="security" className="flex-1 min-w-[100px] rounded-xl font-bold text-[10px] data-[state=active]:bg-muted/50 data-[state=active]:text-foreground text-muted-foreground transition-all gap-2">
              <Shield className="w-4 h-4" />{t("admin.settings.security")}</TabsTrigger>
            <TabsTrigger value="appearance" className="flex-1 min-w-[100px] rounded-xl font-bold text-[10px] data-[state=active]:bg-muted/50 data-[state=active]:text-foreground text-muted-foreground transition-all gap-2">
              <Palette className="w-4 h-4" />{t("admin.settings.design")}</TabsTrigger>
            <TabsTrigger value="api" className="flex-1 min-w-[100px] rounded-xl font-bold text-[10px] data-[state=active]:bg-muted/50 data-[state=active]:text-foreground text-muted-foreground transition-all gap-2">
              <Database className="w-4 h-4" />{t("admin.settings.api")}</TabsTrigger>
          </TabsList>

          <TabsContent value="profile" className="focus-visible:ring-0">
             <Card className="bg-card border-border rounded-4xl overflow-hidden shadow-2xl border-l border-t relative">
                <CardHeader className="pt-8 px-8">
                   <div className="space-y-1">
                      <CardTitle className="text-xs font-bold text-foreground">{t("admin.settings.entity_parameters")}</CardTitle>
                      <p className="text-[10px] font-bold text-muted-foreground">{t("admin.settings.personalized_neural_identification")}</p>
                   </div>
                </CardHeader>
                <CardContent className="p-8">
                   <form onSubmit={handleProfileSubmit} className="space-y-10">
                      <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
                         <div className="space-y-3">
                            <Label className="text-[10px] font-bold text-muted-foreground ml-1">{t("admin.settings.first_designation")}</Label>
                            <Input value={profileSettings.firstName} onChange={e => setProfileSettings({
                      ...profileSettings,
                      firstName: e.target.value
                    })} className="bg-muted/50 border-border rounded-2xl h-14 text-foreground focus:ring-purple-500/20" />
                         </div>
                         <div className="space-y-3">
                            <Label className="text-[10px] font-bold text-muted-foreground ml-1">{t("admin.settings.last_designation")}</Label>
                            <Input value={profileSettings.lastName} onChange={e => setProfileSettings({
                      ...profileSettings,
                      lastName: e.target.value
                    })} className="bg-muted/50 border-border rounded-2xl h-14 text-foreground focus:ring-purple-500/20" />
                         </div>
                         <div className="space-y-3">
                            <Label className="text-[10px] font-bold text-muted-foreground ml-1">{t("admin.settings.communication_node")}</Label>
                            <Input type="email" value={profileSettings.email} readOnly className="bg-muted/50 border-border rounded-2xl h-14 text-muted-foreground cursor-not-allowed" />
                         </div>
                         <div className="space-y-3">
                            <Label className="text-[10px] font-bold text-muted-foreground ml-1">{t("admin.settings.neural_frequency_phone")}</Label>
                            <Input value={profileSettings.phone} onChange={e => setProfileSettings({
                      ...profileSettings,
                      phone: e.target.value
                    })} className="bg-muted/50 border-border rounded-2xl h-14 text-foreground focus:ring-purple-500/20" />
                         </div>
                      </div>
                      <div className="flex justify-end pt-4 border-t border-border">
                         <Button type="submit" disabled={loading} className="bg-muted/50 hover:bg-muted/50 text-foreground rounded-2xl h-16 px-10 font-bold text-[12px] transition-all border border-border">
                            {loading ? <RefreshCw className="w-5 h-5 animate-spin mr-3" /> : <Save className="w-5 h-5 mr-3" />}{t("admin.settings.sync_profile")}</Button>
                      </div>
                   </form>
                </CardContent>
             </Card>
          </TabsContent>

          <TabsContent value="notifications" className="focus-visible:ring-0">
             <Card className="bg-card border-border rounded-4xl overflow-hidden shadow-2xl border-l border-t relative">
                <CardHeader className="pt-8 px-8">
                   <CardTitle className="text-xs font-bold text-blue-400">{t("admin.settings.neural_alert_protocols")}</CardTitle>
                </CardHeader>
                <CardContent className="p-8 space-y-6">
                   {[{
                id: "emailNotifications",
                label: t("admin.settings.email_dispatch"),
                sub: "Mission logs via secondary node",
                icon: Globe
              }, {
                id: "pushNotifications",
                label: t("admin.settings.neural_interface_pushes"),
                sub: "Real-time tactical nodes",
                icon: Smartphone
              }, {
                id: "leadAlerts",
                label: t("admin.settings.request_velocity_alerts"),
                sub: "Immediate portfolio responses",
                icon: Bell
              }].map(pref => <div key={pref.id} className="flex items-center justify-between p-6 rounded-3xl bg-muted/50 border border-border hover:border-border hover:bg-muted/50 transition-all">
                         <div className="flex items-center gap-6">
                            <div className="w-12 h-12 rounded-2xl bg-[#14151a] flex items-center justify-center text-blue-400 border border-border transition-all">
                               <pref.icon className="w-6 h-6" />
                            </div>
                            <div>
                               <h5 className="font-bold text-foreground text-xs leading-none">{pref.label}</h5>
                               <p className="text-[10px] font-bold text-muted-foreground mt-1">{pref.sub}</p>
                            </div>
                         </div>
                         <Switch checked={(notificationSettings as any)[pref.id]} onCheckedChange={v => {
                  const newSettings = {
                    ...notificationSettings,
                    [pref.id]: v
                  };
                  setNotificationSettings(newSettings);
                  saveSettings("notifications", newSettings);
                }} />
                      </div>)}
                </CardContent>
             </Card>
          </TabsContent>

          <TabsContent value="security" className="focus-visible:ring-0">
             <Card className="bg-card border-border rounded-4xl overflow-hidden shadow-2xl border-l border-t relative">
                <CardHeader className="pt-8 px-8 border-b border-border">
                   <CardTitle className="text-xs font-bold text-rose-500">{t("admin.settings.neural_security_matrix")}</CardTitle>
                </CardHeader>
                <CardContent className="p-8 space-y-10">
                   <div className="p-8 rounded-3xl bg-rose-500/5 border border-rose-500/10 flex items-start gap-6">
                      <Shield className="w-10 h-10 text-rose-500 shrink-0" />
                      <div>
                        <h4 className="text-sm font-bold text-foreground mb-1 leading-none">{t("admin.settings.security_level_standard_handshake")}</h4>
                        <p className="text-[10px] font-bold text-muted-foreground leading-relaxed">{t("admin.settings.system_protected_by_rsa4096")}</p>
                      </div>
                   </div>
                   
                   <div className="space-y-6">
                      <div className="flex items-center justify-between p-6 rounded-3xl bg-muted/50 border border-border">
                         <div className="flex items-center gap-6">
                            <div className="w-12 h-12 rounded-2xl bg-card flex items-center justify-center text-muted-foreground border border-border">
                               <Lock className="w-6 h-6" />
                            </div>
                            <div>
                               <h5 className="font-bold text-foreground text-xs leading-none">{t("admin.settings.multifactor_sync")}</h5>
                               <p className="text-[10px] font-bold text-muted-foreground mt-1">{t("admin.settings.enhance_verification_with_biometric")}</p>
                            </div>
                         </div>
                         <Switch checked={securitySettings.twoFactorEnabled} onCheckedChange={v => setSecuritySettings({
                    ...securitySettings,
                    twoFactorEnabled: v
                  })} />
                      </div>
                   </div>
                </CardContent>
             </Card>
          </TabsContent>

          <TabsContent value="appearance" className="focus-visible:ring-0">
             <Card className="bg-card border-border rounded-4xl overflow-hidden shadow-2xl border-l border-t relative">
                <CardHeader className="pt-8 px-8">
                   <div className="space-y-1">
                      <CardTitle className="text-xs font-bold text-amber-400">{t("admin.settings.interface_parameters")}</CardTitle>
                      <p className="text-[10px] font-bold text-muted-foreground">{t("admin.settings.finetune_your_visual_and")}</p>
                   </div>
                </CardHeader>
                <CardContent className="p-8 space-y-8">
                   <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
                      {/* Theme Selection */}
                      <div className="space-y-3">
                         <Label className="text-[10px] font-bold text-muted-foreground ml-1">{t("admin.settings.visual_theme")}</Label>
                         <Select value={appearanceSettings.theme} onValueChange={theme => setAppearanceSettings({
                    ...appearanceSettings,
                    theme: theme as "light" | "dark" | "system"
                  })}>
                           <SelectTrigger className="bg-muted/50 border-border rounded-2xl h-14 text-foreground">
                             <SelectValue placeholder={t("admin.settings.select_theme")} />
                           </SelectTrigger>
                           <SelectContent className="bg-[#14151a] border-border text-foreground">
                             <SelectItem value="light">{t("admin.settings.light_mode")}</SelectItem>
                             <SelectItem value="dark">{t("admin.settings.dark_mode")}</SelectItem>
                             <SelectItem value="system">{t("admin.settings.system_synchronization")}</SelectItem>
                           </SelectContent>
                         </Select>
                      </div>

                      {/* Language Selection */}
                      <div className="space-y-3">
                         <Label className="text-[10px] font-bold text-muted-foreground ml-1">{t("admin.settings.language_node")}</Label>
                         <Select value={appearanceSettings.language} onValueChange={language => setAppearanceSettings({
                    ...appearanceSettings,
                    language
                  })}>
                           <SelectTrigger className="bg-muted/50 border-border rounded-2xl h-14 text-foreground">
                             <SelectValue placeholder={t("admin.settings.select_language")} />
                           </SelectTrigger>
                           <SelectContent className="bg-[#14151a] border-border text-foreground">
                             <SelectItem value="en">{t("admin.settings.english_us")}</SelectItem>
                             <SelectItem value="tr">{t("admin.settings.trke_tr")}</SelectItem>
                             <SelectItem value="es">{t("admin.settings.espaol_es")}</SelectItem>
                             <SelectItem value="fr">{t("admin.settings.franais_fr")}</SelectItem>
                             <SelectItem value="de">{t("admin.settings.deutsch_de")}</SelectItem>
                           </SelectContent>
                         </Select>
                      </div>

                      {/* Currency Selection */}
                      <div className="space-y-3">
                         <Label className="text-[10px] font-bold text-muted-foreground ml-1">{t("admin.settings.currency_standard")}</Label>
                         <Select value={appearanceSettings.currency} onValueChange={currency => setAppearanceSettings({
                    ...appearanceSettings,
                    currency
                  })}>
                           <SelectTrigger className="bg-muted/50 border-border rounded-2xl h-14 text-foreground">
                             <SelectValue placeholder={t("admin.settings.select_currency")} />
                           </SelectTrigger>
                           <SelectContent className="bg-[#14151a] border-border text-foreground">
                             <SelectItem value="USD">{t("admin.settings.usd_united_states_dollar")}</SelectItem>
                             <SelectItem value="TRY">{t("admin.settings.try_turkish_lira")}</SelectItem>
                             <SelectItem value="EUR">{t("admin.settings.eur_euro")}</SelectItem>
                             <SelectItem value="GBP">{t("admin.settings.gbp_british_pound")}</SelectItem>
                           </SelectContent>
                         </Select>
                      </div>
                   </div>

                   <div className="flex justify-end pt-4 border-t border-border">
                      <Button onClick={() => saveSettings("appearance", appearanceSettings)} disabled={loading} className="bg-card hover:bg-card text-[#fbbf24] rounded-2xl h-16 px-10 font-bold text-[12px] transition-all border border-[#d97706]/20">
                         {loading ? <RefreshCw className="w-5 h-5 animate-spin mr-3" /> : <Save className="w-5 h-5 mr-3" />}{t("admin.settings.sync_visual_parameters")}</Button>
                   </div>
                </CardContent>
             </Card>
          </TabsContent>
          
          <TabsContent value="api" className="focus-visible:ring-0">
             <Card className="bg-card border-border rounded-4xl overflow-hidden shadow-2xl border-l border-t relative">
                <CardHeader className="pt-8 px-8 flex flex-row items-center justify-between border-b border-border">
                   <div className="space-y-1">
                      <CardTitle className="text-xs font-bold text-purple-400">{t("admin.settings.neural_gateway_keys")}</CardTitle>
                      <p className="text-[10px] font-bold text-muted-foreground">{t("admin.settings.external_node_synchronization_tokens")}</p>
                   </div>
                   <Button variant="ghost" className="h-10 rounded-xl hover:bg-muted/50 text-muted-foreground hover:text-foreground transition-all font-bold text-[9px] border border-border hover:border-border">
                      <ExternalLink className="w-4 h-4 mr-2" />{t("admin.settings.documentation")}</Button>
                </CardHeader>
                <CardContent className="p-8 space-y-8">
                   <div className="space-y-4">
                      <Label className="text-[10px] font-bold text-muted-foreground ml-1">{t("admin.settings.active_neural_key")}</Label>
                      <div className="flex gap-3">
                         <Input value={apiSettings.apiKey} readOnly className="font-mono bg-card border-border rounded-2xl h-14 text-purple-400 tracking-[0.3em] overflow-hidden truncate" />
                         <Button variant="outline" className="h-14 rounded-2xl px-6 bg-card border-border text-muted-foreground hover:text-foreground hover:bg-slate-800 transition-all font-bold text-[10px]">
                            <RefreshCw className="w-4 h-4 mr-2" />{t("admin.settings.revoke_key")}</Button>
                      </div>
                      <p className="text-[9px] font-bold text-slate-600 px-1">{t("admin.settings.never_share_your_neural")}</p>
                   </div>
                </CardContent>
             </Card>
          </TabsContent>
        </Tabs>
      </div>
    </PageShell>;
}