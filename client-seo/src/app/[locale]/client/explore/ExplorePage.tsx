"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Tabs, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { 
  Video, 
  BarChart3, 
  Shield, 
  Globe2, 
  Zap, 
  Users, 
  Building2, 
  Sparkles, 
  Star,
  Brain,
  Search,
  ArrowUpRight,
  TrendingUp
} from "lucide-react";
import { m } from "framer-motion";
import { useTranslation } from "react-i18next";

const features = [
  {
    id: "ai-valuation",
    title: "AI Property Valuation",
    description: "Get instant property valuations using our advanced AI engine",
    icon: Brain,
    category: "ai",
    popular: true
  },
  {
    id: "smart-search",
    title: "Smart Property Search",
    description: "AI-powered search with natural language processing",
    icon: Search,
    category: "ai",
    popular: true
  },
  {
    id: "virtual-tours",
    title: "Virtual Tours",
    description: "Immersive 3D property tours with video integration",
    icon: Video,
    category: "media",
    popular: false
  },
  {
    id: "analytics",
    title: "Advanced Analytics",
    description: "Comprehensive market insights and performance tracking",
    icon: BarChart3,
    category: "analytics",
    popular: false
  },
  {
    id: "automation",
    title: "Workflow Automation",
    description: "Automate repetitive tasks with intelligent triggers",
    icon: Zap,
    category: "automation",
    popular: true
  },
  {
    id: "security",
    title: "Enterprise Security",
    description: "Bank-grade security with multi-factor authentication",
    icon: Shield,
    category: "security",
    popular: false
  },
  {
    id: "global-reach",
    title: "Global Property Network",
    description: "Access properties from 42+ countries worldwide",
    icon: Globe2,
    category: "network",
    popular: false
  },
  {
    id: "team-collaboration",
    title: "Team Collaboration",
    description: "Work together seamlessly with your team",
    icon: Users,
    category: "collaboration",
    popular: false
  }
];

export default function ExplorePage() {
    const { t } = useTranslation();
  const router = useRouter();
  const [activeTab, setActiveTab] = useState("all");
  const [searchTerm, setSearchTerm] = useState("");

  const filteredFeatures = features.filter(feature => {
    if (activeTab !== "all" && feature.category !== activeTab) return false;
    if (searchTerm && !feature.title.toLowerCase().includes(searchTerm.toLowerCase())) return false;
    return true;
  });

  const categories = [
    { id: "all", label: "All Features" },
    { id: "ai", label: "AI & ML" },
    { id: "media", label: "Media" },
    { id: "analytics", label: "Analytics" },
    { id: "automation", label: "Automation" },
    { id: "security", label: "Security" }
  ];

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
              <h1 className="text-3xl font-bold text-white mb-2">{t("explore.explorepage.auto_ext_1")}</h1>
              <p className="text-gray-400">{t("explore.explorepage.auto_ext_2")}</p>
            </div>
            <Button
              onClick={() => router.push('/dashboard')}
              className="bg-brand hover:bg-brand"
            >
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("explore.explorepage.auto_ext_3")}
                                      </Button>
          </div>
        </m.div>

        {/* Search */}
        <m.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
          className="mb-6"
        >
          <div className="relative">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" />
            <Input
              placeholder="Search features..."
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
              className="pl-10 bg-white/10 border-brand/30 text-white placeholder:text-gray-400"
            />
          </div>
        </m.div>

        {/* Categories */}
        <m.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2 }}
          className="mb-8"
        >
          <Tabs value={activeTab} onValueChange={setActiveTab}>
            <TabsList className="bg-white/5 border-brand/20 w-full justify-start">
              {categories.map(cat => (
                <TabsTrigger key={cat.id} value={cat.id} className="data-[state=active]:bg-brand">
                  {cat.label}
                </TabsTrigger>
              ))}
            </TabsList>
          </Tabs>
        </m.div>

        {/* Features Grid */}
        <m.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.3 }}
        >
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {filteredFeatures.map((feature) => (
              <Card
                key={feature.id}
                className="bg-white/5 backdrop-blur-xl border-brand/20 hover:bg-white/10 transition-all hover:scale-105 cursor-pointer group"
              >
                <CardHeader>
                  <div className="flex items-start justify-between">
                    <div className="p-3 rounded-xl bg-brand/20 group-hover:bg-brand/30 transition-colors">
                      <feature.icon className="w-6 h-6 text-brand" />
                    </div>
                    {feature.popular && (
                      <Badge className="bg-brand/20 text-brand border-blue-500/30">
                        <Sparkles className="w-3 h-3 mr-1" />
                        {t("explore.explorepage.auto_ext_4")}
                                                          </Badge>
                    )}
                  </div>
                  <CardTitle className="text-white mt-4">{feature.title}</CardTitle>
                </CardHeader>
                <CardContent>
                  <p className="text-gray-400 text-sm mb-4">{feature.description}</p>
                  <Button
                    variant="outline"
                    className="w-full bg-white/5 border-brand/30 text-white hover:bg-brand hover:border-purple-600"
                    onClick={() => router.push('/dashboard')}
                  >
                    {t("explore.explorepage.auto_ext_5")}
                                                <ArrowUpRight className="w-4 h-4 ml-2" />
                  </Button>
                </CardContent>
              </Card>
            ))}
          </div>
        </m.div>

        {/* Stats */}
        <m.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.4 }}
          className="mt-12"
        >
          <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
            <Card className="bg-white/5 backdrop-blur-xl border-brand/20">
              <CardContent className="p-6 text-center">
                <Building2 className="w-8 h-8 text-brand mx-auto mb-2" />
                <div className="text-2xl font-bold text-white">{t("explore.explorepage.auto_ext_6")}</div>
                <div className="text-gray-400 text-sm">{t("explore.explorepage.auto_ext_7")}</div>
              </CardContent>
            </Card>
            <Card className="bg-white/5 backdrop-blxl border-brand/20">
              <CardContent className="p-6 text-center">
                <Users className="w-8 h-8 text-brand mx-auto mb-2" />
                <div className="text-2xl font-bold text-white">{t("explore.explorepage.auto_ext_8")}</div>
                <div className="text-gray-400 text-sm">{t("explore.explorepage.auto_ext_9")}</div>
              </CardContent>
            </Card>
            <Card className="bg-white/5 backdrop-blur-xl border-brand/20">
              <CardContent className="p-6 text-center">
                <TrendingUp className="w-8 h-8 text-blue-400 mx-auto mb-2" />
                <div className="text-2xl font-bold text-white">99.9%</div>
                <div className="text-gray-400 text-sm">{t("explore.explorepage.auto_ext_10")}</div>
              </CardContent>
            </Card>
            <Card className="bg-white/5 backdrop-blur-xl border-brand/20">
              <CardContent className="p-6 text-center">
                <Star className="w-8 h-8 text-yellow-400 mx-auto mb-2" />
                <div className="text-2xl font-bold text-white">4.9</div>
                <div className="text-gray-400 text-sm">{t("explore.explorepage.auto_ext_11")}</div>
              </CardContent>
            </Card>
          </div>
        </m.div>
      </div>
    </div>
  );
}
