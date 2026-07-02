"use client";

import { useRouter } from "next/navigation";
import { Button } from "@/components/ui/button";
import { Check, Zap, Shield, Activity, Fingerprint, Star, ArrowUpRight } from "lucide-react";
import { motion } from "framer-motion";
import { cn } from "@/lib/utils";

export function PricingContent() {
  const router = useRouter();

  const plans = [
    {
      id: "starter-10",
      name: "STARTER (10 MÜLK)",
      key: "starter",
      priceMonthlyCents: 1900,
      limits: { maxProperties: 10, maxUsers: 1, maxListings: 25, aiFeatures: false, customIntegrations: false, prioritySupport: false }
    },
    {
      id: "growth-25",
      name: "GROWTH (25 MÜLK)",
      key: "growth",
      priceMonthlyCents: 4900,
      limits: { maxProperties: 25, maxUsers: 3, maxListings: 100, aiFeatures: false, customIntegrations: false, prioritySupport: false }
    },
    {
      id: "professional-50",
      name: "PRO (50 MÜLK)",
      key: "professional",
      priceMonthlyCents: 8000,
      limits: { maxProperties: 50, maxUsers: 5, maxListings: 250, aiFeatures: true, customIntegrations: false, prioritySupport: true }
    },
    {
      id: "agency-100",
      name: "AGENCY (100 MÜLK)",
      key: "agency",
      priceMonthlyCents: 15000,
      limits: { maxProperties: 100, maxUsers: 10, maxListings: 500, aiFeatures: true, customIntegrations: false, prioritySupport: true }
    },
    {
      id: "enterprise",
      name: "ENTERPRISE",
      key: "enterprise",
      priceMonthlyCents: null,
      limits: { maxProperties: null, maxUsers: null, maxListings: null, aiFeatures: true, customIntegrations: true, prioritySupport: true }
    }
  ];

  const formatPrice = (cents: number | null) => {
    if (cents === null || cents === undefined) return "CUSTOM";
    return `$${(cents / 100).toFixed(0)}`;
  };

  const generateFeatures = (limits: Record<string, unknown>) => {
    const features = [];
    if (limits?.maxProperties) {
      features.push(`${limits.maxProperties} Properties`);
    } else {
      features.push("Unlimited Properties");
    }

    if (limits?.maxUsers) {
      features.push(`${limits.maxUsers} Users`);
    }

    if (limits?.maxListings) {
      features.push(`${limits.maxListings} Listings`);
    } else {
      features.push("Unlimited Listings");
    }

    if (limits?.aiFeatures) {
      features.push("AI-Powered Analytics");
    }
    
    if (limits?.customIntegrations) {
      features.push("Custom Integrations & ERP");
    }
    
    if (limits?.prioritySupport) {
      features.push("24/7 Priority Support");
    } else {
      features.push("Standard Email Support");
    }
    
    return features;
  };

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
              <h1 className="text-3xl font-bold text-white mb-2">Pricing Plans</h1>
              <p className="text-gray-400">Choose the perfect plan for your real estate business</p>
            </div>
            <Button
              onClick={() => router.push('/client/dashboard')}
              className="bg-purple-600 hover:bg-purple-700"
            >
              <ArrowUpRight className="w-4 h-4 mr-2" />
              Dashboard
            </Button>
          </div>
        </motion.div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-5 gap-6 max-w-[1600px] mx-auto">
          {plans.map((plan, index) => {
            const isPopular = plan.priceMonthlyCents !== null && plan.priceMonthlyCents > 5000 && plan.priceMonthlyCents < 20000;
            return (
              <motion.div
                key={plan.id}
                initial={{ opacity: 0, y: 30 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: index * 0.1 }}
                className={cn(
                  "relative p-10 rounded-[48px] bg-white/5 backdrop-blur-xl border border-purple-500/20 flex flex-col h-full transition-all duration-500 hover:bg-white/10 group",
                  isPopular && "border-blue-500/50 ring-1 ring-blue-500/20"
                )}
              >
                {isPopular && (
                  <div className="absolute -top-6 left-1/2 -translate-x-1/2 bg-blue-600 text-white px-8 py-2 rounded-full text-[10px] font-bold tracking-widest uppercase shadow-xl shadow-blue-600/40 flex items-center gap-2">
                    <Star className="w-3 h-3 fill-white" /> MOST POPULAR
                  </div>
                )}

                <div className="space-y-6 mb-12">
                  <div className="space-y-1">
                    <h3 className="text-sm font-bold text-gray-500 tracking-widest uppercase">{plan.name}</h3>
                    <div className="flex items-baseline gap-2">
                      <span className="text-5xl font-bold text-white tracking-tighter">{formatPrice(plan.priceMonthlyCents)}</span>
                      {plan.priceMonthlyCents !== null && <span className="text-gray-600 font-bold text-xs uppercase">/ MONTH</span>}
                    </div>
                  </div>
                  <p className="text-sm text-gray-400 leading-relaxed">
                    Advanced management panel tailored to your needs.
                  </p>
                </div>

                <div className="space-y-4 mb-12 flex-1">
                  <p className="text-xs font-bold text-gray-600 tracking-widest border-b border-white/5 pb-2">FEATURES</p>
                  {generateFeatures(plan.limits).map((feature, fIdx) => (
                    <div key={fIdx} className="flex items-center gap-3">
                      <div className="h-5 w-5 rounded-full bg-blue-500/10 border border-blue-500/20 flex items-center justify-center shrink-0">
                        <Check className="w-3 h-3 text-blue-400" />
                      </div>
                      <span className="text-xs font-bold text-white tracking-widest group-hover:text-blue-400 transition-colors">{feature}</span>
                    </div>
                  ))}
                </div>

                <Button
                  onClick={() => {
                    if (plan.priceMonthlyCents !== null) {
                      router.push(`/client/checkout?plan=${plan.id}`);
                    } else {
                      router.push('/client/contact?reason=enterprise');
                    }
                  }}
                  className={cn(
                    "w-full h-16 rounded-2xl font-bold text-xs tracking-widest uppercase transition-all duration-300",
                    isPopular 
                      ? "bg-blue-600 hover:bg-blue-500 text-white shadow-xl shadow-blue-600/20" 
                      : "bg-white/5 hover:bg-white/10 text-white border border-white/10"
                  )}
                >
                  <Zap className="w-4 h-4 mr-2" /> {plan.priceMonthlyCents !== null ? "GET STARTED" : "CONTACT SALES"}
                </Button>

                <div className="mt-8 flex items-center justify-center gap-4 opacity-30 group-hover:opacity-100 transition-opacity">
                  <Fingerprint className="w-4 h-4 text-gray-500" />
                  <Shield className="w-4 h-4 text-gray-500" />
                  <Activity className="w-4 h-4 text-gray-500" />
                </div>
              </motion.div>
            );
          })}
        </div>

        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 0.5 }}
          className="mt-20 p-12 rounded-[40px] bg-gradient-to-b from-transparent to-white/5 border border-purple-500/20 text-center"
        >
          <h2 className="text-xl font-bold text-white tracking-tighter mb-4">MILITARY-GRADE SECURITY</h2>
          <p className="text-sm text-gray-500 tracking-widest max-w-2xl mx-auto mb-8">
            All plans are protected with enterprise-level encryption and advanced data security standards.
          </p>
          <div className="flex flex-wrap justify-center gap-12">
            {["AES-256", "SHA-512", "TLS 1.3", "RBAC", "ISO 27001"].map(auth => (
              <span key={auth} className="text-xs font-bold text-gray-600 tracking-widest">{auth}</span>
            ))}
          </div>
        </motion.div>
      </div>
    </div>
  );
}
