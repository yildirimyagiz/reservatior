'use client';

import { motion } from 'framer-motion';
import Link from 'next/link';
import { useParams } from 'next/navigation';
import { ArrowRight, CheckCircle2, Zap } from 'lucide-react';
import Image from 'next/image';
import type { Dictionary } from '@/lib/i18n/config';

interface Style {
    id: string;
    name: string;
    description: string;
    features: string[];
    image: string;
    beforeImage: string;
    premium?: boolean;
}

interface StylesGalleryProps {
    dictionary: Dictionary;
}

export function StylesGallery({ dictionary }: StylesGalleryProps) {
    const params = useParams();
    const locale = params.locale as string;
    const d = dictionary.landing.gallery;
    const stylesDict = dictionary.styles;

    const styles = [
        {
            id: 'modern-minimalist',
            ...stylesDict['modern-minimalist'],
            image: '/images/rooms/staged/living-room-1.jpg',
            beforeImage: '/images/rooms/empty/living-room-1.jpg',
        },
        {
            id: 'scandinavian',
            ...stylesDict['scandinavian'],
            image: '/images/rooms/staged/living-room-2.png',
            beforeImage: '/images/rooms/empty/living-room-2.png',
        },
        {
            id: 'industrial',
            ...stylesDict['industrial'],
            image: '/images/generated/office-staged.png',
            beforeImage: '/images/generated/office-empty.png',
        },
        {
            id: 'mid-century-modern',
            ...stylesDict['mid-century-modern'],
            image: '/images/rooms/staged/living-room-3.png',
            beforeImage: '/images/rooms/empty/living-room-3.png',
        },
        {
            id: 'luxury',
            ...stylesDict['luxury'],
            image: '/images/rooms/staged/living-room-1.jpg',
            beforeImage: '/images/rooms/empty/living-room-1.jpg',
            premium: true,
        },
        {
            id: 'bohemian',
            ...stylesDict['bohemian'],
            image: '/images/rooms/staged/living-room-3.png',
            beforeImage: '/images/rooms/empty/living-room-3.png',
        },
        {
            id: 'coastal',
            ...stylesDict['coastal'],
            image: '/images/rooms/staged/living-room-3.png',
            beforeImage: '/images/rooms/empty/living-room-3.png',
        },
        {
            id: 'japanese',
            ...stylesDict['japanese'],
            image: '/images/rooms/staged/living-room-2.png',
            beforeImage: '/images/rooms/empty/living-room-2.png',
        },
    ];

    return (
        <section className="relative py-24 overflow-hidden">
            {/* Background */}
            <div className="absolute inset-0 bg-gradient-to-b from-slate-900 to-slate-950" />
            <div className="absolute top-0 left-1/4 h-96 w-96 rounded-full bg-indigo-600/10 blur-[100px]" />
            <div className="absolute bottom-0 right-1/4 h-96 w-96 rounded-full bg-purple-600/10 blur-[100px]" />

            <div className="relative mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
                {/* Section Header */}
                <motion.div
                    initial={{ opacity: 0, y: 20 }}
                    whileInView={{ opacity: 1, y: 0 }}
                    viewport={{ once: true }}
                    className="text-center mb-16"
                >
                    <span className="inline-block px-4 py-1.5 rounded-full bg-indigo-500/10 text-indigo-400 text-sm font-medium mb-4">
                        {d.badge}
                    </span>
                    <h2 className="text-4xl md:text-5xl font-bold text-white mb-4">
                        {d.title}{' '}
                        <span className="bg-gradient-to-r from-indigo-400 to-purple-400 bg-clip-text text-transparent">
                            {d.titleSpan}
                        </span>
                    </h2>
                    <p className="text-lg text-slate-400 max-w-2xl mx-auto">
                        {d.subtitle}
                    </p>
                </motion.div>

                {/* Styles Horizontal Scroll on Mobile, Grid on Desktop */}
                <div className="relative">
                    {/* Desktop Grid */}
                    <div className="hidden lg:grid lg:grid-cols-4 gap-6">
                        {styles.map((style, index) => (
                            <StyleCard
                                key={style.id}
                                style={style}
                                locale={locale}
                                index={index}
                                dictionary={dictionary}
                            />
                        ))}
                    </div>

                    {/* Mobile/Tablet Horizontal Scroll */}
                    <div className="lg:hidden overflow-x-auto pb-6 scrollbar-hide">
                        <div className="flex gap-4 w-max px-4">
                            {styles.map((style, index) => (
                                <div key={style.id} className="w-72 flex-shrink-0">
                                    <StyleCard
                                        style={style}
                                        locale={locale}
                                        index={index}
                                        dictionary={dictionary}
                                    />
                                </div>
                            ))}
                        </div>
                    </div>
                </div>

                {/* View All Link */}
                <motion.div
                    initial={{ opacity: 0 }}
                    whileInView={{ opacity: 1 }}
                    viewport={{ once: true }}
                    className="text-center mt-12"
                >
                    <Link
                        href={`/${locale}/library?tab=styles`}
                        className="inline-flex items-center gap-2 text-purple-400 hover:text-purple-300 font-medium transition-colors"
                    >
                        {d.exploreAll}
                        <ArrowRight className="h-4 w-4" />
                    </Link>
                </motion.div>
            </div>
        </section>
    );
}

