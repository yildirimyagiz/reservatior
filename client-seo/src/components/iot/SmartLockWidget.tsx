import { useTranslation } from "react-i18next";
import { useState } from 'react';
import { Card, CardHeader, CardTitle, CardDescription, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Lock, Unlock, Battery, Activity, Wifi, KeyRound, History, AlertTriangle, RefreshCw } from "lucide-react";
import { Progress } from "@/components/ui/progress";
export function SmartLockWidget() {
  const {
    t
  } = useTranslation();
  const [isLocked, setIsLocked] = useState(true);
  const [isSyncing, setIsSyncing] = useState(false);
  const toggleLock = () => {
    setIsSyncing(true);
    setTimeout(() => {
      setIsLocked(!isLocked);
      setIsSyncing(false);
    }, 1500);
  };
  const logs = [{
    id: 1,
    event: 'Unlocked',
    method: 'PIN Code',
    actor: 'John Smith (Guest)',
    time: '2 mins ago',
    status: 'success'
  }, {
    id: 2,
    event: 'Locked',
    method: 'Auto-Lock',
    actor: 'System',
    time: '1 hour ago',
    status: 'success'
  }, {
    id: 3,
    event: 'Tamper Alert',
    method: 'Manual Force',
    actor: 'Unknown',
    time: '3 hours ago',
    status: 'warning'
  }];
  return <Card className="border-none shadow-2xl bg-white overflow-hidden ring-1 ring-slate-200">
      <CardHeader className="bg-slate-900 text-white pb-6">
        <div className="flex items-center justify-between">
          <div className="flex items-center gap-3">
            <div className={`p-2 rounded-xl ${isLocked ? 'bg-red-500/20' : 'bg-blue-500/20'}`}>
              <Lock className={`w-5 h-5 ${isLocked ? 'text-red-400' : 'text-blue-400'}`} />
            </div>
            <div>
              <CardTitle className="text-lg font-black tracking-tight">{t("client.src.main_entrance_smartlock")}</CardTitle>
              <CardDescription className="text-xs text-slate-400 flex items-center gap-1">
                <Wifi className="w-3 h-3 text-blue-400" />{t("client.src.live_connected_to_cloud")}</CardDescription>
            </div>
          </div>
          <Badge variant="outline" className="bg-white/5 border-white/20 text-white font-bold text-[10px]">{t("client.src.zillowready")}</Badge>
        </div>
      </CardHeader>

      <CardContent className="p-6 space-y-6">
        <div className="flex items-center justify-between p-4 rounded-2xl bg-slate-50 border border-slate-100">
          <div className="space-y-1">
            <p className="text-[10px] font-black text-slate-500 uppercase tracking-widest">{t("client.src.battery_health")}</p>
            <div className="flex items-center gap-2">
              <Battery className="w-4 h-4 text-blue-500" />
              <span className="text-xl font-black text-slate-900">82%</span>
            </div>
          </div>
          <div className="w-32">
            <Progress value={82} className="h-1.5 bg-slate-200" />
          </div>
        </div>

        <div className="flex flex-col gap-3">
          <Button onClick={toggleLock} disabled={isSyncing} variant={isLocked ? "default" : "secondary"} className={`h-16 rounded-2xl font-black text-lg shadow-xl transition-all active:scale-95 ${isLocked ? 'bg-slate-900 border-none' : 'bg-blue-500 text-white hover:bg-blue-600 border-none'}`}>
            {isSyncing ? <RefreshCw className="w-6 h-6 animate-spin mr-2" /> : isLocked ? <Unlock className="w-6 h-6 mr-2" /> : <Lock className="w-6 h-6 mr-2" />}
            {isSyncing ? 'SYNCING...' : isLocked ? 'REMOTE UNLOCK' : 'LOCK COMMAND'}
          </Button>
          
          <div className="grid grid-cols-2 gap-3">
            <Button variant="outline" className="h-12 rounded-xl text-xs font-bold border-slate-200 hover:bg-slate-50 group">
              <KeyRound className="w-4 h-4 mr-2 text-indigo-500 group-hover:scale-110 transition-transform" />{t("client.src.generate_pin")}</Button>
            <Button variant="outline" className="h-12 rounded-xl text-xs font-bold border-slate-200 hover:bg-slate-50 group">
              <Activity className="w-4 h-4 mr-2 text-rose-500 group-hover:scale-110 transition-transform" />{t("client.src.self_tour_mode")}</Button>
          </div>
        </div>

        <div className="space-y-4 pt-2">
          <div className="flex items-center justify-between">
            <h4 className="text-[11px] font-black text-slate-900 uppercase tracking-widest flex items-center gap-2">
              <History className="w-3 h-3 text-slate-400" />{t("client.src.live_access_data")}</h4>
            <span className="text-[10px] text-indigo-600 font-bold hover:underline cursor-pointer">{t("client.src.full_audit_log")}</span>
          </div>
          
          <div className="space-y-2">
            {logs.map(log => <div key={log.id} className="flex items-start justify-between p-3 rounded-xl hover:bg-slate-50 transition-colors border border-transparent hover:border-slate-100">
                <div className="flex gap-3">
                  <div className={`p-2 rounded-lg ${log.status === 'warning' ? 'bg-rose-50 text-rose-600' : 'bg-slate-100 text-slate-600'}`}>
                    {log.status === 'warning' ? <AlertTriangle className="w-3.5 h-3.5" /> : <Activity className="w-3.5 h-3.5" />}
                  </div>
                  <div>
                    <p className="text-xs font-black text-slate-900 leading-none mb-1">{log.event}</p>
                    <p className="text-[10px] text-slate-500 font-medium">{t("client.src.via")}{log.method} • {log.actor}</p>
                  </div>
                </div>
                <span className="text-[9px] font-bold text-slate-400 uppercase">{log.time}</span>
              </div>)}
          </div>
        </div>

        <div className="mt-4 p-4 rounded-xl bg-indigo-50 border border-indigo-100">
           <div className="flex items-center gap-3">
              <div className="p-2 bg-indigo-600 rounded-lg text-white">
                 <RefreshCw className="w-4 h-4" />
              </div>
              <div>
                 <p className="text-[10px] font-black text-indigo-900 uppercase">{t("client.src.selftour_automation")}</p>
                 <p className="text-[9px] text-indigo-700 font-medium">{t("client.src.zillow_compatible_automatic_access")}</p>
              </div>
           </div>
        </div>
      </CardContent>
    </Card>;
}