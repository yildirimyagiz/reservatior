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
  ShieldCheck, Lock, Hourglass, AlertTriangle, Building2, Wallet,
} from "lucide-react";
import { ComponentType } from "react";
import { useTranslation } from "react-i18next";
import { Button } from "@/components/ui/button";
import { cn } from "@/lib/utils";

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
  ShieldCheck, Lock, Hourglass, AlertTriangle, Building2, Wallet,
};

function resolveIcon(name: string): ComponentType<any> {
  return ICON_MAP[name] || Activity;
}

interface GenericOSDashboardProps {
  title: string;
  description?: string;
  osName: string;
  kpiConfig: OSKpiConfig[];
  actions?: OSActionButton[];
  children?: React.ReactNode;
}

export default function GenericOSDashboard({
  title,
  description,
  osName,
  kpiConfig,
  actions,
  children,
}: GenericOSDashboardProps) {
  const { t } = useTranslation();
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
      <div className="flex h-64 items-center justify-center" role="status" aria-label={t("common.loading", "Loading")}>
        <div className="h-12 w-12 animate-spin rounded-full border-b-2 border-brand" />
      </div>
    );
  }

  const stats = dashboardStats?.kpis || {};

  const normalizedOsName = osName.replace(/-/g, '_');
  const translatedTitle = t(`${normalizedOsName}.title`, title);
  const translatedDescription = t(`${normalizedOsName}.subtitle`, t(`${normalizedOsName}.description`, description ?? ""));

  return (
    <div className="ui-page">
      <div className="ui-page-header">
        <div>
          <h1 className="ui-title">{translatedTitle}</h1>
          {translatedDescription && <p className="ui-subtitle">{translatedDescription}</p>}
        </div>
        {actions && actions.length > 0 && (
          <div className="flex gap-3">
            {actions.map((action, i) => (
              <Button
                key={i}
                variant={action.primary ? "default" : "outline"}
                className={action.primary ? "ui-btn-primary" : undefined}
                onClick={() => { if (action.href) window.location.href = action.href; }}
              >
                {t(`${normalizedOsName}.actions.${action.label.toLowerCase().replace(/\s+/g, '_')}`, action.label)}
              </Button>
            ))}
          </div>
        )}
      </div>

      <div className="grid grid-cols-1 gap-6 md:grid-cols-2 lg:grid-cols-4">
        {kpiConfig.map((kpi, index) => {
          const Icon = resolveIcon(kpi.icon);
          const value = stats[kpi.key] ?? 0;
          const snakeKey = kpi.key.replace(/[A-Z]/g, letter => `_${letter.toLowerCase()}`);
          return (
            <div key={index} className="ui-kpi">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm font-medium text-muted-foreground">
                    {t(`${normalizedOsName}.${snakeKey}`, t(`${normalizedOsName}.${kpi.key}`, kpi.label))}
                  </p>
                  <p className="mt-2 text-2xl font-bold text-foreground">
                    {formatValue(value, kpi.format)}
                  </p>
                </div>
                <div className={cn("rounded-lg bg-muted p-3", kpi.color)}>
                  <Icon className="h-6 w-6" />
                </div>
              </div>
            </div>
          );
        })}
      </div>

      <div className="grid grid-cols-1 gap-6 lg:grid-cols-2">
        <div className="ui-panel p-6">
          <div className="mb-4 flex items-center justify-between">
            <h2 className="text-lg font-semibold text-foreground">{t("generic_os.trends", "Trends")}</h2>
            <BarChart3 className="h-5 w-5 text-muted-foreground" />
          </div>
          <div className="flex h-64 items-center justify-center rounded-lg bg-muted">
            <p className="text-muted-foreground">{t("generic_os.chart_will_render", "Chart will be rendered here")}</p>
          </div>
        </div>
        <div className="ui-panel p-6">
          <div className="mb-4 flex items-center justify-between">
            <h2 className="text-lg font-semibold text-foreground">{t("generic_os.distribution", "Distribution")}</h2>
            <PieChart className="h-5 w-5 text-muted-foreground" />
          </div>
          <div className="flex h-64 items-center justify-center rounded-lg bg-muted">
            <p className="text-muted-foreground">{t("generic_os.distribution_chart_will_render", "Distribution chart will be rendered here")}</p>
          </div>
        </div>
      </div>

      {dashboardStats?.recentActivity && dashboardStats.recentActivity.length > 0 && (
        <div className="ui-panel p-6">
          <h2 className="mb-4 text-lg font-semibold text-foreground">{t("generic_os.recent_activity", "Recent Activity")}</h2>
          <div className="space-y-4">
            {dashboardStats.recentActivity.map((item, i) => (
              <div key={item.id || i} className="flex items-center justify-between rounded-lg bg-muted p-4">
                <div className="flex items-center gap-4">
                  <div className="rounded-lg bg-info/15 p-2">
                    <Activity className="h-5 w-5 text-info" />
                  </div>
                  <div>
                    <p className="font-medium text-foreground">{item.title}</p>
                    <p className="text-sm text-muted-foreground">{item.subtitle}</p>
                  </div>
                </div>
                <div className="text-right">
                  <p className="font-medium text-foreground">{item.value}</p>
                  <p className="text-sm text-muted-foreground">{item.timeAgo}</p>
                </div>
              </div>
            ))}
          </div>
        </div>
      )}

      {children}

      {dashboardStats?.alerts && dashboardStats.alerts.length > 0 && (
        <div className="ui-panel p-6">
          <div className="mb-4 flex items-center justify-between">
            <h2 className="text-lg font-semibold text-foreground">{t("generic_os.alerts_notifications", "Alerts & Notifications")}</h2>
            <AlertCircle className="h-5 w-5 text-warning" />
          </div>
          <div className="space-y-3">
            {dashboardStats.alerts.map((alert, i) => {
              const styles =
                alert.type === 'warning'
                  ? "border-warning/30 bg-warning/10 text-warning"
                  : alert.type === 'success'
                    ? "border-success/30 bg-success/10 text-success"
                    : "border-info/30 bg-info/10 text-info";
              return (
                <div key={i} className={cn("flex items-start gap-3 rounded-lg border p-4", styles)}>
                  <CheckCircle className="mt-0.5 h-5 w-5" />
                  <div>
                    <p className="font-medium">{alert.title}</p>
                    <p className="text-sm opacity-80">{alert.message}</p>
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
