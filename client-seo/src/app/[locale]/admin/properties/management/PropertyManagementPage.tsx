"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { 
  Building2, 
  Search, 
  Plus, 
  Edit, 
  Trash2, 
  ArrowUpRight,
  MapPin,
  Bed,
  Bath,
  DollarSign
} from "lucide-react";
import { motion } from "framer-motion";
import { useTranslation } from "react-i18next";

interface Property {
  id: string;
  name: string;
  type: string;
  address: string;
  city: string;
  price: number;
  bedrooms: number;
  bathrooms: number;
  area: number;
  status: "AVAILABLE" | "RENTED" | "MAINTENANCE";
}

const mockProperties: Property[] = [
  { id: "1", name: "Luxury Villa", type: "VILLA", address: "123 Palm Beach Dr", city: "Miami", price: 1250000, bedrooms: 5, bathrooms: 4, area: 450, status: "AVAILABLE" },
  { id: "2", name: "Downtown Apartment", type: "APARTMENT", address: "456 Broadway", city: "New York", price: 4500, bedrooms: 2, bathrooms: 2, area: 120, status: "RENTED" },
  { id: "3", name: "Beachfront Condo", type: "CONDO", address: "789 Ocean Blvd", city: "Los Angeles", price: 890000, bedrooms: 3, bathrooms: 2, area: 180, status: "AVAILABLE" },
  { id: "4", name: "Studio Loft", type: "STUDIO", address: "321 Arts District", city: "San Francisco", price: 1800, bedrooms: 1, bathrooms: 1, area: 65, status: "MAINTENANCE" }
];

const STATUS_COLORS: Record<string, string> = {
  AVAILABLE: "bg-green-500/20 text-green-400",
  RENTED: "bg-slate-500/20 text-slate-400",
  MAINTENANCE: "bg-yellow-500/20 text-yellow-400"
};

export default function PropertyManagementPage() {
    const { t } = useTranslation();
  const router = useRouter();
  const [searchTerm, setSearchTerm] = useState("");

  const filteredProperties = mockProperties.filter(property => 
    property.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
    property.city.toLowerCase().includes(searchTerm.toLowerCase())
  );

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-slate-900 to-slate-900">
      <div className="container mx-auto px-4 py-8">
        <motion.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="mb-8"
        >
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-white mb-2">{t("admin.properties.management.title")}</h1>
              <p className="text-gray-400">{t("admin.properties.management.description")}</p>
            </div>
            <Button
              onClick={() => router.push('/dashboard')}
              className="bg-slate-600 hover:bg-slate-700"
            >
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("admin.properties.management.back_to_dashboard")}
                                      </Button>
          </div>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
          className="mb-6"
        >
          <Card className="bg-white/5 backdrop-blur-xl border-slate-500/20">
            <CardContent className="p-4">
              <div className="flex gap-4">
                <div className="flex-1">
                  <div className="relative">
                    <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" />
                    <Input
                      placeholder={t("admin.properties.management.search_placeholder")}
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-white/10 border-slate-500/30 text-white placeholder:text-gray-400"
                    />
                  </div>
                </div>
                <Button className="bg-slate-600 hover:bg-slate-700">
                  <Plus className="w-4 h-4 mr-2" />
                  {t("admin.properties.management.add_property")}
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
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {filteredProperties.map((property) => (
              <Card key={property.id} className="bg-white/5 backdrop-blur-xl border-slate-500/20">
                <CardHeader>
                  <div className="flex items-start justify-between mb-2">
                    <Badge className={STATUS_COLORS[property.status]}>{property.status}</Badge>
                    <Badge variant="outline" className="border-slate-500/30 text-slate-300">{property.type}</Badge>
                  </div>
                  <CardTitle className="text-white">{property.name}</CardTitle>
                </CardHeader>
                <CardContent className="space-y-4">
                  <div className="flex items-center gap-2 text-gray-400">
                    <MapPin className="w-4 h-4" />
                    <span className="text-sm">{property.address}, {property.city}</span>
                  </div>

                  <div className="flex items-center gap-4 text-sm">
                    <div className="flex items-center gap-1 text-white">
                      <Bed className="w-4 h-4" />
                      <span>{property.bedrooms}</span>
                    </div>
                    <div className="flex items-center gap-1 text-white">
                      <Bath className="w-4 h-4" />
                      <span>{property.bathrooms}</span>
                    </div>
                    <div className="flex items-center gap-1 text-white">
                      <Building2 className="w-4 h-4" />
                      <span>{property.area} {t("admin.properties.management.sqft_label")}</span>
                    </div>
                  </div>

                  <div className="pt-4 border-t border-slate-500/20">
                    <div className="flex items-center justify-between">
                      <div className="text-xl font-bold text-white">
                        <DollarSign className="w-4 h-4 inline" />
                        {property.price.toLocaleString()}
                      </div>
                      <div className="flex gap-2">
                        <Button variant="ghost" size="icon" className="h-8 w-8">
                          <Edit className="w-4 h-4" />
                        </Button>
                        <Button variant="ghost" size="icon" className="h-8 w-8 text-red-400">
                          <Trash2 className="w-4 h-4" />
                        </Button>
                      </div>
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
