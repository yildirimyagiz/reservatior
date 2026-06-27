'use client';

import { motion } from 'framer-motion';
import { Button } from '@/components/ui/button';
import { ArrowRight, CheckCircle2, DollarSign, Zap, Sparkles, PlayCircle } from 'lucide-react';
import type { Dictionary } from '@/lib/i18n/config';
import Image from 'next/image';
import Link from 'next/link';
import { useParams } from 'next/navigation';
import { ComparisonSlider } from './comparison-slider';

interface HeroProps {
    dictionary: Dictionary;
}

export function HeroSection({ dictionary }: HeroProps) {
    const params = useParams();
    const locale = params.locale as string;
    const d = dictionary.landing.hero;

    const infoPills = [
        { label: d.pills.why, icon: Zap },
        { label: d.pills.agents, icon: CheckCircle2 },
        { label: d.pills.results, icon: ArrowRight },
        { label: d.pills.pricing, icon: DollarSign },
    ];

    return (
        <section className="relative min-h-[90vh] flex items-center bg-[#020617] overflow-hidden pt-20">
            {/* 1. Animated Background Gradients */}
            <div className="absolute inset-0 pointer-events-none overflow-hidden">
                <motion.div
                    animate={{
                        scale: [1, 1.2, 1],
                        opacity: [0.3, 0.5, 0.3],
                    }}
                    transition={{ duration: 10, repeat: Infinity, ease: "easeInOut" }}
                    className="absolute -top-[10%] -left-[10%] w-[60%] h-[60%] bg-purple-600/20 rounded-full blur-[120px]"
                />
                <motion.div
                    animate={{
                        scale: [1, 1.3, 1],
                        opacity: [0.2, 0.4, 0.2],
                    }}
                    transition={{ duration: 12, repeat: Infinity, ease: "easeInOut", delay: 1 }}
                    className="absolute -bottom-[10%] -right-[10%] w-[60%] h-[60%] bg-blue-600/20 rounded-full blur-[120px]"
                />
                <div className="absolute inset-0 bg-[url('/grid.svg')] bg-center [mask-image:linear-gradient(180deg,white,rgba(255,255,255,0))]" />
            </div>

            <div className="relative z-10 max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 w-full">
                <div className="grid lg:grid-cols-2 gap-12 items-center">

                    {/* Left Column: Text Content */}
                    <div className="text-left space-y-8">
                        <motion.div
                            initial={{ opacity: 0, x: -20 }}
                            animate={{ opacity: 1, x: 0 }}
                            transition={{ duration: 0.6 }}
                            className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-purple-500/10 border border-purple-500/20 text-purple-400 text-xs font-bold uppercase tracking-widest"
                        >
                            <Sparkles className="h-3 w-3" />
                            {d.tagline}
                        </motion.div>

                        <motion.div
                            initial={{ opacity: 0, y: 20 }}
                            animate={{ opacity: 1, y: 0 }}
                            transition={{ duration: 0.6, delay: 0.1 }}
                        >
                            <h1 className="text-5xl md:text-7xl font-black tracking-tighter text-white leading-[0.9]">
                                {d.title.split(' ').slice(0, -2).join(' ')} <br />
                                <span className="text-transparent bg-clip-text bg-gradient-to-r from-purple-400 via-indigo-400 to-blue-400">
                                    {d.title.split(' ').slice(-2).join(' ')}
                                </span>
                            </h1>
                            <p className="mt-6 text-lg text-slate-400 max-w-xl leading-relaxed font-medium">
                                {d.subtitle}
                            </p>
                        </motion.div>

                        <motion.div
                            initial={{ opacity: 0, y: 20 }}
                            animate={{ opacity: 1, y: 0 }}
                            transition={{ duration: 0.6, delay: 0.2 }}
                            className="flex flex-wrap gap-4"
                        >
                            <Link href={`/${locale}/editor`}>
                                <Button size="lg" className="bg-white text-black hover:bg-slate-200 rounded-full px-8 h-14 text-base font-bold shadow-[0_0_20px_rgba(255,255,255,0.1)] transition-all hover:scale-105">
                                    {d.cta}
                                    <ArrowRight className="ml-2 h-5 w-5" />
                                </Button>
                            </Link>
                            <Button variant="outline" size="lg" className="border-slate-800 bg-slate-900/50 text-white hover:bg-slate-800 rounded-full px-8 h-14 text-base font-bold backdrop-blur-sm">
                                <PlayCircle className="mr-2 h-5 w-5 text-purple-400" />
                                {d.secondaryCta}
                            </Button>
                        </motion.div>

                        {/* Social Proof Mini */}
                        <motion.div
                            initial={{ opacity: 0 }}
                            animate={{ opacity: 1 }}
                            transition={{ duration: 1, delay: 0.4 }}
                            className="pt-4 flex items-center gap-6"
                        >
                            <div className="flex -space-x-3">
                                {[1, 2, 3, 4].map((i) => (
                                    <div key={i} className="h-10 w-10 rounded-full border-2 border-slate-950 bg-slate-800 overflow-hidden relative">
                                        <Image src={`https://i.pravatar.cc/100?img=${i+10}`} alt="User" fill />
                                    </div>
                                ))}
                            </div>
                            <div className="text-sm">
                                <p className="text-white font-bold">10,000+ Agents</p>
                                <p className="text-slate-500">Trust AtlasVS for listings</p>
                            </div>
                        </motion.div>

                        {/* Feature Pills */}
                        <motion.div
                            initial={{ opacity: 0, y: 10 }}
                            animate={{ opacity: 1, y: 0 }}
                            transition={{ duration: 0.6, delay: 0.5 }}
                            className="flex flex-wrap gap-3 pt-4"
                        >
                            {infoPills.map((pill, i) => (
                                <div
                                    key={i}
                                    className="flex items-center gap-2 px-3 py-1.5 rounded-lg bg-white/5 border border-white/5 text-[10px] font-bold text-slate-400"
                                >
                                    <pill.icon className="h-3 w-3 text-purple-500" />
                                    {pill.label}
                                </div>
                            ))}
                        </motion.div>
                    </div>

                    {/* Right Column: Hero Visual with Comparison Slider */}
                    <motion.div
                        initial={{ opacity: 0, scale: 0.9, y: 20 }}
                        animate={{ opacity: 1, scale: 1, y: 0 }}
                        transition={{ duration: 0.8, delay: 0.2 }}
                        className="relative group"
                    >
                        {/* Glow effect under the slider */}
                        <div className="absolute -inset-4 bg-gradient-to-r from-purple-600/30 to-blue-600/30 rounded-[2.5rem] blur-2xl opacity-50 group-hover:opacity-100 transition-opacity duration-500" />

                        <div className="relative rounded-[2rem] overflow-hidden border border-white/10 shadow-2xl aspect-[4/3] bg-slate-900">
                             <ComparisonSlider
                                beforeLabel={dictionary.common.before}
                                afterLabel={dictionary.common.after}
                                dragText={dictionary.landing.featureShowcase.dragText}
                                showLabels={true}
                                showDragText={true}
                                examples={[{
                                    id: 'hero-comparison',
                                    label: 'Luxury Staging',
                                    before: '/images/rooms/empty/living-room-1.jpg',
                                    after: '/images/rooms/staged/living-room-1.jpg'
                                }]}
                                className="h-full w-full p-0"
                            />

                            {/* Floating Badge */}
                            <motion.div
                                animate={{ y: [0, -5, 0] }}
                                transition={{ duration: 4, repeat: Infinity, ease: "easeInOut" }}
                                className="absolute top-6 left-6 z-30 bg-black/60 backdrop-blur-md border border-white/10 p-2.5 rounded-2xl flex items-center gap-2.5"
                            >
                                <div className="h-8 w-8 rounded-lg bg-indigo-600 flex items-center justify-center shadow-lg shadow-indigo-600/40">
                                    <Sparkles className="h-4 w-4 text-white" />
                                </div>
                                <div className="pr-1">
                                    <p className="text-[8px] text-slate-400 font-black uppercase tracking-widest leading-none mb-0.5">Premium Quality</p>
                                    <p className="text-white text-[10px] font-black leading-none">4K AI RENDERS</p>
                                </div>
                            </motion.div>
                        </div>
                    </motion.div>
                </div>
            </div>

            {/* Bottom Gradient Fade */}
            <div className="absolute bottom-0 left-0 right-0 h-32 bg-gradient-to-t from-[#020617] to-transparent z-20" />
        </section>
    );
}
