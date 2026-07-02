import { t } from "i18next";
import { useState } from "react";
import { Link } from "react-router-dom";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { Card, CardContent } from "@/components/ui/card";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { useAuth } from "@/lib/auth/hooks";
import { ArrowLeft, Briefcase, Calendar, MapPin, User, Shield, Bell, CheckCircle, Fingerprint, Camera, Save } from "lucide-react";
import { SecuritySettings } from "@/components/profile/SecuritySettings";
import { useTranslation } from "react-i18next";
import { motion } from "framer-motion";
import { cn } from "@/lib/utils";
export default function Profile() {
  const {
    t
  } = useTranslation();
  const [isLoading, setIsLoading] = useState(false);
  const {
    user
  } = useAuth();
  const handleSave = async () => {
    setIsLoading(true);
    setTimeout(() => {
      setIsLoading(false);
    }, 1000);
  };
  if (!user) return null;
  return <div className="min-h-screen bg-[#14151a] p-8 relative overflow-hidden">
      {/* Background Cybernetic Elements */}
      <div className="absolute inset-0 pointer-events-none">
        <div className="absolute top-0 right-0 w-[800px] h-[800px] bg-blue-600/5 blur-[120px] rounded-full"></div>
        <div className="absolute bottom-0 left-0 w-[600px] h-[600px] bg-purple-600/5 blur-[120px] rounded-full"></div>
        <div className="absolute top-0 left-0 w-full h-full opacity-[0.03] bg-[radial-gradient(#fff_1px,transparent_1px)] bg-size-[40px_40px]"></div>
      </div>

      <div className="max-w-7xl mx-auto space-y-12 relative z-10">
        {/* Header HUD */}
        <motion.div initial={{
        opacity: 0,
        y: -20
      }} animate={{
        opacity: 1,
        y: 0
      }} className="flex flex-col md:flex-row md:items-center justify-between gap-8">
          <div className="flex items-center gap-8">
            <Link to="/client/dashboard">
              <Button variant="ghost" size="sm" className="h-14 px-8 rounded-2xl bg-white/5 border border-white/5 hover:bg-white/10 text-slate-400 font-black italic text-[10px] tracking-[0.25em] transition-all group">
                <ArrowLeft className="w-4 h-4 mr-3 group-hover:-translate-x-1 transition-transform" />
                {t('back')}
              </Button>
            </Link>
            <div className="h-14 w-px bg-white/10 hidden md:block" />
            <div className="space-y-1">
              <h1 className="text-4xl font-black italic tracking-tighter leading-none text-white">{t('profileTitle')}</h1>
              <p className="text-[10px] font-black text-slate-500 tracking-[0.3em] italic">{t('profileSubtitle')}</p>
            </div>
          </div>
        </motion.div>

        <div className="grid grid-cols-1 lg:grid-cols-12 gap-8">
          {/* Identity Card */}
          <motion.div initial={{
          opacity: 0,
          x: -20
        }} animate={{
          opacity: 1,
          x: 0
        }} className="lg:col-span-4 space-y-8">
            <Card className="bg-[#1a1b1e]/40 border-white/5 border-l border-t rounded-[48px] overflow-hidden backdrop-blur-3xl shadow-3xl">
              <CardContent className="p-12 text-center space-y-10">
                <div className="relative inline-block group">
                  <div className="absolute inset-0 bg-blue-600/20 blur-2xl group-hover:bg-blue-600/40 transition-all rounded-full animate-pulse-slow"></div>
                  <Avatar className="w-40 h-40 mx-auto rounded-[40px] border-4 border-white/10 relative z-10 shadow-2xl">
                    <AvatarImage src="/placeholder-avatar.jpg" />
                    <AvatarFallback className="bg-black/40 text-blue-400 text-5xl font-black italic">
                      {user.name?.charAt(0).toUpperCase() || user.email.charAt(0).toUpperCase()}
                    </AvatarFallback>
                  </Avatar>
                  <Button size="icon" className="absolute bottom-0 right-0 h-12 w-12 rounded-2xl bg-white text-black hover:bg-slate-200 shadow-xl z-20 border-4 border-[#1a1b1e]">
                     <Camera className="w-5 h-5" />
                  </Button>
                </div>

                <div className="space-y-3">
                  <h2 className="text-3xl font-black text-white italic tracking-tighter leading-none">{user.name || "User"}</h2>
                  <p className="text-[10px] font-black text-blue-500 tracking-widest italic">{user.email}</p>
                </div>

                <div className="flex flex-wrap justify-center gap-3">
                  <Badge className="bg-blue-500/10 text-blue-400 border border-blue-500/20 px-4 py-1.5 rounded-full text-[8px] font-black tracking-widest italic">
                    {user.role.toLowerCase().replace("_", " ")}
                  </Badge>
                  <Badge variant="outline" className="border-emerald-500/20 text-emerald-400 bg-emerald-500/5 px-4 py-1.5 rounded-full text-[8px] font-black tracking-widest italic flex items-center gap-2">
                    <CheckCircle className="w-3 h-3" /> {t('profileVerified')}
                  </Badge>
                </div>

                <div className="pt-10 border-t border-white/5 space-y-6">
                  {[{
                  icon: Briefcase,
                  text: t('role'),
                  color: "text-blue-400"
                }, {
                  icon: MapPin,
                  text: t("client.src.new_york_usa"),
                  color: "text-purple-400"
                }, {
                  icon: Calendar,
                  text: t('joined', {
                    date: "DEC 2023"
                  }),
                  color: "text-slate-500"
                }].map((item, i) => <div key={i} className="flex items-center gap-4 text-[10px] font-black text-slate-400 italic tracking-widest">
                       <item.icon className={cn("w-4 h-4", item.color)} />
                       {item.text}
                    </div>)}
                </div>

                <Button variant="outline" className="w-full h-14 rounded-2xl border-white/10 bg-white/5 text-white hover:bg-white/10 font-black italic tracking-widest text-[10px] transition-all">
                  {t('changeAvatar')}
                </Button>
              </CardContent>
            </Card>
          </motion.div>

          {/* Config Matrix */}
          <motion.div initial={{
          opacity: 0,
          x: 20
        }} animate={{
          opacity: 1,
          x: 0
        }} className="lg:col-span-8">
            <Card className="bg-[#1a1b1e]/40 border-white/5 border-l border-t rounded-[48px] overflow-hidden backdrop-blur-3xl shadow-3xl h-full flex flex-col">
              <div className="p-12 border-b border-white/5 space-y-2">
                <h2 className="text-2xl font-black text-white italic tracking-tighter leading-none">{t('accountSettings')}</h2>
                <p className="text-[10px] font-black text-slate-500 tracking-widest italic">{t('accountDesc')}</p>
              </div>
              
              <CardContent className="p-0 flex-1">
                <Tabs defaultValue="personal" className="w-full h-full flex flex-col">
                  <div className="px-12 pt-8">
                    <TabsList className="w-full h-14 bg-black/40 border border-white/5 rounded-2xl p-1">
                      {[{
                      val: "personal",
                      label: t('personal'),
                      icon: User
                    }, {
                      val: "security",
                      label: t('security'),
                      icon: Shield
                    }, {
                      val: "notifications",
                      label: t('profileNotifications'),
                      icon: Bell
                    }].map(tab => <TabsTrigger key={tab.val} value={tab.val} className="flex-1 rounded-xl h-full data-[state=active]:bg-white/5 data-[state=active]:text-blue-400 text-[10px] font-black italic tracking-widest transition-all gap-2">
                          <tab.icon className="w-3.5 h-3.5" /> {tab.label}
                        </TabsTrigger>)}
                    </TabsList>
                  </div>

                  <div className="p-12 flex-1 relative overflow-hidden">
                    <TabsContent value="personal" className="mt-0 space-y-8 animate-in fade-in slide-in-from-bottom-4">
                      <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
                        <div className="space-y-3">
                          <Label className="text-[10px] font-black text-slate-500 tracking-widest italic ml-1">{t('firstName')}</Label>
                          <Input className="bg-black/40 border-white/5 rounded-2xl h-14 text-[11px] font-black italic tracking-widest text-white shadow-inner focus:border-blue-500/50 transition-all font-mono" defaultValue="JOHN" />
                        </div>
                        <div className="space-y-3">
                          <Label className="text-[10px] font-black text-slate-500 tracking-widest italic ml-1">{t('lastName')}</Label>
                          <Input className="bg-black/40 border-white/5 rounded-2xl h-14 text-[11px] font-black italic tracking-widest text-white shadow-inner focus:border-blue-500/50 transition-all font-mono" defaultValue="DOE" />
                        </div>
                      </div>
                      
                      <div className="space-y-3">
                        <Label className="text-[10px] font-black text-slate-500 tracking-widest italic ml-1">{t('profileEmail')}</Label>
                        <Input className="bg-black/40 border-white/5 rounded-2xl h-14 text-[11px] font-black italic tracking-widest text-white shadow-inner focus:border-blue-500/50 transition-all font-mono" type="email" defaultValue={user.email} />
                      </div>

                      <div className="space-y-3">
                        <Label className="text-[10px] font-black text-slate-500 tracking-widest italic ml-1">{t('phone')}</Label>
                        <Input className="bg-black/40 border-white/5 rounded-2xl h-14 text-[11px] font-black italic tracking-widest text-white shadow-inner focus:border-blue-500/50 transition-all font-mono" defaultValue="+1 (555) 123-4567" />
                      </div>

                      <div className="space-y-3">
                        <Label className="text-[10px] font-black text-slate-500 tracking-widest italic ml-1">{t('bio')}</Label>
                        <Textarea className="bg-black/40 border-white/5 rounded-[24px] min-h-[120px] text-[11px] font-black italic tracking-widest text-white shadow-inner focus:border-blue-500/50 transition-all font-mono leading-loose resize-none" placeholder={t('placeholderBio')} />
                      </div>

                      <div className="space-y-3">
                        <Label className="text-[10px] font-black text-slate-500 tracking-widest italic ml-1">{t('profileLocation')}</Label>
                        <Input className="bg-black/40 border-white/5 rounded-2xl h-14 text-[11px] font-black italic tracking-widest text-white shadow-inner focus:border-blue-500/50 transition-all font-mono" defaultValue="NEW YORK, USA" />
                      </div>

                      <Button onClick={handleSave} disabled={isLoading} className="w-full h-16 rounded-[24px] bg-white text-black hover:bg-slate-200 font-black italic tracking-widest text-[11px] shadow-xl transition-all group">
                        {isLoading ? <div className="flex items-center gap-3">
                              <div className="w-4 h-4 border-2 border-black/20 border-t-black rounded-full animate-spin" />
                              {t('saving')}
                           </div> : <div className="flex items-center gap-3">
                              <Save className="w-4 h-4 group-hover:scale-110 transition-transform" />
                              {t('save')}
                           </div>}
                      </Button>
                    </TabsContent>

                    <TabsContent value="security" className="mt-0 animate-in fade-in slide-in-from-bottom-4">
                      <SecuritySettings />
                    </TabsContent>

                    <TabsContent value="notifications" className="mt-0 space-y-6 animate-in fade-in slide-in-from-bottom-4">
                      {[{
                      label: t('emailNotif'),
                      desc: t('emailNotifDesc'),
                      icon: Bell
                    }, {
                      label: t('pushNotif'),
                      desc: t('pushNotifDesc'),
                      icon: Fingerprint
                    }, {
                      label: t('marketing'),
                      desc: t('marketingDesc'),
                      icon: Briefcase
                    }].map((item, i) => <div key={i} className="flex items-center justify-between p-8 rounded-[32px] bg-black/40 border border-white/5 hover:bg-white/5 transition-all group">
                          <div className="flex items-center gap-6">
                            <div className="h-14 w-14 rounded-2xl bg-white/5 border border-white/10 flex items-center justify-center text-slate-400 group-hover:text-white transition-colors">
                               <item.icon className="w-6 h-6" />
                            </div>
                            <div className="space-y-1">
                              <Label className="text-xs font-black text-white italic tracking-widest">{item.label}</Label>
                              <p className="text-[10px] font-black text-slate-500 tracking-wider italic">
                                {item.desc}
                              </p>
                            </div>
                          </div>
                          <Button variant="outline" size="sm" className="h-12 px-6 rounded-xl border-white/10 bg-white/5 text-slate-400 hover:text-white font-black italic text-[9px] tracking-widest">
                            {t('profileConfigure')}
                          </Button>
                        </div>)}
                    </TabsContent>
                  </div>
                </Tabs>
              </CardContent>
            </Card>
          </motion.div>
        </div>
      </div>
    </div>;
}