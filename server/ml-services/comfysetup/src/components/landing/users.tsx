'use client';

import { motion } from 'framer-motion';
import { Building2, Compass, PaintBucket, Home } from 'lucide-react';
import type { Dictionary } from '@/lib/i18n/config';

interface UsersProps {
    dictionary: Dictionary;
}

const userTypes = [
    { key: 'realtors', icon: Building2 },
    { key: 'architects', icon: Compass },
    { key: 'designers', icon: PaintBucket },
    { key: 'consumers', icon: Home },
];

export function Users({ dictionary }: UsersProps) {
    return (
        <section className="border-y border-slate-800 bg-slate-900/50 py-24">
            <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
                {/* Section header */}
                <motion.div
                    initial={{ opacity: 0, y: 20 }}
                    whileInView={{ opacity: 1, y: 0 }}
                    viewport={{ once: true }}
                    className="mb-16 text-center"
                >
                    <h2 className="text-3xl font-bold text-white sm:text-4xl">
                        {dictionary.landing.users.title}
                    </h2>
                </motion.div>

                {/* User types grid */}
                <div className="grid gap-8 sm:grid-cols-2 lg:grid-cols-4">
                    {userTypes.map((user, index) => {
                        const Icon = user.icon;
                        const title = dictionary.landing.users[user.key as keyof typeof dictionary.landing.users];
                        const desc = dictionary.landing.users[`${user.key}Desc` as keyof typeof dictionary.landing.users];

                        return (
                            <motion.div
                                key={user.key}
                                initial={{ opacity: 0, y: 20 }}
                                whileInView={{ opacity: 1, y: 0 }}
                                viewport={{ once: true }}
                                transition={{ delay: index * 0.1 }}
                                className="group text-center"
                            >
                                <div className="mx-auto mb-4 flex h-16 w-16 items-center justify-center rounded-2xl border border-slate-700 bg-slate-800/50 transition-colors group-hover:border-purple-500/50 group-hover:bg-purple-500/10">
                                    <Icon className="h-8 w-8 text-slate-400 transition-colors group-hover:text-purple-400" />
                                </div>
                                <h3 className="mb-2 text-lg font-semibold text-white">{title}</h3>
                                <p className="text-sm text-slate-400">{desc}</p>
                            </motion.div>
                        );
                    })}
                </div>
            </div>
        </section>
    );
}
