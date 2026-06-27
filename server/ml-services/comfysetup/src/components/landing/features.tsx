'use client';

import { motion } from 'framer-motion';
import {
    Layers,
    Palette,
    Box,
    Cpu,
    Shield,
    FolderOpen,
} from 'lucide-react';
import { SpotlightCard } from '@/components/aceternity/spotlight';
import type { Dictionary } from '@/lib/i18n/config';

interface FeaturesProps {
    dictionary: Dictionary;
}

const iconMap = {
    staging: Layers,
    library: FolderOpen,
    recolor: Palette,
    '3d': Box,
    comfyui: Cpu,
    offline: Shield,
};

export function Features({ dictionary }: FeaturesProps) {
    const features = [
        { key: 'staging', title: 'Virtual Staging', description: 'Fill empty rooms with style' },
        { key: 'library', title: 'Asset Library', description: 'Professional furniture & decor' },
        { key: 'recolor', title: 'Recolor Walls', description: 'Try different paint colors' },
        { key: '3d', title: '3D Preview', description: 'View in 3D space' },
        { key: 'comfyui', title: 'ComfyUI Powered', description: 'Advanced AI generation' },
        { key: 'offline', title: 'Offline Mode', description: 'Work without internet' },
    ];

    return (
        <section id="features" className="bg-slate-950 py-24">
            <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
                {/* Section header */}
                <motion.div
                    initial={{ opacity: 0, y: 20 }}
                    whileInView={{ opacity: 1, y: 0 }}
                    viewport={{ once: true }}
                    className="mb-16 text-center"
                >
                    <h2 className="text-3xl font-bold text-white sm:text-4xl">
                        {dictionary.landing.features.title}
                    </h2>
                </motion.div>

                {/* Features grid */}
                <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
                    {features.map((feature, index) => {
                        const Icon = iconMap[feature.key as keyof typeof iconMap];
                        return (
                            <motion.div
                                key={feature.key}
                                initial={{ opacity: 0, y: 20 }}
                                whileInView={{ opacity: 1, y: 0 }}
                                viewport={{ once: true }}
                                transition={{ delay: index * 0.1 }}
                            >
                                <SpotlightCard className="h-full">
                                    <div className="mb-4 flex h-12 w-12 items-center justify-center rounded-lg bg-gradient-to-br from-purple-600/20 to-indigo-600/20">
                                        <Icon className="h-6 w-6 text-purple-400" />
                                    </div>
                                    <h3 className="mb-2 text-lg font-semibold text-white">
                                        {feature.title}
                                    </h3>
                                    <p className="text-sm text-slate-400">{feature.description}</p>
                                </SpotlightCard>
                            </motion.div>
                        );
                    })}
                </div>
            </div>
        </section>
    );
}
