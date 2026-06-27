'use client';

import * as React from 'react';
import { useRef, useState, useEffect } from 'react';
import {
    Eraser,
    Trash2,
    ScanLine,
    Layers,
    Snowflake,
    Sun,
    Sunset,
    Moon,
    Clock,
    Droplets,
    Sprout,
    Sparkles,
    Upload,
    Wand2,
    Info,
    ChevronRight,
    Loader2
} from 'lucide-react';
import { cn } from '@/lib/utils';
import { useCanvasStore, CanvasTool } from '@/lib/store/canvas-store';
import Image from 'next/image';

interface ToolConfig {
    id: CanvasTool;
    title: string;
    description: string;
    icon: React.ElementType;
    color: string;
    exampleLabel: string;
    exampleImage: string;
}

const TOOL_CONFIGS: Partial<Record<CanvasTool, ToolConfig>> = {
    eraser: {
        id: 'eraser',
        title: 'Precision Eraser',
        description: 'Remove unwanted objects or imperfections with surgical precision.',
        icon: Eraser,
        color: 'text-red-400',
        exampleLabel: 'Furniture Removal',
        exampleImage: 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=800&q=80'
    },
    declutter: {
        id: 'declutter',
        title: 'Smart Declutter',
        description: 'Instantly clean up messy rooms while preserving architectural details.',
        icon: Trash2,
        color: 'text-orange-400',
        exampleLabel: 'Clutter-Free Space',
        exampleImage: 'https://images.unsplash.com/photo-1519710889408-a67e1c7e0452?w=800&q=80'
    },
    enhance: {
        id: 'enhance',
        title: 'Visual Enhancer',
        description: 'Upscale resolution and optimize lighting for professional presentations.',
        icon: ScanLine,
        color: 'text-blue-400',
        exampleLabel: '8K Optimization',
        exampleImage: 'https://images.unsplash.com/photo-1502005097973-6a7082348e28?w=800&q=80'
    },
    material: {
        id: 'material',
        title: 'Material Studio',
        description: 'Swap floorings, wall textures, and finishes in real-time.',
        icon: Layers,
        color: 'text-emerald-400',
        exampleLabel: 'Flooring Swap',
        exampleImage: 'https://images.unsplash.com/photo-1513584685908-95c9e2d0197c?w=800&q=80'
    },
    seasons: {
        id: 'seasons',
        title: 'Seasonal Shift',
        description: 'Transform the exterior environment across all four seasons.',
        icon: Snowflake,
        color: 'text-cyan-400',
        exampleLabel: 'Winter Sunset',
        exampleImage: 'https://images.unsplash.com/photo-1483347756197-71ef80e95f73?w=800&q=80'
    },
    'rain-shine': {
        id: 'rain-shine',
        title: 'Weather Control',
        description: 'Adjust atmospheric conditions from clear skies to dramatic storms.',
        icon: Sun,
        color: 'text-amber-400',
        exampleLabel: 'Golden Hour',
        exampleImage: 'https://images.unsplash.com/photo-1502318217862-aa4e294ba657?w=800&q=80'
    },
    'natural-twilight': {
        id: 'natural-twilight',
        title: 'Sunset Magic',
        description: 'Automatically shift day photos into stunning sunset architectural shots.',
        icon: Sunset,
        color: 'text-rose-400',
        exampleLabel: 'Dusk Exterior',
        exampleImage: 'https://images.unsplash.com/photo-1507089947368-19c1da977535?w=800&q=80'
    },
    'virtual-twilight': {
        id: 'virtual-twilight',
        title: 'Virtual Night',
        description: 'Illuminate properties with artificial lighting for premium night viewing.',
        icon: Moon,
        color: 'text-indigo-400',
        exampleLabel: 'Blue Hour Glow',
        exampleImage: 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=800&q=80'
    },
    'night-day': {
        id: 'night-day',
        title: 'Time Traveler',
        description: 'Seamlessly transition between day and night lighting setups.',
        icon: Clock,
        color: 'text-violet-400',
        exampleLabel: 'Daylight Simulation',
        exampleImage: 'https://images.unsplash.com/photo-1497366216548-37526070297c?w=800&q=80'
    },
    'water-pool': {
        id: 'water-pool',
        title: 'Aquatic Engine',
        description: 'Add or enhance swimming pools with realistic water physics and reflections.',
        icon: Droplets,
        color: 'text-sky-400',
        exampleLabel: 'Luxury Pool Add',
        exampleImage: 'https://images.unsplash.com/photo-1576013551627-0cc20b96c2a7?w=800&q=80'
    },
    lawn: {
        id: 'lawn',
        title: 'Greenery Studio',
        description: 'Repair patchy grass or add professional landscaping to any exterior.',
        icon: Sprout,
        color: 'text-green-400',
        exampleLabel: 'Lush Landscaping',
        exampleImage: 'https://images.unsplash.com/photo-1592194996308-7b43878e84a6?w=800&q=80'
    }
};

