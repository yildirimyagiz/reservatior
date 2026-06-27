import { ReactNode } from 'react';

interface LegalLayoutProps {
    title: string;
    lastUpdated: string;
    children: ReactNode;
}

export function LegalLayout({ title, lastUpdated, children }: LegalLayoutProps) {
    return (
        <div className="min-h-screen bg-slate-950 pt-24 pb-16">
            <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
                {/* Header */}
                <div className="mb-12 border-b border-white/10 pb-8">
                    <h1 className="text-3xl md:text-5xl font-bold text-white mb-4">
                        {title}
                    </h1>
                    <p className="text-slate-400">
                        Last updated: {lastUpdated}
                    </p>
                </div>

                {/* Content */}
                <div className="prose prose-invert prose-lg max-w-none text-slate-300">
                    {children}
                </div>
            </div>
        </div>
    );
}
