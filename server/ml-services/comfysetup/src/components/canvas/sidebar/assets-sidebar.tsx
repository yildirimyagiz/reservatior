'use client';

import Link from 'next/link';
import { useState } from 'react';
import {
    Armchair,
    Layers,
    Upload,
    Home,
    Sparkles,
    User,
    FolderOpen,
    Video,
    LogOut,
    Wand2,
    Eraser,
    ScanLine,
    Droplets,

} from 'lucide-react';
import { useCanvasStore } from '@/lib/store/canvas-store';
import { FurniturePanel } from './furniture-panel';
import { LayersPanel } from './layers-panel';
import { UploadsPanel } from './uploads-panel';
import { DesignAgentTools } from './design-agent-tools';

type TabKey = 'furniture' | 'uploads' | 'layers' | 'design-agent';

const EDITOR_TABS = [
    { key: 'furniture' as TabKey, label: 'Furniture', icon: Armchair },
    { key: 'uploads' as TabKey, label: 'Uploads', icon: Upload },
    { key: 'layers' as TabKey, label: 'Layers', icon: Layers },
    { key: 'design-agent' as TabKey, label: 'Design AI', icon: Wand2 },
];

export function AssetsSidebar() {
    const { roomImage, reset, setActiveTool } = useCanvasStore();
    const [activeTab, setActiveTab] = useState<TabKey>('furniture');

    // State A: Editor Mode (Asset Library) - Active when roomImage exists
    if (roomImage) {
        return (
            <div className="flex h-full w-72 flex-col border-r border-slate-800 bg-slate-950">
                <div className="flex items-center justify-between p-4 border-b border-slate-800">
                    <span className="font-semibold text-white text-sm">Library</span>
                    <button onClick={reset} className="text-xs text-slate-400 hover:text-white flex items-center gap-1">
                        <LogOut className="h-3 w-3" />
                        Exit
                    </button>
                </div>

                {/* Editor Tabs */}
                <div className="flex border-b border-slate-800 bg-slate-900 overflow-x-auto scrollbar-none">
                    {EDITOR_TABS.map((tab) => (
                        <button
                            key={tab.key}
                            onClick={() => setActiveTab(tab.key)}
                            className={`flex flex-1 min-w-[60px] flex-col items-center gap-1 py-3 text-xs font-medium transition-colors whitespace-nowrap ${activeTab === tab.key
                                ? 'bg-slate-800 text-purple-400 border-b-2 border-purple-400'
                                : 'text-slate-400 hover:bg-slate-800/50 hover:text-slate-300 border-b-2 border-transparent'
                                }`}
                        >
                            <tab.icon className="h-5 w-5" />
                            {tab.label}
                        </button>
                    ))}
                </div>

                {/* Content */}
                <div className="flex-1 overflow-hidden">
                    {activeTab === 'furniture' && <FurniturePanel />}
                    {activeTab === 'uploads' && <UploadsPanel />}
                    {activeTab === 'layers' && <LayersPanel />}
                    {activeTab === 'design-agent' && (
                        <div className="h-full overflow-y-auto">
                            <DesignAgentTools />
                        </div>
                    )}
                </div>
            </div>
        );
    }

    // State B: Dashboard Mode (Start Screen) - Matched to User Image
    return (
        <div className="flex h-full w-64 flex-col border-r border-slate-800 bg-slate-950 font-sans text-slate-300">
            {/* Logo Area */}
            <div className="p-6 pb-8">
                <div className="flex items-center gap-2 text-white font-bold text-xl">
                     <div className="h-8 w-8 rounded-lg bg-white/10 flex items-center justify-center">
                        <Sparkles className="h-5 w-5 text-white" />
                     </div>
                     <span>Collov Clone</span>
                </div>
            </div>

            <div className="flex-1 overflow-y-auto space-y-8 px-4">
                {/* Home */}
                <Link href="/" className="flex items-center gap-3 px-3 py-2 text-slate-400 hover:text-white transition-colors">
                    <Home className="h-5 w-5" />
                    <span className="font-medium">Home</span>
                </Link>

                {/* Tools */}
                <div>
                    <h3 className="px-3 text-xs font-bold text-slate-500 uppercase tracking-wider mb-2">Tools</h3>
                    <div className="space-y-1">
                        {/* AI Virtual Staging */}
                        <div
                            onClick={() => setActiveTool('staging')}
                            className="flex items-center gap-3 px-3 py-2 rounded-lg text-slate-400 hover:text-white hover:bg-slate-800/50 transition-colors cursor-pointer"
                        >
                            <Sparkles className="h-5 w-5" />
                            <span>AI Virtual Staging</span>
                        </div>

                        {/* AI Design Agent */}
                        <div className="flex items-center gap-3 px-3 py-2 rounded-lg text-slate-400 hover:text-white hover:bg-slate-800/50 transition-colors cursor-pointer">
                            <Wand2 className="h-5 w-5" />
                            <span>AI Design Agent</span>
                        </div>

                        {/* AI Photo Editing - Direct Tools */}
                        <div className="mt-3">
                            <h4 className="px-3 text-xs font-semibold text-slate-400 mb-2">AI Photo Editing</h4>
                            <div className="space-y-1">
                                <button
                                    onClick={() => setActiveTool('declutter')}
                                    className="w-full text-left px-3 py-2 text-sm text-slate-400 hover:text-white hover:bg-slate-800/50 rounded-lg transition-colors flex items-center gap-3"
                                >
                                    <Eraser className="h-4 w-4" />
                                    <span>Room Decluttering</span>
                                </button>
                                <button
                                    onClick={() => setActiveTool('enhance')}
                                    className="w-full text-left px-3 py-2 text-sm text-slate-400 hover:text-white hover:bg-slate-800/50 rounded-lg transition-colors flex items-center gap-3"
                                >
                                    <ScanLine className="h-4 w-4" />
                                    <span>Enhance Photo Quality</span>
                                </button>
                                <button
                                    onClick={() => setActiveTool('material')}
                                    className="w-full text-left px-3 py-2 text-sm text-slate-400 hover:text-white hover:bg-slate-800/50 rounded-lg transition-colors flex items-center gap-3"
                                >
                                    <Layers className="h-4 w-4" />
                                    <span>Material Overlay</span>
                                </button>
                                 <button
                                    onClick={() => setActiveTool('water-pool')}
                                    className="w-full text-left px-3 py-2 text-sm text-slate-400 hover:text-white hover:bg-slate-800/50 rounded-lg transition-colors flex items-center gap-3"
                                 >
                                    <Droplets className="h-4 w-4" />
                                    <span>Add Water Effects</span>
                                </button>
                            </div>
                        </div>

                         <button className="w-full flex items-center gap-3 px-3 py-2 rounded-lg text-slate-400 hover:text-white hover:bg-slate-800/50 transition-colors mt-2">
                            <Video className="h-5 w-5" />
                            <span>AI Virtual Tour</span>
                        </button>
                    </div>
                </div>

                {/* Assets */}
                <div>
                    <h3 className="px-3 text-xs font-bold text-slate-500 uppercase tracking-wider mb-2">Assets</h3>
                     <button className="w-full flex items-center gap-3 px-3 py-2 rounded-lg text-slate-400 hover:text-white hover:bg-slate-800/50 transition-colors">
                        <User className="h-5 w-5" />
                        <span>My Profile</span>
                    </button>
                     <button className="w-full flex items-center gap-3 px-3 py-2 rounded-lg text-slate-400 hover:text-white hover:bg-slate-800/50 transition-colors">
                        <FolderOpen className="h-5 w-5" />
                        <span>My Creations</span>
                    </button>
                </div>
            </div>

            {/* Bottom Promo */}
            <div className="p-4 mt-auto">
                <div className="rounded-xl bg-gradient-to-br from-slate-800 to-slate-900 p-4 border border-slate-700">
                    <div className="mb-3 h-10 w-10 rounded-lg bg-white flex items-center justify-center">
                        <Sparkles className="h-6 w-6 text-black" />
                    </div>
                    <h4 className="text-white font-bold text-sm mb-1">Transform spaces</h4>
                    <p className="text-xs text-slate-400 mb-3">Instant room makeovers with AI.</p>
                    <button className="w-full py-2 bg-white text-black text-xs font-bold rounded-lg hover:bg-slate-200 transition-colors">
                        Start Free Trial
                    </button>
                </div>
            </div>
        </div>
    );
}
