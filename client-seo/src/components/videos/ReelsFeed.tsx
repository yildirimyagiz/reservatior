"use client";

import { useCallback, useEffect, useMemo, useRef, useState } from "react";
import { useRouter } from "next/navigation";
import { useTranslation } from "react-i18next";
import { AnimatePresence, motion } from "framer-motion";
import {
  Bath,
  BedDouble,
  Bookmark,
  Camera,
  Heart,
  Info,
  MapPin,
  MessageCircle,
  Ruler,
  Send,
  Share2,
  Verified,
  Video,
  X,
} from "lucide-react";

export interface ReelProperty {
  id: string;
  name: string;
  city?: string | null;
  country?: string | null;
  listingPrice?: number | null;
  currency?: string | null;
  bedrooms?: number | null;
  bathrooms?: number | null;
  areaSqm?: number | null;
  photos?: { url?: string }[] | null;
  videoContents?: { url?: string }[] | null;
  agents?: { name?: string }[] | null;
  propertyPromotions?: { status?: string }[] | null;
}

interface CommentItem {
  id: string;
  user: string;
  avatar: string;
  text: string;
  time: string;
  likes: number;
  liked: boolean;
}

interface ReelsFeedProps {
  properties: ReelProperty[];
  loading?: boolean;
  error?: string | null;
  onRetry?: () => void;
}

const PHONE_REGEX = /(?:\d[\s\-._]?){8,}/;

function formatPrice(property: ReelProperty): string {
  if (property.listingPrice == null) return "—";
  try {
    return new Intl.NumberFormat("en-US", {
      style: "currency",
      currency: property.currency || "USD",
      maximumFractionDigits: 0,
    }).format(property.listingPrice);
  } catch {
    return `$${property.listingPrice.toLocaleString()}`;
  }
}

