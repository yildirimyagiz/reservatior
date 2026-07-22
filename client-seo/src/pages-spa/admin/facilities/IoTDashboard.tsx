import React, { useState } from 'react';
import { m } from 'framer-motion';
import { ShieldCheck, Battery, Wifi, AlertTriangle, Lock, Thermometer, Waves, Search, Filter } from 'lucide-react';
import { useTranslation } from 'react-i18next';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';

// Mock Data
const DEVICES = [
  { id: 'dev-1', property: 'Seattle Penthouse', type: 'Smart Lock', status: 'Online', battery: 85, alert: false, lastPing: '2 mins ago' },
  { id: 'dev-2', property: 'Seattle Penthouse', type: 'Thermostat', status: 'Online', battery: 100, alert: false, lastPing: '1 min ago' },
  { id: 'dev-3', property: 'Downtown Loft', type: 'Smart Lock', status: 'Offline', battery: 12, alert: true, lastPing: '2 hours ago' },
  { id: 'dev-4', property: 'Downtown Loft', type: 'Noise Sensor', status: 'Warning', battery: 90, alert: true, lastPing: 'Just now' },
  { id: 'dev-5', property: 'Lakeview Suite', type: 'Thermostat', status: 'Online', battery: 95, alert: false, lastPing: '5 mins ago' },
  { id: 'dev-6', property: 'Capitol Hill Studio', type: 'Smart Lock', status: 'Online', battery: 60, alert: false, lastPing: '10 mins ago' },
];

