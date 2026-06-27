'use client';

import { useCanvasStore } from '@/lib/store/canvas-store';
import { cn } from '@/lib/utils';
import { Check } from 'lucide-react';
import { useRef, useEffect } from 'react';

import { DesignStyle } from '@/lib/store/canvas-store';

const STYLES: { value: DesignStyle; label: string; color: string }[] = [
    { value: 'modern-minimalist', label: 'Minimalist', color: 'from-slate-300 to-slate-100' },
    { value: 'scandinavian', label: 'Scandinavian', color: 'from-amber-100 to-orange-50' },
    { value: 'industrial', label: 'Industrial', color: 'from-slate-700 to-slate-500' },
    { value: 'mid-century-modern', label: 'Mid-Century', color: 'from-orange-700 to-amber-600' },
    { value: 'bohemian', label: 'Bohemian', color: 'from-rose-400 to-orange-300' },
    { value: 'contemporary', label: 'Contemporary', color: 'from-blue-200 to-slate-200' },
    { value: 'traditional', label: 'Traditional', color: 'from-emerald-800 to-emerald-600' },
    { value: 'coastal', label: 'Coastal', color: 'from-cyan-400 to-blue-300' },
    { value: 'farmhouse', label: 'Farmhouse', color: 'from-stone-300 to-stone-100' },
    { value: 'luxury', label: 'Luxury', color: 'from-zinc-900 to-zinc-700' },
    { value: 'cyberpunk', label: 'Cyberpunk', color: 'from-pink-600 to-purple-900' },
    { value: 'japanese', label: 'Japanese', color: 'from-neutral-200 to-neutral-50' },
    { value: 'biophilic', label: 'Biophilic', color: 'from-green-600 to-emerald-400' },
    { value: 'art-deco', label: 'Art Deco', color: 'from-amber-200 to-yellow-600' },
];

export function StyleSelector() {
    const { style, setStyle } = useCanvasStore();
    const scrollRef = useRef<HTMLDivElement>(null);

    // Auto-scroll to selected item on mount
    useEffect(() => {
        if (scrollRef.current) {
            // Logic to scroll to selected could go here
        }
    }, []);

    return (
        <div className="space-y-3">
            <div className="flex items-center justify-between">
                <label className="text-sm font-medium text-slate-300">Interior Style</label>
                <span className="text-xs text-slate-500">{STYLES.find(s => s.value === style)?.label}</span>
            </div>
            
            <div 
                ref={scrollRef}
                className="flex gap-3 overflow-x-auto pb-4 pt-1 px-1 snap-x snap-mandatory scrollbar-thin scrollbar-thumb-slate-700 scrollbar-track-transparent"
                style={{ scrollbarWidth: 'thin' }}
            >
                {STYLES.map((item) => (
                    <button
                        key={item.value}
                        onClick={() => setStyle(item.value)}
                        className={cn(
                            "group relative flex-shrink-0 w-24 h-32 rounded-xl overflow-hidden transition-all duration-300 snap-center",
                            "hover:ring-2 hover:ring-purple-400/50 hover:scale-105",
                            style === item.value 
                                ? "ring-2 ring-purple-500 scale-105 shadow-lg shadow-purple-500/20" 
                                : "opacity-80 hover:opacity-100"
                        )}
                    >
                        {/* Simulated Image Background */}
                        <div className={cn(
                            "absolute inset-0 bg-gradient-to-br",
                            item.color
                        )} />
                        
                        {/* Overlay */}
                        <div className="absolute inset-0 bg-gradient-to-t from-black/80 via-black/20 to-transparent" />

                        {/* Selected Indicator */}
                        {style === item.value && (
                            <div className="absolute top-2 right-2 bg-purple-500 rounded-full p-0.5">
                                <Check className="w-3 h-3 text-white" />
                            </div>
                        )}

                        {/* Label */}
                        <div className="absolute bottom-3 left-0 right-0 text-center px-1">
                            <span className="text-xs font-medium text-white shadow-sm block truncate">
                                {item.label}
                            </span>
                        </div>
                    </button>
                ))}
            </div>
        </div>
    );
}
