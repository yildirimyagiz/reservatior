"use client";

import Image from "next/image";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Card, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { 
  Play, 
  Heart, 
  Share2, 
  Sparkles, 
  Eye, 
  MapPin, 
  Clock, 
  Search, 
  Star,
  Brain,
  Video,
  ArrowUpRight
} from "lucide-react";
import { motion } from "framer-motion";
import { useTranslation } from "react-i18next";

interface Video {
  id: string;
  title: string;
  agency: string;
  verified: boolean;
  price: string;
  beds: number;
  baths: number;
  sqft: string;
  category: string;
  location: string;
  views: string;
  time: string;
  duration: string;
  tags: string[];
  image: string;
  aiGenerated: boolean;
  mlScore: number;
}

const mockVideos: Video[] = [
  {
    id: "1",
    title: "The Glass Pavilion — Coastal Malibu Architectural Masterpiece",
    agency: "Aura Luxury Properties",
    verified: true,
    price: "$28,500,000",
    beds: 6,
    baths: 8,
    sqft: "12,400",
    category: "villa",
    location: "MALIBU",
    views: "24K",
    time: "2 DAYS AGO",
    duration: "2:14",
    tags: ["EXCLUSIVE LISTING", "MODERN"],
    image: "https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=1920&q=80",
    aiGenerated: true,
    mlScore: 95
  },
  {
    id: "2",
    title: "Monolithic Concrete Dream — Brutalist Beverly Hills Penthouse",
    agency: "Vance & Partners",
    verified: true,
    price: "$16,200,000",
    beds: 4,
    baths: 6,
    sqft: "8,900",
    category: "penthouse",
    location: "BEVERLY HILLS",
    views: "18K",
    time: "5 DAYS AGO",
    duration: "1:48",
    tags: ["PENTHOUSE", "MODERN"],
    image: "https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=1920&q=80",
    aiGenerated: true,
    mlScore: 88
  },
  {
    id: "3",
    title: "Neo-Tokyo Cyber Loft — High-Tech Shinjuku Smart Penthouse",
    agency: "Ren Tanaka Realty",
    verified: true,
    price: "¥1,850,000,000",
    beds: 3,
    baths: 3,
    sqft: "5,400",
    category: "smart",
    location: "SHIBUYA",
    views: "42K",
    time: "1 WEEK AGO",
    duration: "2:05",
    tags: ["SMART HOME", "TECH ENABLED"],
    image: "https://images.unsplash.com/photo-1600607687931-cebf585140bb?w=1920&q=80",
    aiGenerated: false,
    mlScore: 92
  }
];

const CATEGORIES = [
  { id: "all", label: "All" },
  { id: "villa", label: "Villa" },
  { id: "penthouse", label: "Penthouse" },
  { id: "smart", label: "Smart Home" },
  { id: "mountain", label: "Mountain" },
  { id: "loft", label: "Loft" }
];

