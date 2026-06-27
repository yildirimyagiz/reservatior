'use client';

import { useCanvasStore, CanvasTool } from '@/lib/store/canvas-store';
import {
    Armchair,
    Eraser,
    Trash2,
    ScanLine,
    Layers,
    Snowflake,
    Sun,
    Sunset,
    Moon,
    Droplets,
    Sprout,
    Clock,
    Sparkles,
    Home
} from 'lucide-react';
import { cn } from '@/lib/utils';

interface ToolItem {
    id: CanvasTool;
    label: string;
    icon: React.ElementType;
}

const TOOLS: ToolItem[] = [
    { id: 'staging', label: 'AI Staging', icon: Sparkles },
    { id: 'furniture', label: 'Furniture', icon: Armchair },
    { id: 'eraser', label: 'Eraser', icon: Eraser },
    { id: 'declutter', label: 'Declutter', icon: Trash2 },
    { id: 'enhance', label: 'Enhance', icon: ScanLine },
    { id: 'material', label: 'Material', icon: Layers },
    { id: 'seasons', label: 'Seasons', icon: Snowflake },
    { id: 'rain-shine', label: 'Weather', icon: Sun },
    { id: 'natural-twilight', label: 'Twilight', icon: Sunset },
    { id: 'virtual-twilight', label: 'V.Twilight', icon: Moon },
    { id: 'night-day', label: 'Day/Night', icon: Clock },
    { id: 'water-pool', label: 'Pool', icon: Droplets },
    { id: 'lawn', label: 'Lawn', icon: Sprout },
    { id: 'layers', label: 'Layers', icon: Layers },
];

export function ToolsSidebar() {
    const { activeTool, setActiveTool, sidePanelVisible, setSidePanelVisible } = useCanvasStore();

    return (
        <div className="flex h-full w-full flex-col items-center bg-[#020617] py-6 shadow-2xl">
            {/* Logo */}
            <div className="mb-10 flex items-center justify-center w-12 h-12 rounded-[20px] bg-purple-600/20 border border-purple-500/30 group cursor-pointer hover:bg-purple-600/30 transition-all duration-300">
                <Home className="h-6 w-6 text-purple-400 group-hover:scale-110 transition-transform" />
            </div>

            {/* Scrollable Tool Icons - Envisioned Coordinated Scale */}
            <div className="flex-1 overflow-y-auto scrollbar-none w-full flex flex-col items-center gap-4 px-3">
                {TOOLS.map((tool) => {
                    const Icon = tool.icon;
                    const isActive = activeTool === tool.id;

                    return (
                        <button
                            key={tool.id}
                            onClick={() => {
                                if (activeTool === tool.id) {
                                    setSidePanelVisible(!sidePanelVisible);
                                } else {
                                    setActiveTool(tool.id);
                                    setSidePanelVisible(true);
                                }
                            }}
                            className={cn(
                                "w-full aspect-square flex flex-col items-center justify-center rounded-[22px] transition-all duration-300 group relative",
                                isActive
                                    ? 'bg-purple-600/20 text-purple-400 border border-purple-500/40 shadow-xl shadow-purple-900/20'
                                    : 'text-slate-500 hover:text-slate-300 hover:bg-white/5 border border-transparent hover:border-white/10'
                            )}
                        >
                            <Icon className={cn(
                                "h-[22px] w-[22px] transition-transform duration-300",
                                isActive ? "scale-110" : "group-hover:scale-110"
                            )} />
                            <span className={cn(
                                "text-[9px] font-black uppercase tracking-tight mt-2 transition-colors leading-none truncate w-full px-1 text-center",
                                isActive ? "text-purple-400" : "text-slate-600 group-hover:text-slate-400"
                            )}>
                                {tool.label}
                            </span>

                            {/* Tooltip for accessibility */}
                            <div className="absolute left-full ml-5 px-4 py-2 bg-[#0f172a] text-white text-[11px] font-black uppercase tracking-widest rounded-xl opacity-0 group-hover:opacity-100 pointer-events-none whitespace-nowrap transition-all duration-300 z-50 shadow-2xl border border-white/10 -translate-x-2 group-hover:translate-x-0">
                                {tool.label}
                                <div className="absolute top-1/2 -left-1 -translate-y-1/2 w-2 h-2 bg-[#0f172a] rotate-45 border-l border-b border-white/10" />
                            </div>
                        </button>
                    );
                })}
            </div>
        </div>
    );
}
