"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { 
  Heart, 
  Search, 
  ArrowUpRight,
  MapPin,
  DollarSign,
  Trash2
} from "lucide-react";
import { motion } from "framer-motion";

interface FavoriteProperty {
  id: string;
  name: string;
  type: string;
  address: string;
  city: string;
  price: number;
  bedrooms: number;
  bathrooms: number;
}

const mockFavorites: FavoriteProperty[] = [
  { id: "1", name: "Luxury Villa", type: "VILLA", address: "123 Palm Beach Dr", city: "Miami", price: 1250000, bedrooms: 5, bathrooms: 4 },
  { id: "2", name: "Downtown Apartment", type: "APARTMENT", address: "456 Broadway", city: "New York", price: 4500, bedrooms: 2, bathrooms: 2 },
  { id: "3", name: "Beachfront Condo", type: "CONDO", address: "789 Ocean Blvd", city: "Los Angeles", price: 890000, bedrooms: 3, bathrooms: 2 },
  { id: "4", name: "Studio Loft", type: "STUDIO", address: "321 Arts District", city: "San Francisco", price: 1800, bedrooms: 1, bathrooms: 1 }
];

export default function ProfileFavoritesPage() {
  const router = useRouter();
  const [searchTerm, setSearchTerm] = useState("");

  const filteredFavorites = mockFavorites.filter(property => 
    property.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
    property.city.toLowerCase().includes(searchTerm.toLowerCase())
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
              <h1 className="text-3xl font-bold text-white mb-2">My Favorites</h1>
              <p className="text-gray-400">Your saved properties</p>
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
              <div className="relative">
                <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" />
                <Input
                  placeholder="Search favorites..."
                  value={searchTerm}
                  onChange={(e) => setSearchTerm(e.target.value)}
                  className="pl-10 bg-white/10 border-purple-500/30 text-white placeholder:text-gray-400"
                />
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
            {filteredFavorites.map((property) => (
              <Card key={property.id} className="bg-white/5 backdrop-blur-xl border-purple-500/20">
                <CardHeader>
                  <div className="flex items-start justify-between">
                    <CardTitle className="text-white">{property.name}</CardTitle>
                    <Button variant="ghost" size="icon" className="h-8 w-8 text-red-400">
                      <Heart className="w-4 h-4 fill-current" />
                    </Button>
                  </div>
                </CardHeader>
                <CardContent className="space-y-4">
                  <div className="flex items-center gap-2 text-gray-400">
                    <MapPin className="w-4 h-4" />
                    <span className="text-sm">{property.address}, {property.city}</span>
                  </div>
                  <div className="text-xl font-bold text-white">
                    <DollarSign className="w-4 h-4 inline" />
                    {property.price.toLocaleString()}
                  </div>
                  <div className="flex items-center justify-between pt-4 border-t border-purple-500/20">
                    <div className="text-sm text-gray-400">{property.bedrooms} bed • {property.bathrooms} bath</div>
                    <Button variant="ghost" size="icon" className="h-8 w-8 text-red-400">
                      <Trash2 className="w-4 h-4" />
                    </Button>
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
