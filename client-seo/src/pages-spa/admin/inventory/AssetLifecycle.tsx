import React, { useState } from 'react';
import { m, AnimatePresence } from 'framer-motion';
import { Package, RefreshCw, AlertCircle, Wrench, Search, Box, CheckCircle2 } from 'lucide-react';
import { useTranslation } from 'react-i18next';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';

// Mock Data for Circular Economy
const ASSETS = [
  { id: 'AST-001', name: 'Herman Miller Aeron Chair', property: 'Seattle Penthouse', installed: '2022-01-15', condition: 'Fair', status: 'Needs Refresh', ageMonths: 26 },
  { id: 'AST-002', name: 'Nespresso Creatista Plus', property: 'Seattle Penthouse', installed: '2023-11-01', condition: 'Excellent', status: 'Deployed', ageMonths: 8 },
  { id: 'AST-003', name: 'West Elm Sofa', property: 'Downtown Loft', installed: '2021-08-20', condition: 'Poor', status: 'Upcycle Queue', ageMonths: 35 },
  { id: 'AST-004', name: 'Samsung Frame TV', property: 'Capitol Hill Studio', installed: '2022-05-10', condition: 'Good', status: 'Deployed', ageMonths: 24 },
  { id: 'AST-005', name: 'Casper Mattress', property: 'Lakeview Suite', installed: '2021-01-05', condition: 'Critical', status: 'Replacement Needed', ageMonths: 42 },
];

