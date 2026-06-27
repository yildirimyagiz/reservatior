'use client';

import * as React from 'react';
import * as DialogPrimitive from '@radix-ui/react-dialog';
import { X, Check, Lock } from 'lucide-react';
import { cn } from '@/lib/utils';
import { Button } from '@/components/ui/button';
import Image from 'next/image';

interface SelectionOption {
    value: string;
    label: string;
    image?: string;
    icon?: React.ElementType;
    locked?: boolean;
}

interface SelectionModalProps {
    open: boolean;
    onOpenChange: (open: boolean) => void;
    title: string;
    options: SelectionOption[];
    selectedValue: string;
    onSelect: (value: string) => void;
}

export function SelectionModal({
    open,
    onOpenChange,
    title,
    options,
    selectedValue,
    onSelect,
}: SelectionModalProps) {
    return (
        <DialogPrimitive.Root open={open} onOpenChange={onOpenChange}>
            <DialogPrimitive.Portal>
                <DialogPrimitive.Overlay className="fixed inset-0 z-50 bg-black/50 backdrop-blur-sm data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0" />
                <DialogPrimitive.Content className="fixed left-[50%] top-[50%] z-50 w-full max-w-3xl translate-x-[-50%] translate-y-[-50%] rounded-2xl bg-white p-6 shadow-2xl duration-200 data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95 data-[state=closed]:slide-out-to-left-1/2 data-[state=closed]:slide-out-to-top-[48%] data-[state=open]:slide-in-from-left-1/2 data-[state=open]:slide-in-from-top-[48%] sm:rounded-3xl">
                    <div className="flex items-center justify-between mb-6">
                        <DialogPrimitive.Title className="text-xl font-bold text-slate-900">
                            {title}
                        </DialogPrimitive.Title>
                        <DialogPrimitive.Close className="rounded-full p-2 text-slate-400 hover:bg-slate-100 transition-colors">
                            <X className="h-5 w-5" />
                        </DialogPrimitive.Close>
                    </div>

                    <div className="grid grid-cols-2 md:grid-cols-4 lg:grid-cols-5 gap-4 overflow-y-auto max-h-[60vh] pr-2 scrollbar-thin">
                        {options.map((option) => (
                            <button
                                key={option.value}
                                onClick={() => !option.locked && onSelect(option.value)}
                                className={cn(
                                    "group relative flex flex-col gap-2 transition-all p-1 rounded-2xl",
                                    option.locked && "cursor-not-allowed opacity-60"
                                )}
                            >
                                <div className={cn(
                                    "relative aspect-square rounded-xl overflow-hidden border-2 transition-all bg-slate-100",
                                    selectedValue === option.value
                                        ? "border-black ring-1 ring-black/10"
                                        : "border-transparent group-hover:border-slate-300"
                                )}>
                                    {option.image ? (
                                        <Image
                                            src={option.image}
                                            alt={option.label}
                                            fill
                                            className="object-cover"
                                        />
                                    ) : option.icon ? (
                                        <div className="w-full h-full flex items-center justify-center bg-slate-100 text-slate-400">
                                            <option.icon className="w-8 h-8" />
                                        </div>
                                    ) : null}

                                    {/* Selected Badge */}
                                    {selectedValue === option.value && (
                                        <div className="absolute top-2 right-2 bg-black text-white p-1 rounded-full shadow-lg">
                                            <Check className="h-3 w-3" />
                                        </div>
                                    )}

                                    {/* Locked Badge */}
                                    {option.locked && (
                                        <div className="absolute inset-0 bg-black/20 flex items-center justify-center">
                                            <div className="bg-white/90 p-1.5 rounded-full shadow-lg">
                                                <Lock className="h-4 w-4 text-slate-900" />
                                            </div>
                                        </div>
                                    )}
                                </div>
                                <span className={cn(
                                    "text-xs font-semibold text-center truncate px-1",
                                    selectedValue === option.value ? "text-slate-900" : "text-slate-500"
                                )}>
                                    {option.label}
                                </span>
                            </button>
                        ))}
                    </div>

                    <div className="mt-8 flex justify-end">
                        <Button
                            onClick={() => onOpenChange(false)}
                            className="bg-black hover:bg-slate-800 text-white rounded-xl px-8 py-6 h-auto text-base font-bold shadow-xl flex items-center gap-2"
                        >
                            Select
                            <X className="h-4 w-4 rotate-45" /> {/* Arrow-like effect */}
                        </Button>
                    </div>
                </DialogPrimitive.Content>
            </DialogPrimitive.Portal>
        </DialogPrimitive.Root>
    );
}
