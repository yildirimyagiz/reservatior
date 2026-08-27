import React from "react";
import { Card, CardContent } from "@/components/ui/card";
import { Skeleton } from "@/components/ui/skeleton";

export interface PropertyCardSkeletonProps {
  viewMode?: "grid" | "list";
}

export function PropertyCardSkeleton({ viewMode = "grid" }: PropertyCardSkeletonProps) {
  if (viewMode === "list") {
    return (
      <Card className="bg-background/40 border-slate-200 dark:border-white/5 rounded-2xl overflow-hidden flex flex-row h-48 pointer-events-none">
        <Skeleton className="w-1/3 h-full rounded-none" />
        <CardContent className="p-5 flex-1 flex flex-col justify-between">
          <div>
            <div className="flex justify-between items-start mb-2">
              <Skeleton className="h-6 w-2/3" />
              <div className="flex flex-col items-end gap-1">
                <Skeleton className="h-3 w-16" />
                <Skeleton className="h-6 w-24" />
              </div>
            </div>
            <Skeleton className="h-4 w-1/2 mb-4" />
            <Skeleton className="h-8 w-3/4 mb-4" />
            <div className="flex gap-2">
              <Skeleton className="h-6 w-16" />
              <Skeleton className="h-6 w-16" />
              <Skeleton className="h-6 w-16" />
            </div>
          </div>
          <div className="flex justify-end mt-2">
            <Skeleton className="h-8 w-24 rounded-xl" />
          </div>
        </CardContent>
      </Card>
    );
  }

  // Grid view skeleton
  return (
    <Card className="bg-background/40 border-slate-200 dark:border-white/5 rounded-2xl overflow-hidden flex flex-col h-full pointer-events-none">
      <Skeleton className="h-56 w-full rounded-none" />
      <CardContent className="p-5 flex-1 flex flex-col">
        <Skeleton className="h-6 w-3/4 mb-2" />
        <Skeleton className="h-4 w-1/2 mb-4" />
        <Skeleton className="h-10 w-full mb-5" />
        <div className="flex flex-wrap gap-2 mb-4 flex-1">
          <Skeleton className="h-5 w-16" />
          <Skeleton className="h-5 w-20" />
          <Skeleton className="h-5 w-16" />
        </div>
        <div className="flex items-center justify-between mt-auto">
          <div className="flex flex-col gap-1">
            <Skeleton className="h-3 w-12" />
            <Skeleton className="h-6 w-24" />
          </div>
          <Skeleton className="h-8 w-20 rounded-xl" />
        </div>
      </CardContent>
    </Card>
  );
}
