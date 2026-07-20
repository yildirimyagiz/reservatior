"use client";

import { useTranslation } from "react-i18next";
import { Users, Building2, Shield, Key, Smartphone, CheckCircle, Clock, AlertCircle, Settings, Lock } from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { motion } from "framer-motion";

const ORGANIZATIONS = [
  { id: 1, name: "Reservatior Inc.", type: "property_management", users: 45, status: "active" },
  { id: 2, name: "Smith Realty", type: "agency", users: 12, status: "active" },
  { id: 3, name: "Global Investments", type: "investment_firm", users: 8, status: "active" },
];

const ROLES = [
  { id: 1, name: "Admin", permissions: ["*"], users: 5 },
  { id: 2, name: "Agent", permissions: ["listing.read", "listing.write", "deal.read", "deal.write"], users: 28 },
  { id: 3, name: "Viewer", permissions: ["listing.read", "deal.read"], users: 32 },
];

const API_KEYS = [
  { id: 1, name: "Production API Key", user: "john@example.com", lastUsed: "2024-01-15 10:30", status: "active" },
  { id: 2, name: "Test API Key", user: "jane@example.com", lastUsed: "2024-01-14 15:45", status: "active" },
  { id: 3, name: "Legacy Key", user: "bob@example.com", lastUsed: "2024-01-10 09:00", status: "expired" },
];

const SESSIONS = [
  { id: 1, user: "john@example.com", device: "Chrome / macOS", ip: "192.168.1.100", status: "active" },
  { id: 2, user: "jane@example.com", device: "Safari / iOS", ip: "192.168.1.101", status: "active" },
  { id: 3, user: "bob@example.com", device: "Firefox / Windows", ip: "192.168.1.102", status: "expired" },
];

export default function AdminIdentityOSDashboard() {
  const { t } = useTranslation();

  const kpis = [
    { title: "Total Organizations", value: 156, icon: Building2, color: "text-emerald-500", trend: "+12 this month" },
    { title: "Total Users", value: 1247, icon: Users, color: "text-blue-400", trend: "+45 this week" },
    { title: "Active Sessions", value: 342, icon: Smartphone, color: "text-purple-400", trend: "Currently active" },
    { title: "API Keys", value: 89, icon: Key, color: "text-orange-400", trend: "+5 new this month" },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-start justify-between">
        <div>
          <h1 className="text-3xl font-bold tracking-tight text-slate-100">Identity OS Management</h1>
          <p className="text-slate-400 mt-1">Identity and access management</p>
        </div>
        <Button className="bg-indigo-600 hover:bg-indigo-700">
          <Users className="h-4 w-4 mr-2" />
          Add User
        </Button>
      </div>

      {/* KPIs */}
      <div className="grid gap-4 md:grid-cols-4">
        {kpis.map((kpi, i) => (
          <motion.div key={kpi.title} initial={{ opacity: 0, y: 10 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: i * 0.07 }}>
            <Card className="bg-slate-900/60 border-slate-800">
              <CardHeader className="flex flex-row items-center justify-between pb-2">
                <CardTitle className="text-sm font-medium text-slate-400">{kpi.title}</CardTitle>
                <kpi.icon className={`h-4 w-4 ${kpi.color}`} />
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold text-slate-100">{kpi.value}</div>
                <p className="text-xs text-slate-500 mt-1">{kpi.trend}</p>
              </CardContent>
            </Card>
          </motion.div>
        ))}
      </div>

      <Tabs defaultValue="organizations" className="space-y-4">
        <TabsList className="bg-slate-900/60 border-slate-800">
          <TabsTrigger value="organizations">Organizations</TabsTrigger>
          <TabsTrigger value="roles">Roles</TabsTrigger>
          <TabsTrigger value="api-keys">API Keys</TabsTrigger>
          <TabsTrigger value="sessions">Sessions</TabsTrigger>
        </TabsList>

        <TabsContent value="organizations" className="space-y-4">
          <Card className="bg-slate-900/60 border-slate-800">
            <CardHeader>
              <CardTitle className="text-slate-100">Organizations</CardTitle>
              <CardDescription className="text-slate-400">
                Manage organizations and their settings
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {ORGANIZATIONS.map((org) => (
                  <div key={org.id} className="flex items-center justify-between p-4 rounded-lg bg-slate-800/50 border border-slate-700">
                    <div className="flex items-center gap-3">
                      <Building2 className="h-5 w-5 text-slate-400" />
                      <div>
                        <p className="text-sm font-medium text-slate-200">{org.name}</p>
                        <p className="text-xs text-slate-500">{org.type} • {org.users} users</p>
                      </div>
                    </div>
                    <Badge variant={org.status === 'active' ? 'default' : 'secondary'} className="text-xs">
                      {org.status}
                    </Badge>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="roles">
          <Card className="bg-slate-900/60 border-slate-800">
            <CardHeader>
              <CardTitle className="text-slate-100">Roles & Permissions</CardTitle>
              <CardDescription className="text-slate-400">
                Manage roles and their permissions
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {ROLES.map((role) => (
                  <div key={role.id} className="flex items-center justify-between p-4 rounded-lg bg-slate-800/50 border border-slate-700">
                    <div className="flex items-center gap-3">
                      <Shield className="h-5 w-5 text-slate-400" />
                      <div>
                        <p className="text-sm font-medium text-slate-200">{role.name}</p>
                        <p className="text-xs text-slate-500">{role.permissions.length} permissions • {role.users} users</p>
                      </div>
                    </div>
                    <Button variant="outline" size="sm">Edit</Button>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="api-keys">
          <Card className="bg-slate-900/60 border-slate-800">
            <CardHeader>
              <CardTitle className="text-slate-100">API Keys</CardTitle>
              <CardDescription className="text-slate-400">
                Manage API keys for external access
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {API_KEYS.map((key) => (
                  <div key={key.id} className="flex items-center justify-between p-4 rounded-lg bg-slate-800/50 border border-slate-700">
                    <div className="flex items-center gap-3">
                      <Key className="h-5 w-5 text-slate-400" />
                      <div>
                        <p className="text-sm font-medium text-slate-200">{key.name}</p>
                        <p className="text-xs text-slate-500">{key.user} • Last used: {key.lastUsed}</p>
                      </div>
                    </div>
                    <Badge variant={key.status === 'active' ? 'default' : 'secondary'} className="text-xs">
                      {key.status}
                    </Badge>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="sessions">
          <Card className="bg-slate-900/60 border-slate-800">
            <CardHeader>
              <CardTitle className="text-slate-100">Active Sessions</CardTitle>
              <CardDescription className="text-slate-400">
                Monitor and manage user sessions
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {SESSIONS.map((session) => (
                  <div key={session.id} className="flex items-center justify-between p-4 rounded-lg bg-slate-800/50 border border-slate-700">
                    <div className="flex items-center gap-3">
                      <Smartphone className="h-5 w-5 text-slate-400" />
                      <div>
                        <p className="text-sm font-medium text-slate-200">{session.user}</p>
                        <p className="text-xs text-slate-500">{session.device} • {session.ip}</p>
                      </div>
                    </div>
                    <Badge variant={session.status === 'active' ? 'default' : 'secondary'} className="text-xs">
                      {session.status}
                    </Badge>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  );
}
