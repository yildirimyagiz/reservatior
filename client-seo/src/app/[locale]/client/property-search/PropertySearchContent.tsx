"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { 
  Search, 
  Filter, 
  Building2, 
  MapPin, 
  Bed, 
  Bath, 
  ArrowUpRight,
  Heart,
  Share2
} from "lucide-react";
import { motion } from "framer-motion";

interface Property {
  id: string;
  name: string;
  type: string;
  price: number;
  currency: string;
  address: string;
  city: string;
  bedrooms: number;
  bathrooms: number;
  area: number;
  listingType: "SALE" | "RENT" | "SHORT_TERM_RENTAL";
  status: "AVAILABLE" | "PENDING" | "SOLD";
  image?: string;
}

const mockProperties: Property[] = [
  {
    id: "1",
    name: "Luxury Villa with Pool",
    type: "VILLA",
    price: 1250000,
    currency: "USD",
    address: "123 Palm Beach Dr",
    city: "Miami",
    bedrooms: 5,
    bathrooms: 4,
    area: 450,
    listingType: "SALE",
    status: "AVAILABLE"
  },
  {
    id: "2",
    name: "Modern Downtown Apartment",
    type: "APARTMENT",
    price: 4500,
    currency: "USD",
    address: "456 Broadway",
    city: "New York",
    bedrooms: 2,
    bathrooms: 2,
    area: 120,
    listingType: "RENT",
    status: "AVAILABLE"
  },
  {
    id: "3",
    name: "Beachfront Condo",
    type: "CONDO",
    price: 890000,
    currency: "USD",
    address: "789 Ocean Blvd",
    city: "Los Angeles",
    bedrooms: 3,
    bathrooms: 2,
    area: 180,
    listingType: "SALE",
    status: "PENDING"
  },
  {
    id: "4",
    name: "Cozy Studio Loft",
    type: "STUDIO",
    price: 1800,
    currency: "USD",
    address: "321 Arts District",
    city: "San Francisco",
    bedrooms: 1,
    bathrooms: 1,
    area: 65,
    listingType: "RENT",
    status: "AVAILABLE"
  },
  {
    id: "5",
    name: "Penthouse Suite",
    type: "PENTHOUSE",
    price: 3500,
    currency: "USD",
    address: "555 Skyline Tower",
    city: "Chicago",
    bedrooms: 4,
    bathrooms: 3,
    area: 280,
    listingType: "SHORT_TERM_RENTAL",
    status: "AVAILABLE"
  },
  {
    id: "6",
    name: "Suburban Family Home",
    type: "DETACHED_HOUSE",
    price: 650000,
    currency: "USD",
    address: "888 Maple Street",
    city: "Austin",
    bedrooms: 4,
    bathrooms: 3,
    area: 220,
    listingType: "SALE",
    status: "AVAILABLE"
  }
];

const STATUS_COLORS: Record<string, string> = {
  AVAILABLE: "bg-green-500/20 text-green-400",
  PENDING: "bg-yellow-500/20 text-yellow-400",
  SOLD: "bg-red-500/20 text-red-400",
  RENTED: "bg-gray-500/20 text-gray-400"
};

const TYPE_COLORS: Record<string, string> = {
  SALE: "bg-blue-500/20 text-blue-400",
  RENT: "bg-purple-500/20 text-purple-400",
  SHORT_TERM_RENTAL: "bg-emerald-500/20 text-emerald-400"
};

