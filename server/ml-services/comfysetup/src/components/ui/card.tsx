'use client';

import * as React from 'react';
import { motion } from 'framer-motion';
import { cn } from '@/lib/utils';

interface CardProps {
    className?: string;
    hover?: boolean;
    children: React.ReactNode;
}

export function Card({ className, hover = true, children }: CardProps) {
    if (hover) {
        return (
            <motion.div
                className={cn(
                    'rounded-xl border border-slate-800 bg-gradient-to-b from-slate-800/50 to-slate-900/50 p-6 backdrop-blur-sm',
                    className
                )}
                whileHover={{ y: -2, borderColor: 'rgba(147, 51, 234, 0.3)' }}
                transition={{ duration: 0.2 }}
            >
                {children}
            </motion.div>
        );
    }

    return (
        <div
            className={cn(
                'rounded-xl border border-slate-800 bg-gradient-to-b from-slate-800/50 to-slate-900/50 p-6 backdrop-blur-sm',
                className
            )}
        >
            {children}
        </div>
    );
}

export function CardHeader({ className, ...props }: React.HTMLAttributes<HTMLDivElement>) {
    return <div className={cn('mb-4', className)} {...props} />;
}

export function CardTitle({ className, ...props }: React.HTMLAttributes<HTMLHeadingElement>) {
    return (
        <h3 className={cn('text-lg font-semibold text-white', className)} {...props} />
    );
}

export function CardDescription({ className, ...props }: React.HTMLAttributes<HTMLParagraphElement>) {
    return (
        <p className={cn('text-sm text-slate-400', className)} {...props} />
    );
}

export function CardContent({ className, ...props }: React.HTMLAttributes<HTMLDivElement>) {
    return <div className={cn('', className)} {...props} />;
}

export function CardFooter({ className, ...props }: React.HTMLAttributes<HTMLDivElement>) {
    return <div className={cn('mt-4 flex items-center', className)} {...props} />;
}
