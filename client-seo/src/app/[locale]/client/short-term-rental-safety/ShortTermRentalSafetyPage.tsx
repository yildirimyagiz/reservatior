"use client";

import { useRouter } from "next/navigation";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { 
  Shield, 
  Lock,
  Camera,
  Bell,
  ArrowUpRight
} from "lucide-react";
import { m } from "framer-motion";
import { useTranslation } from "react-i18next";

const safetyFeatures = [
  {
    icon: <Camera className="w-6 h-6 text-brand" />,
    title: "24/7 Monitoring",
    description: "Continuous surveillance and security monitoring",
    status: "active"
  },
  {
    icon: <Lock className="w-6 h-6 text-brand" />,
    title: "Smart Locks",
    description: "Keyless entry with secure access codes",
    status: "active"
  },
  {
    icon: <Bell className="w-6 h-6 text-success" />,
    title: "Emergency Alerts",
    description: "Instant notification system for emergencies",
    status: "active"
  },
  {
    icon: <Shield className="w-6 h-6 text-amber-400" />,
    title: "Insurance Coverage",
    description: "Comprehensive property and liability insurance",
    status: "active"
  }
];

export default function ShortTermRentalSafetyPage() {
    const { t } = useTranslation();
  const router = useRouter();

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-purple-900 to-slate-900">
      <div className="container mx-auto px-4 py-8">
        {/* Header */}
        <m.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="mb-8"
        >
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-white mb-2">{t("short_term_rental_safety.shorttermrentalsafetypage.auto_ext_1")}</h1>
              <p className="text-gray-400">{t("short_term_rental_safety.shorttermrentalsafetypage.auto_ext_2")}</p>
            </div>
            <Button
              onClick={() => router.push('/dashboard')}
              className="bg-brand hover:bg-brand"
            >
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("short_term_rental_safety.shorttermrentalsafetypage.auto_ext_3")}
                                      </Button>
          </div>
        </m.div>

        {/* Safety Features */}
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6 mb-12">
          {safetyFeatures.map((feature, idx) => (
            <m.div
              key={idx}
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: idx * 0.1 }}
            >
              <Card className="bg-white/5 backdrop-blur-xl border-brand/20">
                <CardHeader>
                  <div className="flex items-center justify-between">
                    <div className="flex items-center gap-4">
                      <div className="p-3 rounded-xl bg-brand/20">
                        {feature.icon}
                      </div>
                      <CardTitle className="text-white">{feature.title}</CardTitle>
                    </div>
                    <Badge className="bg-blue-500/20 text-blue-400">{feature.status}</Badge>
                  </div>
                </CardHeader>
                <CardContent>
                  <p className="text-gray-400">{feature.description}</p>
                </CardContent>
              </Card>
            </m.div>
          ))}
        </div>

        {/* Stats */}
        <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
          {[
            { label: "Properties Protected", value: "3,200+" },
            { label: "Incidents Prevented", value: "99.8%" },
            { label: "Response Time", value: "< 2 min" },
            { label: "Safety Rating", value: "5.0" }
          ].map((stat, idx) => (
            <m.div
              key={idx}
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: 0.4 + idx * 0.1 }}
            >
              <Card className="bg-white/5 backdrop-blur-xl border-brand/20">
                <CardContent className="p-6 text-center">
                  <div className="text-2xl font-bold text-white mb-1">{stat.value}</div>
                  <div className="text-sm text-gray-400">{stat.label}</div>
                </CardContent>
              </Card>
            </m.div>
          ))}
        </div>
      </div>
    </div>
  );
}
