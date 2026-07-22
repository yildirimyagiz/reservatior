"use client";

import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import {
  Users,
  Search,
  Plus,
  Edit,
  Trash2,
  Star,
  TrendingUp,
  DollarSign,
  Award,
} from "lucide-react";
import { m } from "framer-motion";
import { useTranslation } from "react-i18next";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogDescription,
  DialogFooter,
} from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { useCommerceAgentsStore } from "@/lib/store/commerce-agents-store";

const STATUSES = ["ACTIVE", "INACTIVE", "PENDING", "SUSPENDED", "BANNED"];

const STATUS_COLORS: Record<string, string> = {
  ACTIVE: "bg-green-500/20 text-green-400",
  INACTIVE: "bg-gray-500/20 text-gray-400",
  PENDING: "bg-amber-500/20 text-amber-400",
  SUSPENDED: "bg-orange-500/20 text-orange-400",
  BANNED: "bg-red-500/20 text-red-400",
};

const mockAgents = [
  { id: "1", orgId: "org1", userId: "u1", name: "Alex Morgan", email: "alex@realty.com", phone: "+1-555-0101", imageUrl: "", licenseNumber: "AGT-001", agencyName: "Premier Realty", specializations: ["LUXURY", "COMMERCIAL"], baseCommissionRate: 12, totalSales: 47, totalRevenue: 589999, averageRating: 4.8, status: "ACTIVE", joinedAt: "2025-06-15", metadata: {}, createdAt: "2025-06-15", updatedAt: "2026-02-10" },
  { id: "2", orgId: "org1", userId: "u2", name: "Jordan Lee", email: "jordan@realty.com", phone: "+1-555-0102", imageUrl: "", licenseNumber: "AGT-002", agencyName: "Metro Properties", specializations: ["RESIDENTIAL", "STAGING"], baseCommissionRate: 10, totalSales: 32, totalRevenue: 349999, averageRating: 4.5, status: "ACTIVE", joinedAt: "2025-08-01", metadata: {}, createdAt: "2025-08-01", updatedAt: "2026-02-01" },
  { id: "3", orgId: "org1", userId: "u3", name: "Sam Williams", email: "sam@realty.com", phone: "+1-555-0103", imageUrl: "", licenseNumber: "AGT-003", agencyName: "Home Star", specializations: ["RESIDENTIAL"], baseCommissionRate: 8, totalSales: 19, totalRevenue: 159999, averageRating: 4.2, status: "ACTIVE", joinedAt: "2025-10-15", metadata: {}, createdAt: "2025-10-15", updatedAt: "2026-01-20" },
  { id: "4", orgId: "org1", userId: "u4", name: "Taylor Swift", email: "taylor@realty.com", phone: "+1-555-0104", imageUrl: "", licenseNumber: "AGT-004", agencyName: "Swift Homes", specializations: ["INVESTMENT", "LUXURY"], baseCommissionRate: 15, totalSales: 8, totalRevenue: 89999, averageRating: 4.9, status: "PENDING", joinedAt: "2026-01-20", metadata: {}, createdAt: "2026-01-20", updatedAt: "2026-02-10" },
];

function StarRating({ rating }: { rating: number }) {
  return (
    <div className="flex items-center gap-0.5">
      {[1, 2, 3, 4, 5].map((i) => (
        <Star
          key={i}
          className={`w-3.5 h-3.5 ${
            i <= Math.round(rating)
              ? "fill-amber-400 text-amber-400"
              : "text-muted-foreground"
          }`}
        />
      ))}
      <span className="ml-1 text-xs text-muted-foreground">{rating}</span>
    </div>
  );
}

