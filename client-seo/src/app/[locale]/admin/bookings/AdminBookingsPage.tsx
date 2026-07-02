"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { 
  Calendar, 
  Search, 
  Filter, 
  ArrowUpRight,
  Building2,
  Clock,
  CheckCircle,
  XCircle,
  AlertCircle
} from "lucide-react";
import { motion } from "framer-motion";

interface Booking {
  id: string;
  guestName: string;
  propertyName: string;
  checkIn: string;
  checkOut: string;
  status: "CONFIRMED" | "PENDING" | "CANCELLED" | "COMPLETED";
  totalAmount: number;
}

const mockBookings: Booking[] = [
  { id: "1", guestName: "John Doe", propertyName: "Luxury Villa", checkIn: "2024-04-15", checkOut: "2024-04-20", status: "CONFIRMED", totalAmount: 5000 },
  { id: "2", guestName: "Jane Smith", propertyName: "Downtown Apartment", checkIn: "2024-04-18", checkOut: "2024-04-22", status: "PENDING", totalAmount: 2000 },
  { id: "3", guestName: "Bob Wilson", propertyName: "Beachfront Condo", checkIn: "2024-04-10", checkOut: "2024-04-14", status: "COMPLETED", totalAmount: 3500 },
  { id: "4", guestName: "Alice Brown", propertyName: "Studio Loft", checkIn: "2024-04-25", checkOut: "2024-04-28", status: "CANCELLED", totalAmount: 1200 },
  { id: "5", guestName: "Charlie Davis", propertyName: "Penthouse Suite", checkIn: "2024-05-01", checkOut: "2024-05-07", status: "CONFIRMED", totalAmount: 8000 }
];

const STATUS_COLORS: Record<string, string> = {
  CONFIRMED: "bg-green-500/20 text-green-400",
  PENDING: "bg-yellow-500/20 text-yellow-400",
  CANCELLED: "bg-red-500/20 text-red-400",
  COMPLETED: "bg-blue-500/20 text-blue-400"
};

const STATUS_ICONS: Record<string, any> = {
  CONFIRMED: CheckCircle,
  PENDING: AlertCircle,
  CANCELLED: XCircle,
  COMPLETED: CheckCircle
};

export default function AdminBookingsPage() {
  const router = useRouter();
  const [searchTerm, setSearchTerm] = useState("");

  const filteredBookings = mockBookings.filter(booking => 
    booking.guestName.toLowerCase().includes(searchTerm.toLowerCase()) ||
    booking.propertyName.toLowerCase().includes(searchTerm.toLowerCase())
  );

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-purple-900 to-slate-900">
      <div className="container mx-auto px-4 py-8">
        <motion.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="mb-8"
        >
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-white mb-2">Bookings Management</h1>
              <p className="text-gray-400">Manage all bookings and reservations</p>
            </div>
            <Button
              onClick={() => router.push('/admin/dashboard')}
              className="bg-purple-600 hover:bg-purple-700"
            >
              <ArrowUpRight className="w-4 h-4 mr-2" />
              Dashboard
            </Button>
          </div>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
          className="mb-6"
        >
          <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
            <CardContent className="p-4">
              <div className="flex gap-4">
                <div className="flex-1">
                  <div className="relative">
                    <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" />
                    <Input
                      placeholder="Search bookings..."
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-white/10 border-purple-500/30 text-white placeholder:text-gray-400"
                    />
                  </div>
                </div>
                <Button variant="outline" className="bg-white/10 border-purple-500/30 text-white">
                  <Filter className="w-4 h-4 mr-2" />
                  Filter
                </Button>
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
            <CardHeader>
              <CardTitle className="text-white flex items-center gap-2">
                <Calendar className="w-5 h-5" />
                All Bookings ({filteredBookings.length})
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {filteredBookings.map((booking) => {
                  const StatusIcon = STATUS_ICONS[booking.status];
                  return (
                    <div
                      key={booking.id}
                      className="flex items-center justify-between p-4 bg-white/5 rounded-lg hover:bg-white/10 transition-colors"
                    >
                      <div className="flex items-center gap-4">
                        <div className="w-10 h-10 rounded-full bg-purple-500/20 flex items-center justify-center text-purple-400 font-bold">
                          {booking.guestName.split(' ').map(n => n[0]).join('')}
                        </div>
                        <div>
                          <div className="text-white font-medium">{booking.guestName}</div>
                          <div className="text-sm text-gray-400 flex items-center gap-2">
                            <Building2 className="w-3 h-3" />
                            {booking.propertyName}
                          </div>
                        </div>
                      </div>
                      <div className="flex items-center gap-4">
                        <div className="text-sm text-gray-400 flex items-center gap-1">
                          <Clock className="w-3 h-3" />
                          {booking.checkIn} - {booking.checkOut}
                        </div>
                        <div className={`flex items-center gap-1 ${STATUS_COLORS[booking.status]} px-2 py-1 rounded`}>
                          <StatusIcon className="w-3 h-3" />
                          <span className="text-xs font-medium">{booking.status}</span>
                        </div>
                        <div className="text-white font-bold">
                          ${booking.totalAmount.toLocaleString()}
                        </div>
                      </div>
                    </div>
                  );
                })}
              </div>
            </CardContent>
          </Card>
        </motion.div>
      </div>
    </div>
  );
}
