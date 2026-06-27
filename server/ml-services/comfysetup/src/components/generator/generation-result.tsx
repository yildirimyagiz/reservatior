'use client';

import { useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { Download, RefreshCw, Maximize2, X } from 'lucide-react';
import { Button } from '@/components/ui/button';
import type { Dictionary } from '@/lib/i18n/config';

interface GenerationResultProps {
    originalImage: string | null;
    generatedImage: string | null;
    isGenerating: boolean;
    progress?: string;
    onRegenerate: () => void;
    dictionary: Dictionary;
}

export function GenerationResult({
    originalImage,
    generatedImage,
    isGenerating,
    progress,
    onRegenerate,
    dictionary,
}: GenerationResultProps) {
    const [viewMode, setViewMode] = useState<'side-by-side' | 'slider' | 'full'>('side-by-side');
    const [sliderPosition, setSliderPosition] = useState(50);
    const [showFullscreen, setShowFullscreen] = useState(false);

    if (!originalImage && !generatedImage && !isGenerating) {
        return null;
    }

    const handleDownload = () => {
        if (!generatedImage) return;

        const link = document.createElement('a');
        link.href = generatedImage;
        link.download = `staged_room_${Date.now()}.png`;
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
    };

    return (
        <div className="mt-6 rounded-xl border border-slate-700 bg-slate-800/50 p-6">
            <div className="mb-4 flex items-center justify-between">
                <h3 className="text-lg font-semibold text-white">
                    {isGenerating ? 'Generating...' : 'Result'}
                </h3>

                {generatedImage && (
                    <div className="flex items-center gap-2">
                        <div className="flex rounded-lg border border-slate-700 p-1">
                            <button
                                onClick={() => setViewMode('side-by-side')}
                                className={`rounded px-2 py-1 text-xs ${viewMode === 'side-by-side'
                                        ? 'bg-purple-600 text-white'
                                        : 'text-slate-400 hover:text-white'
                                    }`}
                            >
                                Side by Side
                            </button>
                            <button
                                onClick={() => setViewMode('slider')}
                                className={`rounded px-2 py-1 text-xs ${viewMode === 'slider'
                                        ? 'bg-purple-600 text-white'
                                        : 'text-slate-400 hover:text-white'
                                    }`}
                            >
                                Slider
                            </button>
                        </div>
                        <Button variant="ghost" size="sm" onClick={() => setShowFullscreen(true)}>
                            <Maximize2 className="h-4 w-4" />
                        </Button>
                    </div>
                )}
            </div>

            {/* Loading State */}
            {isGenerating && (
                <div className="flex flex-col items-center justify-center rounded-lg bg-slate-900/50 py-16">
                    <div className="mb-4 h-12 w-12 animate-spin rounded-full border-4 border-purple-500 border-t-transparent" />
                    <p className="text-sm text-slate-400">{progress || 'Processing with AI Engine...'}</p>
                    <p className="mt-2 text-xs text-slate-500">This may take 30-60 seconds</p>
                </div>
            )}

            {/* Result Display */}
            {generatedImage && !isGenerating && (
                <>
                    {viewMode === 'side-by-side' && (
                        <div className="grid gap-4 md:grid-cols-2">
                            {originalImage && (
                                <div>
                                    <p className="mb-2 text-xs font-medium text-slate-500">ORIGINAL</p>
                                    <div className="overflow-hidden rounded-lg border border-slate-700">
                                        {/* eslint-disable-next-line @next/next/no-img-element */}
                                        <img
                                            src={originalImage}
                                            alt="Original room"
                                            className="h-auto w-full object-cover"
                                        />
                                    </div>
                                </div>
                            )}
                            <div>
                                <p className="mb-2 text-xs font-medium text-slate-500">STAGED</p>
                                <div className="overflow-hidden rounded-lg border border-purple-500/50">
                                    {/* eslint-disable-next-line @next/next/no-img-element */}
                                    <img
                                        src={generatedImage}
                                        alt="Staged room"
                                        className="h-auto w-full object-cover"
                                    />
                                </div>
                            </div>
                        </div>
                    )}

                    {viewMode === 'slider' && originalImage && (
                        <div className="relative overflow-hidden rounded-lg border border-slate-700">
                            {/* eslint-disable-next-line @next/next/no-img-element */}
                            <img
                                src={generatedImage}
                                alt="Staged room"
                                className="h-auto w-full object-cover"
                            />
                            <div
                                className="absolute inset-y-0 left-0 overflow-hidden border-r-2 border-white"
                                style={{ width: `${sliderPosition}%` }}
                            >
                                {/* eslint-disable-next-line @next/next/no-img-element */}
                                <img
                                    src={originalImage}
                                    alt="Original room"
                                    className="h-full w-auto max-w-none object-cover"
                                    style={{ width: `${100 / (sliderPosition / 100)}%` }}
                                />
                            </div>
                            <input
                                type="range"
                                min="0"
                                max="100"
                                value={sliderPosition}
                                onChange={(e) => setSliderPosition(Number(e.target.value))}
                                className="absolute inset-0 h-full w-full cursor-ew-resize opacity-0"
                            />
                            <div
                                className="pointer-events-none absolute inset-y-0 flex items-center"
                                style={{ left: `${sliderPosition}%`, transform: 'translateX(-50%)' }}
                            >
                                <div className="h-full w-0.5 bg-white" />
                                <div className="absolute rounded-full bg-white p-2 shadow-lg">
                                    <svg className="h-4 w-4 text-slate-900" viewBox="0 0 24 24" fill="none" stroke="currentColor">
                                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M8 9l4-4 4 4m0 6l-4 4-4-4" />
                                    </svg>
                                </div>
                            </div>
                        </div>
                    )}

                    {/* Actions */}
                    <div className="mt-4 flex justify-end gap-2">
                        <Button variant="secondary" onClick={onRegenerate}>
                            <RefreshCw className="mr-2 h-4 w-4" />
                            Regenerate
                        </Button>
                        <Button onClick={handleDownload}>
                            <Download className="mr-2 h-4 w-4" />
                            {dictionary.common.download}
                        </Button>
                    </div>
                </>
            )}

            {/* Fullscreen Modal */}
            <AnimatePresence>
                {showFullscreen && generatedImage && (
                    <motion.div
                        initial={{ opacity: 0 }}
                        animate={{ opacity: 1 }}
                        exit={{ opacity: 0 }}
                        className="fixed inset-0 z-50 flex items-center justify-center bg-black/90 p-4"
                        onClick={() => setShowFullscreen(false)}
                    >
                        <button
                            className="absolute right-4 top-4 rounded-lg bg-slate-800 p-2 text-white"
                            onClick={() => setShowFullscreen(false)}
                        >
                            <X className="h-6 w-6" />
                        </button>
                        {/* eslint-disable-next-line @next/next/no-img-element */}
                        <img
                            src={generatedImage}
                            alt="Staged room fullscreen"
                            className="max-h-[90vh] max-w-[90vw] object-contain"
                            onClick={(e) => e.stopPropagation()}
                        />
                    </motion.div>
                )}
            </AnimatePresence>
        </div>
    );
}