export function DesignAgentTools() {
    const { activeTool, roomImage, addItem, setSidePanelVisible } = useCanvasStore();
    const [isGenerating, setIsGenerating] = useState(false);
    const fileInputRef = useRef<HTMLInputElement>(null);

    const config = activeTool ? TOOL_CONFIGS[activeTool] : null;

    useEffect(() => {
        // Reset state when tool changes
        setIsGenerating(false);
    }, [activeTool]);

    if (!config) return null;

    const Icon = config.icon;

    const handleGenerate = () => {
        if (!roomImage) return;
        setIsGenerating(true);
        // Simulate generation
        setTimeout(() => {
            setIsGenerating(false);
        }, 3000);
    };

    const handleLoadExample = () => {
        addItem({
            type: 'image',
            name: config.exampleLabel,
            src: config.exampleImage,
            x: 100,
            y: 100,
            width: 400,
            height: 300,
            rotation: 0,
            scaleX: 1,
            scaleY: 1,
            opacity: 1,
            locked: false,
            visible: true,
        });
    };

    return (
        <div className="flex h-full flex-col bg-[#0b0f1a] text-white overflow-hidden relative">
            {/* Header */}
            <div className="p-6 border-b border-white/5 bg-gradient-to-br from-[#1e293b]/50 to-[#0b0f1a]/50 relative overflow-hidden group">
                <button
                    onClick={() => setSidePanelVisible(false)}
                    className="absolute top-4 right-4 p-2 rounded-xl bg-white/5 border border-white/5 text-slate-500 hover:text-white hover:bg-white/10 transition-all z-20 group/close"
                >
                    <ChevronRight className="h-4 w-4 group-hover/close:translate-x-0.5 transition-transform" />
                </button>
                <div className={cn(
                    "absolute top-0 right-0 -mt-4 -mr-4 w-24 h-24 rounded-full blur-3xl transition-all duration-700 opacity-20 group-hover:opacity-40",
                    config.color.replace('text-', 'bg-')
                )} />

                <div className="flex items-center gap-2 mb-2 relative z-10">
                    <div className={cn("p-2 rounded-lg border", config.color.replace('text-', 'bg-') + '/20', config.color.replace('text-', 'border-') + '/30')}>
                        <Icon className={cn("h-4 w-4", config.color)} />
                    </div>
                    <div>
                        <h2 className="font-extrabold text-sm tracking-widest uppercase bg-clip-text text-transparent bg-gradient-to-r from-white to-slate-400">
                            {config.title}
                        </h2>
                        <div className={cn("h-0.5 w-12 rounded-full mt-0.5", config.color.replace('text-', 'bg-') + '/50')} />
                    </div>
                </div>
                <p className="text-xs text-slate-400 font-medium leading-relaxed relative z-10">
                    {config.description}
                </p>
            </div>

            <div className="flex-1 overflow-y-auto p-5 space-y-8 scrollbar-thin">
                {/* Visual Guide / Example */}
                <div className="space-y-4">
                    <div className="flex items-center justify-between">
                        <label className="text-[10px] font-black text-slate-500 uppercase tracking-[0.2em] flex items-center gap-2">
                             Reference Capability
                        </label>
                        <span className="text-[9px] text-purple-400 font-black px-2 py-0.5 rounded-full bg-purple-500/10 border border-purple-500/20 tracking-tighter uppercase">AI Powered</span>
                    </div>

                    <button
                        onClick={handleLoadExample}
                        className="group relative w-full aspect-video rounded-3xl overflow-hidden border border-white/5 bg-slate-900/50 hover:border-purple-500/50 transition-all duration-500 shadow-xl"
                    >
                        <Image
                            src={config.exampleImage}
                            alt={config.exampleLabel}
                            fill
                            className="object-cover transition-transform duration-1000 group-hover:scale-110 opacity-60 group-hover:opacity-100"
                        />
                        <div className="absolute inset-x-0 bottom-0 p-4 bg-gradient-to-t from-black/80 to-transparent">
                            <div className="flex items-center justify-between">
                                <span className="text-[10px] font-bold text-white uppercase tracking-widest">{config.exampleLabel}</span>
                                <div className="flex items-center gap-1.5 px-2 py-1 rounded-full bg-white/10 backdrop-blur-md border border-white/10 opacity-0 group-hover:opacity-100 transition-all">
                                    <Sparkles className="h-2.5 w-2.5 text-purple-400" />
                                    <span className="text-[8px] font-black uppercase text-white">Load Example</span>
                                </div>
                            </div>
                        </div>
                    </button>
                </div>

                {/* Upload Section */}
                <div className="space-y-4">
                    <label className="text-[10px] font-black text-slate-500 uppercase tracking-[0.2em]">Asset Source</label>
                    <button
                        onClick={() => fileInputRef.current?.click()}
                        className="w-full flex items-center justify-between p-4 rounded-2xl bg-slate-900/40 border border-white/5 hover:border-white/20 hover:bg-slate-800/50 transition-all group"
                    >
                        <div className="flex items-center gap-3">
                            <div className="w-10 h-10 rounded-xl bg-white/5 border border-white/10 flex items-center justify-center group-hover:scale-110 transition-transform">
                                <Upload className="h-4 w-4 text-slate-400 group-hover:text-white" />
                            </div>
                            <div className="text-left">
                                <p className="text-[11px] font-bold text-slate-200">Custom Upload</p>
                                <p className="text-[9px] text-slate-500 font-medium">PNG, JPG up to 10MB</p>
                            </div>
                        </div>
                        <ChevronRight className="h-4 w-4 text-slate-600 group-hover:text-white group-hover:translate-x-1 transition-all" />
                    </button>
                    <input ref={fileInputRef} type="file" accept="image/*" className="hidden" />
                </div>

                {/* AI Status / Info */}
                <div className="p-4 rounded-3xl bg-purple-500/5 border border-purple-500/10 flex gap-4 relative overflow-hidden group">
                    <div className="shrink-0 flex items-center justify-center w-8 h-8 rounded-xl bg-purple-500/10 border border-purple-500/20 text-purple-400">
                        <Info className="h-4 w-4" />
                    </div>
                    <div>
                        <p className="text-[9px] font-black text-purple-400 uppercase tracking-widest mb-1">Architecture Intel</p>
                        <p className="text-[10px] text-slate-400 leading-relaxed font-semibold">
                            Adaptive processing active. The engine will automatically detect scene depth and lighting.
                        </p>
                    </div>
                </div>
            </div>

            {/* Sticky Action Footer */}
            <div className="p-6 bg-gradient-to-t from-[#0f172a] via-[#0f172a]/95 to-transparent backdrop-blur-xl border-t border-white/5 relative">
                <div className="absolute inset-x-0 -top-px h-px bg-gradient-to-r from-transparent via-purple-500/30 to-transparent" />

                <button
                    onClick={handleGenerate}
                    disabled={!roomImage || isGenerating}
                    className={cn(
                        "group relative w-full py-4.5 rounded-[22px] font-black text-xs uppercase tracking-[0.2em] flex items-center justify-center gap-3 transition-all duration-500 overflow-hidden",
                        roomImage && !isGenerating
                            ? "bg-white text-black shadow-[0_12px_40px_-10px_rgba(255,255,255,0.2)] hover:shadow-[0_12px_40px_-5px_rgba(255,255,255,0.3)] hover:scale-[1.01] active:scale-[0.98]"
                            : "bg-slate-800 text-slate-500 cursor-not-allowed grayscale"
                    )}
                >
                    <div className="absolute inset-0 bg-gradient-to-r from-purple-500 to-indigo-500 opacity-0 group-hover:opacity-100 transition-opacity duration-500" />

                    <div className="relative z-10 flex items-center gap-3 group-hover:text-white transition-colors duration-300">
                        {isGenerating ? (
                            <>
                                <Loader2 className="h-5 w-5 animate-spin" />
                                <span className="animate-pulse">Processing Agent...</span>
                            </>
                        ) : (
                            <>
                                <Wand2 className="h-5 w-5 transition-transform group-hover:rotate-12 group-hover:scale-110" />
                                <span>Apply Transformation</span>
                            </>
                        )}
                    </div>
                </button>
            </div>
        </div>
    );
}
