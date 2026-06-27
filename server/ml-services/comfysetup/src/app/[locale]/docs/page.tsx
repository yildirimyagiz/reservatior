import { Book, Code } from 'lucide-react';

export default function DocumentationPage() {
    return (
        <div className="min-h-screen bg-slate-950 pt-24 pb-16">
            <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div className="flex flex-col md:flex-row gap-12">
                    {/* Sidebar */}
                    <div className="w-full md:w-64 flex-shrink-0">
                        <div className="sticky top-24">
                            <h3 className="font-semibold text-white mb-4 px-2">Documentation</h3>
                            <nav className="space-y-1">
                                {['Introduction', 'Quick Start', 'Uploading Images', 'Choosing Styles', 'Editing Results', 'Exporting'].map((item) => (
                                    <button key={item} className="w-full text-left px-2 py-1.5 text-sm text-slate-400 hover:text-white hover:bg-slate-900 rounded-md transition-colors">
                                        {item}
                                    </button>
                                ))}
                            </nav>
                        </div>
                    </div>

                    {/* Content */}
                    <div className="flex-1 prose prose-invert prose-lg max-w-none">
                        <h1>Introduction</h1>
                        <p className="lead text-xl text-slate-300">
                            Welcome to the FurnitureStaging.AI documentation. Learn how to transform empty rooms into beautiful, fully staged interiors in minutes using our AI-powered platform.
                        </p>

                        <div className="grid grid-cols-1 md:grid-cols-2 gap-6 not-prose my-12">
                            <div className="p-6 rounded-2xl bg-slate-900 border border-slate-800">
                                <Book className="h-6 w-6 text-purple-400 mb-4" />
                                <h3 className="text-lg font-semibold text-white mb-2">Platform Guide</h3>
                                <p className="text-slate-400 text-sm">Comprehensive guide to all features and tools available in the editor.</p>
                            </div>
                            <div className="p-6 rounded-2xl bg-slate-900 border border-slate-800">
                                <Code className="h-6 w-6 text-blue-400 mb-4" />
                                <h3 className="text-lg font-semibold text-white mb-2">API Reference</h3>
                                <p className="text-slate-400 text-sm">Detailed API documentation for developers integrating with our service.</p>
                            </div>
                        </div>

                        <h2>Overview</h2>
                        <p>
                            Our platform uses advanced generative AI (Stable Diffusion & ControlNet) to analyze detailed room geometry and place realistic 3D furniture models that match the perspective and lighting of your original photo.
                        </p>
                        
                        <h2>Supported File Types</h2>
                        <ul>
                            <li>JPEG/JPG</li>
                            <li>PNG</li>
                            <li>WEBP</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    );
}
