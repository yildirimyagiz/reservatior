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
  DollarSign,
  Star
} from "lucide-react";
import { motion } from "framer-motion";

interface Listing {
  id: string;
  title: string;
  type: "SALE" | "RENT" | "SHORT_TERM";
  price: number;
  address: string;
  city: string;
  featured: boolean;
  views: number;
  status: "ACTIVE" | "PENDING" | "SOLD";
}

const mockListings: Listing[] = [
  { id: "1", title: "Luxury Villa with Ocean View", type: "SALE", price: 1250000, address: "123 Palm Beach Dr", city: "Miami", featured: true, views: 2450, status: "ACTIVE" },
  { id: "2", title: "Modern Downtown Apartment", type: "RENT", price: 4500, address: "456 Broadway", city: "New York", featured: false, views: 1890, status: "ACTIVE" },
  { id: "3", title: "Beachfront Condo", type: "SHORT_TERM", price: 350, address: "789 Ocean Blvd", city: "Los Angeles", featured: true, views: 3200, status: "PENDING" },
  { id: "4", title: "Cozy Studio Loft", type: "RENT", price: 1800, address: "321 Arts District", city: "San Francisco", featured: false, views: 980, status: "SOLD" }
];

const TYPE_COLORS: Record<string, string> = {
  SALE: "bg-slate-500/20 text-slate-400",
  RENT: "bg-slate-500/20 text-slate-400",
  SHORT_TERM: "bg-emerald-500/20 text-emerald-400"
};

const STATUS_COLORS: Record<string, string> = {
  ACTIVE: "bg-green-500/20 text-green-400",
  PENDING: "bg-yellow-500/20 text-yellow-400",
  SOLD: "bg-gray-500/20 text-gray-400"
};

export default function PropertyListingsPage() {
  const router = useRouter();
  const [searchTerm, setSearchTerm] = useState("");

  const filteredListings = mockListings.filter(listing => 
    listing.title.toLowerCase().includes(searchTerm.toLowerCase()) ||
    listing.city.toLowerCase().includes(searchTerm.toLowerCase())
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
              <h1 className="text-3xl font-bold text-white mb-2">Property Listings</h1>
              <p className="text-gray-400">Manage your property listings</p>
            </div>
            <Button
              onClick={() => router.push('/dashboard')}
              className="bg-slate-600 hover:bg-slate-700"
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
          <Card className="bg-white/5 backdrop-blur-xl border-slate-500/20">
            <CardContent className="p-4">
              <div className="flex gap-4">
                <div className="flex-1">
                  <div className="relative">
                    <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" />
                    <Input
                      placeholder="Search listings..."
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-white/10 border-slate-500/30 text-white placeholder:text-gray-400"
                    />
                  </div>
                </div>
                <Button className="bg-slate-600 hover:bg-slate-700">
                  <Plus className="w-4 h-4 mr-2" />
                  Add Listing
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
          <Card className="bg-white/5 backdrop-blur-xl border-slate-500/20">
            <CardHeader>
              <CardTitle className="text-white">All Listings ({filteredListings.length})</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {filteredListings.map((listing) => (
                  <div
                    key={listing.id}
                    className="flex items-center justify-between p-4 bg-white/5 rounded-lg hover:bg-white/10 transition-colors"
                  >
                    <div className="flex items-center gap-4">
                      <div className="w-12 h-12 rounded-lg bg-slate-500/20 flex items-center justify-center">
                        <Building2 className="w-6 h-6 text-slate-400" />
                      </div>
                      <div>
                        <div className="flex items-center gap-2">
                          <div className="text-white font-medium">{listing.title}</div>
                          {listing.featured && <Star className="w-4 h-4 text-yellow-400 fill-yellow-400" />}
                        </div>
                        <div className="text-sm text-gray-400 flex items-center gap-2">
                          <MapPin className="w-3 h-3" />
                          {listing.address}, {listing.city}
                        </div>
                      </div>
                    </div>
                    <div className="flex items-center gap-4">
                      <Badge className={TYPE_COLORS[listing.type]}>{listing.type}</Badge>
                      <Badge className={STATUS_COLORS[listing.status]}>{listing.status}</Badge>
                      <div className="text-white font-bold">
                        <DollarSign className="w-4 h-4 inline" />
                        {listing.price.toLocaleString()}
                      </div>
                      <div className="text-sm text-gray-400">{listing.views} views</div>
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
                ))}
              </div>
            </CardContent>
          </Card>
        </motion.div>
      </div>
    </div>
  );
}
