'use client';

import { motion } from 'framer-motion';
import { AlertTriangle } from 'lucide-react';
import type { Dictionary } from '@/lib/i18n/config';

interface DisclaimerProps {
    dictionary: Dictionary;
}

export function Disclaimer({ dictionary }: DisclaimerProps) {
    return (
        <section className="bg-slate-950 py-16">
            <div className="mx-auto max-w-4xl px-4 sm:px-6 lg:px-8">
                <motion.div
                    initial={{ opacity: 0, y: 20 }}
                    whileInView={{ opacity: 1, y: 0 }}
                    viewport={{ once: true }}
                    className="rounded-xl border border-amber-500/20 bg-amber-500/5 p-6 sm:p-8"
                >
                    <div className="flex items-start gap-4">
                        <div className="flex h-10 w-10 shrink-0 items-center justify-center rounded-lg bg-amber-500/10">
                            <AlertTriangle className="h-5 w-5 text-amber-400" />
                        </div>
                        <div>
                            <h3 className="mb-2 text-lg font-semibold text-amber-200">
                                {dictionary.landing.disclaimer.title}
                            </h3>
                            <p className="text-sm leading-relaxed text-amber-100/70">
                                {dictionary.landing.disclaimer.text}
                            </p>
                        </div>
                    </div>
                </motion.div>
            </div>
        </section>
    );
}
