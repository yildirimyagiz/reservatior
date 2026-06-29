import React from "react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Users, Activity, Target } from "lucide-react";
import { OpportunityFeed } from "./OpportunityFeed";
import { NetworkDashboard } from "./NetworkDashboard";

export default function AgentDashboard() {
  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-3xl font-bold tracking-tight text-slate-100">Agent OS Dashboard</h1>
        <p className="text-muted-foreground">Behavioral Data Intake Surface</p>
      </div>
      
      <div className="grid gap-4 md:grid-cols-3">
        <Card className="bg-slate-900/50 border-slate-800">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-slate-400">Total Leads Handled</CardTitle>
            <Users className="h-4 w-4 text-emerald-500" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-slate-100">1,248</div>
            <p className="text-xs text-emerald-500 mt-1">+12% from last month</p>
          </CardContent>
        </Card>

        <Card className="bg-slate-900/50 border-slate-800">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-slate-400">Response Latency</CardTitle>
            <Activity className="h-4 w-4 text-blue-500" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-slate-100">14m</div>
            <p className="text-xs text-emerald-500 mt-1">-2m improvement</p>
          </CardContent>
        </Card>

        <Card className="bg-slate-900/50 border-slate-800">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-slate-400">Conversion Rate</CardTitle>
            <Target className="h-4 w-4 text-purple-500" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-slate-100">8.4%</div>
            <p className="text-xs text-emerald-500 mt-1">+1.2% from last month</p>
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
