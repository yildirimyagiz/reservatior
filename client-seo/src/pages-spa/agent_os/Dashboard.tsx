import React from "react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Users, Activity, Target } from "lucide-react";
import { OpportunityFeed } from "./OpportunityFeed";
import { NetworkDashboard } from "./NetworkDashboard";
import { useQuery } from "@tanstack/react-query";
import { agentPerformanceApi } from "@/lib/api/agent-performance";
import { useAuth } from "@/lib/auth";

export default function AgentDashboard() {
  const { user } = useAuth();
  
  const { data: performances, isLoading } = useQuery({
    queryKey: ["agent-performance-all", user?.orgId],
    queryFn: () => agentPerformanceApi.getAll(user?.orgId || ""),
    enabled: !!user?.orgId,
  });

  const aggregateStats = React.useMemo(() => {
    if (!performances || performances.length === 0) {
      return { totalLeads: 0, responseLatency: 0, conversionRate: 0 };
    }
    
    // In actual implementation this data would come pre-aggregated from the backend
    const totalLeads = performances.reduce((acc: number, p: any) => acc + (p.leadsGenerated || 0), 0);
    const avgLatency = performances.reduce((acc: number, p: any) => acc + (p.responseTime || 0), 0) / performances.length;
    const avgConversion = performances.reduce((acc: number, p: any) => acc + (p.successRate || 0), 0) / performances.length;
    
    return {
      totalLeads,
      responseLatency: Math.round(avgLatency),
      conversionRate: avgConversion.toFixed(1)
    };
  }, [performances]);

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-3xl font-bold tracking-tight text-slate-100 dark:text-slate-100">Agent OS Dashboard</h1>
        <p className="text-slate-500 dark:text-muted-foreground">Behavioral Data Intake Surface</p>
      </div>
      
      <div className="grid gap-4 md:grid-cols-3">
        <Card className="bg-white dark:bg-slate-900/50 border-slate-200 dark:border-slate-800">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-slate-500 dark:text-slate-400">Total Leads Handled</CardTitle>
            <Users className="h-4 w-4 text-emerald-500" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-slate-900 dark:text-slate-100">
              {isLoading ? "..." : aggregateStats.totalLeads}
            </div>
            <p className="text-xs text-emerald-500 mt-1">Aggregated from active agents</p>
          </CardContent>
        </Card>

        <Card className="bg-white dark:bg-slate-900/50 border-slate-200 dark:border-slate-800">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-slate-500 dark:text-slate-400">Avg Response Latency</CardTitle>
            <Activity className="h-4 w-4 text-blue-500" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-slate-900 dark:text-slate-100">
              {isLoading ? "..." : `${aggregateStats.responseLatency}m`}
            </div>
            <p className="text-xs text-emerald-500 mt-1">SLA compliant</p>
          </CardContent>
        </Card>

        <Card className="bg-white dark:bg-slate-900/50 border-slate-200 dark:border-slate-800">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-slate-500 dark:text-slate-400">Conversion Rate</CardTitle>
            <Target className="h-4 w-4 text-purple-500" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-slate-900 dark:text-slate-100">
              {isLoading ? "..." : `${aggregateStats.conversionRate}%`}
            </div>
            <p className="text-xs text-emerald-500 mt-1">Based on closed deals</p>
          </CardContent>
        </Card>
      </div>

      <div className="grid gap-4 md:grid-cols-2">
        <Card className="bg-slate-900/50 border-slate-800">
          <CardHeader>
            <CardTitle className="text-slate-100">Behavioral Score Matrix</CardTitle>
            <CardDescription className="text-slate-400">Signals feeding into the Revenue DAG.</CardDescription>
          </CardHeader>
          <CardContent>
            <div className="h-[380px] w-full">
              <NetworkDashboard />
            </div>
          </CardContent>
        </Card>
        
        <div className="h-full">
          <OpportunityFeed />
        </div>
      </div>
    </div>
  );
}
