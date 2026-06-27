'use client';

import { motion, AnimatePresence } from 'framer-motion';
import { useEditorStore } from '@/lib/store/editor-store';
import {
    formatPromptOutput,
} from '@/lib/prompt-engine';
import { CopyBlock } from '@/components/ui/copy-button';
import { Button } from '@/components/ui/button';
import { Copy, Check } from 'lucide-react';
import { useState } from 'react';
import type { Dictionary } from '@/lib/i18n/config';

interface PromptOutputProps {
    dictionary: Dictionary;
}

export function PromptOutput({ dictionary }: PromptOutputProps) {
    const [copiedAll, setCopiedAll] = useState(false);
    const { generatedPrompt } = useEditorStore();

    if (!generatedPrompt) return null;

    const fullOutput = formatPromptOutput(generatedPrompt);

    const handleCopyAll = async () => {
        try {
            await navigator.clipboard.writeText(fullOutput);
            setCopiedAll(true);
            setTimeout(() => setCopiedAll(false), 2000);
        } catch (err) {
            console.error('Failed to copy:', err);
        }
    };

    return (
        <AnimatePresence>
            <motion.div
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                exit={{ opacity: 0, y: 20 }}
                className="rounded-xl border border-slate-700 bg-slate-800/50 p-6"
            >
                <div className="mb-4 flex items-center justify-between">
                    <h3 className="text-lg font-semibold text-white">
                        {dictionary.output.title}
                    </h3>
                    <Button
                        variant="secondary"
                        size="sm"
                        onClick={handleCopyAll}
                        className="gap-2"
                    >
                        {copiedAll ? (
                            <>
                                <Check className="h-4 w-4" />
                                {dictionary.common.copied}
                            </>
                        ) : (
                            <>
                                <Copy className="h-4 w-4" />
                                {dictionary.output.copyAll}
                            </>
                        )}
                    </Button>
                </div>

                <div className="space-y-4">
                    <CopyBlock
                        label={dictionary.output.positivePrompt}
                        text={generatedPrompt.positive}
                    />
                    <CopyBlock
                        label={dictionary.output.negativePrompt}
                        text={generatedPrompt.negative}
                    />
                    <CopyBlock
                        label={dictionary.output.settings}
                        text={[
                            `Steps: ${generatedPrompt.settings.steps[0]}-${generatedPrompt.settings.steps[1]}`,
                            `Resolution: ${generatedPrompt.settings.resolution}`,
                            `Sampler: ${generatedPrompt.settings.sampler}`,
                            generatedPrompt.settings.controlNetDepthStrength
                                ? `ControlNet Depth: ${generatedPrompt.settings.controlNetDepthStrength[0]}-${generatedPrompt.settings.controlNetDepthStrength[1]}`
                                : '',
                            generatedPrompt.settings.ipAdapterStrength
                                ? `IP-Adapter: ${generatedPrompt.settings.ipAdapterStrength[0]}-${generatedPrompt.settings.ipAdapterStrength[1]}`
                                : '',
                        ]
                            .filter(Boolean)
                            .join('\n')}
                    />
                </div>

                {/* Disclaimer */}
                <div className="mt-4 rounded-lg border border-amber-500/20 bg-amber-500/5 p-3">
                    <p className="text-xs text-amber-200/70">
                        {dictionary.output.disclaimer}
                    </p>
                </div>
            </motion.div>
        </AnimatePresence>
    );
}
