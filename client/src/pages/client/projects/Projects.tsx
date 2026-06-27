import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { PageShell } from "@/pages/client/layout/PageShell";
import { Card } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Search, MapPin, Calendar, ArrowRight, Building2, Layers, LayoutGrid, List, Map } from "lucide-react";
import { projectsApi, Project } from "@/lib/api/projects";
import { useAuth } from "@/lib/auth/hooks";
import { motion } from "framer-motion";
import { Link } from "wouter";
import { cn } from "@/lib/utils";
import { MapContainer, TileLayer, Marker, Popup } from "react-leaflet";

export default function Projects({ standalone = true }: { standalone?: boolean }) {
  const { t } = useTranslation();
  const [projectsData, setProjectsData] = useState<Project[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [searchTerm, setSearchTerm] = useState("");
  const [viewMode, setViewMode] = useState<"grid" | "list" | "map">("grid");
  const { user } = useAuth();

  useEffect(() => {
    fetchProjects();
  }, [user?.orgId]);

  const fetchProjects = async () => {
    try {
      setIsLoading(true);
      const data = await projectsApi.getProjects();
      setProjectsData((data as any)?.data || data || []);
    } catch (error) {
      console.error("Failed to fetch projects:", error);
    } finally {
      setIsLoading(false);
    }
  };

  const filteredProjects = projectsData.filter(project => 
    project.name.toLowerCase().includes(searchTerm.toLowerCase()) || 
    (project.description?.toLowerCase().includes(searchTerm.toLowerCase()) ?? false)
  );

  const getClientStatusBadge = (status: string, progress: number) => {
    if (progress >= 100 || status.toLowerCase() === "completed") {
      return <Badge className="bg-emerald-500/90 text-white border-0 shadow-sm">{t("client.src.move_in_ready", "Move-in Ready")}</Badge>;
    }
    if (status.toLowerCase() === "planning") {
      return <Badge className="bg-blue-500/90 text-white border-0 shadow-sm">{t("client.src.upcoming_launch", "Upcoming Launch")}</Badge>;
    }
    return <Badge className="bg-amber-500/90 text-white border-0 shadow-sm">{t("client.src.under_construction", "Under Construction")}</Badge>;
  };

  const content = (
      <div className="space-y-12 relative pb-20">
        {/* Background Ambience */}
        <div className="absolute top-0 right-0 w-[400px] h-[400px] bg-primary/5 rounded-full blur-[100px] -z-10 pointer-events-none translate-x-[10%]" />
        <div className="absolute top-40 left-0 w-[500px] h-[500px] bg-blue-500/5 rounded-full blur-[120px] -z-10 pointer-events-none translate-x-[-10%]" />

        {/* Hero & Search Section */}
        <div className="flex flex-col md:flex-row justify-between items-end gap-6 border-b border-border/40 pb-8">
          <div className="max-w-2xl">
            <h1 className="text-4xl font-black bg-clip-text text-transparent bg-linear-to-rrom-foreground to-foreground/70 mb-4">
              {t("client.src.discover_your_future", "Discover Your Future")}
            </h1>
            <p className="text-lg text-muted-foreground font-medium">
              {t("client.src.browse_our_portfolio_of", "Browse our portfolio of award-winning architectural developments. From concept to completion, we build lifestyles.")}
            </p>
          </div>
          
          <div className="w-full xl:w-auto shrink-0 flex flex-col xl:flex-row items-center gap-4">
            <div className="relative group w-full xl:w-auto">
              <Search className="absolute left-4 top-1/2 -translate-y-1/2 h-5 w-5 text-muted-foreground group-focus-within:text-primary transition-colors" />
              <Input 
                placeholder={t("client.src.search_by_project_name", "Search by project name or location...")} 
                value={searchTerm} 
                onChange={e => setSearchTerm(e.target.value)} 
                className="pl-12 pr-6 py-6 w-full xl:w-[350px] text-base bg-background/60 backdrop-blur border-border/50 focus:bg-background transition-all rounded-full shadow-sm group-hover:shadow-md" 
              />
            </div>
            <div className="flex bg-muted/50 p-1 rounded-full border border-border/50 shadow-inner shrink-0 w-full xl:w-auto justify-center">
              <Button variant="ghost" onClick={() => setViewMode("grid")} className={cn("rounded-full px-6 h-12 text-xs font-bold transition-all", viewMode === "grid" ? "bg-background shadow-sm text-foreground" : "text-muted-foreground hover:text-foreground")}>
                <LayoutGrid className="w-4 h-4 mr-2" /> Grid
              </Button>
              <Button variant="ghost" onClick={() => setViewMode("list")} className={cn("rounded-full px-6 h-12 text-xs font-bold transition-all", viewMode === "list" ? "bg-background shadow-sm text-foreground" : "text-muted-foreground hover:text-foreground")}>
                <List className="w-4 h-4 mr-2" /> List
              </Button>
              <Button variant="ghost" onClick={() => setViewMode("map")} className={cn("rounded-full px-6 h-12 text-xs font-bold transition-all", viewMode === "map" ? "bg-background shadow-sm text-foreground" : "text-muted-foreground hover:text-foreground")}>
                <Map className="w-4 h-4 mr-2" /> Map
              </Button>
            </div>
          </div>
        </div>

        {/* Project Grid */}
        {isLoading ? (
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
            {[1, 2, 3, 4].map(i => (
              <div key={i} className="h-[450px] rounded-3xl bg-muted/30 animate-pulse border border-border/30" />
            ))}
          </div>
        ) : filteredProjects.length === 0 ? (
          <div className="flex flex-col items-center justify-center py-20 text-center">
            <div className="w-24 h-24 bg-primary/10 rounded-full flex items-center justify-center mb-6 shadow-inner">
              <Building2 className="w-12 h-12 text-primary" />
            </div>
            <h3 className="text-3xl font-black bg-clip-text text-transparent bg-linear-to-r from-foreground to-foreground/60 mb-2">
              {t("client.src.no_projects_found", "No projects found")}
            </h3>
            <p className="text-muted-foreground">{t("client.src.we_could_not_find_any", "We couldn't find any developments matching your search.")}</p>
          </div>
        ) : viewMode === "map" ? (
          <div className="w-full h-[600px] rounded-3xl overflow-hidden relative shadow-sm border border-border/50 bg-muted/20 z-0">
             <MapContainer center={[39.92077, 32.85411]} zoom={6} className="w-full h-full z-0">
               <TileLayer
                 url="https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png"
                 attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors &copy; <a href="https://carto.com/attributions">CARTO</a>'
               />
               {filteredProjects.map((project: any, idx: number) => {
                  const pLat = project.lat || (39.92077 + (Math.random() - 0.5) * 5);
                  const pLng = project.lng || (32.85411 + (Math.random() - 0.5) * 5);
                  const pImg = idx % 2 === 0 ? "https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=800&q=80" : "https://images.unsplash.com/photo-1600607687920-4e2a09cf159d?w=800&q=80";
                  return (
                   <Marker key={project.id} position={[pLat, pLng]}>
                     <Popup className="rounded-2xl overflow-hidden shadow-lg p-0 border-0" closeButton={false}>
                       <div className="flex flex-col w-[240px] font-sans">
                          <div className="relative h-[140px] w-full">
                            <img src={pImg} className="w-full h-full object-cover" />
                            <div className="absolute top-2 left-2">
                              <Badge className="bg-background/90 text-xs text-foreground border-0 shadow-sm">{project.status.replace("_", " ")}</Badge>
                            </div>
                          </div>
                         <div className="p-3 bg-background flex flex-col gap-1">
                           <strong className="text-sm truncate text-foreground">{project.name}</strong>
                           <span className="text-xs text-muted-foreground truncate">{(project as any).location || "Turkey"}</span>
                         </div>
                       </div>
                     </Popup>
                   </Marker>
                  );
               })}
             </MapContainer>
          </div>
        ) : (
          <div className={cn("grid gap-8", viewMode === "grid" ? "grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4" : "grid-cols-1 xl:grid-cols-2")}>
            {filteredProjects.map((project, idx) => {
              // Extract mock data for beautiful rendering since backend might just have basic fields
              const imagePlaceholder = `https://images.unsplash.com/photo-${1600000000000 + idx}?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80`;
              const progress = (project as any).progress || 0;
              const location = (project as any).location || t("client.src.prime_location", "Prime Location");
              const units = (project as any).units || Math.floor(Math.random() * 200) + 50;

              return (
                <motion.div 
                  key={project.id}
                  initial={{ opacity: 0, y: 20 }}
                  animate={{ opacity: 1, y: 0 }}
                  transition={{ delay: idx * 0.1 }}
                >
                  <Card className={cn("group overflow-hidden rounded-3xl border-border/40 bg-card/50 backdrop-blur-sm shadow-sm hover:shadow-xl transition-all duration-500 cursor-pointer flex h-full", viewMode === "grid" ? "flex-col" : "flex-col sm:flex-row")}>
                    {/* Image Section */}
                    <div className={cn("relative overflow-hidden", viewMode === "grid" ? "w-full h-64" : "w-full sm:w-2/5 h-64 sm:h-auto")}>
                      <div className="absolute inset-0 bg-black/20 group-hover:bg-transparent transition-colors z-10" />
                      {/* We use a beautiful architectural unsplash image fallback for the showcase */}
                      <img 
                        src={idx % 2 === 0 ? "https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" : "https://images.unsplash.com/photo-1600607687920-4e2a09cf159d?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80"}
                        alt={project.name}
                        className="w-full h-full object-cover transform group-hover:scale-110 transition-transform duration-700"
                      />
                      <div className="absolute top-4 left-4 z-20">
                        {getClientStatusBadge(project.status, progress)}
                      </div>
                    </div>

                    {/* Content Section */}
                    <div className="flex-1 p-6 sm:p-8 flex flex-col justify-between">
                      <div>
                        <div className="flex items-center gap-2 text-muted-foreground text-sm font-semibold mb-3">
                          <MapPin className="w-4 h-4 text-primary" />
                          <span>{location}</span>
                        </div>
                        
                        <h2 className="text-2xl font-black text-foreground mb-3 group-hover:text-primary transition-colors">
                          {project.name}
                        </h2>
                        
                        <p className="text-sm text-muted-foreground line-clamp-2 mb-6 leading-relaxed">
                          {project.description || t("client.src.experience_luxury_living", "Experience luxury living with our state-of-the-art facilities and breathtaking views.")}
                        </p>
                        
                        <div className="grid grid-cols-2 gap-4 mb-6">
                          <div className="bg-muted/30 rounded-2xl p-3 border border-border/50">
                            <div className="flex items-center gap-1.5 text-xs text-muted-foreground mb-1 font-semibold">
                              <Layers className="w-3.5 h-3.5" />
                              {t("client.src.total_units", "Total Units")}
                            </div>
                            <div className="font-bold text-foreground">{units}</div>
                          </div>
                          <div className="bg-muted/30 rounded-2xl p-3 border border-border/50">
                            <div className="flex items-center gap-1.5 text-xs text-muted-foreground mb-1 font-semibold">
                              <Calendar className="w-3.5 h-3.5" />
                              {t("client.src.completion", "Completion")}
                            </div>
                            <div className="font-bold text-foreground">
                              {(project as any).estimatedEndDate ? new Date((project as any).estimatedEndDate).getFullYear() : "2027"}
                            </div>
                          </div>
                        </div>
                      </div>

                      <div className="flex flex-col gap-4 mt-auto pt-4 border-t border-border/40">
                        <div className="flex items-center justify-between">
                          <div>
                            <div className="text-xs text-muted-foreground font-semibold uppercase tracking-wider">{t("client.src.starting_from", "Starting From")}</div>
                            <div className="text-xl font-black text-foreground">
                              ${((project.budget || 5000000) / units).toLocaleString(undefined, { maximumFractionDigits: 0 })}
                            </div>
                          </div>
                          <Button className="rounded-full bg-primary/10 text-primary hover:bg-primary hover:text-primary-foreground transition-colors group-hover:px-6">
                            {t("client.src.discover", "Discover")}
                            <ArrowRight className="w-4 h-4 ml-2 group-hover:translate-x-1 transition-transform" />
                          </Button>
                        </div>
                        
                        {/* Download Catalog PDF Button (For 0/New Developments sales) */}
                        {((project as any).property?.documents || []).some((doc: any) => doc.fileName?.endsWith('.pdf') || doc.fileUrl?.endsWith('.pdf')) && (
                          <Button 
                            onClick={(e) => {
                              e.preventDefault();
                              e.stopPropagation();
                              const pdfDoc = (project as any).property.documents.find((doc: any) => doc.fileName?.endsWith('.pdf') || doc.fileUrl?.endsWith('.pdf'));
                              if (pdfDoc) {
                                const fullUrl = pdfDoc.fileUrl.startsWith('http') ? pdfDoc.fileUrl : `${import.meta.env.VITE_API_URL || ''}${pdfDoc.fileUrl}`;
                                window.open(fullUrl, '_blank');
                              }
                            }}
                            variant="outline" 
                            className="w-full rounded-full border-primary/30 text-primary hover:bg-primary/5 hover:text-primary font-bold transition-all text-xs h-10 gap-2 flex items-center justify-center shadow-xs"
                          >
                            <Calendar className="w-4 h-4" /> {t("client.src.download_catalog", "Download PDF Catalog")}
                          </Button>
                        )}
                      </div>
                    </div>
                  </Card>
                </motion.div>
              );
            })}
          </div>
        )}
      </div>
  );

  if (!standalone) {
    return (
      <PageShell title={t("client.src.new_developments", "New Developments")} description={t("client.src.explore_our_exclusive_projects", "Explore our exclusive residential and commercial projects")}>
        {content}
      </PageShell>
    );
  }

  return content;
}
