"use client";

import { useState } from "react";
import { useTranslation } from "react-i18next";
import { useQuery } from "@tanstack/react-query";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { useToast } from "@/hooks/use-toast";
import { 
  Network, 
  Users, 
  DollarSign, 
  Copy, 
  CheckCircle2, 
  TrendingUp,
  Share2,
  Award
} from "lucide-react";

// Mock API Call - replace with real endpoint
const fetchReferralNetwork = async () => {
  const res = await fetch("/api/referrals/network", {
    headers: {
      Authorization: `Bearer ${localStorage.getItem("token")}`
    }
  });
  if (!res.ok) throw new Error("Failed to fetch referral network");
  return res.json();
};

export default function ReferralNetwork() {
  const { t } = useTranslation();
  const { toast } = useToast();
  const [copied, setCopied] = useState(false);

  const { data, isLoading } = useQuery({
    queryKey: ['referral-network'],
    queryFn: fetchReferralNetwork
  });

  const referralData = data?.data || {
    referralCode: "AGENT-2026-X",
    totalEarnings: 0,
    totalReferrals: 0,
    successfulReferrals: 0,
    network: []
  };

  const handleCopy = () => {
    navigator.clipboard.writeText(referralData.referralCode);
    setCopied(true);
    toast({
      title: "Copied!",
      description: "Referral code copied to clipboard",
    });
    setTimeout(() => setCopied(false), 2000);
  };

  const handleShare = () => {
    if (navigator.share) {
      navigator.share({
        title: 'Join Reservatior',
        text: `Join my real estate network using code: ${referralData.referralCode}`,
        url: 'https://reservatior.com/register',
      });
    } else {
      handleCopy();
    }
  };

  return (
    <div className="p-8 space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold text-gray-900 flex items-center gap-2">
            <Network className="w-6 h-6 text-indigo-600" />
            {t("client.src.referral_network", "Referral Network")}
          </h1>
          <p className="text-gray-600 mt-1">
            {t("client.src.manage_referrals_desc", "Grow your network and earn passive income from referred agents")}
          </p>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
        <Card className="bg-gradient-to-br from-indigo-500 to-purple-600 text-white border-0 shadow-lg relative overflow-hidden">
          <div className="absolute top-0 right-0 p-4 opacity-20">
            <Award className="w-24 h-24" />
          </div>
          <CardHeader className="pb-2 relative z-10">
            <CardTitle className="text-lg font-medium text-indigo-50">Your Referral Code</CardTitle>
          </CardHeader>
          <CardContent className="relative z-10">
            <div className="flex items-center gap-2 mt-2">
              <div className="bg-white/20 backdrop-blur-sm px-4 py-2 rounded-lg font-mono text-xl tracking-wider font-bold flex-1 text-center">
                {referralData.referralCode}
              </div>
            </div>
            <div className="flex gap-2 mt-4">
              <Button onClick={handleCopy} variant="secondary" className="flex-1 bg-white text-indigo-700 hover:bg-indigo-50">
                {copied ? <CheckCircle2 className="w-4 h-4 mr-2" /> : <Copy className="w-4 h-4 mr-2" />}
                {copied ? "Copied" : "Copy"}
              </Button>
              <Button onClick={handleShare} variant="secondary" className="flex-1 bg-white text-indigo-700 hover:bg-indigo-50">
                <Share2 className="w-4 h-4 mr-2" /> Share
              </Button>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-sm font-medium text-gray-500 flex items-center">
              <DollarSign className="w-4 h-4 mr-2 text-green-500" />
              Passive Income
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold text-gray-900">${Number(referralData.totalEarnings).toLocaleString()}</div>
            <p className="text-xs text-green-600 mt-1 flex items-center">
              <TrendingUp className="w-3 h-3 mr-1" /> +0% this month
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-sm font-medium text-gray-500 flex items-center">
              <Users className="w-4 h-4 mr-2 text-blue-500" />
              Total Network
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold text-gray-900">{referralData.totalReferrals}</div>
            <p className="text-xs text-gray-500 mt-1">Invited agents</p>
          </CardContent>
        </Card>
        
        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-sm font-medium text-gray-500 flex items-center">
              <CheckCircle2 className="w-4 h-4 mr-2 text-indigo-500" />
              Active Agents
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold text-gray-900">{referralData.successfulReferrals}</div>
            <p className="text-xs text-gray-500 mt-1">Generating revenue</p>
          </CardContent>
        </Card>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>My Network</CardTitle>
          <CardDescription>Agents who joined using your referral code</CardDescription>
        </CardHeader>
        <CardContent>
          {isLoading ? (
            <div className="flex justify-center p-8">
              <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-indigo-600"></div>
            </div>
          ) : referralData.network.length === 0 ? (
            <div className="text-center py-12">
              <Users className="w-12 h-12 text-gray-300 mx-auto mb-4" />
              <h3 className="text-lg font-medium text-gray-900">Your network is empty</h3>
              <p className="text-gray-500 mt-2">Share your code with other agents to start earning 5% passive income from their deals.</p>
              <Button onClick={handleShare} className="mt-4">
                <Share2 className="w-4 h-4 mr-2" /> Invite Agents
              </Button>
            </div>
          ) : (
            <div className="space-y-4">
              {referralData.network.map((user: any) => (
                <div key={user.id} className="flex items-center justify-between p-4 border rounded-lg hover:bg-gray-50 transition-colors">
                  <div className="flex items-center gap-4">
                    <div className="w-10 h-10 rounded-full bg-indigo-100 flex items-center justify-center text-indigo-700 font-bold">
                      {user.name ? user.name.charAt(0) : user.email.charAt(0)}
                    </div>
                    <div>
                      <p className="font-medium text-gray-900">{user.name || "Unknown Agent"}</p>
                      <p className="text-sm text-gray-500">{user.email}</p>
                    </div>
                  </div>
                  <div className="text-right">
                    <Badge variant="outline" className="bg-green-50 text-green-700 border-green-200">Active</Badge>
                    <p className="text-xs text-gray-500 mt-1">Joined {new Date(user.createdAt).toLocaleDateString()}</p>
                  </div>
                </div>
              ))}
            </div>
          )}
        </CardContent>
      </Card>
    </div>
  );
}
