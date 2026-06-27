'use client';

import { motion } from 'framer-motion';
import Link from 'next/link';
import { useParams } from 'next/navigation';
import { ArrowRight } from 'lucide-react';
import { cn } from '@/lib/utils';

const CATEGORIES = [
    {
        id: 'living-room',
        name: 'Living Room',
        count: '2,500+',
        image: '/images/staged_room.png',
        color: 'from-purple-900/40 to-indigo-900/40',
    },
    {
        id: 'bedroom',
        name: 'Bedroom',
        count: '1,800+',
        image: 'https://images.unsplash.com/photo-1616594039964-ae9021a400a0?w=600&q=80',
        color: 'from-pink-900/40 to-rose-900/40',
    },
    {
        id: 'kitchen',
        name: 'Kitchen',
        count: '1,200+',
        image: 'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=600&q=80',
        color: 'from-amber-900/40 to-orange-900/40',
    },
    {
        id: 'bathroom',
        name: 'Bathroom',
        count: '950+',
        image: 'https://images.unsplash.com/photo-1552321554-5fefe8c9ef14?w=600&q=80',
        color: 'from-cyan-900/40 to-blue-900/40',
    },
    {
        id: 'office',
        name: 'Home Office',
        count: '680+',
        image: 'https://images.unsplash.com/photo-1593062096033-9a26b09da705?w=600&q=80',
        color: 'from-emerald-900/40 to-teal-900/40',
    },
    {
        id: 'dining',
        name: 'Dining Room',
        count: '520+',
        image: 'https://images.unsplash.com/photo-1617806118233-18e1de247200?w=600&q=80',
        color: 'from-violet-900/40 to-purple-900/40',
    },
    {
        id: 'outdoor',
        name: 'Outdoor',
        count: '450+',
        image: 'https://images.unsplash.com/photo-1600566753190-17f0baa2a6c3?w=600&q=80',
        color: 'from-green-900/40 to-emerald-900/40',
    },
    {
        id: 'commercial',
        name: 'Commercial',
        count: '380+',
        image: 'https://images.unsplash.com/photo-1497366216548-37526070297c?w=600&q=80',
        color: 'from-slate-800/40 to-zinc-800/40',
    },
];

export function CategoryGrid() {
    const params = useParams();
    const locale = params.locale as string;

    return (
        <section className="relative py-24 overflow-hidden bg-slate-950">
            <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
                {/* Section Header */}
                <motion.div
                    initial={{ opacity: 0, y: 20 }}
                    whileInView={{ opacity: 1, y: 0 }}
                    viewport={{ once: true }}
                    className="flex flex-col sm:flex-row sm:items-end sm:justify-between gap-4 mb-12"
                >
                    <div>
                        <h2 className="text-3xl md:text-4xl font-bold text-white mb-2">
                            Browse by Room Type
                        </h2>
                        <p className="text-slate-400">
                            Explore thousands of professionally staged designs for every space
                        </p>
                    </div>
                    <Link
                        href={`/${locale}/library`}
                        className="inline-flex items-center gap-2 text-purple-400 hover:text-purple-300 font-medium transition-colors"
                    >
                        View All Categories
                        <ArrowRight className="h-4 w-4" />
                    </Link>
                </motion.div>

                {/* Category Grid - Masonry-like layout */}
                <div className="grid grid-cols-2 md:grid-cols-4 gap-4 auto-rows-[200px]">
                    {CATEGORIES.map((category, index) => {
                        // Make first and fifth items span 2 rows for visual interest
                        const isLarge = index === 0 || index === 4;

                        return (
                            <motion.div
                                key={category.id}
                                initial={{ opacity: 0, scale: 0.95 }}
                                whileInView={{ opacity: 1, scale: 1 }}
                                viewport={{ once: true }}
                                transition={{ delay: index * 0.05 }}
                                className={cn(
                                    isLarge && "row-span-2"
                                )}
                            >
                                <Link
                                    href={`/${locale}/editor?room=${category.id}`}
                                    className="group relative block h-full w-full overflow-hidden rounded-2xl"
                                >
                                    {/* Background Image */}
                                    {/* eslint-disable-next-line @next/next/no-img-element */}
                                    <img
                                        src={category.image}
                                        alt={category.name}
                                        className="absolute inset-0 h-full w-full object-cover transition-transform duration-700 group-hover:scale-110"
                                    />

                                    {/* Gradient Overlay - Subtle, only at bottom for text readability */}
                                    <div className={cn(
                                        "absolute inset-0 bg-gradient-to-t opacity-60 group-hover:opacity-70 transition-opacity",
                                        category.color
                                    )} />
                                    <div className="absolute inset-0 bg-gradient-to-t from-black/80 via-black/20 to-transparent" />

                                    {/* Content */}
                                    <div className="absolute inset-0 flex flex-col justify-end p-6">
                                        <h3 className="text-xl md:text-2xl font-bold text-white mb-1">
                                            {category.name}
                                        </h3>
                                        <p className="text-sm text-white/80">
                                            {category.count} designs
                                        </p>
                                    </div>

                                    {/* Hover Arrow */}
                                    <div className="absolute top-4 right-4 flex h-10 w-10 items-center justify-center rounded-full bg-white/10 opacity-0 backdrop-blur-sm transition-all duration-300 group-hover:opacity-100">
                                        <ArrowRight className="h-5 w-5 text-white transition-transform group-hover:translate-x-0.5" />
                                    </div>
                                </Link>
                            </motion.div>
                        );
                    })}
                </div>
            </div>
        </section>
    );
}
