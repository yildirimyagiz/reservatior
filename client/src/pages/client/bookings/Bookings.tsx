import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle, DialogFooter } from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { useBookings, useVerifyOwnership, useCreateSecurityScreening, useBookingAnalytics } from "@/hooks/use-bookings";
import { format } from "date-fns";
import { Search, Shield, AlertTriangle, CheckCircle, Clock, Eye, Download, AlertCircle, Zap, Activity, ArrowUpRight, Fingerprint } from "lucide-react";
import { PageShell } from "../layout/PageShell";
import { motion, AnimatePresence } from "framer-motion";
import { cn } from "@/lib/utils";
import type { BookingStatus, SecurityRiskLevel, VerificationMethod, SecurityScreeningStatus } from "@/lib/api/bookings";
export default function BookingsPage() {
  const {
    t
  } = useTranslation();
  const [filters, setFilters] = useState({
    status: undefined as BookingStatus | undefined,
    ownershipVerified: undefined as boolean | undefined,
    search: ""
  });
  const [selectedBooking, setSelectedBooking] = useState<any>(null);
  const [isOwnershipDialogOpen, setIsOwnershipDialogOpen] = useState(false);
  const [isSecurityDialogOpen, setIsSecurityDialogOpen] = useState(false);
  const [ownershipData, setOwnershipData] = useState({
    propertyId: "",
    verificationMethod: "MANUAL" as VerificationMethod,
    documents: [] as any[],
    notes: ""
  });
  const [securityData, setSecurityData] = useState({
    riskLevel: "MEDIUM" as SecurityRiskLevel,
    riskScore: 0.5,
    manualReviewRequired: false,
    screeningMetadata: {},
    notes: ""
  });
  const {
    data: bookings,
    isLoading,
    refetch
  } = useBookings(filters);
  const {
    data: analytics
  } = useBookingAnalytics();
  const verifyOwnershipMutation = useVerifyOwnership();
  const createSecurityScreeningMutation = useCreateSecurityScreening();
  const handleVerifyOwnership = (bookingId: string) => {
    verifyOwnershipMutation.mutate({
      id: bookingId,
      data: ownershipData
    }, {
      onSuccess: () => {
        setIsOwnershipDialogOpen(false);
        setOwnershipData({
          propertyId: "",
          verificationMethod: "MANUAL",
          documents: [],
          notes: ""
        });
        refetch();
      }
    });
  };
  const handleCreateSecurityScreening = (bookingId: string) => {
    createSecurityScreeningMutation.mutate({
      id: bookingId,
      data: securityData
    }, {
      onSuccess: () => {
        setIsSecurityDialogOpen(false);
        setSecurityData({
          riskLevel: "MEDIUM",
          riskScore: 0.5,
          manualReviewRequired: false,
          screeningMetadata: {},
          notes: ""
        });
        refetch();
      }
    });
  };
  const getStatusColor = (status: BookingStatus) => {
    switch (status) {
      case "CONFIRMED":
        return "bg-emerald-50 dark:bg-emerald-500/10 text-emerald-600 dark:text-emerald-400 border-emerald-200 dark:border-emerald-500/20";
      case "PENDING":
        return "bg-amber-50 dark:bg-amber-500/10 text-amber-600 dark:text-amber-400 border-amber-200 dark:border-amber-500/20";
      case "CANCELLED":
        return "bg-red-50 dark:bg-red-500/10 text-red-600 dark:text-red-400 border-red-200 dark:border-red-500/20";
      case "COMPLETED":
        return "bg-blue-50 dark:bg-blue-500/10 text-blue-600 dark:text-blue-400 border-blue-200 dark:border-blue-500/20";
      default:
        return "bg-slate-100 dark:bg-slate-500/10 text-slate-600 dark:text-slate-400 border-slate-200 dark:border-slate-500/20";
    }
  };
  const getRiskIcon = (level: SecurityRiskLevel) => {
    switch (level) {
      case "LOW":
        return <CheckCircle className="w-3 h-3 text-emerald-400" />;
      case "MEDIUM":
        return <Clock className="w-3 h-3 text-orange-400" />;
      case "HIGH":
        return <AlertTriangle className="w-3 h-3 text-red-400" />;
      case "CRITICAL":
        return <Fingerprint className="w-3 h-3 text-purple-400" />;
      default:
        return <Clock className="w-3 h-3 text-slate-400" />;
    }
  };
  const stats = analytics ? [{
    label: t("bookings.total", "Total Bookings"),
    value: analytics.totalBookings
  }, {
    label: t("bookings.verified_rate", "Verified Rate"),
    value: `${(analytics.ownershipVerificationRate * 100).toFixed(1)}%`
  }, {
    label: t("bookings.risk_score", "Avg Risk Score"),
    value: (analytics.avgRiskScore * 100).toFixed(0)
  }, {
    label: t("bookings.critical_alerts", "Critical Alerts"),
    value: analytics.riskDistribution.high,
    color: "text-red-500"
  }] : [];
  return <PageShell title={t("bookings.title", "Booking Management")} description={t("bookings.desc", "Manage all tenant applications and property reservations")} stats={stats} onSearchChange={v => setFilters(prev => ({
    ...prev,
    search: v
  }))} searchValue={filters.search} filters={<div className="flex items-center gap-4">
          <Select value={filters.status || ""} onValueChange={value => setFilters(prev => ({
      ...prev,
      status: value as BookingStatus || undefined
    }))}>
            <SelectTrigger className="h-10 w-48 bg-white dark:bg-slate-900/60 border-slate-200 dark:border-white/10 rounded-xl text-xs font-semibold text-slate-700 dark:text-slate-300 focus:ring-blue-500/20">
               <SelectValue placeholder={t("bookings.filter_status", "Filter by Status")} />
            </SelectTrigger>
            <SelectContent className="bg-white dark:bg-slate-900 border-slate-200 dark:border-white/10 rounded-xl shadow-lg">
              <SelectItem value="all" className="text-slate-700 dark:text-slate-300 font-medium hover:bg-slate-50 dark:hover:bg-white/5 cursor-pointer">{t("bookings.all_status", "All Statuses")}</SelectItem>
              {["DRAFT", "PENDING", "CONFIRMED", "CANCELLED", "COMPLETED"].map(s => <SelectItem key={s} value={s} className="text-slate-700 dark:text-slate-300 font-medium hover:bg-slate-50 dark:hover:bg-white/5 cursor-pointer">{s}</SelectItem>)}
            </SelectContent>
          </Select>
        </div>}>
      <div className="space-y-6">
        <div className="bg-white dark:bg-slate-900/40 border border-slate-200 dark:border-white/10 rounded-2xl overflow-hidden shadow-sm">
          <Table>
            <TableHeader className="bg-slate-50/50 dark:bg-white/5">
              <TableRow className="border-slate-200 dark:border-white/10 hover:bg-transparent">
                <TableHead className="py-4 text-xs font-semibold text-slate-500 dark:text-slate-400 pl-6">{t("bookings.tenant_info", "Tenant Info")}</TableHead>
                <TableHead className="text-xs font-semibold text-slate-500 dark:text-slate-400 text-center">{t("bookings.property", "Property")}</TableHead>
                <TableHead className="text-xs font-semibold text-slate-500 dark:text-slate-400 text-center">{t("bookings.status", "Status")}</TableHead>
                <TableHead className="text-xs font-semibold text-slate-500 dark:text-slate-400 text-center">{t("bookings.verification", "Verification")}</TableHead>
                <TableHead className="text-xs font-semibold text-slate-500 dark:text-slate-400 text-center">{t("bookings.risk", "Risk Level")}</TableHead>
                <TableHead className="text-xs font-semibold text-slate-500 dark:text-slate-400 text-right pr-6">{t("bookings.actions", "Actions")}</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {isLoading ? <TableRow>
                   <TableCell colSpan={6} className="h-64 text-center">
                      <Activity className="w-6 h-6 text-blue-500 animate-pulse mx-auto" />
                   </TableCell>
                </TableRow> : bookings?.data?.map((booking, idx) => <TableRow key={booking.id} className="border-slate-200 dark:border-white/10 group hover:bg-slate-50 dark:hover:bg-white/5 transition-all">
                    <TableCell className="py-4 pl-6">
                      <div className="flex items-center gap-4">
                         <div className="w-10 h-10 rounded-full bg-blue-50 dark:bg-blue-500/10 border border-blue-100 dark:border-blue-500/20 flex items-center justify-center font-bold text-blue-600 dark:text-blue-400 shadow-sm group-hover:scale-105 transition-transform">
                            {booking.contact?.name?.[0] || "U"}
                         </div>
                         <div>
                            <div className="text-sm font-semibold text-slate-900 dark:text-white leading-tight">{booking.contact?.name}</div>
                            <div className="text-xs text-slate-500 dark:text-slate-400 mt-0.5">{booking.contact?.email}</div>
                         </div>
                      </div>
                    </TableCell>
                    <TableCell className="text-center">
                      <div>
                        <div className="text-sm font-semibold text-slate-900 dark:text-white">{booking.property?.name}</div>
                        <div className="text-xs text-slate-500 dark:text-slate-400 mt-0.5 max-w-[150px] truncate mx-auto">{booking.property?.address}</div>
                      </div>
                    </TableCell>
                    <TableCell className="text-center">
                      <Badge className={cn("px-2.5 py-1 rounded-md text-[10px] font-bold uppercase tracking-wider shadow-none", getStatusColor(booking.status))}>
                        {booking.status}
                      </Badge>
                    </TableCell>
                    <TableCell className="text-center">
                       <div className="flex items-center justify-center gap-2">
                          {booking.ownershipVerified ? <div className="flex items-center gap-1.5 bg-emerald-50 dark:bg-emerald-500/10 text-emerald-600 dark:text-emerald-400 px-2.5 py-1 rounded-md border border-emerald-200 dark:border-emerald-500/20">
                              <Shield className="w-3.5 h-3.5" />
                              <span className="text-[10px] font-bold uppercase tracking-wider">{t("bookings.verified", "Verified")}</span>
                            </div> : <div className="flex items-center gap-1.5 bg-amber-50 dark:bg-amber-500/10 text-amber-600 dark:text-amber-400 px-2.5 py-1 rounded-md border border-amber-200 dark:border-amber-500/20">
                              <AlertTriangle className="w-3.5 h-3.5" />
                              <span className="text-[10px] font-bold uppercase tracking-wider">{t("bookings.pending", "Pending")}</span>
                            </div>}
                       </div>
                    </TableCell>
                    <TableCell className="text-center">
                       <div className="inline-flex items-center gap-2 bg-slate-50 dark:bg-slate-900/50 px-3 py-1.5 rounded-lg border border-slate-200 dark:border-white/10">
                          {getRiskIcon(booking.securityScreenings?.[0]?.riskLevel || "LOW")}
                          <span className="text-xs font-semibold text-slate-700 dark:text-slate-300">
                             {booking.riskScore ? `${(booking.riskScore * 100).toFixed(0)}%` : "N/A"}
                          </span>
                       </div>
                    </TableCell>
                    <TableCell className="text-right pr-6">
                      <div className="flex justify-end gap-2">
                         <Button variant="outline" className="h-8 px-3 rounded-lg border-slate-200 dark:border-white/10 bg-white dark:bg-slate-900/50 text-xs font-medium text-slate-700 dark:text-slate-300 hover:bg-slate-50 dark:hover:bg-white/10 gap-1.5" onClick={() => {
                    setSelectedBooking(booking);
                    setIsSecurityDialogOpen(true);
                  }}>
                            <Eye className="w-3.5 h-3.5 text-blue-500" />{t("bookings.review", "Review")}
                         </Button>
                      </div>
                    </TableCell>
                  </TableRow>)}
            </TableBody>
          </Table>
        </div>
      </div>

      {/* Modern Dialogs */}
      {/* Modern Dialogs */}
      <Dialog open={isOwnershipDialogOpen} onOpenChange={setIsOwnershipDialogOpen}>
        <DialogContent className="bg-white dark:bg-slate-900 border-slate-200 dark:border-white/10 rounded-2xl sm:max-w-xl">
          <DialogHeader>
            <DialogTitle className="text-xl font-semibold text-slate-900 dark:text-white">{t("bookings.verify_ownership", "Verify Ownership")}</DialogTitle>
            <DialogDescription className="text-sm text-slate-500 dark:text-slate-400 mt-1.5">{t("bookings.verify_desc", "Confirm property ownership and validate documents.")}</DialogDescription>
          </DialogHeader>
          <div className="grid gap-6 py-4">
            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label className="text-xs font-semibold text-slate-700 dark:text-slate-300 uppercase tracking-wider">{t("bookings.property_id", "Property ID")}</Label>
                <Input className="h-10 bg-slate-50 dark:bg-slate-900/50 border-slate-200 dark:border-white/10 rounded-lg text-slate-900 dark:text-white focus-visible:ring-blue-500" value={ownershipData.propertyId} onChange={e => setOwnershipData(prev => ({
                ...prev,
                propertyId: e.target.value
              }))} />
              </div>
              <div className="space-y-2">
                <Label className="text-xs font-semibold text-slate-700 dark:text-slate-300 uppercase tracking-wider">{t("bookings.method", "Verification Method")}</Label>
                <Select value={ownershipData.verificationMethod} onValueChange={(value: VerificationMethod) => setOwnershipData(prev => ({
                ...prev,
                verificationMethod: value
              }))}>
                  <SelectTrigger className="h-10 bg-slate-50 dark:bg-slate-900/50 border-slate-200 dark:border-white/10 rounded-lg text-slate-900 dark:text-white focus:ring-blue-500"><SelectValue /></SelectTrigger>
                  <SelectContent className="bg-white dark:bg-slate-900 border-slate-200 dark:border-white/10 rounded-xl">
                    {["MANUAL", "API", "BLOCKCHAIN", "AI"].map(m => <SelectItem key={m} value={m} className="text-slate-700 dark:text-slate-300 font-medium hover:bg-slate-50 dark:hover:bg-white/5 cursor-pointer">{m}</SelectItem>)}
                  </SelectContent>
                </Select>
              </div>
            </div>
            <div className="space-y-2">
              <Label className="text-xs font-semibold text-slate-700 dark:text-slate-300 uppercase tracking-wider">{t("bookings.notes", "Admin Notes")}</Label>
              <Textarea className="bg-slate-50 dark:bg-slate-900/50 border-slate-200 dark:border-white/10 rounded-lg text-slate-900 dark:text-white focus-visible:ring-blue-500 resize-none" value={ownershipData.notes} onChange={e => setOwnershipData(prev => ({
              ...prev,
              notes: e.target.value
            }))} rows={3} />
            </div>
          </div>
          <DialogFooter className="gap-3 sm:justify-end">
             <Button variant="outline" onClick={() => setIsOwnershipDialogOpen(false)} className="h-10 rounded-lg text-slate-700 dark:text-slate-300 border-slate-200 dark:border-white/10 bg-transparent hover:bg-slate-50 dark:hover:bg-white/5 font-medium">{t("bookings.cancel", "Cancel")}</Button>
             <Button className="h-10 rounded-lg bg-blue-600 hover:bg-blue-700 text-white font-semibold px-6 shadow-sm shadow-blue-600/20" onClick={() => selectedBooking && handleVerifyOwnership(selectedBooking.id)}>
                {verifyOwnershipMutation.isPending ? t("bookings.processing", "Processing...") : t("bookings.confirm", "Confirm Verification")}
             </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </PageShell>;
}