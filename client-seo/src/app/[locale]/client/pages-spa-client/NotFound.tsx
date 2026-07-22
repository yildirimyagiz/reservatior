"use client";

import { Button } from "@/components/ui/button";
import { AlertCircle, ArrowLeft } from "lucide-react";
import { useTranslation } from "react-i18next";
import { Link } from "@/lib/react-router-shim";
import { m } from "framer-motion";
export default function NotFound() {
  const {
    t
  } = useTranslation();
  const title = t("notFoundTitle", "Page Not Found");
  const subtitle = t("notFoundErrorCode", "Error Code: 404");
  const desc = t("notFoundDesc", "The page you are looking for might have been removed, had its name changed, or is temporarily unavailable. Please check the URL or return home.");
  const backText = t("notFoundBack", "Return to Home");
  return <div className="min-h-screen w-full flex items-center justify-center bg-background text-foreground overflow-hidden relative">
      {/* Background Decor */}
      <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[800px] h-[800px] bg-primary/5 rounded-full blur-[120px] pointer-events-none" />
      
      <m.div initial={{
      opacity: 0,
      y: 15
    }} animate={{
      opacity: 1,
      y: 0
    }} className="w-full max-w-lg mx-4 z-10">
        <div className="p-8 md:p-12 rounded-3xl bg-card border border-border dark:border-white/5 shadow-xl text-center space-y-6 relative overflow-hidden">
          <div className="absolute top-0 right-0 p-8 opacity-[0.03] pointer-events-none">
             <AlertCircle className="w-32 h-32" />
          </div>

          <div className="inline-flex h-16 w-16 items-center justify-center rounded-2xl bg-destructive/10 border border-destructive/20 text-destructive">
            <AlertCircle className="h-8 w-8" />
          </div>

          <div className="space-y-2">
            <h1 className="text-3xl font-bold tracking-tight text-foreground">{title}</h1>
            <p className="text-xs font-semibold text-muted-foreground tracking-widest">{subtitle}</p>
          </div>

          <p className="text-sm text-muted-foreground leading-relaxed px-4">
            {desc}
          </p>

          <Button asChild className="h-12 px-8 bg-primary hover:bg-primary/90 text-primary-foreground font-semibold text-xs tracking-wide rounded-xl shadow-md transition-all hover:scale-[1.02]">
            <Link to="/" className="flex items-center gap-2">
              <ArrowLeft className="w-4 h-4" />
              {backText}
            </Link>
          </Button>

          <div className="pt-4 flex justify-center items-center gap-4 border-t border-border dark:border-white/5">
             <div className="flex items-center gap-1.5">
                <div className="w-1.5 h-1.5 rounded-full bg-destructive" />
                <span className="text-[10px] font-semibold text-muted-foreground tracking-wider">{t("client.src.http_404")}</span>
             </div>
             <div className="flex items-center gap-1.5">
                <div className="w-1.5 h-1.5 rounded-full bg-slate-400" />
                <span className="text-[10px] font-semibold text-muted-foreground tracking-wider">{t("client.src.resourcenotfound")}</span>
             </div>
          </div>
        </div>
      </m.div>
    </div>;
}