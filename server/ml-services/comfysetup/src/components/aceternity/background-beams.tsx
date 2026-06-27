'use client';

import { useEffect, useRef, useState } from 'react';
import { motion } from 'framer-motion';
import { cn } from '@/lib/utils';

export function BackgroundBeams({ className }: { className?: string }) {
    const [mousePosition, setMousePosition] = useState({ x: 0, y: 0 });
    const ref = useRef<HTMLDivElement>(null);

    useEffect(() => {
        const handleMouseMove = (e: MouseEvent) => {
            if (ref.current) {
                const rect = ref.current.getBoundingClientRect();
                setMousePosition({
                    x: e.clientX - rect.left,
                    y: e.clientY - rect.top,
                });
            }
        };

        window.addEventListener('mousemove', handleMouseMove);
        return () => window.removeEventListener('mousemove', handleMouseMove);
    }, []);

    return (
        <div
            ref={ref}
            className={cn(
                'pointer-events-none absolute inset-0 overflow-hidden',
                className
            )}
        >
            {/* Gradient beams */}
            <div className="absolute inset-0">
                {[...Array(6)].map((_, i) => (
                    <motion.div
                        key={i}
                        className="absolute h-[1px] w-full"
                        style={{
                            top: `${15 + i * 15}%`,
                            background: `linear-gradient(90deg, transparent, rgba(120, 119, 198, 0.2) ${20 + i * 10}%, rgba(147, 51, 234, 0.1) ${50 + i * 5}%, transparent)`,
                        }}
                        animate={{
                            x: [-100, 100],
                            opacity: [0.3, 0.6, 0.3],
                        }}
                        transition={{
                            duration: 8 + i * 2,
                            repeat: Infinity,
                            repeatType: 'reverse',
                            ease: 'easeInOut',
                            delay: i * 0.5,
                        }}
                    />
                ))}
            </div>

            {/* Radial gradient following mouse */}
            <motion.div
                className="absolute h-96 w-96 rounded-full opacity-30"
                style={{
                    background:
                        'radial-gradient(circle, rgba(147, 51, 234, 0.15), transparent 60%)',
                    left: mousePosition.x - 192,
                    top: mousePosition.y - 192,
                }}
                transition={{ type: 'spring', damping: 30, stiffness: 200 }}
            />

            {/* Grid */}
            <div
                className="absolute inset-0 opacity-[0.02]"
                style={{
                    backgroundImage: `linear-gradient(rgba(255,255,255,0.1) 1px, transparent 1px),
                            linear-gradient(90deg, rgba(255,255,255,0.1) 1px, transparent 1px)`,
                    backgroundSize: '60px 60px',
                }}
            />
        </div>
    );
}
