'use client';

import { motion } from 'framer-motion';
import Link from 'next/link';
import { useParams } from 'next/navigation';
import {
    Sofa, Wand2, Video, Box, ImageIcon, Sparkles,
    ArrowRight, CheckCircle2
} from 'lucide-react';
import { cn } from '@/lib/utils';

const SERVICES = [
    {
        id: 'virtual-staging',
        title: 'Virtual Staging',
        description: 'Transform empty rooms into beautifully staged spaces with AI-powered furniture placement.',
        icon: Sofa,
        href: '/editor',
        image: '/images/staged_room.png',
        features: ['Instant results', '50+ furniture styles', 'HD output'],
        gradient: 'from-purple-600 to-indigo-600',
        popular: true,
    },
    {
        id: 'room-redesign',
        title: 'AI Room Redesign',
        description: 'Reimagine any room with different interior design styles while keeping the structure.',
        icon: Wand2,
        href: '/editor?mode=redesign',
        image: 'https://images.unsplash.com/photo-1618221195710-dd6b41faaea6?w=800&q=80',
        features: ['14 design styles', 'Preserve layout', 'Quick iteration'],
        gradient: 'from-pink-600 to-rose-600',
    },
    {
        id: 'photo-enhancement',
        title: 'Photo Enhancement',
        description: 'Enhance real estate photos with AI-powered lighting, color correction, and sky replacement.',
        icon: ImageIcon,
        href: '/editor?mode=enhance',
        image: 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=800&q=80',
        features: ['Auto HDR', 'Sky replacement', 'Color grading'],
        gradient: 'from-amber-500 to-orange-600',
    },
    {
        id: 'video-tours',
        title: 'Video Tours',
        description: 'Generate engaging property video tours from your staged images automatically.',
        icon: Video,
        href: '/editor?mode=video',
        image: 'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=800&q=80',
        features: ['Auto-generated', 'Music & transitions', 'Social-ready'],
        gradient: 'from-cyan-500 to-blue-600',
    },
    {
        id: '3d-visualization',
        title: '3D Visualization',
        description: 'Create immersive 3D walkthroughs and virtual reality experiences.',
        icon: Box,
        href: '/editor?mode=3d',
        image: 'https://images.unsplash.com/photo-1600566753086-00f18fb6b3ea?w=800&q=80',
        features: ['360° views', 'VR compatible', 'Interactive'],
        gradient: 'from-emerald-500 to-teal-600',
        comingSoon: true,
    },
    {
        id: 'ai-declutter',
        title: 'AI Declutter',
        description: 'Remove unwanted items and clutter from photos while preserving natural appearance.',
        icon: Sparkles,
        href: '/editor?mode=declutter',
        image: 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=800&q=80',
        features: ['Object removal', 'Smart fill', 'Natural results'],
        gradient: 'from-violet-500 to-purple-600',
    },
];

export function ServicesShowcase() {
    const params = useParams();
    const locale = params.locale as string;

    return (
        <section className="relative py-24 overflow-hidden">
            {/* Background */}
            <div className="absolute inset-0 bg-gradient-to-b from-slate-950 via-slate-900 to-slate-950" />
            <div className="absolute inset-0 bg-[radial-gradient(ellipse_at_center,_var(--tw-gradient-stops))] from-purple-900/20 via-transparent to-transparent" />

            <div className="relative mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
                {/* Section Header */}
                <motion.div
                    initial={{ opacity: 0, y: 20 }}
                    whileInView={{ opacity: 1, y: 0 }}
                    viewport={{ once: true }}
                    className="text-center mb-16"
                >
                    <span className="inline-flex items-center gap-2 px-4 py-1.5 rounded-full bg-purple-500/10 text-purple-400 text-sm font-medium mb-4">
                        <Sparkles className="h-4 w-4" />
                        AI-Powered Services
                    </span>
                    <h2 className="text-4xl md:text-5xl font-bold text-white mb-4">
                        Everything You Need for{' '}
                        <span className="bg-gradient-to-r from-purple-400 to-pink-400 bg-clip-text text-transparent">
                            Stunning Listings
                        </span>
                    </h2>
                    <p className="text-lg text-slate-400 max-w-2xl mx-auto">
                        Professional-grade tools to transform your real estate photos and create engaging visual content
                    </p>
                </motion.div>

                {/* Services Grid */}
                <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
                    {SERVICES.map((service, index) => (
                        <motion.div
                            key={service.id}
                            initial={{ opacity: 0, y: 20 }}
                            whileInView={{ opacity: 1, y: 0 }}
                            viewport={{ once: true }}
                            transition={{ delay: index * 0.1 }}
                        >
                            <Link
                                href={`/${locale}${service.href}`}
                                className={cn(
                                    "group relative block h-full overflow-hidden rounded-2xl border border-slate-800 bg-slate-900/50 backdrop-blur-sm transition-all duration-300",
                                    "hover:border-slate-700 hover:bg-slate-900/80 hover:shadow-2xl hover:shadow-purple-500/10",
                                    service.comingSoon && "pointer-events-none opacity-60"
                                )}
                            >
                                {/* Image */}
                                <div className="relative h-48 overflow-hidden">
                                    {/* eslint-disable-next-line @next/next/no-img-element */}
                                    <img
                                        src={service.image}
                                        alt={service.title}
                                        className="h-full w-full object-cover transition-transform duration-500 group-hover:scale-110"
                                    />
                                    <div className="absolute inset-0 bg-gradient-to-t from-slate-900 via-slate-900/50 to-transparent" />

                                    {/* Badge */}
                                    {service.popular && (
                                        <span className="absolute top-4 right-4 px-3 py-1 rounded-full bg-green-500/90 text-white text-xs font-bold">
                                            Most Popular
                                        </span>
                                    )}
                                    {service.comingSoon && (
                                        <span className="absolute top-4 right-4 px-3 py-1 rounded-full bg-blue-500/90 text-white text-xs font-bold">
                                            Coming Soon
                                        </span>
                                    )}

                                    {/* Icon */}
                                    <div className={cn(
                                        "absolute bottom-4 left-4 flex h-12 w-12 items-center justify-center rounded-xl bg-gradient-to-br",
                                        service.gradient
                                    )}>
                                        <service.icon className="h-6 w-6 text-white" />
                                    </div>
                                </div>

                                {/* Content */}
                                <div className="p-6">
                                    <h3 className="text-xl font-semibold text-white mb-2 group-hover:text-purple-300 transition-colors">
                                        {service.title}
                                    </h3>
                                    <p className="text-sm text-slate-400 mb-4">
                                        {service.description}
                                    </p>

                                    {/* Features */}
                                    <div className="flex flex-wrap gap-2 mb-4">
                                        {service.features.map((feature) => (
                                            <span
                                                key={feature}
                                                className="inline-flex items-center gap-1 text-xs text-slate-500"
                                            >
                                                <CheckCircle2 className="h-3 w-3 text-green-500" />
                                                {feature}
                                            </span>
                                        ))}
                                    </div>

                                    {/* CTA */}
                                    <div className="flex items-center text-sm font-medium text-purple-400 group-hover:text-purple-300">
                                        {service.comingSoon ? 'Notify Me' : 'Try Now'}
                                        <ArrowRight className="ml-1 h-4 w-4 transition-transform group-hover:translate-x-1" />
                                    </div>
                                </div>
                            </Link>
                        </motion.div>
                    ))}
                </div>
            </div>
        </section>
    );
}
