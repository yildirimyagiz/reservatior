import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { PageShell } from "../layout/PageShell";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Card, CardContent } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription, DialogFooter } from "@/components/ui/dialog";
import { Textarea } from "@/components/ui/textarea";
import { useToast } from "@/hooks/use-toast";
import { Wrench, Calendar, Clock, AlertTriangle, CheckCircle, Plus, Search, Filter, MoreHorizontal, Edit, Trash2, Loader2 } from "lucide-react";
import { motion, AnimatePresence } from "framer-motion";
import { cn } from "@/lib/utils";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { maintenanceBlocksApi, MaintenanceBlock as ApiMaintenanceBlock } from "@/lib/api/maintenance-blocks";

interface MaintenanceBlock extends ApiMaintenanceBlock {
  title?: string;
  description?: string;
  priority?: 'LOW' | 'MEDIUM' | 'HIGH' | 'URGENT';
  scheduledDate?: string;
  completedDate?: string;
  estimatedCost?: number;
  actualCost?: number;
  assignedTo?: string;
}

const STATUS_CONFIG = {
  PENDING: { label: t("client.src.pending"), icon: Clock, cls: "bg-yellow-100 text-yellow-700" },
  IN_PROGRESS: { label: t("client.src.in_progress"), icon: Wrench, cls: "bg-blue-100 text-blue-700" },
  COMPLETED: { label: t("client.src.completed"), icon: CheckCircle, cls: "bg-green-100 text-green-700" },
  CANCELLED: { label: t("client.src.cancelled"), icon: AlertTriangle, cls: "bg-red-100 text-red-700" }
};

const PRIORITY_CONFIG = {
  LOW: { label: t("client.src.low"), cls: "bg-slate-100 text-slate-700" },
  MEDIUM: { label: t("client.src.medium"), cls: "bg-orange-100 text-orange-700" },
  HIGH: { label: t("client.src.high"), cls: "bg-red-100 text-red-700" },
  URGENT: { label: t("client.src.urgent"), cls: "bg-purple-100 text-purple-700" }
};