export default function CommerceAgentsPage() {
  const { t } = useTranslation();
  const [searchTerm, setSearchTerm] = useState("");
  const [statusFilter, setStatusFilter] = useState("all");
  const [isCreateOpen, setIsCreateOpen] = useState(false);
  const [editingItem, setEditingItem] = useState<any>(null);
  const [isEditOpen, setIsEditOpen] = useState(false);
  const [deletingItem, setDeletingItem] = useState<any>(null);
  const [isDeleteOpen, setIsDeleteOpen] = useState(false);

  const filtered = mockAgents.filter((a) => {
    const matchesSearch =
      a.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
      a.email.toLowerCase().includes(searchTerm.toLowerCase()) ||
      a.licenseNumber.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesStatus = statusFilter === "all" || a.status === statusFilter;
    return matchesSearch && matchesStatus;
  });

  const totalAgents = mockAgents.length;
  const activeAgents = mockAgents.filter((a) => a.status === "ACTIVE").length;
  const totalRevenue = mockAgents.reduce((sum, a) => sum + a.totalRevenue, 0);
  const avgRating =
    mockAgents.reduce((sum, a) => sum + a.averageRating, 0) / mockAgents.length;

  return (
    <div className="min-h-screen bg-background">
      <div className="container mx-auto px-4 py-8">
        <m.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="mb-8"
        >
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-foreground mb-2">
                {t("admin_commerce_agents_title", "Commerce Agents")}
              </h1>
              <p className="text-muted-foreground">
                {t(
                  "admin_commerce_agents_description",
                  "Manage agents, performance, and commission rates"
                )}
              </p>
            </div>
          </div>
        </m.div>

        {/* Summary Cards */}
        <m.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
          className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 mb-6"
        >
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-blue-500/10">
                  <Users className="w-5 h-5 text-blue-500" />
                </div>
                <div>
                  <p className="text-sm text-muted-foreground">
                    {t("admin_commerce_agents_total", "Total Agents")}
                  </p>
                  <p className="text-2xl font-bold text-foreground">
                    {totalAgents}
                  </p>
                </div>
              </div>
            </CardContent>
          </Card>
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-green-500/10">
                  <TrendingUp className="w-5 h-5 text-green-500" />
                </div>
                <div>
                  <p className="text-sm text-muted-foreground">
                    {t("admin_commerce_agents_active", "Active")}
                  </p>
                  <p className="text-2xl font-bold text-foreground">
                    {activeAgents}
                  </p>
                </div>
              </div>
            </CardContent>
          </Card>
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-amber-500/10">
                  <DollarSign className="w-5 h-5 text-amber-500" />
                </div>
                <div>
                  <p className="text-sm text-muted-foreground">
                    {t(
                      "admin_commerce_agents_total_revenue",
                      "Total Revenue"
                    )}
                  </p>
                  <p className="text-2xl font-bold text-foreground">
                    ${totalRevenue.toLocaleString()}
                  </p>
                </div>
              </div>
            </CardContent>
          </Card>
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-purple-500/10">
                  <Award className="w-5 h-5 text-purple-500" />
                </div>
                <div>
                  <p className="text-sm text-muted-foreground">
                    {t("admin_commerce_agents_avg_rating", "Avg Rating")}
                  </p>
                  <p className="text-2xl font-bold text-foreground">
                    {avgRating.toFixed(1)}
                  </p>
                </div>
              </div>
            </CardContent>
          </Card>
        </m.div>

        {/* Search and Filters */}
        <m.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.15 }}
          className="mb-6"
        >
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex gap-4 flex-wrap">
                <div className="flex-1 min-w-[200px]">
                  <div className="relative">
                    <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
                    <Input
                      placeholder={t(
                        "admin_commerce_agents_search_placeholder",
                        "Search by name, email, or license..."
                      )}
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors placeholder:text-muted-foreground"
                    />
                  </div>
                </div>
                <Select value={statusFilter} onValueChange={setStatusFilter}>
                  <SelectTrigger className="w-[180px] bg-white/5 border-white/10 text-foreground">
                    <SelectValue
                      placeholder={t(
                        "admin_commerce_agents_status",
                        "Status"
                      )}
                    />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="all">
                      {t("admin_commerce_agents_all_status", "All Status")}
                    </SelectItem>
                    {STATUSES.map((s) => (
                      <SelectItem key={s} value={s}>
                        {s}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
                <Button
                  onClick={() => setIsCreateOpen(true)}
                  className="bg-primary hover:bg-primary/90"
                >
                  <Plus className="w-4 h-4 mr-2" />
                  {t("admin_commerce_agents_add", "Add Agent")}
                </Button>
              </div>
            </CardContent>
          </Card>
        </m.div>

        {/* Agents Table */}
        <m.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2 }}
        >
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground flex items-center gap-2">
                <Users className="w-5 h-5" />
                {t("admin_commerce_agents_list_title", "Agents")} (
                {filtered.length})
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="overflow-x-auto">
                <table className="w-full text-sm">
                  <thead>
                    <tr className="border-b border-border">
                      <th className="text-left py-3 px-4 text-muted-foreground font-medium">
                        {t("admin_commerce_agents_name", "Agent")}
                      </th>
                      <th className="text-left py-3 px-4 text-muted-foreground font-medium">
                        {t("admin_commerce_agents_agency", "Agency")}
                      </th>
                      <th className="text-left py-3 px-4 text-muted-foreground font-medium">
                        {t("admin_commerce_agents_license", "License")}
                      </th>
                      <th className="text-right py-3 px-4 text-muted-foreground font-medium">
                        {t("admin_commerce_agents_commission", "Rate")}
                      </th>
                      <th className="text-right py-3 px-4 text-muted-foreground font-medium">
                        {t("admin_commerce_agents_sales", "Sales")}
                      </th>
                      <th className="text-right py-3 px-4 text-muted-foreground font-medium">
                        {t("admin_commerce_agents_revenue", "Revenue")}
                      </th>
                      <th className="text-left py-3 px-4 text-muted-foreground font-medium">
                        {t("admin_commerce_agents_rating", "Rating")}
                      </th>
                      <th className="text-left py-3 px-4 text-muted-foreground font-medium">
                        {t("admin_commerce_agents_status_col", "Status")}
                      </th>
                      <th className="text-right py-3 px-4 text-muted-foreground font-medium">
                        {t("admin_commerce_agents_actions", "Actions")}
                      </th>
                    </tr>
                  </thead>
                  <tbody>
                    {filtered.map((agent) => (
                      <tr
                        key={agent.id}
                        className="border-b border-border/50 hover:bg-muted/30 transition-colors"
                      >
                        <td className="py-3 px-4">
                          <div className="text-foreground font-medium">
                            {agent.name}
                          </div>
                          <div className="text-xs text-muted-foreground">
                            {agent.email}
                          </div>
                        </td>
                        <td className="py-3 px-4 text-muted-foreground">
                          {agent.agencyName}
                        </td>
                        <td className="py-3 px-4 text-muted-foreground font-mono text-xs">
                          {agent.licenseNumber}
                        </td>
                        <td className="py-3 px-4 text-right font-medium text-foreground">
                          {agent.baseCommissionRate}%
                        </td>
                        <td className="py-3 px-4 text-right text-foreground">
                          {agent.totalSales}
                        </td>
                        <td className="py-3 px-4 text-right font-medium text-foreground">
                          ${agent.totalRevenue.toLocaleString()}
                        </td>
                        <td className="py-3 px-4">
                          <StarRating rating={agent.averageRating} />
                        </td>
                        <td className="py-3 px-4">
                          <Badge className={STATUS_COLORS[agent.status]}>
                            {agent.status}
                          </Badge>
                        </td>
                        <td className="py-3 px-4">
                          <div className="flex justify-end gap-2">
                            <Button
                              onClick={() => {
                                setEditingItem(agent);
                                setIsEditOpen(true);
                              }}
                              variant="ghost"
                              size="icon"
                              className="min-h-10 min-w-10 h-10 w-10"
                            >
                              <Edit className="w-4 h-4" />
                            </Button>
                            <Button
                              onClick={() => {
                                setDeletingItem(agent);
                                setIsDeleteOpen(true);
                              }}
                              variant="ghost"
                              size="icon"
                              className="min-h-10 min-w-10 h-10 w-10 text-red-400"
                            >
                              <Trash2 className="w-4 h-4" />
                            </Button>
                          </div>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </CardContent>
          </Card>
        </m.div>

        {/* Create Dialog */}
        <CreateAgentDialog
          open={isCreateOpen}
          onOpenChange={setIsCreateOpen}
        />
        {editingItem && (
          <EditAgentDialog
            open={isEditOpen}
            onOpenChange={setIsEditOpen}
            item={editingItem}
          />
        )}
        {deletingItem && (
          <DeleteAgentDialog
            open={isDeleteOpen}
            onOpenChange={setIsDeleteOpen}
            item={deletingItem}
            onConfirm={() => setIsDeleteOpen(false)}
          />
        )}
      </div>
    </div>
  );
}

function CreateAgentDialog({
  open,
  onOpenChange,
}: {
  open: boolean;
  onOpenChange: (open: boolean) => void;
}) {
  const { t } = useTranslation();
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [agencyName, setAgencyName] = useState("");
  const [licenseNumber, setLicenseNumber] = useState("");
  const [commissionRate, setCommissionRate] = useState("");

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[600px] bg-background/80 backdrop-blur-xl border border-white/10 shadow-2xl text-foreground max-h-[90vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">
            {t("admin_commerce_agents_create_title", "Add Agent")}
          </DialogTitle>
          <DialogDescription className="text-muted-foreground">
            {t(
              "admin_commerce_agents_create_desc",
              "Register a new commerce agent."
            )}
          </DialogDescription>
        </DialogHeader>
        <div className="grid gap-4 py-4">
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">
              {t("admin_commerce_agents_name", "Name")}
            </Label>
            <Input
              value={name}
              onChange={(e) => setName(e.target.value)}
              className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors"
            />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">
              {t("admin_commerce_agents_email", "Email")}
            </Label>
            <Input
              type="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors"
            />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">
              {t("admin_commerce_agents_agency", "Agency")}
            </Label>
            <Input
              value={agencyName}
              onChange={(e) => setAgencyName(e.target.value)}
              className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors"
            />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">
              {t("admin_commerce_agents_license", "License #")}
            </Label>
            <Input
              value={licenseNumber}
              onChange={(e) => setLicenseNumber(e.target.value)}
              className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors"
            />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">
              {t("admin_commerce_agents_commission", "Commission %")}
            </Label>
            <Input
              type="number"
              value={commissionRate}
              onChange={(e) => setCommissionRate(e.target.value)}
              className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors"
            />
          </div>
        </div>
        <DialogFooter className="pt-4 border-t border-white/10">
          <Button
            variant="outline"
            onClick={() => onOpenChange(false)}
            className="border-border text-foreground"
          >
            {t("admin_action_cancel", "Cancel")}
          </Button>
          <Button
            onClick={() => onOpenChange(false)}
            className="bg-primary hover:bg-primary/90"
          >
            {t("admin_action_create", "Create")}
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

function EditAgentDialog({
  open,
  onOpenChange,
  item,
}: {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  item: any;
}) {
  const { t } = useTranslation();
  const [name, setName] = useState(item.name);
  const [agencyName, setAgencyName] = useState(item.agencyName);
  const [commissionRate, setCommissionRate] = useState(
    String(item.baseCommissionRate)
  );

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[600px] bg-background/80 backdrop-blur-xl border border-white/10 shadow-2xl text-foreground max-h-[90vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">
            {t("admin_commerce_agents_edit_title", "Edit Agent")}
          </DialogTitle>
          <DialogDescription className="text-muted-foreground">
            {t("admin_commerce_agents_edit_desc", "Update agent details.")}
          </DialogDescription>
        </DialogHeader>
        <div className="grid gap-4 py-4">
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">
              {t("admin_commerce_agents_name", "Name")}
            </Label>
            <Input
              value={name}
              onChange={(e) => setName(e.target.value)}
              className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors"
            />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">
              {t("admin_commerce_agents_agency", "Agency")}
            </Label>
            <Input
              value={agencyName}
              onChange={(e) => setAgencyName(e.target.value)}
              className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors"
            />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">
              {t("admin_commerce_agents_commission", "Commission %")}
            </Label>
            <Input
              type="number"
              value={commissionRate}
              onChange={(e) => setCommissionRate(e.target.value)}
              className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors"
            />
          </div>
        </div>
        <DialogFooter className="pt-4 border-t border-white/10">
          <Button
            variant="outline"
            onClick={() => onOpenChange(false)}
            className="border-border text-foreground"
          >
            {t("admin_action_cancel", "Cancel")}
          </Button>
          <Button
            onClick={() => onOpenChange(false)}
            className="bg-primary hover:bg-primary/90"
          >
            {t("admin_action_save", "Save")}
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

function DeleteAgentDialog({
  open,
  onOpenChange,
  item,
  onConfirm,
}: {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  item: any;
  onConfirm: () => void;
}) {
  const { t } = useTranslation();
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[425px] bg-background/80 backdrop-blur-xl border border-white/10 shadow-2xl text-foreground">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">
            {t("admin_commerce_agents_delete_title", "Delete Agent")}
          </DialogTitle>
          <DialogDescription className="text-muted-foreground">
            {t(
              "admin_commerce_agents_delete_desc",
              "Are you sure you want to delete"
            )}
            {item.name}
            {t(
              "admin_auto_this_action_cannot_be_undone",
              "? This action cannot be undone."
            )}
          </DialogDescription>
        </DialogHeader>
        <DialogFooter className="pt-4 border-t border-white/10">
          <Button
            variant="outline"
            onClick={() => onOpenChange(false)}
            className="border-border text-foreground"
          >
            {t("admin_action_cancel", "Cancel")}
          </Button>
          <Button
            onClick={onConfirm}
            className="bg-red-500 hover:bg-red-600 text-white shadow-lg shadow-red-500/20"
          >
            {t("admin_action_delete", "Delete")}
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