export default function AssetLifecycle() {
  const { t } = useTranslation();
  const [activeTab, setActiveTab] = useState('All');
  
  const filteredAssets = activeTab === 'All' 
    ? ASSETS 
    : activeTab === 'Refresh' 
      ? ASSETS.filter(a => a.status === 'Needs Refresh' || a.status === 'Replacement Needed')
      : ASSETS.filter(a => a.status === 'Upcycle Queue');

  return (
    <div className="p-6 md:p-8 space-y-8 animate-in fade-in duration-500">
      
      {/* Header */}
      <div>
        <h1 className="text-3xl font-black text-slate-900 dark:text-white tracking-tight bg-clip-text text-transparent bg-gradient-to-r from-slate-200 to-slate-500">{t("admin_auto_asset_circular_lifecycle", "Asset & Circular Lifecycle")}</h1>
        <p className="text-slate-500 dark:text-slate-400 mt-1">{t("admin_auto_manage_furniture_upcycling_dynamic_style", "Manage furniture upcycling, dynamic style refreshes, and the closed-loop economy.")}</p>
      </div>

      {/* Action Cards */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        <m.div whileHover={{ y: -5 }} className="rounded-3xl p-6 bg-gradient-to-br from-blue-500 to-blue-700 text-white shadow-lg shadow-blue-500/20 relative overflow-hidden">
          <div className="absolute top-0 right-0 p-6 opacity-20">
            <RefreshCw className="w-24 h-24" />
          </div>
          <h3 className="text-lg font-bold mb-2">{t("admin_auto_dynamic_style_refresh", "Dynamic Style Refresh")}</h3>
          <p className="text-blue-100 text-sm mb-6">{t("admin_auto_12_properties_are_eligible_for_a_2_year_", "12 properties are eligible for a 2-year style refresh to maintain premium valuation.")}</p>
          <button className="bg-white text-blue-600 px-4 py-2 rounded-lg font-bold text-sm hover:bg-blue-50 transition-colors">
            {t("admin_auto_trigger_refresh_proposals", "Trigger Refresh Proposals")}</button>
        </m.div>

        <m.div whileHover={{ y: -5 }} className="rounded-3xl p-6 bg-white dark:bg-slate-900/50 border border-slate-200 dark:border-slate-800 shadow-sm relative overflow-hidden">
          <div className="absolute top-0 right-0 p-6 text-slate-100 dark:text-slate-800">
            <Wrench className="w-24 h-24" />
          </div>
          <h3 className="text-lg font-bold mb-2">{t("admin_auto_upcycle_workshop", "Upcycle Workshop")}</h3>
          <p className="text-slate-500 dark:text-slate-400 text-sm mb-6">{t("admin_auto_24_items_are_currently_in_the_seattle_wa", "24 items are currently in the Seattle warehouse being refurbished.")}</p>
          <button className="bg-slate-900 dark:bg-white text-white dark:text-slate-900 px-4 py-2 rounded-lg font-bold text-sm hover:opacity-90 transition-opacity">
            {t("admin_auto_view_workshop_queue", "View Workshop Queue")}</button>
        </m.div>

        <m.div whileHover={{ y: -5 }} className="rounded-3xl p-6 bg-white dark:bg-slate-900/50 border border-slate-200 dark:border-slate-800 shadow-sm flex flex-col justify-center">
          <div className="flex items-center gap-4 mb-4">
            <div className="w-12 h-12 rounded-full bg-emerald-100 dark:bg-emerald-900/30 flex items-center justify-center text-emerald-600 dark:text-emerald-400">
              <CheckCircle2 className="w-6 h-6" />
            </div>
            <div>
              <p className="text-sm font-medium text-slate-500 dark:text-slate-400">{t("admin_auto_sustainability_score", "Sustainability Score")}</p>
              <h3 className="text-2xl font-black text-emerald-600 dark:text-emerald-400">94.2%</h3>
            </div>
          </div>
          <div className="w-full h-2 bg-slate-100 dark:bg-slate-800 rounded-full overflow-hidden">
            <div className="h-full bg-emerald-500 rounded-full" style={{ width: '94.2%' }} />
          </div>
          <p className="text-xs text-slate-500 dark:text-slate-400 mt-2">{t("admin_auto_assets_recycled_or_upcycled_vs_discarded", "Assets recycled or upcycled vs discarded.")}</p>
        </m.div>
      </div>

      {/* Table Section */}
      <Card className="border-none shadow-sm dark:bg-slate-900/50">
        <CardHeader className="flex flex-row items-center justify-between pb-2">
          <CardTitle>{t("admin_auto_asset_registry", "Asset Registry")}</CardTitle>
          <div className="flex gap-2">
            {['All', 'Refresh', 'Upcycle'].map(tab => (
              <button 
                key={tab}
                onClick={() => setActiveTab(tab)}
                className={`px-4 py-1.5 rounded-full text-xs font-bold transition-colors ${
                  activeTab === tab 
                    ? 'bg-slate-900 text-white dark:bg-white dark:text-slate-900' 
                    : 'bg-slate-100 text-slate-600 dark:bg-slate-800 dark:text-slate-400 hover:bg-slate-200 dark:hover:bg-slate-700'
                }`}
              >
                {tab}
              </button>
            ))}
          </div>
        </CardHeader>
        <CardContent>
          <div className="overflow-x-auto">
            <table className="w-full text-sm text-left">
              <thead className="text-xs text-slate-500 dark:text-slate-400 uppercase bg-slate-50 dark:bg-slate-800/50 rounded-lg">
                <tr>
                  <th className="px-6 py-4 font-semibold rounded-tl-lg">{t("admin_auto_asset", "Asset")}</th>
                  <th className="px-6 py-4 font-semibold">{t("admin_financial_location", "Location")}</th>
                  <th className="px-6 py-4 font-semibold">{t("admin_auto_age", "Age")}</th>
                  <th className="px-6 py-4 font-semibold">{t("home.search.condition", "Condition")}</th>
                  <th className="px-6 py-4 font-semibold rounded-tr-lg">{t("admin_ai_action", "Action")}</th>
                </tr>
              </thead>
              <tbody>
                {filteredAssets.map((asset, i) => (
                  <tr key={i} className="border-b border-slate-100 dark:border-slate-800 hover:bg-slate-50 dark:hover:bg-slate-800/50 transition-colors">
                    <td className="px-6 py-4">
                      <div className="flex items-center gap-3">
                        <div className="p-2 rounded-lg bg-slate-100 dark:bg-slate-800 text-slate-600 dark:text-slate-400">
                          <Package className="w-4 h-4" />
                        </div>
                        <div>
                          <p className="font-bold">{asset.name}</p>
                          <p className="text-xs text-slate-500">{asset.id}</p>
                        </div>
                      </div>
                    </td>
                    <td className="px-6 py-4 font-medium">{asset.property}</td>
                    <td className="px-6 py-4">
                      <div className="flex items-center gap-2">
                        <div className="w-16 h-1.5 bg-slate-100 dark:bg-slate-800 rounded-full overflow-hidden">
                          <div 
                            className={`h-full rounded-full ${asset.ageMonths > 24 ? 'bg-amber-500' : 'bg-emerald-500'}`} 
                            style={{ width: `${Math.min(100, (asset.ageMonths / 36) * 100)}%` }}
                          />
                        </div>
                        <span className="text-xs font-bold text-slate-500">{asset.ageMonths} {t("admin_auto_mo", "mo")}</span>
                      </div>
                    </td>
                    <td className="px-6 py-4">
                      <span className={`px-2.5 py-1 rounded-full text-xs font-bold ${
                        asset.condition === 'Excellent' ? 'bg-emerald-100 text-emerald-700 dark:bg-emerald-900/30 dark:text-emerald-400' :
                        asset.condition === 'Good' ? 'bg-blue-100 text-blue-700 dark:bg-blue-900/30 dark:text-blue-400' :
                        asset.condition === 'Fair' ? 'bg-amber-100 text-amber-700 dark:bg-amber-900/30 dark:text-amber-400' :
                        'bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-400'
                      }`}>
                        {asset.status}
                      </span>
                    </td>
                    <td className="px-6 py-4">
                      {asset.status === 'Needs Refresh' && (
                        <button className="text-blue-600 hover:text-blue-700 font-medium text-xs uppercase tracking-wider flex items-center gap-1">
                          <RefreshCw className="w-3 h-3" /> {t("admin_auto_propose_swap", "Propose Swap")}</button>
                      )}
                      {asset.status === 'Upcycle Queue' && (
                        <button className="text-amber-600 hover:text-amber-700 font-medium text-xs uppercase tracking-wider flex items-center gap-1">
                          <Wrench className="w-3 h-3" /> {t("admin_auto_manage_repair", "Manage Repair")}</button>
                      )}
                      {asset.status === 'Replacement Needed' && (
                        <button className="text-red-600 hover:text-red-700 font-medium text-xs uppercase tracking-wider flex items-center gap-1">
                          <AlertCircle className="w-3 h-3" /> {t("admin_auto_issue_replacement", "Issue Replacement")}</button>
                      )}
                      {asset.status === 'Deployed' && (
                        <button className="text-slate-400 hover:text-slate-600 font-medium text-xs uppercase tracking-wider">
                          {t("admin_ai_view_details", "View Details")}</button>
                      )}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </CardContent>
      </Card>

    </div>
  );
}
