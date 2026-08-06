"use client";
import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { operationsOSApi } from "@/lib/api/operations-os";
import { 
  Activity,
  CheckCircle,
  TrendingUp,
  Clock,
  BarChart3,
  PieChart
} from "lucide-react";
import { LineChart } from "@/components/charts/LineChart";
import { PieChart as RechartsPieChart } from "@/components/charts/PieChart";

export default function OperationsOSDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const orgId = user?.orgId || "";

  const { data: dashboardStats, isLoading } = useQuery({
    queryKey: ["operations-os-dashboard", orgId],
    queryFn: () => operationsOSApi.getDashboardStats(orgId),
    enabled: !!orgId,
  });

  const { data: taskTrendsData } = useQuery({
    queryKey: ["operations-os-task-trends", orgId],
    queryFn: () => operationsOSApi.getTaskTrends(orgId),
    enabled: !!orgId,
  });

  const { data: taskCategoriesData } = useQuery({
    queryKey: ["operations-os-task-categories", orgId],
    queryFn: () => operationsOSApi.getTaskCategories(orgId),
    enabled: !!orgId,
  });

  const formatNumber = (val: number) =>
    new Intl.NumberFormat(language).format(val);

  const formatPercent = (val: number) =>
    `${val.toFixed(1)}%`;

  const formatDecimal = (val: number) =>
    val.toFixed(2);

  if (isLoading) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
      </div>
    );
  }

  const stats = dashboardStats || {
    activeTasks: 0,
    completedTasks: 0,
    efficiency: 0,
    avgCompletionTime: 0,
  };

  const kpis = [
    {
      title: "Active Tasks",
      value: formatNumber(stats.activeTasks),
      icon: Activity,
      color: "text-brand",
    },
    {
      title: "Completed",
      value: formatNumber(stats.completedTasks),
      icon: CheckCircle,
      color: "text-blue-600",
    },
    {
      title: "Efficiency",
      value: formatPercent(stats.efficiency),
      icon: TrendingUp,
      color: "text-brand",
    },
    {
      title: "Avg Completion Time",
      value: `${formatDecimal(stats.avgCompletionTime)}h`,
      icon: Clock,
      color: "text-warning",
    },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Operations OS Dashboard</h1>
          <p className="text-gray-600 mt-1">Monitor operations and tasks</p>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        {kpis.map((kpi, index) => {
          const Icon = kpi.icon;
          return (
            <div key={index} className="bg-card rounded-xl shadow-sm p-6 border border-gray-100">
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
        <div className="bg-card rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900">Task Trends</h2>
            <TrendingUp className="w-5 h-5 text-gray-500" />
          </div>
          <LineChart 
            data={taskTrendsData} 
            dataKey="tasks" 
            xAxisKey="month" 
            color="#3b82f6"
            height={256}
          />
        </div>

        <div className="bg-card rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900">Task Categories</h2>
            <PieChart className="w-5 h-5 text-gray-500" />
          </div>
          <RechartsPieChart 
            data={taskCategoriesData} 
            dataKey="value" 
            nameKey="name"
            height={256}
          />
        </div>
      </div>
    </div>
  );
}
