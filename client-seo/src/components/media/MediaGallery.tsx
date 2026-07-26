import Image from "next/image";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Dialog, DialogContent, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Play, Download, Share2, Camera, Video, X } from "lucide-react";
import { propertiesApi } from "@/lib/api/properties-fetch";
interface MediaItem {
  id: string;
  url: string;
  type: "photo" | "video";
  caption?: string;
  thumbnail?: string;
  duration?: number;
  featured?: boolean;
}
interface MediaGalleryProps {
  propertyId: string;
  propertyPhotos?: any[];
  propertyVideos?: any[];
  isOpen: boolean;
  onClose: () => void;
}
export default function MediaGallery({
  propertyId,
  propertyPhotos = [],
  propertyVideos = [],
  isOpen,
  onClose
}: MediaGalleryProps) {
  const {
    t
  } = useTranslation();
  const [activeTab, setActiveTab] = useState("photos");
  const [selectedMedia, setSelectedMedia] = useState<MediaItem | null>(null);
  const [isPlaying, setIsPlaying] = useState(false);
  const [photos, setPhotos] = useState<MediaItem[]>([]);
  const [videos, setVideos] = useState<MediaItem[]>([]);
  const [loading, setLoading] = useState(false);
  useEffect(() => {
    if (isOpen && propertyId) {
      loadMedia();
    }
  }, [isOpen, propertyId]);
  const loadMedia = async () => {
    setLoading(true);
    try {
      // Fetch photos from API
      const photosResponse = await propertiesApi.getPhotos(propertyId);
      const photosData = photosResponse.data || [];

      // Fetch videos from API
      const videosResponse = await propertiesApi.getVideos(propertyId);
      const videosData = videosResponse.data || [];

      // Add photos from seed data
      const seedPhotos = propertyPhotos.map((photo: any, index: number) => ({
        id: photo.id || `photo-${index}`,
        url: photo.url || `https://picsum.photos/seed/property${propertyId}-${index}/800/600.jpg`,
        type: "photo" as const,
        caption: photo.caption || `Property Photo ${index + 1}`,
        featured: photo.featured || photo.isPrimary || index === 0
      }));

      // Add videos from seed data
      const seedVideos = propertyVideos.map((video: any, index: number) => ({
        id: video.id || `video-${index}`,
        url: video.videoUrl || `https://sample-videos.com/zip/10/mp4/SampleVideo_1280x720_1mb.mp4`,
        type: "video" as const,
        caption: video.title || video.description || `Property Video ${index + 1}`,
        thumbnail: video.thumbnailUrl || `https://picsum.photos/seed/video${propertyId}-${index}/800/450.jpg`,
        duration: video.duration || 180,
        title: video.title || `Property Video ${index + 1}`,
        description: video.description
      }));
      setPhotos([...seedPhotos, ...photosData]);
      setVideos([...seedVideos, ...videosData]);
    } catch (error) {
      console.error("Failed to load media:", error);
      // Fallback to sample data
      setPhotos([{
        id: "sample-1",
        url: `https://picsum.photos/seed/property${propertyId}-1/800/600.jpg`,
        type: "photo",
        caption: "Living Room",
        featured: true
      }, {
        id: "sample-2",
        url: `https://picsum.photos/seed/property${propertyId}-2/800/600.jpg`,
        type: "photo",
        caption: "Kitchen"
      }, {
        id: "sample-3",
        url: `https://picsum.photos/seed/property${propertyId}-3/800/600.jpg`,
        type: "photo",
        caption: "Master Bedroom"
      }]);
    } finally {
      setLoading(false);
    }
  };
  const allMedia = [...photos, ...videos];
  const featuredMedia = allMedia.find(item => item.featured) || allMedia[0];
  const handleMediaClick = (media: MediaItem) => {
    setSelectedMedia(media);
    if (media.type === "video") {
      setIsPlaying(true);
    }
  };
  const renderMediaGrid = (items: MediaItem[]) => <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
      {items.map(item => <Card key={item.id} className="cursor-pointer overflow-hidden hover:shadow-lg transition-shadow" onClick={() => handleMediaClick(item)}>
          <div className="relative aspect-square">
            <Image src={(item.type === "video" ? item.thumbnail : item.url) as string} alt={item.caption || ""} fill className="object-cover" loading="lazy" sizes="(max-width: 768px) 100vw, 50vw" />
            {item.type === "video" && <div className="absolute inset-0 bg-black/30 flex items-center justify-center">
                <Play className="w-8 h-8 text-white" />
              </div>}
            {item.featured && <Badge className="absolute top-2 right-2" variant="secondary">{t("client.src.featured")}</Badge>}
          </div>
          <CardContent className="p-2">
            <p className="text-sm truncate">{item.caption}</p>
            {item.type === "video" && item.duration && <p className="text-xs text-gray-500">
                {Math.floor(item.duration / 60)}:{(item.duration % 60).toString().padStart(2, "0")}
              </p>}
          </CardContent>
        </Card>)}
    </div>;
  if (loading) {
    return <Dialog open={isOpen} onOpenChange={onClose}>
        <DialogContent className="max-w-4xl max-h-[90vh]">
          <div className="flex items-center justify-center h-96">
            <div className="text-center">
              <Camera className="w-12 h-12 mx-auto mb-4 text-muted-foreground animate-pulse" />
              <p className="text-muted-foreground">{t("client.src.loading_media")}</p>
            </div>
          </div>
        </DialogContent>
      </Dialog>;
  }
  return <Dialog open={isOpen} onOpenChange={onClose}>
      <DialogContent className="max-w-6xl max-h-[90vh] overflow-hidden">
        <DialogHeader>
          <div className="flex items-center justify-between">
            <DialogTitle className="flex items-center gap-2">
              <Camera className="w-5 h-5" />{t("client.src.property_media_gallery")}</DialogTitle>
            <Button variant="ghost" size="sm" onClick={onClose}>
              <X className="w-4 h-4" />
            </Button>
          </div>
        </DialogHeader>

        <div className="flex-1 overflow-hidden">
          <Tabs value={activeTab} onValueChange={setActiveTab} className="h-full flex flex-col">
            <TabsList className="grid w-full grid-cols-3">
              <TabsTrigger value="all" className="flex items-center gap-2">{t("client.src.all")}{allMedia.length})
              </TabsTrigger>
              <TabsTrigger value="photos" className="flex items-center gap-2">
                <Camera className="w-4 h-4" />{t("client.src.photos")}{photos.length})
              </TabsTrigger>
              <TabsTrigger value="videos" className="flex items-center gap-2">
                <Video className="w-4 h-4" />{t("client.src.videos")}{videos.length})
              </TabsTrigger>
            </TabsList>

            <div className="flex-1 overflow-auto">
              <TabsContent value="all" className="mt-4">
                <div className="space-y-4">
                  {featuredMedia && <div className="mb-6">
                      <h3 className="text-lg font-semibold mb-2">{t("client.src.featured")}</h3>
                      <Card className="overflow-hidden">
                        <div className="relative aspect-video">
                          {featuredMedia.type === "video" ? <video className="w-full h-full object-cover" controls poster={featuredMedia.thumbnail}>
                              <track kind="captions" src="" srcLang="en" label="English" default />
                              <source src={featuredMedia.url as string} type="video/mp4" />
                            </video> : <Image src={featuredMedia.url as string} alt={featuredMedia.caption || ""} fill className="object-cover" loading="lazy" sizes="(max-width: 768px) 100vw, 50vw" />}
                        </div>
                        <CardContent className="p-4">
                          <h4 className="font-semibold">{featuredMedia.caption}</h4>
                        </CardContent>
                      </Card>
                    </div>}
                  
                  {photos.length > 0 && <div>
                      <h3 className="text-lg font-semibold mb-2">{t("client.src.photos")}</h3>
                      {renderMediaGrid(photos)}
                    </div>}
                  
                  {videos.length > 0 && <div className="mt-6">
                      <h3 className="text-lg font-semibold mb-2">{t("client.src.videos")}</h3>
                      {renderMediaGrid(videos)}
                    </div>}
                </div>
              </TabsContent>

              <TabsContent value="photos" className="mt-4">
                {photos.length > 0 ? renderMediaGrid(photos) : <div className="text-center py-12">
                    <Camera className="w-12 h-12 mx-auto mb-4 text-muted-foreground" />
                    <p className="text-muted-foreground">{t("client.src.no_photos_available")}</p>
                  </div>}
              </TabsContent>

              <TabsContent value="videos" className="mt-4">
                {videos.length > 0 ? renderMediaGrid(videos) : <div className="text-center py-12">
                    <Video className="w-12 h-12 mx-auto mb-4 text-muted-foreground" />
                    <p className="text-muted-foreground">{t("client.src.no_videos_available")}</p>
                  </div>}
              </TabsContent>
            </div>
          </Tabs>
        </div>

        {/* Media Preview Modal */}
        {selectedMedia && <Dialog open={!!selectedMedia} onOpenChange={() => setSelectedMedia(null)}>
            <DialogContent className="max-w-4xl">
              <DialogHeader>
                <DialogTitle>{selectedMedia.caption}</DialogTitle>
              </DialogHeader>
              <div className="relative aspect-video">
                {selectedMedia.type === "video" ? <video className="w-full h-full object-contain bg-black" controls autoPlay={isPlaying} onPlay={() => setIsPlaying(true)} onPause={() => setIsPlaying(false)}>
                    <track kind="captions" src="" srcLang="en" label="English" default />
                    <source src={selectedMedia.url as string} type="video/mp4" />
                  </video> : <Image src={selectedMedia.url as string} alt={selectedMedia.caption || ""} fill className="object-contain" loading="lazy" sizes="(max-width: 768px) 100vw, 50vw" />}
              </div>
              <div className="flex justify-between items-center">
                <p className="text-sm text-gray-600">{selectedMedia.caption}</p>
                <div className="flex gap-2">
                  <Button variant="outline" size="sm">
                    <Download className="w-4 h-4 mr-2" />{t("client.src.download")}</Button>
                  <Button variant="outline" size="sm">
                    <Share2 className="w-4 h-4 mr-2" />{t("client.src.share")}</Button>
                </div>
              </div>
            </DialogContent>
          </Dialog>}
      </DialogContent>
    </Dialog>;
}