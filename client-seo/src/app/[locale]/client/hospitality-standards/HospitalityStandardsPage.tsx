"use client";

import { useRouter } from "next/navigation";
import { ShieldCheck, Clock, Users, Building2, CheckCircle, Star, Lock, ArrowUpRight, Hotel, Key, UserCheck } from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { motion } from "framer-motion";

const PILLARS = [
  {
    icon: <Clock className="w-7 h-7 text-amber-400" />,
    title: "Minimum Stay Policy",
    subtitle: "Quality Through Duration",
    description: "Enforcing a minimum 3-night stay eliminates single-night party bookings and attracts business travelers, families, and premium tourists who respect the residence.",
    features: [
      "Minimum 3-night stay enforced across all units",
      "Weekly & monthly rates for extended guests",
      "Peak-season premium pricing tiers",
      "Dynamic pricing aligned with 5-star benchmarks"
    ],
    gradient: "from-amber-500/10 to-orange-500/5"
  },
  {
    icon: <UserCheck className="w-7 h-7 text-blue-400" />,
    title: "White-Glove Operators",
    subtitle: "Licensed Property Managers Only",
    description: "Every short-term rental must be managed through a certified, Reservatior-approved property management company. No owner-managed ad hoc rentals are permitted.",
    features: [
      "Background screening for every guest",
      "Professional check-in & check-out protocols",
      "House rules briefing upon arrival",
      "24/7 on-call guest support & incident response"
    ],
    gradient: "from-blue-500/10 to-cyan-500/5"
  },
  {
    icon: <Building2 className="w-7 h-7 text-emerald-400" />,
    title: "Residence Segmentation",
    subtitle: "Separate Flows, Shared Prestige",
    description: "Purpose-built guest reception zones and smart elevator access ensure short-term guests never disrupt the daily life of permanent residents.",
    features: [
      "Dedicated guest reception & concierge desk",
      "Smart elevator card restricts floor access",
      "Separate luggage handling & parking zones",
      "Guest wristband system for pool & gym access"
    ],
    gradient: "from-emerald-500/10 to-green-500/5"
  }
];

export default function HospitalityStandardsPage() {
  const router = useRouter();

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-purple-900 to-slate-900">
      <div className="container mx-auto px-4 py-24">
        {/* Header */}
        <motion.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="mb-12"
        >
          <div className="flex items-center justify-between mb-8">
            <div>
              <Badge className="mb-6 bg-purple-500/10 text-purple-400 border border-purple-500/20 px-6 py-1 text-xs font-bold tracking-widest">
                <Star className="w-3 h-3 mr-2" /> PREMIUM STANDARDS
              </Badge>
              <h1 className="text-6xl md:text-8xl font-bold text-white tracking-tighter mb-4 italic leading-none">
                Hospitality <span className="text-transparent bg-clip-text bg-gradient-to-r from-purple-400 to-blue-500">Standards</span>
              </h1>
              <p className="text-xl text-gray-500 max-w-3xl font-bold tracking-widest italic leading-relaxed">
                Five-star quality standards for premium short-term rental experiences
              </p>
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

        {/* Pillars */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-8 mb-20">
          {PILLARS.map((pillar, idx) => (
            <motion.div
              key={idx}
              initial={{ opacity: 0, y: 30 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: idx * 0.1 }}
            >
              <Card className={`bg-gradient-to-br ${pillar.gradient} backdrop-blur-xl border border-purple-500/20 h-full`}>
                <CardHeader>
                  <div className="p-4 rounded-2xl bg-black/40 border border-white/5 mb-6 w-fit">
                    {pillar.icon}
                  </div>
                  <CardTitle className="text-xs font-bold text-gray-500 tracking-widest mb-2">{pillar.subtitle}</CardTitle>
                  <h3 className="text-2xl font-bold text-white italic tracking-tighter">{pillar.title}</h3>
                </CardHeader>
                <CardContent className="space-y-6">
                  <p className="text-sm text-gray-400 leading-relaxed">{pillar.description}</p>
                  <ul className="space-y-3">
                    {pillar.features.map((feature, i) => (
                      <li key={i} className="flex items-start gap-3 text-sm text-gray-300">
                        <CheckCircle className="w-4 h-4 text-emerald-400 mt-0.5 shrink-0" />
                        <span>{feature}</span>
                      </li>
                    ))}
                  </ul>
                </CardContent>
              </Card>
            </motion.div>
          ))}
        </div>

        {/* Stats */}
        <div className="grid grid-cols-1 md:grid-cols-4 gap-6 mb-20">
          {[
            { icon: Users, label: "Verified Guests", value: "12K+" },
            { icon: Hotel, label: "Premium Properties", value: "850+" },
            { icon: ShieldCheck, label: "Safety Rating", value: "99.9%" },
            { icon: Star, label: "Guest Satisfaction", value: "4.9" }
          ].map((stat, idx) => (
            <motion.div
              key={idx}
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: 0.4 + idx * 0.1 }}
            >
              <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
                <CardContent className="p-6 text-center">
                  <stat.icon className="w-8 h-8 text-purple-400 mx-auto mb-3" />
                  <div className="text-3xl font-bold text-white mb-1">{stat.value}</div>
                  <div className="text-sm text-gray-400">{stat.label}</div>
                </CardContent>
              </Card>
            </motion.div>
          ))}
        </div>

        {/* Features */}
        <div className="grid lg:grid-cols-2 gap-8">
          <motion.div
            initial={{ opacity: 0, x: -30 }}
            animate={{ opacity: 1, x: 0 }}
            transition={{ delay: 0.6 }}
          >
            <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
              <CardHeader>
                <CardTitle className="text-white flex items-center gap-3">
                  <Lock className="w-6 h-6 text-blue-400" />
                  Security & Compliance
                </CardTitle>
              </CardHeader>
              <CardContent className="space-y-4">
                {[
                  "24/7 security monitoring",
                  "Guest identity verification",
                  "Property damage insurance",
                  "Legal compliance checks"
                ].map((item, i) => (
                  <div key={i} className="flex items-center gap-3 p-3 bg-white/5 rounded-lg">
                    <CheckCircle className="w-5 h-5 text-emerald-400" />
                    <span className="text-gray-300">{item}</span>
                  </div>
                ))}
              </CardContent>
            </Card>
          </motion.div>

          <motion.div
            initial={{ opacity: 0, x: 30 }}
            animate={{ opacity: 1, x: 0 }}
            transition={{ delay: 0.7 }}
          >
            <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
              <CardHeader>
                <CardTitle className="text-white flex items-center gap-3">
                  <Key className="w-6 h-6 text-amber-400" />
                  Premium Services
                </CardTitle>
              </CardHeader>
              <CardContent className="space-y-4">
                {[
                  "Concierge services",
                  "Airport transfers",
                  "In-house dining",
                  "Spa & wellness access"
                ].map((item, i) => (
                  <div key={i} className="flex items-center gap-3 p-3 bg-white/5 rounded-lg">
                    <CheckCircle className="w-5 h-5 text-emerald-400" />
                    <span className="text-gray-300">{item}</span>
                  </div>
                ))}
              </CardContent>
            </Card>
          </motion.div>
        </div>
      </div>
    </div>
  );
}
