import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { ShieldX, Home, ArrowLeft, LogOut, Lock, Fingerprint } from "lucide-react";
import { useNavigate } from "react-router-dom";
import { useAuth } from "@/lib/auth/hooks";
import { useTranslation } from "react-i18next";
import { motion } from "framer-motion";

export default function Unauthorized() {
  const navigate = useNavigate();
  const { user, logout } = useAuth();
  const { t } = useTranslation();

  const handleGoHome = () => {
    navigate("/");
  };

  const handleGoBack = () => {
    navigate(-1);
  };

  const handleLogout = async () => {
    await logout();
    navigate("/login");
  };

  return (
    <div className="min-h-screen flex items-center justify-center bg-[#14151a] p-8 relative overflow-hidden">
      {/* Background Cybernetic Elements */}
      <div className="absolute inset-0 pointer-events-none">
        <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[800px] h-[800px] bg-red-600/5 blur-[120px] rounded-full animate-pulse-slow"></div>
        {/* Background HUD Layer */}
        <div className="absolute inset-0 pointer-events-none opacity-[0.03] bg-[radial-gradient(#fff_1px,transparent_1px)] bg-size-[40px_40px] z-0" />
      </div>

      <motion.div
        initial={{ opacity: 0, scale: 0.9 }}
        animate={{ opacity: 1, scale: 1 }}
        transition={{ duration: 0.5, ease: "easeOut" }}
        className="w-full max-w-xl relative"
      >
        <Card className="bg-[#1a1b1e]/40 border-white/5 border-l border-t rounded-[48px] overflow-hidden backdrop-blur-3xl shadow-3xl">
          <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-red-600 via-transparent to-transparent opacity-50"></div>
          
          <CardContent className="p-12 space-y-12">
            <div className="flex flex-col items-center gap-8">
              <div className="relative group">
                <div className="absolute inset-0 bg-red-600/20 blur-2xl group-hover:bg-red-600/40 transition-all rounded-full animate-pulse"></div>
                <div className="relative h-24 w-24 rounded-3xl bg-black/40 border border-red-500/30 flex items-center justify-center text-red-500 shadow-2xl overflow-hidden">
                   <Lock className="w-10 h-10" />
                   <div className="absolute bottom-0 left-0 w-full h-1 bg-red-500/50"></div>
                </div>
              </div>

              <div className="text-center space-y-3">
                <h1 className="text-5xl font-black text-white italic tracking-tighter leading-none">
                  {t("unauthorizedTitle")}
                </h1>
                <p className="text-xs font-black text-red-500/80 tracking-[0.3em] italic">
                  {t("unauthorizedSubtitle")}
                </p>
              </div>

              <div className="w-full p-8 rounded-3xl bg-black/40 border border-white/5 relative overflow-hidden group">
                <div className="absolute top-0 right-0 p-6 opacity-5 text-red-500 rotate-12 group-hover:rotate-0 transition-transform">
                  <ShieldX className="w-20 h-20" />
                </div>
                <p className="text-sm font-bold text-slate-400 italic leading-loose text-center relative z-10">
                  {t("unauthorizedDesc")}
                </p>
                
                {user && (
                  <div className="mt-6 pt-6 border-t border-white/5 flex flex-col items-center gap-2">
                    <p className="text-[10px] font-black text-slate-600 tracking-widest italic">
                      {t("loggedInAs", { email: user.email })}
                    </p>
                  </div>
                )}
              </div>
            </div>

            <div className="grid grid-cols-2 gap-4">
              <Button 
                onClick={handleGoHome} 
                className="h-16 rounded-[24px] bg-white text-black hover:bg-slate-200 font-black italic tracking-widest text-xs shadow-xl transition-all group"
              >
                <Home className="w-4 h-4 mr-3 group-hover:scale-110 transition-transform" />
                {t("goHome")}
              </Button>
              
              <Button 
                onClick={handleGoBack} 
                variant="outline" 
                className="h-16 rounded-[24px] border-white/10 bg-white/5 text-white hover:bg-white/10 font-black italic tracking-widest text-xs transition-all group"
              >
                <ArrowLeft className="w-4 h-4 mr-3 group-hover:-translate-x-1 transition-transform" />
                {t("goBack")}
              </Button>
              
              {user && (
                <Button 
                  onClick={handleLogout} 
                  variant="ghost" 
                  className="col-span-2 h-16 rounded-[24px] border border-red-500/20 bg-red-500/5 text-red-400 hover:bg-red-500/10 font-black italic tracking-widest text-xs transition-all group"
                >
                  <LogOut className="w-4 h-4 mr-3 group-hover:translate-x-1 transition-transform" />
                  {t("logout")}
                </Button>
              )}
            </div>

            <div className="text-center pt-8 border-t border-white/5">
              <p className="text-[9px] font-black text-slate-600 tracking-widest italic flex items-center justify-center gap-3">
                <Fingerprint className="w-3 h-3" />
                {t("contactAdmin")}
              </p>
            </div>
          </CardContent>
        </Card>
      </motion.div>
    </div>
  );
}
