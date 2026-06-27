'use client';

import * as React from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { ChevronDown } from 'lucide-react';
import { cn } from '@/lib/utils';

interface SelectOption {
    value: string;
    label: string;
}

interface SelectProps {
    value: string;
    onChange: (value: string) => void;
    options: SelectOption[];
    placeholder?: string;
    className?: string;
    label?: string;
}

export function Select({
    value,
    onChange,
    options,
    placeholder = 'Select...',
    className,
    label,
}: SelectProps) {
    const [isOpen, setIsOpen] = React.useState(false);
    const ref = React.useRef<HTMLDivElement>(null);

    const selectedOption = options.find((o) => o.value === value);

    React.useEffect(() => {
        const handleClickOutside = (e: MouseEvent) => {
            if (ref.current && !ref.current.contains(e.target as Node)) {
                setIsOpen(false);
            }
        };
        document.addEventListener('mousedown', handleClickOutside);
        return () => document.removeEventListener('mousedown', handleClickOutside);
    }, []);

    return (
        <div className={cn('relative', className)} ref={ref}>
            {label && (
                <label className="mb-2 block text-sm font-medium text-slate-300">
                    {label}
                </label>
            )}
            <button
                type="button"
                onClick={() => setIsOpen(!isOpen)}
                className="flex w-full items-center justify-between rounded-lg border border-slate-700 bg-slate-800/50 px-4 py-2.5 text-left text-sm text-white transition-colors hover:border-slate-600 focus:border-purple-500 focus:outline-none focus:ring-1 focus:ring-purple-500"
            >
                <span className={selectedOption ? 'text-white' : 'text-slate-400'}>
                    {selectedOption?.label || placeholder}
                </span>
                <ChevronDown
                    className={cn(
                        'h-4 w-4 text-slate-400 transition-transform',
                        isOpen && 'rotate-180'
                    )}
                />
            </button>

            <AnimatePresence>
                {isOpen && (
                    <motion.div
                        initial={{ opacity: 0, y: -10 }}
                        animate={{ opacity: 1, y: 0 }}
                        exit={{ opacity: 0, y: -10 }}
                        transition={{ duration: 0.15 }}
                        className="absolute z-50 mt-2 w-full rounded-lg border border-slate-700 bg-slate-800 py-1 shadow-xl"
                    >
                        {options.map((option) => (
                            <button
                                key={option.value}
                                type="button"
                                onClick={() => {
                                    onChange(option.value);
                                    setIsOpen(false);
                                }}
                                className={cn(
                                    'flex w-full items-center px-4 py-2 text-left text-sm transition-colors',
                                    option.value === value
                                        ? 'bg-purple-600/20 text-purple-300'
                                        : 'text-slate-300 hover:bg-slate-700'
                                )}
                            >
                                {option.label}
                            </button>
                        ))}
                    </motion.div>
                )}
            </AnimatePresence>
        </div>
    );
}