export default function VideosPage() {
    const { t } = useTranslation();
  const router = useRouter();
  const [activeCat, setActiveCat] = useState("all");
  const [searchQuery, setSearchQuery] = useState("");
  const [sortBy, setSortBy] = useState("newest");

  const filteredVideos = mockVideos.filter(video => {
    if (activeCat !== "all" && video.category !== activeCat) return false;
    if (searchQuery && !video.title.toLowerCase().includes(searchQuery.toLowerCase())) return false;
    return true;
  });

  const aiGeneratedCount = filteredVideos.filter(v => v.aiGenerated).length;
  const avgMLScore = filteredVideos.reduce((sum, v) => sum + v.mlScore, 0) / filteredVideos.length;

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
              <h1 className="text-3xl font-bold text-white mb-2">{t("videos.videospage.auto_ext_1")}</h1>
              <p className="text-gray-400">{t("videos.videospage.auto_ext_2")}</p>
            </div>
            <Button
              onClick={() => router.push('/dashboard')}
              className="bg-purple-600 hover:bg-purple-700"
            >
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("videos.videospage.auto_ext_3")}
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
                    <div className="text-sm text-gray-400 mb-1">{t("videos.videospage.auto_ext_4")}</div>
                    <div className="text-2xl font-bold text-white">{filteredVideos.length}</div>
                  </div>
                  <div className="p-3 rounded-lg bg-blue-500/10">
                    <Video className="w-6 h-6 text-blue-400" />
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
                    <div className="text-sm text-gray-400 mb-1">{t("videos.videospage.auto_ext_5")}</div>
                    <div className="text-2xl font-bold text-white">{aiGeneratedCount}</div>
                  </div>
                  <div className="p-3 rounded-lg bg-purple-500/10">
                    <Sparkles className="w-6 h-6 text-purple-400" />
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
                    <div className="text-sm text-gray-400 mb-1">{t("videos.videospage.auto_ext_6")}</div>
                    <div className="text-2xl font-bold text-white">{avgMLScore.toFixed(0)}%</div>
                  </div>
                  <div className="p-3 rounded-lg bg-green-500/10">
                    <Brain className="w-6 h-6 text-green-400" />
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
                      placeholder="Search videos..."
                      value={searchQuery}
                      onChange={(e) => setSearchQuery(e.target.value)}
                      className="pl-10 bg-white/10 border-purple-500/30 text-white placeholder:text-gray-400"
                    />
                  </div>
                </div>
                <Select value={activeCat} onValueChange={setActiveCat}>
                  <SelectTrigger className="w-40 bg-white/10 border-purple-500/30 text-white">
                    <SelectValue placeholder="Category" />
                  </SelectTrigger>
                  <SelectContent className="bg-slate-900 border-purple-500/30">
                    {CATEGORIES.map(cat => (
                      <SelectItem key={cat.id} value={cat.id}>{cat.label}</SelectItem>
                    ))}
                  </SelectContent>
                </Select>
                <Select value={sortBy} onValueChange={setSortBy}>
                  <SelectTrigger className="w-40 bg-white/10 border-purple-500/30 text-white">
                    <SelectValue placeholder="Sort By" />
                  </SelectTrigger>
                  <SelectContent className="bg-slate-900 border-purple-500/30">
                    <SelectItem value="newest">{t("videos.videospage.auto_ext_7")}</SelectItem>
                    <SelectItem value="popular">{t("videos.videospage.auto_ext_8")}</SelectItem>
                    <SelectItem value="ml_score">{t("videos.videospage.auto_ext_9")}</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </CardContent>
          </Card>
        </motion.div>

        {/* Videos Grid */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.5 }}
        >
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {filteredVideos.map((video) => (
              <Card
                key={video.id}
                className="bg-white/5 backdrop-blur-xl border-purple-500/20 hover:bg-white/10 transition-colors cursor-pointer group"
              >
                <CardContent className="p-0">
                  {/* Thumbnail */}
                  <div className="relative aspect-video overflow-hidden">
                    <Image src={video.image} alt={video.title} fill sizes="(max-width: 768px) 100vw, 33vw" className="object-cover group-hover:scale-105 transition-transform duration-300" />
                    <div className="absolute inset-0 bg-gradient-to-t from-black/80 via-transparent to-transparent" />
                    
                    {/* Play Button */}
                    <div className="absolute inset-0 flex items-center justify-center">
                      <Button
                        size="icon"
                        className="w-16 h-16 rounded-full bg-white/20 backdrop-blur-sm hover:bg-white/30 border-2 border-white/50"
                      >
                        <Play className="w-6 h-6 fill-white text-white ml-1" />
                      </Button>
                    </div>

                    {/* Duration Badge */}
                    <div className="absolute bottom-3 right-3 bg-black/70 backdrop-blur-sm px-2 py-1 rounded text-white text-xs">
                      {video.duration}
                    </div>

                    {/* AI Badge */}
                    {video.aiGenerated && (
                      <div className="absolute top-3 left-3 bg-purple-600/80 backdrop-blur-sm px-2 py-1 rounded text-white text-xs flex items-center gap-1">
                        <Sparkles className="w-3 h-3" />
                        {t("videos.videospage.auto_ext_10")}
                                                          </div>
                    )}
                  </div>

                  {/* Content */}
                  <div className="p-4">
                    <div className="flex items-start justify-between mb-2">
                      <div className="flex-1">
                        <h3 className="text-white font-medium line-clamp-2 mb-2">{video.title}</h3>
                        <div className="flex items-center gap-2 text-gray-400 text-sm">
                          <MapPin className="w-3 h-3" />
                          <span>{video.location}</span>
                        </div>
                      </div>
                      {video.verified && (
                        <div className="flex-shrink-0">
                          <Star className="w-4 h-4 text-yellow-400 fill-yellow-400" />
                        </div>
                      )}
                    </div>

                    <div className="flex items-center justify-between text-sm text-gray-400 mb-3">
                      <span>{video.agency}</span>
                      <span>{video.price}</span>
                    </div>

                    <div className="flex items-center gap-4 text-sm text-gray-400 mb-3">
                      <div className="flex items-center gap-1">
                        <Eye className="w-4 h-4" />
                        <span>{video.views}</span>
                      </div>
                      <div className="flex items-center gap-1">
                        <Clock className="w-4 h-4" />
                        <span>{video.time}</span>
                      </div>
                      <div className="flex items-center gap-1">
                        <Brain className="w-4 h-4" />
                        <span>{video.mlScore}%</span>
                      </div>
                    </div>

                    <div className="flex flex-wrap gap-2 mb-3">
                      {video.tags.map((tag) => (
                        <Badge key={tag} variant="outline" className="text-xs border-purple-500/30 text-purple-300">
                          {tag}
                        </Badge>
                      ))}
                    </div>

                    <div className="flex items-center justify-between pt-3 border-t border-purple-500/20">
                      <div className="flex items-center gap-2 text-sm text-gray-400">
                        <span>{video.beds} {t("videos.videospage.auto_ext_11")}</span>
                        <span>•</span>
                        <span>{video.baths} {t("videos.videospage.auto_ext_12")}</span>
                        <span>•</span>
                        <span>{video.sqft} {t("videos.videospage.auto_ext_13")}</span>
                      </div>
                      <div className="flex items-center gap-2">
                        <Button variant="ghost" size="icon" className="h-8 w-8">
                          <Heart className="w-4 h-4" />
                        </Button>
                        <Button variant="ghost" size="icon" className="h-8 w-8">
                          <Share2 className="w-4 h-4" />
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
