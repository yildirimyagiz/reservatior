import React, { useState } from "react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription, DialogFooter } from "@/components/ui/dialog";
import { Card, CardContent } from "@/components/ui/card";
import { useToast } from "@/hooks/use-toast";
import { listingsApi } from "@/lib/api/listings";
import { tagsApi, Tag } from "@/lib/api/tags";
import { listingTagsApi } from "@/lib/api/listing-tags";
import {
  RefreshCw,
  Zap,
  TrendingUp,
  Tag as TagIcon,
  Plus,
  X,
  Check,
  Calendar,
  DollarSign,
  Star,
  ArrowUpRight,
  Search,
  Filter,
  Sparkles,
  Flame,
  Crown,
  Rocket,
  Eye,
  MessageSquare,
  Clock,
  MapPin,
  Building2,
  Layers,
  Grid3X3
} from "lucide-react";
import { motion, AnimatePresence } from "framer-motion";
import { cn } from "@/lib/utils";
import { useTranslation } from "react-i18next";
import { useNavigate } from "react-router-dom";

interface Listing {
  id: string;
  orgId: string;
  propertyId: string;
  title: string;
  description?: string;
  type: string;
  status: string;
  price?: number;
  priceCurrency?: string;
  expiresAt?: string;
  isPromoted: boolean;
  promotionTier?: number;
  promotedUntil?: string;
  createdAt: string;
  updatedAt: string;
  views?: number;
  leads?: number;
  likesCount?: number;
  property?: {
    id: string;
    name: string;
    city: string;
    addressLine1: string;
  };
  tags?: ListingTag[];
}

interface ListingTag {
  id: string;
  listingId: string;
  tagId: string;
  orgId: string;
  tag?: Tag;
}

