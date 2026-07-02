import { t } from "i18next";
import { useState } from "react";
import { PageShell } from "../client/layout/PageShell";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { useTranslation } from "react-i18next";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription, DialogFooter } from "@/components/ui/dialog";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Input } from "@/components/ui/input";
import { useToast } from "@/hooks/use-toast";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { bookingsApi } from "@/lib/api/bookings";
import { Activity, LayoutGrid, List, CalendarDays, Calendar, Clock, AlertCircle, CheckCircle, Edit, Eye, MoreHorizontal, Shield, TrendingUp, XCircle, Search, DollarSign, Zap, MapPin, User as UserIcon, ArrowUpRight, FileText, Loader2 } from "lucide-react";
import { cn } from "@/lib/utils";
import { CalendarView } from "@/components/calendar/CalendarView";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { motion, AnimatePresence } from "framer-motion";
interface Booking {
  id: string;
  orgId: string;
  listingId: string;
  contactId: string;
  startDate: string;
  endDate: string;
  status: "PENDING" | "CONFIRMED" | "CANCELLED" | "COMPLETED" | "NO_SHOW";
  totalPrice?: number;
  depositAmount?: number;
  notes?: string;
  ownershipVerified: boolean;
  verificationStatus: "PENDING" | "VERIFIED" | "FAILED" | "NOT_REQUIRED";
  riskScore?: number;
  specialRequests?: string[];
  createdAt: string;
  updatedAt: string;
  contact: {
    id: string;
    name: string;
    email: string;
    phone?: string;
    avatar?: string;
  };
  listing: {
    id: string;
    title: string;
    property: {
      id: string;
      addressLine1: string;
      city: string;
      state: string;
      zip: string;
      type: string;
      bedrooms: number;
      bathrooms: number;
      areaSqm: number;
    };
    price: number;
    type: string;
  };
}
const STATUS_CONFIG = (t: any) => {
  return {
    PENDING: {
      label: t("admin.bookings.status.pending"),
      color: "bg-orange-500/10 text-orange-400 border-orange-500/20"
    },
    CONFIRMED: {
      label: t("confirmed"),
      color: "bg-blue-500/10 text-blue-400 border-blue-500/20"
    },
    CANCELLED: {
      label: t("admin.bookings.status.cancelled"),
      color: "bg-red-500/10 text-red-500 border-red-500/20"
    },
    COMPLETED: {
      label: t("admin.bookings.status.completed"),
      color: "bg-emerald-500/10 text-emerald-400 border-emerald-500/20"
    },
    NO_SHOW: {
      label: t("noShow"),
      color: "bg-slate-500/10 text-muted-foreground border-slate-500/20"
    }
  };
};
const VERIFICATION_CONFIG = (t: any) => {
  return {
    PENDING: {
      label: t("admin.bookings.verification.pending"),
      color: "bg-orange-500/10 text-orange-400"
    },
    VERIFIED: {
      label: t("admin.bookings.verification.verified"),
      color: "bg-emerald-500/10 text-emerald-400"
    },
    FAILED: {
      label: t("failed"),
      color: "bg-red-500/10 text-red-500"
    },
    NOT_REQUIRED: {
      label: t("admin.bookings.verification.notRequired"),
      color: "bg-slate-500/10 text-muted-foreground"
    }
  };
};
const MOCK_BOOKINGS: Booking[] = [{
  id: "1",
  orgId: "org-1",
  listingId: "listing-1",
  contactId: "contact-1",
  startDate: "2024-04-15",
  endDate: "2024-04-22",
  status: "CONFIRMED",
  totalPrice: 2100,
  depositAmount: 300,
  notes: "Guest requested early check-in",
  ownershipVerified: true,
  verificationStatus: "VERIFIED",
  riskScore: 15,
  specialRequests: ["Early check-in", "Extra towels"],
  createdAt: "2024-03-28",
  updatedAt: "2024-03-28",
  contact: {
    id: "contact-1",
    name: "John Smith",
    email: "john.smith@email.com",
    phone: "+1 555-0123",
    avatar: "/avatars/john.jpg"
  },
  listing: {
    id: "listing-1",
    title: t("admin.bookingsmanagement.luxury_2br_downtown_apartment"),
    property: {
      id: "prop-1",
      addressLine1: "123 Main St",
      city: "New York",
      state: "NY",
      zip: "10001",
      type: "APARTMENT",
      bedrooms: 2,
      bathrooms: 2,
      areaSqm: 85
    },
    price: 300,
    type: "SHORT_TERM"
  }
}, {
  id: "2",
  orgId: "org-1",
  listingId: "listing-2",
  contactId: "contact-2",
  startDate: "2024-05-01",
  endDate: "2024-05-07",
  status: "PENDING",
  totalPrice: 1750,
  depositAmount: 250,
  ownershipVerified: false,
  verificationStatus: "PENDING",
  riskScore: 45,
  specialRequests: ["Pet friendly"],
  createdAt: "2024-03-27",
  updatedAt: "2024-03-27",
  contact: {
    id: "contact-2",
    name: "Emily Davis",
    email: "emily.davis@email.com",
    phone: "+1 555-0124"
  },
  listing: {
    id: "listing-2",
    title: t("admin.bookingsmanagement.cozy_1br_with_garden"),
    property: {
      id: "prop-2",
      addressLine1: "456 Oak Ave",
      city: "Brooklyn",
      state: "NY",
      zip: "11201",
      type: "APARTMENT",
      bedrooms: 1,
      bathrooms: 1,
      areaSqm: 65
    },
    price: 250,
    type: "SHORT_TERM"
  }
}, {
  id: "3",
  orgId: "org-1",
  listingId: "listing-3",
  contactId: "contact-3",
  startDate: "2024-03-20",
  endDate: "2024-03-25",
  status: "COMPLETED",
  totalPrice: 1500,
  depositAmount: 200,
  notes: "Great guest, left property clean",
  ownershipVerified: true,
  verificationStatus: "VERIFIED",
  riskScore: 5,
  createdAt: "2024-03-15",
  updatedAt: "2024-03-26",
  contact: {
    id: "contact-3",
    name: "Michael Chen",
    email: "michael.chen@email.com",
    phone: "+1 555-0125"
  },
  listing: {
    id: "listing-3",
    title: t("admin.bookingsmanagement.modern_studio_in_manhattan"),
    property: {
      id: "prop-3",
      addressLine1: "789 Broadway",
      city: "New York",
      state: "NY",
      zip: "10003",
      type: "STUDIO",
      bedrooms: 0,
      bathrooms: 1,
      areaSqm: 45
    },
    price: 300,
    type: "SHORT_TERM"
  }
}];
export default function BookingsManagement() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const queryClient = useQueryClient();
  const deleteMutation = useMutation({
    mutationFn: async (id: string) => apiClient.delete(`/api/v1/unknown/${id}`),
    onSuccess: () => {
      toast({ title: "Deleted", description: "Record deleted successfully" });
      queryClient.invalidateQueries();
    },
    onError: (err: any) => toast({ title: "Error", description: err.message, variant: "destructive" })
  });
  

  const [search, setSearch] = useState("");
  const [filterStatus, setFilterStatus] = useState("all");
  const [filterVerification, setFilterVerification] = useState("all");
  const [selectedBooking, setSelectedBooking] = useState<Booking | null>(null);
  const [detailsOpen, setDetailsOpen] = useState(false);
  const [viewMode, setViewMode] = useState<"table" | "calendar">("table");
  
  const { data: bookingsData, isLoading, refetch } = useQuery({
    queryKey: ['bookings'],
    queryFn: async () => {
      const res = await bookingsApi.getBookings();
      const items = res?.data || [];
      return items.map((b: any) => ({
        id: b.id,
        orgId: b.orgId,
        listingId: b.listingId,
        contactId: b.contactId || "",
        startDate: b.startDate,
        endDate: b.endDate,
        status: b.status,
        totalPrice: b.priceTotal || b.totalPrice || 0,
        depositAmount: b.depositAmount || 0,
        notes: b.notes || "",
        ownershipVerified: b.ownershipVerified || false,
        verificationStatus: b.verificationStatus || "PENDING",
        riskScore: b.riskScore || 0,
        specialRequests: b.specialRequests || [],
        createdAt: b.createdAt || new Date().toISOString(),
        updatedAt: b.updatedAt || new Date().toISOString(),
        contact: {
          id: b.contact?.id || "unknown",
          name: b.contact?.name || "Unknown Contact",
          email: b.contact?.email || "unknown@email.com",
          phone: b.contact?.phone || "",
          avatar: b.contact?.avatar || ""
        },
        listing: {
          id: b.listing?.id || b.listingId || "unknown",
          title: b.listing?.title || "Unknown Listing",
          property: {
            id: b.listing?.property?.id || b.property?.id || "unknown",
            addressLine1: b.listing?.property?.address || b.property?.address || "Unknown Address",
            city: b.listing?.property?.city || "",
            state: b.listing?.property?.state || "",
            zip: b.listing?.property?.zip || "",
            type: b.listing?.property?.type || b.property?.type || "APARTMENT",
            bedrooms: b.listing?.property?.bedrooms || 0,
            bathrooms: b.listing?.property?.bathrooms || 0,
            areaSqm: b.listing?.property?.areaSqm || 0,
          },
          price: b.listing?.price || 0,
          type: b.listing?.type || "SHORT_TERM"
        }
      })) as Booking[];
    }
  });

  const bookings = bookingsData && bookingsData.length > 0 ? bookingsData : MOCK_BOOKINGS;

  const updateStatusMutation = useMutation({
    mutationFn: async ({ id, status }: { id: string, status: any }) => {
      return await bookingsApi.updateBookingStatus(id, status);
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['bookings'] });
    },
    onError: (error: any) => {
      toast({
        title: t("admin.bookingsmanagement.error", "Hata"),
        description: error.message,
        variant: "destructive"
      });
    }
  });
  const statusConfig = STATUS_CONFIG(t);
  const verificationConfig = VERIFICATION_CONFIG(t);
  const filteredBookings = bookings.filter(booking => {
    const matchesSearch = booking.contact.name.toLowerCase().includes(search.toLowerCase()) || booking.contact.email.toLowerCase().includes(search.toLowerCase()) || booking.listing.title.toLowerCase().includes(search.toLowerCase()) || booking.listing.property.addressLine1.toLowerCase().includes(search.toLowerCase());
    const matchesStatus = filterStatus === "all" || booking.status === filterStatus;
    const matchesVerification = filterVerification === "all" || booking.verificationStatus === filterVerification;
    return matchesSearch && matchesStatus && matchesVerification;
  });
  const stats = {
    total: bookings.length,
    pending: bookings.filter(b => b.status === "PENDING").length,
    confirmed: bookings.filter(b => b.status === "CONFIRMED").length,
    completed: bookings.filter(b => b.status === "COMPLETED").length,
    cancelled: bookings.filter(b => b.status === "CANCELLED").length,
    totalRevenue: bookings.filter(b => b.status === "COMPLETED").reduce((sum, b) => sum + (b.totalPrice || 0), 0),
    pendingVerification: bookings.filter(b => b.verificationStatus === "PENDING").length
  };
  const handleStatusChange = (bookingId: string, newStatus: string) => {
    updateStatusMutation.mutate({
      id: bookingId,
      status: newStatus
    });
    toast({
      title: t("admin.bookingsmanagement.status_updated"),
      description: `Booking status changed to ${newStatus}`
    });
  };
  const getRiskColor = (score?: number) => {
    if (!score) return "text-muted-foreground";
    if (score <= 20) return "text-emerald-400";
    if (score <= 50) return "text-orange-400";
    return "text-red-500";
  };
  const getRiskLabel = (score?: number) => {
    if (!score) return t("admin.bookings.risk.unknown");
    if (score <= 20) return t("low");
    if (score <= 50) return t("admin.bookings.risk.moderate");
    return t("high");
  };
  return <PageShell title={t("admin.bookings.title")} description={t("admin.bookings.desc")}>
      <div className="space-y-10 pb-20">
        {/* KPI Neural Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-5 gap-6">
          <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t transition-all hover:bg-card">
            <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-muted-foreground">
              <Calendar className="w-10 h-10" />
            </div>
            <CardContent className="p-8">
              <p className="text-[10px] font-bold text-muted-foreground mb-1">{t("admin.bookings.stats.totalPulses")}</p>
              <h3 className="text-3xl font-bold text-foreground leading-none">{stats.total}</h3>
            </CardContent>
          </Card>

          <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t transition-all hover:bg-card">
            <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-orange-500">
              <Clock className="w-10 h-10" />
            </div>
            <CardContent className="p-8">
              <p className="text-[10px] font-bold text-muted-foreground mb-1">{t("admin.bookings.stats.pendingSync")}</p>
              <h3 className="text-3xl font-bold text-orange-400 leading-none">{stats.pending}</h3>
            </CardContent>
          </Card>

          <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t transition-all hover:bg-card">
            <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-blue-500">
              <CheckCircle className="w-10 h-10" />
            </div>
            <CardContent className="p-8">
              <p className="text-[10px] font-bold text-muted-foreground mb-1">{t("admin.bookings.stats.confirmedNodes")}</p>
              <h3 className="text-3xl font-bold text-blue-400 leading-none">{stats.confirmed}</h3>
            </CardContent>
          </Card>

          <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t transition-all hover:bg-card">
            <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-emerald-500">
              <TrendingUp className="w-10 h-10" />
            </div>
            <CardContent className="p-8">
              <p className="text-[10px] font-bold text-muted-foreground mb-1">{t("admin.bookings.stats.cycleCompletion")}</p>
              <h3 className="text-3xl font-bold text-emerald-400 leading-none">{stats.completed}</h3>
            </CardContent>
          </Card>

          <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t transition-all hover:bg-card">
            <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-emerald-500">
              <DollarSign className="w-10 h-10" />
            </div>
            <CardContent className="p-8">
              <p className="text-[10px] font-bold text-muted-foreground mb-1">{t("admin.bookings.stats.grossVelocity")}</p>
              <h3 className="text-3xl font-bold text-foreground leading-none">${stats.totalRevenue.toLocaleString()}</h3>
            </CardContent>
          </Card>
        </div>

        {/* Filters and Actions Tactical Interface */}
        <div className="flex flex-col lg:flex-row items-center justify-between gap-6 px-4">
          <div className="flex flex-wrap items-center gap-3 flex-1">
            <div className="relative group min-w-[320px]">
              <Search className="absolute left-4 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground group-focus-within:text-orange-500 transition-colors" />
              <Input placeholder={t("commonSearch")} value={search} onChange={e => setSearch(e.target.value)} className="bg-card border-border rounded-2xl pl-12 h-14 text-foreground focus:ring-orange-500/20 focus:border-orange-500/40 transition-all font-medium border-l border-t" />
            </div>
            <Select value={filterStatus} onValueChange={setFilterStatus}>
              <SelectTrigger className="w-44 bg-card border-border rounded-2xl h-14 text-foreground font-bold text-[10px] border-l border-t">
                <SelectValue placeholder={t("admin.bookingsmanagement.status")} />
              </SelectTrigger>
              <SelectContent className="bg-[#14151a] border-border rounded-2xl text-muted-foreground">
                <SelectItem value="all">{t("admin.bookings.status.all", "Tümü")}</SelectItem>
                <SelectItem value="PENDING">{statusConfig.PENDING.label}</SelectItem>
                <SelectItem value="CONFIRMED">{statusConfig.CONFIRMED.label}</SelectItem>
                <SelectItem value="COMPLETED">{statusConfig.COMPLETED.label}</SelectItem>
                <SelectItem value="CANCELLED">{statusConfig.CANCELLED.label}</SelectItem>
              </SelectContent>
            </Select>
            <Select value={filterVerification} onValueChange={setFilterVerification}>
              <SelectTrigger className="w-48 bg-card border-border rounded-2xl h-14 text-foreground font-bold text-[10px] border-l border-t">
                <SelectValue placeholder={t("admin.bookingsmanagement.verification")} />
              </SelectTrigger>
              <SelectContent className="bg-[#14151a] border-border rounded-2xl text-muted-foreground">
                <SelectItem value="all">{t("admin.bookings.verification.all", "Tümü")}</SelectItem>
                <SelectItem value="PENDING">{verificationConfig.PENDING.label}</SelectItem>
                <SelectItem value="VERIFIED">{verificationConfig.VERIFIED.label}</SelectItem>
              </SelectContent>
            </Select>
          </div>
          <div className="flex items-center gap-3">
             <Button variant="outline" size="icon" className="h-14 w-14 rounded-2xl border-border bg-card text-muted-foreground hover:text-foreground hover:bg-muted/50 transition-all shadow-xl" onClick={() => setViewMode(viewMode === "table" ? "calendar" : "table")}>
              {viewMode === "table" ? <CalendarDays className="w-5 h-5" /> : <List className="w-5 h-5" />}
            </Button>
            {stats.pendingVerification > 0 && <div className="h-14 px-6 rounded-2xl border border-orange-500/20 bg-orange-500/5 flex items-center gap-3 animate-pulse">
                 <Activity className="w-4 h-4 text-orange-500" />
                 <span className="text-[10px] font-bold text-orange-400">{stats.pendingVerification}{t("admin.bookingsmanagement.critical_verifications")}</span>
              </div>}
          </div>
        </div>

        {viewMode === "table" ? <Card className="bg-card border-border rounded-4xl overflow-hidden shadow-2xl border-l border-t relative">
            <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-blue-600 via-transparent to-transparent opacity-50"></div>
            <CardContent className="p-0">
              <Table>
                <TableHeader className="bg-muted/50 border-b border-border">
                  <TableRow className="border-none hover:bg-transparent">
                    <TableHead className="text-[10px] font-bold text-muted-foreground py-6 px-8 text-nowrap">{t("admin.bookingsmanagement.entity_node")}</TableHead>
                    <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t("admin.bookingsmanagement.property_core")}</TableHead>
                    <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t("admin.bookingsmanagement.temporal_sync")}</TableHead>
                    <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t("admin.bookingsmanagement.status_arc")}</TableHead>
                    <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t("admin.bookingsmanagement.risk_index")}</TableHead>
                    <TableHead className="text-[10px] font-bold text-muted-foreground px-8 text-right">{t("admin.bookingsmanagement.interrogate")}</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {isLoading ? (
                    <TableRow>
                      <TableCell colSpan={6} className="text-center py-12 text-muted-foreground">
                        <Loader2 className="w-8 h-8 animate-spin mx-auto mb-2" />
                        {t("admin.bookingsmanagement.loading", "Yükleniyor...")}
                      </TableCell>
                    </TableRow>
                  ) : filteredBookings.map(booking => <TableRow key={booking.id} className="border-b border-border hover:bg-muted/50 transition-all group">
                      <TableCell className="py-8 px-8">
                        <div className="flex items-center gap-4">
                          <div className="relative">
                            <Avatar className="w-14 h-14 border-2 border-border rounded-2xl">
                              <AvatarImage src={booking.contact.avatar} />
                              <AvatarFallback className="bg-card text-foreground font-bold">
                                {booking.contact.name.split(" ").map(n => n[0]).join("")}
                              </AvatarFallback>
                            </Avatar>
                            <div className="absolute -bottom-1 -right-1 w-5 h-5 rounded-full bg-[#14151a] flex items-center justify-center border border-border shadow-2xl">
                               <Shield className={cn("w-3 h-3", booking.verificationStatus === 'VERIFIED' ? "text-emerald-500" : "text-slate-600")} />
                            </div>
                          </div>
                          <div>
                            <div className="text-lg font-bold text-foreground leading-tight">{booking.contact.name}</div>
                            <div className="text-[10px] font-bold text-muted-foreground leading-none mt-1">{booking.contact.email}</div>
                          </div>
                        </div>
                      </TableCell>
                      <TableCell className="px-8">
                        <div>
                          <div className="text-sm font-bold text-muted-foreground leading-tight mb-1">{booking.listing.title}</div>
                          <div className="text-[10px] font-bold text-slate-600 leading-none -translate-y-px">
                            {booking.listing.property.city}, {booking.listing.property.state}
                          </div>
                        </div>
                      </TableCell>
                      <TableCell className="px-8">
                        <div className="text-sm font-bold text-foreground leading-none mb-1">
                          {new Date(booking.startDate).toLocaleDateString('en-US', {
                      month: 'short',
                      day: 'numeric'
                    })} — {new Date(booking.endDate).toLocaleDateString('en-US', {
                      month: 'short',
                      day: 'numeric'
                    })}
                        </div>
                        <p className="text-[10px] font-bold text-muted-foreground leading-none">
                          {Math.ceil((new Date(booking.endDate).getTime() - new Date(booking.startDate).getTime()) / (1000 * 60 * 60 * 24))}{t("admin.bookingsmanagement.cycles")}</p>
                      </TableCell>
                      <TableCell className="px-8">
                        <Badge className={cn("text-[9px] font-bold   px-3 py-1 rounded-full  border-none shadow-lg", statusConfig[booking.status].color)}>
                          {statusConfig[booking.status].label}
                        </Badge>
                      </TableCell>
                      <TableCell className="px-8">
                          <div className={cn("text-[10px] font-bold   ")}>
                            <span className={cn(getRiskColor(booking.riskScore))}>
                              {getRiskLabel(booking.riskScore)}
                            </span>
                          </div>
                          <div className="mt-1 flex items-center gap-1 opacity-40">
                             <div className="h-1 flex-1 bg-muted/50 rounded-full overflow-hidden">
                                <div className={cn("h-full", booking.riskScore && booking.riskScore > 50 ? "bg-red-500" : "bg-emerald-500")} style={{
                        width: `${booking.riskScore || 0}%`
                      }} />
                             </div>
                          </div>
                      </TableCell>
                      <TableCell className="px-8 text-right">
                        <Button variant="ghost" className="h-12 w-12 rounded-2xl hover:bg-muted/50 text-muted-foreground hover:text-foreground transition-all shadow-xl border border-border hover:border-border" onClick={() => {
                    setSelectedBooking(booking);
                    setDetailsOpen(true);
                  }}>
                          <Eye className="w-5 h-5" />
                        </Button>
                      </TableCell>
                    </TableRow>)}
                </TableBody>
              </Table>
            </CardContent>
          </Card> : <Card className="bg-card border-border rounded-4xl overflow-hidden shadow-2xl border-l border-t relative p-8">
            <CalendarView />
          </Card>}
      </div>

      {/* Booking Details Dialog */}
      <Dialog open={detailsOpen} onOpenChange={setDetailsOpen}>
        <DialogContent className="max-w-4xl bg-[#14151a] border-border text-foreground rounded-3xl overflow-hidden p-0 shadow-[0_0_50px_rgba(0,0,0,0.5)]">
          <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-blue-600 via-transparent to-transparent"></div>
          {selectedBooking && <div className="flex flex-col h-full max-h-[90vh]">
              <DialogHeader className="p-8 border-b border-border bg-muted/50">
                <div className="flex items-center justify-between">
                  <div>
                    <DialogTitle className="text-2xl font-bold flex items-center gap-3 text-foreground">
                      <Zap className="w-6 h-6 text-orange-500" />
                      {t("admin.bookings.intel.title")}
                    </DialogTitle>
                    <DialogDescription className="text-[10px] font-bold text-muted-foreground mt-1">
                      {t("admin.bookings.desc")}
                    </DialogDescription>
                  </div>
                  <Badge className={cn("text-[8px] font-bold   px-3 py-1 rounded-full  border-none shadow-lg", statusConfig[selectedBooking.status].color)}>
                    {statusConfig[selectedBooking.status].label}
                  </Badge>
                </div>
              </DialogHeader>

              <div className="p-8 overflow-y-auto space-y-8 scrollbar-hide">
                {/* Core Data Grid */}
                <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
                  {/* Entity Information */}
                  <Card className="bg-card border-border rounded-2xl overflow-hidden">
                    <CardHeader className="p-6 border-b border-border bg-muted/50">
                      <h4 className="text-[10px] font-bold text-muted-foreground flex items-center gap-2">
                        <UserIcon className="w-3 h-3 text-blue-500" /> {t("admin.bookings.intel.guestIdentity")}
                      </h4>
                    </CardHeader>
                    <CardContent className="p-6 space-y-4">
                      <div className="flex items-center gap-4">
                        <Avatar className="w-16 h-16 border-2 border-border rounded-2xl">
                          <AvatarImage src={selectedBooking.contact.avatar} />
                          <AvatarFallback className="bg-card text-foreground font-bold">
                            {selectedBooking.contact.name.split(" ").map(n => n[0]).join("")}
                          </AvatarFallback>
                        </Avatar>
                        <div>
                          <div className="text-xl font-bold text-foreground leading-tight">{selectedBooking.contact.name}</div>
                          <div className="text-[10px] font-bold text-muted-foreground">{selectedBooking.contact.email}</div>
                          {selectedBooking.contact.phone && <div className="text-[10px] font-bold text-muted-foreground mt-0.5">{selectedBooking.contact.phone}</div>}
                        </div>
                      </div>
                      
                      {selectedBooking.specialRequests && selectedBooking.specialRequests.length > 0 && <div className="pt-4 border-t border-border">
                          <p className="text-[10px] font-bold text-muted-foreground mb-2">{t("admin.bookingsmanagement.tactical_requirements")}</p>
                          <div className="flex flex-wrap gap-2">
                            {selectedBooking.specialRequests.map((request, index) => <Badge key={index} variant="outline" className="bg-muted/50 border-border text-muted-foreground text-[8px] font-bold rounded-md">
                                {request}
                              </Badge>)}
                          </div>
                        </div>}
                    </CardContent>
                  </Card>

                  {/* Asset Core Information */}
                  <Card className="bg-card border-border rounded-2xl overflow-hidden">
                    <CardHeader className="p-6 border-b border-border bg-muted/50">
                      <h4 className="text-[10px] font-bold text-muted-foreground flex items-center gap-2">
                        <MapPin className="w-3 h-3 text-orange-500" /> {t("propertyCore")}
                      </h4>
                    </CardHeader>
                    <CardContent className="p-6 space-y-4">
                      <div>
                        <div className="text-lg font-bold text-foreground leading-tight">{selectedBooking.listing.title}</div>
                        <div className="text-[10px] font-bold text-muted-foreground mt-1">
                          {selectedBooking.listing.property.addressLine1}, {selectedBooking.listing.property.city}, {selectedBooking.listing.property.state}
                        </div>
                      </div>
                      
                      <div className="grid grid-cols-2 gap-4 pt-4 border-t border-border">
                        <div className="space-y-1">
                          <p className="text-[10px] font-bold text-muted-foreground">{t("admin.bookingsmanagement.checkin_sequence")}</p>
                          <p className="text-sm font-bold text-blue-400 font-mono">{new Date(selectedBooking.startDate).toLocaleDateString()}</p>
                        </div>
                        <div className="space-y-1">
                          <p className="text-[10px] font-bold text-muted-foreground">{t("admin.bookingsmanagement.departure_sync")}</p>
                          <p className="text-sm font-bold text-orange-400 font-mono">{new Date(selectedBooking.endDate).toLocaleDateString()}</p>
                        </div>
                      </div>
                    </CardContent>
                  </Card>
                </div>

                {/* Performance & Finance Tactical Strip */}
                <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
                  <Card className="bg-muted/50 border-border rounded-2xl p-6 text-center shadow-inner">
                    <p className="text-[10px] font-bold text-muted-foreground mb-2">{t("verification") || "Verification Status"}</p>
                    <Badge className={cn("text-[9px] font-bold   px-4 py-1.5 rounded-full  border-none shadow-lg", verificationConfig[selectedBooking.verificationStatus].color)}>
                      {verificationConfig[selectedBooking.verificationStatus].label}
                    </Badge>
                  </Card>

                  <Card className="bg-muted/50 border-border rounded-2xl p-6 text-center shadow-inner">
                    <p className="text-[10px] font-bold text-muted-foreground mb-2">{t("admin.bookingsmanagement.risk_assessment")}</p>
                    <div className={cn("text-sm font-bold  ", getRiskColor(selectedBooking.riskScore))}>
                      {getRiskLabel(selectedBooking.riskScore)}
                    </div>
                    <div className="text-[9px] font-bold text-muted-foreground font-mono mt-1">{t("admin.bookingsmanagement.score")}{selectedBooking.riskScore}</div>
                  </Card>

                  <Card className="bg-muted/50 border-border rounded-2xl p-6 text-center shadow-inner">
                    <p className="text-[10px] font-bold text-muted-foreground mb-2">{t("admin.bookingsmanagement.gross_velocity")}</p>
                    <div className="text-xl font-bold text-foreground font-mono">
                      ${selectedBooking.totalPrice?.toLocaleString()}
                    </div>
                    <div className="text-[9px] font-bold text-blue-400/60 mt-1">{t("admin.bookingsmanagement.confirmed_revenue")}</div>
                  </Card>
                </div>

                {/* Financial Detail Matrix */}
                <Card className="bg-muted/50 border-border rounded-2xl overflow-hidden">
                  <CardHeader className="p-6 border-b border-border bg-muted/50">
                    <h4 className="text-[10px] font-bold text-muted-foreground flex items-center gap-2">
                      <DollarSign className="w-3 h-3 text-emerald-500" /> {t("economicParameters")}
                    </h4>
                  </CardHeader>
                  <CardContent className="p-8">
                    <div className="grid grid-cols-2 md:grid-cols-4 gap-8">
                      <div className="space-y-1">
                        <p className="text-[10px] font-bold text-muted-foreground">{t("admin.bookingsmanagement.base_rate_cycle")}</p>
                        <p className="text-lg font-bold text-foreground font-mono">${selectedBooking.listing.price}</p>
                      </div>
                      <div className="space-y-1">
                        <p className="text-[10px] font-bold text-muted-foreground">{t("admin.bookingsmanagement.temporal_span")}</p>
                        <p className="text-lg font-bold text-foreground font-mono">
                          {Math.ceil((new Date(selectedBooking.endDate).getTime() - new Date(selectedBooking.startDate).getTime()) / (1000 * 60 * 60 * 24))}{t("admin.bookingsmanagement.cycles")}</p>
                      </div>
                      <div className="space-y-1">
                        <p className="text-[10px] font-bold text-muted-foreground">{t("admin.bookingsmanagement.collateral_held")}</p>
                        <p className="text-lg font-bold text-foreground font-mono">${selectedBooking.depositAmount?.toLocaleString() || '0'}</p>
                      </div>
                      <div className="space-y-1">
                        <p className="text-[10px] font-bold text-muted-foreground">{t("admin.bookingsmanagement.processing_fee")}</p>
                        <p className="text-lg font-bold text-emerald-400 font-mono">{t("admin.bookingsmanagement.included")}</p>
                      </div>
                    </div>
                  </CardContent>
                </Card>

                {/* Sync Logs / Notes */}
                {selectedBooking.notes && <div className="space-y-3">
                    <p className="text-[10px] font-bold text-muted-foreground ml-1 flex items-center gap-2">
                       <FileText className="w-3 h-3" /> {t("syncNotes")}
                    </p>
                    <div className="bg-card border border-border rounded-2xl p-6 text-sm text-muted-foreground font-medium leading-relaxed border-l-orange-500/40 border-l-2">
                      {selectedBooking.notes}
                    </div>
                  </div>}
              </div>

              <DialogFooter className="p-8 bg-card border-t border-border flex gap-4">
                <Button variant="ghost" className="flex-1 h-14 rounded-2xl font-bold text-[10px] hover:bg-muted/50 transition-all text-muted-foreground hover:text-foreground" onClick={() => setDetailsOpen(false)}>{t("admin.bookingsmanagement.close_intel")}</Button>
                {selectedBooking && selectedBooking.status === "PENDING" && <Button className="flex-2 h-14 rounded-2xl bg-blue-600 hover:bg-blue-500 text-foreground font-bold text-[10px] shadow-xl shadow-blue-600/30 gap-2" onClick={() => {
              handleStatusChange(selectedBooking.id, "CONFIRMED");
              setDetailsOpen(false);
            }}>{t("admin.bookingsmanagement.confirm_synchronization")}<ArrowUpRight className="w-3 h-3" />
                  </Button>}
              </DialogFooter>
            </div>}
        </DialogContent>
      </Dialog>
    </PageShell>;
}