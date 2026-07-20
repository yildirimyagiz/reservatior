"use client";

import { useState, useEffect } from "react";
import { PageShell } from "@/pages-spa/client/layout/PageShell";
import { Card } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Zap, CreditCard, Shield, RotateCw, Activity, ArrowRight, TrendingUp, AlertTriangle } from "lucide-react";
import { motion } from "framer-motion";
import { apiClient } from "@/lib/api/client";

export default function MarketplaceBrain() {
  const [loading, setLoading] = useState(false);
  const [dashboardData, setDashboardData] = useState<any>(null);
  const [simulationResult, setSimulationResult] = useState<any>(null);

  const fetchDashboardData = async () => {
    try {
      const res = await apiClient.get<any>("/marketplace/dashboard");
      if (res.success) {
        setDashboardData(res.data);
      }
    } catch (e) {
      console.error("Failed to fetch marketplace dashboard", e);
    }
  };

  useEffect(() => {
    fetchDashboardData();
  }, []);

  const triggerSimulation = () => {
    setLoading(true);
    setTimeout(() => {
      setSimulationResult({
        payment: {
          rail: "OPEN_BANKING_A2A",
          savings: "3.5%",
          speed: "Instant",
          desc: "Routed via TCMB Open Banking due to low fraud risk (Score: 12)."
        },
        failover: {
          status: "SUCCESS_ALTERNATIVE_ROUTED",
          alternatives: [
            { name: "Bosphorus Serviced Suite", match: "94.2%", distance: "1.2 km", price: "$135" },
            { name: "Galata Design Loft", match: "88.5%", distance: "2.4 km", price: "$128" }
          ]
        },
        bandit: {
          optimizedPrice: "$149.00",
          competitorPrice: "$165.00",
          markup: "+15.0%",
          confidence: "98%"
        }
      });
      setLoading(false);
    }, 1200);
  };

  return (
    <PageShell title="Marketplace OS Brain" description="AI-driven dynamic routing, pricing optimization, and automated failover inventory feeds.">
      <div className="space-y-8">
        
        {/* Core metrics row */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          <Card className="bg-card border-border p-6 rounded-2xl relative overflow-hidden">
            <div className="absolute top-0 right-0 p-6 opacity-10 text-purple-500">
              <Zap className="w-12 h-12" />
            </div>
            <p className="text-xs font-semibold text-muted-foreground mb-1">AI Recommendation Model</p>
            <h3 className="text-2xl font-bold tracking-tight">LambdaMART / XGBoost</h3>
            <Badge className="bg-purple-500/10 text-purple-600 border border-purple-500/20 mt-3 rounded-full text-[10px]">Active</Badge>
          </Card>
          
          <Card className="bg-card border-border p-6 rounded-2xl relative overflow-hidden">
            <div className="absolute top-0 right-0 p-6 opacity-10 text-emerald-500">
              <CreditCard className="w-12 h-12" />
            </div>
            <p className="text-xs font-semibold text-muted-foreground mb-1">Fee Optimization Rails</p>
            <h3 className="text-2xl font-bold tracking-tight">-2.8% Average Cost</h3>
            <Badge className="bg-emerald-500/10 text-emerald-600 border border-emerald-500/20 mt-3 rounded-full text-[10px]">Param / A2A Live</Badge>
          </Card>

          <Card className="bg-card border-border p-6 rounded-2xl relative overflow-hidden">
            <div className="absolute top-0 right-0 p-6 opacity-10 text-blue-500">
              <Shield className="w-12 h-12" />
            </div>
            <p className="text-xs font-semibold text-muted-foreground mb-1">Escrow Payout Settlement</p>
            <h3 className="text-2xl font-bold tracking-tight">72h Safety Window</h3>
            <Badge className="bg-blue-500/10 text-blue-600 border border-blue-500/20 mt-3 rounded-full text-[10px]">TCMB Escrow Custody</Badge>
          </Card>
        </div>

        {/* Dynamic Engine Configurations */}
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
          
          {/* Payment routing logic representation */}
          <Card className="bg-card border-border p-6 rounded-2xl space-y-6">
            <div className="flex items-center gap-3">
              <div className="h-10 w-10 rounded-xl bg-purple-500/10 border border-purple-500/20 flex items-center justify-center">
                <TrendingUp className="w-5 h-5 text-purple-500" />
              </div>
              <div>
                <h3 className="text-base font-bold">Dynamic Payment Router</h3>
                <p className="text-xs text-muted-foreground">Dynamic rail allocation based on transaction score.</p>
              </div>
            </div>
            
            <div className="space-y-3 pt-2">
              <div className="flex items-center justify-between border-b border-border/50 pb-2.5">
                <span className="text-xs font-semibold text-muted-foreground">Card Success Probability</span>
                <span className="text-xs font-bold text-foreground">94.8%</span>
              </div>
              <div className="flex items-center justify-between border-b border-border/50 pb-2.5">
                <span className="text-xs font-semibold text-muted-foreground">A2A Regional Availability</span>
                <Badge className="bg-green-500/10 text-green-500 border-none font-bold text-[9px] px-2 py-0.5 rounded-full">TR / UK Supported</Badge>
              </div>
              <div className="flex items-center justify-between">
                <span className="text-xs font-semibold text-muted-foreground">Fallback VCC Rail</span>
                <span className="text-xs font-bold text-yellow-500">Active (Automatic)</span>
              </div>
            </div>
          </Card>

          {/* Failover and Conversion logic */}
          <Card className="bg-card border-border p-6 rounded-2xl space-y-6">
            <div className="flex items-center gap-3">
              <div className="h-10 w-10 rounded-xl bg-orange-500/10 border border-orange-500/20 flex items-center justify-center">
                <RotateCw className="w-5 h-5 text-orange-500" />
              </div>
              <div>
                <h3 className="text-base font-bold">Failover Inventory Engine</h3>
                <p className="text-xs text-muted-foreground">Reroutes alternative inventory to prevent booking loss.</p>
              </div>
            </div>

            <div className="space-y-3 pt-2">
              <div className="flex items-center justify-between border-b border-border/50 pb-2.5">
                <span className="text-xs font-semibold text-muted-foreground">Primary Aggregator Feeds</span>
                <span className="text-xs font-bold text-foreground">Hotelbeds, WebBeds</span>
              </div>
              <div className="flex items-center justify-between border-b border-border/50 pb-2.5">
                <span className="text-xs font-semibold text-muted-foreground">Fallback Ranking Algorithm</span>
                <span className="text-xs font-bold text-purple-500">Learning-to-Rank (LambdaMART)</span>
              </div>
              <div className="flex items-center justify-between">
                <span className="text-xs font-semibold text-muted-foreground">Recent Failover Events</span>
                <span className="text-xs font-bold text-foreground">{dashboardData?.failovers?.length || 0} Last 30d</span>
              </div>
            </div>
          </Card>
        </div>

        {/* Real-time Dashboard Database Data */}
        {dashboardData && (
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-8 mb-8">
            {/* Trust Scores Table */}
            <Card className="bg-card border-border p-6 rounded-2xl">
              <h3 className="text-base font-bold mb-4">Property Trust Governance</h3>
              <div className="space-y-3">
                {dashboardData.trustScores?.map((score: any) => (
                  <div key={score.id} className="flex items-center justify-between border-b border-border/40 pb-2 last:border-none">
                    <div className="flex flex-col">
                      <span className="text-sm font-semibold truncate max-w-[200px]">{score.property?.name || score.propertyId}</span>
                      <span className="text-[10px] text-muted-foreground">KyC: {score.kycVerified ? "Verified" : "Pending"} | Cancel Rate: {score.cancellationRate}%</span>
                    </div>
                    <div className="flex flex-col items-end">
                      <Badge className={score.overallScore >= 80 ? "bg-green-500/10 text-green-500" : score.isSuspended ? "bg-red-500/10 text-red-500" : "bg-yellow-500/10 text-yellow-500"}>
                        {score.overallScore} / 100
                      </Badge>
                      {score.isSuspended && <span className="text-[9px] text-red-500 mt-1 font-bold">SUSPENDED</span>}
                    </div>
                  </div>
                ))}
              </div>
            </Card>

            {/* Payment Logs Table */}
            <Card className="bg-card border-border p-6 rounded-2xl">
              <h3 className="text-base font-bold mb-4">Payment Routing Feed</h3>
              <div className="space-y-3">
                {dashboardData.paymentRoutings?.map((log: any) => (
                  <div key={log.id} className="flex items-center justify-between border-b border-border/40 pb-2 last:border-none">
                    <div className="flex flex-col">
                      <span className="text-xs font-semibold">{log.routingReason}</span>
                      <span className="text-[10px] text-muted-foreground">{new Date(log.createdAt).toLocaleString()}</span>
                    </div>
                    <div className="flex flex-col items-end">
                      <span className="text-sm font-bold text-foreground">${log.amount} {log.currency}</span>
                      <span className="text-[10px] font-bold text-emerald-500">{log.selectedProvider}</span>
                    </div>
                  </div>
                ))}
              </div>
            </Card>
          </div>
        )}

        {/* Real-time Sandbox Simulator */}
        <Card className="bg-card border-border p-8 rounded-2xl space-y-6">
          <div className="flex items-center justify-between flex-wrap gap-4">
            <div>
              <h3 className="text-lg font-bold">Marketplace Engine Simulator</h3>
              <p className="text-xs text-muted-foreground">Simulate real-time reservation processing with LLM context routing, failover, and payout splits.</p>
            </div>
            <Button onClick={triggerSimulation} disabled={loading} className="bg-blue-600 hover:bg-blue-600/90 text-white rounded-xl px-6 h-11 text-xs font-bold tracking-wide transition-all shadow-md shadow-blue-600/10">
              {loading ? "Simulating..." : "Trigger AI Decision Simulation"}
            </Button>
          </div>

          {simulationResult && (
            <motion.div initial={{ opacity: 0, y: 10 }} animate={{ opacity: 1, y: 0 }} className="grid grid-cols-1 md:grid-cols-3 gap-6 pt-4 border-t border-border/60">
              <div className="bg-muted/30 border border-border p-5 rounded-xl space-y-3">
                <Badge className="bg-purple-600 text-white border-none rounded-full text-[9px] font-bold">Payment Rail</Badge>
                <h4 className="text-sm font-bold text-foreground">{simulationResult.payment.rail}</h4>
                <p className="text-xs text-muted-foreground">{simulationResult.payment.desc}</p>
                <div className="flex items-center justify-between pt-2 text-[10px] font-semibold text-muted-foreground">
                  <span>Savings: {simulationResult.payment.savings}</span>
                  <span>Speed: {simulationResult.payment.speed}</span>
                </div>
              </div>

              <div className="bg-muted/30 border border-border p-5 rounded-xl space-y-3">
                <Badge className="bg-orange-600 text-white border-none rounded-full text-[9px] font-bold">Failover Rank</Badge>
                <h4 className="text-sm font-bold text-foreground">{simulationResult.failover.status}</h4>
                <div className="space-y-2 pt-1">
                  {simulationResult.failover.alternatives.map((alt: any, idx: number) => (
                    <div key={idx} className="flex items-center justify-between text-xs border-b border-border/40 pb-1.5 last:border-none">
                      <span className="font-semibold text-foreground truncate max-w-[120px]">{alt.name}</span>
                      <span className="text-[10px] text-muted-foreground">{alt.distance}</span>
                      <span className="font-bold text-blue-600">{alt.price}</span>
                    </div>
                  ))}
                </div>
              </div>

              <div className="bg-muted/30 border border-border p-5 rounded-xl space-y-3">
                <Badge className="bg-blue-600 text-white border-none rounded-full text-[9px] font-bold">Pricing Optimizer</Badge>
                <h4 className="text-sm font-bold text-foreground">Contextual Bandit Dynamic Price</h4>
                <div className="space-y-2 pt-1">
                  <div className="flex items-center justify-between text-xs">
                    <span className="text-muted-foreground font-medium">Optimized Price:</span>
                    <span className="font-bold text-foreground">{simulationResult.bandit.optimizedPrice}</span>
                  </div>
                  <div className="flex items-center justify-between text-xs">
                    <span className="text-muted-foreground font-medium">Competitor Price:</span>
                    <span className="font-bold text-foreground">{simulationResult.bandit.competitorPrice}</span>
                  </div>
                  <div className="flex items-center justify-between text-xs">
                    <span className="text-muted-foreground font-medium">Applied Markup:</span>
                    <span className="font-semibold text-green-500">{simulationResult.bandit.markup}</span>
                  </div>
                </div>
              </div>
            </motion.div>
          )}
        </Card>

      </div>
    </PageShell>
  );
}
