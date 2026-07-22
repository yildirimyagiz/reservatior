import Image from "next/image";
import { useTranslation } from "react-i18next";
import { useState, useRef, useEffect } from "react";
import { m, AnimatePresence } from "framer-motion";
import { Play, X, Volume2, VolumeX, MessageSquare, Languages } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsList, TabsTrigger } from "@/components/ui/tabs";
export interface VideoSegment {
  id: string;
  label: string;
  startTime: number;
}
export interface VideoSubtitle {
  startTime: number;
  endTime: number;
  text: string;
}
export interface VideoItem {
  id: string;
  title: string;
  url: string;
  thumbnail: string;
  duration?: string;
  category?: string;
  segments?: VideoSegment[];
  subtitles?: Record<string, VideoSubtitle[]>;
}
interface VideoGalleryProps {
  videos: VideoItem[];
  title?: string;
}
export function VideoGallery({
  videos,
  title = "Property Video Tours"
}: VideoGalleryProps) {
  const {
    t
  } = useTranslation();
  const [selectedVideo, setSelectedVideo] = useState<VideoItem | null>(null);
  const [isMuted, setIsMuted] = useState(true);
  const [showSubtitles, setShowSubtitles] = useState(true);
  const [currentSubtitle, setCurrentSubtitle] = useState("");
  const [currentLanguage, setCurrentLanguage] = useState("en");
  const videoRef = useRef<HTMLVideoElement>(null);
  useEffect(() => {
    if (selectedVideo && showSubtitles) {
      const video = videoRef.current;
      if (!video) return;
      const handleTimeUpdate = () => {
        const currentTime = video.currentTime;
        const subs = selectedVideo.subtitles?.[currentLanguage] || [];
        const activeSub = subs.find(s => currentTime >= s.startTime && currentTime <= s.endTime);
        setCurrentSubtitle(activeSub ? activeSub.text : "");
      };
      video.addEventListener("timeupdate", handleTimeUpdate);
      return () => video.removeEventListener("timeupdate", handleTimeUpdate);
    }
  }, [selectedVideo, showSubtitles, currentLanguage]);
  const handleSeek = (startTime: number) => {
    if (videoRef.current) {
      videoRef.current.currentTime = startTime;
      videoRef.current.play();
    }
  };
  if (!videos || videos.length === 0) return null;
  return <section className="py-12">
      <div className="flex items-center justify-between mb-8">
        <h2 className="text-2xl font-bold">{title}</h2>
        <Badge variant="secondary" className="px-3 py-1">
          {videos.length}{t("client.src.videos_available")}</Badge>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {videos.map(video => <m.div key={video.id} whileHover={{
        scale: 1.02
      }} whileTap={{
        scale: 0.98
      }} initial={{
        opacity: 0,
        y: 20
      }} animate={{
        opacity: 1,
        y: 0
      }} transition={{
        duration: 0.3
      }}>
            <Card className="overflow-hidden cursor-pointer group relative border-none shadow-premium bg-secondary/10" onClick={() => setSelectedVideo(video)}>
              <div className="relative aspect-video">
                <Image src={video.thumbnail} alt={video.title} fill className="object-cover transition-transform duration-500 group-hover:scale-110" loading="lazy" sizes="(max-width: 768px) 100vw, 50vw" />
                <div className="absolute inset-0 bg-black/40 group-hover:bg-black/20 transition-colors flex items-center justify-center">
                  <div className="w-12 h-12 rounded-full bg-primary/90 flex items-center justify-center text-white transform group-hover:scale-110 transition-transform">
                    <Play className="w-6 h-6 fill-current" />
                  </div>
                </div>
                {video.duration && <div className="absolute bottom-3 right-3 bg-black/70 text-white text-xs px-2 py-1 rounded">
                    {video.duration}
                  </div>}
                {video.category && <div className="absolute top-3 left-3">
                    <Badge className="bg-primary/80 hover:bg-primary backdrop-blur-md">
                      {video.category}
                    </Badge>
                  </div>}
              </div>
              <CardContent className="p-4">
                <h3 className="font-semibold text-lg line-clamp-1">{video.title}</h3>
                <p className="text-sm text-muted-foreground mt-1">{t("client.src.aipowered_virtual_tour_experience")}</p>
              </CardContent>
            </Card>
          </m.div>)}
      </div>

      {/* Video Lightbox */}
      <AnimatePresence>
        {selectedVideo && <m.div initial={{
        opacity: 0
      }} animate={{
        opacity: 1
      }} exit={{
        opacity: 0
      }} className="fixed inset-0 z-50 flex items-center justify-center bg-black/95 p-4 md:p-8">
            <div className="relative w-full max-w-5xl aspect-video bg-black rounded-xl overflow-hidden shadow-2xl flex flex-col">
              <div className="absolute top-4 right-4 z-10 flex gap-2">
                <Button size="icon" variant="secondary" className={`rounded-full border-none text-white ${showSubtitles ? "bg-primary" : "bg-white/10 hover:bg-white/20"}`} onClick={() => setShowSubtitles(!showSubtitles)} title={t("client.src.toggle_subtitles")}>
                  <MessageSquare className="w-5 h-5" />
                </Button>
                <Button size="icon" variant="secondary" className="rounded-full bg-white/10 hover:bg-white/20 border-none text-white" onClick={() => setCurrentLanguage(currentLanguage === "en" ? "tr" : "en")} title={t("client.src.change_language")}>
                  <Languages className="w-5 h-5" />
                </Button>
                <Button size="icon" variant="secondary" className="rounded-full bg-white/10 hover:bg-white/20 border-none text-white" onClick={() => setIsMuted(!isMuted)}>
                  {isMuted ? <VolumeX className="w-5 h-5" /> : <Volume2 className="w-5 h-5" />}
                </Button>
                <Button size="icon" variant="secondary" className="rounded-full bg-white/10 hover:bg-white/20 border-none text-white" onClick={() => setSelectedVideo(null)}>
                  <X className="w-5 h-5" />
                </Button>
              </div>

              {/* Video Player Section */}
              <div className="relative flex-1 w-full bg-black flex items-center justify-center group">
                <video ref={videoRef} autoPlay loop muted={isMuted} className="w-full h-full object-contain" src={selectedVideo.url}>{t("client.src.your_browser_does_not")}</video>
                
                {/* Subtitle Overlay */}
                {showSubtitles && currentSubtitle && <div className="absolute bottom-24 left-1/2 -translate-x-1/2 max-w-[80%] text-center">
                    <span className="bg-black/60 text-white text-lg md:text-xl px-4 py-2 rounded-lg backdrop-blur-sm border border-white/10">
                      {currentSubtitle}
                    </span>
                  </div>}

                <div className="absolute inset-x-0 bottom-0 p-8 bg-gradient-to-t from-black/90 to-transparent">
                  <h3 className="text-2xl font-bold text-white">{selectedVideo.title}</h3>
                  <div className="flex items-center gap-4 mt-2">
                    <span className="text-white/60 text-sm">{t("client.src.aigenerated_highfidelity_tour")}</span>
                    <Badge variant="outline" className="text-white border-white/20">{t("client.src.scope_interactive_engine")}</Badge>
                  </div>
                </div>
              </div>

              {/* Helper Navigation Tabs */}
              {selectedVideo.segments && selectedVideo.segments.length > 0 && <div className="bg-black/40 backdrop-blur-md p-4 border-t border-white/10">
                  <div className="flex items-center justify-center gap-2 overflow-x-auto pb-2 no-scrollbar">
                    <Tabs defaultValue={selectedVideo.segments[0].id} className="w-auto">
                      <TabsList className="bg-white/5 border border-white/10">
                        {selectedVideo.segments.map(segment => <TabsTrigger key={segment.id} value={segment.id} onClick={() => handleSeek(segment.startTime)} className="data-[state=active]:bg-primary data-[state=active]:text-white text-white/70">
                            {segment.label}
                          </TabsTrigger>)}
                      </TabsList>
                    </Tabs>
                  </div>
                </div>}
            </div>
          </m.div>}
      </AnimatePresence>
    </section>;
}