export default function ReelsFeed({
  properties,
  loading = false,
  error = null,
  onRetry,
}: ReelsFeedProps) {
  const { t } = useTranslation();
  const router = useRouter();
  const containerRef = useRef<HTMLDivElement>(null);

  const [activeIndex, setActiveIndex] = useState(0);
  const [tab, setTab] = useState<"forYou" | "following" | "trend">("forYou");
  const [liked, setLiked] = useState<Set<string>>(new Set());
  const [saved, setSaved] = useState<Set<string>>(new Set());
  const [followed, setFollowed] = useState<Set<string>>(new Set());
  const [comments, setComments] = useState<Record<string, CommentItem[]>>({});
  const [commentsFor, setCommentsFor] = useState<string | null>(null);
  const [showLikeBurst, setShowLikeBurst] = useState(false);

  const feedProperties = useMemo(() => {
    const list = [...properties];
    if (tab === "following") {
      list.sort((a, b) => {
        const aAgents = (a.agents?.length ?? 0) > 0;
        const bAgents = (b.agents?.length ?? 0) > 0;
        if (aAgents && !bAgents) return -1;
        if (!aAgents && bAgents) return 1;
        return 0;
      });
    } else if (tab === "trend") {
      list.sort(
        (a, b) => (b.listingPrice ?? 0) - (a.listingPrice ?? 0)
      );
    } else {
      list.sort(
        (a, b) => (b.listingPrice ?? 0) - (a.listingPrice ?? 0)
      );
    }
    return list;
  }, [properties, tab]);

  const activeProperty = feedProperties[activeIndex];

  useEffect(() => {
    if (activeIndex >= feedProperties.length && feedProperties.length > 0) {
      setActiveIndex(feedProperties.length - 1);
    }
  }, [feedProperties.length, activeIndex]);

  const handleScroll = useCallback(() => {
    const el = containerRef.current;
    if (!el) return;
    const idx = Math.round(el.scrollTop / el.clientHeight);
    if (idx !== activeIndex && idx >= 0 && idx < feedProperties.length) {
      setActiveIndex(idx);
    }
  }, [activeIndex, feedProperties.length]);

  const toggleLike = useCallback((id: string) => {
    setLiked((prev) => {
      const next = new Set(prev);
      if (next.has(id)) next.delete(id);
      else next.add(id);
      return next;
    });
  }, []);

  const toggleSave = useCallback((id: string) => {
    setSaved((prev) => {
      const next = new Set(prev);
      if (next.has(id)) next.delete(id);
      else next.add(id);
      return next;
    });
  }, []);

  const toggleFollow = useCallback((id: string) => {
    setFollowed((prev) => {
      const next = new Set(prev);
      if (next.has(id)) next.delete(id);
      else next.add(id);
      return next;
    });
  }, []);

  const handleShare = useCallback(async (property: ReelProperty) => {
    const url = `${window.location.origin}/client/property/${property.id}`;
    const text = property.name;
    if (navigator.share) {
      try {
        await navigator.share({ title: text, url });
      } catch {
        /* user cancelled */
      }
    } else {
      try {
        await navigator.clipboard.writeText(url);
      } catch {
        /* clipboard unavailable */
      }
    }
  }, []);

  const addComment = useCallback((propertyId: string, text: string) => {
    const trimmed = text.trim();
    if (!trimmed) return false;
    if (PHONE_REGEX.test(trimmed)) return false;
    const item: CommentItem = {
      id: `${Date.now()}-${Math.random().toString(36).slice(2)}`,
      user: "Siz",
      avatar: "S",
      text: trimmed,
      time: "now",
      likes: 0,
      liked: false,
    };
    setComments((prev) => ({
      ...prev,
      [propertyId]: [item, ...(prev[propertyId] ?? [])],
    }));
    return true;
  }, []);

  const openDetails = useCallback(
    (property: ReelProperty) => {
      router.push(`/client/property/${property.id}`);
    },
    [router]
  );

  const total = feedProperties.length;

  if (loading) {
    return <FeedSkeleton />;
  }

  if (error) {
    return (
      <div className="flex items-center justify-center h-[68vh] rounded-2xl border border-white/10 bg-white/5">
        <div className="text-center px-6">
          <Video className="w-12 h-12 text-white/20 mx-auto mb-4" />
          <p className="text-white/70 font-medium">{t("videos.feed.connectionError")}</p>
          {onRetry && (
            <button
              onClick={onRetry}
              className="mt-4 px-5 py-2 rounded-lg bg-brand text-white text-sm font-semibold hover:opacity-90"
            >
              {t("common.retry")}
            </button>
          )}
        </div>
      </div>
    );
  }

  if (total === 0) {
    return (
      <div className="flex items-center justify-center h-[68vh] rounded-2xl border border-white/10 bg-white/5">
        <div className="text-center px-6">
          <Video className="w-12 h-12 text-white/20 mx-auto mb-4" />
          <p className="text-white/70 font-medium">{t("videos.feed.emptyTitle")}</p>
          <p className="text-white/40 text-sm mt-1">{t("videos.feed.emptyDesc")}</p>
        </div>
      </div>
    );
  }

  return (
    <div className="relative mx-auto max-w-5xl">
      <div
        ref={containerRef}
        onScroll={handleScroll}
        className="relative h-[68vh] overflow-y-auto snap-y snap-mandatory no-scrollbar rounded-2xl border border-white/10 bg-black shadow-2xl"
      >
        {feedProperties.map((property, index) => (
          <ReelSlide
            key={property.id}
            property={property}
            isActive={index === activeIndex}
            liked={liked.has(property.id)}
            saved={saved.has(property.id)}
            followed={followed.has(property.id)}
            likeCount={(property.listingPrice ?? 0) % 1000 + 100}
            commentCount={comments[property.id]?.length ?? 0}
            onLike={() => toggleLike(property.id)}
            onDoubleTapLike={() => {
              toggleLike(property.id);
              setShowLikeBurst(true);
              setTimeout(() => setShowLikeBurst(false), 700);
            }}
            onSave={() => toggleSave(property.id)}
            onFollow={() => toggleFollow(property.id)}
            onComment={() => setCommentsFor(property.id)}
            onShare={() => handleShare(property)}
            onDetails={() => openDetails(property)}
          />
        ))}
      </div>

      {/* Tabs */}
      <div className="absolute top-4 left-1/2 -translate-x-1/2 z-20 flex items-center gap-6 px-4 py-2 rounded-full bg-black/50 backdrop-blur-md border border-white/10">
        {(
          [
            ["forYou", t("videos.feed.tabForYou")],
            ["following", t("videos.feed.tabFollowing")],
            ["trend", t("videos.feed.tabTrend")],
          ] as const
        ).map(([key, label]) => (
          <button
            key={key}
            onClick={() => setTab(key)}
            className={`text-sm font-bold transition-colors ${
              tab === key
                ? "text-white"
                : "text-white/50 hover:text-white/80"
            }`}
          >
            {label}
          </button>
        ))}
      </div>

      {/* Page indicator */}
      {total > 1 && (
        <div className="absolute right-2 top-1/2 -translate-y-1/2 z-20 flex flex-col items-center gap-1">
          {Array.from({ length: Math.min(total, 10) }).map((_, i) => (
            <div
              key={i}
              className={`w-[3px] rounded-full transition-all ${
                i === activeIndex
                  ? "h-5 bg-brand"
                  : "h-2 bg-white/25"
              }`}
            />
          ))}
        </div>
      )}

      {/* Like burst */}
      <AnimatePresence>
        {showLikeBurst && (
          <motion.div
            initial={{ opacity: 0, scale: 0.4 }}
            animate={{ opacity: 1, scale: 1.2 }}
            exit={{ opacity: 0, scale: 1.4 }}
            className="absolute inset-0 z-30 flex items-center justify-center pointer-events-none"
          >
            <Heart className="w-24 h-24 text-red-500 fill-red-500" />
          </motion.div>
        )}
      </AnimatePresence>

      {/* Comments sheet */}
      <AnimatePresence>
        {commentsFor && activeProperty && (
          <CommentsSheet
            property={activeProperty}
            comments={comments[commentsFor] ?? []}
            onClose={() => setCommentsFor(null)}
            onSubmit={(text) => addComment(commentsFor, text)}
          />
        )}
      </AnimatePresence>
    </div>
  );
}

