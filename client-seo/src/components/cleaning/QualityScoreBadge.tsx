"use client";

import { cn } from "@/lib/utils";

interface QualityScoreBadgeProps {
  score: number;
  size?: "sm" | "md" | "lg";
  showLabel?: boolean;
  className?: string;
}

const scoreColor = (score: number) => {
  if (score >= 90) return "bg-blue-500/20 text-blue-400 border-blue-500/30";
  if (score >= 75) return "bg-amber-500/20 text-amber-400 border-amber-500/30";
  if (score >= 50) return "bg-orange-500/20 text-orange-400 border-orange-500/30";
  return "bg-red-500/20 text-red-400 border-red-500/30";
};

const scoreLabel = (score: number) => {
  if (score >= 90) return "Premium";
  if (score >= 75) return "Good";
  if (score >= 50) return "Fair";
  return "Needs Attention";
};

export function QualityScoreBadge({ score, size = "md", showLabel = true, className }: QualityScoreBadgeProps) {
  return (
    <div
      className={cn(
        "inline-flex items-center gap-1.5 rounded-full border px-2.5 py-0.5 font-medium",
        scoreColor(score),
        size === "sm" && "text-[10px] px-2 py-0",
        size === "md" && "text-xs",
        size === "lg" && "text-sm px-3 py-1",
        className
      )}
      title={`Cleaning Standard Score: ${score}/100`}
    >
      <span className="relative flex h-1.5 w-1.5">
        <span className={cn(
          "absolute inline-flex h-full w-full animate-ping rounded-full opacity-75",
          score >= 90 ? "bg-blue-400" : score >= 75 ? "bg-amber-400" : "bg-red-400"
        )} />
        <span className={cn(
          "relative inline-flex h-1.5 w-1.5 rounded-full",
          score >= 90 ? "bg-blue-500" : score >= 75 ? "bg-amber-500" : "bg-red-500"
        )} />
      </span>
      <span>{score}/100</span>
      {showLabel && <span className="opacity-70 hidden sm:inline">{scoreLabel(score)}</span>}
    </div>
  );
}

export function QualityScoreBadgeSkeleton() {
  return (
    <div className="inline-flex h-5 w-24 animate-pulse rounded-full bg-slate-800" />
  );
}
