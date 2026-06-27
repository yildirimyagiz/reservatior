'use client';

import Link from 'next/link';
import { useParams } from 'next/navigation';
import { motion } from 'framer-motion';
import { ArrowRight } from 'lucide-react';
import { Button } from '@/components/ui/button';
import type { Dictionary } from '@/lib/i18n/config';

interface CTAProps {
    dictionary: Dictionary;
}

export function CTA({ dictionary }: CTAProps) {
    const params = useParams();
    const locale = params.locale as string;
    const d = dictionary.landing.cta;

    return (
        <section className="bg-slate-950 py-24">
            <div className="mx-auto max-w-4xl px-4 text-center sm:px-6 lg:px-8">
                <motion.div
                    initial={{ opacity: 0, y: 20 }}
                    whileInView={{ opacity: 1, y: 0 }}
                    viewport={{ once: true }}
                    className="relative overflow-hidden rounded-2xl border border-slate-800 bg-gradient-to-b from-slate-800/50 to-slate-900/50 px-6 py-16 sm:px-12"
                >
                    {/* Background gradient */}
                    <div className="pointer-events-none absolute inset-0 bg-gradient-to-r from-purple-600/10 via-transparent to-indigo-600/10" />

                    <div className="relative">
                        <h2 className="mb-4 text-3xl font-bold text-white sm:text-4xl">
                            {d.title}
                        </h2>
                        <p className="mx-auto mb-8 max-w-xl text-slate-400">
                            {d.subtitle}
                        </p>
                        <Link href={`/${locale}/editor`}>
                            <Button size="lg" className="group">
                                {d.button}
                                <ArrowRight className="ml-2 h-4 w-4 transition-transform group-hover:translate-x-1" />
                            </Button>
                        </Link>
                    </div>
                </motion.div>
            </div>
        </section>
    );
}
