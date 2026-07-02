"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Building, MapPin, TrendingUp, Search, Grid, Map, Brain, Sparkles, ShieldCheck, Activity, Zap } from "lucide-react";
import { motion } from "framer-motion";
import { cn } from "@/lib/utils";

interface Property {
  id: string;
  name: string;
  address: string;
  type: string;
  bedrooms: number;
  bathrooms: number;
  sqm: number;
  price: number;
  occupancyRate: number;
  monthlyRevenue: number;
  aiValuation: number;
  valuationConfidence: number;
  ownershipVerified: boolean;
  status: "active" | "inactive" | "pending";
}

const mockProperties: Property[] = [
  {
    id: "1",
    name: "Sunset Villa",
    address: "123 Ocean Drive, Miami",
    type: "Villa",
    bedrooms: 4,
    bathrooms: 3,
    sqm: 250,
    price: 850000,
    occupancyRate: 85,
    monthlyRevenue: 12000,
    aiValuation: 920000,
    valuationConfidence: 0.92,
    ownershipVerified: true,
    status: "active"
  },
  {
    id: "2",
    name: "Downtown Loft",
    address: "456 Main Street, New York",
    type: "Apartment",
    bedrooms: 2,
    bathrooms: 2,
    sqm: 120,
    price: 450000,
    occupancyRate: 92,
    monthlyRevenue: 8500,
    aiValuation: 485000,
    valuationConfidence: 0.88,
    ownershipVerified: true,
    status: "active"
  },
  {
    id: "3",
    name: "Mountain Retreat",
    address: "789 Alpine Road, Colorado",
    type: "Cabin",
    bedrooms: 3,
    bathrooms: 2,
    sqm: 180,
    price: 320000,
    occupancyRate: 78,
    monthlyRevenue: 5200,
    aiValuation: 350000,
    valuationConfidence: 0.85,
    ownershipVerified: false,
    status: "pending"
  }
];

