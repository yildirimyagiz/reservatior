"use client";

import { Badge } from "@/components/ui/badge";
import { Sparkles, TrendingDown, Zap, Clock, CheckCircle } from "lucide-react";

interface ListingBadgesProps {
  isOptimizedForSpeed?: boolean;
  optimizationStatus?: string;
  vacancyDays?: number;
  isPromoted?: boolean;
  className?: string;
}

export function ListingBadges({
  isOptimizedForSpeed,
  optimizationStatus,
  vacancyDays,
  isPromoted,
  className = "",
}: ListingBadgesProps) {
  const badges: { label: string; icon: React.ReactNode; className: string }[] = [];

  if (optimizationStatus === "ACTIVE" || isOptimizedForSpeed) {
    badges.push({
      label: "Fast Rental",
      icon: <Zap className="w-3 h-3" />,
      className: "bg-emerald-500/20 text-emerald-400 border-emerald-500/30",
    });
    badges.push({
      label: "Optimized Price",
      icon: <TrendingDown className="w-3 h-3" />,
      className: "bg-blue-500/20 text-blue-400 border-blue-500/30",
    });
  }

  if (optimizationStatus === "SUGGESTED") {
    badges.push({
      label: "AI Recommended",
      icon: <Sparkles className="w-3 h-3" />,
      className: "bg-purple-500/20 text-purple-400 border-purple-500/30",
    });
  }

  if (vacancyDays && vacancyDays > 30 && (optimizationStatus === "ACTIVE" || isOptimizedForSpeed)) {
    badges.push({
      label: "Reduced Vacancy",
      icon: <Clock className="w-3 h-3" />,
      className: "bg-amber-500/20 text-amber-400 border-amber-500/30",
    });
  }

  if (isPromoted) {
    badges.push({
      label: "Boosted",
      icon: <CheckCircle className="w-3 h-3" />,
      className: "bg-rose-500/20 text-rose-400 border-rose-500/30",
    });
  }

  if (badges.length === 0) return null;

  return (
    <div className={`flex flex-wrap gap-1.5 ${className}`}>
      {badges.map((badge, i) => (
        <span
          key={i}
          className={`inline-flex items-center gap-1 px-2 py-0.5 rounded-full text-[10px] font-semibold border ${badge.className}`}
        >
          {badge.icon}
          {badge.label}
        </span>
      ))}
    </div>
  );
}
