
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Lock, Unlock, Zap, Activity, BatteryMedium, DoorOpen } from "lucide-react";
import { Badge } from "@/components/ui/badge";
import { useTranslation } from "react-i18next";

export function SmartAccessWidget() {
  const { t } = useTranslation();
  const locks = [
    { name: "Upper East Villa #4", status: "LOCKED", battery: "84%", signal: "ONLINE" },
    { name: "SoHo Office 2", status: "UNLOCKED", battery: "12%", signal: "ONLINE" },
    { name: "Miami Beach #1", status: "LOCKED", battery: "100%", signal: "OFFLINE" }
  ];

  return (
    <Card className="border-white/5 bg-secondary/5 rounded-2xl overflow-hidden relative">
      <CardHeader className="pb-4">
        <CardTitle className="text-lg flex items-center gap-2">
          <DoorOpen className="h-4 w-4 text-emerald-400" />
          {t("widgetsSmartaccessTitle")}
        </CardTitle>
        <CardDescription>{t("widgetsSmartaccessDesc")}</CardDescription>
      </CardHeader>
      <CardContent className="space-y-4">
        {locks.map((lock, i) => (
          <div key={i} className="flex items-center gap-3 p-3 bg-secondary/20 rounded-xl border border-white/5 group hover:bg-secondary/30 transition-all cursor-pointer">
            <div className={`p-2 rounded-lg ${lock.status === "LOCKED" ? "bg-slate-800 text-white" : "bg-emerald-500/10 text-emerald-500"}`}>
              {lock.status === "LOCKED" ? <Lock className="w-4 h-4" /> : <Unlock className="w-4 h-4 animate-bounce" />}
            </div>
            <div className="flex-1">
              <p className="text-sm font-bold">{lock.name}</p>
              <div className="flex items-center gap-2 text-[10px] text-slate-500">
                <span className="flex items-center gap-1 font-bold">
                  <BatteryMedium className={`w-3 h-3 ${lock.battery === "12%" ? "text-red-500 animate-pulse" : "text-emerald-500"}`} /> {lock.battery}
                </span>
                <span className="flex items-center gap-1 font-bold">
                  <Activity className={`w-3 h-3 ${lock.signal === "ONLINE" ? "text-blue-500" : "text-slate-700"}`} /> {lock.signal === "ONLINE" ? t("online") : t("offline")}
                </span>
              </div>
            </div>
            <Badge variant="outline" className={`text-[10px] uppercase font-bold ${lock.status === "LOCKED" ? "text-slate-400 border-slate-700" : "text-emerald-400 border-emerald-800"}`}>
              {lock.status === "LOCKED" ? t("locked") : t("unlocked")}
            </Badge>
          </div>
        ))}

        <div className="pt-2 border-t border-white/5 mt-4">
          <h4 className="text-[11px] font-bold text-slate-500 uppercase tracking-widest mb-3 flex items-center gap-2">
            <Zap className="p-0.5 w-3 h-3 text-amber-500" /> {t("recentEntries")}
          </h4>
          <div className="space-y-2">
            {[
              { user: "Guest PIN: 4891", room: "Upper East", time: "12:14" },
              { user: "Maintenance Team", room: "SoHo", time: "09:42" }
            ].map((log, i) => (
              <div key={i} className="flex justify-between items-center text-[11px] font-medium text-slate-400 border-l-2 border-blue-500 pl-3 ml-1 py-1">
                <span>{log.user} ({log.room})</span>
                <span className="text-slate-600 font-mono italic">{log.time}</span>
              </div>
            ))}
          </div>
        </div>
      </CardContent>
    </Card>
  );
}
