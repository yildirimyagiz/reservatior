"use client";

import { useState } from "react";
import { useNavigate } from "@/lib/react-router-shim";
import { m, AnimatePresence } from "framer-motion";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Building2, Sparkles, Zap, ChevronRight, Share2, CheckCircle2, TrendingUp, Trophy, ArrowRight, ShieldCheck } from "lucide-react";
import Image from "next/image";
import { toast } from "sonner";

export default function InmanConnect() {
  const navigate = useNavigate();
  const [listingUrl, setListingUrl] = useState("");
  const [isAnalyzing, setIsAnalyzing] = useState(false);
  const [analysisStep, setAnalysisStep] = useState(0);
  const [showResult, setShowResult] = useState(false);

  const mockSteps = [
    "Fetching listing data from StreetEasy / Zillow...",
    "AI analyzing room layout, furniture fit, and lighting...",
    "Rendering AI Virtual Staging layer...",
    "Rewriting conversion-focused listing description and title...",
    "Calculating listing quality score (Current: 61/100)..."
  ];

  const handleAnalyze = (e: React.FormEvent) => {
    e.preventDefault();
    if (!listingUrl.trim()) {
      toast.error("Please paste a valid listing link!");
      return;
    }

    setIsAnalyzing(true);
    setAnalysisStep(0);
    setShowResult(false);

    // Simulated progress steps
    const interval = setInterval(() => {
      setAnalysisStep((prev) => {
        if (prev >= mockSteps.length - 1) {
          clearInterval(interval);
          setTimeout(() => {
            setIsAnalyzing(false);
            setShowResult(true);
            toast.success("Listing successfully optimized!");
          }, 800);
          return prev;
        }
        return prev + 1;
      });
    }, 1200);
  };

  const handleJoinPilot = () => {
    navigate("/auth/signup?promo=ICNY27&type=CORPORATE");
  };

  return (
    <div className="min-h-screen bg-[#0a0a0c] text-white font-sans selection:bg-blue-500/30 overflow-x-hidden">
      
      {/* Background decoration */}
      <div className="absolute top-0 left-1/2 -translate-x-1/2 w-full max-w-7xl h-[600px] bg-gradient-to-b from-blue-500/10 via-indigo-500/5 to-transparent blur-3xl pointer-events-none -z-10" />

      {/* Top Banner for Event Mention */}
      <div className="bg-gradient-to-r from-blue-900/30 via-indigo-900/30 to-purple-900/30 border-b border-[#24262f] py-3 px-4 text-center text-xs sm:text-sm font-semibold tracking-wide">
        🚀 <span className="text-blue-400 font-bold">#ICNY27 Exclusive:</span> Guerrilla AI Listing & Lease Acceleration Sandbox for Inman Connect New York 2027 Attendees
      </div>

      <div className="max-w-6xl mx-auto px-4 py-12 sm:py-20">
        
        {/* Header */}
        <div className="text-center max-w-3xl mx-auto mb-16 sm:mb-24">
          <m.div
            initial={{ opacity: 0, y: -20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6 }}
            className="inline-flex items-center gap-2 px-4 py-1.5 rounded-full bg-[#14151a] border border-[#24262f] text-slate-400 text-xs sm:text-sm mb-6"
          >
            <Sparkles className="w-4 h-4 text-yellow-400 animate-pulse" />
            <span>We didn&apos;t open a physical booth because we already optimized your listings!</span>
          </m.div>
          
          <m.h1
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6, delay: 0.1 }}
            className="text-4xl sm:text-6xl font-black tracking-tight leading-none bg-gradient-to-r from-white via-slate-200 to-slate-400 bg-clip-text text-transparent mb-6"
          >
            Zero Days Vacant.<br />Zero Upfront Commission.
          </m.h1>

          <m.p
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6, delay: 0.2 }}
            className="text-slate-400 text-base sm:text-xl leading-relaxed"
          >
            Paste your StreetEasy or Zillow listing link. Instantly see how AI virtual stages your photo (AI Staging), optimizes your description copy, and how **LeaseCare+** spreads the 3-month upfront commission hurdle into a transparent 3.5% monthly model.
          </m.p>
        </div>

        {/* Action Sandbox */}
        <m.div
          initial={{ opacity: 0, scale: 0.95 }}
          animate={{ opacity: 1, scale: 1 }}
          transition={{ duration: 0.5, delay: 0.3 }}
          className="bg-[#14151a] border border-[#24262f] rounded-3xl p-6 sm:p-10 shadow-2xl relative mb-16 overflow-hidden"
        >
          <div className="absolute top-0 left-0 right-0 h-1 bg-gradient-to-r from-blue-500 to-indigo-500" />

          <h3 className="text-xl sm:text-2xl font-bold mb-4 flex items-center gap-2">
            <Sparkles className="text-blue-500 w-6 h-6" />
            Try the AI Listing Sandbox
          </h3>
          <p className="text-slate-400 text-sm mb-6">
            e.g. Paste your StreetEasy, Zillow, Realtor.com, or local listing link here.
          </p>

          <form onSubmit={handleAnalyze} className="flex flex-col sm:flex-row gap-4 mb-8">
            <Input
              value={listingUrl}
              onChange={(e) => setListingUrl(e.target.value)}
              placeholder="https://www.streeteasy.com/building/manhattan-loft/rent..."
              className="bg-[#0a0a0c] border-[#24262f] hover:border-slate-700 focus:border-blue-500 h-14 text-slate-200 placeholder:text-slate-600 rounded-xl flex-1 text-base"
              disabled={isAnalyzing}
            />
            <Button
              type="submit"
              className="h-14 px-8 bg-gradient-to-r from-blue-600 to-indigo-600 hover:from-blue-500 hover:to-indigo-500 text-white font-bold rounded-xl transition-all shadow-lg shadow-blue-500/20 shrink-0"
              disabled={isAnalyzing}
            >
              {isAnalyzing ? "Analyzing..." : "Optimize & Stage"}
            </Button>
          </form>

          {/* Loader Simulation */}
          <AnimatePresence>
            {isAnalyzing && (
              <m.div
                initial={{ opacity: 0, height: 0 }}
                animate={{ opacity: 1, height: "auto" }}
                exit={{ opacity: 0, height: 0 }}
                className="space-y-4 p-5 rounded-2xl bg-[#0a0a0c] border border-[#24262f]"
              >
                <div className="flex items-center gap-3">
                  <div className="w-5 h-5 rounded-full border-2 border-blue-500 border-t-transparent animate-spin" />
                  <span className="text-sm font-semibold text-slate-300">
                    {mockSteps[analysisStep]}
                  </span>
                </div>
                <div className="w-full bg-[#14151a] h-2 rounded-full overflow-hidden">
                  <m.div
                    className="bg-blue-500 h-full"
                    initial={{ width: "0%" }}
                    animate={{ width: `${((analysisStep + 1) / mockSteps.length) * 100}%` }}
                    transition={{ duration: 1 }}
                  />
                </div>
              </m.div>
            )}
          </AnimatePresence>

          {/* Results Simulation */}
          <AnimatePresence>
            {showResult && (
              <m.div
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                className="space-y-8 mt-4 pt-4 border-t border-[#24262f]"
              >
                {/* Visual before/after mock */}
                <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                  <div className="relative h-64 rounded-2xl overflow-hidden border border-[#24262f] bg-[#0a0a0c]">
                    <span className="absolute top-4 left-4 bg-red-500/80 text-white text-xs font-bold px-3 py-1 rounded-full uppercase tracking-wider">Current Listing (Before)</span>
                    <Image src="https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&w=600&q=80" alt="Before Staging" fill className="object-cover opacity-50 grayscale" loading="lazy" sizes="(max-width: 768px) 100vw, 50vw" />
                    <div className="p-4">
                      <h4 className="font-bold text-slate-400">Traditional Listing Copy & Photo</h4>
                      <p className="text-slate-500 text-xs mt-1">Standard empty spacious room, cold lighting, poor description copy.</p>
                      <div className="mt-3 flex items-center gap-2">
                        <span className="text-xs text-red-400 font-bold">Listing Score: 61/100</span>
                      </div>
                    </div>
                  </div>

                  <div className="relative h-64 rounded-2xl overflow-hidden border border-blue-500/30 bg-[#0a0a0c] shadow-xl shadow-blue-500/5">
                    <span className="absolute top-4 left-4 bg-blue-500/80 text-white text-xs font-bold px-3 py-1 rounded-full uppercase tracking-wider flex items-center gap-1">
                      <Sparkles className="w-3 h-3" /> AI Staged & Optimized (After)
                    </span>
                    <Image src="https://images.unsplash.com/photo-1524758631624-e2822e304c36?auto=format&fit=crop&w=600&q=80" alt="After Staging" fill className="object-cover" loading="lazy" sizes="(max-width: 768px) 100vw, 50vw" />
                    <div className="p-4 bg-gradient-to-b from-transparent to-blue-500/5">
                      <h4 className="font-bold text-white flex items-center gap-1.5">
                        Modern Premium Loft Manhattan
                        <Sparkles className="w-4 h-4 text-yellow-400" />
                      </h4>
                      <p className="text-slate-300 text-xs mt-1">Virtually staged Nordic furniture, optimized warm lighting, and a high-conversion storytelling copy.</p>
                      <div className="mt-3 flex items-center justify-between">
                        <span className="text-xs text-blue-400 font-bold flex items-center gap-1">
                          <CheckCircle2 className="w-3.5 h-3.5" /> Listing Score: 98/100
                        </span>
                        <span className="text-xs text-blue-400 font-bold">Estimated Lease Speed: 2.4x Faster!</span>
                      </div>
                    </div>
                  </div>
                </div>

                {/* Pricing comparison */}
                <div className="bg-[#0a0a0c] border border-[#24262f] rounded-2xl p-6">
                  <h4 className="font-bold text-lg mb-4 text-blue-400">Commission Comparison For This Listing</h4>
                  <div className="grid grid-cols-1 sm:grid-cols-2 gap-6">
                    <div className="p-4 rounded-xl border border-red-500/10 bg-red-500/5">
                      <span className="text-xs text-red-400 font-bold uppercase tracking-wider">Traditional Model (NYC Average)</span>
                      <div className="text-2xl font-black text-slate-300 mt-2">3 Months Rent Upfront</div>
                      <p className="text-slate-500 text-xs mt-2 leading-relaxed">
                        1 month rent from tenant, 1 month from landlord, plus property management/billing tracking fee. High upfront commission hurdle prior to lease start.
                      </p>
                    </div>

                    <div className="p-4 rounded-xl border border-blue-500/20 bg-blue-500/5 relative overflow-hidden">
                      <div className="absolute top-0 right-0 bg-blue-500 text-white text-[10px] font-bold px-2.5 py-0.5 rounded-bl-lg uppercase tracking-wide">Recommended</div>
                      <span className="text-xs text-blue-400 font-bold uppercase tracking-wider">Reservatior LeaseCare+ Model</span>
                      <div className="text-2xl font-black text-white mt-2">3.5% Monthly Commission</div>
                      <p className="text-slate-300 text-xs mt-2 leading-relaxed">
                        Zero upfront commission. Spreads commission across monthly rent. Double-sided privacy masking avoids friction between tenant and landlord.
                      </p>
                    </div>
                  </div>
                </div>

                <div className="text-center pt-2">
                  <Button
                    onClick={handleJoinPilot}
                    className="h-14 px-10 bg-blue-600 hover:bg-blue-500 text-white font-bold rounded-xl text-base transition-all shadow-xl shadow-blue-600/20 group"
                  >
                    Share Listing & Launch Pilot
                    <ArrowRight className="w-5 h-5 ml-2 group-hover:translate-x-1 transition-transform" />
                  </Button>
                </div>
              </m.div>
            )}
          </AnimatePresence>
        </m.div>

        {/* Demo Cases */}
        <div className="mb-20">
          <h3 className="text-2xl font-extrabold mb-8 text-center sm:text-left flex items-center justify-center sm:justify-start gap-2">
            <Trophy className="text-yellow-400 w-7 h-7" />
            #ICNY27 Pilot Agencies & Live Metrics
          </h3>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
            
            {/* Case 1 */}
            <div className="bg-[#14151a] border border-[#24262f] rounded-2xl p-6 flex flex-col justify-between">
              <div>
                <div className="flex items-center justify-between mb-4">
                  <span className="text-xs font-bold text-blue-400 tracking-wider">@DouglasElliman</span>
                  <span className="text-xs text-slate-500">Manhattan Office</span>
                </div>
                <h4 className="font-bold text-white mb-2">John D. (Senior Broker)</h4>
                <p className="text-slate-400 text-sm leading-relaxed mb-4">
                  &quot;Our average days-to-lease was 32. After implementing Reservatior&apos;s AI virtual staging and spread commission, we received 8 applications in the first week. Contract signed on day 11.&quot;
                </p>
              </div>
              <div className="border-t border-[#24262f] pt-4 mt-4 flex items-center justify-between">
                <span className="text-xs text-slate-500">Days-to-Lease</span>
                <span className="text-sm font-bold text-blue-400">-65% Decrease</span>
              </div>
            </div>

            {/* Case 2 */}
            <div className="bg-[#14151a] border border-[#24262f] rounded-2xl p-6 flex flex-col justify-between">
              <div>
                <div className="flex items-center justify-between mb-4">
                  <span className="text-xs font-bold text-indigo-400 tracking-wider">@CompassNY</span>
                  <span className="text-xs text-slate-500">Brooklyn Heights</span>
                </div>
                <h4 className="font-bold text-white mb-2">Sarah M. (Listing Agent)</h4>
                <p className="text-slate-400 text-sm leading-relaxed mb-4">
                  &quot;By presenting the LeaseCare+ monthly spread commission instead of demanding 3 months upfront, we successfully leased 4 luxury units within 2 weeks that had been sitting vacant.&quot;
                </p>
              </div>
              <div className="border-t border-[#24262f] pt-4 mt-4 flex items-center justify-between">
                <span className="text-xs text-slate-500">Inquiry Volume</span>
                <span className="text-sm font-bold text-blue-400">+180% Increase</span>
              </div>
            </div>

            {/* Case 3 */}
            <div className="bg-[#14151a] border border-[#24262f] rounded-2xl p-6 flex flex-col justify-between">
              <div>
                <div className="flex items-center justify-between mb-4">
                  <span className="text-xs font-bold text-purple-400 tracking-wider">@KWManhattan</span>
                  <span className="text-xs text-slate-500">Midtown Office</span>
                </div>
                <h4 className="font-bold text-white mb-2">Robert L. (Team Lead)</h4>
                <p className="text-slate-400 text-sm leading-relaxed mb-4">
                  &quot;No more writing copy manually or chasing staging budgets. Our agents save massive time while the firm tracks commission payouts live in the dashboard.&quot;
                </p>
              </div>
              <div className="border-t border-[#24262f] pt-4 mt-4 flex items-center justify-between">
                <span className="text-xs text-slate-500">Agent Productivity</span>
                <span className="text-sm font-bold text-blue-400">3x Time Saved</span>
              </div>
            </div>

          </div>
        </div>

        {/* Call to Action Footer */}
        <div className="text-center bg-gradient-to-r from-blue-600/10 to-indigo-600/10 border border-blue-500/20 rounded-3xl p-8 sm:p-12 relative overflow-hidden">
          <div className="absolute top-0 right-0 w-32 h-32 bg-blue-500/10 rounded-full blur-2xl pointer-events-none" />
          <h3 className="text-2xl sm:text-3xl font-black mb-4">Join the #ICNY27 Pilot Program</h3>
          <p className="text-slate-400 text-sm sm:text-base max-w-2xl mx-auto mb-8">
            For all brokerages and independent agents who sign up during Inman Connect New York, Reservatior takes 0% commission share on your first 3 lease transactions.
          </p>
          <div className="flex flex-col sm:flex-row justify-center items-center gap-4">
            <Button
              onClick={handleJoinPilot}
              className="w-full sm:w-auto h-14 px-8 bg-blue-600 hover:bg-blue-500 text-white font-bold rounded-xl transition-all shadow-xl shadow-blue-600/10"
            >
              Create Free Corporate Account
            </Button>
            <button
              onClick={() => toast.info("Contact us at info@reservatior.com or tweet using #ICNY27 hashtag!")}
              className="text-slate-400 hover:text-white transition-colors text-sm font-semibold flex items-center gap-1 py-3"
            >
              Support & Contact <ChevronRight className="w-4 h-4" />
            </button>
          </div>
        </div>

      </div>
    </div>
  );
}
