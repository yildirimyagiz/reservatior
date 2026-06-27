'use client';

import * as React from 'react';
import { motion } from 'framer-motion';
import { cn } from '@/lib/utils';

interface ToggleProps {
    checked: boolean;
    onChange: (checked: boolean) => void;
    label?: string;
    description?: string;
    className?: string;
    disabled?: boolean;
}

export function Toggle({
    checked,
    onChange,
    label,
    description,
    className,
    disabled = false,
}: ToggleProps) {
    return (
        <label className={cn(
            'flex items-start gap-3',
            disabled ? 'cursor-not-allowed opacity-50' : 'cursor-pointer',
            className
        )}>
            <button
                type="button"
                role="switch"
                aria-checked={checked}
                disabled={disabled}
                onClick={() => !disabled && onChange(!checked)}
                className={cn(
                    'relative h-6 w-11 shrink-0 rounded-full transition-colors duration-200 focus:outline-none focus:ring-2 focus:ring-purple-500 focus:ring-offset-2 focus:ring-offset-slate-900',
                    checked ? 'bg-purple-600' : 'bg-slate-700'
                )}
            >
                <motion.span
                    className="absolute left-0.5 top-0.5 h-5 w-5 rounded-full bg-white shadow-md"
                    animate={{ x: checked ? 20 : 0 }}
                    transition={{ type: 'spring', stiffness: 500, damping: 30 }}
                />
            </button>
            {(label || description) && (
                <div className="flex flex-col">
                    {label && <span className="text-sm font-medium text-white">{label}</span>}
                    {description && <span className="text-xs text-slate-400">{description}</span>}
                </div>
            )}
        </label>
    );
}

interface ToggleGroupProps {
    value: string;
    onChange: (value: string) => void;
    options: { value: string; label: string; description?: string }[];
    className?: string;
}

export function ToggleGroup({ value, onChange, options, className }: ToggleGroupProps) {
    return (
        <div className={cn('flex rounded-lg border border-slate-700 p-1', className)}>
            {options.map((option) => (
                <button
                    key={option.value}
                    type="button"
                    onClick={() => onChange(option.value)}
                    className={cn(
                        'relative flex-1 rounded-md px-4 py-2 text-sm font-medium transition-colors',
                        value === option.value
                            ? 'text-white'
                            : 'text-slate-400 hover:text-slate-200'
                    )}
                >
                    {value === option.value && (
                        <motion.div
                            layoutId="toggle-bg"
                            className="absolute inset-0 rounded-md bg-purple-600"
                            transition={{ type: 'spring', stiffness: 500, damping: 35 }}
                        />
                    )}
                    <span className="relative z-10">{option.label}</span>
                </button>
            ))}
        </div>
    );
}
