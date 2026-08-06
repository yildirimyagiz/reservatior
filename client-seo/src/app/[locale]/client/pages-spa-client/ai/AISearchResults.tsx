"use client";

import Image from "next/image";
import { useState, useEffect } from "react";
import { useSearchParams, Link, useNavigate } from "@/lib/react-router-shim";
import { m, AnimatePresence } from "framer-motion";
import {
  Sparkles, MapPin, Zap, ArrowRight, Search, Building, TrendingUp,
  AlertTriangle, ChevronRight, Loader2, CheckCircle2, Brain,
  BarChart3, Shield, ArrowUpRight, Filter, Home, X
} from "lucide-react";
import { useTranslation } from "react-i18next";
import { useAISearchStream, AIStreamStage } from "@/hooks/useAISearchStream";
import { cn } from "@/lib/utils";

const STAGE_CONFIG: Record<string, { label: string; icon: any; color: string }> = {
  "stage:started":    { label: "Analyzing your query...",        icon: Brain,        color: "text-brand" },
  "stage:intent":     { label: "Understanding intent & filters", icon: Filter,       color: "text-brand" },
  "stage:properties": { label: "Searching properties",           icon: Building,     color: "text-success" },
  "stage:analysis":   { label: "AI analysis in progress",        icon: Sparkles,     color: "text-brand" },
  "stage:credits":    { label: "Processing credits",             icon: Zap,          color: "text-amber-400" },
  "stage:complete":   { label: "Results ready!",                 icon: CheckCircle2, color: "text-success" },
  "stage:error":      { label: "Something went wrong",           icon: AlertTriangle,color: "text-red-400" },
};

