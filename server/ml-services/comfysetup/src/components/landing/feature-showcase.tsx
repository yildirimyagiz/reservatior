'use client';

import { useState } from 'react';
import { motion } from 'framer-motion';
import { ComparisonSlider } from './comparison-slider';
import { ReelsNav } from './reels-nav';
import { STAGING_IMAGES } from '@/lib/staging-images';
import type { Dictionary } from '@/lib/i18n/config';

interface FeatureShowcaseProps {
    dictionary: Dictionary;
}

export function FeatureShowcase({ dictionary }: FeatureShowcaseProps) {
    const d = dictionary.landing.featureShowcase;

    const reelFeatures = [
        {
            id: 'virtual-staging',
            label: d.items.staging.label,
            description: d.items.staging.description,
            longDescription: d.items.staging.longDescription,
            thumbnail: STAGING_IMAGES.livingRoom.after,
            before: STAGING_IMAGES.livingRoom.before,
            after: STAGING_IMAGES.livingRoom.after,
            link: '/editor?mode=staging',
        },
        {
            id: 'image-to-video',
            label: d.items.video.label,
            description: d.items.video.description,
            longDescription: d.items.video.longDescription,
            thumbnail: STAGING_IMAGES.bedroom.after,
            before: STAGING_IMAGES.bedroom.before,
            after: STAGING_IMAGES.bedroom.after,
            video: true,
            link: '/editor?mode=video',
        },
        {
            id: 'pamphlet',
            label: d.items.pamphlet.label,
            description: d.items.pamphlet.description,
            longDescription: d.items.pamphlet.longDescription,
            thumbnail: STAGING_IMAGES.kitchen.after,
            before: STAGING_IMAGES.kitchen.before,
            after: STAGING_IMAGES.kitchen.after,
            link: '/editor?mode=pamphlet',
        },
        {
            id: 'ready-to-reel',
            label: d.items.reels.label,
            description: d.items.reels.description,
            longDescription: d.items.reels.longDescription,
            thumbnail: STAGING_IMAGES.office.after,
            before: STAGING_IMAGES.office.before,
            after: STAGING_IMAGES.office.after,
            video: true,
            link: '/editor?mode=reels',
        }
    ];

    const [activeFeature, setActiveFeature] = useState(reelFeatures[0]);

    return (
        <div className="w-full max-w-7xl mx-auto px-4 py-8 md:py-16">
            <div className="flex flex-col gap-8 md:gap-12">

                {/* 1. Top Navigation: Reels Style */}
                <div className="w-full flex justify-center mb-4">
                    <ReelsNav
                        features={reelFeatures}
                        activeId={activeFeature.id}
                        onSelect={setActiveFeature}
                    />
                </div>

                <div className="text-center -mt-4 mb-4">
                    <p className="text-slate-400">{d.dragText}</p>
                </div>

                {/* 2. Main Visual Preview area */}
                <motion.div
                    key={activeFeature.id}
                    initial={{ opacity: 0, y: 20 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ duration: 0.5 }}
                    className="relative w-full max-w-5xl mx-auto rounded-[2rem] overflow-hidden border border-white/10 shadow-2xl bg-[#0B0F17] group"
                >
                    {/* The Comparison Component */}
                    <div className="aspect-[4/3] md:aspect-video relative">
                        <ComparisonSlider
                            beforeLabel={dictionary.common.before}
                            afterLabel={dictionary.common.after}
                            dragText={d.dragText}
                            examples={[{
                                id: activeFeature.id,
                                label: activeFeature.label,
                                before: activeFeature.before,
                                after: activeFeature.after
                            }]}
                        />
                    </div>

                    {/* Overlay Description */}
                    <div className="absolute bottom-0 left-0 right-0 bg-gradient-to-t from-black via-black/90 to-transparent pt-20 pb-8 px-8 md:px-12 flex flex-col md:flex-row items-end md:items-center justify-between gap-6 pointer-events-none">
                        <div className="pointer-events-auto max-w-2xl text-left">
                            <h3 className="text-2xl md:text-3xl font-bold text-white mb-2">
                                {activeFeature.label}
                            </h3>
                            <p className="text-slate-300 text-sm md:text-base leading-relaxed">
                                {activeFeature.longDescription}
                            </p>
                        </div>
                        <div className="pointer-events-auto shrink-0">
                            <a
                                href={activeFeature.link}
                                className="inline-flex items-center justify-center bg-white text-black hover:bg-slate-200 rounded-full px-8 py-3 text-base font-semibold transition-all hover:scale-105 active:scale-95"
                            >
                                {d.getStarted}
                            </a>
                        </div>
                    </div>
                </motion.div>

                {/* Bottom Tags */}
                <div className="flex justify-center gap-4 text-sm text-slate-500 mt-8">
                    <span>{d.footerNote}</span>
                </div>

            </div>
        </div>
    );
}
