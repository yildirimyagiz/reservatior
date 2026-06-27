/* eslint-disable @next/next/no-img-element */
'use client';

import { useState, useRef, useEffect, useCallback } from 'react';
import { GripVertical } from 'lucide-react';

interface CompareSliderProps {
    beforeImage: string;
    afterImage: string;
    className?: string;
    beforeLabel?: string;
    afterLabel?: string;
}

export function CompareSlider({
    beforeImage,
    afterImage,
    className = '',
    beforeLabel = 'Original',
    afterLabel = 'Staged',
}: CompareSliderProps) {
    const [sliderPosition, setSliderPosition] = useState(50);
    const [isDragging, setIsDragging] = useState(false);
    const containerRef = useRef<HTMLDivElement>(null);

    const handleMove = useCallback(
        (clientX: number) => {
            if (!containerRef.current) return;
            const rect = containerRef.current.getBoundingClientRect();
            const x = Math.max(0, Math.min(clientX - rect.left, rect.width));
            const percentage = (x / rect.width) * 100;
            setSliderPosition(percentage);
        },
        []
    );

    const handleMouseUp = useCallback(() => setIsDragging(false), []);
    const handleTouchEnd = useCallback(() => setIsDragging(false), []);

    useEffect(() => {
        const handleMouseMove = (e: MouseEvent) => {
            if (!isDragging) return;
            handleMove(e.clientX);
        };

        const handleTouchMove = (e: TouchEvent) => {
            if (!isDragging) return;
            handleMove(e.touches[0].clientX);
        };

        if (isDragging) {
            window.addEventListener('mousemove', handleMouseMove);
            window.addEventListener('touchmove', handleTouchMove);
            window.addEventListener('mouseup', handleMouseUp);
            window.addEventListener('touchend', handleTouchEnd);
        }

        return () => {
            window.removeEventListener('mousemove', handleMouseMove);
            window.removeEventListener('touchmove', handleTouchMove);
            window.removeEventListener('mouseup', handleMouseUp);
            window.removeEventListener('touchend', handleTouchEnd);
        };
    }, [isDragging, handleMove, handleMouseUp, handleTouchEnd]);

    const handleInteractionStart = (e: React.MouseEvent | React.TouchEvent) => {
        setIsDragging(true);
        const clientX = 'touches' in e ? e.touches[0].clientX : e.clientX;
        handleMove(clientX);
    };

    return (
        <div
            ref={containerRef}
            className={`relative w-full h-full overflow-hidden select-none cursor-ew-resize group rounded-2xl ${className}`}
            onMouseDown={handleInteractionStart}
            onTouchStart={handleInteractionStart}
        >
            {/* After Image (Background) */}
            <img
                src={afterImage}
                alt="After"
                className="absolute top-0 left-0 w-full h-full object-cover"
            />
            {/* Label After */}
            <div className="absolute top-4 right-4 bg-black/60 text-white px-3 py-1 rounded-full text-xs font-semibold backdrop-blur-sm pointer-events-none shadow-sm">
                {afterLabel}
            </div>

            {/* Before Image (Clipped) */}
            <div
                className="absolute top-0 left-0 h-full overflow-hidden"
                style={{ width: `${sliderPosition}%` }}
            >
                <img
                    src={beforeImage}
                    alt="Before"
                    className="absolute top-0 left-0 max-w-none h-full object-cover"
                    style={{
                        width: containerRef.current ? containerRef.current.offsetWidth : '100%'
                    }}
                />
                {/* Label Before */}
                <div className="absolute top-4 left-4 bg-black/60 text-white px-3 py-1 rounded-full text-xs font-semibold backdrop-blur-sm pointer-events-none shadow-sm">
                    {beforeLabel}
                </div>
            </div>

            {/* Slider Handle */}
            <div
                className="absolute top-0 bottom-0 w-0.5 bg-white cursor-ew-resize shadow-[0_0_8px_rgba(0,0,0,0.5)]"
                style={{ left: `${sliderPosition}%` }}
            >
                <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-9 h-9 bg-white/90 backdrop-blur-sm rounded-full flex items-center justify-center shadow-lg transform active:scale-110 transition-transform border border-white/30">
                    <GripVertical className="w-4 h-4 text-slate-700" />
                </div>
            </div>
        </div>
    );
}
