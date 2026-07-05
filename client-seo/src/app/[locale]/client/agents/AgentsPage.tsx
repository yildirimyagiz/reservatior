"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import { Input } from "@/components/ui/input";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { 
  Edit, 
  Trash2, 
  Mail, 
  Star, 
  Plus, 
  Search, 
  Phone, 
  Building, 
  MapPin,
  ArrowUpRight,
  TrendingUp,
  Users
} from "lucide-react";
import { motion } from "framer-motion";
import { useTranslation } from "react-i18next";

interface Agent {
  id: string;
  name: string;
  email: string;
  phone: string;
  agency: string;
  status: "ACTIVE" | "INACTIVE" | "PENDING";
  rating: number;
  totalDeals: number;
  totalRevenue: number;
  specialization: string[];
  location: string;
}

const mockAgents: Agent[] = [
  {
    id: "1",
    name: "Sarah Johnson",
    email: "sarah.j@agency.com",
    phone: "+1 (555) 123-4567",
    agency: "Luxury Properties Inc",
    status: "ACTIVE",
    rating: 4.8,
    totalDeals: 45,
    totalRevenue: 12500000,
    specialization: ["Luxury", "Commercial"],
    location: "New York, NY"
  },
  {
    id: "2",
    name: "Michael Chen",
    email: "m.chen@agency.com",
    phone: "+1 (555) 234-5678",
    agency: "Prime Real Estate",
    status: "ACTIVE",
    rating: 4.9,
    totalDeals: 62,
    totalRevenue: 18200000,
    specialization: ["Residential", "Investment"],
    location: "Los Angeles, CA"
  },
  {
    id: "3",
    name: "Emily Rodriguez",
    email: "e.rodriguez@agency.com",
    phone: "+1 (555) 345-6789",
    agency: "Global Realty",
    status: "PENDING",
    rating: 4.5,
    totalDeals: 28,
    totalRevenue: 8900000,
    specialization: ["Residential", "Luxury"],
    location: "Miami, FL"
  }
];

const STATUS_COLORS: Record<string, string> = {
  ACTIVE: "bg-green-500/20 text-green-400 border-green-500/30",
  INACTIVE: "bg-gray-500/20 text-gray-400 border-gray-500/30",
  PENDING: "bg-yellow-500/20 text-yellow-400 border-yellow-500/30"
};

