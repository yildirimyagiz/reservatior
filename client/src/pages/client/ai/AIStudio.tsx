import { useTranslation } from "react-i18next";
import { motion, AnimatePresence } from "framer-motion";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Switch } from "@/components/ui/switch";
import { Slider } from "@/components/ui/slider";
import { AI_MODELS, AIModelCategory } from "@/lib/ai-models";
import { Sparkles, Bot, Video, Image as ImageIcon, Mic, ShieldCheck, Languages, Zap, ArrowRight, Cpu, Activity, Shield, Layers, Terminal, ChevronRight, Boxes, Workflow } from "lucide-react";
import { useState, useEffect } from "react";
import { cn } from "@/lib/utils";
import { Card } from "@/components/ui/card";
export default function AIStudio() {
  const {
    t
  } = useTranslation();
  const categories: AIModelCategory[] = [AIModelCategory.REASONING, AIModelCategory.VISION, AIModelCategory.SPEECH_TO_TEXT, AIModelCategory.TEXT_TO_TEXT, AIModelCategory.MULTILINGUAL, AIModelCategory.SAFETY];
  const [activeModels, setActiveModels] = useState<Record<string, string>>({
    [AIModelCategory.REASONING]: "gpt-oss-120b",
    [AIModelCategory.VISION]: "llama-4-scout",
    [AIModelCategory.SPEECH_TO_TEXT]: "whisper-large-v3",
    [AIModelCategory.SAFETY]: "llama-guard"
  });
  const [isProcessing, setIsProcessing] = useState(false);
  const [progress, setProgress] = useState(0);
  const [mounted, setMounted] = useState(false);
  useEffect(() => {
    setMounted(true);
  }, []);
  const handleSimulateGeneration = () => {
    setIsProcessing(true);
    setProgress(0);
    const interval = setInterval(() => {
      setProgress(prev => {
        if (prev >= 100) {
          clearInterval(interval);
          setIsProcessing(false);
          return 100;
        }
        return prev + 1;
      });
    }, 50);
  };
  if (!mounted) return null;
  return <div className="min-h-screen bg-[#14151a] p-8 lg:p-12 overflow-x-hidden">
      <div className="max-w-[1600px] mx-auto space-y-12">
        
        {/* Cinematic Header HUD */}
        <header className="relative py-12 px-10 rounded-[40px] bg-[#1a1b1e]/40 border border-white/5 border-l border-t overflow-hidden shadow-3xl">
           <div className="absolute top-0 right-0 p-40 opacity-5 pointer-events-none text-purple-600">
              <Sparkles className="w-96 h-96" />
           </div>
           <div className="absolute -top-24 -left-24 w-96 h-96 bg-blue-600/10 blur-[120px] rounded-full pointer-events-none"></div>
           
           <div className="relative z-10 flex flex-col md:flex-row items-center justify-between gap-10">
              <div className="flex items-center gap-8">
                 <div className="relative group">
                    <div className="absolute inset-0 bg-purple-600/20 blur-2xl group-hover:bg-purple-600/40 transition-all rounded-full animate-pulse-slow"></div>
                    <div className="relative p-6 rounded-3xl bg-linear-to-br from-purple-500/20 to-blue-500/20 border border-purple-500/30 backdrop-blur-xl shadow-2xl">
                       <Cpu className="w-10 h-10 text-purple-400" />
                    </div>
                 </div>
                 <div className="space-y-2">
                    <div className="flex items-center gap-3">
                       <h1 className="text-5xl font-black text-white italic tracking-tighter leading-none">{t("client.src.neural_hub_studio")}</h1>
                       <Badge className="bg-emerald-500/10 text-emerald-400 border border-emerald-500/20 font-black italic tracking-widest text-[10px] px-3 py-1 rounded-full">{t("client.src.primary_cluster_online")}</Badge>
                    </div>
                    <p className="text-lg font-black text-slate-500 italic tracking-widest leading-none mt-2">{t("client.src.bidirectional_media_transformation_pipeline")}</p>
                 </div>
              </div>
              
              <div className="flex gap-4">
                 <Button className="h-16 px-10 rounded-2xl bg-white text-black hover:bg-slate-200 font-black italic text-xs tracking-widest shadow-xl transition-all hover:scale-105 active:scale-95">{t("client.src.sync_global_models")}</Button>
                 <Button variant="outline" className="h-16 w-16 rounded-2xl border-white/5 bg-white/5 text-slate-400 hover:text-white transition-all backdrop-blur-xl">
                    <Terminal className="w-6 h-6" />
                 </Button>
              </div>
           </div>
        </header>

        <div className="grid lg:grid-cols-12 gap-12">
          {/* Main Transformation Matrix */}
          <div className="lg:col-span-8 space-y-12">
            
            {/* Model Architecture Grid */}
            <div className="grid md:grid-cols-2 gap-6">
              {categories.map((cat, idx) => <motion.div key={cat} initial={{
              opacity: 0,
              y: 30
            }} animate={{
              opacity: 1,
              y: 0
            }} transition={{
              delay: idx * 0.1
            }} className="bg-[#1a1b1e]/60 border border-white/5 rounded-[32px] p-8 hover:border-purple-500/30 transition-all shadow-xl hover:shadow-purple-500/5 group border-l border-t">
                  <div className="flex items-center justify-between mb-8">
                    <div className="flex items-center gap-4">
                      <div className="h-10 w-10 rounded-xl bg-black/40 border border-white/5 flex items-center justify-center transition-all group-hover:scale-110">
                        {cat === "Reasoning" && <Bot className="w-5 h-5 text-blue-400" />}
                        {cat === "Vision" && <ImageIcon className="w-5 h-5 text-pink-400" />}
                        {cat === "Speech to Text" && <Mic className="w-5 h-5 text-emerald-400" />}
                        {cat === "Safety" && <Shield className="w-5 h-5 text-red-400" />}
                        {cat === "Multilingual" && <Languages className="w-5 h-5 text-orange-400" />}
                        {cat === "Text to Text" && <Terminal className="w-5 h-5 text-violet-400" />}
                      </div>
                      <span className="font-black text-xs text-white tracking-widest italic">{cat}{t("client.src.node")}</span>
                    </div>
                    <div className="flex items-center gap-2 px-3 py-1 bg-emerald-500/10 rounded-full border border-emerald-500/20">
                       <span className="w-1.5 h-1.5 rounded-full bg-emerald-500 animate-pulse"></span>
                       <span className="text-[9px] font-black text-emerald-500 italic tracking-widest">{t("client.src.enabled")}</span>
                    </div>
                  </div>
                  
                  <div className="space-y-4">
                    {AI_MODELS.filter(m => m.category === cat).map(model => <div key={model.id} onClick={() => setActiveModels(prev => ({
                  ...prev,
                  [cat]: model.id
                }))} className={cn("cursor-pointer p-5 rounded-2xl border transition-all relative overflow-hidden group/item", activeModels[cat] === model.id ? "bg-purple-600/10 border-purple-500/50 shadow-[0_0_20px_rgba(147,51,234,0.1)]" : "bg-black/20 border-white/5 hover:bg-white/5")}>
                        <div className="flex items-center justify-between mb-2">
                          <span className={cn("font-black italic tracking-tighter ", activeModels[cat] === model.id ? "text-purple-400" : "text-white")}>{model.name}</span>
                          {activeModels[cat] === model.id && <div className="absolute right-0 top-0 bottom-0 w-1 bg-purple-500 shadow-[0_0_15px_#a855f7]"></div>}
                        </div>
                        <p className="text-[10px] font-bold text-slate-500 tracking-tight italic line-clamp-1">{model.description}</p>
                      </div>)}
                  </div>
                </motion.div>)}
            </div>

            {/* Neural Data Pipeline Visualizer */}
            <Card className="bg-[#1a1b1e]/40 border-white/5 rounded-[40px] p-12 relative overflow-hidden shadow-3xl border-l border-t group">
               <div className="absolute top-0 right-0 p-12 opacity-5 pointer-events-none text-blue-500 group-hover:scale-110 transition-transform duration-700">
                  <Workflow className="w-48 h-48" />
               </div>
               
               <header className="mb-12 space-y-1">
                  <h3 className="text-xs font-black text-slate-500 tracking-widest italic flex items-center gap-3">
                     <Zap className="w-4 h-4 text-orange-400" />{t("client.src.transformation_sequence_optimization")}</h3>
                  <p className="text-3xl font-black text-white italic tracking-tighter">{t("client.src.pipeline_simulation_photo_kinetic")}</p>
               </header>

               <div className="flex flex-col xl:flex-row items-center justify-between gap-12 relative z-10">
                 <div className="text-center space-y-4">
                   <div className="w-32 h-32 rounded-[32px] bg-black/40 border border-white/5 shadow-inner flex items-center justify-center mx-auto group-hover:shadow-blue-500/10 transition-all cursor-crosshair">
                     <ImageIcon className="w-12 h-12 text-slate-600 group-hover:text-blue-400 transition-colors" />
                   </div>
                   <div className="space-y-1">
                      <p className="text-[10px] font-black text-white italic tracking-widest leading-none">{t("client.src.raster_origin")}</p>
                      <p className="text-[9px] font-bold text-slate-500 tracking-tighter italic">{t("client.src.raw_spectral_data")}</p>
                   </div>
                 </div>
                 
                 <div className="flex-1 w-full xl:w-auto space-y-6">
                   {[{
                  label: `Structural Sync (${activeModels["Vision"]})`,
                  color: "bg-blue-500",
                  threshold: 10,
                  icon: Boxes
                }, {
                  label: `Semantic Interpolation (${activeModels["Reasoning"]})`,
                  color: "bg-purple-500",
                  threshold: 45,
                  icon: Bot
                }, {
                  label: `Fluid Synthesis & Audio Overlay`,
                  color: "bg-emerald-500",
                  threshold: 75,
                  icon: Mic
                }].map((node, i) => <motion.div key={i} className={cn("bg-black/40 border border-white/5 rounded-3xl p-6 flex items-center justify-between group/node transition-all", isProcessing && progress > node.threshold ? "border-white/20 shadow-xl" : "")}>
                        <div className="flex items-center gap-6">
                           <div className={cn("h-10 w-10 rounded-2xl flex items-center justify-center transition-all duration-500", isProcessing && progress > node.threshold ? `${node.color}/20 text-white shadow-lg` : "bg-white/2 text-slate-600")}>
                              <node.icon className="w-5 h-5" />
                           </div>
                           <span className={cn("text-[11px] font-black  tracking-widest italic transition-colors", isProcessing && progress > node.threshold ? "text-white" : "text-slate-500")}>{node.label}</span>
                        </div>
                        {isProcessing && progress > node.threshold && <div className="flex items-center gap-2">
                              <Activity className="w-4 h-4 text-emerald-400 animate-pulse" />
                              <span className="text-[10px] font-black text-emerald-400 italic">{t("client.src.processing")}</span>
                           </div>}
                     </motion.div>)}
                   
                   <div className="relative h-2 w-full bg-black/40 rounded-full mt-6 overflow-hidden border border-white/5 shadow-inner">
                     <motion.div className="h-full bg-linear-to-r from-blue-600 via-purple-600 to-emerald-600 relative" animate={{
                    width: `${progress}%`
                  }} transition={{
                    ease: "linear"
                  }}>
                        <div className="absolute top-0 right-0 h-full w-20 bg-linear-to-r from-transparent to-white/40 blur-sm"></div>
                     </motion.div>
                   </div>
                 </div>
                 
                 <div className="text-center space-y-4">
                   <div className="relative w-32 h-32 rounded-[32px] bg-black/40 border border-white/5 shadow-inner flex items-center justify-center mx-auto overflow-hidden">
                     {isProcessing && progress === 100 ? <div className="space-y-2">
                          <Video className="w-12 h-12 text-white drop-shadow-[0_0_15px_rgba(255,255,255,0.5)] animate-pulse" />
                       </div> : <div className={cn("w-12 h-12 border-4 border-slate-800 border-t-blue-500 rounded-full", isProcessing ? 'animate-spin' : '')} />}
                     {progress === 100 && <div className="absolute inset-0 bg-blue-500/10 animate-pulse" />}
                   </div>
                    <div className="space-y-1">
                      <p className="text-[10px] font-black text-white italic tracking-widest leading-none">{t("client.src.kinetic_hub")}</p>
                      <p className="text-[9px] font-bold text-slate-500 tracking-tighter italic">{t("client.src.4k_tactical_output")}</p>
                   </div>
                 </div>
               </div>
               
               <div className="mt-16 flex justify-center">
                 <Button size="lg" onClick={handleSimulateGeneration} disabled={isProcessing} className={cn("h-20 px-16 rounded-[28px] font-black  italic text-sm tracking-[0.2em] transition-all relative overflow-hidden group shadow-2xl active:scale-95", isProcessing ? "bg-slate-800 text-slate-500" : "bg-white text-black hover:bg-slate-100 hover:scale-[1.02]")}>
                   <div className="relative z-10 flex items-center gap-4">
                      {isProcessing ? "Engaging Transformation Engines..." : "Initialize Synthesis Cycle"}
                      {!isProcessing && <ChevronRight className="w-5 h-5 group-hover:translate-x-1 transition-transform" />}
                   </div>
                   {isProcessing && <div className="absolute left-0 top-0 h-full bg-blue-600/10 animate-progress" style={{
                  width: `${progress}%`
                }}></div>}
                 </Button>
               </div>
            </Card>
          </div>

          {/* Tactical Resource HUD */}
          <div className="lg:col-span-4 space-y-12">
            <aside className="sticky top-12 space-y-8">
               <Card className="bg-[#1a1b1e]/80 backdrop-blur-3xl border-white/5 rounded-[40px] p-10 shadow-3xl border-l border-t">
                  <header className="mb-10 flex items-center justify-between">
                     <h2 className="text-xl font-black text-white italic tracking-tighter leading-none">{t("client.src.cluster_config")}</h2>
                     <div className="h-8 w-8 rounded-xl bg-white/5 flex items-center justify-center">
                        <Terminal className="w-4 h-4 text-slate-500" />
                     </div>
                  </header>
                  
                  <div className="space-y-10">
                    <div className="space-y-4">
                      <div className="flex items-center justify-between group cursor-help">
                         <label className="text-xs font-black text-slate-200 tracking-widest italic">{t("client.src.autonomous_optimization")}</label>
                         <Switch defaultChecked className="data-[state=checked]:bg-blue-600" />
                      </div>
                      <p className="text-[10px] font-bold text-slate-500 tracking-tight italic">{t("client.src.automatically_route_workloads_between")}</p>
                    </div>

                    <div className="space-y-6">
                      <div className="flex justify-between items-center mb-2">
                         <label className="text-xs font-black text-slate-200 tracking-widest italic">{t("client.src.compute_velocity")}</label>
                         <span className="text-[10px] font-black text-blue-400 italic">{t("client.src.max_turbo")}</span>
                      </div>
                      <div className="relative pt-4">
                         <Slider defaultValue={[85]} max={100} step={1} className="relative z-10" />
                         <div className="absolute top-0 left-0 w-full h-px bg-white/5"></div>
                      </div>
                    </div>

                    <div className="pt-10 border-t border-white/5 space-y-8">
                      <h3 className="text-xs font-black text-slate-500 tracking-widest italic flex items-center gap-2">
                         <Activity className="w-4 h-4" />{t("client.src.resource_calibration")}</h3>
                      
                      <div className="space-y-4">
                        <div className="flex justify-between items-center text-[10px] font-black italic tracking-tighter">
                           <span className="text-slate-400">{t("client.src.memory_partition")}</span>
                           <span className="text-white">{t("client.src.584_gb")}<span className="text-slate-600 text-[8px]">/ 80 GB</span></span>
                        </div>
                        <div className="h-1.5 w-full bg-black/40 rounded-full overflow-hidden shadow-inner">
                           <motion.div initial={{
                        width: 0
                      }} animate={{
                        width: "73%"
                      }} className="h-full bg-blue-600 shadow-[0_0_10px_#2563eb]" />
                        </div>
                      </div>

                      <div className="space-y-4">
                        <div className="flex justify-between items-center text-[10px] font-black italic tracking-tighter">
                           <span className="text-slate-400">{t("client.src.throughput_velocity")}</span>
                           <span className="text-white">{t("client.src.412_ts")}<span className="text-emerald-500 text-[8px] animate-pulse">{t("client.src.updating")}</span></span>
                        </div>
                        <div className="h-1.5 w-full bg-black/40 rounded-full overflow-hidden shadow-inner">
                           <motion.div initial={{
                        width: 0
                      }} animate={{
                        width: "88%"
                      }} className="h-full bg-emerald-500 shadow-[0_0_10px_#10b981]" />
                        </div>
                      </div>
                    </div>
                    
                    <Button variant="outline" className="w-full h-14 rounded-2xl border-white/5 bg-white/5 text-slate-400 hover:text-white font-black text-[10px] tracking-widest italic transition-all group">{t("client.src.export_system_logs")}<ChevronRight className="w-3 h-3 ml-2 group-hover:translate-x-1 transition-transform" />
                    </Button>
                  </div>
               </Card>
               
               <div className="p-10 rounded-[40px] bg-linear-to-br from-purple-600/20 via-blue-600/20 to-transparent border border-white/5 border-l border-t relative overflow-hidden">
                  <div className="absolute -top-12 -right-12 p-20 opacity-5 pointer-events-none">
                     <Languages className="w-32 h-32" />
                  </div>
                  <h4 className="text-xs font-black text-white tracking-widest italic mb-4">{t("client.src.neural_security_node")}</h4>
                  <p className="text-[10px] font-bold text-slate-400 tracking-widest italic mb-6 leading-relaxed">{t("client.src.hardwarelevel_encryption_for_all")}</p>
                  <div className="flex items-center gap-4">
                     <div className="h-10 w-10 rounded-2xl bg-white/5 flex items-center justify-center text-emerald-500 shadow-xl">
                        <ShieldCheck className="w-5 h-5" />
                     </div>
                     <span className="text-[10px] font-black text-emerald-400 tracking-widest italic">{t("client.src.vault_lock_synchronized")}</span>
                  </div>
               </div>
            </aside>
          </div>
        </div>
      </div>
    </div>;
}