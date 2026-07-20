"use client";

import React, { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Video, Sparkles, Play, CheckCircle2, Instagram, Facebook, Share2 } from "lucide-react";

const MOCK_LISTINGS = [
  { id: "L-4821", address: "1422 Harbor View Dr", price: "$1,250,000", adStatus: "READY", views: 4210 },
  { id: "L-4822", address: "99 Skyline Penthouse", price: "$3,400,000", adStatus: "GENERATING", views: 0 },
  { id: "L-4823", address: "Downtown Studio A", price: "$450,000", adStatus: "NONE", views: 0 },
];

export function AiAdsAutomationCard() {
  const [listings, setListings] = useState(MOCK_LISTINGS);
  const [generatingId, setGeneratingId] = useState<string | null>(null);

  const handleGenerate = (id: string) => {
    setGeneratingId(id);
    setTimeout(() => {
      setListings(prev => prev.map(l => l.id === id ? { ...l, adStatus: "GENERATING" } : l));
      setGeneratingId(null);
      
      // Mock completion
      setTimeout(() => {
        setListings(prev => prev.map(l => l.id === id ? { ...l, adStatus: "READY", views: 124 } : l));
      }, 3000);
    }, 1000);
  };

  return (
    <Card className="bg-slate-900/60 border-slate-800">
      <CardHeader className="flex flex-row items-center justify-between pb-4">
        <div>
          <CardTitle className="text-slate-100 flex items-center gap-2">
            <Sparkles className="h-5 w-5 text-purple-400" />
            AI Video Ads & Meta Engine
          </CardTitle>
          <CardDescription className="text-slate-400">
            Automatically transform listing photos into high-converting Instagram & Facebook Reels.
          </CardDescription>
        </div>
        <div className="flex gap-2">
          <Badge variant="outline" className="bg-blue-500/10 text-blue-400 border-blue-500/20">
            <Facebook className="h-3 w-3 mr-1" /> Connected
          </Badge>
          <Badge variant="outline" className="bg-pink-500/10 text-pink-400 border-pink-500/20">
            <Instagram className="h-3 w-3 mr-1" /> Connected
          </Badge>
        </div>
      </CardHeader>
      <CardContent>
        <Table>
          <TableHeader className="bg-slate-800/30">
            <TableRow className="border-slate-800">
              <TableHead className="text-slate-400">Property</TableHead>
              <TableHead className="text-slate-400">Value</TableHead>
              <TableHead className="text-slate-400">Ad Status</TableHead>
              <TableHead className="text-slate-400">Campaign Reach</TableHead>
              <TableHead className="text-right text-slate-400">Action</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {listings.map(listing => (
              <TableRow key={listing.id} className="border-slate-800 hover:bg-slate-800/20">
                <TableCell className="font-medium text-slate-200">{listing.address}</TableCell>
                <TableCell className="text-slate-300">{listing.price}</TableCell>
                <TableCell>
                  {listing.adStatus === "NONE" && <Badge variant="outline" className="text-slate-500 border-slate-700">No Ads</Badge>}
                  {listing.adStatus === "GENERATING" && (
                    <Badge variant="outline" className="bg-yellow-500/10 text-yellow-500 border-yellow-500/20 animate-pulse flex items-center gap-1 w-max">
                      <Sparkles className="h-3 w-3" /> Rendering GPU...
                    </Badge>
                  )}
                  {listing.adStatus === "READY" && (
                    <Badge variant="outline" className="bg-emerald-500/10 text-emerald-400 border-emerald-500/20 flex items-center gap-1 w-max">
                      <CheckCircle2 className="h-3 w-3" /> Active Campaign
                    </Badge>
                  )}
                </TableCell>
                <TableCell className="text-slate-300">
                  {listing.views > 0 ? (
                    <span className="flex items-center gap-1 text-blue-400">
                      <Share2 className="h-3 w-3" /> {listing.views.toLocaleString()} Impressions
                    </span>
                  ) : "-"}
                </TableCell>
                <TableCell className="text-right">
                  {listing.adStatus === "NONE" && (
                    <Button 
                      size="sm" 
                      className="bg-purple-600 hover:bg-purple-500 text-white"
                      onClick={() => handleGenerate(listing.id)}
                      disabled={generatingId === listing.id}
                    >
                      <Video className="h-4 w-4 mr-2" />
                      Auto-Create Reels
                    </Button>
                  )}
                  {listing.adStatus === "READY" && (
                    <Button size="sm" variant="outline" className="border-slate-700 text-slate-300 hover:text-white">
                      <Play className="h-4 w-4 mr-2" /> View Metrics
                    </Button>
                  )}
                </TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </CardContent>
    </Card>
  );
}
