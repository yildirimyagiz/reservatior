import { useTranslation } from "react-i18next";
import { useState, useEffect, useRef } from 'react';
import { motion } from 'framer-motion';
import { Heart, MessageCircle, Bookmark, MapPin, User, Zap, Star, TrendingUp, Volume2, VolumeX, Play, Eye, Sparkles } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Link } from 'react-router-dom';
import SEOMetadata from "@/components/seo/SEOMetadata";
interface VideoListing {
  id: string;
  title: string;
  description: string;
  price: number;
  priceCurrency: string;
  likesCount: number;
  isPromoted: boolean;
  promotionTier: number;
  property: {
    name: string;
    city: string;
    region: string;
  };
  videoContents: Array<{
    videoUrl: string;
    thumbnailUrl?: string;
  }>;
  org: {
    name: string;
  };
  isB2B?: boolean;
  isAiArbitrage?: boolean;
  aiMessage?: string;
}
interface VideoFeedProps {
  isFullPage?: boolean;
}
export function VideoFeed({
  isFullPage = false
}: VideoFeedProps) {
  const {
    t
  } = useTranslation();
  const [items, setItems] = useState<VideoListing[]>([]);
  const [currentIndex, setCurrentIndex] = useState(0);
  const [loading, setLoading] = useState(true);
  const [isMuted, setIsMuted] = useState(true);
  const containerRef = useRef<HTMLDivElement>(null);
  useEffect(() => {
    const fetchFeed = async () => {
      try {
        const response = await fetch(`${import.meta.env.VITE_API_URL || ""}/api/v1/feed?limit=10`);
        const result = await response.json();
        setItems(result.data || []);
      } catch (error) {
        console.error("Failed to fetch feed:", error);
      } finally {
        setLoading(false);
      }
    };
    fetchFeed();
  }, []);
  const handleScroll = () => {
    if (!containerRef.current) return;
    const index = Math.round(containerRef.current.scrollTop / containerRef.current.clientHeight);
    if (index !== currentIndex) {
      setCurrentIndex(index);
    }
  };
  if (loading) return <div className="h-[80vh] flex items-center justify-center">{t("client.src.loading_feed")}</div>;
  if (items.length === 0) return null;
  return <section className={`bg-slate-950 text-white overflow-hidden relative ${isFullPage ? 'h-full py-0' : 'py-20 h-[calc(100vh+200px)]'}`}>
      <SEOMetadata data={{
        type: 'LISTING',
        title: 'Video Keşfet: Lüks Rezidanslar ve Oteller | ',
        description: 'En popüler B2B otel indirimleri ve AI Arbitraj destekli ucuz konaklama fırsatlarını video akışımızla keşfedin. Direkt rezervasyon avantajı.',
        url: typeof window !== 'undefined' ? window.location.href : 'https://reservatior.com/feed',
        amenities: ['Direct Booking Hotel', 'Cheap Luxury Residence', 'Best Deal Accommodations', 'AI Travel Deals', 'B2B Wholesale Prices']
      }} />
      {!isFullPage && <div className="max-w-7xl mx-auto px-4 mb-10 flex justify-between items-end">
          <div>
            <Badge className="mb-4 bg-gold text-black hover:bg-gold/90">
              <TrendingUp className="w-3 h-3 mr-1" />{t("client.src.trending")}</Badge>
            <h2 className="text-2xl md:text-3xl font-medium font-outfit uppercase tracking-widest">{t("client.src.video_discovery")}<span className="text-gold">{t("client.src.feed")}</span>
            </h2>
            <p className="text-slate-400 mt-2 max-w-lg">{t("client.src.experience_properties_through_immersive")}</p>
          </div>
          <div className="hidden md:flex gap-2">
            <Link to="/auth/signup">
              <Button variant="outline" className="border-gold/50 text-gold hover:bg-gold hover:text-black">{t("client.src.join_premium")}</Button>
            </Link>
          </div>
        </div>}

      <div className={`flex flex-col md:flex-row gap-8 items-center justify-center ${isFullPage ? 'h-full w-full' : 'h-[700px] md:h-[800px]'}`}>
        {/* The Feed Container */}
        <div ref={containerRef} onScroll={handleScroll} className={`relative w-full snap-y snap-mandatory no-scrollbar shadow-2xl ${isFullPage ? 'h-full max-w-full md:max-w-[500px] border-x border-slate-900 bg-black' : 'h-full max-w-[450px] bg-black rounded-3xl overflow-y-scroll border-4 border-slate-900'}`}>
          {items.map((listing, index) => <VideoSlide key={listing.id} listing={listing} active={index === currentIndex} muted={isMuted} toggleMute={() => setIsMuted(!isMuted)} />)}
        </div>

        {/* Info Grid (Visible on Desktop) - Only in Section Mode */}
        {!isFullPage && <div className="hidden lg:grid grid-cols-1 gap-6 w-full max-w-sm h-full overflow-y-auto pr-4">
            {items.map((listing, index) => <motion.div key={listing.id} onClick={() => {
          containerRef.current?.scrollTo({
            top: index * containerRef.current.clientHeight,
            behavior: 'smooth'
          });
        }} className={`p-4 rounded-xl border transition-all cursor-pointer ${index === currentIndex ? 'bg-gold/10 border-gold' : 'bg-slate-900/50 border-slate-800 opacity-50'}`} whileHover={{
          scale: 1.02
        }}>
                <div className="flex items-center gap-3">
                  <div className="w-12 h-12 bg-slate-800 rounded-lg overflow-hidden relative">
                    <img src={listing.videoContents[0]?.thumbnailUrl || "/logo.png"} alt="" className="w-full h-full object-cover" />
                    {listing.isPromoted && <div className="absolute top-0 right-0 bg-gold text-black p-0.5 rounded-bl-md">
                        <Star className="w-2.5 h-2.5 fill-current" />
                      </div>}
                  </div>
                  <div>
                    <h4 className="font-bold text-sm line-clamp-1">{listing.title}</h4>
                    <p className="text-xs text-slate-400 capitalize">{listing.property.city}, {listing.property.region}</p>
                  </div>
                </div>
              </motion.div>)}
          </div>}
      </div>
    </section>;
}
function VideoSlide({
  listing,
  active,
  muted,
  toggleMute
}: {
  listing: VideoListing;
  active: boolean;
  muted: boolean;
  toggleMute: () => void;
}) {
  const {
    t
  } = useTranslation();
  const [isPlaying, setIsPlaying] = useState(false);
  const videoRef = useRef<HTMLVideoElement>(null);
  const [isLiked, setIsLiked] = useState(false);
  const [localLikes, setLocalLikes] = useState(listing.likesCount);
  useEffect(() => {
    if (active && videoRef.current) {
      videoRef.current.play().catch(() => {});
      setIsPlaying(true);
      // Track view when slide stays active for > 2s
      const timer = setTimeout(() => {
        fetch(`${import.meta.env.VITE_API_URL || ""}/api/v1/feed/view/${listing.id}`, {
          method: 'POST'
        });
      }, 2000);
      return () => clearTimeout(timer);
    } else if (videoRef.current) {
      videoRef.current.pause();
      setIsPlaying(false);
    }
  }, [active, listing.id]);
  const handleLike = async () => {
    if (isLiked) return;
    setIsLiked(true);
    setLocalLikes(prev => prev + 1);
    try {
      await fetch(`${import.meta.env.VITE_API_URL || ""}/api/v1/feed/like/${listing.id}`, {
        method: 'POST'
      });
    } catch (e) {
      console.error("Like failed:", e);
    }
  };
  const togglePlay = () => {
    if (videoRef.current) {
      if (isPlaying) videoRef.current.pause();else videoRef.current.play().catch(() => {});
      setIsPlaying(!isPlaying);
    }
  };
  return <div className="h-full w-full snap-start relative bg-slate-900 group">
      {/* Video layer */}
      <video ref={videoRef} src={listing.videoContents[0]?.videoUrl} poster={listing.videoContents[0]?.thumbnailUrl} loop muted={muted} playsInline className="h-full w-full object-cover" onClick={togglePlay} />

      {/* Overlay UI */}
      <div className="absolute inset-0 bg-linear-to-b from-black/40 via-transparent to-black/90 pointer-events-none" />

      {/* Top badges */}
      <div className="absolute top-6 left-6 flex flex-col gap-2 pointer-events-auto z-20">
        {listing.isAiArbitrage && <Badge className="w-fit bg-violet-600 text-white border-none animate-pulse shadow-[0_0_15px_rgba(139,92,246,0.5)]">
            <Sparkles className="w-3 h-3 mr-1 fill-current" /> AI ARBITRAGE
          </Badge>}
        {listing.isB2B && <Badge className="w-fit bg-emerald-500 text-white border-none shadow-[0_0_10px_rgba(16,185,129,0.3)]">
            <Zap className="w-3 h-3 mr-1 fill-current" /> BEST DEAL
          </Badge>}
        {listing.isPromoted && !listing.isAiArbitrage && !listing.isB2B && <Badge className="w-fit bg-gold text-black border-none animate-pulse">
            <Zap className="w-3 h-3 mr-1 fill-current" /> {(listing as any).isProject ? "FEATURED PROJECT" : "PROMOTED"}
          </Badge>}
        <div className="flex gap-2">
          {listing.promotionTier === 3 && <Badge variant="secondary" className="bg-purple-600 text-white border-none">{t("client.src.featured")}</Badge>}
        </div>
      </div>

      {/* AI Arbitrage Glow Overlay */}
      {listing.isAiArbitrage && (
        <div className="absolute inset-0 pointer-events-none rounded-3xl overflow-hidden shadow-[inset_0_0_50px_rgba(139,92,246,0.3)] border-2 border-violet-500/30" />
      )}

      {/* Play/Pause indicator */}
      {!isPlaying && <div className="absolute inset-0 flex items-center justify-center pointer-events-none">
          <motion.div initial={{
        scale: 0.5,
        opacity: 0
      }} animate={{
        scale: 1,
        opacity: 1
      }}>
            <Play className="w-16 h-16 text-white/50 fill-current" />
          </motion.div>
        </div>}

      {/* Vertical Actions */}
      <div className="absolute right-4 bottom-32 flex flex-col gap-6 items-center pointer-events-auto">
        <ActionButton icon={<Heart className={`w-7 h-7 ${isLiked ? 'fill-red-500 text-red-500' : ''}`} />} label={localLikes.toString()} onClick={handleLike} />
        <ActionButton icon={<MessageCircle className="w-7 h-7" />} label="24" />
        <ActionButton icon={<Bookmark className="w-7 h-7" />} label={t("client.src.save")} />
        <button onClick={toggleMute} className="p-3 bg-black/40 rounded-full backdrop-blur-md">
          {muted ? <VolumeX className="w-5 h-5 text-gold" /> : <Volume2 className="w-5 h-5 text-white" />}
        </button>
      </div>

      {/* Bottom Info */}
      <div className="absolute bottom-10 left-6 right-16 pointer-events-none">
        <div className="flex items-center gap-3 mb-4">
          <div className="w-10 h-10 bg-gold rounded-full flex items-center justify-center text-black font-bold">
            <User className="w-5 h-5" />
          </div>
          <div>
            <h4 className="font-bold text-lg">{listing.org.name}</h4>
            <div className="flex items-center text-xs text-gold/80">
              <Star className="w-3 h-3 fill-current mr-1" />{t("client.src.partner_agency")}</div>
          </div>
        </div>
        
        <h3 className="text-2xl font-bold font-outfit uppercase tracking-tight mb-2 line-clamp-1">
          {listing.title}
        </h3>
        
        <p className="text-sm text-slate-200 line-clamp-2 mb-4 max-w-[80%]">
          {listing.description}
        </p>

        <div className="flex items-center justify-between pointer-events-auto">
          <div className="flex items-center gap-4">
            <div className="flex items-center gap-1 text-gold text-xl font-black">
              {listing.priceCurrency} {listing.price.toLocaleString()}
            </div>
            <div className="flex items-center text-xs text-white/60">
              <MapPin className="w-3 h-3 mr-1" /> {listing.property.city}
            </div>
          </div>
          <Link to={`/properties/${listing.id}`}>
            {listing.isAiArbitrage || listing.isB2B ? (
              <Button size="sm" className="bg-gold hover:bg-white text-black font-bold uppercase tracking-widest text-[10px] h-9 px-4 shadow-[0_0_20px_rgba(255,215,0,0.4)]">
                {listing.isAiArbitrage ? "Tasarruf Et" : "Hemen Rezerve Et"}
              </Button>
            ) : (
              <Button size="sm" className="bg-white/10 hover:bg-gold hover:text-black border border-white/20 backdrop-blur-md font-bold uppercase tracking-widest text-[10px] h-9 px-4">
                <Eye className="w-3.5 h-3.5 mr-2" />{t("client.src.view_property")}
              </Button>
            )}
          </Link>
        </div>
      </div>
    </div>;
}
function ActionButton({
  icon,
  label,
  onClick
}: {
  icon: React.ReactNode;
  label: string;
  onClick?: () => void;
}) {
  return <button onClick={onClick} className="flex flex-col items-center gap-1 group/btn">
      <div className="p-3 bg-black/40 rounded-full backdrop-blur-md group-hover/btn:bg-gold/20 transition-colors">
        {icon}
      </div>
      <span className="text-xs font-bold text-white/80">{label}</span>
    </button>;
}