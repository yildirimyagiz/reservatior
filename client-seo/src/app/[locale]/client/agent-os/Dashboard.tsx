"use client";
import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { agentOSApi } from "@/lib/api/agent-os";
import { 
  Users, 
  DollarSign, 
  Shield, 
  Award,
  BarChart3,
  CheckCircle
} from "lucide-react";
import { LineChart } from "@/components/charts/LineChart";
import { PieChart } from "@/components/charts/PieChart";

export default function AgentOSDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const orgId = user?.orgId || "";

  const { data: dashboardStats, isLoading } = useQuery({
    queryKey: ["agent-os-dashboard", orgId],
    queryFn: () => agentOSApi.getDashboardStats(orgId),
    enabled: !!orgId,
  });

  const formatCurrency = (val: number) =>
    new Intl.NumberFormat(language, { style: 'currency', currency: 'USD', maximumFractionDigits: 0 }).format(val);

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

  // Mock chart data - replace with actual API data
  const performanceData = [
    { month: 'Jan', performance: 65 },
    { month: 'Feb', performance: 72 },
    { month: 'Mar', performance: 78 },
    { month: 'Apr', performance: 75 },
    { month: 'May', performance: 82 },
    { month: 'Jun', performance: 88 },
  ];

  const trustScoreData = [
    { name: 'Excellent (90-100)', value: 35 },
    { name: 'Good (80-89)', value: 28 },
    { name: 'Average (70-79)', value: 22 },
    { name: 'Below Average (60-69)', value: 10 },
    { name: 'Poor (<60)', value: 5 },
  ];

  const kpis = [
    {
      title: "Total Agents",
      value: formatNumber(stats.totalAgents),
      icon: Users,
      color: "text-blue-600",
    },
    {
      title: "Active Agents",
      value: formatNumber(stats.activeAgents),
      icon: CheckCircle,
      color: "text-green-600",
    },
    {
      title: "Total Commissions",
      value: formatCurrency(stats.totalCommissions),
      icon: DollarSign,
      color: "text-purple-600",
    },
    {
      title: "Avg Performance",
      value: `${stats.averagePerformance.toFixed(1)}/100`,
      icon: Award,
      color: "text-orange-600",
    },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Agent OS Dashboard</h1>
          <p className="text-gray-600 mt-1">Monitor and manage agent operations</p>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        {kpis.map((kpi, index) => {
          const Icon = kpi.icon;
          return (
            <div key={index} className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm font-medium text-gray-600">{kpi.title}</p>
                  <p className="text-2xl font-bold text-gray-900 mt-2">{kpi.value}</p>
                </div>
                <div className={`p-3 bg-gray-50 rounded-lg ${kpi.color}`}>
                  <Icon className="w-6 h-6" />
                </div>
              </div>
            </div>
          );
        })}
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900">Performance Trends</h2>
            <BarChart3 className="w-5 h-5 text-gray-500" />
          </div>
          <LineChart 
            data={performanceData} 
            dataKey="performance" 
            xAxisKey="month" 
            color="#3b82f6"
            height={256}
          />
        </div>

        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900">Trust Score Distribution</h2>
            <Shield className="w-5 h-5 text-gray-500" />
          </div>
          <PieChart 
            data={trustScoreData} 
            dataKey="value" 
            nameKey="name"
            height={256}
          />
        </div>
      </div>
    </div>
  );
}
