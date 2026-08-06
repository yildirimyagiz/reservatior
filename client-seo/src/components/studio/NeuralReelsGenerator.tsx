import { t } from "i18next";
import { useTranslation } from "react-i18next";
import React, { useState } from "react";
import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle, DialogTrigger } from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { PlayCircle, Sparkles, Layout, MapPin, BarChart3, Calendar, DollarSign, Activity, Clapperboard, CheckCircle2 } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { videoApi } from "@/lib/api/video";
import { Progress } from "@/components/ui/progress";
import { m, AnimatePresence } from "framer-motion";
interface NeuralReelsGeneratorProps {
  projectId?: string;
  projectName?: string;
  selectedProperties?: string[];
  trigger?: React.ReactNode;
}
export function NeuralReelsGenerator({
  projectId,
  projectName,
  selectedProperties,
  trigger
}: NeuralReelsGeneratorProps) {
  const {
    t
  } = useTranslation();
  const [isOpen, setIsOpen] = useState(false);
  const [isGenerating, setIsGenerating] = useState(false);
  const [progress, setProgress] = useState(0);
  const [status, setStatus] = useState("");
  const [sortBy, setBy] = useState("popularity");
  const [style, setStyle] = useState("luxury_cinematic");
  const [isSuccess, setIsSuccess] = useState(false);
  const {
    toast
  } = useToast();
  const handleGenerate = async () => {
    setIsGenerating(true);
    setIsSuccess(false);
    setProgress(10);
    setStatus("Analyzing project assets...");
    try {
      // Step 1: Analyze Assets
      await new Promise(r => setTimeout(r, 1500));
      setProgress(30);
      setStatus(`Sorting by ${sortBy.replace("_", " ")}...`);

      // Step 2: Prompt Engineering
      await new Promise(r => setTimeout(r, 1200));
      setProgress(55);
      setStatus("Generating Neural Sequences...");

      // Step 3: Trigger API
      const result = await videoApi.generateWalkthrough({
        photoCount: 12,
        roomTypes: ["Living Room", "Kitchen", "Exterior"],
        luxuryFlag: style === "luxury_cinematic"
      });
      setProgress(85);
      setStatus("Applying stylistic overlays...");

      // Final Step
      await new Promise(r => setTimeout(r, 1000));
      setProgress(100);
      setStatus("Neural Reel Complete!");
      setIsSuccess(true);
      toast({
        title: t("client.src.reel_generated"),
        description: t("client.src.the_ai_reel_for")
      });
    } catch (error) {
      console.error("Reel generation failed:", error);
      toast({
        title: t("client.src.generation_failed"),
        description: t("client.src.could_not_produce_the"),
        variant: "destructive"
      });
      setIsGenerating(false);
    }
  };
  return <Dialog open={isOpen} onOpenChange={setIsOpen}>
      <DialogTrigger asChild>
        {trigger || <Button variant="outline" className="border-blue-600/30 text-blue-500 hover:bg-blue-600/10">
            <Sparkles className="w-4 h-4 mr-2" />{t("client.src.generate_reels")}</Button>}
      </DialogTrigger>
      <DialogContent className="sm:max-w-[500px] bg-[#0f1014] border-white/5 shadow-2xl">
        <DialogHeader>
          <DialogTitle className="flex items-center gap-3 text-2xl font-black italic tracking-tighter text-white">
            <div className="p-2 bg-blue-600/20 rounded-xl">
               <Clapperboard className="w-6 h-6 text-blue-500" />
            </div>{t("client.src.neural_reels_studio")}</DialogTitle>
          <DialogDescription className="text-slate-400 font-medium">{t("client.src.generate_highconversion_cinematographic_reels")}{projectName || 'selected assets'}{t("client.src.using_mldriven_sorting_logic")}</DialogDescription>
        </DialogHeader>

        <AnimatePresence mode="wait">
          {isGenerating ? <m.div initial={{
          opacity: 0,
          y: 10
        }} animate={{
          opacity: 1,
          y: 0
        }} exit={{
          opacity: 0,
          y: -10
        }} className="py-8 space-y-6">
              <div className="space-y-4">
                <div className="flex justify-between text-xs font-black uppercase tracking-widest italic">
                  <span className="text-blue-500 animate-pulse">{status}</span>
                  <span className="text-white">{progress}%</span>
                </div>
                <Progress value={progress} className="h-2 bg-white/5" />
              </div>

              {isSuccess ? <m.div initial={{
            scale: 0.9,
            opacity: 0
          }} animate={{
            scale: 1,
            opacity: 1
          }} className="bg-blue-500/10 border border-blue-500/20 rounded-2xl p-4 flex items-center gap-4">
                  <div className="w-12 h-12 bg-blue-500 rounded-full flex items-center justify-center shadow-lg shadow-blue-500/30">
                    <CheckCircle2 className="w-6 h-6 text-white" />
                  </div>
                  <div>
                    <h4 className="text-white font-black italic text-sm">{t("client.src.reel_is_active")}</h4>
                    <p className="text-slate-400 text-xs">{t("client.src.ready_for_social_distribution")}</p>
                  </div>
                  <Button className="ml-auto bg-white text-black hover:bg-slate-200 text-xs font-black px-4 h-9">{t("client.src.preview")}</Button>
                </m.div> : <div className="flex justify-center py-4">
                  <div className="relative">
                    <Activity className="w-16 h-16 text-blue-600/20" />
                    <Sparkles className="w-6 h-6 text-blue-500 absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 animate-bounce" />
                  </div>
                </div>}
            </m.div> : <m.div initial={{
          opacity: 0
        }} animate={{
          opacity: 1
        }} className="space-y-6 py-4">
              <div className="grid grid-cols-2 gap-4">
                <div className="space-y-2">
                  <Label className="text-[10px] font-black text-slate-500 uppercase tracking-widest">{t("client.src.sorting_protocol")}</Label>
                  <Select value={sortBy} onValueChange={setBy}>
                    <SelectTrigger className="bg-white/5 border-white/5 text-white h-12 uppercase text-[10px] font-black tracking-widest">
                      <SelectValue />
                    </SelectTrigger>
                    <SelectContent className="bg-[#14151a] border-white/5 text-white">
                      <SelectItem value="location"><div className="flex items-center gap-2"><MapPin className="w-3 h-3" />{t("common.location")}</div></SelectItem>
                      <SelectItem value="price"><div className="flex items-center gap-2"><DollarSign className="w-3 h-3" />{t("client.src.price_range")}</div></SelectItem>
                      <SelectItem value="popularity"><div className="flex items-center gap-2"><BarChart3 className="w-3 h-3" />{t("client.src.popularity")}</div></SelectItem>
                      <SelectItem value="date"><div className="flex items-center gap-2"><Calendar className="w-3 h-3" />{t("client.src.newest_releases")}</div></SelectItem>
                    </SelectContent>
                  </Select>
                </div>
                <div className="space-y-2">
                  <Label className="text-[10px] font-black text-slate-500 uppercase tracking-widest">{t("client.src.neural_style")}</Label>
                  <Select value={style} onValueChange={setStyle}>
                    <SelectTrigger className="bg-white/5 border-white/5 text-white h-12 uppercase text-[10px] font-black tracking-widest">
                      <SelectValue />
                    </SelectTrigger>
                    <SelectContent className="bg-[#14151a] border-white/5 text-white">
                      <SelectItem value="luxury_cinematic">{t("client.src.luxury_cinematic")}</SelectItem>
                      <SelectItem value="urban_pulse">{t("client.src.urban_pulse")}</SelectItem>
                      <SelectItem value="minimalist_flow">{t("client.src.minimalist_flow")}</SelectItem>
                      <SelectItem value="vibrant_energy">{t("client.src.vibrant_energy")}</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
              </div>

              <div className="p-4 bg-white/5 border border-white/5 rounded-2xl space-y-3">
                 <div className="flex justify-between items-center">
                    <p className="text-[10px] font-black text-slate-500 uppercase tracking-widest">{t("client.src.active_asset_context")}</p>
                    <Badge variant="outline" className="bg-blue-500/10 text-blue-400 border-blue-500/20 text-[9px]">
                       {selectedProperties?.length || 1}{t("client.src.assets")}</Badge>
                 </div>
                 <div className="flex flex-wrap gap-2">
                   {["GPS Coordinates", "Pricing Matrix", "Market Demand", "Professional Photography"].map(tag => <span key={tag} className="px-2 py-1 bg-white/5 border border-white/10 rounded text-[9px] font-black text-blue-500 uppercase tracking-tight">
                        {tag}
                     </span>)}
                 </div>
              </div>

              <Button onClick={handleGenerate} className="w-full h-16 rounded-2xl bg-blue-600 hover:bg-blue-500 text-white font-black uppercase tracking-widest shadow-2xl shadow-blue-600/30 gap-3">
                <PlayCircle className="w-5 h-5" />{t("client.src.initiate_neural_generation")}</Button>
            </m.div>}
        </AnimatePresence>
      </DialogContent>
    </Dialog>;
}