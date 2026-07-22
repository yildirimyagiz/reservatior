"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import {
  Scale,
  Search,
  Plus,
  Phone,
  Mail,
  Building2,
  ArrowUpRight,
  Globe,
} from "lucide-react";
import { m } from "framer-motion";
import { useTranslation } from "react-i18next";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription, DialogFooter } from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";

interface Solicitor {
  id: string;
  solicitorFirm: string;
  solicitorName: string;
  solicitorEmail: string;
  solicitorPhone?: string;
  solicitorType: "LOCAL_LEGAL_COUNSEL" | "TENANT_INTERNATIONAL_LAWYER" | "LANDLORD_REPRESENTATIVE";
  status: "ENGAGED" | "VERIFIED" | "DISPUTE_OPEN" | "COMPLETED" | "TERMINATED";
  countryCode: string;
  barRegistrationNo: string;
  legalNoticeAddress: string;
  referredByAgencyId?: string;
  appointmentType?: string;
  appointmentDate?: string;
  completionDate?: string;
}

const mockSolicitors: Solicitor[] = [
  { 
    id: "1", 
    solicitorFirm: "Smith & Co Legal", 
    solicitorName: "John Smith", 
    solicitorEmail: "john@smithlegal.com", 
    solicitorPhone: "+44 20 7123 4567", 
    solicitorType: "TENANT_INTERNATIONAL_LAWYER",
    status: "VERIFIED",
    countryCode: "GB",
    barRegistrationNo: "BAR-GB-12345",
    legalNoticeAddress: "123 Legal Street, London, UK",
    appointmentType: "INITIAL_CONSULTATION",
    appointmentDate: "2026-08-01"
  },
  { 
    id: "2", 
    solicitorFirm: "Brown & Partners", 
    solicitorName: "Sarah Brown", 
    solicitorEmail: "sarah@brownpartners.com", 
    solicitorPhone: "+44 20 7234 5678", 
    solicitorType: "LOCAL_LEGAL_COUNSEL",
    status: "ENGAGED",
    countryCode: "TR",
    barRegistrationNo: "BAR-TR-67890",
    legalNoticeAddress: "456 Hukuk Caddesi, Istanbul, Turkey",
    appointmentType: "EXCHANGE",
    appointmentDate: "2026-07-25"
  },
];

const STATUS_COLORS: Record<string, string> = {
  ENGAGED: "bg-blue-500/20 text-blue-400",
  VERIFIED: "bg-green-500/20 text-green-400",
  DISPUTE_OPEN: "bg-red-500/20 text-red-400",
  COMPLETED: "bg-emerald-500/20 text-emerald-400",
  TERMINATED: "bg-gray-500/20 text-gray-400",
};

const SOLICITOR_TYPE_COLORS: Record<string, string> = {
  LOCAL_LEGAL_COUNSEL: "bg-purple-500/20 text-purple-400",
  TENANT_INTERNATIONAL_LAWYER: "bg-orange-500/20 text-orange-400",
  LANDLORD_REPRESENTATIVE: "bg-cyan-500/20 text-cyan-400",
};