export default function AISearchResults() {
  const { t } = useTranslation();
  const [searchParams] = useSearchParams();
  const navigate = useNavigate();
  const { streamSearch, state, abort } = useAISearchStream();
  const [searchInput, setSearchInput] = useState("");

  const query = searchParams.get("q") || "";

  // Auto-trigger search when page loads with a query param
  useEffect(() => {
    if (query && !state.isStreaming && !state.completeResult) {
      setSearchInput(query);
      streamSearch(query);
    }
  }, [query]);

  const handleNewSearch = () => {
    if (!searchInput.trim()) return;
    navigate(`/ai-results?q=${encodeURIComponent(searchInput.trim())}`, { replace: true });
    streamSearch(searchInput.trim());
  };

  const completedStages = state.events.map(e => e.stage);

  return (
    <div className="min-h-screen bg-[#0A0A0B] text-white font-sans">
      {/* ───── Top Bar ───── */}
      <header className="sticky top-0 z-50 bg-[#0A0A0B]/80 backdrop-blur-2xl border-b border-white/5">
        <div className="max-w-7xl mx-auto px-6 h-16 flex items-center justify-between">
          <Link to="/" className="flex items-center gap-3 group">
            <div className="w-9 h-9 rounded-xl bg-gradient-to-br from-brand to-brand flex items-center justify-center shadow-lg shadow-indigo-500/20 group-hover:scale-105 transition-transform">
              <Sparkles className="w-4 h-4 text-white" />
            </div>
            <span className="font-bold text-lg tracking-tight text-white/90">Reservatior AI</span>
          </Link>

          <div className="flex items-center gap-3">
            {state.creditsRemaining !== null && (
              <div className="flex items-center gap-1.5 px-3 py-1.5 rounded-full bg-amber-500/10 border border-amber-500/20">
                <Zap className="w-3.5 h-3.5 text-amber-400" />
                <span className="text-xs font-bold text-amber-300">{state.creditsRemaining}</span>
                <span className="text-[10px] text-amber-500/70">credits</span>
              </div>
            )}
            <Link
              to="/property"
              className="px-4 py-2 rounded-xl bg-white/5 hover:bg-white/10 border border-white/5 text-xs font-semibold text-white/60 hover:text-white transition-all"
            >
              Classic Search
            </Link>
            <Link
              to="/ai-search"
              className="px-4 py-2 rounded-xl bg-white/5 hover:bg-white/10 border border-white/5 text-xs font-semibold text-white/60 hover:text-white transition-all"
            >
              AI Chat
            </Link>
          </div>
        </div>
      </header>

      <div className="max-w-7xl mx-auto px-6 py-8">
        {/* ───── Search Bar ───── */}
        <div className="relative group mb-10">
          <div className="absolute -inset-1 bg-gradient-to-r from-brand/20 via-brand/10 to-blue-500/20 rounded-2xl blur-xl opacity-0 group-focus-within:opacity-100 transition-all duration-500" />
          <div className="relative flex items-center bg-white/[0.03] border border-white/10 rounded-2xl overflow-hidden focus-within:border-brand/30 transition-all">
            <Search className="w-5 h-5 text-white/30 ml-5" />
            <input
              aria-label="AI search"
              value={searchInput}
              onChange={(e) => setSearchInput(e.target.value)}
              onKeyDown={(e) => e.key === "Enter" && handleNewSearch()}
              placeholder="Describe what you're looking for..."
              className="flex-1 bg-transparent px-4 py-4 text-white placeholder:text-white/25 text-[15px] font-medium focus:outline-none"
            />
            {state.isStreaming && (
              <button onClick={abort} aria-label="Cancel search" className="mr-2 p-2 rounded-lg hover:bg-white/5 text-white/40">
                <X className="w-4 h-4" />
              </button>
            )}
            <button
              onClick={handleNewSearch}
              disabled={!searchInput.trim() || state.isStreaming}
              className="m-2 px-6 py-2.5 bg-gradient-to-r from-brand to-brand hover:from-brand hover:to-brand disabled:opacity-30 rounded-xl text-sm font-bold transition-all active:scale-95"
            >
              {state.isStreaming ? <Loader2 className="w-4 h-4 animate-spin" /> : "Search"}
            </button>
          </div>
        </div>

        <div className="grid grid-cols-12 gap-8">
          {/* ───── Left: Progress Pipeline ───── */}
          <div className="col-span-3">
            <div className="sticky top-24 space-y-1">
              <p className="text-[10px] font-black tracking-[0.2em] text-white/20 uppercase mb-4">Pipeline</p>
              {Object.entries(STAGE_CONFIG).map(([stage, config]) => {
                const isCompleted = completedStages.includes(stage as AIStreamStage);
                const isCurrent = state.currentStage === stage;
                const Icon = config.icon;

                return (
                  <m.div
                    key={stage}
                    initial={false}
                    animate={{
                      opacity: isCompleted ? 1 : 0.3,
                      x: isCurrent ? 4 : 0
                    }}
                    className={cn(
                      "flex items-center gap-3 px-3 py-2.5 rounded-xl transition-all",
                      isCurrent && "bg-white/5 border border-white/10",
                      isCompleted && !isCurrent && "opacity-70"
                    )}
                  >
                    <div className={cn(
                      "w-7 h-7 rounded-lg flex items-center justify-center flex-shrink-0",
                      isCompleted ? "bg-white/5" : "bg-white/[0.02]"
                    )}>
                      {isCurrent && state.isStreaming ? (
                        <Loader2 className={cn("w-3.5 h-3.5 animate-spin", config.color)} />
                      ) : (
                        <Icon className={cn("w-3.5 h-3.5", isCompleted ? config.color : "text-white/15")} />
                      )}
                    </div>
                    <span className={cn(
                      "text-xs font-semibold",
                      isCompleted ? "text-white/70" : "text-white/20"
                    )}>
                      {config.label}
                    </span>
                    {isCompleted && !isCurrent && (
                      <CheckCircle2 className="w-3 h-3 text-success/50 ml-auto" />
                    )}
                  </m.div>
                );
              })}

              {/* Filters detected */}
              {state.filters && (
                <m.div
                  initial={{ opacity: 0, y: 10 }}
                  animate={{ opacity: 1, y: 0 }}
                  className="mt-6 p-4 rounded-xl bg-white/[0.03] border border-white/5 space-y-3"
                >
                  <p className="text-[10px] font-black tracking-[0.2em] text-white/20 uppercase">Detected Filters</p>
                  {state.filters.location && (
                    <div className="flex items-center gap-2 text-xs text-white/50">
                      <MapPin className="w-3 h-3 text-brand" />
                      <span>{state.filters.location}</span>
                    </div>
                  )}
                  {state.filters.maxPrice && (
                    <div className="flex items-center gap-2 text-xs text-white/50">
                      <TrendingUp className="w-3 h-3 text-success" />
                      <span>Max ${state.filters.maxPrice?.toLocaleString()}</span>
                    </div>
                  )}
                  {state.filters.beds && (
                    <div className="flex items-center gap-2 text-xs text-white/50">
                      <Home className="w-3 h-3 text-brand" />
                      <span>{state.filters.beds}+ bedrooms</span>
                    </div>
                  )}
                  {state.routeUsed && (
                    <div className="mt-2 px-2 py-1 rounded-lg bg-brand/10 border border-brand/20 text-[10px] font-bold text-brand text-center">
                      Route: {state.routeUsed}
                    </div>
                  )}
                </m.div>
              )}

              {/* Market context */}
              {state.marketContext && (
                <m.div
                  initial={{ opacity: 0, y: 10 }}
                  animate={{ opacity: 1, y: 0 }}
                  className="mt-4 p-4 rounded-xl bg-white/[0.03] border border-white/5 space-y-2"
                >
                  <p className="text-[10px] font-black tracking-[0.2em] text-white/20 uppercase flex items-center gap-2">
                    <BarChart3 className="w-3 h-3" /> Market Intel
                  </p>
                  <div className="text-xs text-white/40">
                    Signal: <span className="text-white/70 font-semibold">{state.marketContext.signal}</span>
                  </div>
                  {state.marketContext.pricingPressure && (
                    <div className="text-xs text-white/40">
                      Pressure: <span className="text-white/70 font-semibold">{state.marketContext.pricingPressure}</span>
                    </div>
                  )}
                </m.div>
              )}
            </div>
          </div>

          {/* ───── Right: Results ───── */}
          <div className="col-span-9 space-y-8">
            {/* Properties Grid */}
            <AnimatePresence mode="wait">
              {state.properties.length > 0 && (
                <m.div
                  initial={{ opacity: 0, y: 20 }}
                  animate={{ opacity: 1, y: 0 }}
                  className="space-y-4"
                >
                  <div className="flex items-center justify-between">
                    <h2 className="text-sm font-black tracking-[0.15em] text-white/30 uppercase">
                      {state.properties.length} Properties Found
                    </h2>
                    <Link
                      to={`/properties${state.filters?.location ? `?search=${state.filters.location}` : ""}`}
                      className="flex items-center gap-1 text-xs font-semibold text-brand hover:text-brand transition-colors"
                    >
                      View in Classic Search <ArrowUpRight className="w-3 h-3" />
                    </Link>
                  </div>

                  <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-5">
                    {state.properties.map((prop, idx) => (
                      <m.div
                        key={prop.id}
                        initial={{ opacity: 0, y: 20, scale: 0.97 }}
                        animate={{ opacity: 1, y: 0, scale: 1 }}
                        transition={{ delay: idx * 0.08 }}
                        className="group relative bg-white/[0.03] border border-white/5 rounded-2xl overflow-hidden hover:border-brand/20 hover:bg-white/[0.05] transition-all cursor-pointer"
                        onClick={() => navigate(`/property/${prop.id}`)}
                      >
                        {/* Image */}
                        <div className="h-44 overflow-hidden relative">
                          <Image
                            src={prop.image || "https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=600"}
                            alt={prop.title}
                            fill
                            loading="lazy"
                            className="object-cover group-hover:scale-105 transition-transform duration-700"
                            sizes="600px"
                          />
                          <div className="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent" />
                          <div className="absolute bottom-3 left-3 px-3 py-1 bg-black/40 backdrop-blur-md rounded-lg text-white text-sm font-bold border border-white/10">
                            {prop.price}
                          </div>
                          {state.isDowngraded && (
                            <div className="absolute top-3 right-3 px-2 py-0.5 bg-amber-500/20 border border-amber-500/30 rounded-full text-[9px] font-bold text-amber-300">
                              Optimized
                            </div>
                          )}
                        </div>

                        {/* Content */}
                        <div className="p-4 space-y-2">
                          <h3 className="font-bold text-white/90 truncate group-hover:text-brand transition-colors">
                            {prop.title}
                          </h3>
                          <div className="flex items-center gap-1.5 text-white/40 text-xs">
                            <MapPin className="w-3 h-3 text-brand" />
                            <span>{prop.location}</span>
                          </div>
                          {prop.summary && (
                            <p className="text-xs text-white/30 line-clamp-2 mt-2">{prop.summary}</p>
                          )}
                          <div className="flex items-center justify-between mt-3 pt-3 border-t border-white/5">
                            <div className="flex items-center gap-1 text-[10px] text-white/20">
                              <Shield className="w-3 h-3" /> Verified
                            </div>
                            <div className="w-7 h-7 rounded-full bg-brand/10 flex items-center justify-center group-hover:bg-brand/100 transition-colors">
                              <ArrowRight className="w-3 h-3 text-brand group-hover:text-white" />
                            </div>
                          </div>
                        </div>
                      </m.div>
                    ))}
                  </div>
                </m.div>
              )}
            </AnimatePresence>

            {/* AI Analysis Text */}
            <AnimatePresence>
              {state.analysisText && (
                <m.div
                  initial={{ opacity: 0, y: 15 }}
                  animate={{ opacity: 1, y: 0 }}
                  className="relative p-6 rounded-2xl bg-gradient-to-br from-brand/5 to-brand/5 border border-brand/10"
                >
                  <div className="absolute top-4 right-4">
                    <Sparkles className="w-5 h-5 text-brand/30" />
                  </div>
                  <h3 className="text-sm font-black tracking-[0.15em] text-white/30 uppercase mb-4 flex items-center gap-2">
                    <Brain className="w-4 h-4 text-brand" /> AI Analysis
                  </h3>
                  <p className="text-sm text-white/70 leading-relaxed whitespace-pre-wrap font-medium">
                    {state.analysisText}
                  </p>
                  {state.costCharged > 0 && (
                    <div className="mt-4 flex items-center gap-2 text-[10px] text-white/20">
                      <Zap className="w-3 h-3 text-amber-400" />
                      This analysis cost {state.costCharged} credits
                    </div>
                  )}
                </m.div>
              )}
            </AnimatePresence>

            {/* Upsell Banner */}
            <AnimatePresence>
              {state.isUpsellTriggered && state.upsellMessage && (
                <m.div
                  initial={{ opacity: 0, scale: 0.95 }}
                  animate={{ opacity: 1, scale: 1 }}
                  className="p-6 rounded-2xl bg-gradient-to-r from-amber-500/10 to-orange-500/10 border border-amber-500/20"
                >
                  <div className="flex items-start gap-4">
                    <div className="w-10 h-10 rounded-xl bg-amber-500/20 flex items-center justify-center flex-shrink-0">
                      <TrendingUp className="w-5 h-5 text-amber-400" />
                    </div>
                    <div className="flex-1">
                      <p className="text-sm text-white/80 font-medium">{state.upsellMessage}</p>
                      <button className="mt-3 px-5 py-2 bg-gradient-to-r from-amber-500 to-orange-500 rounded-xl text-sm font-bold text-white shadow-lg shadow-amber-500/20 hover:shadow-xl transition-all active:scale-95">
                        Upgrade Now
                      </button>
                    </div>
                  </div>
                </m.div>
              )}
            </AnimatePresence>

            {/* Error State */}
            {state.error && (
              <m.div
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
                className="p-6 rounded-2xl bg-red-500/5 border border-red-500/20 flex items-center gap-4"
              >
                <AlertTriangle className="w-5 h-5 text-red-400" />
                <p className="text-sm text-red-300/80">{state.error}</p>
              </m.div>
            )}

            {/* Empty State (no query yet) */}
            {!query && !state.isStreaming && state.properties.length === 0 && (
              <div className="flex flex-col items-center justify-center py-32 text-center space-y-6">
                <div className="w-16 h-16 rounded-2xl bg-white/[0.03] border border-white/5 flex items-center justify-center">
                  <Search className="w-7 h-7 text-white/10" />
                </div>
                <div className="space-y-2">
                  <h2 className="text-xl font-bold text-white/20">Search with AI</h2>
                  <p className="text-sm text-white/10 max-w-md">
                    Describe what you&apos;re looking for in natural language and watch the AI analyze properties in real-time.
                  </p>
                </div>
                <div className="flex flex-wrap gap-2 justify-center max-w-lg">
                  {[
                    "2 bedroom apartment in Istanbul under $50,000",
                    "High ROI studio in Dubai",
                    "Seaside villa in Bodrum",
                    "3+1 apartment with pool"
                  ].map((suggestion) => (
                    <button
                      key={suggestion}
                      onClick={() => {
                        setSearchInput(suggestion);
                        navigate(`/ai-results?q=${encodeURIComponent(suggestion)}`, { replace: true });
                        streamSearch(suggestion);
                      }}
                      className="px-4 py-2 bg-white/[0.03] hover:bg-white/[0.06] border border-white/5 rounded-xl text-xs text-white/30 hover:text-white/60 transition-all"
                    >
                      {suggestion}
                    </button>
                  ))}
                </div>
              </div>
            )}
          </div>
        </div>
      </div>
    </div>
  );
}
