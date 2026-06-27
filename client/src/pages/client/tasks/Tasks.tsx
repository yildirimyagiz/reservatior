import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription, DialogFooter } from "@/components/ui/dialog";
import { Textarea } from "@/components/ui/textarea";
import { Label } from "@/components/ui/label";
import { CheckSquare, Plus, Search, Calendar, Clock, Edit, Trash2, User as UserIcon, Home as HomeIcon, AlertCircle, CheckCircle, Zap, Activity, Layers, Cpu, ArrowUpRight, Shield, Target } from "lucide-react";
import { motion, AnimatePresence } from "framer-motion";
import { useToast } from "@/hooks/use-toast";
import { PageShell } from "@/pages/client/layout/PageShell";
import { cn } from "@/lib/utils";

// Mock data for premium feel
const MOCK_TASKS = [{
  id: "1",
  title: t("client.src.neural_grid_maintenance_sector"),
  description: t("client.src.scheduled_recalibration_of_propertywide"),
  status: "IN_PROGRESS",
  priority: "HIGH",
  assignedTo: "SUBJECT-X",
  property: "SUNSET NODE-4B",
  dueDate: "2024-04-20",
  riskRating: 0.85
}, {
  id: "2",
  title: t("client.src.security_audit_level_4"),
  description: t("client.src.full_spectral_analysis_of"),
  status: "OPEN",
  priority: "URGENT",
  assignedTo: "SYSTEM-ADMIN",
  property: "DOWNTOWN LOGIC LOFT",
  dueDate: "2024-04-18",
  riskRating: 0.92
}, {
  id: "3",
  title: t("client.src.thermal_cooling_sync"),
  description: t("client.src.optimizing_hvac_flow_across"),
  status: "DONE",
  priority: "MEDIUM",
  assignedTo: "CORE-TECH",
  property: "OCEAN VISTA TERMINAL",
  dueDate: "2024-04-15",
  riskRating: 0.45
}, {
  id: "4",
  title: t("client.src.biometric_update_v24"),
  description: t("client.src.uploading_new_identity_signatures"),
  status: "OPEN",
  priority: "LOW",
  assignedTo: "IDENTITY-NODE",
  property: "GLOBAL HUB",
  dueDate: "2024-04-25",
  riskRating: 0.12
}];
export default function Tasks() {
  const {
    t
  } = useTranslation();
  const [searchTerm, setSearchTerm] = useState("");
  const [filterStatus, setFilterStatus] = useState("all");
  const [createOpen, setCreateOpen] = useState(false);
  const [editOpen, setEditOpen] = useState(false);
  const [selectedTask, setSelectedTask] = useState<any>(null);
  const {
    toast
  } = useToast();
  const getStatusColor = (status: string) => {
    switch (status) {
      case "OPEN":
        return "bg-blue-500/10 text-blue-400 border-blue-500/20";
      case "IN_PROGRESS":
        return "bg-orange-500/10 text-orange-400 border-orange-500/20";
      case "DONE":
        return "bg-emerald-500/10 text-emerald-400 border-emerald-500/20 shadow-[0_0_15px_rgba(16,185,129,0.1)]";
      case "URGENT":
        return "bg-red-500/10 text-red-400 border-red-500/20 animate-pulse";
      default:
        return "bg-slate-500/10 text-slate-400 border-slate-500/20";
    }
  };
  const getPriorityColor = (priority: string) => {
    switch (priority) {
      case "LOW":
        return "text-emerald-400";
      case "MEDIUM":
        return "text-blue-400";
      case "HIGH":
        return "text-orange-400";
      case "URGENT":
        return "text-red-400";
      default:
        return "text-slate-400";
    }
  };
  const stats = [{
    label: t("client.src.active_cycles"),
    value: MOCK_TASKS.length
  }, {
    label: t("client.src.sync_completion"),
    value: "84.2%"
  }, {
    label: t("client.src.queue_delta"),
    value: "-12.4%",
    color: "text-emerald-400"
  }, {
    label: t("client.src.threat_stable"),
    value: "YES",
    color: "text-blue-500"
  }];
  return <PageShell title={t("client.src.protocol_queue")} description={t("client.src.neural_task_management_subsystem")} stats={stats} onSearchChange={setSearchTerm} searchValue={searchTerm}>
      <div className="space-y-12">
        {/* Tactical Controls */}
        <div className="flex flex-col lg:flex-row items-center justify-between gap-6 px-4">
           <div className="flex items-center gap-4 flex-1 w-full max-w-2xl relative group">
              <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-500 group-focus-within:text-blue-500 transition-colors" />
              <Input placeholder={t("client.src.searching_protocol_repository")} value={searchTerm} onChange={e => setSearchTerm(e.target.value)} className="bg-black/40 border-white/5 rounded-2xl pl-12 h-14 text-white focus:ring-blue-500/20 focus:border-blue-500/40 transition-all font-display italic border-l border-t" />
           </div>
           <div className="flex items-center gap-4 w-full lg:w-auto">
              <Select value={filterStatus} onValueChange={setFilterStatus}>
                <SelectTrigger className="h-14 w-48 bg-[#1a1b1e]/60 border-white/5 rounded-2xl text-[10px] font-black tracking-widest italic text-slate-400">
                   <SelectValue placeholder={t("client.src.status_sector")} />
                </SelectTrigger>
                <SelectContent className="bg-[#1a1b1e] border-white/10 font-display">
                   <SelectItem value="all" className="text-slate-400 font-bold italic">{t("client.src.all_sectors")}</SelectItem>
                   <SelectItem value="OPEN" className="text-slate-400 font-bold italic text-[9px]">{t("client.src.open")}</SelectItem>
                   <SelectItem value="IN_PROGRESS" className="text-slate-400 font-bold italic text-[9px]">{t("client.src.in_progress")}</SelectItem>
                   <SelectItem value="DONE" className="text-slate-400 font-bold italic text-[9px]">{t("client.src.completed")}</SelectItem>
                </SelectContent>
              </Select>
              <Button onClick={() => setCreateOpen(true)} className="h-14 px-8 rounded-2xl bg-blue-600 hover:bg-blue-500 text-white font-black text-[10px] italic tracking-widest shadow-xl shadow-blue-600/20 border-t border-white/10 shrink-0">
                 <Plus className="w-4 h-4 mr-2" />{t("client.src.add_protocol")}</Button>
           </div>
        </div>

        {/* Task Nodes Grid */}
        <div className="grid grid-cols-1 xl:grid-cols-2 gap-8 px-4">
           <AnimatePresence mode="popLayout">
              {MOCK_TASKS.map((task, idx) => <motion.div key={task.id} initial={{
            opacity: 0,
            x: -20
          }} animate={{
            opacity: 1,
            x: 0
          }} exit={{
            opacity: 0,
            scale: 0.95
          }} transition={{
            delay: idx * 0.05
          }} whileHover={{
            y: -5
          }} className={cn("p-8 rounded-[40px] bg-[#1a1b1e]/40 border border-white/5 backdrop-blur-3xl shadow-3xl group relative overflow-hidden flex flex-col justify-between border-l border-t transition-all", task.status === "DONE" && "opacity-60 grayscale-[0.5]")}>
                  <div className="absolute top-0 right-0 p-10 opacity-5 group-hover:opacity-10 transition-all pointer-events-none text-blue-500">
                     <Cpu className="w-32 h-32" />
                  </div>

                  <div className="space-y-6 relative z-10">
                     <div className="flex items-center justify-between">
                        <Badge className={cn("text-[9px] font-black  tracking-[0.2em] italic border-none py-1 px-4 rounded-full", getStatusColor(task.status))}>
                           {task.status.replace("_", " ")}
                        </Badge>
                        <div className="flex items-center gap-4">
                           <div className="text-right">
                              <p className="text-[9px] font-black text-slate-600 tracking-widest italic">{t("client.src.threat_index")}</p>
                              <p className={cn("text-xs font-black italic", getPriorityColor(task.priority))}>{(task.riskRating * 100).toFixed(0)} / 100</p>
                           </div>
                           <div className="h-10 w-10 rounded-xl bg-black/40 border border-white/5 flex items-center justify-center text-slate-400 group-hover:text-white transition-colors cursor-pointer">
                              <Edit className="w-4 h-4" onClick={() => {
                      setSelectedTask(task);
                      setEditOpen(true);
                    }} />
                           </div>
                        </div>
                     </div>

                     <div className="space-y-2">
                        <h3 className="text-2xl font-black text-white italic tracking-tighter leading-tight group-hover:text-blue-400 transition-colors">{task.title}</h3>
                        <p className="text-[11px] font-bold text-slate-500 tracking-widest leading-relaxed italic max-w-lg">{task.description}</p>
                     </div>

                     <div className="grid grid-cols-2 md:grid-cols-3 gap-6 pt-6 border-t border-white/5">
                        <div className="space-y-1">
                           <p className="text-[8px] font-black text-slate-600 tracking-widest italic flex items-center gap-1.5"><UserIcon className="w-2.5 h-2.5" />{t("client.src.assigned_identity")}</p>
                           <p className="text-[10px] font-black text-white italic tracking-tight">{task.assignedTo}</p>
                        </div>
                        <div className="space-y-1">
                           <p className="text-[8px] font-black text-slate-600 tracking-widest italic flex items-center gap-1.5"><HomeIcon className="w-2.5 h-2.5" />{t("client.src.neural_node")}</p>
                           <p className="text-[10px] font-black text-white italic tracking-tight">{task.property}</p>
                        </div>
                        <div className="space-y-1">
                           <p className="text-[8px] font-black text-slate-600 tracking-widest italic flex items-center gap-1.5"><Calendar className="w-2.5 h-2.5" />{t("client.src.deadline")}</p>
                           <p className="text-[10px] font-black text-white italic tracking-tight font-mono">{task.dueDate}</p>
                        </div>
                     </div>
                  </div>

                  <div className="mt-8 flex items-center justify-between">
                     <div className="flex items-center gap-2">
                        <div className="h-1.5 w-32 bg-white/5 rounded-full overflow-hidden">
                           <motion.div initial={{
                    width: 0
                  }} animate={{
                    width: `${task.riskRating * 100}%`
                  }} className={cn("h-full", task.riskRating > 0.7 ? "bg-red-500" : task.riskRating > 0.4 ? "bg-orange-500" : "bg-emerald-500")} style={{
                    boxShadow: `0 0 10px ${task.riskRating > 0.7 ? '#ef4444' : task.riskRating > 0.4 ? '#f97316' : '#10b981'}`
                  }} />
                        </div>
                        <span className="text-[8px] font-black text-slate-600 italic">{t("client.src.trust_level")}</span>
                     </div>
                     <Button variant="ghost" className="h-10 text-[9px] font-black text-blue-400 hover:text-white tracking-widest italic gap-2 group/btn">{t("client.src.execute_sync")}<ArrowUpRight className="w-3 h-3 group-hover/btn:translate-x-0.5 group-hover/btn:-translate-y-0.5 transition-transform" />
                     </Button>
                  </div>
                </motion.div>)}
           </AnimatePresence>
        </div>
      </div>

      {/* Modern Dialogs */}
      <Dialog open={createOpen} onOpenChange={setCreateOpen}>
        <DialogContent className="max-w-2xl bg-[#14151a] border border-white/10 rounded-[32px] shadow-3xl text-white font-display overflow-hidden">
          <div className="absolute top-0 left-0 w-full h-1 bg-linear-to-r from-blue-600 via-transparent to-transparent opacity-50"></div>
          <DialogHeader className="p-8">
            <DialogTitle className="text-3xl font-black italic tracking-tighter flex items-center gap-4">
               <div className="p-3 bg-blue-600 rounded-2xl shadow-xl shadow-blue-600/20">
                  <Shield className="w-6 h-6 text-white" />
               </div>{t("client.src.initialize_protocol")}</DialogTitle>
            <DialogDescription className="text-[10px] font-black text-slate-500 tracking-widest italic mt-4">{t("client.src.deploy_new_subsystem_maintenance")}</DialogDescription>
          </DialogHeader>
          
          <div className="p-8 pt-0 space-y-6">
             <div className="grid grid-cols-2 gap-6">
                <div className="space-y-2">
                   <Label className="text-[9px] font-black text-slate-500 italic tracking-widest">{t("client.src.protocol_identifier")}</Label>
                   <Input className="h-12 bg-black/40 border-white/5 rounded-xl text-white focus:ring-blue-500/20" placeholder={t("client.src.eg_neural_sync_alpha")} />
                </div>
                <div className="space-y-2">
                   <Label className="text-[9px] font-black text-slate-500 italic tracking-widest">{t("client.src.sector_assignment")}</Label>
                   <Select>
                      <SelectTrigger className="h-12 bg-black/40 border-white/5 rounded-xl text-white">
                         <SelectValue placeholder={t("client.src.select_hub")} />
                      </SelectTrigger>
                      <SelectContent className="bg-black border-white/10">
                         <SelectItem value="1">{t("client.src.hubalpha")}</SelectItem>
                         <SelectItem value="2">{t("client.src.hubbeta")}</SelectItem>
                      </SelectContent>
                   </Select>
                </div>
             </div>
             <div className="space-y-2">
                <Label className="text-[9px] font-black text-slate-500 italic tracking-widest">{t("client.src.subsystem_description")}</Label>
                <Textarea className="bg-black/40 border-white/5 rounded-xl text-white focus:ring-blue-500/20" rows={4} placeholder={t("client.src.enter_deployment_specs")} />
             </div>
          </div>

          <DialogFooter className="p-8 pt-0 flex gap-4">
            <Button variant="ghost" onClick={() => setCreateOpen(false)} className="h-12 rounded-xl text-[10px] font-black text-slate-500 hover:text-white transition-all italic">{t("client.src.abort_mission")}</Button>
            <Button className="h-12 px-8 rounded-xl bg-blue-600 hover:bg-blue-500 text-white font-black text-[10px] italic tracking-widest shadow-xl shadow-blue-600/20">{t("client.src.confirm_deployment")}</Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </PageShell>;
}