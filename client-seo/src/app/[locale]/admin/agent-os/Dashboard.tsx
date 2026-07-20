"use client";


import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { agentOSApi } from "@/lib/api/agent-os";
import { 
  Users, 
  TrendingUp, 
  DollarSign, 
  Shield, 
  Award,
  BarChart3,
  Network,
  MessageSquare,
  CheckCircle,
  AlertTriangle,
  ArrowUpRight,
  ArrowDownRight
} from "lucide-react";
import { useAuth } from "@/lib/auth";

export default function AgentOSDashboard() {
  const { user } = useAuth();
  const { currency, language } = useLocalization();
  const orgId = user?.orgId || "";

  const { data: dashboardStats, isLoading } = useQuery({
    queryKey: ["agent-os-dashboard", orgId],
    queryFn: () => agentOSApi.getDashboardStats(orgId),
    enabled: !!orgId,
  });

  const formatCurrency = (val: number) =>
    new Intl.NumberFormat(language, { style: 'currency', currency, maximumFractionDigits: 0 }).format(val);

  const formatNumber = (val: number) =>
    new Intl.NumberFormat(language).format(val);

  if (isLoading) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
      </div>
    );
  }

  const stats = dashboardStats || {
    totalAgents: 0,
    activeAgents: 0,
    totalCommissions: 0,
    averagePerformance: 0,
    averageTrustScore: 0,
    totalLeads: 0,
    conversionRate: 0,
    trainingCompletion: 0,
  };

  const kpis = [
    {
      title: "Total Agents",
      value: formatNumber(stats.totalAgents),
      icon: Users,
      color: "text-blue-600",
      trend: "+18.2% vs last month",
      trendUp: true,
    },
    {
      title: "Active Agents",
      value: formatNumber(stats.activeAgents),
      icon: CheckCircle,
      color: "text-green-600",
      trend: "+15.8% vs last month",
      trendUp: true,
    },
    {
      title: "Total Commissions",
      value: formatCurrency(stats.totalCommissions),
      icon: DollarSign,
      color: "text-purple-600",
      trend: "+22.5% vs last month",
      trendUp: true,
    },
    {
      title: "Avg Performance",
      value: `${stats.averagePerformance.toFixed(1)}/100`,
      icon: Award,
      color: "text-orange-600",
      trend: "+5.3% vs last month",
      trendUp: true,
    },
    {
      title: "Avg Trust Score",
      value: `${stats.averageTrustScore.toFixed(2)}`,
      icon: Shield,
      color: "text-emerald-600",
      trend: "+3.7% vs last month",
      trendUp: true,
    },
    {
      title: "Total Leads",
      value: formatNumber(stats.totalLeads),
      icon: Network,
      color: "text-indigo-600",
      trend: "+28.1% vs last month",
      trendUp: true,
    },
    {
      title: "Conversion Rate",
      value: `${stats.conversionRate.toFixed(1)}%`,
      icon: TrendingUp,
      color: "text-pink-600",
      trend: "+7.4% vs last month",
      trendUp: true,
    },
    {
      title: "Training Completion",
      value: `${stats.trainingCompletion.toFixed(1)}%`,
      icon: BarChart3,
      color: "text-cyan-600",
      trend: "+12.2% vs last month",
      trendUp: true,
    },
  ];

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Agent OS Dashboard</h1>
          <p className="text-gray-600 mt-1">Monitor and manage agent operations</p>
        </div>
        <div className="flex gap-3">
          <button className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition">
            Invite Agent
          </button>
          <button className="px-4 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 transition">
            View Leaderboard
          </button>
        </div>
      </div>

      {/* KPI Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        {kpis.map((kpi, index) => {
          const Icon = kpi.icon;
          return (
            <div key={index} className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm font-medium text-gray-600">{kpi.title}</p>
                  <p className="text-2xl font-bold text-gray-900 mt-2">{kpi.value}</p>
                  <div className="flex items-center gap-1 mt-1">
                    {kpi.trendUp ? (
                      <ArrowUpRight className="w-4 h-4 text-green-600" />
                    ) : (
                      <ArrowDownRight className="w-4 h-4 text-red-600" />
                    )}
                    <p className={`text-sm ${kpi.trendUp ? 'text-green-600' : 'text-red-600'}`}>
                      {kpi.trend}
                    </p>
                  </div>
                </div>
                <div className={`p-3 bg-gray-50 rounded-lg ${kpi.color}`}>
                  <Icon className="w-6 h-6" />
                </div>
              </div>
            </div>
          );
        })}
      </div>

      {/* Charts Section */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Performance Trends Chart */}
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900">Performance Trends</h2>
            <BarChart3 className="w-5 h-5 text-gray-500" />
          </div>
          <div className="h-64 flex items-center justify-center bg-gray-50 rounded-lg">
            <p className="text-gray-500">Performance trends chart will be rendered here</p>
          </div>
        </div>

        {/* Trust Score Distribution */}
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900">Trust Score Distribution</h2>
            <Shield className="w-5 h-5 text-gray-500" />
          </div>
          <div className="h-64 flex items-center justify-center bg-gray-50 rounded-lg">
            <p className="text-gray-500">Trust score distribution chart will be rendered here</p>
          </div>
        </div>
      </div>

      {/* Top Performers */}
      <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
        <h2 className="text-lg font-semibold text-gray-900 mb-4">Top Performers</h2>
        <div className="space-y-4">
          {[1, 2, 3, 4, 5].map((item) => (
            <div key={item} className="flex items-center justify-between p-4 bg-gray-50 rounded-lg">
              <div className="flex items-center gap-4">
                <div className="p-2 bg-yellow-100 rounded-lg">
                  <Award className="w-5 h-5 text-yellow-600" />
                </div>
                <div>
                  <p className="font-medium text-gray-900">Agent #{1000 + item}</p>
                  <p className="text-sm text-gray-600">{item * 15} deals closed</p>
                </div>
              </div>
              <div className="text-right">
                <p className="font-medium text-gray-900">{formatCurrency(500000 + item * 100000)}</p>
                <p className="text-sm text-gray-600">Score: {95 - item * 2}</p>
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* Agent Network Activity */}
      <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
        <h2 className="text-lg font-semibold text-gray-900 mb-4">Network Activity</h2>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div className="p-4 bg-blue-50 border border-blue-200 rounded-lg">
            <h3 className="font-semibold text-blue-900">High Activity</h3>
            <p className="text-sm text-blue-700 mt-1">Strong network connections</p>
            <p className="text-2xl font-bold text-blue-900 mt-2">45%</p>
            <p className="text-xs text-blue-600">of agents</p>
          </div>
          <div className="p-4 bg-purple-50 border border-purple-200 rounded-lg">
            <h3 className="font-semibold text-purple-900">Moderate Activity</h3>
            <p className="text-sm text-purple-700 mt-1">Growing network</p>
            <p className="text-2xl font-bold text-purple-900 mt-2">40%</p>
            <p className="text-xs text-purple-600">of agents</p>
          </div>
          <div className="p-4 bg-gray-50 border border-gray-200 rounded-lg">
            <h3 className="font-semibold text-gray-900">Low Activity</h3>
            <p className="text-sm text-gray-700 mt-1">Limited network</p>
            <p className="text-2xl font-bold text-gray-900 mt-2">15%</p>
            <p className="text-xs text-gray-600">of agents</p>
          </div>
        </div>
      </div>

      {/* Alerts Section */}
      <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-lg font-semibold text-gray-900">Agent Alerts</h2>
          <AlertTriangle className="w-5 h-5 text-yellow-500" />
        </div>
        <div className="space-y-3">
          <div className="flex items-start gap-3 p-4 bg-yellow-50 border border-yellow-200 rounded-lg">
            <AlertTriangle className="w-5 h-5 text-yellow-600 mt-0.5" />
            <div>
              <p className="font-medium text-yellow-900">Performance decline detected</p>
              <p className="text-sm text-yellow-700">3 agents showing performance decline this week</p>
            </div>
          </div>
          <div className="flex items-start gap-3 p-4 bg-green-50 border border-green-200 rounded-lg">
            <CheckCircle className="w-5 h-5 text-green-600 mt-0.5" />
            <div>
              <p className="font-medium text-green-900">Training milestone achieved</p>
              <p className="text-sm text-green-700">85% of agents completed required training</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
