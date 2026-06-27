import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Card, CardContent } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { LeadStatus } from "@/lib/types/leads";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription, DialogFooter } from "@/components/ui/dialog";
import { Textarea } from "@/components/ui/textarea";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import { Users, Plus, Search, Filter, Phone, Calendar, Edit, Trash2, Star, CheckCircle, Activity, Cpu, Layers, Fingerprint, Mail, DollarSign, TrendingUp } from "lucide-react";
import { motion, AnimatePresence } from "framer-motion";
import { useState } from "react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { useToast } from "@/hooks/use-toast";
import { leadsApi, Lead } from "@/lib/api/leads";
import { PageShell } from "@/pages/client/layout/PageShell";
import { cn } from "@/lib/utils";
export default function Leads() {
  const {
    t
  } = useTranslation();
  const queryClient = useQueryClient();
  const { data: leadsResponse, isLoading: loading } = useQuery({
    queryKey: ['leads'],
    queryFn: async () => leadsApi.getAll()
  });
  const leads = (Array.isArray(leadsResponse) ? leadsResponse : (leadsResponse as any)?.data) || [];
  
  const [searchTerm, setSearchTerm] = useState("");
  const [filterStatus, setFilterStatus] = useState("all");
  const [filterSource, setFilterSource] = useState("all");
  const [createOpen, setCreateOpen] = useState(false);
  const [editOpen, setEditOpen] = useState(false);
  const [selectedLead, setSelectedLead] = useState<Lead | null>(null);
  const [formData, setFormData] = useState<Partial<Lead>>({});
  const { toast } = useToast();
  const filteredLeads = leads.filter((lead: Lead) => {
    const fullName = `${lead.firstName || ""} ${lead.lastName || ""}`.trim();
    const matchesSearch = fullName.toLowerCase().includes(searchTerm.toLowerCase()) || lead.email && lead.email.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesStatus = filterStatus === "all" || lead.status === filterStatus;
    const matchesSource = filterSource === "all" || lead.sourceDetail?.includes(filterSource);
    return matchesSearch && matchesStatus && matchesSource;
  });
  const getStatusColor = (status: LeadStatus) => {
    switch (status) {
      case LeadStatus.NEW:
        return "bg-blue-500/10 text-blue-400 border-blue-500/20";
      case LeadStatus.CONTACTED:
        return "bg-orange-500/10 text-orange-400 border-orange-500/20";
      case LeadStatus.QUALIFIED:
        return "bg-purple-500/10 text-purple-400 border-purple-500/20";
      case LeadStatus.CONVERTED:
        return "bg-emerald-500/10 text-emerald-400 border-emerald-500/20";
      case LeadStatus.LOST:
        return "bg-red-500/10 text-red-500 border-red-500/20";
      default:
        return "bg-slate-500/10 text-slate-500 border-white/5";
    }
  };
  const createMutation = useMutation({
    mutationFn: (data: Partial<Lead>) => leadsApi.create(data as any),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['leads'] });
      toast({
        title: t("client.src.node_initialized"),
        description: t("client.src.entity_successfully_registered_in")
      });
      setCreateOpen(false);
      setFormData({});
    },
    onError: () => {
      toast({
        title: t("client.src.error"),
        variant: "destructive"
      });
    }
  });

  const updateMutation = useMutation({
    mutationFn: ({ id, data }: { id: string; data: Partial<Lead> }) => leadsApi.update(id, data as any),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['leads'] });
      toast({
        title: t("client.src.data_synchronized"),
        description: t("client.src.lead_metadata_updated_across")
      });
      setEditOpen(false);
      setSelectedLead(null);
    },
    onError: () => {
      toast({
        title: t("client.src.error"),
        variant: "destructive"
      });
    }
  });

  const handleCreate = (e: React.FormEvent) => {
    e.preventDefault();
    createMutation.mutate(formData);
  };
  const handleEdit = (e: React.FormEvent) => {
    e.preventDefault();
    if (selectedLead) {
      updateMutation.mutate({ id: selectedLead.id, data: formData });
    }
  };
  const statusMutation = useMutation({
    mutationFn: ({ id, newStatus }: { id: string; newStatus: LeadStatus }) => leadsApi.update(id, { status: newStatus }),
    onSuccess: (_, { newStatus }) => {
      queryClient.invalidateQueries({ queryKey: ['leads'] });
      toast({
        title: t("client.src.status_evolved"),
        description: `Lead state transitioned to ${newStatus}.`
      });
    },
    onError: () => {
      toast({
        title: t("client.src.transition_error"),
        description: t("client.src.failed_to_materialize_lead"),
        variant: "destructive"
      });
    }
  });

  const handleStatusUpdate = (id: string, newStatus: LeadStatus) => {
    statusMutation.mutate({ id, newStatus });
  };
  const deleteMutation = useMutation({
    mutationFn: (id: string) => leadsApi.delete(id),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['leads'] });
      toast({
        title: t("client.src.node_purged"),
        description: t("client.src.entity_removed_from_active")
      });
    },
    onError: () => {
      toast({
        title: t("client.src.purge_failed"),
        description: t("client.src.critical_error_encountered_during"),
        variant: "destructive"
      });
    }
  });

  const handleDelete = (id: string) => {
    deleteMutation.mutate(id);
  };
  if (loading) {
    return <div className="flex items-center justify-center min-h-screen bg-[#14151a]">
        <div className="flex flex-col items-center gap-4">
          <Activity className="w-12 h-12 text-blue-500 animate-spin" />
          <p className="text-[10px] font-black text-slate-500 tracking-widest italic animate-pulse">{t("client.src.syncing_neural_core")}</p>
        </div>
      </div>;
  }
  const stats = [{
    label: t("client.src.total_entities"),
    value: leads.length,
    icon: Users,
    color: "text-blue-400"
  }, {
    label: t("client.src.new_nodes"),
    value: leads.filter((l: Lead) => l.status === LeadStatus.NEW).length,
    icon: Star,
    color: "text-yellow-400"
  }, {
    label: t("client.src.qualified_leads"),
    value: leads.filter((l: Lead) => l.status === LeadStatus.QUALIFIED).length,
    icon: TrendingUp,
    color: "text-purple-400"
  }, {
    label: t("client.src.conversion_yield"),
    value: leads.filter((l: Lead) => l.status === LeadStatus.CONVERTED).length,
    icon: CheckCircle,
    color: "text-emerald-400"
  }];
  return <PageShell title={t("client.src.neural_crm_pulse")} description={t("client.src.advanced_entity_intelligence_lead")} createLabel="Initialize Lead" onCreateClick={() => setCreateOpen(true)}>
      <div className="space-y-12">
        {/* Intelligence Metrics */}
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
          {stats.map((stat, idx) => <Card key={idx} className="bg-[#1a1b1e]/60 border-white/5 border-l border-t rounded-[32px] overflow-hidden shadow-2xl relative group hover:bg-white/5 transition-all">
               <div className="absolute top-0 right-0 p-8 opacity-5 text-blue-500 group-hover:scale-110 transition-transform">
                  <stat.icon className="w-16 h-16" />
               </div>
               <CardContent className="p-10">
                  <p className="text-[10px] font-black text-slate-500 tracking-widest italic mb-2 leading-none">{stat.label}</p>
                  <h3 className="text-4xl font-black text-white italic tracking-tighter leading-none">{stat.value}</h3>
                  <div className="mt-6 flex items-center gap-2">
                     <div className="h-1 flex-1 bg-white/5 rounded-full overflow-hidden">
                        <motion.div initial={{
                  width: 0
                }} animate={{
                  width: "65%"
                }} transition={{
                  duration: 1,
                  delay: idx * 0.2
                }} className={cn("h-full", stat.color.replace('text-', 'bg-'))} />
                     </div>
                     <span className="text-[8px] font-black text-slate-600">{t("client.src.65_optimization")}</span>
                  </div>
               </CardContent>
            </Card>)}
        </div>

        {/* Command Layer */}
        <Card className="bg-[#1a1b1e]/40 border-white/5 border-l border-t rounded-[40px] p-10 shadow-3xl">
           <div className="flex flex-col lg:flex-row items-center gap-10">
              <div className="relative flex-1 group w-full">
                 <Search className="absolute left-6 top-1/2 -translate-y-1/2 w-5 h-5 text-slate-600 group-focus-within:text-blue-500 transition-colors" />
                 <input type="text" placeholder={t("client.src.search_neural_entities")} className="w-full h-16 pl-16 pr-8 bg-black/40 border border-white/5 rounded-2xl text-xs font-black tracking-widest italic text-white placeholder:text-slate-700 focus:outline-none focus:border-blue-500/50 transition-all shadow-xl" value={searchTerm} onChange={e => setSearchTerm(e.target.value)} />
              </div>
              
              <div className="flex items-center gap-6 w-full lg:w-auto">
                 <Select value={filterStatus} onValueChange={setFilterStatus}>
                    <SelectTrigger className="h-16 px-8 rounded-2xl bg-black/40 border-white/5 text-[10px] font-black italic tracking-widest text-white min-w-44">
                       <SelectValue placeholder={t("client.src.status_control")} />
                    </SelectTrigger>
                    <SelectContent className="bg-[#1a1b1e] border-white/10 rounded-2xl">
                       <SelectItem value="all">{t("client.src.all_nodes")}</SelectItem>
                       <SelectItem value={LeadStatus.NEW}>{t("client.src.new_nodes")}</SelectItem>
                       <SelectItem value={LeadStatus.CONTACTED}>{t("client.src.engaged")}</SelectItem>
                       <SelectItem value={LeadStatus.QUALIFIED}>{t("client.src.qualified")}</SelectItem>
                       <SelectItem value={LeadStatus.CONVERTED}>{t("client.src.revenue")}</SelectItem>
                       <SelectItem value={LeadStatus.LOST}>{t("client.src.terminated")}</SelectItem>
                    </SelectContent>
                 </Select>

                 <Button variant="outline" className="h-16 px-8 rounded-2xl border-white/5 bg-white/5 text-slate-400 hover:text-white transition-all backdrop-blur-xl shrink-0">
                    <Filter className="w-5 h-5" />
                 </Button>
              </div>
           </div>
        </Card>

        {/* Entity Data Stream */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          <AnimatePresence mode="popLayout">
            {filteredLeads.map((lead: Lead, idx: number) => <motion.div key={lead.id} layout initial={{
            opacity: 0,
            scale: 0.9
          }} animate={{
            opacity: 1,
            scale: 1
          }} exit={{
            opacity: 0,
            scale: 0.9
          }} transition={{
            duration: 0.4,
            delay: idx * 0.05
          }}>
                <Card className="group relative bg-[#1a1b1e]/40 border-white/5 border-l border-t rounded-[32px] p-8 hover:bg-white/5 transition-all shadow-2xl overflow-hidden cursor-pointer">
                  <div className="absolute top-0 right-0 p-8 opacity-0 group-hover:opacity-5 transition-opacity text-blue-500 pointer-events-none">
                     <Fingerprint className="w-24 h-24" />
                  </div>

                  <div className="flex justify-between items-start mb-8">
                    <div className="flex items-center gap-4">
                      <Avatar className="h-14 w-14 rounded-2xl border-2 border-white/10 shadow-2xl">
                        <AvatarFallback className="bg-linear-to-br from-blue-500 to-purple-600 text-white font-black">
                          {lead.firstName && lead.lastName ? `${lead.firstName[0]}${lead.lastName[0]}` : lead.firstName?.[0] || "?"}
                        </AvatarFallback>
                      </Avatar>
                      <div>
                        <h3 className="text-lg font-black text-white italic tracking-tighter leading-none mb-1">
                          {lead.firstName && lead.lastName ? `${lead.firstName} ${lead.lastName}` : lead.firstName || lead.email || "Unknown Entity"}
                        </h3>
                        <div className="flex items-center gap-2 text-[8px] font-black text-slate-600 tracking-widest italic group-hover:text-blue-500 transition-colors">
                           <Mail className="w-2.5 h-2.5" />
                           {lead.email || "NO ENCRYPTED COMMS"}
                        </div>
                      </div>
                    </div>
                    <Badge className={cn("text-[9px] font-black italic tracking-widest px-3 py-1 rounded-full border", getStatusColor(lead.status))}>
                      {lead.status}
                    </Badge>
                  </div>

                  <div className="space-y-4 mb-8">
                    {lead.phone && <div className="flex items-center gap-3 p-4 rounded-xl bg-black/40 border border-white/5 text-[10px] font-black text-slate-400 italic">
                        <Phone className="w-3 h-3 text-emerald-500" />
                        <span>{lead.phone}</span>
                      </div>}

                    <div className="grid grid-cols-2 gap-4">
                       <div className="p-4 rounded-xl bg-black/40 border border-white/5">
                          <p className="text-[7px] font-black text-slate-600 tracking-widest mb-1 italic">{t("client.src.fiscal_budget")}</p>
                          <div className="flex items-center gap-1.5 text-xs font-black text-white italic">
                             <DollarSign className="w-3 h-3 text-emerald-500" />
                             <span>{lead.budget?.toLocaleString() || "UNSPECIFIED"}</span>
                          </div>
                       </div>
                       <div className="p-4 rounded-xl bg-black/40 border border-white/5">
                          <p className="text-[7px] font-black text-slate-600 tracking-widest mb-1 italic">{t("client.src.last_interaction")}</p>
                          <div className="flex items-center gap-1.5 text-xs font-black text-white italic">
                             <Activity className="w-3 h-3 text-blue-500" />
                             <span>{new Date(lead.createdAt).toLocaleDateString()}</span>
                          </div>
                       </div>
                    </div>

                    {lead.notes && <div className="p-6 rounded-2xl bg-white/5 border border-white/5 relative">
                        <p className="text-[8px] font-black text-slate-600 italic tracking-widest mb-3">{t("client.src.intelligence_notes")}</p>
                        <p className="text-[10px] font-bold text-slate-500 italic leading-relaxed line-clamp-2">
                          "{lead.notes}"
                        </p>
                      </div>}
                  </div>

                  <div className="flex gap-4">
                    <Button className="flex-1 h-14 rounded-xl bg-white text-black hover:bg-slate-200 font-black italic tracking-widest text-xs transition-all" onClick={e => {
                  e.stopPropagation();
                  setSelectedLead(lead);
                  setFormData({
                    firstName: lead.firstName,
                    lastName: lead.lastName,
                    email: lead.email,
                    phone: lead.phone,
                    notes: lead.notes,
                    budget: lead.budget
                  });
                  setEditOpen(true);
                }}>
                      <Edit className="w-4 h-4 mr-2" />{t("client.src.configure")}</Button>
                    <Button variant="outline" className="h-14 w-14 rounded-xl border-white/10 bg-white/5 text-slate-500 hover:text-red-500 hover:bg-red-500/10 transition-all" onClick={e => {
                  e.stopPropagation();
                  handleDelete(lead.id);
                }}>
                      <Trash2 className="w-5 h-5" />
                    </Button>
                  </div>
                </Card>
              </motion.div>)}
          </AnimatePresence>
          {filteredLeads.length === 0 && <div className="col-span-full py-40 flex flex-col items-center gap-6 rounded-[40px] border border-dashed border-white/10 bg-black/20">
                <Layers className="w-16 h-16 text-slate-800 opacity-20" />
                <p className="text-[10px] font-black text-slate-600 tracking-widest italic animate-pulse">{t("client.src.no_neural_matches_detected")}</p>
             </div>}
        </div>
      </div>

      {/* Legacy Dialogs styled to match */}
      <Dialog open={createOpen} onOpenChange={setCreateOpen}>
        <DialogContent className="max-w-2xl bg-[#1a1b1e] border-white/10 text-white rounded-[32px] p-10">
          <DialogHeader>
            <DialogTitle className="text-2xl font-black italic tracking-tighter">{t("client.src.initialize_new_entity")}</DialogTitle>
            <DialogDescription className="text-[10px] font-bold text-slate-500 italic tracking-widest">{t("client.src.enter_the_metadata_for")}</DialogDescription>
          </DialogHeader>
          <form onSubmit={handleCreate} className="mt-8">
            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              <div className="space-y-2">
                <Label htmlFor="firstName" className="text-[10px] font-black text-slate-500 italic">{t("client.src.first_name")}</Label>
                <Input id="firstName" placeholder={t("client.src.first_name")} className="bg-black/40 border-white/5 h-12 rounded-xl text-xs font-black italic" required value={formData.firstName || ""} onChange={e => setFormData({ ...formData, firstName: e.target.value })} />
              </div>
              <div className="space-y-2">
                <Label htmlFor="lastName" className="text-[10px] font-black text-slate-500 italic">{t("client.src.last_name")}</Label>
                <Input id="lastName" placeholder={t("client.src.last_name")} className="bg-black/40 border-white/5 h-12 rounded-xl text-xs font-black italic" required value={formData.lastName || ""} onChange={e => setFormData({ ...formData, lastName: e.target.value })} />
              </div>
              <div className="space-y-2">
                <Label htmlFor="email" className="text-[10px] font-black text-slate-500 italic">{t("client.src.comms_encryption")}</Label>
                <Input id="email" type="email" placeholder={t("client.src.email_address")} className="bg-black/40 border-white/5 h-12 rounded-xl text-xs font-black italic" required value={formData.email || ""} onChange={e => setFormData({ ...formData, email: e.target.value })} />
              </div>
              <div className="space-y-2">
                <Label htmlFor="phone" className="text-[10px] font-black text-slate-500 italic">{t("client.src.vocal_uplink")}</Label>
                <Input id="phone" placeholder={t("client.src.phone_number")} className="bg-black/40 border-white/5 h-12 rounded-xl text-xs font-black italic" value={formData.phone || ""} onChange={e => setFormData({ ...formData, phone: e.target.value })} />
              </div>
              <div className="space-y-2">
                <Label htmlFor="source" className="text-[10px] font-black text-slate-500 italic">{t("client.src.origin_node")}</Label>
                <Select value={formData.source} onValueChange={v => setFormData({ ...formData, source: v })}>
                  <SelectTrigger className="bg-black/40 border-white/5 h-12 rounded-xl text-xs font-black italic">
                    <SelectValue placeholder={t("client.src.select_origin")} />
                  </SelectTrigger>
                  <SelectContent className="bg-[#1a1b1e] border-white/10">
                    <SelectItem value="website">{t("client.src.website")}</SelectItem>
                    <SelectItem value="referral">{t("client.src.referral")}</SelectItem>
                    <SelectItem value="open_house">{t("client.src.open_house")}</SelectItem>
                    <SelectItem value="social">{t("client.src.social_media")}</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <div className="space-y-2">
                <Label htmlFor="budget" className="text-[10px] font-black text-slate-500 italic">{t("client.src.fiscal_budget")}</Label>
                <Input id="budget" type="number" placeholder={t("client.src.budget")} className="bg-black/40 border-white/5 h-12 rounded-xl text-xs font-black italic" value={formData.budget || ""} onChange={e => setFormData({ ...formData, budget: Number(e.target.value) })} />
              </div>
              <div className="md:col-span-2 space-y-2">
                <Label htmlFor="notes" className="text-[10px] font-black text-slate-500 italic">{t("client.src.intelligence_logs")}</Label>
                <Textarea id="notes" placeholder={t("client.src.enter_intel_summary")} rows={3} className="bg-black/40 border-white/5 rounded-xl text-xs font-black italic" value={formData.notes || ""} onChange={e => setFormData({ ...formData, notes: e.target.value })} />
              </div>
            </div>
            <DialogFooter className="mt-10 gap-4">
              <Button type="button" variant="outline" className="flex-1 h-16 rounded-xl border-white/10 bg-white/5 text-slate-500 font-black italic text-xs" onClick={() => setCreateOpen(false)}>{t("client.src.abort_protocol")}</Button>
              <Button type="submit" className="flex-1 h-16 rounded-xl bg-blue-600 hover:bg-blue-500 text-white font-black italic text-xs shadow-xl shadow-blue-600/20">{t("client.src.materialize_node")}</Button>
            </DialogFooter>
          </form>
        </DialogContent>
      </Dialog>
      
      {/* Edit Dialog follows same pattern */}
      <Dialog open={editOpen} onOpenChange={setEditOpen}>
          <DialogContent className="max-w-2xl bg-[#1a1b1e] border-white/10 text-white rounded-[32px] p-10">
            <DialogHeader>
              <DialogTitle className="text-2xl font-black italic tracking-tighter text-blue-500">{t("client.src.recalibrate_entity_node")}</DialogTitle>
              <DialogDescription className="text-[10px] font-bold text-slate-500 italic tracking-widest">{t("client.src.update_entity_metadata_within")}</DialogDescription>
            </DialogHeader>
            {selectedLead && <form onSubmit={handleEdit} className="mt-8">
                <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                  <div className="space-y-2">
                    <Label className="text-[10px] font-black text-slate-500 italic">{t("client.src.first_signature")}</Label>
                    <Input value={formData.firstName || selectedLead.firstName || ""} onChange={e => setFormData({ ...formData, firstName: e.target.value })} className="bg-black/40 border-white/5 h-12 rounded-xl text-xs font-black italic" />
                  </div>
                  <div className="space-y-2">
                    <Label className="text-[10px] font-black text-slate-500 italic">{t("client.src.last_signature")}</Label>
                    <Input value={formData.lastName || selectedLead.lastName || ""} onChange={e => setFormData({ ...formData, lastName: e.target.value })} className="bg-black/40 border-white/5 h-12 rounded-xl text-xs font-black italic" />
                  </div>
                  <div className="space-y-2">
                    <Label className="text-[10px] font-black text-slate-500 italic">{t("client.src.email")}</Label>
                    <Input value={formData.email || selectedLead.email || ""} onChange={e => setFormData({ ...formData, email: e.target.value })} className="bg-black/40 border-white/5 h-12 rounded-xl text-xs font-black italic" />
                  </div>
                  <div className="space-y-2">
                    <Label className="text-[10px] font-black text-slate-500 italic">{t("client.src.phone")}</Label>
                    <Input value={formData.phone || selectedLead.phone || ""} onChange={e => setFormData({ ...formData, phone: e.target.value })} className="bg-black/40 border-white/5 h-12 rounded-xl text-xs font-black italic" />
                  </div>
                  <div className="md:col-span-2 space-y-2">
                    <Label className="text-[10px] font-black text-slate-500 italic">{t("client.src.intelligence_summary")}</Label>
                    <Textarea value={formData.notes || selectedLead.notes || ""} onChange={e => setFormData({ ...formData, notes: e.target.value })} rows={3} className="bg-black/40 border-white/5 rounded-xl text-xs font-black italic" />
                  </div>
                </div>
                <DialogFooter className="mt-10">
                   <Button type="submit" className="w-full h-16 rounded-xl bg-white text-black hover:bg-slate-200 font-black italic tracking-widest text-xs">{t("client.src.synchronize_changes")}</Button>
                </DialogFooter>
              </form>}
          </DialogContent>
      </Dialog>
    </PageShell>;
}