export default function MaintenanceBlocks() {
  const { t } = useTranslation();
  const { toast } = useToast();
  const queryClient = useQueryClient();
  const [search, setSearch] = useState("");
  const [filterStatus, setFilterStatus] = useState("all");
  const [filterPriority, setFilterPriority] = useState("all");
  const [createOpen, setCreateOpen] = useState(false);
  const [editOpen, setEditOpen] = useState(false);
  const [selectedBlock, setSelectedBlock] = useState<MaintenanceBlock | null>(null);
  const [formData, setFormData] = useState<Partial<MaintenanceBlock>>({});

  // Fetch from real API
  const { data: blocksResponse, isLoading } = useQuery({
    queryKey: ['maintenance-blocks'],
    queryFn: () => maintenanceBlocksApi.getAll()
  });
  const blocks = (Array.isArray(blocksResponse) ? blocksResponse : (blocksResponse as any)?.data) || [];

  const createMutation = useMutation({
    mutationFn: (data: Partial<MaintenanceBlock>) => maintenanceBlocksApi.create(data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['maintenance-blocks'] });
      toast({ title: t("client.src.maintenance_created") });
      setCreateOpen(false);
      setFormData({});
    },
    onError: () => {
      toast({ title: t("client.src.error"), variant: "destructive" });
    }
  });

  const updateMutation = useMutation({
    mutationFn: ({ id, data }: { id: string; data: Partial<MaintenanceBlock> }) => maintenanceBlocksApi.update(id, data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['maintenance-blocks'] });
      toast({ title: t("client.src.maintenance_updated") });
      setEditOpen(false);
      setSelectedBlock(null);
    },
    onError: () => {
      toast({ title: t("client.src.error"), variant: "destructive" });
    }
  });

  const deleteMutation = useMutation({
    mutationFn: (id: string) => maintenanceBlocksApi.delete(id),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['maintenance-blocks'] });
      toast({ title: t("client.src.maintenance_deleted") });
    },
    onError: () => {
      toast({ title: t("client.src.error"), variant: "destructive" });
    }
  });

  const filtered = blocks.filter((block: any) => {
    const title = block.title || block.reason || "";
    const description = block.description || "";
    const matchesSearch = title.toLowerCase().includes(search.toLowerCase()) || 
                         description.toLowerCase().includes(search.toLowerCase());
    const matchesStatus = filterStatus === "all" || block.status === filterStatus;
    const matchesPriority = filterPriority === "all" || block.priority === filterPriority;
    return matchesSearch && matchesStatus && matchesPriority;
  });

  const handleCreate = (e: React.FormEvent) => {
    e.preventDefault();
    createMutation.mutate(formData);
  };

  const handleEdit = (e: React.FormEvent) => {
    e.preventDefault();
    if (selectedBlock) {
      updateMutation.mutate({ id: selectedBlock.id, data: formData });
    }
  };

  const handleDelete = (id: string) => {
    if (confirm("Are you sure?")) {
      deleteMutation.mutate(id);
    }
  };

  if (isLoading) {
    return (
      <PageShell title={t("client.src.maintenance_blocks")} description={t("client.src.preventive_maintenance_scheduling_and")}>
        <div className="flex items-center justify-center h-64">
          <Loader2 className="w-8 h-8 animate-spin text-muted-foreground" />
        </div>
      </PageShell>
    );
  }

  return (
    <PageShell 
      title={t("client.src.maintenance_blocks")} 
      description={t("client.src.preventive_maintenance_scheduling_and")}
      createLabel="Schedule Maintenance"
      onCreateClick={() => {
        setFormData({});
        setCreateOpen(true);
      }}
      searchValue={search}
      onSearchChange={setSearch}
      searchPlaceholder="Search maintenance blocks..."
      stats={[
        { label: t("client.src.total"), value: blocks.length },
        { label: t("client.src.pending"), value: blocks.filter((b: any) => b.status === 'PENDING').length },
        { label: t("client.src.in_progress"), value: blocks.filter((b: any) => b.status === 'IN_PROGRESS').length },
        { label: t("client.src.completed"), value: blocks.filter((b: any) => b.status === 'COMPLETED').length }
      ]}
    >
      <div className="space-y-6">
        {/* Filters */}
        <div className="flex items-center gap-4">
          <Select value={filterStatus} onValueChange={setFilterStatus}>
            <SelectTrigger className="w-40">
              <SelectValue placeholder={t("client.src.status")} />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="all">{t("client.src.all")}</SelectItem>
              <SelectItem value="PENDING">{t("client.src.pending")}</SelectItem>
              <SelectItem value="IN_PROGRESS">{t("client.src.in_progress")}</SelectItem>
              <SelectItem value="COMPLETED">{t("client.src.completed")}</SelectItem>
            </SelectContent>
          </Select>
          <Select value={filterPriority} onValueChange={setFilterPriority}>
            <SelectTrigger className="w-40">
              <SelectValue placeholder={t("client.src.priority")} />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="all">{t("client.src.all")}</SelectItem>
              <SelectItem value="LOW">{t("client.src.low")}</SelectItem>
              <SelectItem value="MEDIUM">{t("client.src.medium")}</SelectItem>
              <SelectItem value="HIGH">{t("client.src.high")}</SelectItem>
              <SelectItem value="URGENT">{t("client.src.urgent")}</SelectItem>
            </SelectContent>
          </Select>
        </div>

        {/* Maintenance Blocks Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          <AnimatePresence mode="popLayout">
            {filtered.map((block: MaintenanceBlock, idx: number) => (
              <motion.div
                key={block.id}
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                exit={{ opacity: 0, scale: 0.95 }}
                transition={{ delay: idx * 0.05 }}
              >
                <Card className="hover:shadow-lg transition-shadow">
                  <CardContent className="p-6">
                    <div className="flex justify-between items-start mb-4">
                      <Badge className={PRIORITY_CONFIG[(block.priority || 'LOW') as keyof typeof PRIORITY_CONFIG]?.cls || PRIORITY_CONFIG.LOW.cls}>
                        {PRIORITY_CONFIG[(block.priority || 'LOW') as keyof typeof PRIORITY_CONFIG]?.label || block.priority || "LOW"}
                      </Badge>
                      <Badge className={STATUS_CONFIG[(block.status || 'PENDING') as keyof typeof STATUS_CONFIG]?.cls || STATUS_CONFIG.PENDING.cls}>
                        {STATUS_CONFIG[(block.status || 'PENDING') as keyof typeof STATUS_CONFIG]?.label || block.status || "PENDING"}
                      </Badge>
                    </div>
                    <h3 className="text-lg font-semibold mb-2">{block.title || block.reason || "Untitled"}</h3>
                    <p className="text-sm text-muted-foreground mb-4">{block.description || block.type || "No description"}</p>
                    <div className="space-y-2 text-sm">
                      <div className="flex items-center gap-2">
                        <Calendar className="w-4 h-4" />
                        <span>{new Date(block.scheduledDate || block.startDate || new Date()).toLocaleDateString()}</span>
                      </div>
                      {block.estimatedCost && (
                        <div className="flex items-center gap-2">
                          <span className="font-semibold">${block.estimatedCost.toLocaleString()}</span>
                        </div>
                      )}
                    </div>
                    <div className="flex gap-2 mt-4">
                      <Button
                        size="sm"
                        variant="outline"
                        className="flex-1"
                        onClick={() => {
                          setSelectedBlock(block);
                          setFormData(block);
                          setEditOpen(true);
                        }}
                      >
                        <Edit className="w-4 h-4 mr-2" />
                        Edit
                      </Button>
                      <Button
                        size="sm"
                        variant="outline"
                        onClick={() => handleDelete(block.id)}
                      >
                        <Trash2 className="w-4 h-4" />
                      </Button>
                    </div>
                  </CardContent>
                </Card>
              </motion.div>
            ))}
          </AnimatePresence>
        </div>
      </div>

      {/* Create Dialog */}
      <Dialog open={createOpen} onOpenChange={setCreateOpen}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>{t("client.src.schedule_maintenance")}</DialogTitle>
            <DialogDescription>{t("client.src.create_new_maintenance_block")}</DialogDescription>
          </DialogHeader>
          <form onSubmit={handleCreate} className="space-y-4">
            <div>
              <Label>{t("client.src.title")}</Label>
              <Input
                value={formData.title || formData.reason || ""}
                onChange={e => setFormData({ ...formData, title: e.target.value, reason: e.target.value })}
              />
            </div>
            <div>
              <Label>{t("client.src.description")}</Label>
              <Textarea
                value={formData.description || ""}
                onChange={e => setFormData({ ...formData, description: e.target.value })}
              />
            </div>
            <div className="grid grid-cols-2 gap-4">
              <div>
                <Label>{t("client.src.priority")}</Label>
                <Select
                  value={formData.priority || "LOW"}
                  onValueChange={v => setFormData({ ...formData, priority: v as any })}
                >
                  <SelectTrigger>
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="LOW">{t("client.src.low")}</SelectItem>
                    <SelectItem value="MEDIUM">{t("client.src.medium")}</SelectItem>
                    <SelectItem value="HIGH">{t("client.src.high")}</SelectItem>
                    <SelectItem value="URGENT">{t("client.src.urgent")}</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <div>
                <Label>{t("client.src.scheduled_date")}</Label>
                <Input
                  type="date"
                  value={formData.scheduledDate || formData.startDate || ""}
                  onChange={e => setFormData({ ...formData, scheduledDate: e.target.value, startDate: e.target.value })}
                />
              </div>
            </div>
            <div>
              <Label>{t("client.src.estimated_cost")}</Label>
              <Input
                type="number"
                value={formData.estimatedCost || ""}
                onChange={e => setFormData({ ...formData, estimatedCost: Number(e.target.value) })}
              />
            </div>
            <DialogFooter>
              <Button type="button" variant="outline" onClick={() => setCreateOpen(false)}>
                Cancel
              </Button>
              <Button type="submit">{t("client.src.create")}</Button>
            </DialogFooter>
          </form>
        </DialogContent>
      </Dialog>

      {/* Edit Dialog */}
      <Dialog open={editOpen} onOpenChange={setEditOpen}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>{t("client.src.edit_maintenance")}</DialogTitle>
          </DialogHeader>
          <form onSubmit={handleEdit} className="space-y-4">
            <div>
              <Label>{t("client.src.title")}</Label>
              <Input
                value={formData.title || formData.reason || ""}
                onChange={e => setFormData({ ...formData, title: e.target.value, reason: e.target.value })}
              />
            </div>
            <div>
              <Label>{t("client.src.description")}</Label>
              <Textarea
                value={formData.description || ""}
                onChange={e => setFormData({ ...formData, description: e.target.value })}
              />
            </div>
            <div className="grid grid-cols-2 gap-4">
              <div>
                <Label>{t("client.src.status")}</Label>
                <Select
                  value={formData.status || "PENDING"}
                  onValueChange={v => setFormData({ ...formData, status: v as any })}
                >
                  <SelectTrigger>
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="PENDING">{t("client.src.pending")}</SelectItem>
                    <SelectItem value="IN_PROGRESS">{t("client.src.in_progress")}</SelectItem>
                    <SelectItem value="COMPLETED">{t("client.src.completed")}</SelectItem>
                    <SelectItem value="CANCELLED">{t("client.src.cancelled")}</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <div>
                <Label>{t("client.src.priority")}</Label>
                <Select
                  value={formData.priority || "LOW"}
                  onValueChange={v => setFormData({ ...formData, priority: v as any })}
                >
                  <SelectTrigger>
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="LOW">{t("client.src.low")}</SelectItem>
                    <SelectItem value="MEDIUM">{t("client.src.medium")}</SelectItem>
                    <SelectItem value="HIGH">{t("client.src.high")}</SelectItem>
                    <SelectItem value="URGENT">{t("client.src.urgent")}</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </div>
            <div>
              <Label>{t("client.src.actual_cost")}</Label>
              <Input
                type="number"
                value={formData.actualCost || ""}
                onChange={e => setFormData({ ...formData, actualCost: Number(e.target.value) })}
              />
            </div>
            <DialogFooter>
              <Button type="submit">{t("client.src.save")}</Button>
            </DialogFooter>
          </form>
        </DialogContent>
      </Dialog>
    </PageShell>
  );
}