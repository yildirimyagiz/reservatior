import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { PageShell } from "@/pages-spa/client/layout/PageShell";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Card, CardContent } from "@/components/ui/card";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription, DialogFooter } from "@/components/ui/dialog";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { useToast } from "@/hooks/use-toast";
import { Calendar, Clock, CheckCircle, XCircle, AlertCircle, MoreHorizontal, Edit3, Trash2, Plus, Search, Paperclip, MessageSquare, Flag, Target, Zap, Activity, Shield, Cpu, ChevronRight, ArrowUpRight, Layers, Circle, RefreshCw } from "lucide-react";
import { motion, AnimatePresence } from "framer-motion";
import { cn } from "@/lib/utils";
interface Task {
  id: string;
  title: string;
  description?: string;
  status: "TODO" | "IN_PROGRESS" | "REVIEW" | "COMPLETED" | "CANCELLED";
  priority: "LOW" | "MEDIUM" | "HIGH" | "URGENT";
  assignedToUserId?: string;
  propertyId?: string;
  dueAt?: string;
  estimatedHours?: number;
  actualHours?: number;
  tags?: string[];
  assignedUser?: {
    id: string;
    name: string;
    avatar?: string;
  };
  property?: {
    name: string;
    addressLine1: string;
  };
}
const STATUS_CONFIG: Record<string, {
  label: string;
  color: string;
  indicator: string;
}> = {
  TODO: {
    label: t("client.src.pendingqueue"),
    color: "text-slate-400 bg-slate-500/10 border-white/5",
    indicator: "bg-slate-500"
  },
  IN_PROGRESS: {
    label: t("client.src.activeexecution"),
    color: "text-blue-400 bg-blue-500/10 border-blue-500/20",
    indicator: "bg-blue-500"
  },
  REVIEW: {
    label: t("client.src.neuralvalidation"),
    color: "text-yellow-400 bg-yellow-500/10 border-yellow-500/20",
    indicator: "bg-yellow-500"
  },
  COMPLETED: {
    label: t("client.src.materialized"),
    color: "text-emerald-400 bg-emerald-500/10 border-emerald-500/20",
    indicator: "bg-emerald-500"
  },
  CANCELLED: {
    label: t("client.src.terminated"),
    color: "text-red-400 bg-red-500/10 border-red-500/20",
    indicator: "bg-red-500"
  }
};
const PRIORITY_CONFIG: Record<string, {
  label: string;
  color: string;
  icon: any;
}> = {
  LOW: {
    label: t("client.src.lowimpact"),
    color: "text-slate-500",
    icon: Circle
  },
  MEDIUM: {
    label: t("client.src.standardlogic"),
    color: "text-blue-500",
    icon: Target
  },
  HIGH: {
    label: t("client.src.highpriority"),
    color: "text-orange-500",
    icon: AlertCircle
  },
  URGENT: {
    label: t("client.src.criticalsignal"),
    color: "text-red-500",
    icon: Zap
  }
};
const MOCK_TASKS: Task[] = [{
  id: "1",
  title: t("client.src.prepare_property_photos_for"),
  description: t("client.src.take_professional_photos_of"),
  status: "IN_PROGRESS",
  priority: "HIGH",
  assignedToUserId: "user-1",
  dueAt: "2024-04-12",
  estimatedHours: 4,
  actualHours: 2,
  tags: ["photography", "listing"],
  assignedUser: {
    id: "user-1",
    name: "Sarah Johnson",
    avatar: "/avatars/sarah.jpg"
  },
  property: {
    name: "Luxury Downtown Apartment",
    addressLine1: "123 Main St"
  }
}, {
  id: "2",
  title: t("client.src.schedule_property_viewing_for"),
  description: t("client.src.coordinate_with_client_and"),
  status: "TODO",
  priority: "MEDIUM",
  assignedToUserId: "user-2",
  dueAt: "2024-04-15",
  estimatedHours: 1,
  tags: ["viewing", "client"],
  assignedUser: {
    id: "user-2",
    name: "Mike Wilson"
  },
  property: {
    name: "Cozy Garden View Apartment",
    addressLine1: "456 Oak Ave"
  }
}];
export default function TaskManagement() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const [tasks, setTasks] = useState<Task[]>(MOCK_TASKS);
  const [search, setSearch] = useState("");
  const [filterStatus, setFilterStatus] = useState("all");
  const [filterPriority, setFilterPriority] = useState("all");
  const [createOpen, setCreateOpen] = useState(false);
  const [editOpen, setEditOpen] = useState(false);
  const [form, setForm] = useState<any>({
    title: "",
    description: "",
    status: "TODO",
    priority: "MEDIUM"
  });
  const filteredTasks = tasks.filter(task => {
    const matchesSearch = task.title.toLowerCase().includes(search.toLowerCase());
    const matchesStatus = filterStatus === "all" || task.status === filterStatus;
    const matchesPriority = filterPriority === "all" || task.priority === filterPriority;
    return matchesSearch && matchesStatus && matchesPriority;
  });
  const stats = [{
    label: t("client.src.totalnodes"),
    value: tasks.length,
    icon: Layers
  }, {
    label: t("client.src.inexecution"),
    value: tasks.filter(t => t.status === "IN_PROGRESS").length,
    icon: Activity
  }, {
    label: t("client.src.validation"),
    value: tasks.filter(t => t.status === "REVIEW").length,
    icon: Shield
  }, {
    label: t("client.src.critical"),
    value: tasks.filter(t => t.priority === "URGENT").length,
    icon: Zap
  }];
  const TaskCard = ({
    task,
    idx
  }: {
    task: Task;
    idx: number;
  }) => {
    const {
      t
    } = useTranslation();
    const sCfg = STATUS_CONFIG[task.status] || STATUS_CONFIG.TODO;
    const pCfg = PRIORITY_CONFIG[task.priority] || PRIORITY_CONFIG.MEDIUM;
    const progress = task.status === "COMPLETED" ? 100 : task.status === "REVIEW" ? 80 : task.status === "IN_PROGRESS" ? 50 : 0;
    return <motion.div initial={{
      opacity: 0,
      scale: 0.95
    }} animate={{
      opacity: 1,
      scale: 1
    }} transition={{
      delay: idx * 0.05
    }} className="bg-[#1a1b1e]/60 border border-white/5 border-l border-t rounded-[40px] p-8 backdrop-blur-3xl shadow-3xl group hover:bg-white/5 transition-all relative overflow-hidden">
        <div className="absolute top-0 right-0 p-8 opacity-5 text-blue-500 group-hover:scale-110 transition-transform">
           <pCfg.icon className="w-48 h-48" />
        </div>

        <div className="flex items-start justify-between mb-8 relative z-10">
           <div className="flex items-center gap-4">
              <Badge className={cn("px-4 py-1.5 rounded-full border text-[9px] font-black  tracking-widest italic", sCfg.color)}>
                 {sCfg.label}
              </Badge>
              <div className="flex items-center gap-2">
                 <pCfg.icon className={cn("w-3 h-3", pCfg.color)} />
                 <span className={cn("text-[9px] font-black  italic tracking-widest", pCfg.color)}>{pCfg.label}</span>
              </div>
           </div>
           
           <DropdownMenu>
              <DropdownMenuTrigger asChild>
                 <Button variant="ghost" size="icon" className="h-10 w-10 text-slate-500 hover:text-white rounded-xl">
                    <MoreHorizontal className="w-5 h-5" />
                 </Button>
              </DropdownMenuTrigger>
              <DropdownMenuContent align="end" className="bg-[#1a1b1e] border-white/10 text-white font-bold italic text-[10px]">
                 <DropdownMenuItem onClick={() => {
              setForm(task);
              setEditOpen(true);
            }} className="focus:bg-blue-600"><Edit3 className="w-4 h-4 mr-2" />{t("client.src.reconfigtask")}</DropdownMenuItem>
                 <DropdownMenuItem className="focus:bg-emerald-600"><CheckCircle className="w-4 h-4 mr-2" />{t("client.src.completelogic")}</DropdownMenuItem>
                 <DropdownMenuItem onClick={() => setTasks(tasks.filter(t => t.id !== task.id))} className="text-red-500 focus:bg-red-600 focus:text-white"><Trash2 className="w-4 h-4 mr-2" />{t("client.src.erasenode")}</DropdownMenuItem>
              </DropdownMenuContent>
           </DropdownMenu>
        </div>

        <h3 className="text-xl font-black text-white italic tracking-tighter mb-2 group-hover:text-blue-400 transition-colors">{task.title}</h3>
        <p className="text-[10px] font-bold text-slate-500 tracking-widest italic mb-8 line-clamp-2 leading-relaxed">{task.description}</p>

        <div className="bg-black/40 border border-white/5 rounded-2xl p-6 mb-8 relative z-10">
           <div className="flex items-center justify-between mb-2">
              <p className="text-[8px] font-black text-slate-600 italic">{t("client.src.neuralprogress")}</p>
              <span className="text-[10px] font-black text-white italic tracking-widest">{progress}%</span>
           </div>
           <div className="h-1 w-full bg-white/5 rounded-full overflow-hidden">
              <motion.div initial={{
            width: 0
          }} animate={{
            width: `${progress}%`
          }} className={cn("h-full transition-all duration-1000", sCfg.indicator)} />
           </div>
        </div>

        <div className="flex items-center justify-between pt-6 border-t border-white/5 relative z-10">
           <div className="flex items-center gap-3">
              <Avatar className="h-10 w-10 border border-white/10 shadow-2xl">
                 <AvatarFallback className="bg-blue-600 text-white font-black text-[10px]">{task.assignedUser?.name.split(' ').map(n => n[0]).join('') || "U"}</AvatarFallback>
              </Avatar>
              <div className="flex flex-col">
                 <span className="text-[8px] font-black text-slate-600 italic mb-0.5">{t("client.src.operative")}</span>
                 <span className="text-[10px] font-black text-white italic tracking-tighter">{task.assignedUser?.name || "UNASSIGNED"}</span>
              </div>
           </div>
           <div className="flex flex-col items-end">
              <span className="text-[8px] font-black text-slate-600 italic mb-0.5">{t("client.src.deadline")}</span>
              <div className="flex items-center gap-2 text-slate-400">
                 <Calendar className="w-3 h-3" />
                 <span className="text-[10px] font-black italic">{task.dueAt || "INF_TIME_BUFFER"}</span>
              </div>
           </div>
        </div>
      </motion.div>;
  };
  return <PageShell title={t("client.src.neural_logistics")} description={t("client.src.task_orchestration_operational_force")}>
      <div className="space-y-12">
        {/* Hub Stats */}
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
           {stats.map((stat, idx) => <Card key={idx} className="bg-[#1a1b1e]/60 border-white/5 border-l border-t rounded-[32px] p-10 shadow-3xl relative group hover:bg-white/5 transition-all">
                <div className="absolute top-0 right-0 p-8 opacity-5 text-blue-500 group-hover:scale-110 transition-transform">
                   <stat.icon className="w-16 h-16" />
                </div>
                <p className="text-[10px] font-black text-slate-500 tracking-widest italic mb-2 leading-none">{stat.label}</p>
                <h3 className="text-4xl font-black text-white italic tracking-tighter leading-none">{stat.value}</h3>
             </Card>)}
        </div>

        {/* System Precision Dashboard */}
        <Card className="bg-[#1a1b1e]/40 border border-white/5 rounded-[48px] p-12 backdrop-blur-3xl shadow-3xl overflow-hidden relative">
           <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-transparent via-blue-500/50 to-transparent opacity-30" />
           <div className="flex flex-col lg:flex-row gap-12 items-center">
              <div className="flex-1 w-full space-y-8">
                 <div className="flex items-center gap-4 mb-2">
                    <div className="h-12 w-12 rounded-2xl bg-blue-600/10 border border-blue-500/20 flex items-center justify-center">
                       <Activity className="w-6 h-6 text-blue-400" />
                    </div>
                    <div>
                       <h4 className="text-lg font-black text-white italic tracking-tighter leading-none">{t("client.src.systemprecision")}</h4>
                       <p className="text-[9px] font-black text-slate-500 tracking-widest italic mt-1">{t("client.src.realtime_operational_metrics")}</p>
                    </div>
                 </div>
                 <div className="space-y-8 pt-4">
                    <div className="space-y-3">
                       <div className="flex justify-between items-end">
                          <p className="text-[10px] font-black text-white italic tracking-widest">{t("client.src.global_objective_alignment")}</p>
                          <span className="text-xl font-black text-blue-400 italic leading-none">84.2%</span>
                       </div>
                       <div className="h-2 bg-white/5 rounded-full overflow-hidden p-0.5">
                          <motion.div initial={{
                    width: 0
                  }} animate={{
                    width: "84.2%"
                  }} className="h-full bg-blue-500 rounded-full" />
                       </div>
                    </div>
                    <div className="space-y-3">
                       <div className="flex justify-between items-end">
                          <p className="text-[10px] font-black text-white italic tracking-widest">{t("client.src.temporal_buffer_availability")}</p>
                          <span className="text-xl font-black text-emerald-400 italic leading-none">12.5%</span>
                       </div>
                       <div className="h-2 bg-white/5 rounded-full overflow-hidden p-0.5">
                          <motion.div initial={{
                    width: 0
                  }} animate={{
                    width: "12.5%"
                  }} className="h-full bg-emerald-500 rounded-full" />
                       </div>
                    </div>
                 </div>
              </div>
              <div className="lg:w-px h-32 bg-white/5" />
              <div className="flex flex-wrap items-center justify-center gap-10">
                 <div className="text-center group">
                    <div className="h-20 w-20 rounded-[28px] bg-white/2 border border-white/5 flex items-center justify-center mb-4 group-hover:bg-blue-600 group-hover:scale-110 transition-all cursor-pointer">
                       <Cpu className="w-10 h-10 text-slate-500 group-hover:text-white" />
                    </div>
                    <p className="text-[9px] font-black text-slate-500 italic tracking-widest">{t("client.src.allocateforces")}</p>
                 </div>
                 <div className="text-center group">
                    <div className="h-20 w-20 rounded-[28px] bg-white/2 border border-white/5 flex items-center justify-center mb-4 group-hover:bg-emerald-600 group-hover:scale-110 transition-all cursor-pointer">
                       <RefreshCw className="w-10 h-10 text-slate-500 group-hover:text-white" />
                    </div>
                    <p className="text-[9px] font-black text-slate-500 italic tracking-widest">{t("client.src.syncbuffers")}</p>
                 </div>
                 <div className="text-center group">
                    <div className="h-20 w-20 rounded-[28px] bg-white/2 border border-white/5 flex items-center justify-center mb-4 group-hover:bg-red-600 group-hover:scale-110 transition-all cursor-pointer">
                       <AlertCircle className="w-10 h-10 text-slate-500 group-hover:text-white" />
                    </div>
                    <p className="text-[9px] font-black text-slate-500 italic tracking-widest">{t("client.src.cleanupstreams")}</p>
                 </div>
              </div>
           </div>
        </Card>

        {/* Global Control Bar */}
        <div className="flex flex-col sm:flex-row items-center justify-between gap-8 bg-[#1a1b1e]/60 border border-white/5 p-8 rounded-[40px] backdrop-blur-xl">
           <div className="flex flex-wrap items-center gap-6 flex-1">
              <div className="relative group min-w-[300px]">
                 <Search className="absolute left-5 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-600 group-focus-within:text-blue-500 transition-colors" />
                 <input placeholder={t("client.src.search_task_nodes")} className="w-full h-14 pl-14 pr-6 bg-black/40 border border-white/5 rounded-2xl text-[10px] font-black tracking-widest italic text-white placeholder:text-slate-800 outline-none focus:border-blue-500/30 transition-all" value={search} onChange={e => setSearch(e.target.value)} />
              </div>
              <Select value={filterStatus} onValueChange={setFilterStatus}>
                 <SelectTrigger className="w-[180px] h-14 bg-black/40 border-white/5 rounded-2xl text-[10px] font-black italic text-white">
                    <SelectValue placeholder={t("client.src.filterstatus")} />
                 </SelectTrigger>
                 <SelectContent className="bg-[#1a1b1e] border-white/10 text-white font-bold italic text-[10px]">
                    <SelectItem value="all">{t("client.src.allstreams")}</SelectItem>
                    <SelectItem value="TODO">{t("client.src.pendinglogic")}</SelectItem>
                    <SelectItem value="IN_PROGRESS">{t("client.src.activecpu")}</SelectItem>
                    <SelectItem value="REVIEW">{t("client.src.validation")}</SelectItem>
                 </SelectContent>
              </Select>
              <Select value={filterPriority} onValueChange={setFilterPriority}>
                 <SelectTrigger className="w-[180px] h-14 bg-black/40 border-white/5 rounded-2xl text-[10px] font-black italic text-white">
                    <SelectValue placeholder={t("client.src.filterthreshold")} />
                 </SelectTrigger>
                 <SelectContent className="bg-[#1a1b1e] border-white/10 text-white font-bold italic text-[10px]">
                    <SelectItem value="all">{t("client.src.allthresholds")}</SelectItem>
                    <SelectItem value="URGENT">{t("client.src.criticalonly")}</SelectItem>
                    <SelectItem value="HIGH">{t("client.src.highimpact")}</SelectItem>
                 </SelectContent>
              </Select>
           </div>
           <Button onClick={() => {
          setForm({
            title: "",
            description: "",
            status: "TODO",
            priority: "MEDIUM"
          });
          setCreateOpen(true);
        }} className="h-16 px-10 rounded-2xl bg-blue-600 hover:bg-blue-500 text-white font-black text-[11px] italic tracking-[0.2em] shadow-2xl shadow-blue-600/30 shrink-0">
             <Plus className="w-5 h-5 mr-3" />{t("client.src.initializedirective")}</Button>
        </div>

        {/* Task Grid */}
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-10">
          <AnimatePresence mode="popLayout">
            {filteredTasks.map((task, idx) => <TaskCard key={task.id} task={task} idx={idx} />)}
          </AnimatePresence>
        </div>
      </div>

      {/* Modern Interface Dialogs */}
      <Dialog open={createOpen || editOpen} onOpenChange={v => {
      setCreateOpen(v);
      setEditOpen(v);
    }}>
        <DialogContent className="max-w-3xl bg-[#14151a] border-white/10 text-white rounded-[40px] p-12 font-display shadow-3xl">
           <DialogHeader>
             <DialogTitle className="text-4xl font-black italic tracking-tighter">
                {editOpen ? "Recalibrate Directive" : "Materialize New Goal"}
             </DialogTitle>
             <DialogDescription className="text-[10px] font-black text-slate-500 tracking-widest italic mt-2">{t("client.src.injecting_operational_parameters_into")}</DialogDescription>
           </DialogHeader>
           <form className="space-y-10 py-10">
             <div className="grid grid-cols-1 md:grid-cols-2 gap-10">
                <div className="space-y-6 md:col-span-2">
                   <Label className="text-[10px] font-black text-slate-400 italic">{t("client.src.directiveheader")}</Label>
                   <Input required value={form.title} onChange={e => setForm({
                ...form,
                title: e.target.value
              })} className="h-16 bg-black/40 border-white/5 rounded-2xl text-[11px] font-black italic text-white placeholder:text-slate-800" placeholder={t("client.src.eg_corelogisticsexpansion")} />
                </div>
                <div className="space-y-6 md:col-span-2">
                   <Label className="text-[10px] font-black text-slate-400 italic">{t("client.src.logicdescription")}</Label>
                   <Textarea value={form.description} onChange={e => setForm({
                ...form,
                description: e.target.value
              })} className="bg-black/40 border-white/5 rounded-2xl text-[11px] font-black italic text-white placeholder:text-slate-800 min-h-[120px]" placeholder={t("client.src.defineoperationalparameters")} />
                </div>
                <div className="space-y-6">
                   <Label className="text-[10px] font-black text-slate-400 italic">{t("client.src.executionstatus")}</Label>
                   <Select value={form.status} onValueChange={v => setForm({
                ...form,
                status: v
              })}>
                      <SelectTrigger className="h-16 bg-black/40 border-white/5 rounded-2xl text-[11px] font-black italic text-white">
                         <SelectValue />
                      </SelectTrigger>
                      <SelectContent className="bg-[#1a1b1e] border-white/10 text-white font-bold italic text-[10px]">
                         <SelectItem value="TODO">{t("client.src.pendingqueue")}</SelectItem>
                         <SelectItem value="IN_PROGRESS">{t("client.src.activecpu")}</SelectItem>
                         <SelectItem value="REVIEW">{t("client.src.neuralvalidation")}</SelectItem>
                      </SelectContent>
                   </Select>
                </div>
                <div className="space-y-6">
                   <Label className="text-[10px] font-black text-slate-400 italic">{t("client.src.threatthreshold")}</Label>
                   <Select value={form.priority} onValueChange={v => setForm({
                ...form,
                priority: v
              })}>
                      <SelectTrigger className="h-16 bg-black/40 border-white/5 rounded-2xl text-[11px] font-black italic text-white">
                         <SelectValue />
                      </SelectTrigger>
                      <SelectContent className="bg-[#1a1b1e] border-white/10 text-white font-bold italic text-[10px]">
                         <SelectItem value="LOW">{t("client.src.lowimpact")}</SelectItem>
                         <SelectItem value="MEDIUM">{t("client.src.standardlogic")}</SelectItem>
                         <SelectItem value="HIGH">{t("client.src.highpriority")}</SelectItem>
                         <SelectItem value="URGENT">{t("client.src.criticalsignal")}</SelectItem>
                      </SelectContent>
                   </Select>
                </div>
             </div>
             <DialogFooter className="gap-8 pt-8 border-t border-white/5">
                <Button type="button" variant="ghost" onClick={() => {
              setCreateOpen(false);
              setEditOpen(false);
            }} className="text-[11px] font-black italic text-slate-500 hover:text-white">{t("client.src.abortdirective")}</Button>
                <Button type="button" onClick={() => {
              setCreateOpen(false);
              setEditOpen(false);
              toast({
                title: t("client.src.directivecommitted"),
                description: t("client.src.node_parameters_successfully_synced")
              });
            }} className="h-18 px-14 rounded-2xl bg-blue-600 hover:bg-blue-500 text-white font-black text-[12px] italic tracking-[0.3em] shadow-2xl shadow-blue-600/30">
                   {editOpen ? "RECALIBRATE" : "MATERIALIZE"}
                </Button>
             </DialogFooter>
           </form>
        </DialogContent>
      </Dialog>
    </PageShell>;
}