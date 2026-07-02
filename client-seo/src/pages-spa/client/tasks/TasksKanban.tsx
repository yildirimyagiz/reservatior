import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { PageShell } from "@/pages-spa/client/layout/PageShell";
import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { MoreHorizontal, Plus, Search, Filter, Clock, AlertTriangle, CheckCircle, XCircle, Layout, Activity, Target, Cpu, Shield, ArrowUpRight, User as UserIcon, Tag as TagIcon } from "lucide-react";
import { Input } from "@/components/ui/input";
import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle, DialogFooter } from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { useToast } from "@/hooks/use-toast";
import { motion, AnimatePresence } from "framer-motion";
import { cn } from "@/lib/utils";

// Mock data
const MOCK_TASKS = [{
  id: "TSK-001",
  title: t("client.src.hvac_sensor_recalibration"),
  description: t("client.src.annual_tactical_inspection_of"),
  status: "todo",
  priority: "high",
  assignee: "OPERATIVE-X",
  property: "SUNSET NODE-2A",
  dueDate: "2024-03-20",
  tags: ["maintenance", "hvac"]
}, {
  id: "TSK-002",
  title: t("client.src.legal_protocol_drafting"),
  description: t("client.src.reviewing_multisig_lease_agreements"),
  status: "in-progress",
  priority: "medium",
  assignee: "PROTOCOL-S",
  property: "LOGIC LOFT-3B",
  dueDate: "2024-03-18",
  tags: ["legal", "protocol"]
}, {
  id: "TSK-003",
  title: t("client.src.thermal_leak_containment"),
  description: t("client.src.emergency_shielding_of_building"),
  status: "done",
  priority: "urgent",
  assignee: "CORE-TECH",
  property: "OAKWOOD TERMINAL",
  dueDate: "2024-03-16",
  tags: ["urgent", "repair"]
}];
export default function TasksKanban() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const [searchTerm, setSearchTerm] = useState("");
  const [filterPriority, setFilterPriority] = useState("all");
  const [isAddDialogOpen, setIsAddDialogOpen] = useState(false);
  const filteredTasks = MOCK_TASKS.filter(task => {
    const matchesSearch = task.title.toLowerCase().includes(searchTerm.toLowerCase()) || task.description.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesPriority = filterPriority === "all" || task.priority.toLowerCase() === filterPriority.toLowerCase();
    return matchesSearch && matchesPriority;
  });
  const todoTasks = filteredTasks.filter(task => task.status === "todo");
  const inProgressTasks = filteredTasks.filter(task => task.status === "in-progress");
  const doneTasks = filteredTasks.filter(task => task.status === "done");
  const handleAddTask = (e: React.FormEvent) => {
    e.preventDefault();
    setIsAddDialogOpen(false);
    toast({
      title: t("client.src.directive_initialized"),
      description: t("client.src.task_successfully_registered_to")
    });
  };
  const getPriorityColor = (priority: string) => {
    switch (priority.toLowerCase()) {
      case "urgent":
        return "bg-red-500/10 text-red-500 border-red-500/20";
      case "high":
        return "bg-orange-500/10 text-orange-500 border-orange-500/20";
      case "medium":
        return "bg-blue-500/10 text-blue-500 border-blue-500/20";
      default:
        return "bg-slate-500/10 text-slate-500 border-white/5";
    }
  };
  const TaskCard = ({
    task
  }: {
    task: any;
  }) => {
    const {
      t
    } = useTranslation();
    return <motion.div layout initial={{
      opacity: 0,
      y: 10
    }} animate={{
      opacity: 1,
      y: 0
    }} exit={{
      opacity: 0,
      scale: 0.95
    }} whileHover={{
      y: -4
    }} className="bg-[#1a1b1e]/60 border border-white/5 rounded-3xl p-6 mb-4 backdrop-blur-2xl shadow-xl group cursor-grab active:cursor-grabbing hover:bg-white/5 transition-all">
      <div className="flex items-start justify-between mb-4">
         <Badge className={cn("text-[8px] font-black  tracking-widest italic px-2 py-0.5 rounded-md border", getPriorityColor(task.priority))}>
            {task.priority}
         </Badge>
         <DropdownMenu>
            <DropdownMenuTrigger asChild>
               <Button variant="ghost" size="sm" className="h-8 w-8 p-0 opacity-20 group-hover:opacity-100 transition-opacity">
                  <MoreHorizontal className="h-4 w-4" />
               </Button>
            </DropdownMenuTrigger>
            <DropdownMenuContent className="bg-[#1a1b1e] border-white/10 italic font-bold text-[10px]">
               <DropdownMenuItem className="focus:bg-blue-600 focus:text-white">{t("client.src.reassign")}</DropdownMenuItem>
               <DropdownMenuItem className="focus:bg-blue-600 focus:text-white">{t("client.src.recalibrate")}</DropdownMenuItem>
               <DropdownMenuItem className="focus:bg-red-600 focus:text-white text-red-500">{t("client.src.terminate")}</DropdownMenuItem>
            </DropdownMenuContent>
         </DropdownMenu>
      </div>

      <h4 className="text-sm font-black text-white italic tracking-tight mb-2 group-hover:text-blue-400 transition-colors">{task.title}</h4>
      <p className="text-[10px] font-bold text-slate-500 tracking-widest leading-relaxed italic mb-4 line-clamp-2">{task.description}</p>

      <div className="flex flex-wrap gap-1.5 mb-6">
         {task.tags.map((tag: string) => <Badge key={tag} className="bg-black/40 border-white/5 text-[7px] font-black text-slate-400 italic px-2 py-0.5">
             {tag}
           </Badge>)}
      </div>

      <div className="flex items-center justify-between pt-4 border-t border-white/5">
         <div className="flex items-center gap-2">
            <div className="h-6 w-6 rounded-full bg-blue-600/20 border border-blue-500/30 flex items-center justify-center">
               <UserIcon className="w-3 h-3 text-blue-400" />
            </div>
            <span className="text-[8px] font-black text-slate-400 italic">{task.assignee}</span>
         </div>
         <div className="flex items-center gap-1.5">
            <Clock className="w-2.5 h-2.5 text-slate-600" />
            <span className="text-[8px] font-black text-slate-600 italic">{task.dueDate}</span>
         </div>
      </div>
    </motion.div>;
  };
  const KanbanColumn = ({
    title,
    tasks,
    icon: Icon,
    color
  }: {
    title: string;
    tasks: any[];
    icon: any;
    color: string;
  }) => {
    const {
      t
    } = useTranslation();
    return <div className="flex-1 min-w-[320px] max-w-[400px]">
      <div className="flex items-center justify-between mb-6 px-2">
        <div className="flex items-center gap-3">
          <div className={cn("h-2 w-2 rounded-full", color)} />
          <h3 className="text-[10px] font-black text-white tracking-widest italic">{title}</h3>
        </div>
        <Badge variant="outline" className="bg-white/2 border-white/5 text-[9px] font-bold text-slate-500 rounded-lg h-6 px-2">
           {tasks.length}
        </Badge>
      </div>

      <div className="bg-[#1a1b1e]/20 border border-white/5 rounded-[40px] p-6 min-h-[600px] shadow-inner relative overflow-hidden backdrop-blur-3xl">
        <div className="absolute top-0 right-0 p-10 opacity-5 pointer-events-none">
           <Icon className="w-24 h-24 text-slate-600" />
        </div>
        
        <div className="relative z-10">
          <AnimatePresence mode="popLayout">
            {tasks.map(task => <TaskCard key={task.id} task={task} />)}
          </AnimatePresence>
          {tasks.length === 0 && <div className="py-20 flex flex-col items-center gap-4 border border-dashed border-white/5 rounded-3xl bg-black/10">
               <Layout className="w-8 h-8 text-slate-800 opacity-20" />
               <p className="text-[9px] font-black text-slate-700 italic">{t("client.src.sector_empty")}</p>
            </div>}
        </div>

        <Button variant="outline" className="w-full mt-2 h-14 border-dashed border-white/10 bg-white/2 hover:bg-blue-600/10 hover:border-blue-500/30 hover:text-blue-400 text-slate-600 text-[10px] font-black italic tracking-widest rounded-2xl transition-all">
          <Plus className="w-4 h-4 mr-2" />{t("client.src.initialize_protocol")}</Button>
      </div>
    </div>;
  };
  return <PageShell title={t("client.src.neural_kanban")} description={t("client.src.visual_directive_synchronization_organizational")}>
      <div className="space-y-12">
        {/* Intelligence Grid */}
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
           {[{
          label: t("client.src.directives"),
          value: MOCK_TASKS.length,
          icon: Target
        }, {
          label: t("client.src.system_flow"),
          value: "82%",
          icon: Activity
        }, {
          label: t("client.src.priority_load"),
          value: "HIGH",
          icon: AlertTriangle
        }, {
          label: t("client.src.node_status"),
          value: "STABLE",
          icon: Shield
        }].map((stat, idx) => <Card key={idx} className="bg-[#1a1b1e]/60 border-white/5 border-l border-t rounded-[32px] p-10 shadow-3xl relative group hover:bg-white/5 transition-all">
                <div className="absolute top-0 right-0 p-8 opacity-5 text-blue-500 group-hover:scale-110 transition-transform">
                   <stat.icon className="w-16 h-16" />
                </div>
                <p className="text-[10px] font-black text-slate-500 tracking-widest italic mb-2 leading-none">{stat.label}</p>
                <h3 className="text-4xl font-black text-white italic tracking-tighter leading-none">{stat.value}</h3>
             </Card>)}
        </div>

        {/* Tactical Filters */}
        <div className="flex flex-col sm:flex-row items-center justify-between gap-6 bg-[#1a1b1e]/60 border border-white/5 p-4 rounded-[28px] backdrop-blur-xl">
           <div className="relative group flex-1 w-full max-w-md">
             <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-600 group-focus-within:text-blue-500 transition-colors" />
             <Input placeholder={t("client.src.search_directive_grid")} value={searchTerm} onChange={e => setSearchTerm(e.target.value)} className="h-12 pl-12 bg-black/40 border-white/5 rounded-xl text-[10px] font-black tracking-widest italic text-white placeholder:text-slate-700" />
           </div>
           
           <div className="flex items-center gap-4 w-full sm:w-auto">
             <Select value={filterPriority} onValueChange={setFilterPriority}>
               <SelectTrigger className="h-12 w-40 bg-black/40 border-white/5 rounded-xl text-[9px] font-black tracking-widest italic text-slate-400">
                  <SelectValue placeholder={t("client.src.priority")} />
               </SelectTrigger>
               <SelectContent className="bg-[#1a1b1e] border-white/10 italic font-bold">
                  <SelectItem value="all">{t("client.src.all_levels")}</SelectItem>
                  <SelectItem value="urgent">{t("client.src.urgent")}</SelectItem>
                  <SelectItem value="high">{t("client.src.high")}</SelectItem>
                  <SelectItem value="medium">{t("client.src.medium")}</SelectItem>
               </SelectContent>
             </Select>
             
             <Button onClick={() => setIsAddDialogOpen(true)} className="h-12 px-6 rounded-xl bg-blue-600 hover:bg-blue-500 text-white font-black text-[10px] italic tracking-widest shadow-xl shadow-blue-600/20">
               <Plus className="w-4 h-4 mr-2" />{t("client.src.add_task")}</Button>
           </div>
        </div>

        {/* Kanban Board Grid */}
        <div className="flex gap-10 overflow-x-auto pb-12 snap-x">
          <KanbanColumn title={t("client.src.pending_queue")} tasks={todoTasks} icon={Clock} color="bg-slate-500 shadow-[0_0_10px_#64748b]" />
          <KanbanColumn title={t("client.src.active_processing")} tasks={inProgressTasks} icon={Cpu} color="bg-yellow-500 shadow-[0_0_10px_#eab308]" />
          <KanbanColumn title={t("client.src.synchronized")} tasks={doneTasks} icon={CheckCircle} color="bg-emerald-500 shadow-[0_0_10px_#10b981]" />
        </div>
      </div>

      {/* Modern Interface Dialogs */}
      <Dialog open={isAddDialogOpen} onOpenChange={setIsAddDialogOpen}>
        <DialogContent className="max-w-2xl bg-[#14151a] border-white/10 text-white rounded-[32px] p-10 font-display">
          <DialogHeader>
            <DialogTitle className="text-3xl font-black italic tracking-tighter">{t("client.src.initialize_tactical_directive")}</DialogTitle>
            <DialogDescription className="text-[10px] font-black text-slate-500 tracking-widest italic">{t("client.src.provisioning_new_task_node")}</DialogDescription>
          </DialogHeader>
          <form onSubmit={handleAddTask} className="space-y-8 py-8">
            <div className="space-y-3">
              <Label className="text-[10px] font-black text-slate-400 italic">{t("client.src.directive_title")}</Label>
              <Input placeholder={t("client.src.task_identifier")} className="h-14 bg-black/40 border-white/5 rounded-2xl text-[10px] font-black italic text-white placeholder:text-slate-800" />
            </div>
            <div className="space-y-3">
              <Label className="text-[10px] font-black text-slate-400 italic">{t("client.src.directive_parameters")}</Label>
              <Input placeholder={t("client.src.task_description")} className="h-14 bg-black/40 border-white/5 rounded-2xl text-[10px] font-black italic text-white placeholder:text-slate-800" />
            </div>
            <div className="grid grid-cols-2 gap-8">
               <div className="space-y-3">
                  <Label className="text-[10px] font-black text-slate-400 italic">{t("client.src.assign_operative")}</Label>
                  <Select><SelectTrigger className="h-14 bg-black/40 border-white/5 rounded-2xl text-[10px] font-black italic text-slate-400"><SelectValue placeholder={t("client.src.select_operative")} /></SelectTrigger><SelectContent className="bg-[#1a1b1e] border-white/10 font-display">
                    {["OPERATIVE-X", "PROTOCOL-S", "CORE-TECH", "IDENTITY-NODE"].map(o => <SelectItem key={o} value={o} className="text-slate-400 font-bold italic">{o}</SelectItem>)}
                  </SelectContent></Select>
               </div>
               <div className="space-y-3">
                  <Label className="text-[10px] font-black text-slate-400 italic">{t("client.src.priority_clearance")}</Label>
                  <Select><SelectTrigger className="h-14 bg-black/40 border-white/5 rounded-2xl text-[10px] font-black italic text-slate-400"><SelectValue placeholder={t("client.src.select_level")} /></SelectTrigger><SelectContent className="bg-[#1a1b1e] border-white/10 font-display">
                    <SelectItem value="low" className="text-slate-400 font-bold italic text-[10px]">{t("client.src.standard_clearance")}</SelectItem>
                    <SelectItem value="medium" className="text-slate-400 font-bold italic text-[10px]">{t("client.src.medium_priority")}</SelectItem>
                    <SelectItem value="high" className="text-slate-400 font-bold italic text-[10px]">{t("client.src.high_priority")}</SelectItem>
                    <SelectItem value="urgent" className="text-slate-400 font-bold italic text-[10px]">{t("client.src.urgent_response")}</SelectItem>
                  </SelectContent></Select>
               </div>
            </div>
            <DialogFooter className="gap-6 pt-6 border-t border-white/5">
              <Button type="button" variant="ghost" onClick={() => setIsAddDialogOpen(false)} className="text-[10px] font-black italic text-slate-500 hover:text-white">{t("client.src.abort")}</Button>
              <Button type="submit" className="h-16 px-12 rounded-2xl bg-blue-600 hover:bg-blue-500 text-white font-black text-[11px] italic tracking-[0.2em] shadow-2xl shadow-blue-600/30">{t("client.src.materialize_directive")}</Button>
            </DialogFooter>
          </form>
        </DialogContent>
      </Dialog>
    </PageShell>;
}