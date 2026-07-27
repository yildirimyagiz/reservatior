"use client";

import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { DollarSign, Calendar, CheckCircle, Clock, AlertCircle } from "lucide-react";
import { useTranslation } from "react-i18next";

export function CommissionPayouts() {
  const { t } = useTranslation();

  // Mock data - replace with actual API calls
  const payouts = [
    {
      id: "CP-001",
      property: "Luxury Apartment - Istanbul",
      amount: 45000,
      currency: "USD",
      status: "PAID",
      date: "2026-07-15",
      commissionRate: 2.5
    },
    {
      id: "CP-002",
      property: "Villa - Antalya",
      amount: 32000,
      currency: "USD",
      status: "PENDING",
      date: "2026-07-20",
      commissionRate: 2.0
    },
    {
      id: "CP-003",
      property: "Commercial - Izmir",
      amount: 28000,
      currency: "USD",
      status: "PROCESSING",
      date: "2026-07-22",
      commissionRate: 3.0
    }
  ];

  const getStatusBadge = (status: string) => {
    const statusConfig = {
      PAID: { color: "bg-green-500", icon: CheckCircle, label: "Paid" },
      PENDING: { color: "bg-yellow-500", icon: Clock, label: "Pending" },
      PROCESSING: { color: "bg-blue-500", icon: Clock, label: "Processing" },
      FAILED: { color: "bg-red-500", icon: AlertCircle, label: "Failed" }
    };
    const config = statusConfig[status as keyof typeof statusConfig] || statusConfig.PENDING;
    const Icon = config.icon;
    
    return (
      <Badge className={`${config.color} text-white`}>
        <Icon className="w-3 h-3 mr-1" />
        {config.label}
      </Badge>
    );
  };

  const totalPayouts = payouts.reduce((sum, p) => sum + p.amount, 0);
  const paidAmount = payouts.filter(p => p.status === "PAID").reduce((sum, p) => sum + p.amount, 0);
  const pendingAmount = payouts.filter(p => p.status === "PENDING" || p.status === "PROCESSING").reduce((sum, p) => sum + p.amount, 0);

  return (
    <div className="p-8 space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold text-gray-900">Commission Payouts</h1>
          <p className="text-gray-600 mt-1">Track and manage your commission earnings</p>
        </div>
        <Button className="bg-blue-600 hover:bg-blue-700">
          <DollarSign className="w-4 h-4 mr-2" />
          Request Payout
        </Button>
      </div>

      {/* Summary Cards */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        <Card>
          <CardHeader className="pb-3">
            <CardTitle className="text-sm font-medium text-gray-600">Total Earnings</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-gray-900">${totalPayouts.toLocaleString()}</div>
            <p className="text-xs text-gray-500 mt-1">All time</p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="pb-3">
            <CardTitle className="text-sm font-medium text-gray-600">Paid Amount</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-green-600">${paidAmount.toLocaleString()}</div>
            <p className="text-xs text-gray-500 mt-1">Successfully transferred</p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="pb-3">
            <CardTitle className="text-sm font-medium text-gray-600">Pending Amount</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-yellow-600">${pendingAmount.toLocaleString()}</div>
            <p className="text-xs text-gray-500 mt-1">Awaiting processing</p>
          </CardContent>
        </Card>
      </div>

      {/* Payouts Table */}
      <Card>
        <CardHeader>
          <CardTitle>Recent Payouts</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="space-y-4">
            {payouts.map((payout) => (
              <div key={payout.id} className="flex items-center justify-between p-4 border border-gray-200 rounded-lg hover:bg-gray-50 transition-colors">
                <div className="flex-1">
                  <div className="flex items-center gap-3">
                    <div className="w-10 h-10 rounded-full bg-blue-100 flex items-center justify-center">
                      <DollarSign className="w-5 h-5 text-blue-600" />
                    </div>
                    <div>
                      <h3 className="font-semibold text-gray-900">{payout.property}</h3>
                      <div className="flex items-center gap-2 text-sm text-gray-600">
                        <Calendar className="w-4 h-4" />
                        {payout.date}
                      </div>
                    </div>
                  </div>
                </div>

                <div className="flex items-center gap-6">
                  <div className="text-right">
                    <div className="font-semibold text-gray-900">${payout.amount.toLocaleString()}</div>
                    <div className="text-xs text-gray-500">{payout.commissionRate}% commission</div>
                  </div>
                  {getStatusBadge(payout.status)}
                </div>
              </div>
            ))}
          </div>
        </CardContent>
      </Card>
    </div>
  );
}
