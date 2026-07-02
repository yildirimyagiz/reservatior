"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { 
  TrendingUp, 
  Search, 
  Plus, 
  ArrowUpRight,
  Building2,
  DollarSign,
  Calendar,
  BarChart3
} from "lucide-react";
import { motion } from "framer-motion";

interface Valuation {
  id: string;
  propertyName: string;
  currentValue: number;
  previousValue: number;
  change: number;
  changePercent: number;
  lastUpdated: string;
  type: "APPRAISAL" | "MARKET" | "AI_ESTIMATE";
}

const mockValuations: Valuation[] = [
  { id: "1", propertyName: "Luxury Villa", currentValue: 1250000, previousValue: 1200000, change: 50000, changePercent: 4.2, lastUpdated: "2024-04-15", type: "APPRAISAL" },
  { id: "2", propertyName: "Downtown Apartment", currentValue: 890000, previousValue: 850000, change: 40000, changePercent: 4.7, lastUpdated: "2024-04-14", type: "MARKET" },
  { id: "3", propertyName: "Beachfront Condo", currentValue: 750000, previousValue: 780000, change: -30000, changePercent: -3.8, lastUpdated: "2024-04-13", type: "AI_ESTIMATE" },
  { id: "4", propertyName: "Studio Loft", currentValue: 420000, previousValue: 400000, change: 20000, changePercent: 5.0, lastUpdated: "2024-04-12", type: "APPRAISAL" }
];

const TYPE_COLORS: Record<string, string> = {
  APPRAISAL: "bg-blue-500/20 text-blue-400",
  MARKET: "bg-purple-500/20 text-purple-400",
  AI_ESTIMATE: "bg-emerald-500/20 text-emerald-400"
};

export default function PropertyValuationsPage() {
  const router = useRouter();
  const [searchTerm, setSearchTerm] = useState("");

  const filteredValuations = mockValuations.filter(valuation => 
    valuation.propertyName.toLowerCase().includes(searchTerm.toLowerCase())
  );

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-purple-900 to-slate-900">
      <div className="container mx-auto px-4 py-8">
        <motion.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="mb-8"
        >
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-white mb-2">Property Valuations</h1>
              <p className="text-gray-400">Track property values and market trends</p>
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

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
          className="mb-6"
        >
          <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
            <CardContent className="p-4">
              <div className="flex gap-4">
                <div className="flex-1">
                  <div className="relative">
                    <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" />
                    <Input
                      placeholder="Search valuations..."
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-white/10 border-purple-500/30 text-white placeholder:text-gray-400"
                    />
                  </div>
                </div>
                <Button className="bg-purple-600 hover:bg-purple-700">
                  <Plus className="w-4 h-4 mr-2" />
                  New Valuation
                </Button>
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
            <CardHeader>
              <CardTitle className="text-white flex items-center gap-2">
                <BarChart3 className="w-5 h-5" />
                All Valuations ({filteredValuations.length})
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {filteredValuations.map((valuation) => (
                  <div
                    key={valuation.id}
                    className="flex items-center justify-between p-4 bg-white/5 rounded-lg hover:bg-white/10 transition-colors"
                  >
                    <div className="flex items-center gap-4">
                      <div className="w-12 h-12 rounded-lg bg-purple-500/20 flex items-center justify-center">
                        <Building2 className="w-6 h-6 text-purple-400" />
                      </div>
                      <div>
                        <div className="text-white font-medium">{valuation.propertyName}</div>
                        <div className="text-sm text-gray-400 flex items-center gap-2">
                          <Calendar className="w-3 h-3" />
                          {valuation.lastUpdated}
                        </div>
                      </div>
                    </div>
                    <div className="flex items-center gap-4">
                      <Badge className={TYPE_COLORS[valuation.type]}>{valuation.type}</Badge>
                      <div className="text-right">
                        <div className="text-white font-bold">
                          <DollarSign className="w-4 h-4 inline" />
                          {valuation.currentValue.toLocaleString()}
                        </div>
                        <div className={`text-sm flex items-center gap-1 ${valuation.change >= 0 ? 'text-green-400' : 'text-red-400'}`}>
                          <TrendingUp className={`w-3 h-3 ${valuation.change < 0 ? 'rotate-180' : ''}`} />
                          {valuation.change >= 0 ? '+' : ''}{valuation.changePercent}%
                        </div>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </motion.div>
      </div>
    </div>
  );
}
