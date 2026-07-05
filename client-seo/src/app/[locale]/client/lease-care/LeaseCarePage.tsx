"use client";

import { useRouter } from "next/navigation";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { 
  Home, 
  CheckCircle, 
  ArrowUpRight,
  FileText,
  Calendar,
  DollarSign
} from "lucide-react";
import { motion } from "framer-motion";
import { useTranslation } from "react-i18next";

const services = [
  {
    icon: <Home className="w-6 h-6 text-purple-400" />,
    title: "Property Maintenance",
    description: "24/7 maintenance support for all rental properties",
    features: ["Emergency repairs", "Routine inspections", "Preventive maintenance"]
  },
  {
    icon: <FileText className="w-6 h-6 text-blue-400" />,
    title: "Lease Management",
    description: "Complete lease lifecycle management",
    features: ["Digital contracts", "Automated renewals", "Compliance tracking"]
  },
  {
    icon: <Calendar className="w-6 h-6 text-emerald-400" />,
    title: "Schedule Management",
    description: "Efficient booking and scheduling",
    features: ["Real-time availability", "Automated reminders", "Conflict resolution"]
  },
  {
    icon: <DollarSign className="w-6 h-6 text-amber-400" />,
    title: "Financial Services",
    description: "Comprehensive financial management",
    features: ["Rent collection", "Expense tracking", "Financial reporting"]
  }
];

export default function LeaseCarePage() {
    const { t } = useTranslation();
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
              <h1 className="text-3xl font-bold text-white mb-2">{t("lease_care.leasecarepage.auto_ext_1")}</h1>
              <p className="text-gray-400">{t("lease_care.leasecarepage.auto_ext_2")}</p>
            </div>
            <Button
              onClick={() => router.push('/dashboard')}
              className="bg-purple-600 hover:bg-purple-700"
            >
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("lease_care.leasecarepage.auto_ext_3")}
                                      </Button>
          </div>
        </motion.div>

        {/* Services */}
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6 mb-12">
          {services.map((service, idx) => (
            <motion.div
              key={idx}
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: idx * 0.1 }}
            >
              <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20 hover:bg-white/10 transition-colors">
                <CardHeader>
                  <div className="flex items-center gap-4">
                    <div className="p-3 rounded-xl bg-purple-500/20">
                      {service.icon}
                    </div>
                    <CardTitle className="text-white">{service.title}</CardTitle>
                  </div>
                </CardHeader>
                <CardContent>
                  <p className="text-gray-400 mb-4">{service.description}</p>
                  <ul className="space-y-2">
                    {service.features.map((feature, i) => (
                      <li key={i} className="flex items-center gap-2 text-sm text-gray-300">
                        <CheckCircle className="w-4 h-4 text-emerald-400" />
                        {feature}
                      </li>
                    ))}
                  </ul>
                </CardContent>
              </Card>
            </motion.div>
          ))}
        </div>

        {/* Stats */}
        <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
          {[
            { label: "Properties Managed", value: "2,500+" },
            { label: "Active Leases", value: "1,800+" },
            { label: "Maintenance Requests", value: "99.2%" },
            { label: "Client Satisfaction", value: "4.8" }
          ].map((stat, idx) => (
            <motion.div
              key={idx}
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: 0.4 + idx * 0.1 }}
            >
              <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
                <CardContent className="p-6 text-center">
                  <div className="text-2xl font-bold text-white mb-1">{stat.value}</div>
                  <div className="text-sm text-gray-400">{stat.label}</div>
                </CardContent>
              </Card>
            </motion.div>
          ))}
        </div>
      </div>
    </div>
  );
}