function ReelSlide({
  property,
  isActive,
  liked,
  saved,
  followed,
  likeCount,
  commentCount,
  onLike,
  onDoubleTapLike,
  onSave,
  onFollow,
  onComment,
  onShare,
  onDetails,
}: {
  property: ReelProperty;
  isActive: boolean;
  liked: boolean;
  saved: boolean;
  followed: boolean;
  likeCount: number;
  commentCount: number;
  onLike: () => void;
  onDoubleTapLike: () => void;
  onSave: () => void;
  onFollow: () => void;
  onComment: () => void;
  onShare: () => void;
  onDetails: () => void;
}) {
  const { t } = useTranslation();
  const videoUrl = property.videoContents?.find((v) => v.url)?.url;
  const hasVideo = Boolean(videoUrl);
  const primaryImage =
    property.photos?.find((p) => p.url)?.url ||
    "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=1000";
  const isPromoted = property.propertyPromotions?.some(
    (p) => p.status === "ACTIVE"
  );

  const agentName =
    property.agents?.[0]?.name ||
    `Agent ${property.id.slice(0, 4).toUpperCase()}`;
  const agentLetter = (agentName[0] || "A").toUpperCase();

  return (
    <div
      className="relative h-full w-full snap-start overflow-hidden"
      onDoubleClick={onDoubleTapLike}
    >
      {/* Media layer */}
      {hasVideo ? (
        <ReelVideo
          src={videoUrl!}
          poster={primaryImage}
          isActive={isActive}
        />
      ) : (
        <motion.img
          src={primaryImage}
          alt={property.name}
          draggable={false}
          className="absolute inset-0 w-full h-full object-cover"
          animate={{ scale: [1, 1.12, 1] }}
          transition={{
            duration: 15,
            repeat: Infinity,
            ease: "easeInOut",
          }}
        />
      )}

      {/* Gradient overlay */}
      <div
        className="absolute inset-0 pointer-events-none"
        style={{
          background:
            "linear-gradient(to bottom, rgba(0,0,0,0.4) 0%, rgba(0,0,0,0) 30%, rgba(0,0,0,0) 70%, rgba(0,0,0,0.85) 100%)",
        }}
      />

      {/* Promoted badge */}
      {isPromoted && (
        <div className="absolute top-20 left-4 z-10 px-3 py-1 rounded-full bg-gradient-to-r from-amber-400 to-amber-500 shadow-lg shadow-amber-500/30">
          <span className="text-black text-[10px] font-black tracking-wide">
            ⚡ {t("videos.exclusive")}
          </span>
        </div>
      )}

      {/* Media type indicator */}
      <div className="absolute top-20 right-4 z-10 px-2.5 py-1 rounded-full bg-black/50 border border-white/10">
        <span className="flex items-center gap-1 text-white/70 text-[10px] font-bold tracking-wide">
          {hasVideo ? (
            <>
              <Video className="w-3 h-3 text-brand" />
              VIDEO
            </>
          ) : (
            <>
              <Camera className="w-3 h-3 text-white/70" />
              PHOTO
            </>
          )}
        </span>
      </div>

      {/* Bottom info */}
      <div className="absolute bottom-16 left-4 right-24 z-10">
        <div className="flex items-center gap-2 mb-3">
          <div className="flex items-center gap-2 px-3 py-1.5 rounded-full bg-black/50 border border-white/15">
            <span className="flex items-center justify-center w-6 h-6 rounded-full bg-brand/20 text-brand text-[11px] font-bold">
              {agentLetter}
            </span>
            <span className="text-white text-xs font-bold">{agentName}</span>
            <Verified className="w-3.5 h-3.5 text-brand" />
          </div>
          <button
            onClick={onFollow}
            className={`px-3.5 py-1.5 rounded-full text-[11px] font-bold transition-colors ${
              followed
                ? "bg-white/20 text-white border border-white/30"
                : "bg-brand text-white"
            }`}
          >
            {followed ? t("videos.feed.following") : t("videos.feed.follow")}
          </button>
        </div>

        <h3 className="text-white text-lg font-black leading-tight drop-shadow-lg line-clamp-2">
          {property.name}
        </h3>

        <div className="flex items-center gap-1 mt-2 text-white/60 text-[13px]">
          <MapPin className="w-3.5 h-3.5" />
          <span className="truncate">
            {[property.city, property.country].filter(Boolean).join(", ")}
          </span>
        </div>

        <div className="flex items-center mt-3 gap-2">
          <span className="px-3.5 py-1.5 rounded-xl bg-white text-black text-sm font-black shadow-lg">
            {formatPrice(property)}
          </span>
          <span className="flex-1" />
          {typeof property.bedrooms === "number" && property.bedrooms > 0 && (
            <ReelStat icon={BedDouble} value={`${property.bedrooms}`} />
          )}
          {typeof property.bathrooms === "number" && property.bathrooms > 0 && (
            <ReelStat icon={Bath} value={`${property.bathrooms}`} />
          )}
          {typeof property.areaSqm === "number" && property.areaSqm > 0 && (
            <ReelStat icon={Ruler} value={`${property.areaSqm}m²`} />
          )}
        </div>
      </div>

      {/* Right action rail */}
      <div className="absolute bottom-24 right-2.5 z-10 flex flex-col items-center gap-4">
        <ActionButton
          icon={Heart}
          label={likeCount.toString()}
          active={liked}
          activeColor="#ef4444"
          onClick={onLike}
        />
        <ActionButton
          icon={MessageCircle}
          label={commentCount > 0 ? commentCount.toString() : "0"}
          onClick={onComment}
        />
        <ActionButton
          icon={Bookmark}
          label={t("common.save")}
          active={saved}
          activeColor="#F59E0B"
          onClick={onSave}
        />
        <ActionButton icon={Share2} label={t("common.share")} onClick={onShare} />
        <ActionButton
          icon={Info}
          label={t("videos.feed.details")}
          activeColor="#F59E0B"
          onClick={onDetails}
        />
      </div>
    </div>
  );
}

