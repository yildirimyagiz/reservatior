"use client";

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
import { Users, DollarSign, Calendar, Clock, CheckCircle, XCircle, AlertTriangle, Plus, Search, Filter, MoreHorizontal, Edit, Trash2, Loader2 } from "lucide-react";
import { m, AnimatePresence } from "framer-motion";
import { cn } from "@/lib/utils";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { propertyOffersApi, PropertyOffer as ApiPropertyOffer } from "@/lib/api/property-offers";

interface PropertyOffer extends ApiPropertyOffer {
  applicantName?: string;
  applicantEmail?: string;
  propertyName?: string;
  depositAmount?: number;
  expiryDate?: string;
  conditions?: string;
}

const STATUS_CONFIG = {
  PENDING: { label: t("common.processing"), icon: Clock, cls: "bg-yellow-100 text-yellow-700" },
  ACCEPTED: { label: t("common.accepted"), icon: CheckCircle, cls: "bg-blue-100 text-blue-700" },
  REJECTED: { label: t("common.rejected"), icon: XCircle, cls: "bg-red-100 text-red-700" },
  WITHDRAWN: { label: t("client.src.withdrawn"), icon: AlertTriangle, cls: "bg-gray-100 text-gray-700" },
  COUNTERED: { label: t("client.src.countered"), icon: AlertTriangle, cls: "bg-orange-100 text-orange-700" }
};

