'use client';

import { motion } from 'framer-motion';
import { ShoppingBag, ArrowRight, ExternalLink } from 'lucide-react';
import { Button } from '@/components/ui/button';

export function EcommerceSection() {
    return (
        <section className="relative overflow-hidden bg-slate-950 py-32">
            {/* Background Gradients */}
            <div className="absolute inset-0 bg-[radial-gradient(circle_at_30%_50%,rgba(124,58,237,0.05),transparent_50%)]" />
            <div className="absolute inset-0 bg-[radial-gradient(circle_at_70%_80%,rgba(236,72,153,0.05),transparent_50%)]" />

            <div className="container relative mx-auto px-4">
                <div className="grid gap-16 lg:grid-cols-2 lg:items-center">
                    {/* Left Content */}
                    <div className="max-w-xl">
                        <motion.div
                            initial={{ opacity: 0, x: -20 }}
                            whileInView={{ opacity: 1, x: 0 }}
                            transition={{ duration: 0.5 }}
                            viewport={{ once: true }}
                        >
                            <span className="mb-4 inline-block rounded-full bg-purple-500/10 px-4 py-1.5 text-sm font-medium text-purple-400 border border-purple-500/20">
                                Monetization Ready
                            </span>
                            <h2 className="mb-6 text-4xl font-bold leading-tight text-white md:text-5xl">
                                Turn Staged Demos into <span className="text-transparent bg-clip-text bg-gradient-to-r from-purple-400 to-pink-400">Real Sales</span>
                            </h2>
                            <p className="mb-8 text-lg text-slate-400">
                                Stop leaving money on the table. Our AI doesn&apos;t just visualize space—it connects your designs to real inventory. Seamlessly integrated with major e-commerce platforms.
                            </p>
                            
                            <div className="space-y-6">
                                <div className="flex items-start gap-4">
                                    <div className="flex h-12 w-12 shrink-0 items-center justify-center rounded-xl bg-slate-900 border border-slate-800 text-purple-400">
                                        <ShoppingBag className="h-6 w-6" />
                                    </div>
                                    <div>
                                        <h3 className="mb-1 text-lg font-semibold text-white">Instant Shoppability</h3>
                                        <p className="text-slate-400">Automatically identify and link generated furniture to similar products on Amazon and Shopify.</p>
                                    </div>
                                </div>
                                <div className="flex items-start gap-4">
                                    <div className="flex h-12 w-12 shrink-0 items-center justify-center rounded-xl bg-slate-900 border border-slate-800 text-pink-400">
                                        <ExternalLink className="h-6 w-6" />
                                    </div>
                                    <div>
                                        <h3 className="mb-1 text-lg font-semibold text-white">Direct Checkout Links</h3>
                                        <p className="text-slate-400">Provide clients with a shopping list for their new room. Earn affiliate commissions effortlessly.</p>
                                    </div>
                                </div>
                            </div>

                            <div className="mt-10 flex flex-wrap gap-4">
                                <Button size="lg" className="bg-white text-slate-950 hover:bg-slate-200">
                                    Start Selling
                                    <ArrowRight className="ml-2 h-4 w-4" />
                                </Button>
                            </div>
                        </motion.div>
                    </div>

                    {/* Right Visual */}
                    <motion.div
                        initial={{ opacity: 0, scale: 0.95 }}
                        whileInView={{ opacity: 1, scale: 1 }}
                        transition={{ duration: 0.7 }}
                        viewport={{ once: true }}
                        className="relative"
                    >
                         {/* Card Stack Effect */}
                        <div className="relative z-10 overflow-hidden rounded-2xl border border-slate-800 bg-slate-900/50 backdrop-blur-sm shadow-2xl">
                             {/* Mockup Header */}
                             <div className="flex items-center justify-between border-b border-slate-800 px-6 py-4 bg-slate-900/80">
                                <div className="flex items-center gap-2">
                                    <span className="text-sm font-medium text-white">Product Detection</span>
                                    <span className="flex h-5 items-center rounded-full bg-green-500/20 px-2 text-[10px] font-medium text-green-400">Active</span>
                                </div>
                             </div>
                             
                             {/* Mockup Content */}
                             <div className="p-6 grid gap-4">
                                {/* Item 1 */}
                                <div className="flex items-center gap-4 rounded-xl border border-slate-700 bg-slate-800/50 p-4 transition-colors hover:border-purple-500/50">
                                    <div className="h-16 w-16 rounded-lg bg-slate-700 bg-[url('https://images.unsplash.com/photo-1555041469-a586c61ea9bc?auto=format&fit=crop&w=150&q=80')] bg-cover bg-center" />
                                    <div className="flex-1">
                                        <h4 className="font-medium text-white">Green Velvet Sofa</h4>
                                        <p className="text-xs text-slate-400">Mid-Century Modern Collection</p>
                                    </div>
                                    <div className="flex gap-2">
                                        <div className="h-8 w-8 rounded-full bg-white flex items-center justify-center" title="Amazon">
                                             <span className="text-[10px] font-bold text-black">Amz</span>
                                        </div>
                                    </div>
                                </div>
                                {/* Item 2 */}
                                <div className="flex items-center gap-4 rounded-xl border border-slate-700 bg-slate-800/50 p-4 transition-colors hover:border-purple-500/50">
                                    <div className="h-16 w-16 rounded-lg bg-slate-700 bg-[url('https://images.unsplash.com/photo-1532372320572-cda25653a26d?auto=format&fit=crop&w=150&q=80')] bg-cover bg-center" />
                                    <div className="flex-1">
                                        <h4 className="font-medium text-white">Mahogany Coffee Table</h4>
                                        <p className="text-xs text-slate-400">Artisan Woodworks</p>
                                    </div>
                                    <div className="flex gap-2">
                                        <div className="h-8 w-8 rounded-full bg-[#95BF47] flex items-center justify-center text-white" title="Shopify">
                                             <span className="text-[10px] font-bold">Shop</span>
                                        </div>
                                    </div>
                                </div>
                             </div>
                        </div>

                        {/* Background Decoration */}
                        <div className="absolute -right-10 -top-10 h-72 w-72 rounded-full bg-purple-500/20 blur-[100px]" />
                        <div className="absolute -left-10 -bottom-10 h-72 w-72 rounded-full bg-pink-500/20 blur-[100px]" />
                    </motion.div>
                </div>
            </div>
        </section>
    );
}
