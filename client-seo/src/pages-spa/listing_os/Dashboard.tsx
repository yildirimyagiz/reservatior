"use client";

import React from "react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Home, Key, CheckCircle, Activity } from "lucide-react";
import { useQuery } from "@tanstack/react-query";
import { listingOSApi } from "@/lib/api/listing-os";
import { useAuth } from "@/lib/auth";

export default function ListingDashboard() {
  const { user } = useAuth();
  
  const { data: statsData, isLoading } = useQuery({
    queryKey: ["listing-os-dashboard", user?.orgId],
    queryFn: () => listingOSApi.getDashboardStats(user?.orgId || ""),
    enabled: !!user?.orgId,
  });

  const stats = statsData?.data || {
    totalProperties: 0,
    activeListings: 0,
    totalViews: 0,
    averageQualityScore: 0,
  };

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-3xl font-bold tracking-tight text-slate-100 dark:text-slate-100">Listing OS Dashboard</h1>
        <p className="text-slate-500 dark:text-muted-foreground">Digital Health Record & Asset Management</p>
      </div>
      
      <div className="grid gap-4 md:grid-cols-4">
        <Card className="bg-white dark:bg-slate-900/50 border-slate-200 dark:border-slate-800">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-slate-500 dark:text-slate-400">Total Properties</CardTitle>
            <Home className="h-4 w-4 text-emerald-500" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-slate-900 dark:text-slate-100">
              {isLoading ? "..." : stats.totalProperties}
            </div>
            <p className="text-xs text-slate-500 mt-1">Under management</p>
          </CardContent>
        </Card>

        <Card className="bg-white dark:bg-slate-900/50 border-slate-200 dark:border-slate-800">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-slate-500 dark:text-slate-400">Active Listings</CardTitle>
            <Activity className="h-4 w-4 text-blue-500" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-slate-900 dark:text-slate-100">
              {isLoading ? "..." : stats.activeListings}
            </div>
            <p className="text-xs text-slate-500 mt-1">Live on portals</p>
          </CardContent>
        </Card>

        <Card className="bg-white dark:bg-slate-900/50 border-slate-200 dark:border-slate-800">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-slate-500 dark:text-slate-400">Average Quality</CardTitle>
            <CheckCircle className="h-4 w-4 text-purple-500" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-slate-900 dark:text-slate-100">
              {isLoading ? "..." : `${stats.averageQualityScore}%`}
            </div>
            <p className="text-xs text-emerald-500 mt-1">Cleaning compliance</p>
          </CardContent>
        </Card>
        
        <Card className="bg-white dark:bg-slate-900/50 border-slate-200 dark:border-slate-800">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-slate-500 dark:text-slate-400">Network Views</CardTitle>
            <Key className="h-4 w-4 text-orange-500" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-slate-900 dark:text-slate-100">
              {isLoading ? "..." : stats.totalViews}
            </div>
            <p className="text-xs text-slate-500 mt-1">Last 30 days</p>
          </CardContent>
        </Card>
      </div>

      <div className="grid gap-4 md:grid-cols-2">
        <Card className="bg-white dark:bg-slate-900/50 border-slate-200 dark:border-slate-800">
          <CardHeader>
            <CardTitle className="text-slate-900 dark:text-slate-100">Health Record Stream</CardTitle>
            <CardDescription className="text-slate-500 dark:text-slate-400">Recent compliance checks and property states.</CardDescription>
          </CardHeader>
          <CardContent>
             <div className="text-center text-slate-500 py-8 text-sm">Health streaming service will mount here.</div>
          </CardContent>
        </Card>
        
        <Card className="bg-white dark:bg-slate-900/50 border-slate-200 dark:border-slate-800">
          <CardHeader>
            <CardTitle className="text-slate-900 dark:text-slate-100">Syndication Status</CardTitle>
            <CardDescription className="text-slate-500 dark:text-slate-400">Status across MLS and global OTAs.</CardDescription>
          </CardHeader>
          <CardContent>
            <div className="text-center text-slate-500 py-8 text-sm">Syndication pipeline monitoring will mount here.</div>
          </CardContent>
        </Card>
      </div>
    </div>
  );
}
