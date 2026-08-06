"use client";
import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { governanceOSApi } from "@/lib/api/governance-os";
import { 
  FileText,
  CheckCircle,
  Shield,
  AlertCircle,
  BarChart3,
  TrendingUp
} from "lucide-react";
import { LineChart } from "@/components/charts/LineChart";
import { BarChart } from "@/components/charts/BarChart";

export default function GovernanceOSDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const orgId = user?.orgId || "";

  const { data: dashboardStats, isLoading } = useQuery({
    queryKey: ["governance-os-dashboard", orgId],
    queryFn: () => governanceOSApi.getDashboardStats(orgId),
    enabled: !!orgId,
  });

  const { data: complianceTrendsData } = useQuery({
    queryKey: ["governance-os-compliance-trends", orgId],
    queryFn: () => governanceOSApi.getComplianceTrends(orgId),
    enabled: !!orgId,
  });

  const { data: riskAssessmentData } = useQuery({
    queryKey: ["governance-os-risk-assessment", orgId],
    queryFn: () => governanceOSApi.getRiskAssessment(orgId),
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
    policies: 0,
    complianceScore: 0,
    audits: 0,
    riskLevel: 0,
  };

  const kpis = [
    {
      title: "Active Policies",
      value: formatNumber(stats.policies),
      icon: FileText,
      color: "text-brand",
    },
    {
      title: "Compliance Score",
      value: formatPercent(stats.complianceScore),
      icon: CheckCircle,
      color: "text-blue-600",
    },
    {
      title: "Audits Completed",
      value: formatNumber(stats.audits),
      icon: Shield,
      color: "text-brand",
    },
    {
      title: "Risk Level",
      value: formatDecimal(stats.riskLevel),
      icon: AlertCircle,
      color: "text-warning",
    },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Governance OS Dashboard</h1>
          <p className="text-gray-600 mt-1">Monitor governance and compliance</p>
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
            <h2 className="text-lg font-semibold text-gray-900">Compliance Trends</h2>
            <TrendingUp className="w-5 h-5 text-gray-500" />
          </div>
          <LineChart 
            data={complianceTrendsData} 
            dataKey="score" 
            xAxisKey="month" 
            color="#3b82f6"
            height={256}
          />
        </div>

        <div className="bg-card rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900">Risk Assessment</h2>
            <BarChart3 className="w-5 h-5 text-gray-500" />
          </div>
          <BarChart 
            data={riskAssessmentData} 
            dataKey="risk" 
            xAxisKey="category" 
            color="#ef4444"
            height={256}
          />
        </div>
      </div>
    </div>
  );
}
