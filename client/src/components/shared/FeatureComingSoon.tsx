import { useTranslation } from "react-i18next";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Rocket, ArrowLeft, Clock, Sparkles, Zap, Lock } from "lucide-react";
import { useNavigate } from "react-router-dom";
interface FeatureComingSoonProps {
  title: string;
  description: string;
  icon?: React.ElementType;
}
export default function FeatureComingSoon({
  title,
  description,
  icon: Icon = Rocket
}: FeatureComingSoonProps) {
  const {
    t
  } = useTranslation();
  const navigate = useNavigate();
  return <div className="flex flex-col items-center justify-center min-h-[80vh] p-8 text-center space-y-8 animate-in fade-in zoom-in duration-500">
      <div className="relative">
        <div className="absolute -inset-4 bg-blue-600/20 rounded-full blur-3xl animate-pulse" />
        <div className="relative p-6 bg-slate-900 rounded-3xl border border-slate-800 shadow-2xl">
          <Icon className="w-16 h-16 text-blue-500" />
        </div>
        <div className="absolute -top-2 -right-2">
          <Badge className="bg-amber-500 text-amber-950 border-none font-black text-[10px] px-3 py-1 shadow-lg shadow-amber-500/20">{t("client.src.coming_soon")}</Badge>
        </div>
      </div>

      <div className="max-w-md space-y-4">
        <h1 className="text-4xl font-black tracking-tight text-slate-100">{title}</h1>
        <p className="text-lg text-slate-400 font-medium leading-relaxed">
          {description}
        </p>
      </div>

      <div className="grid grid-cols-1 sm:grid-cols-2 gap-4 w-full max-w-sm">
        <div className="p-4 bg-slate-900/50 border border-slate-800 rounded-2xl flex items-center gap-3">
          <div className="p-2 bg-blue-600/10 rounded-lg">
            <Clock className="w-5 h-5 text-blue-400" />
          </div>
          <div className="text-left">
            <p className="text-[10px] font-bold text-slate-500 uppercase">{t("client.src.eta")}</p>
            <p className="text-sm font-bold text-slate-200">{t("client.src.q2_2026")}</p>
          </div>
        </div>
        <div className="p-4 bg-slate-900/50 border border-slate-800 rounded-2xl flex items-center gap-3">
          <div className="p-2 bg-emerald-600/10 rounded-lg">
            <Lock className="w-5 h-5 text-emerald-400" />
          </div>
          <div className="text-left">
            <p className="text-[10px] font-bold text-slate-500 uppercase">{t("client.src.status")}</p>
            <p className="text-sm font-bold text-slate-200">{t("client.src.in_dev")}</p>
          </div>
        </div>
      </div>

      <div className="flex flex-col sm:flex-row gap-4 pt-4">
        <Button variant="outline" onClick={() => navigate(-1)} className="h-12 px-8 rounded-xl bg-slate-900 border-slate-800 hover:bg-slate-800 text-slate-300 gap-2">
          <ArrowLeft className="w-4 h-4" />{t("client.src.go_back")}</Button>
        <Button className="h-12 px-8 rounded-xl bg-blue-600 hover:bg-blue-700 shadow-lg shadow-blue-600/20 gap-2 font-bold">
          <Sparkles className="w-4 h-4" />{t("client.src.get_beta_access")}</Button>
      </div>

      <div className="pt-12 flex items-center gap-2 text-slate-600">
        <Zap className="w-4 h-4" />
        <span className="text-[10px] font-bold uppercase tracking-[0.2em]">{t("client.src.edge_release_v420beta")}</span>
      </div>
    </div>;
}