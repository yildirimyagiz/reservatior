"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Search, Shield, CheckCircle, Clock, AlertCircle, Zap, ArrowUpRight } from "lucide-react";
import { motion } from "framer-motion";
import { cn } from "@/lib/utils";
import { useTranslation } from "react-i18next";

type BookingStatus = "PENDING" | "CONFIRMED" | "CANCELLED" | "COMPLETED";
type SecurityRiskLevel = "LOW" | "MEDIUM" | "HIGH";

interface Booking {
  id: string;
  propertyId: string;
  guestName: string;
  checkIn: string;
  checkOut: string;
  status: BookingStatus;
  ownershipVerified: boolean;
  securityRiskLevel: SecurityRiskLevel;
  amount: number;
}

const mockBookings: Booking[] = [
  {
    id: "1",
    propertyId: "PROP-001",
    guestName: "John Doe",
    checkIn: "2024-07-15",
    checkOut: "2024-07-20",
    status: "CONFIRMED",
    ownershipVerified: true,
    securityRiskLevel: "LOW",
    amount: 1500
  },
  {
    id: "2",
    propertyId: "PROP-002",
    guestName: "Jane Smith",
    checkIn: "2024-07-18",
    checkOut: "2024-07-25",
    status: "PENDING",
    ownershipVerified: false,
    securityRiskLevel: "MEDIUM",
    amount: 2100
  },
  {
    id: "3",
    propertyId: "PROP-003",
    guestName: "Bob Johnson",
    checkIn: "2024-07-10",
    checkOut: "2024-07-15",
    status: "COMPLETED",
    ownershipVerified: true,
    securityRiskLevel: "LOW",
    amount: 950
  }
];

const statusConfig: Record<BookingStatus, { label: string; color: string }> = {
  PENDING: { label: "Pending", color: "bg-yellow-500/20 text-yellow-400 border-yellow-500/30" },
  CONFIRMED: { label: "Confirmed", color: "bg-green-500/20 text-green-400 border-green-500/30" },
  CANCELLED: { label: "Cancelled", color: "bg-red-500/20 text-red-400 border-red-500/30" },
  COMPLETED: { label: "Completed", color: "bg-blue-500/20 text-blue-400 border-blue-500/30" }
};

const riskConfig: Record<SecurityRiskLevel, { label: string; icon: React.ComponentType<{ className?: string }>; color: string }> = {
  LOW: { label: "Low Risk", icon: CheckCircle, color: "text-green-400" },
  MEDIUM: { label: "Medium Risk", icon: AlertCircle, color: "text-yellow-400" },
  HIGH: { label: "High Risk", icon: Shield, color: "text-red-400" }
};

