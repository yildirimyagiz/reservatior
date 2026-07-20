"use client";
import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { Shield, CheckCircle, FileText, AlertTriangle } from "lucide-react";

export default function GovernanceOSDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const orgId = user?.organizationId || "";
  const { data: stats } = useQuery({ queryKey: ["governance-os-dashboard", orgId], queryFn: () => fetchGovernanceDashboardStats(orgId), enabled: !!orgId });
  const formatNumber = (val: number) => new Intl.NumberFormat(language).format(val);
  const dashboardStats = stats || { totalPolicies: 0, activePolicies: 0, totalAudits: 0, averageComplianceScore: 0 };
  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div><h1 className="text-3xl font-bold text-gray-900">Governance OS Dashboard</h1></div>
      </div>
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Total Policies</p><p className="text-2xl font-bold">{formatNumber(dashboardStats.totalPolicies)}</p></div>
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Active Policies</p><p className="text-2xl font-bold">{formatNumber(dashboardStats.activePolicies)}</p></div>
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Total Audits</p><p className="text-2xl font-bold">{formatNumber(dashboardStats.totalAudits)}</p></div>
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Avg Compliance</p><p className="text-2xl font-bold">{dashboardStats.averageComplianceScore.toFixed(1)}%</p></div>
      </div>
    </div>
  );
}

async function fetchGovernanceDashboardStats(orgId: string) {
  return { totalPolicies: 45, activePolicies: 38, totalAudits: 120, averageComplianceScore: 94.5 };
}