function ReelVideo({
  src,
  poster,
  isActive,
}: {
  src: string;
  poster: string;
  isActive: boolean;
}) {
  const ref = useRef<HTMLVideoElement>(null);

  useEffect(() => {
    const video = ref.current;
    if (!video) return;
    if (isActive) {
      video.play().catch(() => {});
    } else {
      video.pause();
    }
  }, [isActive]);

  return (
    <video
      ref={ref}
      src={src}
      poster={poster}
      muted
      loop
      playsInline
      preload={isActive ? "auto" : "metadata"}
      className="absolute inset-0 w-full h-full object-cover"
    />
  );
}

function ReelStat({ icon: Icon, value }: { icon: any; value: string }) {
  return (
    <div className="flex items-center gap-1 px-2 py-1.5 rounded-lg bg-white/10 border border-white/10">
      <Icon className="w-3 h-3 text-white/70" />
      <span className="text-white text-[11px] font-semibold">{value}</span>
    </div>
  );
}

function ActionButton({
  icon: Icon,
  label,
  active,
  activeColor,
  onClick,
}: {
  icon: any;
  label: string;
  active?: boolean;
  activeColor?: string;
  onClick?: () => void;
}) {
  return (
    <button onClick={onClick} className="flex flex-col items-center gap-1 group">
      <span className="flex items-center justify-center w-11 h-11 rounded-full border border-white/15 bg-black/30 backdrop-blur-md group-hover:bg-white/10 transition-colors">
        <Icon
          className={`w-[22px] h-[22px] ${
            active ? "fill-current" : ""
          }`}
          style={{
            color: active ? (activeColor ?? "#fff") : "rgba(255,255,255,0.9)",
          }}
        />
      </span>
      <span className="text-white/90 text-[10px] font-bold drop-shadow">
        {label}
      </span>
    </button>
  );
}