export default function PropertyOffers() {
  const { t } = useTranslation();
  const { toast } = useToast();
  const queryClient = useQueryClient();
  const [search, setSearch] = useState("");
  const [filterStatus, setFilterStatus] = useState("all");
  const [createOpen, setCreateOpen] = useState(false);
  const [editOpen, setEditOpen] = useState(false);
  const [selectedOffer, setSelectedOffer] = useState<PropertyOffer | null>(null);
  const [formData, setFormData] = useState<Partial<PropertyOffer>>({});

  // Fetch from real API
  const { data: offersResponse, isLoading } = useQuery({
    queryKey: ['property-offers'],
    queryFn: () => propertyOffersApi.getAll()
  });
  const offers = (Array.isArray(offersResponse) ? offersResponse : (offersResponse as any)?.data) || [];

  const createMutation = useMutation({
    mutationFn: (data: Partial<PropertyOffer>) => propertyOffersApi.create(data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['property-offers'] });
      toast({ title: t("client.src.offer_created") });
      setCreateOpen(false);
      setFormData({});
    },
    onError: () => {
      toast({ title: t("common.error"), variant: "destructive" });
    }
  });

  const updateMutation = useMutation({
    mutationFn: ({ id, data }: { id: string; data: Partial<PropertyOffer> }) => propertyOffersApi.update(id, data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['property-offers'] });
      toast({ title: t("client.src.offer_updated") });
      setEditOpen(false);
      setSelectedOffer(null);
    },
    onError: () => {
      toast({ title: t("common.error"), variant: "destructive" });
    }
  });

  const deleteMutation = useMutation({
    mutationFn: (id: string) => propertyOffersApi.delete(id),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['property-offers'] });
      toast({ title: t("client.src.offer_deleted") });
    },
    onError: () => {
      toast({ title: t("common.error"), variant: "destructive" });
    }
  });

  const filtered = offers.filter((offer: any) => {
    const applicantName = offer.applicantName || "";
    const propertyName = offer.propertyName || "";
    const matchesSearch = applicantName.toLowerCase().includes(search.toLowerCase()) || 
                         propertyName.toLowerCase().includes(search.toLowerCase());
    const matchesStatus = filterStatus === "all" || offer.status === filterStatus;
    return matchesSearch && matchesStatus;
  });

  const handleCreate = (e: React.FormEvent) => {
    e.preventDefault();
    createMutation.mutate(formData);
  };

  const handleEdit = (e: React.FormEvent) => {
    e.preventDefault();
    if (selectedOffer) {
      updateMutation.mutate({ id: selectedOffer.id, data: formData });
    }
  };

  const handleDelete = (id: string) => {
    if (confirm("Are you sure?")) {
      deleteMutation.mutate(id);
    }
  };

  if (isLoading) {
    return (
      <PageShell title={t("client.src.property_offers")} description={t("client.src.streamlined_offer_submission_and")}>
        <div className="flex items-center justify-center h-64">
          <Loader2 className="w-8 h-8 animate-spin text-muted-foreground" />
        </div>
      </PageShell>
    );
  }

  return (
    <PageShell 
      title={t("client.src.property_offers")} 
      description={t("client.src.streamlined_offer_submission_and")}
      createLabel="Create Offer"
      onCreateClick={() => {
        setFormData({});
        setCreateOpen(true);
      }}
      searchValue={search}
      onSearchChange={setSearch}
      searchPlaceholder="Search offers..."
      stats={[
        { label: t("common.total"), value: offers.length },
        { label: t("common.processing"), value: offers.filter((o: any) => o.status === 'PENDING').length },
        { label: t("common.accepted"), value: offers.filter((o: any) => o.status === 'ACCEPTED').length },
        { label: t("client.src.total_value"), value: `$${offers.reduce((sum: number, o: any) => sum + (o.offerAmount || 0), 0).toLocaleString()}` }
      ]}
    >
      <div className="space-y-6">
        {/* Filters */}
        <div className="flex items-center gap-4">
          <Select value={filterStatus} onValueChange={setFilterStatus}>
            <SelectTrigger className="w-40">
              <SelectValue placeholder={t("common.status")} />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="all">{t("common.all")}</SelectItem>
              <SelectItem value="PENDING">{t("common.processing")}</SelectItem>
              <SelectItem value="ACCEPTED">{t("common.accepted")}</SelectItem>
              <SelectItem value="REJECTED">{t("common.rejected")}</SelectItem>
              <SelectItem value="WITHDRAWN">{t("client.src.withdrawn")}</SelectItem>
            </SelectContent>
          </Select>
        </div>

        {/* Offers Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          <AnimatePresence mode="popLayout">
            {filtered.map((offer: PropertyOffer, idx: number) => (
              <m.div
                key={offer.id}
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                exit={{ opacity: 0, scale: 0.95 }}
                transition={{ delay: idx * 0.05 }}
              >
                <Card className="hover:shadow-lg transition-shadow">
                  <CardContent className="p-6">
                    <div className="flex justify-between items-start mb-4">
                      <Badge className={STATUS_CONFIG[(offer.status || 'PENDING') as keyof typeof STATUS_CONFIG]?.cls || STATUS_CONFIG.PENDING.cls}>
                        {STATUS_CONFIG[(offer.status || 'PENDING') as keyof typeof STATUS_CONFIG]?.label || offer.status || "PENDING"}
                      </Badge>
                    </div>
                    <h3 className="text-lg font-semibold mb-2">{offer.applicantName || "Unknown"}</h3>
                    <p className="text-sm text-muted-foreground mb-4">{offer.propertyName || "Unknown Property"}</p>
                    <div className="space-y-2 text-sm">
                      <div className="flex items-center gap-2">
                        <DollarSign className="w-4 h-4" />
                        <span className="font-semibold">${(offer.offerAmount || 0).toLocaleString()}</span>
                      </div>
                      {offer.depositAmount && (
                        <div className="flex items-center gap-2">
                          <span className="text-muted-foreground">Deposit:</span>
                          <span>${offer.depositAmount.toLocaleString()}</span>
                        </div>
                      )}
                      <div className="flex items-center gap-2">
                        <Calendar className="w-4 h-4" />
                        <span>{new Date(offer.offerDate || new Date()).toLocaleDateString()}</span>
                      </div>
                      {offer.expiryDate && (
                        <div className="flex items-center gap-2">
                          <Clock className="w-4 h-4" />
                          <span>Expires: {new Date(offer.expiryDate).toLocaleDateString()}</span>
                        </div>
                      )}
                    </div>
                    <div className="flex gap-2 mt-4">
                      <Button
                        size="sm"
                        variant="outline"
                        className="flex-1"
                        onClick={() => {
                          setSelectedOffer(offer);
                          setFormData(offer);
                          setEditOpen(true);
                        }}
                      >
                        <Edit className="w-4 h-4 mr-2" />
                        Edit
                      </Button>
                      <Button
                        size="sm"
                        variant="outline"
                        onClick={() => handleDelete(offer.id)}
                       aria-label={t("common.delete")}>
                        <Trash2 className="w-4 h-4" />
                      </Button>
                    </div>
                  </CardContent>
                </Card>
              </m.div>
            ))}
          </AnimatePresence>
        </div>
      </div>

      {/* Create Dialog */}
      <Dialog open={createOpen} onOpenChange={setCreateOpen}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>{t("client.src.create_offer")}</DialogTitle>
            <DialogDescription>{t("client.src.create_new_property_offer")}</DialogDescription>
          </DialogHeader>
          <form onSubmit={handleCreate} className="space-y-4">
            <div>
              <Label>{t("client.src.applicant_name")}</Label>
              <Input
                value={formData.applicantName || ""}
                onChange={e => setFormData({ ...formData, applicantName: e.target.value })}
              />
            </div>
            <div>
              <Label>{t("client.src.applicant_email")}</Label>
              <Input
                type="email"
                value={formData.applicantEmail || ""}
                onChange={e => setFormData({ ...formData, applicantEmail: e.target.value })}
              />
            </div>
            <div className="grid grid-cols-2 gap-4">
              <div>
                <Label>{t("client.src.offer_amount")}</Label>
                <Input
                  type="number"
                  value={formData.offerAmount || ""}
                  onChange={e => setFormData({ ...formData, offerAmount: Number(e.target.value) })}
                />
              </div>
              <div>
                <Label>{t("client.src.deposit_amount")}</Label>
                <Input
                  type="number"
                  value={formData.depositAmount || ""}
                  onChange={e => setFormData({ ...formData, depositAmount: Number(e.target.value) })}
                />
              </div>
            </div>
            <div className="grid grid-cols-2 gap-4">
              <div>
                <Label>{t("client.src.offer_date")}</Label>
                <Input
                  type="date"
                  value={formData.offerDate || ""}
                  onChange={e => setFormData({ ...formData, offerDate: e.target.value })}
                />
              </div>
              <div>
                <Label>{t("common.expiry_date")}</Label>
                <Input
                  type="date"
                  value={formData.expiryDate || ""}
                  onChange={e => setFormData({ ...formData, expiryDate: e.target.value })}
                />
              </div>
            </div>
            <div>
              <Label>{t("client.src.conditions")}</Label>
              <Textarea
                value={formData.conditions || ""}
                onChange={e => setFormData({ ...formData, conditions: e.target.value })}
              />
            </div>
            <DialogFooter>
              <Button type="button" variant="outline" onClick={() => setCreateOpen(false)}>
                Cancel
              </Button>
              <Button type="submit">{t("common.create")}</Button>
            </DialogFooter>
          </form>
        </DialogContent>
      </Dialog>

      {/* Edit Dialog */}
      <Dialog open={editOpen} onOpenChange={setEditOpen}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>{t("client.src.edit_offer")}</DialogTitle>
          </DialogHeader>
          <form onSubmit={handleEdit} className="space-y-4">
            <div>
              <Label>{t("common.status")}</Label>
              <Select
                value={formData.status || "PENDING"}
                onValueChange={v => setFormData({ ...formData, status: v as any })}
              >
                <SelectTrigger>
                  <SelectValue />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="PENDING">{t("common.processing")}</SelectItem>
                  <SelectItem value="ACCEPTED">{t("common.accepted")}</SelectItem>
                  <SelectItem value="REJECTED">{t("common.rejected")}</SelectItem>
                  <SelectItem value="WITHDRAWN">{t("client.src.withdrawn")}</SelectItem>
                  <SelectItem value="COUNTERED">{t("client.src.countered")}</SelectItem>
                </SelectContent>
              </Select>
            </div>
            <div className="grid grid-cols-2 gap-4">
              <div>
                <Label>{t("client.src.offer_amount")}</Label>
                <Input
                  type="number"
                  value={formData.offerAmount || ""}
                  onChange={e => setFormData({ ...formData, offerAmount: Number(e.target.value) })}
                />
              </div>
              <div>
                <Label>{t("client.src.deposit_amount")}</Label>
                <Input
                  type="number"
                  value={formData.depositAmount || ""}
                  onChange={e => setFormData({ ...formData, depositAmount: Number(e.target.value) })}
                />
              </div>
            </div>
            <div>
              <Label>{t("client.src.conditions")}</Label>
              <Textarea
                value={formData.conditions || ""}
                onChange={e => setFormData({ ...formData, conditions: e.target.value })}
              />
            </div>
            <div>
              <Label>{t("common.notes")}</Label>
              <Textarea
                value={formData.notes || ""}
                onChange={e => setFormData({ ...formData, notes: e.target.value })}
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