import { ArrowRight } from 'lucide-react';
import Link from 'next/link';

export default function CaseStudiesPage() {
    return (
        <div className="min-h-screen bg-slate-950 pt-24 pb-16">
            <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div className="text-center mb-16">
                    <h1 className="text-4xl md:text-5xl font-bold text-white mb-6">
                        Customer Success Stories
                    </h1>
                    <p className="text-lg text-slate-400 max-w-2xl mx-auto">
                        See how real estate agents, photographers, and developers are using FurnitureStaging.AI to sell properties faster.
                    </p>
                </div>

                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                    {[1, 2, 3].map((i) => (
                        <div key={i} className="group rounded-2xl bg-slate-900 border border-slate-800 overflow-hidden hover:border-purple-500/50 transition-all">
                            <div className="aspect-video bg-slate-800 relative">
                                {/* Placeholder for case study image */}
                                <div className="absolute inset-0 bg-gradient-to-t from-slate-900 to-transparent opacity-60" />
                                <div className="absolute bottom-4 left-4">
                                    <span className="bg-purple-500/20 text-purple-300 text-xs font-medium px-2 py-1 rounded-full border border-purple-500/20">
                                        Real Estate Agency
                                    </span>
                                </div>
                            </div>
                            <div className="p-6">
                                <h3 className="text-xl font-bold text-white mb-2 group-hover:text-purple-400 transition-colors">
                                    Selling a Vacant Luxury Condo in Record Time
                                </h3>
                                <p className="text-slate-400 text-sm mb-4">
                                    How The Agency used virtual staging to transform a cold, empty unit into a warm, inviting home, resulting in a sale within 14 days.
                                </p>
                                <Link href="#" className="inline-flex items-center text-sm font-medium text-white hover:text-purple-400 transition-colors">
                                    Read Case Study <ArrowRight className="ml-1 h-4 w-4" />
                                </Link>
                            </div>
                        </div>
                    ))}
                </div>
            </div>
        </div>
    );
}
