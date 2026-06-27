'use client';

import { useState, useEffect } from 'react';
import Image from 'next/image';
import { cn } from '@/lib/utils';

interface AutoCompareSliderProps {
    beforeImage: string;
    afterImage: string;
    className?: string;
    duration?: number; // duration of one full cycle in ms
}

export function AutoCompareSlider({
    beforeImage,
    afterImage,
    className,
    duration = 5000
}: AutoCompareSliderProps) {
    const [sliderPos, setSliderPos] = useState(50);

    useEffect(() => {
        const startTime = Date.now();

        const animate = () => {
            const elapsed = Date.now() - startTime;
            // Use sine wave for smooth back and forth movement
            const pos = 50 + 45 * Math.sin((elapsed / duration) * 2 * Math.PI);
            setSliderPos(pos);
            requestAnimationFrame(animate);
        };

        const animationId = requestAnimationFrame(animate);
        return () => cancelAnimationFrame(animationId);
    }, [duration]);

    return (
        <div className={cn("relative overflow-hidden select-none group/auto", className)}>
            {/* After Image (Base) */}
            <Image
                src={afterImage}
                alt="After"
                fill
                className="object-cover"
                priority
            />

            {/* Before Image (Clipped) */}
            <div
                className="absolute inset-0 pointer-events-none"
                style={{ clipPath: `inset(0 ${100 - sliderPos}% 0 0)` }}
            >
                <Image
                    src={beforeImage}
                    alt="Before"
                    fill
                    className="object-cover"
                    priority
                />
            </div>

            {/* Decorative Slider Handle */}
            <div
                className="absolute inset-y-0 z-10 transition-transform duration-100 ease-linear pointer-events-none"
                style={{ left: `${sliderPos}%` }}
            >
                <div className="absolute inset-y-0 -left-px w-0.5 bg-white/80 shadow-[0_0_15px_rgba(255,255,255,0.5)]">
                    <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-6 h-6 bg-white rounded-full shadow-2xl flex items-center justify-center">
                        <div className="w-1 h-3 bg-slate-300 rounded-full mx-0.5" />
                        <div className="w-1 h-3 bg-slate-300 rounded-full mx-0.5" />
                    </div>
                </div>
            </div>

            {/* Status Badges */}
            <div className="absolute bottom-4 left-4 z-20 px-2 py-0.5 bg-black/40 backdrop-blur-md rounded-md border border-white/10 opacity-0 group-hover/auto:opacity-100 transition-opacity">
                <span className="text-[8px] font-black uppercase text-white tracking-widest">Before</span>
            </div>
            <div className="absolute bottom-4 right-4 z-20 px-2 py-0.5 bg-purple-500/40 backdrop-blur-md rounded-md border border-purple-500/20 opacity-0 group-hover/auto:opacity-100 transition-opacity">
                <span className="text-[8px] font-black uppercase text-white tracking-widest">After</span>
            </div>
        </div>
    );
}