export default function IoTDashboard() {
  const { t } = useTranslation();
  const [searchTerm, setSearchTerm] = useState('');

  const filteredDevices = DEVICES.filter(dev => 
    dev.property.toLowerCase().includes(searchTerm.toLowerCase()) || 
    dev.type.toLowerCase().includes(searchTerm.toLowerCase())
  );

  return (
    <div className="p-6 md:p-8 space-y-8 animate-in fade-in duration-500">
      
      {/* Header */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div>
          <h1 className="text-3xl font-black text-slate-900 dark:text-white tracking-tight bg-clip-text text-transparent bg-gradient-to-r from-slate-200 to-slate-500">{t("admin_auto_iot_fleet_command", "IoT Fleet Command")}</h1>
          <p className="text-slate-500 dark:text-slate-400 mt-1">{t("admin_auto_monitor_autonomous_property_hardware_and", "Monitor autonomous property hardware and environmental sensors.")}</p>
        </div>
        <div className="flex items-center gap-3">
          <div className="relative">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400" />
            <input 
              type="text" 
              aria-label="Search devices or properties"
              placeholder={t("admin_auto_search_devices_or_properties", "Search devices or properties...")} 
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
              className="pl-10 pr-4 py-2 bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 rounded-lg text-sm w-full md:w-64 focus:outline-none focus:ring-2 focus:ring-blue-500"
            />
          </div>
          <button className="p-2 bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 rounded-lg hover:bg-slate-50 dark:hover:bg-slate-800">
            <Filter className="w-4 h-4" />
          </button>
        </div>
      </div>

      {/* Top Metrics */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
        {[
          { title: 'Total Devices', value: '1,248', icon: Wifi, color: 'text-blue-500', bg: 'bg-blue-50 dark:bg-blue-900/20' },
          { title: 'Critical Alerts', value: '3', icon: AlertTriangle, color: 'text-red-500', bg: 'bg-red-50 dark:bg-red-900/20' },
          { title: 'Low Battery', value: '14', icon: Battery, color: 'text-amber-500', bg: 'bg-amber-50 dark:bg-amber-900/20' },
          { title: 'System Health', value: '99.2%', icon: ShieldCheck, color: 'text-emerald-500', bg: 'bg-emerald-50 dark:bg-emerald-900/20' },
        ].map((metric, i) => (
          <Card key={i} className="border-none shadow-sm dark:bg-slate-900/50">
            <CardContent className="p-6 flex items-center justify-between">
              <div>
                <p className="text-sm font-medium text-slate-500 dark:text-slate-400 mb-1">{metric.title}</p>
                <h3 className="text-3xl font-black">{metric.value}</h3>
              </div>
              <div className={`w-12 h-12 rounded-full ${metric.bg} flex items-center justify-center ${metric.color}`}>
                <metric.icon className="w-6 h-6" />
              </div>
            </CardContent>
          </Card>
        ))}
      </div>

      {/* Data Table */}
      <Card className="border-none shadow-sm dark:bg-slate-900/50">
        <CardHeader>
          <CardTitle>{t("admin_auto_active_fleet", "Active Fleet")}</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="overflow-x-auto">
            <table className="w-full text-sm text-left">
              <thead className="text-xs text-slate-500 dark:text-slate-400 uppercase bg-slate-50 dark:bg-slate-800/50 rounded-t-lg">
                <tr>
                  <th className="px-6 py-4 font-semibold rounded-tl-lg">{t("admin_mobile_device", "Device")}</th>
                  <th className="px-6 py-4 font-semibold">{t("admin_ai_property", "Property")}</th>
                  <th className="px-6 py-4 font-semibold">{t("admin_ai_status", "Status")}</th>
                  <th className="px-6 py-4 font-semibold">{t("battery", "Battery")}</th>
                  <th className="px-6 py-4 font-semibold">{t("admin_auto_last_ping", "Last Ping")}</th>
                  <th className="px-6 py-4 font-semibold rounded-tr-lg">{t("admin_ai_actions", "Actions")}</th>
                </tr>
              </thead>
              <tbody>
                {filteredDevices.map((dev, i) => (
                  <tr key={i} className="border-b border-slate-100 dark:border-slate-800 hover:bg-slate-50 dark:hover:bg-slate-800/50 transition-colors">
                    <td className="px-6 py-4">
                      <div className="flex items-center gap-3">
                        <div className={`p-2 rounded-lg ${
                          dev.type === 'Smart Lock' ? 'bg-blue-100 dark:bg-blue-900/30 text-blue-600 dark:text-blue-400' :
                          dev.type === 'Thermostat' ? 'bg-amber-100 dark:bg-amber-900/30 text-amber-600 dark:text-amber-400' :
                          'bg-emerald-100 dark:bg-emerald-900/30 text-emerald-600 dark:text-emerald-400'
                        }`}>
                          {dev.type === 'Smart Lock' ? <Lock className="w-4 h-4" /> : 
                           dev.type === 'Thermostat' ? <Thermometer className="w-4 h-4" /> : 
                           <Waves className="w-4 h-4" />}
                        </div>
                        <div>
                          <p className="font-bold">{dev.type}</p>
                          <p className="text-xs text-slate-500">{dev.id}</p>
                        </div>
                      </div>
                    </td>
                    <td className="px-6 py-4 font-medium">{dev.property}</td>
                    <td className="px-6 py-4">
                      <span className={`px-2.5 py-1 rounded-full text-xs font-bold ${
                        dev.status === 'Online' ? 'bg-emerald-100 text-emerald-700 dark:bg-emerald-900/30 dark:text-emerald-400' :
                        dev.status === 'Warning' ? 'bg-amber-100 text-amber-700 dark:bg-amber-900/30 dark:text-amber-400' :
                        'bg-red-100 text-red-700 dark:bg-red-900/30 dark:text-red-400'
                      }`}>
                        {dev.status}
                      </span>
                    </td>
                    <td className="px-6 py-4">
                      <div className="flex items-center gap-2">
                        <div className="w-16 h-2 bg-slate-100 dark:bg-slate-800 rounded-full overflow-hidden">
                          <div 
                            className={`h-full rounded-full ${dev.battery > 20 ? 'bg-emerald-500' : 'bg-red-500'}`} 
                            style={{ width: `${dev.battery}%` }}
                          />
                        </div>
                        <span className="text-xs font-bold text-slate-500">{dev.battery}%</span>
                      </div>
                    </td>
                    <td className="px-6 py-4 text-slate-500">{dev.lastPing}</td>
                    <td className="px-6 py-4">
                      <button className="text-blue-600 hover:text-blue-700 font-medium text-xs uppercase tracking-wider">{t("admin_adminpage_auto_ext_23", "Configure")}</button>
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