export default function ListingManagement() {
  const { t } = useTranslation();
  const navigate = useNavigate();
  const { toast } = useToast();
  const queryClient = useQueryClient();
  
  const [search, setSearch] = useState("");
  const [filterStatus, setFilterStatus] = useState("all");
  const [selectedListing, setSelectedListing] = useState<Listing | null>(null);
  const [tagDialogOpen, setTagDialogOpen] = useState(false);
  const [promotionDialogOpen, setPromotionDialogOpen] = useState(false);
  const [renewalDialogOpen, setRenewalDialogOpen] = useState(false);
  const [selectedTags, setSelectedTags] = useState<string[]>([]);

  const { data: listings = [], isLoading: listingsLoading } = useQuery({
    queryKey: ['listings'],
    queryFn: async () => {
      const response = await listingsApi.getListings({ page: 1, limit: 50 });
      return (response as any).data || [];
    }
  });

  const { data: tags = [], isLoading: tagsLoading } = useQuery({
    queryKey: ['tags'],
    queryFn: async () => {
      const response = await tagsApi.getAll();
      return (response as any).data || [];
    }
  });

  const { data: listingTags = [] } = useQuery({
    queryKey: ['listing-tags'],
    queryFn: async () => {
      const response = await listingTagsApi.getAll();
      return (response as any).data || [];
    }
  });

  const addTagMutation = useMutation({
    mutationFn: async ({ listingId, tagId, orgId }: { listingId: string; tagId: string; orgId: string }) => {
      return listingTagsApi.addTagToListing(listingId, tagId, orgId);
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['listing-tags'] });
      queryClient.invalidateQueries({ queryKey: ['listings'] });
      toast({ title: t('success'), description: t('tagAdded') });
    }
  });

  const removeTagMutation = useMutation({
    mutationFn: async (id: string) => {
      return listingTagsApi.removeTagFromListing(id);
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['listing-tags'] });
      queryClient.invalidateQueries({ queryKey: ['listings'] });
      toast({ title: t('success'), description: t('tagRemoved') });
    }
  });

  const promoteMutation = useMutation({
    mutationFn: async ({ listingId, tier, days }: { listingId: string; tier: number; days: number }) => {
      // This would call the promotion API
      return listingsApi.updateListing(listingId, { 
        isPromoted: true, 
        promotionTier: tier,
        promotedUntil: new Date(Date.now() + days * 24 * 60 * 60 * 1000).toISOString()
      } as any);
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['listings'] });
      toast({ title: t('success'), description: t('listingPromoted') });
      setPromotionDialogOpen(false);
    }
  });

  const renewMutation = useMutation({
    mutationFn: async (listingId: string) => {
      // This would call the renewal API
      return listingsApi.updateListing(listingId, { 
        expiresAt: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toISOString()
      } as any);
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['listings'] });
      toast({ title: t('success'), description: t('listingRenewed') });
      setRenewalDialogOpen(false);
    }
  });

  const getStatusColor = (status: string) => {
    const colors: Record<string, string> = {
      ACTIVE: "bg-emerald-500/10 text-emerald-400 border-emerald-500/20",
      DRAFT: "bg-slate-500/10 text-slate-400 border-slate-500/20",
      INACTIVE: "bg-amber-500/10 text-amber-400 border-amber-500/20",
      SOLD: "bg-indigo-500/10 text-indigo-400 border-indigo-500/20",
      EXPIRED: "bg-rose-500/10 text-rose-400 border-rose-500/20",
      RENTED: "bg-blue-500/10 text-blue-400 border-blue-500/20",
    };
    return colors[status] || "bg-slate-500/10 text-slate-400";
  };

  const getListingTags = (listingId: string) => {
    return listingTags.filter((lt: ListingTag) => lt.listingId === listingId);
  };

  const handleAddTags = () => {
    if (!selectedListing) return;
    selectedTags.forEach(tagId => {
      addTagMutation.mutate({ 
        listingId: selectedListing.id, 
        tagId, 
        orgId: selectedListing.orgId 
      });
    });
    setSelectedTags([]);
    setTagDialogOpen(false);
  };

  const handleRemoveTag = (listingTagId: string) => {
    removeTagMutation.mutate(listingTagId);
  };

  const filteredListings = listings.filter((l: Listing) => 
    (l.title?.toLowerCase().includes(search.toLowerCase()) || l.property?.name.toLowerCase().includes(search.toLowerCase())) &&
    (filterStatus === "all" || l.status === filterStatus)
  );

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-950 via-slate-900 to-slate-950 p-6 lg:p-12 relative overflow-hidden">
      {/* Animated Background */}
      <div className="absolute inset-0 pointer-events-none overflow-hidden">
        <div className="absolute -top-40 -right-40 w-96 h-96 bg-blue-500/10 rounded-full blur-3xl animate-pulse" />
        <div className="absolute -bottom-40 -left-40 w-96 h-96 bg-purple-500/10 rounded-full blur-3xl animate-pulse delay-1000" />
        <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[800px] h-[800px] bg-gradient-to-r from-blue-500/5 via-purple-500/5 to-pink-500/5 rounded-full blur-3xl" />
        <div className="absolute inset-0 bg-[url('data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNDAiIGhlaWdodD0iNDAiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+PGNpcmNsZSBjeD0iMSIgY3k9IjEiIHI9IjEiIGZpbGw9InJnYmEoMjU1LDI1NSwyNTUsMC4wMykiLz48L3N2Zz4=')] opacity-30" />
      </div>

      <div className="max-w-[1800px] mx-auto space-y-8 relative z-10">
        {/* Hero Header */}
        <motion.div 
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="relative"
        >
          <div className="bg-gradient-to-r from-blue-600/20 via-purple-600/20 to-pink-600/20 backdrop-blur-3xl border border-white/10 rounded-3xl p-8 lg:p-12 relative overflow-hidden">
            <div className="absolute inset-0 bg-gradient-to-r from-blue-500/10 to-purple-500/10" />
            <div className="relative z-10">
              <div className="flex items-center gap-3 mb-4">
                <div className="w-12 h-12 rounded-2xl bg-gradient-to-br from-blue-500 to-purple-600 flex items-center justify-center shadow-2xl shadow-blue-500/30">
                  <Building2 className="w-6 h-6 text-white" />
                </div>
                <div>
                  <h1 className="text-4xl lg:text-5xl font-black text-white italic tracking-tighter">
                    Listing Management
                  </h1>
                  <p className="text-slate-400 text-sm font-black tracking-widest uppercase mt-1">
                    Manage, Boost & Optimize Your Listings
                  </p>
                </div>
              </div>
              
              {/* Stats Bar */}
              <div className="grid grid-cols-2 lg:grid-cols-4 gap-4 mt-8">
                {[
                  { label: "Total Listings", value: listings.length, icon: Layers, color: "from-blue-500 to-blue-600" },
                  { label: "Active", value: listings.filter((l: Listing) => l.status === "ACTIVE").length, icon: Sparkles, color: "from-emerald-500 to-emerald-600" },
                  { label: "Promoted", value: listings.filter((l: Listing) => l.isPromoted).length, icon: Crown, color: "from-amber-500 to-amber-600" },
                  { label: "Expiring Soon", value: listings.filter((l: Listing) => l.expiresAt && new Date(l.expiresAt) < new Date(Date.now() + 7 * 24 * 60 * 60 * 1000)).length, icon: Clock, color: "from-rose-500 to-rose-600" }
                ].map((stat, i) => (
                  <motion.div
                    key={i}
                    initial={{ opacity: 0, scale: 0.9 }}
                    animate={{ opacity: 1, scale: 1 }}
                    transition={{ delay: i * 0.1 }}
                    className="bg-white/5 backdrop-blur-xl border border-white/10 rounded-2xl p-4 hover:bg-white/10 transition-all group"
                  >
                    <div className="flex items-center gap-3">
                      <div className={cn("w-10 h-10 rounded-xl bg-gradient-to-br flex items-center justify-center shadow-lg", stat.color)}>
                        <stat.icon className="w-5 h-5 text-white" />
                      </div>
                      <div>
                        <p className="text-[10px] font-black text-slate-400 tracking-widest uppercase">{stat.label}</p>
                        <p className="text-2xl font-black text-white italic tracking-tighter">{stat.value}</p>
                      </div>
                    </div>
                  </motion.div>
                ))}
              </div>
            </div>
          </div>
        </motion.div>

        {/* Search & Filter Bar */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2 }}
          className="bg-white/5 backdrop-blur-3xl border border-white/10 rounded-2xl p-4 flex flex-col lg:flex-row gap-4"
        >
          <div className="flex-1 relative">
            <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-5 h-5 text-slate-500" />
            <input 
              placeholder="Search listings..."
              className="w-full pl-12 pr-4 h-12 bg-black/40 border border-white/10 rounded-xl text-white font-black italic text-sm tracking-wider focus:outline-none focus:ring-2 focus:ring-blue-500/50 focus:border-transparent transition-all placeholder:text-slate-600"
              value={search}
              onChange={(e) => setSearch(e.target.value)}
            />
          </div>
          <div className="flex gap-3">
            <Select value={filterStatus} onValueChange={setFilterStatus}>
              <SelectTrigger className="w-48 h-12 bg-black/40 border-white/10 rounded-xl text-white font-black italic text-xs tracking-wider focus:ring-2 focus:ring-blue-500/50">
                <SelectValue placeholder="Status" />
              </SelectTrigger>
              <SelectContent className="bg-slate-900 border-white/10 text-white font-black italic">
                <SelectItem value="all">All Status</SelectItem>
                <SelectItem value="ACTIVE">Active</SelectItem>
                <SelectItem value="DRAFT">Draft</SelectItem>
                <SelectItem value="SOLD">Sold</SelectItem>
                <SelectItem value="EXPIRED">Expired</SelectItem>
              </SelectContent>
            </Select>
          </div>
        </motion.div>

        {/* Listings Grid */}
        <div className="grid grid-cols-1 lg:grid-cols-2 xl:grid-cols-3 gap-6">
          {filteredListings.map((listing: Listing, idx: number) => (
            <motion.div
              key={listing.id}
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: idx * 0.05 }}
            >
              <Card className={cn(
                "group relative bg-gradient-to-br from-white/5 to-white/2 backdrop-blur-3xl border border-white/10 rounded-3xl overflow-hidden transition-all duration-500 hover:shadow-2xl hover:shadow-blue-500/10 hover:border-blue-500/30",
                listing.isPromoted && "border-amber-500/30 shadow-amber-500/10"
              )}>
                {/* Promoted Badge */}
                {listing.isPromoted && (
                  <div className="absolute top-4 right-4 z-20">
                    <Badge className="bg-gradient-to-r from-amber-500 to-amber-600 text-white border-none px-4 py-1.5 rounded-full text-[10px] font-black tracking-widest shadow-lg shadow-amber-500/30 flex items-center gap-1.5">
                      <Crown className="w-3.5 h-3.5" /> PROMOTED
                    </Badge>
                  </div>
                )}

                <CardContent className="p-6 space-y-5">
                  {/* Header */}
                  <div className="space-y-3">
                    <div className="flex items-start justify-between gap-3">
                      <div className="flex-1">
                        <div className="flex items-center gap-2 mb-2">
                          <Badge className={cn("px-3 py-1 text-[9px] font-black tracking-widest rounded-full border", getStatusColor(listing.status))}>
                            {listing.status}
                          </Badge>
                        </div>
                        <h3 className="font-black text-lg text-white italic tracking-tight leading-tight group-hover:text-blue-400 transition-colors">
                          {listing.title || listing.property?.name}
                        </h3>
                        <p className="text-slate-500 text-[11px] font-black italic tracking-wider flex items-center gap-1.5 mt-1">
                          <MapPin className="w-3.5 h-3.5" /> {listing.property?.city}, {listing.property?.addressLine1}
                        </p>
                      </div>
                      {listing.price && (
                        <div className="text-right">
                          <p className="text-[9px] font-black text-slate-500 tracking-widest uppercase">Price</p>
                          <span className="text-2xl font-black bg-gradient-to-r from-blue-400 to-purple-400 bg-clip-text text-transparent italic tracking-tighter">
                            ${listing.price.toLocaleString()}
                          </span>
                        </div>
                      )}
                    </div>
                  </div>

                  {/* Tags */}
                  <div className="space-y-2.5">
                    <div className="flex items-center justify-between">
                      <p className="text-[10px] font-black text-slate-500 tracking-widest uppercase flex items-center gap-1.5">
                        <TagIcon className="w-3.5 h-3.5" /> Tags
                      </p>
                      <Button
                        size="sm"
                        variant="ghost"
                        onClick={() => {
                          setSelectedListing(listing);
                          setSelectedTags(getListingTags(listing.id).map((lt: ListingTag) => lt.tagId));
                          setTagDialogOpen(true);
                        }}
                        className="h-8 px-3 text-[10px] font-black italic tracking-wider text-blue-400 hover:text-blue-300 hover:bg-blue-500/10 rounded-xl"
                      >
                        <Plus className="w-3 h-3 mr-1" /> Add
                      </Button>
                    </div>
                    <div className="flex flex-wrap gap-2">
                      {getListingTags(listing.id).map((lt: ListingTag) => (
                        <Badge
                          key={lt.id}
                          variant="outline"
                          className={cn(
                            "px-3 py-1.5 text-[9px] font-black tracking-widest rounded-full border flex items-center gap-1.5 transition-all hover:scale-105",
                            lt.tag?.color ? `border-${lt.tag.color}-500/30 bg-${lt.tag.color}-500/10 text-${lt.tag.color}-400` : "border-white/10 bg-white/5 text-slate-400"
                          )}
                        >
                          {lt.tag?.name}
                          <button
                            onClick={() => handleRemoveTag(lt.id)}
                            className="hover:text-red-400 transition-colors ml-0.5"
                          >
                            <X className="w-3 h-3" />
                          </button>
                        </Badge>
                      ))}
                      {getListingTags(listing.id).length === 0 && (
                        <p className="text-[10px] text-slate-600 font-black italic tracking-wider">No tags yet</p>
                      )}
                    </div>
                  </div>

                  {/* Quick Stats */}
                  <div className="grid grid-cols-3 gap-2">
                    <div className="bg-white/5 rounded-xl p-3 text-center border border-white/5">
                      <Eye className="w-4 h-4 mx-auto mb-1 text-slate-500" />
                      <p className="text-lg font-black text-white italic tracking-tighter">{listing.views || 0}</p>
                      <p className="text-[8px] font-black text-slate-500 tracking-widest uppercase">Views</p>
                    </div>
                    <div className="bg-white/5 rounded-xl p-3 text-center border border-white/5">
                      <MessageSquare className="w-4 h-4 mx-auto mb-1 text-slate-500" />
                      <p className="text-lg font-black text-white italic tracking-tighter">{listing.leads || 0}</p>
                      <p className="text-[8px] font-black text-slate-500 tracking-widest uppercase">Leads</p>
                    </div>
                    <div className="bg-white/5 rounded-xl p-3 text-center border border-white/5">
                      <TrendingUp className="w-4 h-4 mx-auto mb-1 text-slate-500" />
                      <p className="text-lg font-black text-white italic tracking-tighter">{listing.likesCount || 0}</p>
                      <p className="text-[8px] font-black text-slate-500 tracking-widest uppercase">Likes</p>
                    </div>
                  </div>

                  {/* Action Buttons */}
                  <div className="grid grid-cols-3 gap-2">
                    <Button
                      variant="outline"
                      onClick={() => {
                        setSelectedListing(listing);
                        setRenewalDialogOpen(true);
                      }}
                      className="h-11 rounded-xl border-white/10 bg-white/5 hover:bg-white/10 text-white font-black italic text-[10px] tracking-wider gap-2 transition-all hover:scale-105"
                    >
                      <RefreshCw className="w-4 h-4" /> Renew
                    </Button>
                    <Button
                      onClick={() => {
                        setSelectedListing(listing);
                        setPromotionDialogOpen(true);
                      }}
                      className={cn(
                        "h-11 rounded-xl font-black italic text-[10px] tracking-wider gap-2 transition-all hover:scale-105",
                        listing.isPromoted 
                          ? "bg-gradient-to-r from-amber-500 to-amber-600 text-white shadow-lg shadow-amber-500/30" 
                          : "bg-gradient-to-r from-blue-500 to-purple-600 text-white shadow-lg shadow-blue-500/30"
                      )}
                    >
                      {listing.isPromoted ? <Crown className="w-4 h-4" /> : <Zap className="w-4 h-4" />}
                      {listing.isPromoted ? "Boosted" : "Boost"}
                    </Button>
                    <Button
                      variant="outline"
                      onClick={() => navigate(`/listings/${listing.id}`)}
                      className="h-11 rounded-xl border-white/10 bg-white/5 hover:bg-white/10 text-white font-black italic text-[10px] tracking-wider gap-2 transition-all hover:scale-105"
                    >
                      <ArrowUpRight className="w-4 h-4" /> View
                    </Button>
                  </div>

                  {/* Expiry Info */}
                  {listing.expiresAt && (
                    <div className={cn(
                      "flex items-center gap-2 text-[10px] font-black italic tracking-wider px-3 py-2 rounded-xl",
                      new Date(listing.expiresAt) < new Date(Date.now() + 7 * 24 * 60 * 60 * 1000)
                        ? "bg-rose-500/10 text-rose-400 border border-rose-500/20"
                        : "bg-white/5 text-slate-400 border border-white/10"
                    )}>
                      <Clock className="w-3.5 h-3.5" />
                      Expires: {new Date(listing.expiresAt).toLocaleDateString()}
                    </div>
                  )}
                </CardContent>
              </Card>
            </motion.div>
          ))}
        </div>

        {/* Empty State */}
        {filteredListings.length === 0 && !listingsLoading && (
          <motion.div
            initial={{ opacity: 0, scale: 0.9 }}
            animate={{ opacity: 1, scale: 1 }}
            className="text-center py-20"
          >
            <div className="w-24 h-24 mx-auto mb-6 rounded-full bg-white/5 border border-white/10 flex items-center justify-center">
              <Building2 className="w-12 h-12 text-slate-600" />
            </div>
            <h3 className="text-2xl font-black text-white italic tracking-tighter mb-2">No Listings Found</h3>
            <p className="text-slate-500 text-sm font-black italic tracking-wider">
              Try adjusting your search or filters
            </p>
          </motion.div>
        )}
      </div>

      {/* Tag Selection Dialog */}
      <Dialog open={tagDialogOpen} onOpenChange={setTagDialogOpen}>
        <DialogContent className="max-w-lg bg-slate-900/95 border-white/10 text-white rounded-3xl p-0 overflow-hidden backdrop-blur-3xl shadow-2xl">
          <DialogHeader className="p-8 pb-0">
            <DialogTitle className="text-2xl font-black italic tracking-tighter bg-gradient-to-r from-blue-400 to-purple-400 bg-clip-text text-transparent">
              Select Tags
            </DialogTitle>
            <DialogDescription className="text-slate-400 font-black italic tracking-widest text-[10px] pt-4">
              Choose tags to add to this listing
            </DialogDescription>
          </DialogHeader>
          <div className="p-8 space-y-6">
            <div className="flex flex-wrap gap-3">
              {tags.map((tag: Tag) => {
                const isSelected = selectedTags.includes(tag.id);
                const isAlreadyAdded = getListingTags(selectedListing?.id || "").some((lt: ListingTag) => lt.tagId === tag.id);
                return (
                  <button
                    key={tag.id}
                    onClick={() => {
                      if (!isAlreadyAdded) {
                        setSelectedTags(prev => 
                          prev.includes(tag.id) 
                            ? prev.filter(id => id !== tag.id)
                            : [...prev, tag.id]
                        );
                      }
                    }}
                    disabled={isAlreadyAdded}
                    className={cn(
                      "px-4 h-10 rounded-full border font-black italic text-[10px] tracking-widest transition-all flex items-center gap-2",
                      isSelected 
                        ? "bg-gradient-to-r from-blue-500 to-purple-600 text-white border-transparent shadow-lg shadow-blue-500/30" 
                        : isAlreadyAdded
                        ? "bg-slate-500/20 text-slate-500 border-slate-500/20 cursor-not-allowed"
                        : "bg-white/5 border-white/10 text-slate-400 hover:bg-white/10 hover:border-white/20"
                    )}
                  >
                    {isSelected && <Check className="w-3.5 h-3.5" />}
                    {tag.name}
                    {isAlreadyAdded && <span className="text-[8px] ml-1">(added)</span>}
                  </button>
                );
              })}
            </div>
            <DialogFooter className="pt-4">
              <Button
                variant="ghost"
                onClick={() => setTagDialogOpen(false)}
                className="h-12 px-8 text-[10px] font-black italic text-slate-500 hover:text-slate-400"
              >
                Cancel
              </Button>
              <Button
                onClick={handleAddTags}
                disabled={selectedTags.length === 0}
                className="h-12 px-8 rounded-2xl bg-gradient-to-rrom-blue-500 to-purple-600 hover:from-blue-600 hover:to-purple-700 text-white font-black italic text-xs tracking-widest shadow-lg shadow-blue-500/30 transition-all hover:scale-105"
              >
                Add Selected Tags
              </Button>
            </DialogFooter>
          </div>
        </DialogContent>
      </Dialog>

      {/* Promotion Dialog */}
      <Dialog open={promotionDialogOpen} onOpenChange={setPromotionDialogOpen}>
        <DialogContent className="max-w-md bg-slate-900/95 border-white/10 text-white rounded-3xl p-0 overflow-hidden backdrop-blur-3xl shadow-2xl">
          <DialogHeader className="p-8 pb-0">
            <DialogTitle className="text-2xl font-black italic tracking-tighter bg-gradient-to-r from-amber-400 to-orange-400 bg-clip-text text-transparent">
              Boost Your Listing
            </DialogTitle>
            <DialogDescription className="text-slate-400 font-black italic tracking-widest text-[10px] pt-4">
              Choose a promotion tier to increase visibility
            </DialogDescription>
          </DialogHeader>
          <div className="p-8 space-y-6">
            <div className="space-y-4">
              {[
                { tier: 1, days: 7, price: 10, icon: Sparkles, color: "from-blue-500 to-blue-600", label: "Starter" },
                { tier: 2, days: 14, price: 20, icon: Flame, color: "from-purple-500 to-purple-600", label: "Pro" },
                { tier: 3, days: 21, price: 30, icon: Crown, color: "from-amber-500 to-amber-600", label: "Elite" }
              ].map((option) => (
                <button
                  key={option.tier}
                  onClick={() => {
                    if (selectedListing) {
                      promoteMutation.mutate({ 
                        listingId: selectedListing.id, 
                        tier: option.tier,
                        days: option.days 
                      });
                    }
                  }}
                  className="w-full p-5 rounded-2xl border border-white/10 bg-white/5 hover:bg-white/10 hover:border-blue-500/30 transition-all text-left group"
                >
                  <div className="flex items-center justify-between mb-2">
                    <div className="flex items-center gap-3">
                      <div className={cn("w-10 h-10 rounded-xl bg-gradient-to-br flex items-center justify-center shadow-lg", option.color)}>
                        <option.icon className="w-5 h-5 text-white" />
                      </div>
                      <div>
                        <span className="font-black text-white italic tracking-tighter block">
                          Tier {option.tier} - {option.label}
                        </span>
                        <span className="text-[10px] text-slate-500 font-black italic tracking-wider">
                          {option.days} days
                        </span>
                      </div>
                    </div>
                    <span className="font-black bg-gradient-to-r from-blue-400 to-purple-400 bg-clip-text text-transparent italic tracking-tighter text-xl">
                      ${option.price}
                    </span>
                  </div>
                </button>
              ))}
            </div>
            <DialogFooter className="pt-4">
              <Button
                variant="ghost"
                onClick={() => setPromotionDialogOpen(false)}
                className="h-12 px-8 text-[10px] font-black italic text-slate-500 hover:text-slate-400"
              >
                Cancel
              </Button>
            </DialogFooter>
          </div>
        </DialogContent>
      </Dialog>

      {/* Renewal Dialog */}
      <Dialog open={renewalDialogOpen} onOpenChange={setRenewalDialogOpen}>
        <DialogContent className="max-w-md bg-slate-900/95 border-white/10 text-white rounded-3xl p-0 overflow-hidden backdrop-blur-3xl shadow-2xl">
          <DialogHeader className="p-8 pb-0">
            <DialogTitle className="text-2xl font-black italic tracking-tighter bg-gradient-to-r from-emerald-400 to-green-400 bg-clip-text text-transparent">
              Renew Listing
            </DialogTitle>
            <DialogDescription className="text-slate-400 font-black italic tracking-widest text-[10px] pt-4">
              Extend your listing visibility by 30 days
            </DialogDescription>
          </DialogHeader>
          <div className="p-8 space-y-6">
            <div className="p-6 rounded-2xl border border-white/10 bg-gradient-to-brrom-white/5 to-white/2e-y-4">
              <div className="flex items-center justify-between">
                <span className="text-[10px] font-black text-slate-500 tracking-widest uppercase">New Expiry Date</span>
                <span className="font-black text-white italic tracking-tighter">
                  {selectedListing?.expiresAt 
                    ? new Date(new Date(selectedListing.expiresAt).getTime() + 30 * 24 * 60 * 60 * 1000).toLocaleDateString()
                    : new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toLocaleDateString()
                  }
                </span>
              </div>
              <div className="flex items-center justify-between">
                <span className="text-[10px] font-black text-slate-500 tracking-widest uppercase">Cost</span>
                <span className="font-black bg-gradient-to-r from-emerald-400 to-green-400 bg-clip-text text-transparent italic tracking-tighter text-xl">$5.00</span>
              </div>
            </div>
            <DialogFooter className="pt-4">
              <Button
                variant="ghost"
                onClick={() => setRenewalDialogOpen(false)}
                className="h-12 px-8 text-[10px] font-black italic text-slate-500 hover:text-slate-400"
              >
                Cancel
              </Button>
              <Button
                onClick={() => selectedListing && renewMutation.mutate(selectedListing.id)}
                disabled={renewMutation.isPending}
                className="h-12 px-8 rounded-2xl bg-gradient-to-r from-emerald-500 to-green-600 hover:from-emerald-600 hover:to-green-700 text-white font-black italic text-xs tracking-widest shadow-lg shadow-emerald-500/30 transition-all hover:scale-105"
              >
                {renewMutation.isPending ? "Processing..." : "Confirm Renewal"}
              </Button>
            </DialogFooter>
          </div>
        </DialogContent>
      </Dialog>
    </div>
  );
}
