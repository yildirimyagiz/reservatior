'use client';

import { useState, useRef, useEffect } from 'react';
import { ChevronsLeftRight, ImageIcon } from 'lucide-react';
import Image from 'next/image';
import { cn } from '@/lib/utils';
import { motion, AnimatePresence } from 'framer-motion';

interface ComparisonExample {
    id: string;
    label: string;
    before: string;
    after: string;
}

interface ComparisonSliderProps {
    examples: ComparisonExample[];
    beforeLabel?: string;
    afterLabel?: string;
    dragText?: string;
    showLabels?: boolean;
    showDragText?: boolean;
}

export function ComparisonSlider({
    examples,
    beforeLabel = "Original",
    afterLabel = "Virtual Staging",
    dragText = "Drag slider to see the magic",
    showLabels = true,
    showDragText = true,
    className
}: ComparisonSliderProps & { className?: string }) {
    const [activeId, setActiveId] = useState(examples[0].id);
    const [sliderPosition, setSliderPosition] = useState(50);
    const [isDragging, setIsDragging] = useState(false);
    const containerRef = useRef<HTMLDivElement>(null);

    const activeExample = examples.find(e => e.id === activeId) || examples[0];

    const [hasInteracted, setHasInteracted] = useState(false);

    // Auto-slide animation
    useEffect(() => {
        if (hasInteracted) return;

        let startTime: number;
        let animationFrame: number;

        const animate = (time: number) => {
            if (!startTime) startTime = time;
            const progress = (time - startTime) / 3000; // 3 seconds per cycle

            // Sine wave for smooth back-and-forth
            const val = 50 + Math.sin(progress * Math.PI * 2) * 35;
            setSliderPosition(val);

            animationFrame = requestAnimationFrame(animate);
        };

        animationFrame = requestAnimationFrame(animate);
        return () => cancelAnimationFrame(animationFrame);
    }, [hasInteracted]);

    const handleMove = (event: React.MouseEvent | React.TouchEvent) => {
        setHasInteracted(true);
        if (!containerRef.current) return;

        const containerRect = containerRef.current.getBoundingClientRect();
        let clientX;

        if ('touches' in event) {
            clientX = event.touches[0].clientX;
        } else {
            clientX = (event as React.MouseEvent).clientX;
        }

        const position = ((clientX - containerRect.left) / containerRect.width) * 100;
        setSliderPosition(Math.min(Math.max(position, 0), 100));
    };

    const handleMouseDown = () => {
        setHasInteracted(true);
        setIsDragging(true);
    };

    useEffect(() => {
        const handleGlobalMouseUp = () => setIsDragging(false);
        const handleGlobalMouseMove = (e: MouseEvent) => {
            if (isDragging) {
                if (!containerRef.current) return;
                const containerRect = containerRef.current.getBoundingClientRect();
                const position = ((e.clientX - containerRect.left) / containerRect.width) * 100;
                setSliderPosition(Math.min(Math.max(position, 0), 100));
            }
        };

        window.addEventListener('mouseup', handleGlobalMouseUp);
        window.addEventListener('mousemove', handleGlobalMouseMove);

        return () => {
            window.removeEventListener('mouseup', handleGlobalMouseUp);
            window.removeEventListener('mousemove', handleGlobalMouseMove);
        };
    }, [isDragging]);

    return (
        <div className={cn("w-full max-w-6xl mx-auto px-4", className)}>

            {/* Gallery Selector - only show if multiple examples */}
            {examples.length > 1 && (
                <div className="flex flex-wrap justify-center gap-4 mb-8">
                    {examples.map((ex) => (
                        <button
                            key={ex.id}
                            onClick={() => setActiveId(ex.id)}
                            className={cn(
                                "flex items-center gap-2 px-4 py-2 rounded-full text-sm font-medium transition-all duration-300 border",
                                activeId === ex.id
                                    ? "bg-white/10 border-purple-500/50 text-white shadow-[0_0_15px_rgba(168,85,247,0.3)]"
                                    : "bg-transparent border-white/5 text-slate-400 hover:text-white hover:bg-white/5"
                            )}
                        >
                            <ImageIcon className="w-4 h-4" />
                            {ex.label}
                        </button>
                    ))}
                </div>
            )}

            {showDragText && (
                <div className="text-center mb-6">
                    <p className="text-lg text-slate-300">{dragText}</p>
                </div>
            )}

            <div
                ref={containerRef}
                className="relative aspect-[4/3] md:aspect-video w-full overflow-hidden rounded-2xl border border-white/10 shadow-2xl select-none cursor-ew-resize group"
                onMouseDown={handleMouseDown}
                onTouchMove={handleMove}
                onTouchStart={handleMouseDown}
            >
                <AnimatePresence mode='wait'>
                    <motion.div
                        key={activeExample.id}
                        initial={{ opacity: 0 }}
                        animate={{ opacity: 1 }}
                        exit={{ opacity: 0 }}
                        transition={{ duration: 0.5 }}
                        className="absolute inset-0"
                    >
                        {/* Before Image (Background) */}
                        <div className="absolute inset-0 bg-slate-800">
                            <Image
                                src={activeExample.before}
                                alt="Before - Empty Room"
                                fill
                                className="object-cover"
                                draggable={false}
                            />
                                    {showLabels && (
                                        <div className="absolute top-4 left-4 bg-black/50 backdrop-blur-sm px-3 py-1 rounded-lg text-white text-sm font-medium z-10 border border-white/10">
                                            {beforeLabel}
                                        </div>
                                    )}
                                </div>

                        {/* After Image (Foreground, clipped) */}
                        <div
                            className="absolute inset-0 bg-slate-900 overflow-hidden"
                            style={{ clipPath: `inset(0 ${100 - sliderPosition}% 0 0)` }}
                        >
                            <Image
                                src={activeExample.after}
                                alt="After - Staged Room"
                                fill
                                className="object-cover"
                                draggable={false}
                            />
                                    {showLabels && (
                                        <div className="absolute top-4 right-4 bg-purple-600/80 backdrop-blur-sm px-3 py-1 rounded-lg text-white text-sm font-medium z-10 shadow-lg">
                                            {afterLabel}
                                        </div>
                                    )}
                                </div>
                    </motion.div>
                </AnimatePresence>

                {/* Slider Handle */}
                <div
                    className="absolute top-0 bottom-0 w-0.5 bg-white cursor-ew-resize z-20 shadow-[0_0_10px_rgba(0,0,0,0.5)]"
                    style={{ left: `${sliderPosition}%` }}
                >
                    <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-8 h-8 md:w-10 md:h-10 bg-white rounded-full shadow-xl flex items-center justify-center transform transition-transform group-hover:scale-110">
                        <ChevronsLeftRight className="w-4 h-4 md:w-5 md:h-5 text-slate-900" />
                    </div>
                </div>
            </div>
        </div>
    );
}
