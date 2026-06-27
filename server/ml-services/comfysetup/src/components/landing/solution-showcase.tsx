"use client";

import { useState } from "react";
import { motion, AnimatePresence } from "framer-motion";
import { Building2, Camera, Home, Briefcase, ChevronRight } from "lucide-react";
import { ComparisonSlider } from "./comparison-slider";

import { STAGING_IMAGES } from '@/lib/staging-images';
import type { Dictionary } from '@/lib/i18n/config';
import { cn } from "@/lib/utils";

interface SolutionProps {
  dictionary: Dictionary;
}

export function SolutionShowcase({ dictionary }: SolutionProps) {
  const d = dictionary.landing.solutions;

  const solutions = [
    {
      id: "agents",
      label: d.items.agents.label,
      icon: Briefcase,
      title: d.items.agents.title,
      description: d.items.agents.description,
      before: STAGING_IMAGES.livingRoom.before,
      after: STAGING_IMAGES.livingRoom.after,
      link: "/editor?mode=staging",
      color: "from-purple-600 to-indigo-600"
    },
    {
      id: "architects",
      label: d.items.architects.label,
      icon: Building2,
      title: d.items.architects.title,
      description: d.items.architects.description,
      before: STAGING_IMAGES.bedroom.before,
      after: STAGING_IMAGES.bedroom.after,
      link: "/editor?mode=redesign",
      color: "from-blue-600 to-cyan-600"
    },
    {
      id: "homeowners",
      label: d.items.homeowners.label,
      icon: Home,
      title: d.items.homeowners.title,
      description: d.items.homeowners.description,
      before: STAGING_IMAGES.office.before,
      after: STAGING_IMAGES.office.after,
      link: "/editor?mode=redesign",
      color: "from-emerald-600 to-teal-600"
    },
    {
      id: "photographers",
      label: d.items.photographers.label,
      icon: Camera,
      title: d.items.photographers.title,
      description: d.items.photographers.description,
      before: STAGING_IMAGES.kitchen.before,
      after: STAGING_IMAGES.kitchen.after,
      link: "/editor?mode=enhance",
      color: "from-orange-600 to-rose-600"
    }
  ];

  const [activeTab, setActiveTab] = useState(solutions[0].id);
  const activeSolution = solutions.find(s => s.id === activeTab) || solutions[0];

  return (
    <section className="py-32 bg-[#020617] relative overflow-hidden">
      {/* Ambient background glow */}
      <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[800px] h-[800px] bg-purple-600/5 rounded-full blur-[120px] pointer-events-none" />

      <div className="container mx-auto px-4 max-w-7xl relative z-10">
        <div className="text-center mb-20 space-y-4">
          <motion.span
            initial={{ opacity: 0, y: 10 }}
            whileInView={{ opacity: 1, y: 0 }}
            className="text-purple-400 text-xs font-black uppercase tracking-[0.3em]"
          >
            Professional Solutions
          </motion.span>
          <motion.h2
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.1 }}
            className="text-4xl md:text-6xl font-black text-white tracking-tight"
          >
            {d.title}
          </motion.h2>
          <motion.p
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.2 }}
            className="text-slate-400 max-w-2xl mx-auto text-lg font-medium"
          >
            {d.subtitle}
          </motion.p>
        </div>

        <div className="grid lg:grid-cols-12 gap-8 items-start">
          {/* Sidebar / Tabs */}
          <div className="lg:col-span-4 space-y-3">
            {solutions.map((s, idx) => {
              const Icon = s.icon;
              const isActive = activeTab === s.id;
              return (
                <motion.button
                  key={s.id}
                  initial={{ opacity: 0, x: -20 }}
                  whileInView={{ opacity: 1, x: 0 }}
                  transition={{ delay: idx * 0.1 }}
                  onClick={() => setActiveTab(s.id)}
                  className={cn(
                    "w-full text-left p-6 rounded-3xl transition-all duration-500 border group relative overflow-hidden",
                    isActive
                      ? "bg-white/5 border-white/10 shadow-2xl"
                      : "bg-transparent border-transparent hover:bg-white/[0.02] hover:border-white/5"
                  )}
                >
                  {/* Active Indicator Line */}
                  {isActive && (
                    <motion.div
                      layoutId="active-pill"
                      className={cn("absolute left-0 top-0 bottom-0 w-1 bg-gradient-to-b", s.color)}
                    />
                  )}

                  <div className="flex items-center gap-5">
                    <div className={cn(
                      "p-3 rounded-2xl transition-all duration-500",
                      isActive ? "bg-white text-black scale-110 shadow-xl" : "bg-slate-800/50 text-slate-500 group-hover:text-slate-300"
                    )}>
                      <Icon size={24} />
                    </div>
                    <div className="flex-1">
                      <h3 className={cn(
                        "font-bold text-lg transition-colors",
                        isActive ? "text-white" : "text-slate-500 group-hover:text-slate-300"
                      )}>
                        {s.label}
                      </h3>
                      <p className={cn(
                        "text-xs font-medium line-clamp-1 mt-0.5",
                        isActive ? "text-slate-400" : "text-slate-600"
                      )}>
                        {s.title}
                      </p>
                    </div>
                    <ChevronRight className={cn(
                      "h-5 w-5 transition-all duration-300",
                      isActive ? "text-white translate-x-0 opacity-100" : "text-slate-600 -translate-x-2 opacity-0 group-hover:opacity-100 group-hover:translate-x-0"
                    )} />
                  </div>
                </motion.button>
              );
            })}
          </div>

          {/* Preview Area */}
          <div className="lg:col-span-8 relative aspect-video rounded-[2.5rem] overflow-hidden border border-white/10 bg-slate-900/50 shadow-[0_0_50px_-12px_rgba(0,0,0,0.5)] group">
            <AnimatePresence mode="wait">
              <motion.div
                key={activeSolution.id}
                initial={{ opacity: 0, scale: 0.95 }}
                animate={{ opacity: 1, scale: 1 }}
                exit={{ opacity: 0, scale: 1.05 }}
                transition={{ duration: 0.5, ease: [0.22, 1, 0.36, 1] }}
                className="absolute inset-0 flex flex-col"
              >
                <div className="flex-1 relative h-full">
                  <ComparisonSlider
                    beforeLabel={dictionary.common.before}
                    afterLabel={dictionary.common.after}
                    dragText={dictionary.landing.featureShowcase.dragText}
                    showLabels={false}
                    showDragText={false}
                    examples={[{
                      id: activeSolution.id,
                      label: activeSolution.label,
                      before: activeSolution.before,
                      after: activeSolution.after
                    }]}
                    className="p-0 max-w-none"
                  />

                  {/* Glass Info Overlay - Premium Version */}
                  <div className="absolute inset-x-0 bottom-0 p-8 pt-20 bg-gradient-to-t from-black via-black/80 to-transparent pointer-events-none">
                    <div className="flex flex-col md:flex-row items-end justify-between gap-6 pointer-events-auto mt-auto">
                      <div className="max-w-xl">
                        <motion.div
                          initial={{ opacity: 0, y: 10 }}
                          animate={{ opacity: 1, y: 0 }}
                          transition={{ delay: 0.3 }}
                          className={cn("inline-block px-3 py-1 rounded-full bg-gradient-to-r text-[10px] font-black uppercase tracking-widest text-white mb-3 shadow-lg", activeSolution.color)}
                        >
                          Target Solution
                        </motion.div>
                        <motion.h4
                          initial={{ opacity: 0, y: 10 }}
                          animate={{ opacity: 1, y: 0 }}
                          transition={{ delay: 0.4 }}
                          className="text-2xl md:text-3xl font-black text-white mb-2 tracking-tight"
                        >
                          {activeSolution.title}
                        </motion.h4>
                        <motion.p
                          initial={{ opacity: 0, y: 10 }}
                          animate={{ opacity: 1, y: 0 }}
                          transition={{ delay: 0.5 }}
                          className="text-slate-300 text-sm md:text-base font-medium leading-relaxed"
                        >
                          {activeSolution.description}
                        </motion.p>
                      </div>
                      <motion.div
                        initial={{ opacity: 0, scale: 0.9 }}
                        animate={{ opacity: 1, scale: 1 }}
                        transition={{ delay: 0.6 }}
                        className="shrink-0"
                      >
                        <a
                          href={activeSolution.link}
                          className="inline-flex items-center justify-center font-black bg-white text-black hover:bg-slate-200 px-8 py-4 text-sm rounded-2xl transition-all hover:scale-105 active:scale-95 shadow-xl shadow-white/10"
                        >
                          {dictionary.landing.featureShowcase.getStarted}
                          <ChevronRight className="ml-2 h-4 w-4" />
                        </a>
                      </motion.div>
                    </div>
                  </div>
                </div>
              </motion.div>
            </AnimatePresence>

            {/* View Port Decorative Corners */}
            <div className="absolute top-0 left-0 w-20 h-20 border-t-2 border-l-2 border-white/20 rounded-tl-[2.5rem] pointer-events-none" />
            <div className="absolute top-0 right-0 w-20 h-20 border-t-2 border-r-2 border-white/20 rounded-tr-[2.5rem] pointer-events-none" />
          </div>
        </div>
      </div>
    </section>
  );
}
