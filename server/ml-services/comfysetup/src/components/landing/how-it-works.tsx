'use client';

import { motion } from 'framer-motion';
import { Upload, Armchair, Download } from 'lucide-react';
import Image from 'next/image';
import type { Dictionary } from '@/lib/i18n/config';

interface HowItWorksProps {
    dictionary: Dictionary;
}

export function HowItWorks({ dictionary }: HowItWorksProps) {
    const d = dictionary.landing.howItWorks;

    const steps = [
        {
            id: 1,
            title: d.steps.upload.title,
            description: d.steps.upload.description,
            icon: Upload,
            image: "/images/generated/living-room-empty.webp",
        },
        {
            id: 2,
            title: d.steps.choose.title,
            description: d.steps.choose.description,
            icon: Armchair,
            image: "/images/generated/kitchen-staged.webp",
        },
        {
            id: 3,
            title: d.steps.export.title,
            description: d.steps.export.description,
            icon: Download,
            image: "/images/generated/bedroom-staged.webp",
        }
    ];

    return (
        <section className="py-24 relative overflow-hidden bg-slate-950">
            {/* Background Glow */}
            <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[800px] h-[800px] bg-purple-500/10 rounded-full blur-[100px] pointer-events-none" />

            <div className="container mx-auto px-4 relative z-10">
                <div className="text-center max-w-2xl mx-auto mb-16">
                    <h2 className="text-3xl md:text-5xl font-bold text-white mb-6">
                        {d.title}
                    </h2>
                    <p className="text-lg text-slate-400">
                        {d.subtitle}
                    </p>
                </div>

                <div className="grid grid-cols-1 md:grid-cols-3 gap-8 md:gap-12">
                    {steps.map((step, index) => (
                        <motion.div
                            key={step.id}
                            initial={{ opacity: 0, y: 20 }}
                            whileInView={{ opacity: 1, y: 0 }}
                            transition={{ duration: 0.5, delay: index * 0.2 }}
                            viewport={{ once: true }}
                            className="relative group"
                        >
                            {/* Connector Line (Desktop) */}
                            {index < steps.length - 1 && (
                                <div className="hidden md:block absolute top-24 left-1/2 w-full h-0.5 bg-gradient-to-r from-purple-500/50 to-transparent -z-10 transform translate-x-1/2" />
                            )}

                            <div className="mb-8 relative mx-auto w-48 h-48 rounded-2xl glass-card flex items-center justify-center overflow-hidden group-hover:border-purple-500/50 transition-colors">
                                <div className="absolute inset-0 bg-gradient-to-br from-purple-500/10 to-pink-500/10 opacity-0 group-hover:opacity-100 transition-opacity" />
                                <Image src={step.image} alt={step.title} fill className="object-cover opacity-50 group-hover:opacity-100 transition-opacity" />
                                <div className="absolute inset-0 flex items-center justify-center">
                                    <step.icon className="w-12 h-12 text-purple-400 drop-shadow-[0_0_10px_rgba(168,85,247,0.5)]" />
                                </div>
                            </div>

                            <div className="text-center relative">
                                <div className="inline-flex items-center justify-center w-8 h-8 rounded-full bg-slate-800 border border-slate-700 text-white font-bold mb-4 shadow-xl">
                                    {step.id}
                                </div>
                                <h3 className="text-xl font-bold text-white mb-3">{step.title}</h3>
                                <p className="text-slate-400 leading-relaxed">
                                    {step.description}
                                </p>
                            </div>
                        </motion.div>
                    ))}
                </div>
            </div>
        </section>
    );
}