function CommentsSheet({
  property,
  comments,
  onClose,
  onSubmit,
}: {
  property: ReelProperty;
  comments: CommentItem[];
  onClose: () => void;
  onSubmit: (text: string) => void;
}) {
  const { t } = useTranslation();
  const [text, setText] = useState("");
  const [blocked, setBlocked] = useState(false);

  const handleSubmit = () => {
    if (PHONE_REGEX.test(text.trim())) {
      setBlocked(true);
      setTimeout(() => setBlocked(false), 2500);
      return;
    }
    if (!text.trim()) return;
    onSubmit(text);
    setText("");
  };

  return (
    <motion.div
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      exit={{ opacity: 0 }}
      className="absolute inset-0 z-40 flex items-end justify-center bg-black/60"
      onClick={onClose}
    >
      <motion.div
        initial={{ y: 40, opacity: 0 }}
        animate={{ y: 0, opacity: 1 }}
        exit={{ y: 40, opacity: 0 }}
        transition={{ type: "spring", damping: 28, stiffness: 300 }}
        onClick={(e) => e.stopPropagation()}
        className="w-full max-w-2xl bg-[#101018] border border-white/10 rounded-t-2xl overflow-hidden"
      >
        <div className="flex items-center justify-between px-5 py-3 border-b border-white/10">
          <div className="min-w-0">
            <span className="text-white text-sm font-bold">
              {t("client.src.comments")} ({comments.length})
            </span>
            <p className="text-white/40 text-xs truncate mt-0.5">
              {property.name}
            </p>
          </div>
          <button
            onClick={onClose}
            className="p-1 rounded-full hover:bg-white/10 text-white/60 shrink-0"
          >
            <X className="w-5 h-5" />
          </button>
        </div>

        <div className="max-h-[40vh] overflow-y-auto px-5 py-4">
          {comments.length === 0 ? (
            <p className="text-center text-white/40 text-sm py-8">
              {t("videos.feed.noComments")}
            </p>
          ) : (
            <div className="space-y-5">
              {comments.map((c) => (
                <div key={c.id} className="flex gap-3">
                  <span className="flex items-center justify-center w-9 h-9 rounded-full bg-brand/15 text-brand text-xs font-bold shrink-0">
                    {c.avatar}
                  </span>
                  <div className="min-w-0">
                    <div className="flex items-center gap-2">
                      <span className="text-white text-[13px] font-bold">
                        {c.user}
                      </span>
                      <span className="text-white/40 text-[11px]">{c.time}</span>
                    </div>
                    <p className="text-white/85 text-[13px] leading-snug mt-1">
                      {c.text}
                    </p>
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>

        <div className="px-4 pb-4 pt-2 border-t border-white/10">
          {blocked && (
            <p className="text-red-400 text-xs mb-2">
              {t("videos.feed.phoneNumberBlocked")}
            </p>
          )}
          <div className="flex items-center gap-3">
            <input
              value={text}
              onChange={(e) => setText(e.target.value)}
              onKeyDown={(e) => {
                if (e.key === "Enter") handleSubmit();
              }}
              placeholder={t("videos.feed.writeComment")}
              className="flex-1 bg-white/5 border border-white/10 rounded-full px-4 py-2.5 text-white text-sm placeholder:text-white/40 outline-none focus:border-brand/50"
            />
            <button
              onClick={handleSubmit}
              className="flex items-center justify-center w-10 h-10 rounded-full bg-gradient-to-r from-brand to-amber-500 text-white"
            >
              <Send className="w-4 h-4" />
            </button>
          </div>
        </div>
      </motion.div>
    </motion.div>
  );
}

function FeedSkeleton() {
  return (
    <div className="relative mx-auto max-w-5xl h-[68vh] rounded-2xl border border-white/10 bg-[#0a0a14] overflow-hidden">
      <div className="absolute inset-0 animate-pulse">
        <div className="absolute inset-0 bg-white/5" />
        <div className="absolute bottom-16 left-4 right-24 space-y-3">
          <div className="w-44 h-9 rounded-full bg-white/10" />
          <div className="w-64 h-6 rounded bg-white/10" />
          <div className="w-48 h-4 rounded bg-white/5" />
          <div className="w-32 h-8 rounded-lg bg-white/10" />
        </div>
        <div className="absolute bottom-24 right-2.5 flex flex-col gap-4">
          {Array.from({ length: 5 }).map((_, i) => (
            <div key={i} className="w-11 h-11 rounded-full bg-white/10" />
          ))}
        </div>
      </div>
    </div>
  );
}
