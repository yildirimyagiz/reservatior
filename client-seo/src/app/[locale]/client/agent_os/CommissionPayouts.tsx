"use client";

import { useState, useEffect, useRef } from "react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import {
  Wallet, ArrowRightLeft, Clock, Zap, Building2, CheckCircle2,
  TrendingUp, CalendarDays, Activity, CircleDot
} from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { io } from "socket.io-client";
import { useBfcache } from "@/hooks/use-bfcache";

interface Commission {
  id: string;
  property: string;
  value: number;
  commission: number;
  status: "AWAITING_SETTLEMENT" | "PAID";
}

interface StreamEvent {
  id: string;
  type: string;
  label: string;
  time: string;
}

const EVENT_LABELS: Record<string, string> = {
  CommissionCreated: "💰 New commission created",
  CommissionAdvanceOffered: "⚡ Advance offer generated",
  CommissionAdvanceAccepted: "✅ Advance accepted by agent",
  CommissionPaid: "🏦 Commission paid out",
  LeadCreated: "🎯 New lead captured",
  AdGenerated: "🤖 AI ad creative ready",
  DealClosed: "🤝 Deal closed",
};

export function CommissionPayouts() {
  const { toast } = useToast();
  const [commissions, setCommissions] = useState<Commission[]>([
    {
      id: "comm_123abc",
      property: "Luxury Villa Dubai",
      value: 1200000,
      commission: 36000,
      status: "AWAITING_SETTLEMENT"
    }
  ]);
  const [isProcessing, setIsProcessing] = useState<string | null>(null);
  const [stream, setStream] = useState<StreamEvent[]>([]);
  const streamRef = useRef<HTMLDivElement>(null);

  const wsRef = useRef<ReturnType<typeof io> | null>(null);

  // Revenue forecast (mock — in prod, fetch from /api/v1/commissions/forecast)
  const forecast = {
    pendingDeals: 120000,
    expectedCommission: 18500,
    availableAdvance: Math.round(18500 * 0.875),
    nextSettlementDays: 14,
  };

  useBfcache(() => {
    wsRef.current?.disconnect();
    wsRef.current = null;
  });

  useEffect(() => {
    const SOCKET_URL = process.env.NEXT_PUBLIC_WS_URL || "http://localhost:3002";
    const socket = io(SOCKET_URL, { transports: ["websocket"] });
    wsRef.current = socket;

    socket.on("notification:new", (event: { type: string; payload: any }) => {
      const label = EVENT_LABELS[event.type] || `📡 ${event.type}`;
      setStream(prev => [
        {
          id: `${Date.now()}-${Math.random()}`,
          type: event.type,
          label,
          time: new Date().toLocaleTimeString(),
        },
        ...prev.slice(0, 49),
      ]);
    });

    return () => {
      socket.disconnect();
      wsRef.current = null;
    };
  }, []);

  useEffect(() => {
    if (streamRef.current) streamRef.current.scrollTop = 0;
  }, [stream]);

  const handleInstantPayout = async (id: string) => {
    setIsProcessing(id);
    try {
      await new Promise(r => setTimeout(r, 1500));
      setCommissions(prev => prev.filter(c => c.id !== id));
      toast({
        title: "Payout Processing 🚀",
        description: "Your instant advance is on its way to your account.",
      });
    } finally {
      setIsProcessing(null);
    }
  };

  const handleInstallments = async (id: string) => {
    setIsProcessing(id);
    try {
      await new Promise(r => setTimeout(r, 1500));
      setCommissions(prev => prev.filter(c => c.id !== id));
      toast({
        title: "Installment Plan Activated 📅",
        description: "You will receive monthly payouts for the next 12 months.",
      });
    } finally {
      setIsProcessing(null);
    }
  };

  return (
    <div className="p-6 max-w-7xl mx-auto space-y-8">

      {/* Header */}
      <div>
        <h1 className="text-3xl font-bold flex items-center gap-2">
          <Wallet className="w-8 h-8 text-primary" />
          Commission Payouts & Advances
        </h1>
        <p className="text-muted-foreground mt-2">
          Real-time revenue infrastructure — from deal close to instant liquidity.
        </p>
      </div>

      {/* Revenue Forecast */}
      <Card className="bg-gradient-to-br from-slate-900/80 via-slate-900/60 to-slate-800/40 border-slate-700/50 shadow-xl">
        <CardHeader className="pb-2">
          <CardTitle className="text-base flex items-center gap-2 text-slate-300">
            <TrendingUp className="w-4 h-4 text-emerald-400" />
            Upcoming Revenue Forecast
          </CardTitle>
        </CardHeader>
        <CardContent>
          <div className="grid grid-cols-2 lg:grid-cols-4 gap-6">
            <div>
              <p className="text-xs text-slate-500 mb-1">Pending Deals</p>
              <p className="text-2xl font-bold text-white">${forecast.pendingDeals.toLocaleString()}</p>
            </div>
            <div>
              <p className="text-xs text-slate-500 mb-1">Expected Commission</p>
              <p className="text-2xl font-bold text-emerald-400">${forecast.expectedCommission.toLocaleString()}</p>
            </div>
            <div>
              <p className="text-xs text-slate-500 mb-1">Available Advance</p>
              <p className="text-2xl font-bold text-blue-400">${forecast.availableAdvance.toLocaleString()}</p>
            </div>
            <div>
              <p className="text-xs text-slate-500 mb-1">Next Settlement</p>
              <p className="text-2xl font-bold text-amber-400 flex items-center gap-2">
                <CalendarDays className="w-5 h-5" />
                {forecast.nextSettlementDays} days
              </p>
            </div>
          </div>
        </CardContent>
      </Card>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">

        {/* Left — Pending Commissions */}
        <div className="lg:col-span-2 space-y-6">
          <h2 className="text-lg font-semibold text-slate-200">Pending Commissions</h2>

          {commissions.length === 0 ? (
            <div className="flex flex-col items-center justify-center p-12 border border-dashed border-slate-700 rounded-xl text-slate-500">
              <CheckCircle2 className="w-12 h-12 mb-4 text-emerald-500/40" />
              <h3 className="text-lg font-medium text-white">All caught up!</h3>
              <p className="text-sm text-center max-w-md mt-2">
                No pending commissions. Close more deals to unlock liquidity options.
              </p>
            </div>
          ) : (
            commissions.map(comm => (
              <div key={comm.id} className="space-y-4">

                {/* Deal Info */}
                <Card className="bg-slate-900/50 border-slate-800">
                  <CardContent className="p-4">
                    <div className="flex items-center justify-between mb-3">
                      <div className="flex items-center gap-2">
                        <Building2 className="w-4 h-4 text-blue-400" />
                        <span className="font-semibold text-white">{comm.property}</span>
                      </div>
                      <Badge variant="outline" className="bg-amber-500/10 text-amber-500 border-amber-500/20 text-xs">
                        <Clock className="w-3 h-3 mr-1" />
                        {comm.status.replace(/_/g, " ")}
                      </Badge>
                    </div>
                    <div className="grid grid-cols-3 gap-4 text-sm">
                      <div>
                        <p className="text-xs text-slate-500">Deal Value</p>
                        <p className="font-medium">${comm.value.toLocaleString()}</p>
                      </div>
                      <div>
                        <p className="text-xs text-slate-500">Commission</p>
                        <p className="font-bold text-emerald-400">${comm.commission.toLocaleString()}</p>
                      </div>
                      <div>
                        <p className="text-xs text-slate-500">Fee Rate</p>
                        <p className="font-medium text-slate-300">12.5%</p>
                      </div>
                    </div>
                  </CardContent>
                </Card>

                {/* Payout Options */}
                <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">

                  {/* Instant Advance */}
                  <Card className="border-emerald-500/30 bg-emerald-950/10 shadow-lg shadow-emerald-900/10">
                    <CardHeader className="pb-2">
                      <CardTitle className="text-base flex items-center gap-2 text-emerald-400">
                        <Zap className="w-4 h-4" /> Instant Advance
                      </CardTitle>
                      <CardDescription className="text-xs">Get paid within minutes</CardDescription>
                    </CardHeader>
                    <CardContent className="space-y-4">
                      <div>
                        <p className="text-xs text-slate-500">You receive</p>
                        <p className="text-3xl font-bold text-white">
                          ${(comm.commission * 0.875).toLocaleString()}
                        </p>
                        <p className="text-xs text-slate-500 mt-0.5">
                          Fee: <span className="text-red-400">−${(comm.commission * 0.125).toLocaleString()}</span>
                        </p>
                      </div>
                      <Button
                        className="w-full bg-emerald-600 hover:bg-emerald-500 text-white font-semibold"
                        onClick={() => handleInstantPayout(comm.id)}
                        disabled={isProcessing === comm.id}
                      >
                        {isProcessing === comm.id ? "Processing..." : "Accept Instant Payout"}
                      </Button>
                    </CardContent>
                  </Card>

                  {/* Installment */}
                  <Card className="border-blue-500/30 bg-blue-950/10 shadow-lg shadow-blue-900/10">
                    <CardHeader className="pb-2">
                      <CardTitle className="text-base flex items-center gap-2 text-blue-400">
                        <ArrowRightLeft className="w-4 h-4" /> 12-Month Plan
                      </CardTitle>
                      <CardDescription className="text-xs">Convert to predictable income</CardDescription>
                    </CardHeader>
                    <CardContent className="space-y-4">
                      <div>
                        <p className="text-xs text-slate-500">Monthly payout</p>
                        <p className="text-3xl font-bold text-white">
                          ${Math.round(comm.commission / 12).toLocaleString()}
                        </p>
                        <p className="text-xs text-blue-400 mt-0.5">
                          Total: ${comm.commission.toLocaleString()} over 12 mo
                        </p>
                      </div>
                      <Button
                        variant="outline"
                        className="w-full border-blue-500/50 text-blue-400 hover:bg-blue-500/10"
                        onClick={() => handleInstallments(comm.id)}
                        disabled={isProcessing === comm.id}
                      >
                        {isProcessing === comm.id ? "Processing..." : "Convert To Installments"}
                      </Button>
                    </CardContent>
                  </Card>

                </div>
              </div>
            ))
          )}
        </div>

        {/* Right — Live Event Stream */}
        <div className="space-y-4">
          <h2 className="text-lg font-semibold text-slate-200 flex items-center gap-2">
            <Activity className="w-5 h-5 text-emerald-400" />
            Live Event Stream
            <span className="ml-auto flex items-center gap-1 text-xs text-emerald-400 font-normal">
              <CircleDot className="w-3 h-3 animate-pulse" /> LIVE
            </span>
          </h2>

          <Card className="bg-slate-950/60 border-slate-800 h-[520px] overflow-hidden">
            <CardContent className="p-0 h-full">
              <div
                ref={streamRef}
                className="h-full overflow-y-auto p-3 space-y-2"
              >
                {stream.length === 0 ? (
                  <div className="flex flex-col items-center justify-center h-full text-slate-600 text-sm text-center px-4">
                    <Activity className="w-8 h-8 mb-3 opacity-30" />
                    Waiting for events…
                    <span className="text-xs mt-1 opacity-60">
                      Events from all domain modules appear here in real-time.
                    </span>
                  </div>
                ) : (
                  stream.map(ev => (
                    <div
                      key={ev.id}
                      className="flex items-start gap-2 p-2 rounded-lg bg-slate-900/50 border border-slate-800"
                    >
                      <div className="flex-1 min-w-0">
                        <p className="text-xs text-slate-200 truncate">{ev.label}</p>
                        <p className="text-[10px] text-slate-600 mt-0.5">{ev.type}</p>
                      </div>
                      <span className="text-[10px] text-slate-600 shrink-0 mt-0.5">{ev.time}</span>
                    </div>
                  ))
                )}
              </div>
            </CardContent>
          </Card>
        </div>

      </div>
    </div>
  );
}
