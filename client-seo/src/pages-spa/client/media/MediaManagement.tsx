import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { PageShell } from "@/pages-spa/client/layout/PageShell";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { MoreHorizontal, Search, Camera, Image, Download, Eye, Trash2, Edit, Grid, List, Upload, Filter } from "lucide-react";
import { Input } from "@/components/ui/input";
import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { useToast } from "@/hooks/use-toast";
import { apiClient } from "@/lib/api";
import { AiStudioTab } from "@/components/dashboard/AiStudioTab";
import { Sparkles } from "lucide-react";
import NextImage from "next/image";

// Type definitions
interface Photo {
  id: string;
  orgId: string;
  propertyId?: string;
  agentId?: string;
  url: string;
  thumbnailUrl: string;
  caption?: string;
  description?: string;
  tags: string[];
  isPublic: boolean;
  isFeatured: boolean;
  sortOrder: number;
  metadata?: {
    width: number;
    height: number;
    fileSize: number;
    format: string;
    takenAt?: string;
    camera?: string;
    location?: string;
  };
  createdAt: string;
  updatedAt: string;
  property?: {
    id: string;
    name: string;
  };
  agent?: {
    id: string;
    name: string;
  };
}
interface Post {
  id: string;
  orgId: string;
  agentId?: string;
  title: string;
  content: string;
  type: PostType;
  mediaUrls: string[];
  tags: string[];
  isPublished: boolean;
  publishedAt?: string;
  viewCount: number;
  likeCount: number;
  commentCount: number;
  createdAt: string;
  updatedAt: string;
  agent?: {
    id: string;
    name: string;
  };
}
enum PostType {
  PHOTO_GALLERY = "PHOTO_GALLERY",
  VIDEO_TOUR = "VIDEO_TOUR",
  PROPERTY_SHOWCASE = "PROPERTY_SHOWCASE",
  MARKETING_UPDATE = "MARKETING_UPDATE",
  MARKET_ANALYSIS = "MARKET_ANALYSIS",
  SUCCESS_STORY = "SUCCESS_STORY",
}
export default function MediaManagement() {
  const {
    t
  } = useTranslation();
  const [activeTab, setActiveTab] = useState<"photos" | "posts" | "ai">("photos");
  const [searchTerm, setSearchTerm] = useState("");
  const [filterType, setFilterType] = useState("all");
  const [filterStatus, setFilterStatus] = useState("all");
  const [viewMode, setViewMode] = useState<"grid" | "list">("grid");
  const [selectedPhoto, setSelectedPhoto] = useState<Photo | null>(null);
  const [photos, setPhotos] = useState<Photo[]>([]);
  const [posts, setPosts] = useState<Post[]>([]);
  const [loading, setLoading] = useState(true);
  const {
    toast
  } = useToast();

  // Fetch data from API
  useEffect(() => {
    const fetchData = async () => {
      try {
        setLoading(true);
        const [photosRes, postsRes] = await Promise.all([apiClient.get('/photos'), apiClient.get('/posts')]);
        setPhotos((photosRes as any).data || []);
        setPosts((postsRes as any).data || []);
      } catch (error) {
        console.error('Error fetching media data:', error);
        toast({
          title: t("client.src.error"),
          description: t("client.src.failed_to_load_media"),
          variant: "destructive"
        });
      } finally {
        setLoading(false);
      }
    };
    fetchData();
  }, []);
  const filteredPhotos = photos.filter(photo => {
    const matchesSearch = photo.caption?.toLowerCase().includes(searchTerm.toLowerCase()) || photo.description?.toLowerCase().includes(searchTerm.toLowerCase()) || photo.tags.some(tag => tag.toLowerCase().includes(searchTerm.toLowerCase())) || photo.property?.name.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesType = filterType === "all" || filterType === "image" && photo.metadata?.format?.startsWith('image/') || filterType === "featured" && photo.isFeatured;
    const matchesStatus = filterStatus === "all" || filterStatus === "public" && photo.isPublic || filterStatus === "private" && !photo.isPublic;
    return matchesSearch && matchesType && matchesStatus;
  });
  const filteredPosts = posts.filter(post => {
    const matchesSearch = post.title.toLowerCase().includes(searchTerm.toLowerCase()) || post.content.toLowerCase().includes(searchTerm.toLowerCase()) || post.tags.some(tag => tag.toLowerCase().includes(searchTerm.toLowerCase())) || post.agent?.name.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesType = filterType === "all" || post.type === filterType;
    const matchesStatus = filterStatus === "all" || filterStatus === "published" && post.isPublished || filterStatus === "draft" && !post.isPublished;
    return matchesSearch && matchesType && matchesStatus;
  });
  const totalPhotos = filteredPhotos.length;
  const featuredPhotos = filteredPhotos.filter(p => p.isFeatured).length;
  const publicPhotos = filteredPhotos.filter(p => p.isPublic).length;
  const totalPosts = filteredPosts.length;
  const publishedPosts = filteredPosts.filter(p => p.isPublished).length;
  const handleDeletePhoto = async (id: string) => {
    try {
      await apiClient.delete(`/photos/${id}`);
      setPhotos(photos.filter(p => p.id !== id));
      toast({
        title: t("client.src.photo_deleted"),
        description: t("client.src.photo_has_been_deleted")
      });
    } catch (error) {
      console.error('Error deleting photo:', error);
    }
  };
  const handleDeletePost = async (id: string) => {
    try {
      await apiClient.delete(`/posts/${id}`);
      setPosts(posts.filter(p => p.id !== id));
      toast({
        title: t("client.src.post_deleted"),
        description: t("client.src.post_has_been_deleted")
      });
    } catch (error) {
      console.error('Error deleting post:', error);
    }
  };
  const handleToggleFeatured = async (id: string, isFeatured: boolean) => {
    try {
      await apiClient.patch(`/photos/${id}`, {
        isFeatured
      });
      setPhotos(photos.map(p => p.id === id ? {
        ...p,
        isFeatured
      } : p));
    } catch (error) {
      console.error('Error toggling featured:', error);
    }
  };
  const handleTogglePublish = async (id: string, isPublished: boolean) => {
    try {
      await apiClient.patch(`/posts/${id}`, {
        isPublished
      });
      setPosts(posts.map(p => p.id === id ? {
        ...p,
        isPublished
      } : p));
    } catch (error) {
      console.error('Error toggling publish:', error);
    }
  };
  const formatFileSize = (bytes: number) => {
    if (bytes === 0) return '0 Bytes';
    const k = 1024;
    const sizes = ['Bytes', 'KB', 'MB', 'GB'];
    const i = Math.floor(Math.log(bytes) / Math.log(k));
    return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
  };
  const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleDateString();
  };
  const getPostTypeColor = (type: PostType) => {
    switch (type) {
      case "PHOTO_GALLERY":
        return "default";
      case "VIDEO_TOUR":
        return "destructive";
      case "PROPERTY_SHOWCASE":
        return "default";
      case "MARKETING_UPDATE":
        return "secondary";
      case "MARKET_ANALYSIS":
        return "outline";
      case "SUCCESS_STORY":
        return "default";
      default:
        return "secondary";
    }
  };
  return <PageShell title={t("client.src.media_management")} description={t("client.src.manage_photos_videos_and")}>
      <div className="space-y-6">
        {/* Tab Navigation */}
        <div className="flex space-x-1 bg-muted p-1 rounded-lg w-fit">
          <Button variant={activeTab === "photos" ? "default" : "ghost"} size="sm" onClick={() => setActiveTab("photos")}>
            <Camera className="h-4 w-4 mr-2" />{t("client.src.photos")}</Button>
          <Button variant={activeTab === "posts" ? "default" : "ghost"} size="sm" onClick={() => setActiveTab("posts")}>
            <Grid className="h-4 w-4 mr-2" />{t("client.src.posts")}</Button>
          <Button variant={activeTab === "ai" ? "default" : "ghost"} size="sm" onClick={() => setActiveTab("ai")}>
            <Sparkles className="h-4 w-4 mr-2" />{t("client.src.ai_studio")}</Button>
        </div>

        {/* Summary Cards */}
        <div className="grid gap-4 md:grid-cols-4">
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("client.src.total_photos")}</CardTitle>
              <Camera className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{totalPhotos}</div>
              <p className="text-xs text-muted-foreground">
                {featuredPhotos}{t("client.src.featured")}</p>
            </CardContent>
          </Card>
          
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("client.src.public_photos")}</CardTitle>
              <Eye className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-green-600">
                {publicPhotos}
              </div>
              <p className="text-xs text-muted-foreground">
                {totalPhotos > 0 ? (publicPhotos / totalPhotos * 100).toFixed(1) : 0}{t("client.src.public")}</p>
            </CardContent>
          </Card>
          
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("client.src.posts")}</CardTitle>
              <Grid className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{totalPosts}</div>
              <p className="text-xs text-muted-foreground">
                {publishedPosts}{t("client.src.published")}</p>
            </CardContent>
          </Card>
          
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("client.src.engagement")}</CardTitle>
              <Eye className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-blue-600">
                {posts.reduce((sum, p) => sum + p.viewCount, 0)}
              </div>
              <p className="text-xs text-muted-foreground">{t("client.src.total_views")}</p>
            </CardContent>
          </Card>
        </div>

        {/* Filters and Actions */}
        <div className="flex items-center justify-between space-x-2">
          <div className="flex items-center space-x-2">
            <div className="relative">
              <Search className="absolute left-2 top-2.5 h-4 w-4 text-muted-foreground" />
              <Input placeholder={t("client.src.search")} value={searchTerm} onChange={e => setSearchTerm(e.target.value)} className="pl-8 w-[250px]" />
            </div>
            <DropdownMenu>
              <DropdownMenuTrigger asChild>
                <Button variant="outline" size="sm">
                  <Filter className="h-4 w-4 mr-2" />{t("client.src.type")}{filterType === "all" ? "All" : filterType}
                </Button>
              </DropdownMenuTrigger>
              <DropdownMenuContent>
                <DropdownMenuItem onClick={() => setFilterType("all")}>{t("client.src.all_types")}</DropdownMenuItem>
                {activeTab === "photos" && <>
                    <DropdownMenuItem onClick={() => setFilterType("image")}>{t("client.src.images")}</DropdownMenuItem>
                    <DropdownMenuItem onClick={() => setFilterType("featured")}>{t("client.src.featured")}</DropdownMenuItem>
                  </>}
                {activeTab === "posts" && Object.values(PostType).map(type => <DropdownMenuItem key={type} onClick={() => setFilterType(type)}>
                    {type.replace("_", " ")}
                  </DropdownMenuItem>)}
              </DropdownMenuContent>
            </DropdownMenu>
            <DropdownMenu>
              <DropdownMenuTrigger asChild>
                <Button variant="outline" size="sm">{t("client.src.status")}{filterStatus === "all" ? "All" : filterStatus}
                </Button>
              </DropdownMenuTrigger>
              <DropdownMenuContent>
                <DropdownMenuItem onClick={() => setFilterStatus("all")}>{t("client.src.all_status")}</DropdownMenuItem>
                {activeTab === "photos" && <>
                    <DropdownMenuItem onClick={() => setFilterStatus("public")}>{t("client.src.public")}</DropdownMenuItem>
                    <DropdownMenuItem onClick={() => setFilterStatus("private")}>{t("client.src.private")}</DropdownMenuItem>
                  </>}
                {activeTab === "posts" && <>
                    <DropdownMenuItem onClick={() => setFilterStatus("published")}>{t("client.src.published")}</DropdownMenuItem>
                    <DropdownMenuItem onClick={() => setFilterStatus("draft")}>{t("client.src.draft")}</DropdownMenuItem>
                  </>}
              </DropdownMenuContent>
            </DropdownMenu>
            {activeTab === "photos" && <div className="flex items-center space-x-1 border rounded-md p-1">
                <Button variant={viewMode === "grid" ? "default" : "ghost"} size="sm" onClick={() => setViewMode("grid")}>
                  <Grid className="h-4 w-4" />
                </Button>
                <Button variant={viewMode === "list" ? "default" : "ghost"} size="sm" onClick={() => setViewMode("list")}>
                  <List className="h-4 w-4" />
                </Button>
              </div>}
          </div>
          <Button>
            <Upload className="h-4 w-4 mr-2" />{t("client.src.upload")}{activeTab === "photos" ? "Photos" : "Create Post"}
          </Button>
        </div>

        {/* Content based on active tab */}
        {activeTab === "photos" && <Card>
            <CardHeader>
              <CardTitle>{t("client.src.photo_gallery")}</CardTitle>
              <CardDescription>{t("client.src.manage_property_photos_and")}</CardDescription>
            </CardHeader>
            <CardContent>
              {loading ? <div className="flex items-center justify-center py-8">
                  <div className="text-sm text-muted-foreground">{t("client.src.loading")}</div>
                </div> : viewMode === "grid" ? <div className="grid grid-cols-1 md:grid-cols-3 lg:grid-cols-4 gap-4">
                  {filteredPhotos.map(photo => <div key={photo.id} className="relative group">
                      <div className="aspect-square rounded-lg overflow-hidden bg-gray-100 relative">
                        <NextImage src={photo.thumbnailUrl || "/placeholder.jpg"} alt={photo.caption || "Photo"} fill className="object-cover group-hover:scale-105 transition-transform" sizes="(max-width: 768px) 100vw, 50vw" />
                        {photo.isFeatured && <Badge className="absolute top-2 left-2" variant="default">{t("client.src.featured")}</Badge>}
                      </div>
                      <div className="mt-2">
                        <p className="font-medium truncate">{photo.caption || "Untitled"}</p>
                        <p className="text-sm text-muted-foreground">
                          {photo.metadata?.width}×{photo.metadata?.height} • {formatFileSize(photo.metadata?.fileSize || 0)}
                        </p>
                      </div>
                      <div className="absolute top-2 right-2 opacity-0 group-hover:opacity-100 transition-opacity">
                        <DropdownMenu>
                          <DropdownMenuTrigger asChild>
                            <Button variant="secondary" size="sm">
                              <MoreHorizontal className="h-4 w-4" />
                            </Button>
                          </DropdownMenuTrigger>
                          <DropdownMenuContent>
                            <DropdownMenuItem onClick={() => setSelectedPhoto(photo)}>
                              <Eye className="h-4 w-4 mr-2" />{t("client.src.view")}</DropdownMenuItem>
                            <DropdownMenuItem>
                              <Download className="h-4 w-4 mr-2" />{t("client.src.download")}</DropdownMenuItem>
                            <DropdownMenuItem>
                              <Edit className="h-4 w-4 mr-2" />{t("client.src.edit")}</DropdownMenuItem>
                            <DropdownMenuItem onClick={() => handleToggleFeatured(photo.id, !photo.isFeatured)}>
                              <Camera className="h-4 w-4 mr-2" />
                              {photo.isFeatured ? "Remove Featured" : "Make Featured"}
                            </DropdownMenuItem>
                            <DropdownMenuItem className="text-red-600" onClick={() => handleDeletePhoto(photo.id)}>
                              <Trash2 className="h-4 w-4 mr-2" />{t("client.src.delete")}</DropdownMenuItem>
                          </DropdownMenuContent>
                        </DropdownMenu>
                      </div>
                    </div>)}
                </div> : <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead>{t("client.src.preview")}</TableHead>
                      <TableHead>{t("client.src.caption")}</TableHead>
                      <TableHead>{t("client.src.property")}</TableHead>
                      <TableHead>{t("client.src.size")}</TableHead>
                      <TableHead>{t("client.src.status")}</TableHead>
                      <TableHead>{t("client.src.created")}</TableHead>
                      <TableHead className="w-[50px]"></TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {filteredPhotos.map(photo => <TableRow key={photo.id}>
                        <TableCell>
                          <div className="w-16 h-16 rounded overflow-hidden bg-gray-100 relative">
                            <NextImage src={photo.thumbnailUrl || "/placeholder.jpg"} alt={photo.caption || ""} fill className="object-cover" sizes="64px" />
                          </div>
                        </TableCell>
                        <TableCell className="font-medium">
                          <div>
                            <div className="font-medium">{photo.caption || "Untitled"}</div>
                            {photo.description && <div className="text-sm text-muted-foreground truncate max-w-[200px]">
                                {photo.description}
                              </div>}
                          </div>
                        </TableCell>
                        <TableCell>
                          {photo.property ? <div>
                              <div className="font-medium">{photo.property.name}</div>
                              <div className="text-sm text-muted-foreground">
                                {photo.property.id}
                              </div>
                            </div> : <span className="text-muted-foreground">{t("client.src.na")}</span>}
                        </TableCell>
                        <TableCell>
                          <div className="text-sm">
                            <div>{photo.metadata?.width}×{photo.metadata?.height}</div>
                            <div className="text-muted-foreground">
                              {formatFileSize(photo.metadata?.fileSize || 0)}
                            </div>
                          </div>
                        </TableCell>
                        <TableCell>
                          <div className="flex flex-col space-y-1">
                            <Badge variant={photo.isPublic ? "default" : "secondary"}>
                              {photo.isPublic ? "Public" : "Private"}
                            </Badge>
                            {photo.isFeatured && <Badge variant="outline">{t("client.src.featured")}</Badge>}
                          </div>
                        </TableCell>
                        <TableCell>{formatDate(photo.createdAt)}</TableCell>
                        <TableCell>
                          <DropdownMenu>
                            <DropdownMenuTrigger asChild>
                              <Button variant="ghost" size="sm">
                                <MoreHorizontal className="h-4 w-4" />
                              </Button>
                            </DropdownMenuTrigger>
                            <DropdownMenuContent>
                              <DropdownMenuItem onClick={() => setSelectedPhoto(photo)}>
                                <Eye className="h-4 w-4 mr-2" />{t("client.src.view")}</DropdownMenuItem>
                              <DropdownMenuItem>
                                <Download className="h-4 w-4 mr-2" />{t("client.src.download")}</DropdownMenuItem>
                              <DropdownMenuItem onClick={() => handleToggleFeatured(photo.id, !photo.isFeatured)}>
                                <Camera className="h-4 w-4 mr-2" />
                                {photo.isFeatured ? "Remove Featured" : "Make Featured"}
                              </DropdownMenuItem>
                              <DropdownMenuItem className="text-red-600" onClick={() => handleDeletePhoto(photo.id)}>
                                <Trash2 className="h-4 w-4 mr-2" />{t("client.src.delete")}</DropdownMenuItem>
                            </DropdownMenuContent>
                          </DropdownMenu>
                        </TableCell>
                      </TableRow>)}
                  </TableBody>
                </Table>}
            </CardContent>
          </Card>}

        {activeTab === "posts" && <Card>
            <CardHeader>
              <CardTitle>{t("client.src.marketing_posts")}</CardTitle>
              <CardDescription>{t("client.src.manage_blog_posts_video")}</CardDescription>
            </CardHeader>
            <CardContent>
              {loading ? <div className="flex items-center justify-center py-8">
                  <div className="text-sm text-muted-foreground">{t("client.src.loading")}</div>
                </div> : <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead>{t("client.src.title")}</TableHead>
                      <TableHead>{t("client.src.type")}</TableHead>
                      <TableHead>{t("client.src.author")}</TableHead>
                      <TableHead>{t("client.src.media")}</TableHead>
                      <TableHead>{t("client.src.engagement")}</TableHead>
                      <TableHead>{t("client.src.status")}</TableHead>
                      <TableHead>{t("client.src.created")}</TableHead>
                      <TableHead className="w-[50px]"></TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {filteredPosts.map(post => <TableRow key={post.id}>
                        <TableCell className="font-medium">
                          <div>
                            <div className="font-medium">{post.title}</div>
                            <div className="text-sm text-muted-foreground truncate max-w-[200px]">
                              {post.content}
                            </div>
                          </div>
                        </TableCell>
                        <TableCell>
                          <Badge variant={getPostTypeColor(post.type)}>
                            {post.type.replace("_", " ")}
                          </Badge>
                        </TableCell>
                        <TableCell>
                          {post.agent ? <div>
                              <div className="font-medium">{post.agent.name}</div>
                              <div className="text-sm text-muted-foreground">
                                {post.agent.id}
                              </div>
                            </div> : <span className="text-muted-foreground">{t("client.src.system")}</span>}
                        </TableCell>
                        <TableCell>
                          <div className="flex items-center space-x-2">
                            {post.mediaUrls.length > 0 && <>
                                <Image className="h-4 w-4 text-blue-500" />
                                <span className="text-sm">{post.mediaUrls.length}{t("client.src.files")}</span>
                              </>}
                          </div>
                        </TableCell>
                        <TableCell>
                          <div className="text-sm">
                            <div>{post.viewCount}{t("client.src.views")}</div>
                            <div className="text-muted-foreground">
                              {post.likeCount}{t("client.src.likes")}{post.commentCount}{t("client.src.comments")}</div>
                          </div>
                        </TableCell>
                        <TableCell>
                          <Button variant={post.isPublished ? "default" : "secondary"} size="sm" onClick={() => handleTogglePublish(post.id, !post.isPublished)}>
                            {post.isPublished ? "Published" : "Draft"}
                          </Button>
                        </TableCell>
                        <TableCell>{formatDate(post.createdAt)}</TableCell>
                        <TableCell>
                          <DropdownMenu>
                            <DropdownMenuTrigger asChild>
                              <Button variant="ghost" size="sm">
                                <MoreHorizontal className="h-4 w-4" />
                              </Button>
                            </DropdownMenuTrigger>
                            <DropdownMenuContent>
                              <DropdownMenuItem>
                                <Eye className="h-4 w-4 mr-2" />{t("client.src.view")}</DropdownMenuItem>
                              <DropdownMenuItem>
                                <Edit className="h-4 w-4 mr-2" />{t("client.src.edit")}</DropdownMenuItem>
                              <DropdownMenuItem onClick={() => handleTogglePublish(post.id, !post.isPublished)}>
                                {post.isPublished ? "Unpublish" : "Publish"}
                              </DropdownMenuItem>
                              <DropdownMenuItem className="text-red-600" onClick={() => handleDeletePost(post.id)}>
                                <Trash2 className="h-4 w-4 mr-2" />{t("client.src.delete")}</DropdownMenuItem>
                            </DropdownMenuContent>
                          </DropdownMenu>
                        </TableCell>
                      </TableRow>)}
                  </TableBody>
                </Table>}
            </CardContent>
          </Card>}

        {activeTab === "ai" && <AiStudioTab />}

        {/* Photo Preview Dialog */}
        <Dialog open={!!selectedPhoto} onOpenChange={() => setSelectedPhoto(null)}>
          <DialogContent className="sm:max-w-[800px]">
            <DialogHeader>
              <DialogTitle>{selectedPhoto?.caption || "Photo Details"}</DialogTitle>
              <DialogDescription>
                {selectedPhoto?.description}
              </DialogDescription>
            </DialogHeader>
            {selectedPhoto && <div className="space-y-4">
                <div className="aspect-video bg-gray-100 rounded-lg overflow-hidden relative">
                  <NextImage src={selectedPhoto.url || "/placeholder.jpg"} alt={selectedPhoto.caption || ""} fill className="object-contain" sizes="(max-width: 768px) 100vw, 800px" />
                </div>
                <div className="grid grid-cols-2 gap-4 text-sm">
                  <div>
                    <span className="font-medium">{t("client.src.dimensions")}</span> {selectedPhoto.metadata?.width}×{selectedPhoto.metadata?.height}
                  </div>
                  <div>
                    <span className="font-medium">{t("client.src.file_size")}</span> {formatFileSize(selectedPhoto.metadata?.fileSize || 0)}
                  </div>
                  <div>
                    <span className="font-medium">{t("client.src.format")}</span> {selectedPhoto.metadata?.format}
                  </div>
                  <div>
                    <span className="font-medium">{t("client.src.camera")}</span> {selectedPhoto.metadata?.camera || "Unknown"}
                  </div>
                  {selectedPhoto.metadata?.takenAt && <div>
                      <span className="font-medium">{t("client.src.taken")}</span> {formatDate(selectedPhoto.metadata.takenAt)}
                    </div>}
                  {selectedPhoto.property && <div>
                      <span className="font-medium">{t("client.src.property")}</span> {selectedPhoto.property.name}
                    </div>}
                </div>
                {selectedPhoto.tags.length > 0 && <div>
                    <span className="font-medium text-sm">{t("client.src.tags")}</span>
                    <div className="flex flex-wrap gap-1 mt-1">
                      {selectedPhoto.tags.map((tag, index) => <Badge key={index} variant="outline">{tag}</Badge>)}
                    </div>
                  </div>}
              </div>}
          </DialogContent>
        </Dialog>
      </div>
    </PageShell>;
}