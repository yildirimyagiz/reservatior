'use client';

import Link from 'next/link';
import { Button } from '@/components/ui/button';
import { CircularNav } from './circular-nav';
import { ComparisonSlider } from './comparison-slider';

export function Hero() {
    return (
        <section className="relative min-h-screen overflow-hidden bg-gradient-to-b from-[#0B1121] to-[#1a233b] pt-16">
            {/* Background Effects */}
            <div className="absolute inset-x-0 -top-40 -z-10 transform-gpu overflow-hidden blur-3xl sm:-top-80" aria-hidden="true">
                <div className="relative left-[calc(50%-11rem)] aspect-[1155/678] w-[36.125rem] -translate-x-1/2 rotate-[30deg] bg-gradient-to-tr from-[#0ea5e9] to-[#8b5cf6] opacity-30 sm:left-[calc(50%-30rem)] sm:w-[72.1875rem]" style={{ clipPath: 'polygon(74.1% 44.1%, 100% 61.6%, 97.5% 26.9%, 85.5% 0.1%, 80.7% 2%, 72.5% 32.5%, 60.2% 62.4%, 52.4% 68.1%, 47.5% 58.3%, 45.2% 34.5%, 27.5% 76.7%, 0.1% 64.9%, 17.9% 100%, 27.6% 76.8%, 76.1% 97.7%, 74.1% 44.1%)' }} />
            </div>

            <div className="relative mx-auto flex min-h-[calc(100vh-4rem)] max-w-7xl flex-col items-center justify-start px-4 py-20 text-center sm:px-6 lg:px-8">

                {/* Headline */}
                <div className="mx-auto max-w-3xl text-center mb-12">
                    <h1 className="text-4xl font-bold tracking-tight text-white/90 sm:text-6xl mb-6 font-display">
                        Fewer decisions. <span className="text-blue-400">Better listings.</span>
                    </h1>
                    <p className="mt-6 text-lg leading-8 text-slate-300/80">
                        AI-powered visual solutions destined to sell properties faster.
                        Stage, edit, and enhance your real estate photos in seconds.
                    </p>
                </div>

                {/* Circular Navigation */}
                <CircularNav />

                {/* Comparison Slider */}
                <ComparisonSlider />

                {/* CTA Buttons */}
                <div className="mt-12 flex flex-col items-center gap-4 sm:flex-row">
                    <Link href="/en/editor">
                        <Button size="lg" className="rounded-full bg-blue-600 px-8 text-white hover:bg-blue-500 text-lg h-12">
                            Get started
                        </Button>
                    </Link>
                    <Link href="/en/pricing">
                        <Button variant="ghost" size="lg" className="rounded-full text-white hover:text-blue-300 hover:bg-white/5 text-lg h-12">
                            View Pricing <span aria-hidden="true" className="ml-2">→</span>
                        </Button>
                    </Link>
                </div>

                {/* Decorative gradient bottom */}
                <div className="pointer-events-none absolute bottom-0 left-1/2 h-96 w-full -translate-x-1/2 translate-y-1/2 rounded-full bg-gradient-to-t from-blue-900/10 to-transparent blur-3xl" />
            </div>

            {/* Bottom transition */}
            <div className="absolute inset-x-0 bottom-0 -z-10 h-24 bg-gradient-to-t from-slate-900 to-transparent" />
        </section>
    );
}
