'use client';

import * as React from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { Copy, Check } from 'lucide-react';
import { cn } from '@/lib/utils';

interface CopyButtonProps {
    text: string;
    className?: string;
    size?: 'sm' | 'md';
}

export function CopyButton({ text, className, size = 'md' }: CopyButtonProps) {
    const [copied, setCopied] = React.useState(false);

    const handleCopy = async () => {
        try {
            await navigator.clipboard.writeText(text);
            setCopied(true);
            setTimeout(() => setCopied(false), 2000);
        } catch (err) {
            console.error('Failed to copy:', err);
        }
    };

    const sizes = {
        sm: 'h-8 w-8',
        md: 'h-10 w-10',
    };

    const iconSizes = {
        sm: 'h-3.5 w-3.5',
        md: 'h-4 w-4',
    };

    return (
        <button
            type="button"
            onClick={handleCopy}
            className={cn(
                'inline-flex items-center justify-center rounded-lg border border-slate-700 bg-slate-800 text-slate-400 transition-all hover:border-slate-600 hover:text-white focus:outline-none focus:ring-2 focus:ring-purple-500',
                sizes[size],
                className
            )}
            aria-label="Copy to clipboard"
        >
            <AnimatePresence mode="wait">
                {copied ? (
                    <motion.span
                        key="check"
                        initial={{ scale: 0 }}
                        animate={{ scale: 1 }}
                        exit={{ scale: 0 }}
                        className="text-green-400"
                    >
                        <Check className={iconSizes[size]} />
                    </motion.span>
                ) : (
                    <motion.span
                        key="copy"
                        initial={{ scale: 0 }}
                        animate={{ scale: 1 }}
                        exit={{ scale: 0 }}
                    >
                        <Copy className={iconSizes[size]} />
                    </motion.span>
                )}
            </AnimatePresence>
        </button>
    );
}

interface CopyBlockProps {
    text: string;
    label?: string;
    className?: string;
}

export function CopyBlock({ text, label, className }: CopyBlockProps) {
    return (
        <div className={cn('group relative', className)}>
            {label && (
                <div className="mb-2 flex items-center justify-between">
                    <span className="text-xs font-medium uppercase tracking-wider text-slate-500">
                        {label}
                    </span>
                    <CopyButton text={text} size="sm" />
                </div>
            )}
            <div className="relative rounded-lg border border-slate-700 bg-slate-900/50 p-4">
                <pre className="overflow-x-auto whitespace-pre-wrap break-words text-sm text-slate-300">
                    {text}
                </pre>
                {!label && (
                    <div className="absolute right-2 top-2">
                        <CopyButton text={text} size="sm" />
                    </div>
                )}
            </div>
        </div>
    );
}
