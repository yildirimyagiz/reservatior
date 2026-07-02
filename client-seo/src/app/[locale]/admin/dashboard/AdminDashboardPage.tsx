"use client";

import { useRouter } from "next/navigation";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { 
  Building, 
  Users, 
  DollarSign, 
  Activity, 
  ArrowUpRight,
  ArrowDownRight,
  ShieldCheck
} from "lucide-react";
import { motion } from "framer-motion";

const metrics = [
  {
    title: "Total Revenue",
    value: "$2.4M",
    change: "+12.5%",
    trend: "up",
    icon: DollarSign,
    color: "text-green-400"
  },
  {
    title: "Properties",
    value: "1,234",
    change: "+8.2%",
    trend: "up",
    icon: Building,
    color: "text-blue-400"
  },
  {
    title: "Active Users",
    value: "8,567",
    change: "+15.3%",
    trend: "up",
    icon: Users,
    color: "text-purple-400"
  },
  {
    title: "Tasks Completed",
    value: "2,890",
    change: "-2.1%",
    trend: "down",
    icon: Activity,
    color: "text-amber-400"
  }
];

const recentActivities = [
  { id: 1, action: "New property listed", time: "2 hours ago", user: "John Doe" },
  { id: 2, action: "Booking confirmed", time: "4 hours ago", user: "Jane Smith" },
  { id: 3, action: "Payment received", time: "6 hours ago", user: "Bob Wilson" },
  { id: 4, action: "User registered", time: "8 hours ago", user: "Alice Brown" }
];

export default function AdminDashboardPage() {
  const router = useRouter();

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
              <h1 className="text-3xl font-bold text-white mb-2">Admin Dashboard</h1>
              <p className="text-gray-400">Overview of your platform performance</p>
            </div>
            <Button
              onClick={() => router.push('/')}
              className="bg-purple-600 hover:bg-purple-700"
            >
              <ArrowUpRight className="w-4 h-4 mr-2" />
              View Site
            </Button>
          </div>
        </motion.div>

        {/* Metrics */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
          className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8"
        >
          {metrics.map((metric, idx) => (
            <Card key={idx} className="bg-white/5 backdrop-blur-xl border-purple-500/20">
              <CardContent className="p-6">
                <div className="flex items-center justify-between mb-4">
                  <metric.icon className={`w-6 h-6 ${metric.color}`} />
                  <div className={`flex items-center text-sm ${metric.trend === 'up' ? 'text-green-400' : 'text-red-400'}`}>
                    {metric.trend === 'up' ? <ArrowUpRight className="w-4 h-4 mr-1" /> : <ArrowDownRight className="w-4 h-4 mr-1" />}
                    {metric.change}
                  </div>
                </div>
                <div className="text-2xl font-bold text-white mb-1">{metric.value}</div>
                <div className="text-sm text-gray-400">{metric.title}</div>
              </CardContent>
            </Card>
          ))}
        </motion.div>

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          {/* Recent Activities */}
          <motion.div
            initial={{ opacity: 0, x: -20 }}
            animate={{ opacity: 1, x: 0 }}
            transition={{ delay: 0.2 }}
          >
            <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
              <CardHeader>
                <CardTitle className="text-white">Recent Activities</CardTitle>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  {recentActivities.map((activity) => (
                    <div key={activity.id} className="flex items-center justify-between p-3 bg-white/5 rounded-lg">
                      <div>
                        <div className="text-white font-medium">{activity.action}</div>
                        <div className="text-sm text-gray-400">{activity.user}</div>
                      </div>
                      <div className="text-sm text-gray-400">{activity.time}</div>
                    </div>
                  ))}
                </div>
              </CardContent>
            </Card>
          </motion.div>

          {/* Quick Actions */}
          <motion.div
            initial={{ opacity: 0, x: 20 }}
            animate={{ opacity: 1, x: 0 }}
            transition={{ delay: 0.3 }}
          >
            <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
              <CardHeader>
                <CardTitle className="text-white">Quick Actions</CardTitle>
              </CardHeader>
              <CardContent>
                <div className="grid grid-cols-2 gap-4">
                  <Button variant="outline" className="bg-white/10 border-purple-500/30 text-white h-20 flex-col">
                    <Building className="w-6 h-6 mb-2" />
                    Properties
                  </Button>
                  <Button variant="outline" className="bg-white/10 border-purple-500/30 text-white h-20 flex-col">
                    <Users className="w-6 h-6 mb-2" />
                    Users
                  </Button>
                  <Button variant="outline" className="bg-white/10 border-purple-500/30 text-white h-20 flex-col">
                    <DollarSign className="w-6 h-6 mb-2" />
                    Financial
                  </Button>
                  <Button variant="outline" className="bg-white/10 border-purple-500/30 text-white h-20 flex-col">
                    <ShieldCheck className="w-6 h-6 mb-2" />
                    Security
                  </Button>
                </div>
              </CardContent>
            </Card>
          </motion.div>
        </div>
      </div>
    </div>
  );
}
