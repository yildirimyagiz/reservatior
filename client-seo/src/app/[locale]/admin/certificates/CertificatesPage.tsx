"use client";

import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import {
  Award,
  Search,
  Plus,
  ArrowUp,
  Shield,
  CheckCircle,
  AlertTriangle,
  Home,
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

const TIERS = ["MOVE_IN_READY", "INCOME_READY", "INVESTMENT_READY"];
const STATUSES = ["ISSUED", "EXPIRED", "REVOKED", "PENDING_REVIEW"];

const TIER_COLORS: Record<string, string> = {
  MOVE_IN_READY: "bg-blue-500/20 text-blue-400",
  INCOME_READY: "bg-green-500/20 text-green-400",
  INVESTMENT_READY: "bg-purple-500/20 text-purple-400",
};

const STATUS_COLORS: Record<string, string> = {
  ISSUED: "bg-green-500/20 text-green-400",
  EXPIRED: "bg-amber-500/20 text-amber-400",
  REVOKED: "bg-red-500/20 text-red-400",
  PENDING_REVIEW: "bg-blue-500/20 text-blue-400",
};

const mockCertificates = [
  { id: "1", orgId: "org1", propertyId: "p1", propertyName: "Beyoğlu Luxury Apartment", tier: "INVESTMENT_READY", status: "ISSUED", certificateNumber: "CERT-2026-001", moveInReady: true, incomeReady: true, investmentReady: true, trustScore: 92, annualIncome: 36000, occupancyRate: 95, maintenanceScore: 88, complianceStatus: "COMPLIANT", monthsRented: 24, totalIncome: 72000, averageMonthlyRent: 3000, yieldRate: 8.2, furnishedBy: "Premium Furnishings Co.", furnitureValue: 15000, issuedAt: "2026-01-15", expiresAt: "2027-01-15", createdAt: "2026-01-15", updatedAt: "2026-01-15" },
  { id: "2", orgId: "org1", propertyId: "p2", propertyName: "Kadıköy Modern Studio", tier: "INCOME_READY", status: "ISSUED", certificateNumber: "CERT-2026-002", moveInReady: true, incomeReady: true, investmentReady: false, trustScore: 85, annualIncome: 24000, occupancyRate: 88, maintenanceScore: 82, complianceStatus: "COMPLIANT", monthsRented: 18, totalIncome: 36000, averageMonthlyRent: 2000, yieldRate: 7.5, furnishedBy: null, furnitureValue: null, issuedAt: "2026-01-20", expiresAt: "2027-01-20", createdAt: "2026-01-20", updatedAt: "2026-01-20" },
  { id: "3", orgId: "org1", propertyId: "p3", propertyName: "Beşiktaş Family Home", tier: "MOVE_IN_READY", status: "ISSUED", certificateNumber: "CERT-2026-003", moveInReady: true, incomeReady: false, investmentReady: false, trustScore: 72, annualIncome: 0, occupancyRate: 0, maintenanceScore: 75, complianceStatus: "PARTIAL", monthsRented: 0, totalIncome: 0, averageMonthlyRent: 0, yieldRate: 0, furnishedBy: null, furnitureValue: null, issuedAt: "2026-02-01", expiresAt: "2027-02-01", createdAt: "2026-02-01", updatedAt: "2026-02-01" },
  { id: "4", orgId: "org1", propertyId: "p4", propertyName: "Şişli Penthouse", tier: "INVESTMENT_READY", status: "EXPIRED", certificateNumber: "CERT-2025-089", moveInReady: true, incomeReady: true, investmentReady: true, trustScore: 88, annualIncome: 48000, occupancyRate: 92, maintenanceScore: 85, complianceStatus: "COMPLIANT", monthsRented: 36, totalIncome: 144000, averageMonthlyRent: 4000, yieldRate: 9.1, furnishedBy: "Luxe Staging", furnitureValue: 25000, issuedAt: "2024-06-01", expiresAt: "2025-06-01", createdAt: "2024-06-01", updatedAt: "2025-06-01" },
  { id: "5", orgId: "org1", propertyId: "p5", propertyName: "Ankara Business Suite", tier: "MOVE_IN_READY", status: "PENDING_REVIEW", certificateNumber: "CERT-2026-004", moveInReady: true, incomeReady: false, investmentReady: false, trustScore: 65, annualIncome: 0, occupancyRate: 0, maintenanceScore: 70, complianceStatus: "PENDING", monthsRented: 0, totalIncome: 0, averageMonthlyRent: 0, yieldRate: 0, furnishedBy: null, furnitureValue: null, issuedAt: null, expiresAt: null, createdAt: "2026-02-10", updatedAt: "2026-02-10" },
];

export default function CertificatesPage() {
  const { t } = useTranslation();
  const [searchTerm, setSearchTerm] = useState("");
  const [tierFilter, setTierFilter] = useState("all");
  const [statusFilter, setStatusFilter] = useState("all");
  const [isIssueOpen, setIsIssueOpen] = useState(false);
  const [verifyDialogOpen, setVerifyDialogOpen] = useState(false);
  const [verifyNumber, setVerifyNumber] = useState("");
  const [verifyResult, setVerifyResult] = useState<any>(null);

  const filtered = mockCertificates.filter((c) => {
    const matchesSearch = c.propertyName.toLowerCase().includes(searchTerm.toLowerCase()) || c.certificateNumber.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesTier = tierFilter === "all" || c.tier === tierFilter;
    const matchesStatus = statusFilter === "all" || c.status === statusFilter;
    return matchesSearch && matchesTier && matchesStatus;
  });

  const totalCertificates = mockCertificates.length;
  const issuedCertificates = mockCertificates.filter((c) => c.status === "ISSUED").length;
  const investmentReady = mockCertificates.filter((c) => c.tier === "INVESTMENT_READY" && c.status === "ISSUED").length;

  return (
    <div className="min-h-screen bg-background">
      <div className="container mx-auto px-4 py-8">
        <m.div initial={{ opacity: 0, y: -20 }} animate={{ opacity: 1, y: 0 }} className="mb-8">
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-foreground mb-2">{t("admin_certificates_title", "Income Certificates")}</h1>
              <p className="text-muted-foreground">{t("admin_certificates_description", "Issue and manage income-ready property certificates")}</p>
            </div>
          </div>
        </m.div>

        {/* Summary Cards */}
        <m.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.1 }} className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 mb-6">
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-blue-500/10"><Award className="w-5 h-5 text-blue-500" /></div>
                <div>
                  <p className="text-sm text-muted-foreground">{t("admin_certificates_total", "Total")}</p>
                  <p className="text-2xl font-bold text-foreground">{totalCertificates}</p>
                </div>
              </div>
            </CardContent>
          </Card>
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-green-500/10"><CheckCircle className="w-5 h-5 text-green-500" /></div>
                <div>
                  <p className="text-sm text-muted-foreground">{t("admin_certificates_issued", "Issued")}</p>
                  <p className="text-2xl font-bold text-foreground">{issuedCertificates}</p>
                </div>
              </div>
            </CardContent>
          </Card>
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-purple-500/10"><Shield className="w-5 h-5 text-purple-500" /></div>
                <div>
                  <p className="text-sm text-muted-foreground">{t("admin_certificates_investment", "Investment Ready")}</p>
                  <p className="text-2xl font-bold text-foreground">{investmentReady}</p>
                </div>
              </div>
            </CardContent>
          </Card>
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-amber-500/10"><Home className="w-5 h-5 text-amber-500" /></div>
                <div>
                  <p className="text-sm text-muted-foreground">{t("admin_certificates_avg_yield", "Avg Yield")}</p>
                  <p className="text-2xl font-bold text-foreground">8.3%</p>
                </div>
              </div>
            </CardContent>
          </Card>
        </m.div>

        {/* Search and Filter */}
        <m.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.15 }} className="mb-6">
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex gap-4 flex-wrap">
                <div className="flex-1 min-w-[200px]">
                  <div className="relative">
                    <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
                    <Input
                      placeholder={t("admin_certificates_search_placeholder", "Search by property or certificate number...")}
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors placeholder:text-muted-foreground"
                    />
                  </div>
                </div>
                <Select value={tierFilter} onValueChange={setTierFilter}>
                  <SelectTrigger className="w-[200px] bg-white/5 border-white/10 text-foreground">
                    <SelectValue placeholder={t("admin_certificates_tier", "Tier")} />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="all">{t("admin_certificates_all_tiers", "All Tiers")}</SelectItem>
                    {TIERS.map((tier) => <SelectItem key={tier} value={tier}>{tier.replace(/_/g, " ")}</SelectItem>)}
                  </SelectContent>
                </Select>
                <Select value={statusFilter} onValueChange={setStatusFilter}>
                  <SelectTrigger className="w-[180px] bg-white/5 border-white/10 text-foreground">
                    <SelectValue placeholder={t("admin_certificates_status", "Status")} />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="all">{t("admin_certificates_all_status", "All Status")}</SelectItem>
                    {STATUSES.map((s) => <SelectItem key={s} value={s}>{s.replace(/_/g, " ")}</SelectItem>)}
                  </SelectContent>
                </Select>
                <Button onClick={() => setVerifyDialogOpen(true)} variant="outline" className="border-border text-foreground">
                  <Shield className="w-4 h-4 mr-2" />
                  {t("admin_certificates_verify", "Verify")}
                </Button>
                <Button onClick={() => setIsIssueOpen(true)} className="bg-primary hover:bg-primary/90">
                  <Plus className="w-4 h-4 mr-2" />
                  {t("admin_certificates_issue", "Issue Certificate")}
                </Button>
              </div>
            </CardContent>
          </Card>
        </m.div>

        {/* Certificates Table */}
        <m.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.2 }}>
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground flex items-center gap-2">
                <Award className="w-5 h-5" />
                {t("admin_certificates_list_title", "Certificates")} ({filtered.length})
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="overflow-x-auto">
                <table className="w-full text-sm">
                  <thead>
                    <tr className="border-b border-border">
                      <th className="text-left py-3 px-4 text-muted-foreground font-medium">{t("admin_certificates_number", "Certificate #")}</th>
                      <th className="text-left py-3 px-4 text-muted-foreground font-medium">{t("admin_certificates_property", "Property")}</th>
                      <th className="text-left py-3 px-4 text-muted-foreground font-medium">{t("admin_certificates_tier_col", "Tier")}</th>
                      <th className="text-right py-3 px-4 text-muted-foreground font-medium">{t("admin_certificates_trust", "Trust Score")}</th>
                      <th className="text-right py-3 px-4 text-muted-foreground font-medium">{t("admin_certificates_yield", "Yield")}</th>
                      <th className="text-left py-3 px-4 text-muted-foreground font-medium">{t("admin_certificates_readiness", "Readiness")}</th>
                      <th className="text-left py-3 px-4 text-muted-foreground font-medium">{t("admin_certificates_status_col", "Status")}</th>
                      <th className="text-right py-3 px-4 text-muted-foreground font-medium">{t("admin_certificates_actions", "Actions")}</th>
                    </tr>
                  </thead>
                  <tbody>
                    {filtered.map((cert) => (
                      <tr key={cert.id} className="border-b border-border/50 hover:bg-muted/30 transition-colors">
                        <td className="py-3 px-4">
                          <div className="text-foreground font-medium font-mono text-xs">{cert.certificateNumber}</div>
                          <div className="text-xs text-muted-foreground">{cert.issuedAt ? new Date(cert.issuedAt).toLocaleDateString() : "Pending"}</div>
                        </td>
                        <td className="py-3 px-4 text-foreground">{cert.propertyName}</td>
                        <td className="py-3 px-4">
                          <Badge className={TIER_COLORS[cert.tier]}>{cert.tier.replace(/_/g, " ")}</Badge>
                        </td>
                        <td className="py-3 px-4 text-right">
                          <span className={`font-medium ${cert.trustScore >= 80 ? "text-green-400" : cert.trustScore >= 60 ? "text-amber-400" : "text-red-400"}`}>{cert.trustScore}</span>
                        </td>
                        <td className="py-3 px-4 text-right font-medium text-foreground">{cert.yieldRate}%</td>
                        <td className="py-3 px-4">
                          <div className="flex gap-1">
                            {cert.moveInReady && <Badge className="bg-green-500/20 text-green-400 text-xs">Move-In</Badge>}
                            {cert.incomeReady && <Badge className="bg-blue-500/20 text-blue-400 text-xs">Income</Badge>}
                            {cert.investmentReady && <Badge className="bg-purple-500/20 text-purple-400 text-xs">Investment</Badge>}
                          </div>
                        </td>
                        <td className="py-3 px-4">
                          <Badge className={STATUS_COLORS[cert.status]}>{cert.status.replace(/_/g, " ")}</Badge>
                        </td>
                        <td className="py-3 px-4">
                          <div className="flex justify-end gap-2">
                            {cert.status === "ISSUED" && cert.tier !== "INVESTMENT_READY" && (
                              <Button variant="ghost" size="sm" className="text-green-400"><ArrowUp className="w-3.5 h-3.5 mr-1" />Upgrade</Button>
                            )}
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

        {/* Issue Certificate Dialog */}
        <IssueCertificateDialog open={isIssueOpen} onOpenChange={setIsIssueOpen} />

        {/* Verify Dialog */}
        <Dialog open={verifyDialogOpen} onOpenChange={setVerifyDialogOpen}>
          <DialogContent className="sm:max-w-[425px] bg-background/80 backdrop-blur-xl border border-white/10 shadow-2xl text-foreground">
            <DialogHeader>
              <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">{t("admin_certificates_verify_title", "Verify Certificate")}</DialogTitle>
              <DialogDescription className="text-muted-foreground">{t("admin_certificates_verify_desc", "Enter a certificate number to verify.")}</DialogDescription>
            </DialogHeader>
            <div className="py-4">
              <Input
                placeholder={t("admin_certificates_verify_placeholder", "Enter certificate number...")}
                value={verifyNumber}
                onChange={(e) => setVerifyNumber(e.target.value)}
                className="bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors"
              />
            </div>
            <DialogFooter className="pt-4 border-t border-white/10">
              <Button variant="outline" onClick={() => { setVerifyDialogOpen(false); setVerifyNumber(""); }} className="border-border text-foreground">{t("admin_action_cancel", "Cancel")}</Button>
              <Button onClick={() => { setVerifyDialogOpen(false); setVerifyNumber(""); }} className="bg-primary hover:bg-primary/90">{t("admin_certificates_verify_btn", "Verify")}</Button>
            </DialogFooter>
          </DialogContent>
        </Dialog>
      </div>
    </div>
  );
}

function IssueCertificateDialog({ open, onOpenChange }: { open: boolean; onOpenChange: (open: boolean) => void }) {
  const { t } = useTranslation();
  const [propertyName, setPropertyName] = useState("");
  const [propertyId, setPropertyId] = useState("");
  const [tier, setTier] = useState("MOVE_IN_READY");

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[600px] bg-background/80 backdrop-blur-xl border border-white/10 shadow-2xl text-foreground max-h-[90vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">{t("admin_certificates_issue_title", "Issue Certificate")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("admin_certificates_issue_desc", "Issue a new income-ready certificate for a property.")}</DialogDescription>
        </DialogHeader>
        <div className="grid gap-4 py-4">
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_certificates_property_name", "Property")}</Label>
            <Input value={propertyName} onChange={(e) => setPropertyName(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_certificates_property_id", "Property ID")}</Label>
            <Input value={propertyId} onChange={(e) => setPropertyId(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_certificates_tier", "Tier")}</Label>
            <Select value={tier} onValueChange={setTier}>
              <SelectTrigger className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors"><SelectValue /></SelectTrigger>
              <SelectContent>{TIERS.map((t) => <SelectItem key={t} value={t}>{t.replace(/_/g, " ")}</SelectItem>)}</SelectContent>
            </Select>
          </div>
        </div>
        <DialogFooter className="pt-4 border-t border-white/10">
          <Button variant="outline" onClick={() => onOpenChange(false)} className="border-border text-foreground">{t("admin_action_cancel", "Cancel")}</Button>
          <Button onClick={() => onOpenChange(false)} className="bg-primary hover:bg-primary/90">{t("admin_certificates_issue_btn", "Issue Certificate")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
