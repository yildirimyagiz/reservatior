"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Switch } from "@/components/ui/switch";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { 
  Zap, 
  Settings, 
  Clock, 
  CheckCircle, 
  Plus, 
  Trash2, 
  Edit,
  ArrowUpRight,
  Workflow,
  Bell,
  MessageSquare,
  Building,
  DollarSign
} from "lucide-react";
import { motion } from "framer-motion";
import { cn } from "@/lib/utils";

interface Trigger {
  id: string;
  name: string;
  type: "booking" | "payment" | "property" | "custom";
  condition: string;
  action: string;
  enabled: boolean;
  lastRun: string;
  successRate: number;
}

interface Automation {
  id: string;
  name: string;
  description: string;
  triggers: Trigger[];
  enabled: boolean;
  runs: number;
  lastRun: string;
}

const mockAutomations: Automation[] = [
  {
    id: "1",
    name: "New Booking Notification",
    description: "Send notification when a new booking is created",
    triggers: [
      {
        id: "t1",
        name: "Booking Created",
        type: "booking",
        condition: "status = 'confirmed'",
        action: "send_email",
        enabled: true,
        lastRun: "2024-07-15T10:30:00Z",
        successRate: 98
      }
    ],
    enabled: true,
    runs: 234,
    lastRun: "2024-07-15T10:30:00Z"
  },
  {
    id: "2",
    name: "Payment Reminder",
    description: "Send payment reminders 3 days before due date",
    triggers: [
      {
        id: "t2",
        name: "Payment Due",
        type: "payment",
        condition: "due_date = today + 3 days",
        action: "send_sms",
        enabled: true,
        lastRun: "2024-07-14T09:00:00Z",
        successRate: 95
      }
    ],
    enabled: true,
    runs: 156,
    lastRun: "2024-07-14T09:00:00Z"
  },
  {
    id: "3",
    name: "Property Valuation Update",
    description: "Auto-update property valuations monthly",
    triggers: [
      {
        id: "t3",
        name: "Monthly Valuation",
        type: "property",
        condition: "day = 1 of month",
        action: "run_ai_valuation",
        enabled: false,
        lastRun: "2024-06-01T00:00:00Z",
        successRate: 100
      }
    ],
    enabled: false,
    runs: 12,
    lastRun: "2024-06-01T00:00:00Z"
  }
];

const triggerTypeConfig: Record<string, { label: string; icon: React.ComponentType<{ className?: string }>; color: string }> = {
  booking: { label: "Booking", icon: CheckCircle, color: "text-blue-400" },
  payment: { label: "Payment", icon: DollarSign, color: "text-green-400" },
  property: { label: "Property", icon: Building, color: "text-purple-400" },
  custom: { label: "Custom", icon: Settings, color: "text-yellow-400" }
};

