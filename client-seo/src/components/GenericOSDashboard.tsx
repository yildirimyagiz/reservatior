import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { osDashboardApi, OSKpiConfig, OSActionButton } from "@/lib/api/os-dashboard";
import {
  ArrowUpRight, ArrowDownRight, AlertCircle, CheckCircle,
  BarChart3, PieChart, Activity,
  DollarSign, TrendingUp, Briefcase, CreditCard,
  Calendar, Users, Brain, Zap, Sparkles, Shield,
  Clock, FileText, Target, Key,
  Package, ShoppingCart, Megaphone, Play, Pause,
  Globe, Languages, CheckSquare, Star,
} from "lucide-react";
import { ComponentType } from "react";

const ICON_MAP: Record<string, ComponentType<any>> = {
  DollarSign, TrendingUp,
  Briefcase, CreditCard,
  PieChart, BarChart3,
  Calendar, Users,
  AlertCircle, CheckCircle,
  Brain, Zap, Activity,
  Sparkles, Shield,
  Clock, FileText,
  Target, Key,
  Package, ShoppingCart,
  Megaphone, Play, Pause,
  Globe, Languages, CheckSquare, Star,
};

function resolveIcon(name: string): ComponentType<any> {
  return ICON_MAP[name] || Activity;
}

export default function GenericOSDashboard({
  title,
  description,
  osName,
  kpiConfig,
  actions,
  children,
}: GenericOSDashboardProps) {
  const { user } = useAuth();
  const { currency, language } = useLocalization();
  const orgId = user?.organizationId || "";

  const { data: dashboardStats, isLoading } = useQuery({
    queryKey: [`${osName}-os-dashboard`, orgId],
    queryFn: () => osDashboardApi.getStats(osName, orgId),
    enabled: !!orgId,
  });

  const formatCurrency = (val: number) =>
    new Intl.NumberFormat(language, { style: 'currency', currency, maximumFractionDigits: 0 }).format(val);

  const formatNumber = (val: number) =>
    new Intl.NumberFormat(language).format(val);

  const formatPercent = (val: number) =>
    `${val.toFixed(1)}%`;

  const formatDecimal = (val: number) =>
    val.toFixed(2);

  const formatValue = (val: number, format?: string) => {
    switch (format) {
      case 'currency': return formatCurrency(val);
      case 'percent': return formatPercent(val);
      case 'decimal': return formatDecimal(val);
      default: return formatNumber(val);
    }
  };

  if (isLoading) {
    return (
      <div className="flex items-center justify-center h-64" role="status" aria-label="Dashboard loading">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
      </div>
    );
  }

  const stats = dashboardStats?.kpis || {};

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">{title}</h1>
          {description && <p className="text-gray-600 mt-1">{description}</p>}
        </div>
        {actions && actions.length > 0 && (
          <div className="flex gap-3">
            {actions.map((action, i) => (
              <button
                key={i}
                className={
                  action.primary
                    ? "px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition"
                    : "px-4 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 transition"
                }
                onClick={() => { if (action.href) window.location.href = action.href; }}
              >
                {action.label}
              </button>
            ))}
          </div>
        )}
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        {kpiConfig.map((kpi, index) => {
          const Icon = resolveIcon(kpi.icon);
          const value = stats[kpi.key] ?? 0;
          return (
            <div key={index} className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm font-medium text-gray-600">{kpi.label}</p>
                  <p className="text-2xl font-bold text-gray-900 mt-2">
                    {formatValue(value, kpi.format)}
                  </p>
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
            <h2 className="text-lg font-semibold text-gray-900">Trends</h2>
            <BarChart3 className="w-5 h-5 text-gray-500" />
          </div>
          <div className="h-64 flex items-center justify-center bg-gray-50 rounded-lg">
            <p className="text-gray-500">Chart will be rendered here</p>
          </div>
        </div>
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900">Distribution</h2>
            <PieChart className="w-5 h-5 text-gray-500" />
          </div>
          <div className="h-64 flex items-center justify-center bg-gray-50 rounded-lg">
            <p className="text-gray-500">Distribution chart will be rendered here</p>
          </div>
        </div>
      </div>

      {dashboardStats?.recentActivity && dashboardStats.recentActivity.length > 0 && (
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
          <h2 className="text-lg font-semibold text-gray-900 mb-4">Recent Activity</h2>
          <div className="space-y-4">
            {dashboardStats.recentActivity.map((item, i) => (
              <div key={item.id || i} className="flex items-center justify-between p-4 bg-gray-50 rounded-lg">
                <div className="flex items-center gap-4">
                  <div className="p-2 bg-blue-100 rounded-lg">
                    <Activity className="w-5 h-5 text-blue-600" />
                  </div>
                  <div>
                    <p className="font-medium text-gray-900">{item.title}</p>
                    <p className="text-sm text-gray-600">{item.subtitle}</p>
                  </div>
                </div>
                <div className="text-right">
                  <p className="font-medium text-gray-900">{item.value}</p>
                  <p className="text-sm text-gray-600">{item.timeAgo}</p>
                </div>
              </div>
            ))}
          </div>
        </div>
      )}

      {children}

      {dashboardStats?.alerts && dashboardStats.alerts.length > 0 && (
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900">Alerts & Notifications</h2>
            <AlertCircle className="w-5 h-5 text-yellow-500" />
          </div>
          <div className="space-y-3">
            {dashboardStats.alerts.map((alert, i) => {
              const borderColor = alert.type === 'warning' ? 'border-yellow-200 bg-yellow-50'
                : alert.type === 'success' ? 'border-green-200 bg-green-50'
                : 'border-blue-200 bg-blue-50';
              const textColor = alert.type === 'warning' ? 'text-yellow-900'
                : alert.type === 'success' ? 'text-green-900'
                : 'text-blue-900';
              const subColor = alert.type === 'warning' ? 'text-yellow-700'
                : alert.type === 'success' ? 'text-green-700'
                : 'text-blue-700';
              return (
                <div key={i} className={`flex items-start gap-3 p-4 border rounded-lg ${borderColor}`}>
                  <CheckCircle className={`w-5 h-5 mt-0.5 ${textColor}`} />
                  <div>
                    <p className={`font-medium ${textColor}`}>{alert.title}</p>
                    <p className={`text-sm ${subColor}`}>{alert.message}</p>
                  </div>
                </div>
              );
            })}
          </div>
        </div>
      )}
    </div>
  );
}
