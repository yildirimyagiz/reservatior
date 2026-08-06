import Image from "next/image";
import { t } from "i18next";
import { useState, useEffect } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { ShieldCheck, ShieldAlert, Monitor, LogOut, Loader2, Fingerprint, Activity, Clock, Shield, X, Zap } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { securityApi } from "@/lib/api/security";
import { useTranslation } from "react-i18next";
import { m, AnimatePresence } from "framer-motion";
import { cn } from "@/lib/utils";
interface Session {
  id: string;
  deviceId: string | null;
  userAgent: string | null;
  ipAddress: string | null;
  lastUsedAt: string;
  isCurrent: boolean;
}
export function SecuritySettings() {
  const {
    t
  } = useTranslation();
  const [is2FAEnabled, setIs2FAEnabled] = useState(false);
  const [show2FASetup, setShow2FASetup] = useState(false);
  const [qrCode, setQrCode] = useState("");
  const [secret, setSecret] = useState("");
  const [token, setToken] = useState("");
  const [sessions, setSessions] = useState<Session[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const {
    toast
  } = useToast();
  useEffect(() => {
    fetchSecurityStatus();
    fetchSessions();
  }, []);
  const fetchSecurityStatus = async () => {
    // setIs2FAEnabled(user?.twoFactorEnabled);
  };
  const fetchSessions = async () => {
    try {
      const res = await securityApi.getSessions();
      setSessions(((res as any)?.data || []).map((s: any) => ({
        id: s.id,
        deviceId: s.deviceId,
        userAgent: s.userAgent,
        ipAddress: s.ipAddress,
        lastUsedAt: s.updatedAt || s.createdAt,
        isCurrent: s.tokenHash === localStorage.getItem("auth_token")?.split(".").pop()
      })));
    } catch (error) {
      console.error("Failed to fetch sessions", error);
    }
  };
  const handleEnable2FA = async () => {
    setIsLoading(true);
    try {
      const res = await securityApi.setup2FA();
      setQrCode((res as any).qrCodeUrl);
      setSecret((res as any).secret);
      setShow2FASetup(true);
    } catch (error) {
      toast({
        title: t("common.error"),
        description: t('errorSetup'),
        variant: "destructive"
      });
    } finally {
      setIsLoading(false);
    }
  };
  const verifyAndEnable = async () => {
    setIsLoading(true);
    try {
      await securityApi.verify2FA(token, secret);
      setIs2FAEnabled(true);
      setShow2FASetup(false);
      toast({
        title: t('success2FA')
      });
    } catch (error) {
      toast({
        title: t("common.error"),
        description: t('error2FA'),
        variant: "destructive"
      });
    } finally {
      setIsLoading(false);
    }
  };
  const revokeSession = async (id: string) => {
    try {
      await securityApi.revokeSession(id);
      setSessions(sessions.filter(s => s.id !== id));
      toast({
        title: t('successTerminated')
      });
    } catch (error) {
      toast({
        title: t("common.error"),
        description: t("client.src.could_not_terminate_session"),
        variant: "destructive"
      });
    }
  };
  return <div className="space-y-12">
      {/* 2FA Matrix Card */}
      <Card className="bg-black/40 border-white/5 border-l border-t rounded-[32px] overflow-hidden group hover:bg-white/5 transition-all">
        <div className="p-10 space-y-8 relative overflow-hidden">
          <div className="flex items-start justify-between relative z-10">
            <div className="flex items-center gap-6">
               <div className="h-16 w-16 rounded-2xl bg-black/40 border border-white/5 flex items-center justify-center relative overflow-hidden">
                  <div className={cn("absolute inset-0 opacity-20", is2FAEnabled ? "bg-blue-500" : "bg-amber-500")} />
                  {is2FAEnabled ? <ShieldCheck className="w-8 h-8 text-blue-500 relative z-10" /> : <ShieldAlert className="w-8 h-8 text-amber-500 relative z-10" />}
               </div>
               <div className="space-y-2">
                  <h3 className="text-xl font-black text-white italic tracking-tighter uppercase leading-none">{t('twoFactor')}</h3>
                  <p className="text-[10px] font-black text-slate-500 uppercase tracking-widest italic">{t('twoFactorDesc')}</p>
               </div>
            </div>
            <Badge className={cn("px-4 py-1.5 rounded-full text-[9px] font-black uppercase tracking-widest italic border", is2FAEnabled ? "bg-blue-500/10 text-blue-400 border-blue-500/20" : "bg-amber-500/10 text-amber-400 border-amber-500/20")}>
               {is2FAEnabled ? "ENABLED" : "DISABLED"}
            </Badge>
          </div>

          {!is2FAEnabled && !show2FASetup && <Button onClick={handleEnable2FA} disabled={isLoading} className="h-14 px-10 rounded-2xl bg-blue-600 hover:bg-blue-500 text-white font-black uppercase italic tracking-widest text-[10px] shadow-xl shadow-blue-600/20 group/btn">
              {isLoading ? <Loader2 className="mr-3 h-4 w-4 animate-spin" /> : <Zap className="mr-3 h-4 w-4 group-hover:scale-110 transition-transform" />}
              {t('startSetup')}
            </Button>}

          <AnimatePresence>
            {show2FASetup && <m.div initial={{
            opacity: 0,
            height: 0
          }} animate={{
            opacity: 1,
            height: "auto"
          }} exit={{
            opacity: 0,
            height: 0
          }} className="space-y-8 pt-8 border-t border-white/5">
                <div className="grid grid-cols-1 md:grid-cols-2 gap-10 items-center">
                   <div className="bg-white p-6 rounded-[32px] inline-block shadow-2xl relative group/qr overflow-hidden">
                      <div className="absolute inset-0 bg-blue-600/10 opacity-0 group-hover:opacity-100 transition-opacity" />
                       <Image src={qrCode} alt={t("client.src.qr_code")} width={224} height={224} loading="lazy" sizes="224px" className="mx-auto relative z-10" />
                   </div>
                   <div className="space-y-6">
                      <div className="space-y-2">
                        <p className="text-xs font-black text-white italic tracking-wider uppercase">{t('scanCode')}</p>
                        <div className="p-4 bg-white/5 border border-white/5 rounded-2xl flex items-center justify-between group/code cursor-copy transition-all hover:bg-white/10 overflow-hidden">
                           <code className="text-[10px] font-mono text-blue-400 font-black">{secret}</code>
                           <Badge variant="outline" className="text-[8px] font-black opacity-40 group-hover:opacity-100">{t("client.src.click_to_copy")}</Badge>
                        </div>
                      </div>
                      
                      <div className="space-y-4">
                        <div className="flex gap-4">
                          <Input placeholder={t("client.src.codex")} value={token} onChange={e => setToken(e.target.value)} maxLength={6} className="bg-black/40 border-white/5 rounded-2xl h-14 text-center text-xl font-black italic tracking-tighter text-white shadow-inner focus:border-blue-500/50 transition-all font-mono" />
                          <Button onClick={verifyAndEnable} disabled={isLoading || token.length !== 6} className="h-14 px-8 rounded-2xl bg-blue-600 hover:bg-blue-500 text-white font-black uppercase italic tracking-widest text-[10px] shadow-xl group/verify">
                            <Shield className="w-4 h-4 mr-2 group-hover:rotate-12 transition-transform" />
                            {t('verify')}
                          </Button>
                        </div>
                        <Button variant="ghost" onClick={() => setShow2FASetup(false)} className="w-full h-12 text-slate-500 hover:text-white text-[9px] font-black uppercase italic tracking-[0.3em] font-mono">
                          {t('profileCancel')}
                        </Button>
                      </div>
                   </div>
                </div>
              </m.div>}
          </AnimatePresence>

          {is2FAEnabled && <Button variant="ghost" className="h-12 text-red-500 hover:bg-red-500/10 hover:text-red-400 text-[10px] font-black uppercase italic tracking-widest gap-2">
              <LogOut className="w-4 h-4" /> {t('disable2FA')}
            </Button>}
        </div>
      </Card>

      {/* Sessions Terminal Card */}
      <Card className="bg-black/40 border-white/5 border-l border-t rounded-[32px] overflow-hidden group hover:bg-white/5 transition-all">
        <div className="p-10 space-y-8">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-6">
               <div className="h-16 w-16 rounded-2xl bg-black/40 border border-white/5 flex items-center justify-center">
                  <Monitor className="w-8 h-8 text-blue-500" />
               </div>
               <div className="space-y-2">
                  <h3 className="text-xl font-black text-white italic tracking-tighter uppercase leading-none">{t('profileActivesessions')}</h3>
                  <p className="text-[10px] font-black text-slate-500 uppercase tracking-widest italic">{t('sessionsDesc')}</p>
               </div>
            </div>
          </div>

          <div className="space-y-4">
            {sessions.map((session, i) => <m.div key={session.id} initial={{
            opacity: 0,
            scale: 0.98
          }} animate={{
            opacity: 1,
            scale: 1
          }} transition={{
            delay: i * 0.05
          }} className="flex items-center justify-between p-6 rounded-[24px] bg-black/40 border border-white/5 hover:bg-white/5 transition-all group/session hover:border-blue-500/20">
                <div className="flex items-center gap-6">
                  <div className="relative">
                    <div className={cn("absolute inset-0 blur-lg opacity-20 transition-all", session.isCurrent ? "bg-blue-500" : "bg-blue-500")} />
                    <div className="h-14 w-14 rounded-2xl bg-black/40 border border-white/5 flex items-center justify-center relative z-10 text-slate-400 group-hover/session:text-white transition-colors">
                      <Monitor className="w-6 h-6" />
                    </div>
                  </div>
                  <div className="space-y-1.5">
                    <div className="flex items-center gap-3">
                      <span className="text-xs font-black text-white italic tracking-widest uppercase">{session.deviceId || t('unknownDevice')}</span>
                      {session.isCurrent && <Badge className="bg-blue-500/10 text-blue-400 border border-blue-500/20 text-[8px] font-black uppercase italic">
                           {t('currentDevice')}
                        </Badge>}
                    </div>
                    <div className="flex items-center gap-4 text-[9px] font-black text-slate-600 uppercase tracking-widest italic">
                       <span className="flex items-center gap-1.5"><Activity className="w-3 h-3 text-blue-500" /> {session.ipAddress}</span>
                       <span className="h-1 w-1 rounded-full bg-slate-800" />
                       <span className="flex items-center gap-1.5"><Clock className="w-3 h-3 text-slate-500" /> {t('lastSeen', {
                      date: new Date(session.lastUsedAt).toLocaleDateString()
                    })}</span>
                    </div>
                  </div>
                </div>
                {!session.isCurrent && <Button variant="ghost" size="icon" aria-label={t("common.close")} className="h-12 w-12 rounded-xl bg-red-500/5 text-red-500 hover:text-red-400 hover:bg-red-500/10 transition-all border border-red-500/10 opacity-0 group-hover/session:opacity-100" onClick={() => revokeSession(session.id)}>
                    <X className="w-5 h-5" />
                  </Button>}
              </m.div>)}
          </div>
        </div>
      </Card>
    </div>;
}