export default function AutomationPage() {
  const router = useRouter();
  const [activeTab, setActiveTab] = useState("automations");
  const [automations, setAutomations] = useState(mockAutomations);

  const toggleAutomation = (id: string) => {
    setAutomations(prev =>
      prev.map(auto =>
        auto.id === id ? { ...auto, enabled: !auto.enabled } : auto
      )
    );
  };

  const toggleTrigger = (automationId: string, triggerId: string) => {
    setAutomations(prev =>
      prev.map(auto =>
        auto.id === automationId
          ? {
              ...auto,
              triggers: auto.triggers.map(trigger =>
                trigger.id === triggerId ? { ...trigger, enabled: !trigger.enabled } : trigger
              )
            }
          : auto
      )
    );
  };

  const activeAutomations = automations.filter(a => a.enabled).length;
  const totalRuns = automations.reduce((sum, a) => sum + a.runs, 0);
  const avgSuccessRate = automations.reduce((sum, a) => {
    const avgTriggerRate = a.triggers.reduce((tSum, t) => tSum + t.successRate, 0) / a.triggers.length;
    return sum + avgTriggerRate;
  }, 0) / automations.length;

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-purple-900 to-slate-900">
      <div className="container mx-auto px-4 py-8">
        {/* Header */}
        <motion.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="mb-8"
        >
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-white mb-2">Automation Dashboard</h1>
              <p className="text-gray-400">Manage triggers and automated workflows with AI-powered insights</p>
            </div>
            <Button
              onClick={() => router.push('/dashboard')}
              className="bg-purple-600 hover:bg-purple-700"
            >
              <ArrowUpRight className="w-4 h-4 mr-2" />
              Dashboard
            </Button>
          </div>
        </motion.div>

        {/* Stats */}
        <div className="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.1 }}
          >
            <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
              <CardContent className="p-6">
                <div className="flex items-center justify-between">
                  <div>
                    <div className="text-sm text-gray-400 mb-1">Active Automations</div>
                    <div className="text-2xl font-bold text-white">{activeAutomations}</div>
                  </div>
                  <div className="p-3 rounded-lg bg-green-500/10">
                    <Zap className="w-6 h-6 text-green-400" />
                  </div>
                </div>
              </CardContent>
            </Card>
          </motion.div>

          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.2 }}
          >
            <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
              <CardContent className="p-6">
                <div className="flex items-center justify-between">
                  <div>
                    <div className="text-sm text-gray-400 mb-1">Total Runs</div>
                    <div className="text-2xl font-bold text-white">{totalRuns}</div>
                  </div>
                  <div className="p-3 rounded-lg bg-blue-500/10">
                    <Workflow className="w-6 h-6 text-blue-400" />
                  </div>
                </div>
              </CardContent>
            </Card>
          </motion.div>

          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.3 }}
          >
            <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
              <CardContent className="p-6">
                <div className="flex items-center justify-between">
                  <div>
                    <div className="text-sm text-gray-400 mb-1">Success Rate</div>
                    <div className="text-2xl font-bold text-white">{avgSuccessRate.toFixed(0)}%</div>
                  </div>
                  <div className="p-3 rounded-lg bg-purple-500/10">
                    <CheckCircle className="w-6 h-6 text-purple-400" />
                  </div>
                </div>
              </CardContent>
            </Card>
          </motion.div>

          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.4 }}
          >
            <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
              <CardContent className="p-6">
                <div className="flex items-center justify-between">
                  <div>
                    <div className="text-sm text-gray-400 mb-1">Triggers</div>
                    <div className="text-2xl font-bold text-white">{automations.reduce((sum, a) => sum + a.triggers.length, 0)}</div>
                  </div>
                  <div className="p-3 rounded-lg bg-yellow-500/10">
                    <Clock className="w-6 h-6 text-yellow-400" />
                  </div>
                </div>
              </CardContent>
            </Card>
          </motion.div>
        </div>

        {/* Tabs */}
        <Tabs value={activeTab} onValueChange={setActiveTab} className="space-y-6">
          <TabsList className="bg-white/5 border-purple-500/20">
            <TabsTrigger value="automations" className="data-[state=active]:bg-purple-600">Automations</TabsTrigger>
            <TabsTrigger value="triggers" className="data-[state=active]:bg-purple-600">Triggers</TabsTrigger>
            <TabsTrigger value="logs" className="data-[state=active]:bg-purple-600">Logs</TabsTrigger>
          </TabsList>

          <TabsContent value="automations">
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
            >
              <div className="flex justify-between items-center mb-6">
                <h2 className="text-xl font-bold text-white">Active Automations</h2>
                <Button className="bg-purple-600 hover:bg-purple-700">
                  <Plus className="w-4 h-4 mr-2" />
                  New Automation
                </Button>
              </div>

              <div className="space-y-4">
                {automations.map((automation) => (
                  <Card
                    key={automation.id}
                    className="bg-white/5 backdrop-blur-xl border-purple-500/20"
                  >
                    <CardHeader>
                      <div className="flex items-start justify-between">
                        <div className="flex-1">
                          <div className="flex items-center gap-3 mb-2">
                            <CardTitle className="text-white">{automation.name}</CardTitle>
                            <Badge
                              variant="outline"
                              className={cn(
                                "border",
                                automation.enabled
                                  ? "border-green-500/30 text-green-400"
                                  : "border-gray-500/30 text-gray-400"
                              )}
                            >
                              {automation.enabled ? "Active" : "Inactive"}
                            </Badge>
                          </div>
                          <p className="text-gray-400 text-sm">{automation.description}</p>
                        </div>
                        <div className="flex items-center gap-2">
                          <Switch
                            checked={automation.enabled}
                            onCheckedChange={() => toggleAutomation(automation.id)}
                          />
                          <Button variant="ghost" size="icon">
                            <Edit className="w-4 h-4" />
                          </Button>
                          <Button variant="ghost" size="icon">
                            <Trash2 className="w-4 h-4" />
                          </Button>
                        </div>
                      </div>
                    </CardHeader>
                    <CardContent>
                      <div className="space-y-3">
                        <div className="text-sm text-gray-400 mb-2">Triggers</div>
                        {automation.triggers.map((trigger) => {
                          const config = triggerTypeConfig[trigger.type];
                          const Icon = config?.icon;
                          return (
                            <div
                              key={trigger.id}
                              className="flex items-center justify-between p-3 bg-white/5 rounded-lg"
                            >
                              <div className="flex items-center gap-3">
                                {Icon && <Icon className={cn("w-4 h-4", config.color)} />}
                                <div>
                                  <div className="text-white text-sm font-medium">{trigger.name}</div>
                                  <div className="text-gray-400 text-xs">{trigger.condition}</div>
                                </div>
                              </div>
                              <div className="flex items-center gap-4">
                                <div className="text-right">
                                  <div className="text-white text-sm">{trigger.successRate}%</div>
                                  <div className="text-gray-400 text-xs">Success</div>
                                </div>
                                <Switch
                                  checked={trigger.enabled}
                                  onCheckedChange={() => toggleTrigger(automation.id, trigger.id)}
                                />
                              </div>
                            </div>
                          );
                        })}
                      </div>
                      <div className="flex items-center justify-between mt-4 pt-4 border-t border-purple-500/20 text-sm">
                        <span className="text-gray-400">Total Runs: {automation.runs}</span>
                        <span className="text-gray-400">Last Run: {new Date(automation.lastRun).toLocaleDateString()}</span>
                      </div>
                    </CardContent>
                  </Card>
                ))}
              </div>
            </motion.div>
          </TabsContent>

          <TabsContent value="triggers">
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
            >
              <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
                <CardHeader>
                  <CardTitle className="text-white">Trigger Management</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="text-center py-12 text-gray-400">
                    <Bell className="w-12 h-12 mx-auto mb-4 text-purple-400" />
                    <p>Detailed trigger configuration coming soon</p>
                  </div>
                </CardContent>
              </Card>
            </motion.div>
          </TabsContent>

          <TabsContent value="logs">
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
            >
              <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
                <CardHeader>
                  <CardTitle className="text-white">Execution Logs</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="text-center py-12 text-gray-400">
                    <MessageSquare className="w-12 h-12 mx-auto mb-4 text-purple-400" />
                    <p>Automation execution logs coming soon</p>
                  </div>
                </CardContent>
              </Card>
            </motion.div>
          </TabsContent>
        </Tabs>
      </div>
    </div>
  );
}
