import { useTranslation } from "react-i18next";
import { motion } from "framer-motion";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import { Progress } from "@/components/ui/progress";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { User, Phone, Mail, MapPin, Globe, TrendingUp, Star, DollarSign, Video, Building, BarChart, Users, Camera, Play, Edit, Eye, Target } from "lucide-react";
import Image from "next/image";

// Using API types

import { useParams } from "react-router-dom";
import { agentsApi, Agent } from "@/lib/api/agents";
import { useQuery } from "@tanstack/react-query";
export default function AgentProfile() {
  const {
    t
  } = useTranslation();
  const {
    id
  } = useParams<{
    id: string;
  }>();
  const agentId = id || "1";
  const {
    data: agent,
    isLoading: isLoadingAgent
  } = useQuery<Agent>({
    queryKey: ["agent", agentId],
    queryFn: () => agentsApi.getById(agentId)
  });
  const {
    data: assignments = [],
    isLoading: isLoadingAssignments
  } = useQuery<any[]>({
    queryKey: ["agent-assignments", agentId],
    queryFn: () => agentsApi.getAssignments(agentId),
    enabled: !!agent
  });
  const listings = assignments.map(a => a.listing);
  const videos: any[] = []; // Videos not yet implemented in API

  const loading = isLoadingAgent || isLoadingAssignments;
  const formatCurrency = (amount: number) => {
    return new Intl.NumberFormat("en-US", {
      style: "currency",
      currency: "USD",
      maximumFractionDigits: 0
    }).format(amount);
  };

  // Use API types

  if (loading) {
    return <div className="flex items-center justify-center min-h-screen">
        <div className="animate-spin rounded-full h-32 w-32 border-b-2 border-primary"></div>
      </div>;
  }
  if (!agent) return null;
  return <div className="min-h-screen bg-background p-6">
      <div className="max-w-7xl mx-auto space-y-6">
        {/* Header */}
        <motion.div initial={{
        opacity: 0,
        y: 20
      }} animate={{
        opacity: 1,
        y: 0
      }} className="flex items-center justify-between">
          <div className="flex items-center gap-4">
            <Avatar className="w-20 h-20">
              <AvatarFallback className="text-2xl">
                {agent.name.split(" ").map(n => n[0]).join("")}
              </AvatarFallback>
            </Avatar>
            <div>
              <h1 className="text-3xl font-bold">{agent.name}</h1>
              <div className="flex items-center gap-2 text-muted-foreground">
                <Mail className="w-4 h-4" />
                <span>{agent.email}</span>
                <Phone className="w-4 h-4 ml-2" />
                <span>{agent.phoneNumber}</span>
              </div>
              <div className="flex items-center gap-2 mt-2">
                <Badge variant="outline">{t("client.src.agent_tier")}</Badge>
                <Badge variant="outline">
                  <Star className="w-3 h-3 mr-1" />
                  5.0★
                </Badge>
              </div>
            </div>
          </div>
          <div className="flex gap-2">
            <Button variant="outline">
              <Edit className="w-4 h-4 mr-2" />{t("client.src.edit_profile")}</Button>
            <Button>
              <Video className="w-4 h-4 mr-2" />{t("client.src.create_video")}</Button>
          </div>
        </motion.div>

        {/* Main Content */}
        <Tabs defaultValue="overview" className="space-y-6">
          <TabsList className="grid w-full grid-cols-5">
            <TabsTrigger value="overview">{t("client.src.overview")}</TabsTrigger>
            <TabsTrigger value="listings">{t("client.src.listings")}</TabsTrigger>
            <TabsTrigger value="videos">{t("client.src.videos")}</TabsTrigger>
            <TabsTrigger value="performance">{t("client.src.performance")}</TabsTrigger>
            <TabsTrigger value="partnerships">{t("client.src.partnerships")}</TabsTrigger>
          </TabsList>

          <TabsContent value="overview" className="space-y-6">
            <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
              {/* About */}
              <Card className="md:col-span-2">
                <CardHeader>
                  <CardTitle className="flex items-center gap-2">
                    <User className="w-5 h-5" />{t("client.src.about")}</CardTitle>
                </CardHeader>
                <CardContent className="space-y-4">
                  <p>{agent.bio || "No bio provided"}</p>
                  
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div>
                      <div className="text-sm font-medium mb-2">{t("client.src.contact_information")}</div>
                      <div className="space-y-2 text-sm">
                        <div className="flex items-center gap-2">
                          <MapPin className="w-4 h-4 text-muted-foreground" />
                          <span>{t("client.src.office_branch")}</span>
                        </div>
                        <div className="flex items-center gap-2">
                          <Globe className="w-4 h-4 text-muted-foreground" />
                          <span>{agent.name.toLowerCase().replace(/\s+/g, '')}{t("client.src.realestatecom")}</span>
                        </div>
                      </div>
                    </div>
                    
                    <div>
                      <div className="text-sm font-medium mb-2">{t("client.src.license_information")}</div>
                      <div className="space-y-2 text-sm">
                        <div><strong>{t("client.src.number")}</strong> {agent.licenseNumber || "N/A"}</div>
                        <div><strong>{t("client.src.status")}</strong> {agent.status || "ACTIVE"}</div>
                      </div>
                    </div>
                  </div>

                  <div>
                    <div className="text-sm font-medium mb-2">{t("client.src.specialties")}</div>
                    <div className="flex flex-wrap gap-1">
                      {agent.specialties?.map((specialty, idx) => <Badge key={idx} variant="outline">
                          {specialty}
                        </Badge>) || <Badge variant="outline">{t("client.src.residential")}</Badge>}
                    </div>
                  </div>

                  <div>
                    <div className="text-sm font-medium mb-2">{t("client.src.service_areas")}</div>
                    <div className="flex flex-wrap gap-1">
                      {agent.serviceAreas?.map((area, idx) => <Badge key={idx} variant="outline">
                          {area}
                        </Badge>) || <Badge variant="outline">{t("client.src.global")}</Badge>}
                    </div>
                  </div>
                </CardContent>
              </Card>

              {/* Quick Stats */}
              <Card>
                <CardHeader>
                  <CardTitle className="flex items-center gap-2">
                    <BarChart className="w-5 h-5" />{t("client.src.quick_stats")}</CardTitle>
                </CardHeader>
                <CardContent className="space-y-4">
                  <div className="text-center">
                    <div className="text-2xl font-bold text-primary">{agent.yearsOfExperience || 0}</div>
                    <div className="text-sm text-muted-foreground">{t("client.src.years_experience")}</div>
                  </div>
                  <div className="text-center">
                    <div className="text-2xl font-bold text-primary">0</div>
                    <div className="text-sm text-muted-foreground">{t("client.src.total_transactions")}</div>
                  </div>
                  <div className="text-center">
                    <div className="text-2xl font-bold text-primary">$0</div>
                    <div className="text-sm text-muted-foreground">{t("client.src.total_volume")}</div>
                  </div>
                  <div className="text-center">
                    <div className="text-2xl font-bold text-primary">{agent.commissionRate || 0}%</div>
                    <div className="text-sm text-muted-foreground">{t("client.src.commission_rate")}</div>
                  </div>
                </CardContent>
              </Card>
            </div>
          </TabsContent>

          <TabsContent value="listings" className="space-y-6">
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center gap-2">
                  <Building className="w-5 h-5" />{t("client.src.property_listings")}</CardTitle>
                <CardDescription>{t("client.src.manage_your_property_listings")}</CardDescription>
              </CardHeader>
              <CardContent>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                  {listings.map((listing, index) => <motion.div key={listing.id} initial={{
                  opacity: 0,
                  y: 20
                }} animate={{
                  opacity: 1,
                  y: 0
                }} transition={{
                  delay: index * 0.1
                }} className="border rounded-lg overflow-hidden">
                      <div className="aspect-[4/3] bg-muted relative">
                        <Image src={listing.images[0]} alt={listing.title} fill className="object-cover" sizes="(max-width: 768px) 100vw, 50vw" />
                        {listing.hasVideo && <div className="absolute inset-0 flex items-center justify-center bg-black/50">
                            <div className="w-16 h-16 rounded-full bg-primary/90 flex items-center justify-center text-white">
                              <Play className="w-8 h-8 fill-current" />
                            </div>
                          </div>}
                        <div className="absolute top-2 right-2">
                          <Badge variant={listing.status === "ACTIVE" ? "default" : "secondary"}>
                            {listing.status}
                          </Badge>
                        </div>
                      </div>
                      <div className="p-4">
                        <h3 className="font-medium mb-2">{listing.name}</h3>
                        <div className="text-sm text-muted-foreground mb-2">{listing.addressLine1}</div>
                        <div className="text-lg font-bold text-primary mb-2">
                          {formatCurrency(listing.listingPrice || 0)}
                        </div>
                        <div className="flex items-center justify-between text-sm text-muted-foreground">
                          <div className="flex items-center gap-1">
                            <Eye className="w-4 h-4" />
                            <span>{listing.views}</span>
                          </div>
                          <div className="flex items-center gap-1">
                            <Users className="w-4 h-4" />
                            <span>{listing.inquiries}</span>
                          </div>
                        </div>
                      </div>
                    </motion.div>)}
                </div>
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="videos" className="space-y-6">
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center gap-2">
                  <Video className="w-5 h-5" />{t("client.src.video_content")}</CardTitle>
                <CardDescription>{t("client.src.track_your_video_performance")}</CardDescription>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  {videos.map((video, index) => <motion.div key={video.id} initial={{
                  opacity: 0,
                  x: -20
                }} animate={{
                  opacity: 1,
                  x: 0
                }} transition={{
                  delay: index * 0.1
                }} className="flex items-center justify-between p-4 border rounded-lg">
                      <div className="flex items-center gap-4">
                        <div className="w-12 h-12 rounded-lg bg-primary/10 flex items-center justify-center">
                          <Camera className="w-6 h-6 text-primary" />
                        </div>
                        <div>
                          <div className="font-medium">{video.title}</div>
                          <div className="text-sm text-muted-foreground">
                            {video.propertyTitle} • {video.vendorName}
                          </div>
                          <div className="text-xs text-muted-foreground">{t("client.src.quality")}{video.quality}
                          </div>
                        </div>
                      </div>
                      <div className="text-right">
                        <div className="font-medium">{formatCurrency(video.commission)}</div>
                        <div className="text-sm text-muted-foreground">
                          {video.views}{t("client.src.views")}{video.engagement}{t("client.src.engagement")}</div>
                      </div>
                    </motion.div>)}
                </div>
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="performance" className="space-y-6">
            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              {/* Performance Metrics */}
              <Card>
                <CardHeader>
                  <CardTitle className="flex items-center gap-2">
                    <TrendingUp className="w-5 h-5" />{t("client.src.performance_metrics")}</CardTitle>
                </CardHeader>
                <CardContent className="space-y-4">
                  <div>
                    <div className="flex justify-between mb-2">
                      <span className="text-sm">{t("client.src.client_satisfaction")}</span>
                      <span className="text-sm font-medium">5.0/5</span>
                    </div>
                    <Progress value={100} />
                  </div>
                  <div>
                    <div className="flex justify-between mb-2">
                      <span className="text-sm">{t("client.src.response_rate")}</span>
                      <span className="text-sm font-medium">100%</span>
                    </div>
                    <Progress value={100} />
                  </div>
                </CardContent>
              </Card>

              {/* Revenue */}
              <Card>
                <CardHeader>
                  <CardTitle className="flex items-center gap-2">
                    <DollarSign className="w-5 h-5" />{t("client.src.revenue_analytics")}</CardTitle>
                </CardHeader>
                <CardContent className="space-y-4">
                  <div className="grid grid-cols-2 gap-4">
                    <div className="text-center">
                      <div className="text-2xl font-bold text-primary">
                        $0
                      </div>
                      <div className="text-sm text-muted-foreground">{t("client.src.monthly")}</div>
                    </div>
                    <div className="text-center">
                      <div className="text-2xl font-bold text-primary">
                        $0
                      </div>
                      <div className="text-sm text-muted-foreground">{t("client.src.quarterly")}</div>
                    </div>
                  </div>
                </CardContent>
              </Card>
            </div>
          </TabsContent>

          <TabsContent value="partnerships" className="space-y-6">
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center gap-2">
                  <Target className="w-5 h-5" />{t("client.src.video_vendor_partnerships")}</CardTitle>
                <CardDescription>{t("client.src.manage_your_video_vendor")}</CardDescription>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  <div className="flex items-center justify-between p-4 border rounded-lg">
                    <div>
                      <div className="font-medium">{t("client.src.video_vendor_status")}</div>
                      <div className="text-sm text-muted-foreground">{t("client.src.disabled")}</div>
                    </div>
                    <Badge variant="outline">{t("client.src.standard")}</Badge>
                  </div>
                  
                  <div className="flex items-center justify-between p-4 border rounded-lg">
                    <div>
                      <div className="font-medium">{t("client.src.video_commission_rate")}</div>
                      <div className="text-sm text-muted-foreground">{t("client.src.earned_from_video_partnerships")}</div>
                    </div>
                    <div className="text-lg font-bold text-primary">
                      0%
                    </div>
                  </div>

                  <div className="text-center">
                    <Button>
                      <Video className="w-4 h-4 mr-2" />{t("client.src.find_video_vendors")}</Button>
                  </div>
                </div>
              </CardContent>
            </Card>
          </TabsContent>
        </Tabs>
      </div>
    </div>;
}