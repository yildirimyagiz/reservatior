"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect, useCallback } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { Progress } from "@/components/ui/progress";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Video, Upload, Wand2, Sparkles, Play, Pause, SkipForward, Download, Trash2, Eye, Film, Layers, Palette, Music, Type, Scissors, RotateCcw, Maximize, SlidersHorizontal, Zap, Clock, FileVideo, ImagePlus, Camera, Globe, TrendingUp, ChevronRight, Plus, Search, Filter, MonitorPlay, Cpu, CloudLightning, Box, Clapperboard, Volume2, Subtitles, Move3D, Sun, Contrast, Droplets } from "lucide-react";
import { m, AnimatePresence } from "framer-motion";
import { cn } from "@/lib/utils";
import { apiClient } from "@/lib/api/client";
import { videoApi } from "@/lib/api/video";
import { Share2 } from "lucide-react";
import { toast } from "sonner";

// ── Types ──────────────────────────────────────────────────────────────────
interface VideoProject {
  id: string;
  title: string;
  propertyId?: string;
  propertyName?: string;
  status: "draft" | "processing" | "rendering" | "completed" | "failed";
  pipeline: string;
  loraStyle: string;
  platform: string;
  duration?: number;
  thumbnailUrl?: string;
  url?: string;
  progress?: number;
  createdAt: string;
  aiEngine?: string;
}
interface AITool {
  id: string;
  name: string;
  description: string;
  icon: React.ReactNode;
  category: "motion" | "enhance" | "audio" | "text" | "effects" | "3d";
  isPremium?: boolean;
}

// ── AI Tool Config ─────────────────────────────────────────────────────────
const AI_TOOLS: AITool[] = [{
  id: "ken-burns",
  name: "Ken Burns",
  description: t("client.src.cinematic_pan_zoom_motion"),
  icon: <Move3D className="w-4 h-4" />,
  category: "motion"
}, {
  id: "parallax",
  name: "2.5D Parallax",
  description: t("client.src.depthbased_3d_motion_effect"),
  icon: <Layers className="w-4 h-4" />,
  category: "motion"
}, {
  id: "stabilize",
  name: "AI Stabilize",
  description: t("client.src.remove_shake_smooth_motion"),
  icon: <SlidersHorizontal className="w-4 h-4" />,
  category: "motion"
}, {
  id: "upscale",
  name: "AI Upscale 4K",
  description: t("client.src.neural_upscaling_to_4k"),
  icon: <Maximize className="w-4 h-4" />,
  category: "enhance"
}, {
  id: "color-grade",
  name: "Color Grade",
  description: t("client.src.cinematic_lut_color_correction"),
  icon: <Palette className="w-4 h-4" />,
  category: "enhance"
}, {
  id: "lighting",
  name: "AI Lighting",
  description: t("client.src.intelligent_lighting_correction"),
  icon: <Sun className="w-4 h-4" />,
  category: "enhance"
}, {
  id: "denoiser",
  name: "AI Denoiser",
  description: t("client.src.remove_noise_grain"),
  icon: <Droplets className="w-4 h-4" />,
  category: "enhance"
}, {
  id: "contrast",
  name: "HDR Enhance",
  description: t("client.src.dynamic_range_enhancement"),
  icon: <Contrast className="w-4 h-4" />,
  category: "enhance"
}, {
  id: "voiceover",
  name: "AI Voiceover",
  description: t("client.src.neural_texttospeech_narration"),
  icon: <Volume2 className="w-4 h-4" />,
  category: "audio"
}, {
  id: "music",
  name: "AI Music",
  description: t("client.src.generate_background_score"),
  icon: <Music className="w-4 h-4" />,
  category: "audio"
}, {
  id: "subtitles",
  name: "AI Subtitles",
  description: t("client.src.multilingual_subtitle_overlay"),
  icon: <Subtitles className="w-4 h-4" />,
  category: "text"
}, {
  id: "titles",
  name: "Title Cards",
  description: t("client.src.animated_property_info_cards"),
  icon: <Type className="w-4 h-4" />,
  category: "text"
}, {
  id: "transitions",
  name: "AI Transitions",
  description: t("client.src.cinematic_scene_transitions"),
  icon: <Scissors className="w-4 h-4" />,
  category: "effects"
}, {
  id: "vfx",
  name: "VFX Particles",
  description: t("client.src.ambient_lighting_particles"),
  icon: <Sparkles className="w-4 h-4" />,
  category: "effects"
}, {
  id: "gaussian",
  name: "3D Gaussian",
  description: t("client.src.gaussian_splatting_walkthrough"),
  icon: <Box className="w-4 h-4" />,
  category: "3d",
  isPremium: true
}, {
  id: "nerf",
  name: "NeRF Tour",
  description: t("client.src.neural_radiance_field_tour"),
  icon: <Globe className="w-4 h-4" />,
  category: "3d",
  isPremium: true
}, {
  id: "b2b-auto-reel",
  name: "B2B Auto-Reel",
  description: "Generate viral Reels from B2B hotel static photos via Luma/Runway Gen-3",
  icon: <Video className="w-4 h-4" />,
  category: "motion",
  isPremium: true
}];
const PIPELINES = [{
  id: "KREA_REALTIME",
  name: "Krea Realtime",
  desc: "Fast preview generation",
  icon: <Zap className="w-4 h-4" />
}, {
  id: "COMFYUI",
  name: "ComfyUI",
  desc: "Full pipeline with LoRA",
  icon: <Cpu className="w-4 h-4" />
}, {
  id: "RUNPOD",
  name: "RunPod Cloud",
  desc: "Cloud GPU rendering",
  icon: <CloudLightning className="w-4 h-4" />
}, {
  id: "A1111",
  name: "Automatic1111",
  desc: "Stable Diffusion WebUI",
  icon: <MonitorPlay className="w-4 h-4" />
}];
const LORA_STYLES = [{
  id: "CINEMATIC",
  name: "Cinematic",
  color: "from-amber-500 to-orange-600"
}, {
  id: "LUXURY",
  name: "Luxury",
  color: "from-violet-500 to-brand"
}, {
  id: "MODERN",
  name: "Modern",
  color: "from-blue-500 to-brand"
}, {
  id: "WARM",
  name: "Warm & Cozy",
  color: "from-rose-500 to-pink-600"
}, {
  id: "AERIAL",
  name: "Aerial",
  color: "from-brand to-blue-600"
}, {
  id: "TWILIGHT",
  name: "Twilight",
  color: "from-brand to-brand"
}];
const PLATFORMS = [{
  id: "YOUTUBE",
  name: "YouTube (16:9)"
}, {
  id: "INSTAGRAM_REEL",
  name: "Instagram Reel (9:16)"
}, {
  id: "TIKTOK",
  name: "TikTok (9:16)"
}, {
  id: "WEBSITE",
  name: "Website Hero (21:9)"
}, {
  id: "SQUARE",
  name: "Square (1:1)"
}];