export function PropertySearchContent({ initialProperties = [] }: { initialProperties?: any[] }) {
  const router = useRouter();
  const [searchTerm, setSearchTerm] = useState("");
  const [filterType, setFilterType] = useState<string>("all");

  // Use real properties if available, otherwise fallback to mock
  const propertiesToUse = initialProperties.length > 0 ? initialProperties.map(p => ({
    id: p.id,
    name: p.name || "Unnamed Property",
    type: p.propertyCategory || "PROPERTY",
    price: p.price || 0,
    currency: p.currency || "USD",
    address: p.addressLine1 || "",
    city: p.city || "",
    bedrooms: p.bedrooms || 0,
    bathrooms: p.bathrooms || 0,
    area: p.areaSqm || 0,
    listingType: p.listingType || "SALE",
    status: p.status || "AVAILABLE",
    image: p.listings?.[0]?.pricingRules?.[0]?.discountRules?.image || undefined
  })) : mockProperties;

  const filteredProperties = propertiesToUse.filter(property => {
    if (searchTerm && !property.name.toLowerCase().includes(searchTerm.toLowerCase())) return false;
    if (filterType !== "all" && property.listingType !== filterType) return false;
    return true;
  });

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
              <h1 className="text-3xl font-bold text-white mb-2">Property Search</h1>
              <p className="text-gray-400">Find your perfect property</p>
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

        {/* Search & Filter */}
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
                      placeholder="Search properties..."
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-white/10 border-purple-500/30 text-white placeholder:text-gray-400"
                    />
                  </div>
                </div>
                <Button variant="outline" className="bg-white/10 border-purple-500/30 text-white">
                  <Filter className="w-4 h-4 mr-2" />
                  Filters
                </Button>
              </div>
            </CardContent>
          </Card>
        </motion.div>

        {/* Type Filter */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2 }}
          className="mb-6 flex gap-2"
        >
          {["all", "SALE", "RENT", "SHORT_TERM_RENTAL"].map((type) => (
            <Button
              key={type}
              variant={filterType === type ? "default" : "outline"}
              className={
                filterType === type 
                  ? "bg-purple-600 hover:bg-purple-700" 
                  : "bg-white/10 border-purple-500/30 text-white"
              }
              onClick={() => setFilterType(type)}
            >
              {type === "all" ? "All" : type.replace("_", " ")}
            </Button>
          ))}
        </motion.div>

        {/* Properties Grid */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.3 }}
        >
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {filteredProperties.map((property) => (
              <Card
                key={property.id}
                className="bg-white/5 backdrop-blur-xl border-purple-500/20 hover:bg-white/10 transition-colors cursor-pointer"
              >
                <CardHeader>
                  <div className="flex items-start justify-between mb-4">
                    <Badge className={STATUS_COLORS[property.status]}>{property.status}</Badge>
                    <Badge className={TYPE_COLORS[property.listingType]}>{property.listingType.replace("_", " ")}</Badge>
                  </div>
                  <CardTitle className="text-white text-lg">{property.name}</CardTitle>
                </CardHeader>
                <CardContent className="space-y-4">
                  <div className="flex items-center gap-2 text-gray-400">
                    <MapPin className="w-4 h-4" />
                    <span className="text-sm">{property.address}, {property.city}</span>
                  </div>

                  <div className="flex items-center gap-4 text-sm">
                    <div className="flex items-center gap-1 text-white">
                      <Bed className="w-4 h-4" />
                      <span>{property.bedrooms} Beds</span>
                    </div>
                    <div className="flex items-center gap-1 text-white">
                      <Bath className="w-4 h-4" />
                      <span>{property.bathrooms} Baths</span>
                    </div>
                    <div className="flex items-center gap-1 text-white">
                      <Building2 className="w-4 h-4" />
                      <span>{property.area} m²</span>
                    </div>
                  </div>

                  <div className="pt-4 border-t border-purple-500/20">
                    <div className="flex items-center justify-between">
                      <div>
                        <div className="text-2xl font-bold text-white">
                          {property.currency === "USD" ? "$" : ""}{property.price.toLocaleString()}
                          {property.listingType === "RENT" || property.listingType === "SHORT_TERM_RENTAL" ? "/mo" : ""}
                        </div>
                        <div className="text-xs text-gray-400">{property.type}</div>
                      </div>
                      <div className="flex gap-2">
                        <Button variant="ghost" size="icon" className="h-8 w-8">
                          <Heart className="w-4 h-4" />
                        </Button>
                        <Button variant="ghost" size="icon" className="h-8 w-8">
                          <Share2 className="w-4 h-4" />
                        </Button>
                      </div>
                    </div>
                  </div>

                  <Button 
                    className="w-full bg-purple-600 hover:bg-purple-700"
                    onClick={() => router.push(`/client/properties/${property.id}`)}
                  >
                    View Details
                    <ArrowUpRight className="w-4 h-4 ml-2" />
                  </Button>
                </CardContent>
              </Card>
            ))}
          </div>
        </motion.div>
      </div>
    </div>
  );
}