export default function BookingsPage() {
    const { t } = useTranslation();
  const router = useRouter();
  const [filters, setFilters] = useState({
    status: undefined as BookingStatus | undefined,
    search: ""
  });

  const filteredBookings = mockBookings.filter(booking => {
    if (filters.status && booking.status !== filters.status) return false;
    if (filters.search && !booking.guestName.toLowerCase().includes(filters.search.toLowerCase())) return false;
    return true;
  });

  const totalRevenue = filteredBookings.reduce((sum, b) => sum + b.amount, 0);
  const pendingCount = filteredBookings.filter(b => b.status === "PENDING").length;
  const verifiedCount = filteredBookings.filter(b => b.ownershipVerified).length;

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-purple-900 to-slate-900">
      <div className="container mx-auto px-4 py-8">
        {/* Header */}
        <motion.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="mb-8"
        >
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-white mb-2">{t("bookings.bookingspage.auto_ext_1")}</h1>
              <p className="text-gray-400">{t("bookings.bookingspage.auto_ext_2")}</p>
            </div>
            <Button
              onClick={() => router.push('/dashboard')}
              className="bg-purple-600 hover:bg-purple-700"
            >
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("bookings.bookingspage.auto_ext_3")}
                                      </Button>
          </div>
        </motion.div>

        {/* Stats */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.1 }}
          >
            <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
              <CardContent className="p-6">
                <div className="flex items-center justify-between">
                  <div>
                    <div className="text-sm text-gray-400 mb-1">{t("bookings.bookingspage.auto_ext_4")}</div>
                    <div className="text-2xl font-bold text-white">${totalRevenue.toLocaleString()}</div>
                  </div>
                  <div className="p-3 rounded-lg bg-green-500/10">
                    <Zap className="w-6 h-6 text-green-400" />
                  </div>
                </div>
              </CardContent>
            </Card>
          </motion.div>

          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.2 }}
          >
            <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
              <CardContent className="p-6">
                <div className="flex items-center justify-between">
                  <div>
                    <div className="text-sm text-gray-400 mb-1">{t("bookings.bookingspage.auto_ext_5")}</div>
                    <div className="text-2xl font-bold text-white">{pendingCount}</div>
                  </div>
                  <div className="p-3 rounded-lg bg-yellow-500/10">
                    <Clock className="w-6 h-6 text-yellow-400" />
                  </div>
                </div>
              </CardContent>
            </Card>
          </motion.div>

          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.3 }}
          >
            <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
              <CardContent className="p-6">
                <div className="flex items-center justify-between">
                  <div>
                    <div className="text-sm text-gray-400 mb-1">{t("bookings.bookingspage.auto_ext_6")}</div>
                    <div className="text-2xl font-bold text-white">{verifiedCount}</div>
                  </div>
                  <div className="p-3 rounded-lg bg-blue-500/10">
                    <Shield className="w-6 h-6 text-blue-400" />
                  </div>
                </div>
              </CardContent>
            </Card>
          </motion.div>
        </div>

        {/* Filters */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.4 }}
          className="mb-6"
        >
          <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
            <CardContent className="p-4">
              <div className="flex gap-4">
                <div className="flex-1">
                  <div className="relative">
                    <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" />
                    <Input
                      placeholder="Search by guest name..."
                      value={filters.search}
                      onChange={(e) => setFilters({ ...filters, search: e.target.value })}
                      className="pl-10 bg-white/10 border-purple-500/30 text-white placeholder:text-gray-400"
                    />
                  </div>
                </div>
                <Select
                  value={filters.status}
                  onValueChange={(value) => setFilters({ ...filters, status: value as BookingStatus | undefined })}
                >
                  <SelectTrigger className="w-48 bg-white/10 border-purple-500/30 text-white">
                    <SelectValue placeholder="All Status" />
                  </SelectTrigger>
                  <SelectContent className="bg-slate-900 border-purple-500/30">
                    <SelectItem value="undefined">{t("bookings.bookingspage.auto_ext_7")}</SelectItem>
                    <SelectItem value="PENDING">{t("bookings.bookingspage.auto_ext_8")}</SelectItem>
                    <SelectItem value="CONFIRMED">{t("bookings.bookingspage.auto_ext_9")}</SelectItem>
                    <SelectItem value="CANCELLED">{t("bookings.bookingspage.auto_ext_10")}</SelectItem>
                    <SelectItem value="COMPLETED">{t("bookings.bookingspage.auto_ext_11")}</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </CardContent>
          </Card>
        </motion.div>

        {/* Bookings Table */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.5 }}
        >
          <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
            <CardHeader>
              <CardTitle className="text-white">{t("bookings.bookingspage.auto_ext_12")}</CardTitle>
            </CardHeader>
            <CardContent>
              <Table>
                <TableHeader>
                  <TableRow className="border-purple-500/20">
                    <TableHead className="text-gray-400">{t("bookings.bookingspage.auto_ext_13")}</TableHead>
                    <TableHead className="text-gray-400">{t("bookings.bookingspage.auto_ext_14")}</TableHead>
                    <TableHead className="text-gray-400">{t("bookings.bookingspage.auto_ext_15")}</TableHead>
                    <TableHead className="text-gray-400">{t("bookings.bookingspage.auto_ext_16")}</TableHead>
                    <TableHead className="text-gray-400">{t("bookings.bookingspage.auto_ext_17")}</TableHead>
                    <TableHead className="text-gray-400">{t("bookings.bookingspage.auto_ext_18")}</TableHead>
                    <TableHead className="text-gray-400">{t("bookings.bookingspage.auto_ext_19")}</TableHead>
                    <TableHead className="text-gray-400">{t("bookings.bookingspage.auto_ext_20")}</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {filteredBookings.map((booking) => {
                      const { t } = useTranslation();
                    const statusInfo = statusConfig[booking.status];
                    const riskInfo = riskConfig[booking.securityRiskLevel];
                    const RiskIcon = riskInfo.icon;
                    
                    return (
                      <TableRow
                        key={booking.id}
                        className="border-purple-500/10 hover:bg-white/5"
                      >
                        <TableCell className="text-white font-medium">{booking.guestName}</TableCell>
                        <TableCell className="text-gray-300">{booking.propertyId}</TableCell>
                        <TableCell className="text-gray-300">{booking.checkIn}</TableCell>
                        <TableCell className="text-gray-300">{booking.checkOut}</TableCell>
                        <TableCell>
                          <Badge variant="outline" className={statusInfo.color}>
                            {statusInfo.label}
                          </Badge>
                        </TableCell>
                        <TableCell>
                          <div className={cn("flex items-center gap-2", riskInfo.color)}>
                            <RiskIcon className="w-4 h-4" />
                            <span className="text-sm">{riskInfo.label}</span>
                          </div>
                        </TableCell>
                        <TableCell className="text-white font-medium">${booking.amount.toLocaleString()}</TableCell>
                        <TableCell>
                          {booking.ownershipVerified ? (
                            <CheckCircle className="w-5 h-5 text-green-400" />
                          ) : (
                            <AlertCircle className="w-5 h-5 text-yellow-400" />
                          )}
                        </TableCell>
                      </TableRow>
                    );
                  })}
                </TableBody>
              </Table>
            </CardContent>
          </Card>
        </motion.div>
      </div>
    </div>
  );
}
