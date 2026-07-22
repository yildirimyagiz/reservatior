"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import { 
  Search, 
  Filter, 
  Video, 
  Star, 
  MapPin, 
  Mail, 
  ArrowUpRight,
  Clock
} from "lucide-react";
import { m } from "framer-motion";
import { useTranslation } from "react-i18next";

interface VideoVendor {
  id: string;
  name: string;
  email: string;
  phone: string;
  website: string;
  description: string;
  location: string;
  specialties: string[];
  rating: number;
  reviews: number;
  completedProjects: number;
  responseTime: string;
  tier: "basic" | "standard" | "premium";
}

const mockVendors: VideoVendor[] = [
  {
    id: "1",
    name: "ProVideo Studios",
    email: "contact@provideo.com",
    phone: "+1 (555) 123-4567",
    website: "provideo.com",
    description: "Professional property video production with 4K quality and drone footage",
    location: "New York, NY",
    specialties: ["Drone Footage", "4K Video", "Virtual Tours"],
    rating: 4.8,
    reviews: 156,
    completedProjects: 320,
    responseTime: "2 hours",
    tier: "premium"
  },
  {
    id: "2",
    name: "Cinematic Properties",
    email: "info@cinematic.com",
    phone: "+1 (555) 234-5678",
    website: "cinematic.com",
    description: "Cinematic quality videos for luxury real estate",
    location: "Los Angeles, CA",
    specialties: ["Cinematic", "Luxury", "Aerial"],
    rating: 4.9,
    reviews: 203,
    completedProjects: 450,
    responseTime: "1 hour",
    tier: "premium"
  },
  {
    id: "3",
    name: "QuickShoot Media",
    email: "hello@quickshoot.com",
    phone: "+1 (555) 345-6789",
    website: "quickshoot.com",
    description: "Fast turnaround video production for standard listings",
    location: "Miami, FL",
    specialties: ["Fast Turnaround", "Standard Video", "360° Tours"],
    rating: 4.5,
    reviews: 89,
    completedProjects: 180,
    responseTime: "4 hours",
    tier: "standard"
  }
];

const TIER_COLORS: Record<string, string> = {
  basic: "bg-gray-500/20 text-gray-400",
  standard: "bg-blue-500/20 text-blue-400",
  premium: "bg-purple-500/20 text-purple-400"
};

export default function VideoVendorsPage() {
    const { t } = useTranslation();
  const router = useRouter();
  const [searchTerm, setSearchTerm] = useState("");

  const filteredVendors = mockVendors.filter(vendor => {
    if (searchTerm && !vendor.name.toLowerCase().includes(searchTerm.toLowerCase())) return false;
    return true;
  });

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-purple-900 to-slate-900">
      <div className="container mx-auto px-4 py-8">
        {/* Header */}
        <m.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="mb-8"
        >
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-white mb-2">{t("video_vendors.videovendorspage.auto_ext_1")}</h1>
              <p className="text-gray-400">{t("video_vendors.videovendorspage.auto_ext_2")}</p>
            </div>
            <Button
              onClick={() => router.push('/dashboard')}
              className="bg-purple-600 hover:bg-purple-700"
            >
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("video_vendors.videovendorspage.auto_ext_3")}
                                      </Button>
          </div>
        </m.div>

        {/* Toolbar */}
        <m.div
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
                      placeholder="Search vendors..."
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-white/10 border-purple-500/30 text-white placeholder:text-gray-400"
                    />
                  </div>
                </div>
                <Button variant="outline" className="bg-white/10 border-purple-500/30 text-white">
                  <Filter className="w-4 h-4 mr-2" />
                  {t("video_vendors.videovendorspage.auto_ext_4")}
                                                  </Button>
              </div>
            </CardContent>
          </Card>
        </m.div>

        {/* Vendors */}
        <m.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2 }}
        >
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {filteredVendors.map((vendor) => (
              <Card
                key={vendor.id}
                className="bg-white/5 backdrop-blur-xl border-purple-500/20 hover:bg-white/10 transition-colors"
              >
                <CardHeader>
                  <div className="flex items-start gap-4">
                    <Avatar className="h-16 w-16">
                      <AvatarFallback className="bg-purple-500/20 text-purple-400 text-xl font-bold">
                        {vendor.name.split(' ').map(n => n[0]).join('')}
                      </AvatarFallback>
                    </Avatar>
                    <div className="flex-1">
                      <CardTitle className="text-white mb-1">{vendor.name}</CardTitle>
                      <Badge className={TIER_COLORS[vendor.tier]}>{vendor.tier}</Badge>
                    </div>
                  </div>
                </CardHeader>
                <CardContent className="space-y-4">
                  <p className="text-gray-400 text-sm">{vendor.description}</p>
                  
                  <div className="flex items-center gap-2 text-sm text-gray-400">
                    <MapPin className="w-4 h-4" />
                    <span>{vendor.location}</span>
                  </div>

                  <div className="flex items-center gap-4 text-sm">
                    <div className="flex items-center gap-1">
                      <Star className="w-4 h-4 text-yellow-400 fill-yellow-400" />
                      <span className="text-white">{vendor.rating}</span>
                      <span className="text-gray-400">({vendor.reviews})</span>
                    </div>
                    <div className="flex items-center gap-1 text-gray-400">
                      <Video className="w-4 h-4" />
                      <span>{vendor.completedProjects}</span>
                    </div>
                  </div>

                  <div className="flex flex-wrap gap-2">
                    {vendor.specialties.slice(0, 3).map((specialty) => (
                      <Badge key={specialty} variant="outline" className="border-purple-500/30 text-purple-300 text-xs">
                        {specialty}
                      </Badge>
                    ))}
                  </div>

                  <div className="flex items-center gap-2 text-sm text-gray-400">
                    <Clock className="w-4 h-4" />
                    <span>{t("video_vendors.videovendorspage.auto_ext_5")} {vendor.responseTime}</span>
                  </div>

                  <div className="flex gap-2 pt-4 border-t border-purple-500/20">
                    <Button variant="outline" className="flex-1 bg-white/10 border-purple-500/30 text-white">
                      <Mail className="w-4 h-4 mr-2" />
                      {t("video_vendors.videovendorspage.auto_ext_6")}
                                                    </Button>
                    <Button className="flex-1 bg-purple-600 hover:bg-purple-700">
                      <ArrowUpRight className="w-4 h-4 mr-2" />
                      {t("video_vendors.videovendorspage.auto_ext_7")}
                                                    </Button>
                  </div>
                </CardContent>
              </Card>
            ))}
          </div>
        </m.div>
      </div>
    </div>
  );
}
