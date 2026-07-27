"use client";

import { PageShell } from "@/components/PageShell";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Upload, Play, Clock, Eye, Trash2 } from "lucide-react";
import { useTranslation } from "react-i18next";

export default function AdminAgentVideosPage() {
    const { t } = useTranslation();

  // Mock data - replace with actual API calls
  const videos = [
    {
      id: "V-001",
      agentId: "AG-001",
      agentName: "John Smith",
      property: "Luxury Apartment - Istanbul",
      title: "Property Tour - Living Room",
      duration: "3:45",
      views: 1250,
      status: "PUBLISHED",
      uploadedAt: "2026-07-15"
    },
    {
      id: "V-002",
      agentId: "AG-002",
      agentName: "Sarah Johnson",
      property: "Villa - Antalya",
      title: "Property Tour - Exterior",
      duration: "5:20",
      views: 890,
      status: "PROCESSING",
      uploadedAt: "2026-07-20"
    },
    {
      id: "V-003",
      agentId: "AG-001",
      agentName: "John Smith",
      property: "Commercial - Izmir",
      title: "Property Tour - Office Space",
      duration: "4:15",
      views: 2100,
      status: "PUBLISHED",
      uploadedAt: "2026-07-18"
    }
  ];

  const getStatusBadge = (status: string) => {
    const statusConfig = {
      PUBLISHED: { color: "bg-green-500", label: "Published" },
      PROCESSING: { color: "bg-blue-500", label: "Processing" },
      FAILED: { color: "bg-red-500", label: "Failed" },
      DRAFT: { color: "bg-gray-500", label: "Draft" }
    };
    const config = statusConfig[status as keyof typeof statusConfig] || statusConfig.DRAFT;
    
    return (
      <Badge className={`${config.color} text-white`}>
        {config.label}
      </Badge>
    );
  };

  const totalVideos = videos.length;
  const publishedVideos = videos.filter(v => v.status === "PUBLISHED").length;
  const totalViews = videos.reduce((sum, v) => sum + v.views, 0);

  return (
    <PageShell 
      title={t("admin_index_agent_videos", "Agent Videos")} 
      description={t("admin_auto_manage_agent_video_content_and_recording", "Manage agent video content and recordings")}
    >
      <div className="space-y-6">
        {/* Header Actions */}
        <div className="flex items-center justify-between">
          <div className="flex gap-3">
            <Button className="bg-blue-600 hover:bg-blue-700">
              <Upload className="w-4 h-4 mr-2" />
              Upload Video
            </Button>
          </div>
        </div>

        {/* Summary Cards */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          <Card>
            <CardHeader className="pb-3">
              <CardTitle className="text-sm font-medium text-gray-600">Total Videos</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-gray-900">{totalVideos}</div>
              <p className="text-xs text-gray-500 mt-1">All agent videos</p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="pb-3">
              <CardTitle className="text-sm font-medium text-gray-600">Published</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-green-600">{publishedVideos}</div>
              <p className="text-xs text-gray-500 mt-1">Live on platform</p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="pb-3">
              <CardTitle className="text-sm font-medium text-gray-600">Total Views</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-blue-600">{totalViews.toLocaleString()}</div>
              <p className="text-xs text-gray-500 mt-1">All time views</p>
            </CardContent>
          </Card>
        </div>

        {/* Videos Grid */}
        <Card>
          <CardHeader>
            <CardTitle>Agent Videos</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {videos.map((video) => (
                <div key={video.id} className="flex items-center justify-between p-4 border border-gray-200 rounded-lg hover:bg-gray-50 transition-colors">
                  <div className="flex-1">
                    <div className="flex items-center gap-3">
                      <div className="w-16 h-12 bg-gray-200 rounded flex items-center justify-center">
                        <Play className="w-6 h-6 text-gray-500" />
                      </div>
                      <div>
                        <h3 className="font-semibold text-gray-900">{video.title}</h3>
                        <div className="flex items-center gap-2 text-sm text-gray-600">
                          <span>{video.agentName}</span>
                          <span>•</span>
                          <span>{video.property}</span>
                        </div>
                        <div className="flex items-center gap-4 text-xs text-gray-500 mt-1">
                          <div className="flex items-center gap-1">
                            <Clock className="w-3 h-3" />
                            {video.duration}
                          </div>
                          <div className="flex items-center gap-1">
                            <Eye className="w-3 h-3" />
                            {video.views.toLocaleString()} views
                          </div>
                          <div>{video.uploadedAt}</div>
                        </div>
                      </div>
                    </div>
                  </div>

                  <div className="flex items-center gap-4">
                    {getStatusBadge(video.status)}
                    <Button variant="ghost" size="sm">
                      <Trash2 className="w-4 h-4 text-red-500" />
                    </Button>
                  </div>
                </div>
              ))}
            </div>
          </CardContent>
        </Card>
      </div>
    </PageShell>
  );
}
