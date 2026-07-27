"use client";

import { useState } from "react";
import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { b2bBulkOnboardingApi } from "@/lib/api/b2b-bulk-onboarding";
import { 
  Building2,
  Upload,
  Users,
  FileText,
  Mail,
  TrendingUp,
  DollarSign,
  Zap,
  Target,
  Settings,
  Download,
  Filter,
  CheckCircle,
  Clock,
  AlertTriangle,
  BarChart3,
  Globe,
  Sparkles
} from "lucide-react";

export default function B2BOnboardingDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const orgId = user?.organizationId || "";
  const [activeTab, setActiveTab] = useState<"accounts" | "upload" | "invitations" | "pitch-decks" | "seattle-pilot">("accounts");

  const { data: seattlePilotStats } = useQuery({
    queryKey: ["seattle-pilot-stats"],
    queryFn: () => b2bBulkOnboardingApi.getSeattlePilotStats(),
  });

  const formatNumber = (val: number) => new Intl.NumberFormat(language).format(val);
  const formatCurrency = (val: number) => new Intl.NumberFormat(language, { style: 'currency', currency: 'USD', maximumFractionDigits: 0 } as any).format(val);

  const seattleKPIs = seattlePilotStats ? [
    { title: "Targeted Accounts", value: formatNumber(seattlePilotStats.totalTargetedAccounts), icon: Building2, color: "text-blue-600", trend: "+12%" },
    { title: "Accepted Invitations", value: formatNumber(seattlePilotStats.acceptedInvitations), icon: CheckCircle, color: "text-green-600", trend: "+8%" },
    { title: "Properties Imported", value: formatNumber(seattlePilotStats.totalPropertiesImported), icon: Upload, color: "text-purple-600", trend: "+45%" },
    { title: "Estimated Revenue", value: formatCurrency(seattlePilotStats.estimatedRevenue), icon: DollarSign, color: "text-emerald-600", trend: "+23%" },
  ] : [];

  const seattleTargetAccounts = [
    { name: "ABODA", type: "Corporate Housing", properties: 85, status: "Invited", priority: "High" },
    { name: "Sophari", type: "Corporate Housing", properties: 120, status: "Pending", priority: "High" },
    { name: "Seattle Corporate Rentals", type: "Multi-Family", properties: 65, status: "Contacted", priority: "Medium" },
    { name: "Roundtop", type: "Property Management", properties: 45, status: "Negotiating", priority: "Medium" },
    { name: "PNW Suites", type: "Corporate Housing", properties: 95, status: "Invited", priority: "High" },
    { name: "Met Tower", type: "High-Rise Building", properties: 200, status: "Pending", priority: "High" },
    { name: "AMLI SLU", type: "Multi-Family", properties: 350, status: "Contacted", priority: "High" },
    { name: "CityLine", type: "Multi-Family", properties: 180, status: "Pending", priority: "Medium" },
    { name: "AVA Queen Anne", type: "Multi-Family", properties: 150, status: "Invited", priority: "Medium" },
    { name: "Insignia", type: "High-Rise Building", properties: 275, status: "Pending", priority: "High" },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">B2B Bulk Onboarding</h1>
          <p className="text-gray-600 mt-1">Corporate housing provider bulk acquisition and portfolio management</p>
        </div>
        <div className="flex gap-3">
          <button className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition flex items-center gap-2">
            <Upload className="w-4 h-4" /> Bulk Upload
          </button>
          <button className="px-4 py-2 bg-purple-600 text-white rounded-lg hover:bg-purple-700 transition flex items-center gap-2">
            <Mail className="w-4 h-4" /> Send Invitations
          </button>
        </div>
      </div>

      {/* Tabs */}
      <div className="flex gap-2 border-b border-gray-200">
        {[
          { id: "accounts", label: "Corporate Accounts", icon: Building2 },
          { id: "upload", label: "Bulk Upload", icon: Upload },
          { id: "invitations", label: "Invitations", icon: Mail },
          { id: "pitch-decks", label: "AI Pitch Decks", icon: FileText },
          { id: "seattle-pilot", label: "Seattle Pilot", icon: Globe },
        ].map((tab) => (
          <button
            key={tab.id}
            onClick={() => setActiveTab(tab.id as any)}
            className={`px-4 py-2 flex items-center gap-2 border-b-2 transition ${
              activeTab === tab.id
                ? "border-blue-600 text-blue-600 font-medium"
                : "border-transparent text-gray-600 hover:text-gray-900"
            }`}
          >
            <tab.icon className="w-4 h-4" />
            {tab.label}
          </button>
        ))}
      </div>

      {/* Seattle Pilot Tab */}
      {activeTab === "seattle-pilot" && (
        <div className="space-y-6">
          {/* Seattle Pilot KPIs */}
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
            {seattleKPIs.map((kpi) => (
              <div key={kpi.title} className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
                <div className="flex items-center justify-between mb-2">
                  <kpi.icon className={`w-5 h-5 ${kpi.color}`} />
                  <span className="text-xs font-medium text-green-600 bg-green-50 px-2 py-1 rounded-full">{kpi.trend}</span>
                </div>
                <p className="text-2xl font-bold text-gray-900">{kpi.value}</p>
                <p className="text-sm text-gray-600">{kpi.title}</p>
              </div>
            ))}
          </div>

          {/* Seattle Target Accounts */}
          <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
            <div className="flex items-center justify-between mb-4">
              <h2 className="text-lg font-semibold text-gray-900 flex items-center gap-2">
                <Globe className="w-5 h-5 text-blue-600" /> Seattle/Bellevue Target Accounts
              </h2>
              <div className="flex gap-2">
                <button className="px-3 py-1 bg-blue-100 text-blue-700 rounded-lg text-sm">View All</button>
                <button className="px-3 py-1 bg-purple-100 text-purple-700 rounded-lg text-sm flex items-center gap-1">
                  <Sparkles className="w-3 h-3" /> Generate AI Reports
                </button>
              </div>
            </div>
            <div className="overflow-x-auto">
              <table className="w-full">
                <thead>
                  <tr className="border-b border-gray-200">
                    <th className="text-left py-3 px-4 text-sm font-medium text-gray-600">Account Name</th>
                    <th className="text-left py-3 px-4 text-sm font-medium text-gray-600">Type</th>
                    <th className="text-left py-3 px-4 text-sm font-medium text-gray-600">Properties</th>
                    <th className="text-left py-3 px-4 text-sm font-medium text-gray-600">Status</th>
                    <th className="text-left py-3 px-4 text-sm font-medium text-gray-600">Priority</th>
                    <th className="text-left py-3 px-4 text-sm font-medium text-gray-600">Actions</th>
                  </tr>
                </thead>
                <tbody>
                  {seattleTargetAccounts.map((account) => (
                    <tr key={account.name} className="border-b border-gray-100 hover:bg-gray-50">
                      <td className="py-3 px-4">
                        <div className="flex items-center gap-3">
                          <div className="w-10 h-10 bg-gradient-to-br from-blue-500 to-purple-600 rounded-lg flex items-center justify-center text-white font-bold">
                            {account.name.charAt(0)}
                          </div>
                          <span className="font-medium text-gray-900">{account.name}</span>
                        </div>
                      </td>
                      <td className="py-3 px-4 text-sm text-gray-600">{account.type}</td>
                      <td className="py-3 px-4 text-sm text-gray-600">{account.properties}</td>
                      <td className="py-3 px-4">
                        <span className={`text-xs px-2 py-1 rounded-full ${
                          account.status === "Invited" ? "bg-blue-100 text-blue-700" :
                          account.status === "Pending" ? "bg-yellow-100 text-yellow-700" :
                          account.status === "Contacted" ? "bg-purple-100 text-purple-700" :
                          account.status === "Negotiating" ? "bg-green-100 text-green-700" :
                          "bg-gray-100 text-gray-700"
                        }`}>
                          {account.status}
                        </span>
                      </td>
                      <td className="py-3 px-4">
                        <span className={`text-xs px-2 py-1 rounded-full ${
                          account.priority === "High" ? "bg-red-100 text-red-700" : "bg-gray-100 text-gray-700"
                        }`}>
                          {account.priority}
                        </span>
                      </td>
                      <td className="py-3 px-4">
                        <div className="flex gap-2">
                          <button className="p-2 hover:bg-gray-100 rounded-lg text-blue-600">
                            <Mail className="w-4 h-4" />
                          </button>
                          <button className="p-2 hover:bg-gray-100 rounded-lg text-purple-600">
                            <FileText className="w-4 h-4" />
                          </button>
                          <button className="p-2 hover:bg-gray-100 rounded-lg text-gray-600">
                            <Settings className="w-4 h-4" />
                          </button>
                        </div>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </div>

          {/* Seattle Market Insights */}
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
            <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
              <h2 className="text-lg font-semibold text-gray-900 flex items-center gap-2 mb-4">
                <TrendingUp className="w-5 h-5 text-green-600" /> Yield Opportunity Analysis
              </h2>
              <div className="space-y-4">
                <div className="p-4 bg-gradient-to-r from-green-50 to-emerald-50 rounded-lg border border-green-200">
                  <div className="flex items-center justify-between mb-2">
                    <span className="font-medium text-green-900">South Lake Union (SLU)</span>
                    <span className="text-sm font-bold text-green-700">+18.5% Yield</span>
                  </div>
                  <p className="text-sm text-green-700">Corporate housing premium vs long-term rental</p>
                </div>
                <div className="p-4 bg-gradient-to-r from-blue-50 to-indigo-50 rounded-lg border border-blue-200">
                  <div className="flex items-center justify-between mb-2">
                    <span className="font-medium text-blue-900">Downtown Seattle</span>
                    <span className="text-sm font-bold text-blue-700">+15.2% Yield</span>
                  </div>
                  <p className="text-sm text-blue-700">High demand from Amazon & Microsoft relocations</p>
                </div>
                <div className="p-4 bg-gradient-to-r from-purple-50 to-pink-50 rounded-lg border border-purple-200">
                  <div className="flex items-center justify-between mb-2">
                    <span className="font-medium text-purple-900">Bellevue</span>
                    <span className="text-sm font-bold text-purple-700">+12.8% Yield</span>
                  </div>
                  <p className="text-sm text-purple-700">Tech corridor with premium corporate demand</p>
                </div>
              </div>
            </div>

            <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
              <h2 className="text-lg font-semibold text-gray-900 flex items-center gap-2 mb-4">
                <Target className="w-5 h-5 text-red-600" /> Tech Tenant Demand
              </h2>
              <div className="space-y-4">
                <div className="flex items-center justify-between p-3 bg-gray-50 rounded-lg">
                  <div className="flex items-center gap-3">
                    <div className="w-8 h-8 bg-orange-500 rounded-lg flex items-center justify-center text-white font-bold text-sm">A</div>
                    <span className="font-medium text-gray-900">Amazon</span>
                  </div>
                  <div className="text-right">
                    <p className="text-sm font-bold text-gray-900">2,450 units</p>
                    <p className="text-xs text-gray-600">Monthly demand</p>
                  </div>
                </div>
                <div className="flex items-center justify-between p-3 bg-gray-50 rounded-lg">
                  <div className="flex items-center gap-3">
                    <div className="w-8 h-8 bg-blue-500 rounded-lg flex items-center justify-center text-white font-bold text-sm">M</div>
                    <span className="font-medium text-gray-900">Microsoft</span>
                  </div>
                  <div className="text-right">
                    <p className="text-sm font-bold text-gray-900">1,890 units</p>
                    <p className="text-xs text-gray-600">Monthly demand</p>
                  </div>
                </div>
                <div className="flex items-center justify-between p-3 bg-gray-50 rounded-lg">
                  <div className="flex items-center gap-3">
                    <div className="w-8 h-8 bg-red-500 rounded-lg flex items-center justify-center text-white font-bold text-sm">G</div>
                    <span className="font-medium text-gray-900">Google</span>
                  </div>
                  <div className="text-right">
                    <p className="text-sm font-bold text-gray-900">980 units</p>
                    <p className="text-xs text-gray-600">Monthly demand</p>
                  </div>
                </div>
                <div className="flex items-center justify-between p-3 bg-gray-50 rounded-lg">
                  <div className="flex items-center gap-3">
                    <div className="w-8 h-8 bg-blue-600 rounded-lg flex items-center justify-center text-white font-bold text-sm">F</div>
                    <span className="font-medium text-gray-900">Meta</span>
                  </div>
                  <div className="text-right">
                    <p className="text-sm font-bold text-gray-900">650 units</p>
                    <p className="text-xs text-gray-600">Monthly demand</p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      )}

      {/* Other tabs placeholder */}
      {activeTab !== "seattle-pilot" && (
        <div className="bg-white rounded-xl shadow-sm p-12 border border-gray-100 text-center">
          <div className="w-16 h-16 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-4">
            <Settings className="w-8 h-8 text-gray-400" />
          </div>
          <h3 className="text-lg font-semibold text-gray-900 mb-2">{activeTab.replace('-', ' ').toUpperCase()}</h3>
          <p className="text-gray-600">This module is under development. Check back soon.</p>
        </div>
      )}
    </div>
  );
}
