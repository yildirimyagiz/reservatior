import { Search, FileText, MessageCircle, HelpCircle } from 'lucide-react';

export default function HelpCenterPage() {
    return (
        <div className="min-h-screen bg-slate-950 pt-24 pb-16">
            <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
                {/* Header */}
                <div className="text-center mb-16">
                    <h1 className="text-4xl font-bold text-white mb-4">
                        How can we help you?
                    </h1>
                    <div className="max-w-xl mx-auto relative mt-8">
                        <Search className="absolute left-4 top-1/2 -translate-y-1/2 text-slate-400 h-5 w-5" />
                        <input
                            type="text"
                            placeholder="Search for answers..."
                            className="w-full h-12 bg-slate-900 border border-slate-700 rounded-full pl-12 pr-4 text-white placeholder-slate-500 focus:border-purple-500 focus:outline-none focus:ring-1 focus:ring-purple-500 transition-all"
                        />
                    </div>
                </div>

                {/* Categories */}
                <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
                    <div className="p-6 rounded-2xl bg-slate-900 border border-slate-800 hover:border-purple-500/50 transition-colors group cursor-pointer">
                        <div className="w-12 h-12 rounded-xl bg-purple-500/20 flex items-center justify-center mb-4 group-hover:scale-110 transition-transform">
                            <FileText className="h-6 w-6 text-purple-400" />
                        </div>
                        <h3 className="text-xl font-semibold text-white mb-2">Getting Started</h3>
                        <p className="text-slate-400">Everything you need to know about setting up your account and first staging.</p>
                    </div>

                    <div className="p-6 rounded-2xl bg-slate-900 border border-slate-800 hover:border-blue-500/50 transition-colors group cursor-pointer">
                        <div className="w-12 h-12 rounded-xl bg-blue-500/20 flex items-center justify-center mb-4 group-hover:scale-110 transition-transform">
                            <HelpCircle className="h-6 w-6 text-blue-400" />
                        </div>
                        <h3 className="text-xl font-semibold text-white mb-2">FAQs</h3>
                        <p className="text-slate-400">Common questions about virtual staging, pricing, and image quality.</p>
                    </div>

                    <div className="p-6 rounded-2xl bg-slate-900 border border-slate-800 hover:border-pink-500/50 transition-colors group cursor-pointer">
                        <div className="w-12 h-12 rounded-xl bg-pink-500/20 flex items-center justify-center mb-4 group-hover:scale-110 transition-transform">
                            <MessageCircle className="h-6 w-6 text-pink-400" />
                        </div>
                        <h3 className="text-xl font-semibold text-white mb-2">Support</h3>
                        <p className="text-slate-400">Contact our support team for technical assistance or billing inquiries.</p>
                    </div>
                </div>

                {/* FAQ List */}
                <div className="mt-16">
                    <h2 className="text-2xl font-bold text-white mb-8">Frequently Asked Questions</h2>
                    <div className="space-y-4">
                        {[
                            "How long does virtual staging take?",
                            "What is the best image resolution to upload?",
                            "Can I edit the staged images?",
                            "Do you offer refunds?"
                        ].map((question, i) => (
                            <div key={i} className="p-4 rounded-xl bg-slate-900/50 border border-slate-800 hover:bg-slate-900 cursor-pointer transition-colors">
                                <h4 className="text-white font-medium">{question}</h4>
                            </div>
                        ))}
                    </div>
                </div>
            </div>
        </div>
    );
}
