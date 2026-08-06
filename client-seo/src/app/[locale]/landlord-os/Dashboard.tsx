"use client";
import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { landlordFinanceApi, type LandlordPortfolio } from "@/lib/api/landlord-finance";
import {
  Building2,
  Home,
  TrendingUp,
  Activity,
  ShieldCheck,
  RefreshCw,
  FileSignature,
} from "lucide-react";
import Link from "next/link";

export default function LandlordOSDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const orgId = user?.organizationId || "";

  const { data: listRes, isLoading, refetch } = useQuery({
    queryKey: ["landlord-os", orgId],
    queryFn: () => landlordFinanceApi.listLandlords(orgId),
    enabled: !!orgId,
  });

  const formatCurrency = (val: number) =>
    new Intl.NumberFormat(language, { style: "currency", currency: "USD", maximumFractionDigits: 0 }).format(val || 0);
  const formatPercent = (val: number) => `${((val ?? 0) * 100).toFixed(1)}%`;

  if (isLoading) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
      </div>
    );
  }

  const landlords = listRes?.data ?? [];
  const profiles = landlords.map((l) => l.financialProfile).filter(Boolean) as NonNullable<LandlordPortfolio["financialProfile"]>[];
  const avgOccupancy = profiles.length ? profiles.reduce((s, p) => s + p.occupancyRate, 0) / profiles.length : 0;
  const avgPaymentHealth = profiles.length ? profiles.reduce((s, p) => s + p.paymentHealth, 0) / profiles.length : 0;
  const totalRevenue = profiles.reduce((s, p) => s + (p.totalRevenue || 0), 0);
  const totalProperties = profiles.reduce((s, p) => s + (p.propertyCount || 0), 0);

  const kpis = [
    { label: "Landlords", value: landlords.length.toLocaleString(language), icon: Building2, color: "text-blue-600" },
    { label: "Properties", value: totalProperties.toLocaleString(language), icon: Home, color: "text-emerald-600" },
    { label: "Avg Occupancy", value: formatPercent(avgOccupancy), icon: TrendingUp, color: "text-amber-600" },
    { label: "Payment Health", value: `${avgPaymentHealth.toFixed(0)}%`, icon: Activity, color: "text-purple-600" },
    { label: "Total Revenue", value: formatCurrency(totalRevenue), icon: RefreshCw, color: "text-green-600" },
  ];

  return (
    <div className="min-h-screen bg-background">
      <div className="mx-auto max-w-7xl px-6 py-8">
        <div className="flex items-center justify-between mb-8">
          <div>
            <h1 className="text-3xl font-bold flex items-center gap-2">
              <ShieldCheck className="text-emerald-500" /> Landlord OS
            </h1>
            <p className="text-muted-foreground mt-1">Portfolio analytics, occupancy, payment health and risk</p>
          </div>
          <div className="flex items-center gap-3">
            <Link
              href="/landlord-os/contracts"
              className="inline-flex items-center gap-2 px-4 py-2 rounded-lg border border-border hover:bg-muted text-sm"
            >
              <FileSignature size={16} /> Contracts
            </Link>
            <button
              onClick={() => refetch()}
              className="inline-flex items-center gap-2 px-4 py-2 rounded-lg border border-border hover:bg-muted text-sm"
            >
              <RefreshCw size={16} /> Refresh
            </button>
          </div>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-5 gap-6 mb-8">
          {kpis.map((k) => (
            <div key={k.label} className="p-6 bg-card border border-border rounded-xl">
              <div className="flex items-center gap-3 mb-2">
                <k.icon className={`w-5 h-5 ${k.color}`} />
                <span className="text-sm text-muted-foreground">{k.label}</span>
              </div>
              <div className="text-2xl font-bold">{k.value}</div>
            </div>
          ))}
        </div>

        <div className="bg-card border border-border rounded-xl overflow-hidden">
          <div className="px-6 py-4 border-b border-border">
            <h2 className="text-lg font-semibold">Landlord Portfolios</h2>
          </div>
          {landlords.length === 0 ? (
            <div className="p-10 text-center text-muted-foreground">
              No landlord entities found. Create a rental plan to get started.
            </div>
          ) : (
            <div className="overflow-x-auto">
              <table className="w-full text-sm">
                <thead className="bg-muted/50">
                  <tr>
                    <th className="text-left px-6 py-3">Landlord</th>
                    <th className="text-left px-6 py-3">Properties</th>
                    <th className="text-left px-6 py-3">Occupancy</th>
                    <th className="text-left px-6 py-3">Payment Health</th>
                    <th className="text-left px-6 py-3">Risk</th>
                    <th className="text-right px-6 py-3">Revenue</th>
                  </tr>
                </thead>
                <tbody>
                  {landlords.map((l) => {
                    const p = l.financialProfile;
                    return (
                      <tr key={l.id} className="border-t border-border">
                        <td className="px-6 py-3 font-medium">{l.id.slice(0, 10)}…</td>
                        <td className="px-6 py-3">{p?.propertyCount ?? 0}</td>
                        <td className="px-6 py-3">{formatPercent(p?.occupancyRate ?? 0)}</td>
                        <td className="px-6 py-3">{((p?.paymentHealth ?? 0)).toFixed(0)}%</td>
                        <td className="px-6 py-3">
                          <span className={`px-2 py-1 rounded-full text-xs ${
                            p?.riskLevel === "LOW" ? "bg-emerald-100 text-emerald-700" :
                            p?.riskLevel === "MEDIUM" ? "bg-amber-100 text-amber-700" : "bg-red-100 text-red-700"
                          }`}>
                            {p?.riskLevel ?? "—"}
                          </span>
                        </td>
                        <td className="px-6 py-3 text-right">{formatCurrency(p?.totalRevenue ?? 0)}</td>
                      </tr>
                    );
                  })}
                </tbody>
              </table>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