interface StyleCardProps {
    style: Style;
    locale: string;
    index: number;
    dictionary: Dictionary;
}

function StyleCard({ style, locale, index, dictionary }: StyleCardProps) {
    return (
        <motion.div
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ delay: index * 0.05 }}
        >
            <Link
                href={`/${locale}/editor?style=${style.id}`}
                className="group relative block overflow-hidden rounded-2xl border border-slate-800 bg-slate-900/50 backdrop-blur-sm transition-all duration-300 hover:border-slate-700 hover:shadow-2xl hover:shadow-purple-500/10"
            >
                {/* Image Wrap */}
                <div className="relative h-56 overflow-hidden">
                    {/* Staged Image (Main) */}
                    <Image
                        src={style.image}
                        alt={style.name}
                        fill
                        className="object-cover transition-all duration-700 group-hover:scale-110 group-hover:opacity-0"
                    />

                    {/* Before Image (Revealed on hover) */}
                    <Image
                        src={style.beforeImage}
                        alt="Before"
                        fill
                        className="object-cover opacity-0 transition-opacity duration-700 group-hover:opacity-100 scale-110"
                    />

                    {/* Overlay Gradient */}
                    <div className="absolute inset-0 bg-gradient-to-t from-slate-900 via-slate-900/20 to-transparent" />

                    {/* Premium/4K Badges */}
                    <div className="absolute top-4 right-4 flex flex-col gap-2 items-end">
                        {style.premium && (
                            <span className="px-3 py-1 rounded-full bg-gradient-to-r from-amber-500 to-orange-500 text-white text-[10px] font-black shadow-lg">
                                {dictionary.landing.gallery.premium}
                            </span>
                        )}
                        <span className="px-2 py-1 rounded-md bg-white/10 backdrop-blur-md border border-white/10 text-white text-[8px] font-black tracking-widest">
                            4K RENDER
                        </span>
                    </div>

                    {/* Transforming Label (Shown on hover) */}
                    <div className="absolute inset-0 flex items-center justify-center opacity-0 group-hover:opacity-100 transition-opacity duration-500 pointer-events-none">
                        <span className="px-4 py-2 rounded-full bg-black/60 backdrop-blur-md border border-white/20 text-white text-xs font-bold flex items-center gap-2 transform translate-y-4 group-hover:translate-y-0 transition-transform duration-500">
                            <Zap className="h-3 w-3 text-yellow-400" />
                            See Transformation
                        </span>
                    </div>
                </div>

                {/* Content */}
                <div className="p-5">
                    <h3 className="text-lg font-semibold text-white mb-1 group-hover:text-purple-300 transition-colors">
                        {style.name}
                    </h3>
                    <p className="text-sm text-slate-500 mb-3 line-clamp-2">
                        {style.description}
                    </p>

                    {/* Features */}
                    <div className="flex flex-wrap gap-1.5">
                        {style.features.map((feature: string) => (
                            <span
                                key={feature}
                                className="inline-flex items-center gap-1 px-2 py-0.5 rounded-full bg-slate-800 text-xs text-slate-400"
                            >
                                <CheckCircle2 className="h-3 w-3 text-green-500" />
                                {feature}
                            </span>
                        ))}
                    </div>
                </div>
            </Link>
        </motion.div>
    );
}