export default function AgentsPage() {
    const { t } = useTranslation();
  const router = useRouter();
  const [searchTerm, setSearchTerm] = useState("");
  const [statusFilter, setStatusFilter] = useState("ALL");

  const filteredAgents = mockAgents.filter(agent => {
    if (searchTerm && !agent.name.toLowerCase().includes(searchTerm.toLowerCase())) return false;
    if (statusFilter !== "ALL" && agent.status !== statusFilter) return false;
    return true;
  });

  const totalAgents = filteredAgents.length;
  const totalRevenue = filteredAgents.reduce((sum, a) => sum + a.totalRevenue, 0);
  const avgRating = filteredAgents.reduce((sum, a) => sum + a.rating, 0) / totalAgents;

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
              <h1 className="text-3xl font-bold text-white mb-2">{t("agents.agentspage.auto_ext_1")}</h1>
              <p className="text-gray-400">{t("agents.agentspage.auto_ext_2")}</p>
            </div>
            <Button
              onClick={() => router.push('/dashboard')}
              className="bg-purple-600 hover:bg-purple-700"
            >
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("agents.agentspage.auto_ext_3")}
                                      </Button>
          </div>
        </motion.div>

        {/* Stats */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.1 }}
          >
            <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
              <CardContent className="p-6">
                <div className="flex items-center justify-between">
                  <div>
                    <div className="text-sm text-gray-400 mb-1">{t("agents.agentspage.auto_ext_4")}</div>
                    <div className="text-2xl font-bold text-white">{totalAgents}</div>
                  </div>
                  <div className="p-3 rounded-lg bg-blue-500/10">
                    <Users className="w-6 h-6 text-blue-400" />
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
                    <div className="text-sm text-gray-400 mb-1">{t("agents.agentspage.auto_ext_5")}</div>
                    <div className="text-2xl font-bold text-white">${(totalRevenue / 1000000).toFixed(1)}M</div>
                  </div>
                  <div className="p-3 rounded-lg bg-green-500/10">
                    <TrendingUp className="w-6 h-6 text-green-400" />
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
                    <div className="text-sm text-gray-400 mb-1">{t("agents.agentspage.auto_ext_6")}</div>
                    <div className="text-2xl font-bold text-white">{avgRating.toFixed(1)}</div>
                  </div>
                  <div className="p-3 rounded-lg bg-yellow-500/10">
                    <Star className="w-6 h-6 text-yellow-400" />
                  </div>
                </div>
              </CardContent>
            </Card>
          </motion.div>
        </div>

        {/* Filters */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.4 }}
          className="mb-6"
        >
          <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
            <CardContent className="p-4">
              <div className="flex gap-4">
                <div className="flex-1">
                  <div className="relative">
                    <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" />
                    <Input
                      placeholder="Search agents..."
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-white/10 border-purple-500/30 text-white placeholder:text-gray-400"
                    />
                  </div>
                </div>
                <Select value={statusFilter} onValueChange={setStatusFilter}>
                  <SelectTrigger className="w-40 bg-white/10 border-purple-500/30 text-white">
                    <SelectValue placeholder="Status" />
                  </SelectTrigger>
                  <SelectContent className="bg-slate-900 border-purple-500/30">
                    <SelectItem value="ALL">{t("agents.agentspage.auto_ext_7")}</SelectItem>
                    <SelectItem value="ACTIVE">{t("agents.agentspage.auto_ext_8")}</SelectItem>
                    <SelectItem value="INACTIVE">{t("agents.agentspage.auto_ext_9")}</SelectItem>
                    <SelectItem value="PENDING">{t("agents.agentspage.auto_ext_10")}</SelectItem>
                  </SelectContent>
                </Select>
                <Button className="bg-purple-600 hover:bg-purple-700">
                  <Plus className="w-4 h-4 mr-2" />
                  {t("agents.agentspage.auto_ext_11")}
                                                  </Button>
              </div>
            </CardContent>
          </Card>
        </motion.div>

        {/* Agents Grid */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.5 }}
        >
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {filteredAgents.map((agent) => (
              <Card
                key={agent.id}
                className="bg-white/5 backdrop-blur-xl border-purple-500/20 hover:bg-white/10 transition-colors"
              >
                <CardHeader>
                  <div className="flex items-start justify-between">
                    <div className="flex items-center gap-4">
                      <Avatar className="w-12 h-12 rounded-xl">
                        <AvatarFallback className="bg-purple-600/20 text-purple-400 font-bold">
                          {agent.name.split(' ').map(n => n[0]).join('')}
                        </AvatarFallback>
                      </Avatar>
                      <div>
                        <CardTitle className="text-white">{agent.name}</CardTitle>
                        <div className="flex items-center gap-1 text-gray-400 text-sm">
                          <Building className="w-3 h-3" />
                          <span>{agent.agency}</span>
                        </div>
                      </div>
                    </div>
                    <Badge
                      variant="outline"
                      className={STATUS_COLORS[agent.status]}
                    >
                      {agent.status}
                    </Badge>
                  </div>
                </CardHeader>
                <CardContent className="space-y-4">
                  <div className="flex items-center gap-2 text-sm text-gray-400">
                    <MapPin className="w-4 h-4" />
                    <span>{agent.location}</span>
                  </div>

                  <div className="flex items-center gap-2 text-sm text-gray-400">
                    <Mail className="w-4 h-4" />
                    <span className="truncate">{agent.email}</span>
                  </div>

                  <div className="flex items-center gap-2 text-sm text-gray-400">
                    <Phone className="w-4 h-4" />
                    <span>{agent.phone}</span>
                  </div>

                  <div className="flex flex-wrap gap-2">
                    {agent.specialization.map((spec) => (
                      <Badge key={spec} variant="outline" className="text-xs border-purple-500/30 text-purple-300">
                        {spec}
                      </Badge>
                    ))}
                  </div>

                  <div className="grid grid-cols-2 gap-4 pt-4 border-t border-purple-500/20">
                    <div>
                      <div className="text-xs text-gray-400 mb-1">{t("agents.agentspage.auto_ext_12")}</div>
                      <div className="flex items-center gap-1 text-white">
                        <Star className="w-4 h-4 text-yellow-400 fill-yellow-400" />
                        <span className="font-medium">{agent.rating}</span>
                      </div>
                    </div>
                    <div>
                      <div className="text-xs text-gray-400 mb-1">{t("agents.agentspage.auto_ext_13")}</div>
                      <div className="text-white font-medium">{agent.totalDeals}</div>
                    </div>
                  </div>

                  <div className="flex items-center justify-between pt-4 border-t border-purple-500/20">
                    <div>
                      <div className="text-xs text-gray-400 mb-1">{t("agents.agentspage.auto_ext_14")}</div>
                      <div className="text-green-400 font-medium">${(agent.totalRevenue / 1000000).toFixed(1)}M</div>
                    </div>
                    <div className="flex gap-2">
                      <Button variant="ghost" size="icon" className="h-8 w-8">
                        <Edit className="w-4 h-4" />
                      </Button>
                      <Button variant="ghost" size="icon" className="h-8 w-8 text-red-400 hover:text-red-300">
                        <Trash2 className="w-4 h-4" />
                      </Button>
                    </div>
                  </div>
                </CardContent>
              </Card>
            ))}
          </div>
        </motion.div>
      </div>
    </div>
  );
}
