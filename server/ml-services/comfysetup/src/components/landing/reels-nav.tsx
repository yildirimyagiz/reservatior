'use client';

import { motion } from 'framer-motion';
import { cn } from '@/lib/utils';
import Image from 'next/image';
import { Play } from 'lucide-react';

export interface ReelFeature {
    id: string;
    label: string;
    thumbnail: string;
    video?: string | boolean;
    // Allow other properties to pass through via Generics
}

interface ReelsNavProps<T extends ReelFeature> {
    features: T[];
    activeId: string;
    onSelect: (feature: T) => void;
}

export function ReelsNav<T extends ReelFeature>({ features, activeId, onSelect }: ReelsNavProps<T>) {
    return (
        <div className="w-full flex justify-center py-6">
            <div className="flex items-start justify-center gap-4 md:gap-12 flex-wrap">
                {features.map((feature) => {
                    const isActive = activeId === feature.id;

                    return (
                        <button
                            key={feature.id}
                            onClick={() => onSelect(feature)}
                            className="group flex flex-col items-center gap-4 relative transition-all duration-300"
                        >
                            {/* Viewfinder Bounding Box Area */}
                            <div className="relative p-2">
                                {/* Corner Brackets (Viewfinder Marks) - Visible Technical Look */}
                                <div className={cn(
                                    "absolute top-0 left-0 w-6 h-6 border-t-[3px] border-l-[3px] rounded-tl-xl transition-all duration-300",
                                    isActive ? "border-purple-500 scale-110" : "border-slate-600 group-hover:border-slate-400"
                                )} />
                                <div className={cn(
                                    "absolute top-0 right-0 w-6 h-6 border-t-[3px] border-r-[3px] rounded-tr-xl transition-all duration-300",
                                    isActive ? "border-purple-500 scale-110" : "border-slate-600 group-hover:border-slate-400"
                                )} />
                                <div className={cn(
                                    "absolute bottom-0 left-0 w-6 h-6 border-b-[3px] border-l-[3px] rounded-bl-xl transition-all duration-300",
                                    isActive ? "border-purple-500 scale-110" : "border-slate-600 group-hover:border-slate-400"
                                )} />
                                <div className={cn(
                                    "absolute bottom-0 right-0 w-6 h-6 border-b-[3px] border-r-[3px] rounded-br-xl transition-all duration-300",
                                    isActive ? "border-purple-500 scale-110" : "border-slate-600 group-hover:border-slate-400"
                                )} />

                                {/* The Lens Circle */}
                                <div className={cn(
                                    "relative w-24 h-24 md:w-32 md:h-32 rounded-full border-[3px] transition-all duration-500 overflow-hidden",
                                    isActive
                                        ? "border-transparent p-[2px] shadow-[0_0_30px_rgba(168,85,247,0.4)]"
                                        : "border-slate-800 bg-slate-900 group-hover:border-slate-600"
                                )}>
                                    {isActive && (
                                        <motion.div
                                            className="absolute inset-0 bg-gradient-to-r from-blue-500 via-purple-500 to-pink-500"
                                            animate={{
                                                rotate: [0, 360],
                                            }}
                                            transition={{
                                                duration: 4,
                                                repeat: Infinity,
                                                ease: "linear",
                                            }}
                                        />
                                    )}
                                    {/* Inner Mask for Gradient Border if Active */}
                                    <div className="w-full h-full rounded-full bg-slate-950 flex items-center justify-center overflow-hidden relative z-10">
                                        <Image
                                            src={feature.thumbnail}
                                            alt={feature.label}
                                            fill
                                            className={cn(
                                                "object-cover transition-transform duration-700 opacity-80",
                                                isActive ? "scale-110 opacity-100" : "scale-100 group-hover:scale-110 group-hover:opacity-100 grayscale group-hover:grayscale-0"
                                            )}
                                        />

                                        {/* Play Icon Overlay */}
                                        {feature.video && (
                                            <div className="absolute inset-0 flex items-center justify-center bg-black/10">
                                                <div className="w-8 h-8 rounded-full bg-black/40 backdrop-blur-sm flex items-center justify-center border border-white/20">
                                                    <Play className="w-3.5 h-3.5 text-white fill-white ml-0.5" />
                                                </div>
                                            </div>
                                        )}
                                    </div>
                                </div>
                            </div>

                            {/* Label */}
                            <span className={cn(
                                "text-sm font-medium tracking-wide transition-colors duration-300",
                                isActive ? "text-white" : "text-slate-500 group-hover:text-slate-300"
                            )}>
                                {feature.label}
                            </span>
                        </button>
                    );
                })}
            </div>
        </div>
    );
}