// ── Main Component ─────────────────────────────────────────────────────────
export default function VideoContentManagement() {
  const {
    t
  } = useTranslation();
  const [activeTab, setActiveTab] = useState("projects");
  const [projects, setProjects] = useState<VideoProject[]>([]);
  const [showCreateDialog, setShowCreateDialog] = useState(false);
  const [showEditorPanel, setShowEditorPanel] = useState(false);
  const [selectedProject, setSelectedProject] = useState<VideoProject | null>(null);
  const [activeToolCategory, setActiveToolCategory] = useState("motion");
  const [searchTerm, setSearchTerm] = useState("");
  const [filterStatus, setFilterStatus] = useState("all");

  // Share state
  const [showShareDialog, setShowShareDialog] = useState(false);
  const [sharingProject, setSharingProject] = useState<VideoProject | null>(null);
  const [generatedHashtags, setGeneratedHashtags] = useState<string[]>([]);
  const [trendingHashtags, setTrendingHashtags] = useState<string[]>([]);
  const [selectedHashtags, setSelectedHashtags] = useState<string[]>([]);
  const [customMention, setCustomMention] = useState("");
  const [isSharing, setIsSharing] = useState(false);

  const fetchTrendingHashtags = async () => {
    try {
      const response = await apiClient.get("/hashtags/trending") as any;
      if (response && Array.isArray(response.data)) {
        setTrendingHashtags(response.data.map((h: any) => h.name));
      } else {
        setTrendingHashtags(["realestate", "icny27", "luxury", "nycRentals", "aiStaging"]);
      }
    } catch {
      setTrendingHashtags(["realestate", "icny27", "luxury", "nycRentals", "aiStaging"]);
    }
  };

  const handleOpenShareDialog = (project: VideoProject) => {
    setSharingProject(project);
    // Simulate AI hashtag generation from title
    const tags = ["rent", "listing", "aiStudio"];
    if (project.loraStyle) tags.push(project.loraStyle.toLowerCase());
    if (project.propertyName) tags.push(project.propertyName.replace(/\s+/g, "").toLowerCase());
    setGeneratedHashtags(tags);
    setSelectedHashtags(tags);
    setCustomMention("@douglaselliman");
    fetchTrendingHashtags();
    setShowShareDialog(true);
  };

  const handleShareSubmit = async () => {
    if (!sharingProject) return;
    setIsSharing(true);
    try {
      // 1. Post to Twitter via hashtag service
      await apiClient.post("/hashtags/post-twitter", {
        title: sharingProject.title,
        location: sharingProject.propertyName || "Manhattan, NY",
        price: 2000,
        currency: "USD",
        url: "https://reservatior.com/listing/" + sharingProject.id
      });

      // 2. Track hashtags used
      for (const tag of selectedHashtags) {
        await apiClient.post("/hashtags/track", { hashtag: tag });
      }

      // 3. Create mention audit trail
      if (customMention) {
        await apiClient.post("/mentions", {
          mentionedById: "current-user", // handled by auth/session
          mentionedToId: "agent-id",
          type: "TWITTER",
          propertyId: sharingProject.propertyId || undefined,
          content: `Posted listing video ${sharingProject.title} mentioning ${customMention}`
        });
      }

      toast.success("Video ve ilan sosyal ağlarda başarıyla paylaşıldı!");
      setShowShareDialog(false);
    } catch (err: any) {
      toast.error("Paylaşım yapılırken bir hata oluşdu: " + (err.message || err));
    } finally {
      setIsSharing(false);
    }
  };

  // New project form state
  const [newProject, setNewProject] = useState({
    title: "",
    propertyId: "",
    pipeline: "COMFYUI",
    loraStyle: "CINEMATIC",
    platform: "YOUTUBE",
    prompt: "",
    duration: 30
  });
  const [isGenerating, setIsGenerating] = useState(false);

  const handleGenerateVideo = async () => {
    if (!newProject.title.trim()) {
      toast.error("Lütfen proje başlığı girin");
      return;
    }
    setIsGenerating(true);
    try {
      const created = await videoApi.generateVideo({
        title: newProject.title,
        platform: newProject.platform,
        pipeline: newProject.pipeline,
        primaryLoraStyle: newProject.loraStyle,
        prompt: newProject.prompt,
        durationSeconds: newProject.duration,
        status: "PROCESSING"
      });
      setProjects(prev => [{
        id: created.id,
        title: created.title || newProject.title,
        propertyName: "",
        status: "processing",
        pipeline: created.pipeline || newProject.pipeline,
        loraStyle: newProject.loraStyle,
        platform: created.platform || newProject.platform,
        progress: 5,
        aiEngine: "ComfyUI + LoRA",
        thumbnailUrl: created.thumbnailUrl || "",
        url: created.url,
        createdAt: created.createdAt || new Date().toISOString()
      }, ...prev]);
      setShowCreateDialog(false);
      setNewProject({
        title: "",
        propertyId: "",
        pipeline: "COMFYUI",
        loraStyle: "CINEMATIC",
        platform: "YOUTUBE",
        prompt: "",
        duration: 30
      });
    } catch (err: any) {
      toast.error("Video oluşturulurken bir hata oluştu: " + (err.message || err));
    } finally {
      setIsGenerating(false);
    }
  };
  useEffect(() => {
    setProjects([{
      id: "v1",
      title: t("client.src.grand_tower_cinematic_showcase"),
      propertyName: "The Grand Tower 5A",
      status: "completed",
      pipeline: "COMFYUI",
      loraStyle: "CINEMATIC",
      platform: "YOUTUBE",
      duration: 45,
      progress: 100,
      aiEngine: "ComfyUI + LoRA",
      thumbnailUrl: "",
      createdAt: new Date(Date.now() - 86400000).toISOString()
    }, {
      id: "v2",
      title: t("client.src.plaza_suites_luxury_night"),
      propertyName: "Plaza Office Hub",
      status: "rendering",
      pipeline: "RUNPOD",
      loraStyle: "TWILIGHT",
      platform: "INSTAGRAM_REEL",
      duration: 30,
      progress: 67,
      aiEngine: "RunPod A1111",
      thumbnailUrl: "",
      createdAt: new Date(Date.now() - 43200000).toISOString()
    }, {
      id: "v3",
      title: t("client.src.riverside_loft_3d_walkthrough"),
      propertyName: "Riverside Loft",
      status: "processing",
      pipeline: "COMFYUI",
      loraStyle: "MODERN",
      platform: "WEBSITE",
      duration: 60,
      progress: 34,
      aiEngine: "Gaussian Splatting",
      thumbnailUrl: "",
      createdAt: new Date().toISOString()
    }, {
      id: "v4",
      title: t("client.src.marina_view_aerial_promo"),
      propertyName: "Marina Bay Suite",
      status: "draft",
      pipeline: "KREA_REALTIME",
      loraStyle: "AERIAL",
      platform: "TIKTOK",
      duration: 15,
      progress: 0,
      aiEngine: "Krea Realtime",
      thumbnailUrl: "",
      createdAt: new Date().toISOString()
    }]);
  }, []);
  const statusConfig: Record<string, {
    label: string;
    color: string;
    dot: string;
  }> = {
    draft: {
      label: t("common.draft"),
      color: "bg-muted text-muted-foreground border-slate-500/20",
      dot: "bg-muted0"
    },
    processing: {
      label: t("client.src.ai_processing"),
      color: "bg-brand/10 text-brand border-blue-500/20",
      dot: "bg-brand/100 animate-pulse"
    },
    rendering: {
      label: t("client.src.rendering"),
      color: "bg-amber-500/10 text-amber-400 border-amber-500/20",
      dot: "bg-amber-500 animate-pulse"
    },
    completed: {
      label: t("common.completed"),
      color: "bg-success/10 text-success border-success/20",
      dot: "bg-success"
    },
    failed: {
      label: t("common.failed"),
      color: "bg-rose-500/10 text-rose-400 border-rose-500/20",
      dot: "bg-rose-500"
    }
  };
  const filteredProjects = projects.filter(p => {
    const matchSearch = p.title.toLowerCase().includes(searchTerm.toLowerCase());
    const matchFilter = filterStatus === "all" || p.status === filterStatus;
    return matchSearch && matchFilter;
  });
  const openEditor = (project: VideoProject) => {
    setSelectedProject(project);
    setShowEditorPanel(true);
  };
  const toolsByCategory = AI_TOOLS.filter(t => t.category === activeToolCategory);
  return <div className="p-8 space-y-8 bg-[#0a0b0d] min-h-full text-foreground selection:bg-brand/30">
      {/* ── Header ─────────────────────────────────────────────────────── */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-6">
        <div className="space-y-1">
          <h1 className="text-4xl font-bold tracking-tight text-white flex items-center gap-3">
            <div className="p-2.5 bg-violet-600/10 rounded-2xl border border-violet-600/20 shadow-lg shadow-violet-600/10">
              <Clapperboard className="w-8 h-8 text-violet-500" />
            </div>{t("client.src.video_content_studio")}</h1>
          <p className="text-muted-foreground font-medium ml-1">{t("client.src.aipowered_cinematic_video_production")}</p>
        </div>

        <div className="flex items-center gap-3">
          <Button onClick={() => setShowCreateDialog(true)} className="bg-violet-600 hover:bg-violet-500 text-white font-bold h-11 px-6 rounded-xl shadow-lg shadow-violet-600/20 active:scale-95 transition-all">
            <Plus className="w-4 h-4 mr-2" />{t("client.src.new_video_project")}</Button>
        </div>
      </div>

      {/* ── Stats Row ──────────────────────────────────────────────────── */}
      <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
        {[{
        label: t("client.src.total_videos"),
        value: projects.length,
        icon: <FileVideo className="w-4 h-4" />,
        accent: "text-violet-400"
      }, {
        label: t("client.src.ai_processing"),
        value: projects.filter(p => p.status === "processing" || p.status === "rendering").length,
        icon: <Cpu className="w-4 h-4" />,
        accent: "text-brand"
      }, {
        label: t("common.completed"),
        value: projects.filter(p => p.status === "completed").length,
        icon: <Play className="w-4 h-4" />,
        accent: "text-success"
      }, {
        label: t("client.src.avg_duration"),
        value: `${Math.round(projects.reduce((a, p) => a + (p.duration || 0), 0) / Math.max(projects.length, 1))}s`,
        icon: <Clock className="w-4 h-4" />,
        accent: "text-amber-400"
      }].map((stat, i) => <Card key={i} className="bg-background/60 border-border backdrop-blur-xl rounded-2xl p-4">
            <div className="flex items-center gap-3">
              <div className={cn("p-2 rounded-xl bg-card/50 border border-white/5", stat.accent)}>{stat.icon}</div>
              <div>
                <div className="text-[10px] font-bold text-muted-foreground tracking-widest">{stat.label}</div>
                <div className={cn("text-xl font-bold text-white")}>{stat.value}</div>
              </div>
            </div>
          </Card>)}
      </div>

      {/* ── Tabs ───────────────────────────────────────────────────────── */}
      <Tabs value={activeTab} onValueChange={setActiveTab} className="space-y-6">
        <div className="flex items-center justify-between">
          <TabsList className="bg-background border border-border rounded-xl p-1">
            <TabsTrigger value="projects" className="rounded-lg data-[state=active]:bg-violet-600 data-[state=active]:text-white text-muted-foreground px-4">
              <Film className="w-4 h-4 mr-2" />{t("client.src.projects")}</TabsTrigger>
            <TabsTrigger value="ai-editor" className="rounded-lg data-[state=active]:bg-violet-600 data-[state=active]:text-white text-muted-foreground px-4">
              <Wand2 className="w-4 h-4 mr-2" />{t("client.src.ai_editor")}</TabsTrigger>
            <TabsTrigger value="pipelines" className="rounded-lg data-[state=active]:bg-violet-600 data-[state=active]:text-white text-muted-foreground px-4">
              <Cpu className="w-4 h-4 mr-2" />{t("client.src.pipelines")}</TabsTrigger>
          </TabsList>

          <div className="flex gap-2">
            <div className="relative">
              <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
              <Input placeholder={t("client.src.search_videos")} value={searchTerm} onChange={e => setSearchTerm(e.target.value)} className="pl-9 bg-background border-border rounded-xl h-10 w-56 text-sm" />
            </div>
            <Select value={filterStatus} onValueChange={setFilterStatus}>
              <SelectTrigger className="bg-background border-border rounded-xl h-10 w-36 text-sm">
                <Filter className="w-3 h-3 mr-2 text-muted-foreground" /><SelectValue />
              </SelectTrigger>
              <SelectContent className="bg-card border-border text-white">
                <SelectItem value="all">{t("common.all_status")}</SelectItem>
                <SelectItem value="draft">{t("common.draft")}</SelectItem>
                <SelectItem value="processing">{t("common.processing")}</SelectItem>
                <SelectItem value="rendering">{t("client.src.rendering")}</SelectItem>
                <SelectItem value="completed">{t("common.completed")}</SelectItem>
              </SelectContent>
            </Select>
          </div>
        </div>

        {/* ── Projects Tab ─────────────────────────────────────────── */}
        <TabsContent value="projects" className="space-y-4">
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
            {filteredProjects.map((project, idx) => {
            const st = statusConfig[project.status];
            return <m.div key={project.id} initial={{
              opacity: 0,
              y: 20
            }} animate={{
              opacity: 1,
              y: 0
            }} transition={{
              delay: idx * 0.08
            }}>
                  <Card className="bg-background/60 border-border rounded-3xl overflow-hidden hover:border-violet-600/30 transition-all group cursor-pointer" onClick={() => openEditor(project)}>
                    {/* Thumbnail Area */}
                    <div className="h-44 bg-gradient-to-br from-slate-900 to-slate-950 relative overflow-hidden">
                      <div className="absolute inset-0 bg-gradient-to-t from-[#14151a] to-transparent z-10" />
                      <div className="absolute inset-0 flex items-center justify-center z-20">
                        <div className="w-14 h-14 rounded-full bg-white/10 backdrop-blur-xl border border-white/20 flex items-center justify-center group-hover:scale-110 transition-transform shadow-2xl">
                          <Play className="w-6 h-6 text-white ml-0.5" />
                        </div>
                      </div>
                      <div className="absolute top-3 right-3 z-20">
                        <Badge className={cn("text-[9px] font-black  border", st.color)}>
                          <div className={cn("w-1.5 h-1.5 rounded-full mr-1.5", st.dot)} />
                          {st.label}
                        </Badge>
                      </div>
                      <div className="absolute bottom-3 left-4 z-20 flex gap-2">
                        <Badge className="bg-black/50 backdrop-blur text-white/80 border-0 text-[9px] font-bold">
                          <Clock className="w-3 h-3 mr-1" />{project.duration}s
                        </Badge>
                        <Badge className="bg-black/50 backdrop-blur text-white/80 border-0 text-[9px] font-bold">
                          {project.platform.replace(/_/g, " ")}
                        </Badge>
                      </div>
                      {/* LoRA gradient band */}
                      {LORA_STYLES.find(l => l.id === project.loraStyle) && <div className={cn("absolute bottom-0 left-0 right-0 h-0.5 bg-gradient-to-r", LORA_STYLES.find(l => l.id === project.loraStyle)?.color)} />}
                    </div>

                    <CardContent className="p-5 space-y-3">
                      <div>
                        <h3 className="text-sm font-bold text-white group-hover:text-violet-300 transition-colors truncate">{project.title}</h3>
                        <p className="text-[10px] text-muted-foreground mt-0.5">{project.propertyName} · {project.aiEngine}</p>
                      </div>

                      {(project.status === "processing" || project.status === "rendering") && <div className="space-y-1.5">
                          <div className="flex justify-between text-[10px]">
                            <span className="text-muted-foreground font-bold tracking-widest">
                              {project.status === "processing" ? "AI Processing" : "GPU Rendering"}
                            </span>
                            <span className="text-violet-400 font-bold">{project.progress}%</span>
                          </div>
                          <Progress value={project.progress} className="h-1.5 bg-muted" />
                        </div>}

                      <div className="flex items-center justify-between pt-1">
                        <div className="flex gap-1.5">
                          <Badge variant="outline" className="text-[8px] font-bold border-border text-muted-foreground">
                            {project.loraStyle}
                          </Badge>
                          <Badge variant="outline" className="text-[8px] font-bold border-border text-muted-foreground">
                            {project.pipeline}
                          </Badge>
                        </div>
                        <div className="flex gap-1">
                          {project.status === "completed" && (
                            <Button 
                              variant="ghost" 
                              size="sm" 
                              className="h-7 px-2.5 text-[10px] text-success hover:text-white hover:bg-blue-600/10 rounded-lg flex items-center"
                              onClick={(e) => {
                                e.stopPropagation();
                                handleOpenShareDialog(project);
                              }}
                            >
                              <Share2 className="w-3 h-3 mr-1" />
                              Paylaş
                            </Button>
                          )}
                          <Button variant="ghost" size="sm" className="h-7 px-3 text-[10px] text-violet-400 hover:text-white hover:bg-violet-600/10 rounded-lg">
                            <Wand2 className="w-3 h-3 mr-1" />{t("common.edit")}</Button>
                        </div>
                      </div>
                    </CardContent>
                  </Card>
                </m.div>;
          })}
          </div>
        </TabsContent>

        {/* ── AI Editor Tab ────────────────────────────────────────── */}
        <TabsContent value="ai-editor" className="space-y-6">
          <div className="grid grid-cols-1 lg:grid-cols-12 gap-8">
            {/* Preview Surface */}
            <div className="lg:col-span-8">
              <Card className="bg-background/60 border-border rounded-4xl overflow-hidden">
                <div className="aspect-video bg-gradient-to-br from-slate-900 via-slate-950 to-black relative flex items-center justify-center">
                  {selectedProject ? <>
                      <div className="absolute inset-0 bg-[url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI0MCIgaGVpZ2h0PSI0MCI+PGRlZnM+PHBhdHRlcm4gaWQ9ImdyaWQiIHdpZHRoPSI0MCIgaGVpZ2h0PSI0MCIgcGF0dGVyblVuaXRzPSJ1c2VyU3BhY2VPblVzZSI+PHBhdGggZD0iTSAwIDQwIEwgNDAgNDAgNDAgMCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSJyZ2JhKDI1NSwyNTUsMjU1LDAuMDMpIiBzdHJva2Utd2lkdGg9IjEiLz48L3BhdHRlcm4+PC9kZWZzPjxyZWN0IHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiIGZpbGw9InVybCgjZ3JpZCkiLz48L3N2Zz4=')] opacity-50" />
                      <div className="text-center z-10 space-y-3">
                        <div className="w-20 h-20 rounded-full bg-violet-600/10 border border-violet-600/20 flex items-center justify-center mx-auto">
                          <Play className="w-8 h-8 text-violet-400 ml-1" />
                        </div>
                        <h3 className="text-lg font-bold text-white">{selectedProject.title}</h3>
                        <p className="text-xs text-muted-foreground">{selectedProject.aiEngine} · {selectedProject.duration}{t("client.src.s")}{selectedProject.platform}</p>
                      </div>
                    </> : <div className="text-center space-y-3 z-10">
                      <div className="w-16 h-16 rounded-2xl bg-muted/50 flex items-center justify-center mx-auto border border-white/5">
                        <Video className="w-7 h-7 text-muted-foreground" />
                      </div>
                      <p className="text-sm text-muted-foreground">{t("client.src.select_a_project_or")}</p>
                    </div>}
                </div>

                {/* Timeline */}
                <div className="p-4 border-t border-white/5 bg-muted/50">
                  <div className="flex items-center gap-3 mb-3">
                    <Button variant="ghost" size="icon" aria-label={t("common.skip")} className="h-8 w-8 text-muted-foreground hover:text-white rounded-lg"><SkipForward className="w-4 h-4 rotate-180" /></Button>
                    <Button size="icon" aria-label={t("common.play")} className="h-9 w-9 bg-violet-600 hover:bg-violet-500 text-white rounded-full shadow-lg"><Play className="w-4 h-4 ml-0.5" /></Button>
                    <Button variant="ghost" size="icon" aria-label={t("common.skip")} className="h-8 w-8 text-muted-foreground hover:text-white rounded-lg"><SkipForward className="w-4 h-4" /></Button>
                    <div className="flex-1 h-8 bg-card rounded-lg border border-white/5 relative overflow-hidden">
                      <div className="absolute inset-y-0 left-0 w-1/3 bg-violet-600/20 border-r border-violet-500/50" />
                      <div className="absolute inset-y-0 left-[33%] w-1/4 bg-blue-600/20 border-r border-blue-500/50" />
                      <div className="absolute inset-y-0 left-[58%] w-1/4 bg-blue-600/20 border-r border-blue-500/50" />
                    </div>
                    <span className="text-[10px] text-muted-foreground font-mono whitespace-nowrap">00:00 / {selectedProject?.duration || "00"}s</span>
                  </div>
                </div>
              </Card>
            </div>

            {/* AI Tools Panel */}
            <div className="lg:col-span-4 space-y-4">
              <Card className="bg-background/60 border-border rounded-4xl overflow-hidden">
                <CardHeader className="pb-3 border-b border-white/5">
                  <CardTitle className="text-sm font-bold text-white flex items-center gap-2">
                    <Wand2 className="w-4 h-4 text-violet-500" />{t("client.src.ai_video_tools")}</CardTitle>
                </CardHeader>
                <CardContent className="p-3 space-y-3">
                  {/* Category Selector */}
                  <div className="flex flex-wrap gap-1.5">
                    {[{
                    id: "motion",
                    label: t("client.src.motion"),
                    icon: <Move3D className="w-3 h-3" />
                  }, {
                    id: "enhance",
                    label: t("client.src.enhance"),
                    icon: <Sparkles className="w-3 h-3" />
                  }, {
                    id: "audio",
                    label: t("client.src.audio"),
                    icon: <Volume2 className="w-3 h-3" />
                  }, {
                    id: "text",
                    label: t("client.src.text"),
                    icon: <Type className="w-3 h-3" />
                  }, {
                    id: "effects",
                    label: t("client.src.effects"),
                    icon: <Layers className="w-3 h-3" />
                  }, {
                    id: "3d",
                    label: "3D",
                    icon: <Box className="w-3 h-3" />
                  }].map(cat => <Button key={cat.id} variant="ghost" size="sm" className={cn("h-7 px-2.5 text-[10px] font-bold rounded-lg transition-all", activeToolCategory === cat.id ? "bg-violet-600 text-white shadow-lg" : "text-muted-foreground hover:text-white hover:bg-muted")} onClick={() => setActiveToolCategory(cat.id)}>
                        {cat.icon}<span className="ml-1">{cat.label}</span>
                      </Button>)}
                  </div>

                  {/* Tools Grid */}
                  <div className="space-y-2">
                    <AnimatePresence mode="wait">
                      {toolsByCategory.map((tool, idx) => <m.div key={tool.id} initial={{
                      opacity: 0,
                      x: 10
                    }} animate={{
                      opacity: 1,
                      x: 0
                    }} exit={{
                      opacity: 0,
                      x: -10
                    }} transition={{
                      delay: idx * 0.05
                    }}>
                          <div className={cn("flex items-center gap-3 p-3 rounded-xl border cursor-pointer transition-all group", "bg-card/40 border-white/5 hover:border-violet-600/30 hover:bg-violet-600/5")}>
                            <div className="w-9 h-9 rounded-lg bg-violet-600/10 border border-violet-600/20 flex items-center justify-center text-violet-400 group-hover:scale-110 transition-transform">
                              {tool.icon}
                            </div>
                            <div className="flex-1 min-w-0">
                              <div className="flex items-center gap-1.5">
                                <span className="text-xs font-bold text-white">{tool.name}</span>
                                {tool.isPremium && <Badge className="bg-amber-500/10 text-amber-400 border-amber-500/20 text-[7px] font-black h-3.5 px-1">{t("client.src.pro")}</Badge>}
                              </div>
                              <p className="text-[10px] text-muted-foreground truncate">{tool.description}</p>
                            </div>
                            <ChevronRight className="w-3.5 h-3.5 text-muted-foreground group-hover:text-violet-400 transition-colors" />
                          </div>
                        </m.div>)}
                    </AnimatePresence>
                  </div>
                </CardContent>
              </Card>

              {/* Engine Status */}
              <Card className="bg-gradient-to-br from-violet-600/10 to-info/5 border-border rounded-4xl p-5">
                <h4 className="text-xs font-bold text-white mb-3 flex items-center gap-2">
                  <Cpu className="w-3.5 h-3.5 text-violet-400" />{t("client.src.engine_status")}</h4>
                <div className="space-y-2">
                  {[{
                  name: "ComfyUI (VPS)",
                  status: "online",
                  latency: "120ms"
                }, {
                  name: "RunPod GPU",
                  status: "standby",
                  latency: "—"
                }, {
                  name: "A1111 Local",
                  status: "offline",
                  latency: "—"
                }, {
                  name: "Krea Realtime",
                  status: "online",
                  latency: "45ms"
                }].map(engine => <div key={engine.name} className="flex items-center justify-between py-1.5">
                      <div className="flex items-center gap-2">
                        <div className={cn("w-1.5 h-1.5 rounded-full", engine.status === "online" ? "bg-success shadow-[0_0_6px_rgba(16,185,129,0.6)]" : engine.status === "standby" ? "bg-amber-500" : "bg-muted")} />
                        <span className="text-[10px] text-muted-foreground font-medium">{engine.name}</span>
                      </div>
                      <span className="text-[9px] text-muted-foreground font-mono">{engine.latency}</span>
                    </div>)}
                </div>
              </Card>
            </div>
          </div>
        </TabsContent>

        {/* ── Pipelines Tab ────────────────────────────────────────── */}
        <TabsContent value="pipelines" className="space-y-6">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            {PIPELINES.map((pipe, idx) => <m.div key={pipe.id} initial={{
            opacity: 0,
            y: 20
          }} animate={{
            opacity: 1,
            y: 0
          }} transition={{
            delay: idx * 0.1
          }}>
                <Card className="bg-background/60 border-border rounded-4xl p-6 hover:border-violet-600/30 transition-all group cursor-pointer">
                  <div className="flex items-start gap-4">
                    <div className="w-12 h-12 rounded-xl bg-violet-600/10 border border-violet-600/20 flex items-center justify-center text-violet-400 group-hover:scale-110 transition-transform">
                      {pipe.icon}
                    </div>
                    <div className="flex-1">
                      <h3 className="text-sm font-bold text-white mb-1">{pipe.name}</h3>
                      <p className="text-[10px] text-muted-foreground mb-4">{pipe.desc}</p>
                      <div className="grid grid-cols-3 gap-3">
                        <div className="bg-card/50 rounded-xl p-2.5 border border-white/5">
                          <div className="text-[8px] text-muted-foreground tracking-widest">{t("client.src.speed")}</div>
                          <div className="text-xs font-bold text-white mt-0.5">
                            {pipe.id === "KREA_REALTIME" ? "⚡ Fast" : pipe.id === "RUNPOD" ? "🔥 Medium" : "⏱️ Standard"}
                          </div>
                        </div>
                        <div className="bg-card/50 rounded-xl p-2.5 border border-white/5">
                          <div className="text-[8px] text-muted-foreground tracking-widest">{t("client.src.quality")}</div>
                          <div className="text-xs font-bold text-white mt-0.5">
                            {pipe.id === "COMFYUI" ? "Ultra" : pipe.id === "RUNPOD" ? "High" : pipe.id === "A1111" ? "High" : "Preview"}
                          </div>
                        </div>
                        <div className="bg-card/50 rounded-xl p-2.5 border border-white/5">
                          <div className="text-[8px] text-muted-foreground tracking-widest">{t("client.src.cost")}</div>
                          <div className="text-xs font-bold text-white mt-0.5">
                            {pipe.id === "KREA_REALTIME" ? "Free" : pipe.id === "A1111" ? "Free" : pipe.id === "COMFYUI" ? "$0.05" : "$0.25"}
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </Card>
              </m.div>)}
          </div>

          {/* LoRA Styles Showcase */}
          <Card className="bg-background/60 border-border rounded-4xl p-6">
            <h3 className="text-sm font-bold text-white mb-4 flex items-center gap-2">
              <Palette className="w-4 h-4 text-violet-400" />{t("client.src.lora_style_library")}</h3>
            <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-3">
              {LORA_STYLES.map(style => <div key={style.id} className="group cursor-pointer">
                  <div className={cn("h-20 rounded-xl bg-gradient-to-br mb-2 border border-white/10 group-hover:scale-105 transition-transform shadow-lg", style.color)} />
                  <p className="text-[10px] font-bold text-muted-foreground text-center">{style.name}</p>
                </div>)}
            </div>
          </Card>
        </TabsContent>
      </Tabs>

      {/* ── Create New Video Dialog ────────────────────────────────────── */}
      <Dialog open={showCreateDialog} onOpenChange={setShowCreateDialog}>
        <DialogContent className="bg-background border-border text-white rounded-4xl max-w-2xl p-0 shadow-[0_0_60px_rgba(0,0,0,0.5)]">
          <div className="p-8 space-y-6">
            <DialogHeader>
              <DialogTitle className="text-2xl font-bold flex items-center gap-2">
                <Sparkles className="w-6 h-6 text-violet-500" />{t("client.src.new_ai_video_project")}</DialogTitle>
              <DialogDescription className="text-muted-foreground">{t("client.src.configure_your_aipowered_cinematic")}</DialogDescription>
            </DialogHeader>

            <div className="grid gap-5">
              <div className="grid grid-cols-2 gap-5">
                <div className="space-y-2">
                  <label className="text-[10px] font-bold text-muted-foreground tracking-widest ml-1">{t("client.src.project_title")}</label>
                  <Input placeholder={t("client.src.eg_luxury_penthouse_tour")} value={newProject.title} onChange={e => setNewProject({
                  ...newProject,
                  title: e.target.value
                })} className="bg-muted border-border rounded-xl h-11" />
                </div>
                <div className="space-y-2">
                  <label className="text-[10px] font-bold text-muted-foreground tracking-widest ml-1">{t("client.src.target_platform")}</label>
                  <Select value={newProject.platform} onValueChange={v => setNewProject({
                  ...newProject,
                  platform: v
                })}>
                    <SelectTrigger className="bg-muted border-border rounded-xl h-11"><SelectValue /></SelectTrigger>
                    <SelectContent className="bg-card border-border text-white">
                      {PLATFORMS.map(p => <SelectItem key={p.id} value={p.id}>{p.name}</SelectItem>)}
                    </SelectContent>
                  </Select>
                </div>
              </div>

              <div className="grid grid-cols-2 gap-5">
                <div className="space-y-2">
                  <label className="text-[10px] font-bold text-muted-foreground tracking-widest ml-1">{t("client.src.ai_pipeline")}</label>
                  <Select value={newProject.pipeline} onValueChange={v => setNewProject({
                  ...newProject,
                  pipeline: v
                })}>
                    <SelectTrigger className="bg-muted border-border rounded-xl h-11"><SelectValue /></SelectTrigger>
                    <SelectContent className="bg-card border-border text-white">
                      {PIPELINES.map(p => <SelectItem key={p.id} value={p.id}>{p.name} — {p.desc}</SelectItem>)}
                    </SelectContent>
                  </Select>
                </div>
                <div className="space-y-2">
                  <label className="text-[10px] font-bold text-muted-foreground tracking-widest ml-1">{t("client.src.lora_style")}</label>
                  <Select value={newProject.loraStyle} onValueChange={v => setNewProject({
                  ...newProject,
                  loraStyle: v
                })}>
                    <SelectTrigger className="bg-muted border-border rounded-xl h-11"><SelectValue /></SelectTrigger>
                    <SelectContent className="bg-card border-border text-white">
                      {LORA_STYLES.map(s => <SelectItem key={s.id} value={s.id}>{s.name}</SelectItem>)}
                    </SelectContent>
                  </Select>
                </div>
              </div>

              <div className="space-y-2">
                <label className="text-[10px] font-bold text-muted-foreground tracking-widest ml-1">{t("client.src.ai_prompt_direction")}</label>
                <Textarea placeholder={t("client.src.describe_the_cinematic_style")} value={newProject.prompt} onChange={e => setNewProject({
                ...newProject,
                prompt: e.target.value
              })} className="bg-muted border-border rounded-xl min-h-[80px] text-sm" />
              </div>

              {/* Photo Upload Zone */}
              <div className="border-2 border-dashed border-border rounded-2xl p-8 text-center hover:border-violet-600/50 transition-colors cursor-pointer">
                <div className="w-12 h-12 rounded-xl bg-violet-600/10 border border-violet-600/20 flex items-center justify-center mx-auto mb-3">
                  <ImagePlus className="w-5 h-5 text-violet-400" />
                </div>
                <p className="text-xs font-bold text-muted-foreground">{t("client.src.drop_property_photos_here")}</p>
                <p className="text-[10px] text-muted-foreground mt-1">{t("client.src.or_click_to_browse")}</p>
              </div>
            </div>

            <DialogFooter className="pt-4 border-t border-white/5">
              <Button variant="ghost" className="text-muted-foreground" onClick={() => setShowCreateDialog(false)}>{t("common.cancel")}</Button>
              <Button onClick={handleGenerateVideo} disabled={isGenerating} className="bg-violet-600 hover:bg-violet-500 px-8 rounded-xl h-11 font-bold shadow-lg shadow-violet-600/20">
                <Wand2 className="w-4 h-4 mr-2" />{isGenerating ? t("common.processing") : t("client.src.generate_video")}</Button>
            </DialogFooter>
          </div>
        </DialogContent>
      </Dialog>

      {/* ── Share on Social Networks Dialog ──────────────────────────────── */}
      <Dialog open={showShareDialog} onOpenChange={setShowShareDialog}>
        <DialogContent className="bg-background border-border text-white rounded-4xl max-w-xl p-0 shadow-[0_0_60px_rgba(0,0,0,0.5)]">
          <div className="p-8 space-y-6">
            <DialogHeader>
              <DialogTitle className="text-2xl font-bold flex items-center gap-2">
                <Share2 className="w-6 h-6 text-success" />
                Sosyal Ağlarda Paylaş
              </DialogTitle>
              <DialogDescription className="text-muted-foreground">
                AI tarafından oluşturulan video klibi ve ilanı otomatik hashtagler ve mentionlar ile Twitter&apos;da paylaşın.
              </DialogDescription>
            </DialogHeader>

            <div className="space-y-4">
              {/* Project Title */}
              <div>
                <label className="text-[10px] font-bold text-muted-foreground tracking-widest ml-1">Video Başlığı</label>
                <div className="bg-muted p-3 rounded-xl border border-border text-sm text-foreground mt-1">
                  {sharingProject?.title}
                </div>
              </div>

              {/* Mention Input */}
              <div className="space-y-2">
                <label className="text-[10px] font-bold text-muted-foreground tracking-widest ml-1">Acente / Ofis Mention Etiketi</label>
                <Input 
                  value={customMention} 
                  onChange={e => setCustomMention(e.target.value)} 
                  placeholder="@douglaselliman" 
                  className="bg-muted border-border rounded-xl h-11"
                />
              </div>

              {/* AI Generated Hashtags */}
              <div>
                <label className="text-[10px] font-bold text-muted-foreground tracking-widest ml-1">Yapay Zeka Hashtagleri</label>
                <div className="flex flex-wrap gap-1.5 mt-2">
                  {generatedHashtags.map(tag => {
                    const isSelected = selectedHashtags.includes(tag);
                    return (
                      <Badge 
                        key={tag}
                        onClick={() => setSelectedHashtags(prev => isSelected ? prev.filter(t => t !== tag) : [...prev, tag])}
                        className={cn(
                          "cursor-pointer text-[10px] py-1 px-2.5 rounded-lg border transition-all",
                          isSelected 
                            ? "bg-blue-600/20 text-success border-blue-500/30" 
                            : "bg-muted text-muted-foreground border-border hover:border-border"
                        )}
                      >
                        #{tag}
                      </Badge>
                    );
                  })}
                </div>
              </div>

              {/* Trending Hashtags */}
              <div>
                <label className="text-[10px] font-bold text-muted-foreground tracking-widest ml-1">Popüler Hashtag Önerileri</label>
                <div className="flex flex-wrap gap-1.5 mt-2">
                  {trendingHashtags.map(tag => {
                    const isSelected = selectedHashtags.includes(tag);
                    return (
                      <Badge 
                        key={tag}
                        onClick={() => setSelectedHashtags(prev => isSelected ? prev.filter(t => t !== tag) : [...prev, tag])}
                        className={cn(
                          "cursor-pointer text-[10px] py-1 px-2.5 rounded-lg border transition-all",
                          isSelected 
                            ? "bg-blue-600/20 text-brand border-blue-500/30" 
                            : "bg-muted text-muted-foreground border-border hover:border-border"
                        )}
                      >
                        #{tag}
                      </Badge>
                    );
                  })}
                </div>
              </div>

              {/* Preview post content */}
              <div>
                <label className="text-[10px] font-bold text-muted-foreground tracking-widest ml-1">Paylaşım Metni Önizlemesi</label>
                <div className="bg-muted p-4 rounded-xl border border-border text-xs text-muted-foreground font-mono mt-1 leading-relaxed">
                  🏠 {sharingProject?.title} <br />
                  📍 {sharingProject?.propertyName || "Manhattan, NY"} <br />
                  🔑 Kiralık İlan Videosu yayında! {customMention} <br /><br />
                  {selectedHashtags.map(t => `#${t}`).join(" ")}
                </div>
              </div>
            </div>

            <DialogFooter className="pt-4 border-t border-white/5">
              <Button variant="ghost" className="text-muted-foreground" onClick={() => setShowShareDialog(false)}>İptal</Button>
              <Button 
                onClick={handleShareSubmit} 
                disabled={isSharing}
                className="bg-blue-600 hover:bg-success px-8 rounded-xl h-11 font-bold shadow-lg shadow-blue-600/20"
              >
                {isSharing ? "Paylaşılıyor..." : "Twitter'da Paylaş"}
              </Button>
            </DialogFooter>
          </div>
        </DialogContent>
      </Dialog>
    </div>;
}