export default function PropertiesPage() {
  const router = useRouter();
  const [searchTerm, setSearchTerm] = useState("");
  const [viewMode, setViewMode] = useState<"grid" | "map">("grid");
  const [propertyType, setPropertyType] = useState("ALL");
  const [status, setStatus] = useState("ALL");

  const filteredProperties = mockProperties.filter(property => {
    if (searchTerm && !property.name.toLowerCase().includes(searchTerm.toLowerCase())) return false;
    if (propertyType !== "ALL" && property.type !== propertyType) return false;
    if (status !== "ALL" && property.status !== status) return false;
    return true;
  });

  const totalProperties = filteredProperties.length;
  const totalValue = filteredProperties.reduce((sum, p) => sum + p.aiValuation, 0);
  const avgOccupancy = filteredProperties.reduce((sum, p) => sum + p.occupancyRate, 0) / totalProperties;
  const monthlyRevenue = filteredProperties.reduce((sum, p) => sum + p.monthlyRevenue, 0);

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
              <h1 className="text-3xl font-bold text-white mb-2">Properties</h1>
              <p className="text-gray-400">Manage your properties with AI-powered valuation and insights</p>
            </div>
            <Button
              onClick={() => router.push('/dashboard')}
              className="bg-purple-600 hover:bg-purple-700"
            >
              <TrendingUp className="w-4 h-4 mr-2" />
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
                    <div className="text-sm text-gray-400 mb-1">Total Properties</div>
                    <div className="text-2xl font-bold text-white">{totalProperties}</div>
                  </div>
                  <div className="p-3 rounded-lg bg-blue-500/10">
                    <Building className="w-6 h-6 text-blue-400" />
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
                    <div className="text-sm text-gray-400 mb-1">Total Value (AI)</div>
                    <div className="text-2xl font-bold text-white">${(totalValue / 1000000).toFixed(1)}M</div>
                  </div>
                  <div className="p-3 rounded-lg bg-purple-500/10">
                    <Brain className="w-6 h-6 text-purple-400" />
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
                    <div className="text-sm text-gray-400 mb-1">Avg Occupancy</div>
                    <div className="text-2xl font-bold text-white">{avgOccupancy.toFixed(0)}%</div>
                  </div>
                  <div className="p-3 rounded-lg bg-green-500/10">
                    <Activity className="w-6 h-6 text-green-400" />
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
                    <div className="text-sm text-gray-400 mb-1">Monthly Revenue</div>
                    <div className="text-2xl font-bold text-white">${monthlyRevenue.toLocaleString()}</div>
                  </div>
                  <div className="p-3 rounded-lg bg-yellow-500/10">
                    <Zap className="w-6 h-6 text-yellow-400" />
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
          transition={{ delay: 0.5 }}
          className="mb-6"
        >
          <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
            <CardContent className="p-4">
              <div className="flex gap-4">
                <div className="flex-1">
                  <div className="relative">
                    <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" />
                    <Input
                      placeholder="Search properties..."
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-white/10 border-purple-500/30 text-white placeholder:text-gray-400"
                    />
                  </div>
                </div>
                <Select value={propertyType} onValueChange={setPropertyType}>
                  <SelectTrigger className="w-40 bg-white/10 border-purple-500/30 text-white">
                    <SelectValue placeholder="All Types" />
                  </SelectTrigger>
                  <SelectContent className="bg-slate-900 border-purple-500/30">
                    <SelectItem value="ALL">All Types</SelectItem>
                    <SelectItem value="Villa">Villa</SelectItem>
                    <SelectItem value="Apartment">Apartment</SelectItem>
                    <SelectItem value="Cabin">Cabin</SelectItem>
                  </SelectContent>
                </Select>
                <Select value={status} onValueChange={setStatus}>
                  <SelectTrigger className="w-40 bg-white/10 border-purple-500/30 text-white">
                    <SelectValue placeholder="All Status" />
                  </SelectTrigger>
                  <SelectContent className="bg-slate-900 border-purple-500/30">
                    <SelectItem value="ALL">All Status</SelectItem>
                    <SelectItem value="active">Active</SelectItem>
                    <SelectItem value="inactive">Inactive</SelectItem>
                    <SelectItem value="pending">Pending</SelectItem>
                  </SelectContent>
                </Select>
                <div className="flex gap-2">
                  <Button
                    variant={viewMode === "grid" ? "default" : "outline"}
                    size="icon"
                    onClick={() => setViewMode("grid")}
                    className={cn(viewMode === "grid" ? "bg-purple-600" : "border-purple-500/30")}
                  >
                    <Grid className="w-4 h-4" />
                  </Button>
                  <Button
                    variant={viewMode === "map" ? "default" : "outline"}
                    size="icon"
                    onClick={() => setViewMode("map")}
                    className={cn(viewMode === "map" ? "bg-purple-600" : "border-purple-500/30")}
                  >
                    <Map className="w-4 h-4" />
                  </Button>
                </div>
              </div>
            </CardContent>
          </Card>
        </motion.div>

        {/* Properties Grid */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.6 }}
        >
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {filteredProperties.map((property) => (
              <Card
                key={property.id}
                className="bg-white/5 backdrop-blur-xl border-purple-500/20 hover:bg-white/10 transition-colors cursor-pointer"
              >
                <CardHeader>
                  <div className="flex items-start justify-between">
                    <div className="flex-1">
                      <CardTitle className="text-white mb-1">{property.name}</CardTitle>
                      <div className="flex items-center gap-2 text-gray-400 text-sm">
                        <MapPin className="w-3 h-3" />
                        <span className="truncate">{property.address}</span>
                      </div>
                    </div>
                    <Badge
                      variant="outline"
                      className={cn(
                        "border",
                        property.status === "active"
                          ? "border-green-500/30 text-green-400"
                          : "border-yellow-500/30 text-yellow-400"
                      )}
                    >
                      {property.status}
                    </Badge>
                  </div>
                </CardHeader>
                <CardContent className="space-y-4">
                  <div className="flex items-center justify-between text-sm">
                    <span className="text-gray-400">{property.type}</span>
                    <span className="text-white">{property.bedrooms} bed • {property.bathrooms} bath • {property.sqm} sqm</span>
                  </div>

                  <div className="grid grid-cols-2 gap-4">
                    <div className="bg-white/5 rounded-lg p-3">
                      <div className="text-xs text-gray-400 mb-1">List Price</div>
                      <div className="text-lg font-bold text-white">${property.price.toLocaleString()}</div>
                    </div>
                    <div className="bg-purple-500/10 rounded-lg p-3">
                      <div className="text-xs text-purple-400 mb-1 flex items-center gap-1">
                        <Brain className="w-3 h-3" />
                        AI Valuation
                      </div>
                      <div className="text-lg font-bold text-purple-300">${property.aiValuation.toLocaleString()}</div>
                    </div>
                  </div>

                  <div className="space-y-2">
                    <div className="flex justify-between text-sm">
                      <span className="text-gray-400">Occupancy Rate</span>
                      <span className="text-white">{property.occupancyRate}%</span>
                    </div>
                    <div className="w-full bg-purple-500/20 rounded-full h-2">
                      <div
                        className="bg-purple-500 h-2 rounded-full transition-all"
                        style={{ width: `${property.occupancyRate}%` }}
                      />
                    </div>
                  </div>

                  <div className="flex items-center justify-between text-sm">
                    <span className="text-gray-400">Monthly Revenue</span>
                    <span className="text-green-400 font-medium">${property.monthlyRevenue.toLocaleString()}</span>
                  </div>

                  <div className="flex items-center gap-2 pt-2 border-t border-purple-500/20">
                    <Sparkles className="w-4 h-4 text-purple-400" />
                    <span className="text-xs text-gray-400">
                      AI Confidence: {(property.valuationConfidence * 100).toFixed(0)}%
                    </span>
                    {property.ownershipVerified && (
                      <ShieldCheck className="w-4 h-4 text-green-400 ml-auto" />
                    )}
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