export function SolicitorManagementContent() {
    const { t } = useTranslation();
  const router = useRouter();
  const [searchTerm, setSearchTerm] = useState("");
  const [items, setItems] = useState<Solicitor[]>(mockSolicitors);
  const [isCreateOpen, setIsCreateOpen] = useState(false);

  const filtered = items.filter(s =>
    s.solicitorFirm.toLowerCase().includes(searchTerm.toLowerCase()) ||
    s.solicitorName.toLowerCase().includes(searchTerm.toLowerCase()) ||
    s.countryCode.toLowerCase().includes(searchTerm.toLowerCase()) ||
    s.barRegistrationNo.toLowerCase().includes(searchTerm.toLowerCase())
  );

  return (
    <div className="min-h-screen bg-background">
      <div className="container mx-auto px-4 py-8">
        <m.div initial={{ opacity: 0, y: -20 }} animate={{ opacity: 1, y: 0 }} className="mb-8">
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-foreground mb-2">{t("solicitor_management_title")}</h1>
              <p className="text-muted-foreground">{t("solicitor_management_description")}</p>
            </div>
            <Button onClick={() => router.push("/client/legal")} className="bg-primary hover:bg-primary/90">
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("back_to_legal")}
            </Button>
          </div>
        </m.div>

        <m.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.1 }} className="mb-6">
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex gap-4">
                <div className="flex-1">
                  <div className="relative">
                    <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
                    <Input
                      placeholder={t("search_solicitors")}
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors placeholder:text-muted-foreground"
                    />
                  </div>
                </div>
                <Button onClick={() => setIsCreateOpen(true)} className="bg-primary hover:bg-primary/90">
                  <Plus className="w-4 h-4 mr-2" />
                  {t("add_solicitor")}
                </Button>
              </div>
            </CardContent>
          </Card>
        </m.div>

        <m.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.2 }}>
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground flex items-center gap-2">
                <Scale className="w-5 h-5" />
                {t("my_solicitors")} ({filtered.length})
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {filtered.map((solicitor) => (
                  <div key={solicitor.id} className="flex items-center justify-between p-4 bg-muted/30 rounded-lg hover:bg-muted/50 transition-colors">
                    <div className="flex items-center gap-4">
                      <div className="w-10 h-10 rounded-full bg-muted/50 flex items-center justify-center">
                        <Scale className="w-5 h-5 text-muted-foreground" />
                      </div>
                      <div>
                        <div className="text-foreground font-medium">{solicitor.solicitorFirm}</div>
                        <div className="text-sm text-muted-foreground flex items-center gap-2">
                          <Building2 className="w-3 h-3" />
                          {solicitor.solicitorName}
                        </div>
                        <div className="text-xs text-muted-foreground/70 flex items-center gap-3 mt-1">
                          <span className="flex items-center gap-1"><Mail className="w-3 h-3" />{solicitor.solicitorEmail}</span>
                          <span className="flex items-center gap-1"><Phone className="w-3 h-3" />{solicitor.solicitorPhone}</span>
                          <span className="flex items-center gap-1"><Globe className="w-3 h-3" />{solicitor.countryCode}</span>
                        </div>
                        <div className="text-xs text-muted-foreground/50 mt-1">
                          Bar: {solicitor.barRegistrationNo}
                        </div>
                      </div>
                    </div>
                    <div className="flex items-center gap-4">
                      <Badge className={SOLICITOR_TYPE_COLORS[solicitor.solicitorType]}>{solicitor.solicitorType.replace(/_/g, ' ')}</Badge>
                      <Badge className={STATUS_COLORS[solicitor.status]}>{solicitor.status.replace(/_/g, ' ')}</Badge>
                    </div>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </m.div>

        {/* Create Dialog */}
        <CreateSolicitorDialog open={isCreateOpen} onOpenChange={setIsCreateOpen} />
      </div>
    </div>
  );
}

function CreateSolicitorDialog({ open, onOpenChange }: { open: boolean; onOpenChange: (open: boolean) => void }) {
    const { t } = useTranslation();
  const [solicitorFirm, setSolicitorFirm] = useState("");
  const [solicitorName, setSolicitorName] = useState("");
  const [solicitorEmail, setSolicitorEmail] = useState("");
  const [solicitorPhone, setSolicitorPhone] = useState("");
  const [solicitorType, setSolicitorType] = useState<"LOCAL_LEGAL_COUNSEL" | "TENANT_INTERNATIONAL_LAWYER" | "LANDLORD_REPRESENTATIVE">("TENANT_INTERNATIONAL_LAWYER");
  const [countryCode, setCountryCode] = useState("");
  const [barRegistrationNo, setBarRegistrationNo] = useState("");
  const [legalNoticeAddress, setLegalNoticeAddress] = useState("");
  
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[600px] bg-background/80 backdrop-blur-xl border border-white/10 shadow-2xl text-foreground max-h-[90vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">{t("add_solicitor")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("add_solicitor_description")}</DialogDescription>
        </DialogHeader>
        <div className="grid gap-4 py-4">
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("firm_name")}</Label>
            <Input value={solicitorFirm} onChange={e => setSolicitorFirm(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("contact_name")}</Label>
            <Input value={solicitorName} onChange={e => setSolicitorName(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("email")}</Label>
            <Input value={solicitorEmail} onChange={e => setSolicitorEmail(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("phone")}</Label>
            <Input value={solicitorPhone} onChange={e => setSolicitorPhone(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">Solicitor Type</Label>
            <Select value={solicitorType} onValueChange={v => setSolicitorType(v as "LOCAL_LEGAL_COUNSEL" | "TENANT_INTERNATIONAL_LAWYER" | "LANDLORD_REPRESENTATIVE")}>
              <SelectTrigger className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="LOCAL_LEGAL_COUNSEL">Local Legal Counsel</SelectItem>
                <SelectItem value="TENANT_INTERNATIONAL_LAWYER">Tenant International Lawyer</SelectItem>
                <SelectItem value="LANDLORD_REPRESENTATIVE">Landlord Representative</SelectItem>
              </SelectContent>
            </Select>
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">Country Code</Label>
            <Input value={countryCode} onChange={e => setCountryCode(e.target.value)} placeholder="GB, TR, US, DE" className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">Bar Registration No</Label>
            <Input value={barRegistrationNo} onChange={e => setBarRegistrationNo(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">Legal Notice Address</Label>
            <Input value={legalNoticeAddress} onChange={e => setLegalNoticeAddress(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
        </div>
        <DialogFooter className="pt-4 border-t border-white/10">
          <Button variant="outline" onClick={() => onOpenChange(false)} className="border-border text-foreground">{t("cancel")}</Button>
          <Button onClick={() => onOpenChange(false)} className="bg-primary hover:bg-primary/90">{t("create")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
