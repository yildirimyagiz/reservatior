"use client";

import { useRouter } from "next/navigation";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { 
  Shield, 
  CheckCircle, 
  ArrowUpRight,
  FileText,
  Search
} from "lucide-react";
import { motion } from "framer-motion";

const verificationSteps = [
  {
    icon: <Search className="w-6 h-6 text-blue-400" />,
    title: "Identity Verification",
    description: "Government ID verification and background checks",
    status: "completed"
  },
  {
    icon: <FileText className="w-6 h-6 text-purple-400" />,
    title: "Document Review",
    description: "Employment and income verification",
    status: "completed"
  },
  {
    icon: <Shield className="w-6 h-6 text-emerald-400" />,
    title: "Security Check",
    description: "Criminal background and credit history",
    status: "in_progress"
  },
  {
    icon: <CheckCircle className="w-6 h-6 text-amber-400" />,
    title: "Final Approval",
    description: "Comprehensive review and approval",
    status: "pending"
  }
];

export default function TenantVerificationPage() {
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
              <h1 className="text-3xl font-bold text-white mb-2">Tenant Verification</h1>
              <p className="text-gray-400">Comprehensive tenant screening and verification</p>
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

        {/* Verification Steps */}
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6 mb-12">
          {verificationSteps.map((step, idx) => (
            <motion.div
              key={idx}
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: idx * 0.1 }}
            >
              <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
                <CardHeader>
                  <div className="flex items-center justify-between">
                    <div className="flex items-center gap-4">
                      <div className="p-3 rounded-xl bg-purple-500/20">
                        {step.icon}
                      </div>
                      <CardTitle className="text-white">{step.title}</CardTitle>
                    </div>
                    <Badge 
                      className={
                        step.status === 'completed' ? 'bg-green-500/20 text-green-400' :
                        step.status === 'in_progress' ? 'bg-blue-500/20 text-blue-400' :
                        'bg-gray-500/20 text-gray-400'
                      }
                    >
                      {step.status}
                    </Badge>
                  </div>
                </CardHeader>
                <CardContent>
                  <p className="text-gray-400">{step.description}</p>
                </CardContent>
              </Card>
            </motion.div>
          ))}
        </div>

        {/* Stats */}
        <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
          {[
            { label: "Verified Tenants", value: "5,200+" },
            { label: "Approval Rate", value: "94%" },
            { label: "Avg. Processing Time", value: "2 days" },
            { label: "Accuracy", value: "99.5%" }
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
