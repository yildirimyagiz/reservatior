'use client';

import { useRef } from 'react';
import { StagingCanvas } from './staging-canvas';
import { CanvasBottomToolbar } from './canvas-bottom-toolbar';
import { CanvasToolbar } from './canvas-toolbar';
import { useCanvasStore } from '@/lib/store/canvas-store';
import { ToolsSidebar } from './sidebar/tools-sidebar';
import { cn } from '@/lib/utils';
import { ChevronRight, ChevronLeft, Sparkles } from 'lucide-react';

import { VirtualStagingPanel } from './sidebar/virtual-staging-panel';
import { FurniturePanel } from './sidebar/furniture-panel';
import { DesignAgentTools } from './sidebar/design-agent-tools';
import { LayersPanel } from './sidebar/layers-panel';


export function CanvasEditor() {
    const { roomImage, activeTool, sidePanelVisible, setSidePanelVisible } = useCanvasStore();
    const canvasRef = useRef<HTMLDivElement>(null);

    const renderSecondaryPanel = () => {
        switch (activeTool) {
            case 'staging':
                return <VirtualStagingPanel />;
            case 'furniture':
                return <FurniturePanel />;
            case 'eraser':
            case 'declutter':
            case 'enhance':
            case 'material':
            case 'seasons':
            case 'rain-shine':
            case 'natural-twilight':
            case 'virtual-twilight':
            case 'water-pool':
            case 'lawn':
            case 'night-day':
                return <DesignAgentTools />;
            case 'layers':
                return <LayersPanel />;
            default:
                return null;
        }
    };

    return (
        <div className="flex h-screen flex-col bg-[#020617] text-white selection:bg-purple-500/30 overflow-hidden font-sans">
            {/* 1. Global Navigation Bar (Top) */}
            <div className="h-14 flex-shrink-0 z-50">
                <CanvasToolbar canvasRef={canvasRef} />
            </div>

            {/* 2. Primary Workspace Layout */}
            <div className="flex-1 relative overflow-hidden flex">

                {/* A. Left Utility Dock (Narrow/Floating feel) */}
                <div className="w-[92px] flex-shrink-0 border-r border-white/5 bg-[#020617] z-40 flex flex-col items-center py-4 gap-4">
                    <ToolsSidebar />
                </div>

                {/* B. Center Stage (Main Canvas) */}
                <div className="flex-1 relative flex flex-col bg-[#050814] overflow-hidden">
                    {/* Atmospheric Layering */}
                    <div className="absolute inset-0 bg-[radial-gradient(circle_at_50%_40%,_rgba(30,41,59,0.3)_0%,_rgba(2,6,23,1)_100%)] pointer-events-none" />

                    {/* Background Detail Pattern */}
                    <div
                        className="absolute inset-0 opacity-[0.04] pointer-events-none"
                        style={{
                            backgroundImage: `linear-gradient(to right, #ffffff 1px, transparent 1px), linear-gradient(to bottom, #ffffff 1px, transparent 1px)`,
                            backgroundSize: '40px 40px'
                        }}
                    />

                    {/* Infinite Canvas Container */}
                    <div className="flex-1 overflow-auto relative flex items-center justify-center p-6 md:p-12 lg:p-20 scrollbar-none">
                         <div className="relative shadow-[0_0_100px_rgba(0,0,0,0.8)] rounded-2xl overflow-hidden transition-all duration-700 hover:shadow-purple-500/10">
                            <StagingCanvas ref={canvasRef} />
                         </div>
                    </div>

                    {/* Floating Bottom Center Control Group */}
                    <div className="absolute bottom-10 left-1/2 -translate-x-1/2 z-40 transition-all duration-500">
                        {roomImage && <CanvasBottomToolbar />}
                    </div>
                </div>

                {/* C. Right Inspector / Configuration Panel (Floating Panel feel) */}
                <div
                    className={cn(
                        "absolute right-6 top-6 bottom-6 w-[380px] z-40 transition-all duration-700 ease-[cubic-bezier(0.23,1,0.32,1)]",
                        (activeTool && sidePanelVisible)
                            ? "translate-x-0 opacity-100 visible"
                            : "translate-x-[120%] opacity-0 invisible"
                    )}
                >
                    {/* Toggle Button (On Panel) */}
                    <button
                        onClick={() => setSidePanelVisible(false)}
                        className="absolute -left-3 top-1/2 -translate-y-1/2 w-8 h-12 bg-[#0b0f1a] border border-white/10 rounded-xl flex items-center justify-center text-slate-500 hover:text-white transition-all shadow-xl z-[60] group/hide"
                    >
                        <ChevronRight className="h-4 w-4 group-hover/hide:translate-x-0.5 transition-transform" />
                    </button>

                    <div className="h-full bg-[#0b0f1a]/80 backdrop-blur-3xl border border-white/10 rounded-[32px] overflow-hidden shadow-[0_32px_64px_-16px_rgba(0,0,0,0.8)] flex flex-col border-opacity-20 relative">
                        {/* Header Shine */}
                        <div className="absolute top-0 inset-x-0 h-24 bg-gradient-to-b from-purple-500/10 to-transparent pointer-events-none" />

                        {/* Panel Content Container */}
                        <div className="flex-1 relative overflow-hidden flex flex-col">
                            {renderSecondaryPanel()}
                        </div>
                    </div>
                </div>

                {/* Floating Peek Trigger (When panel is hidden) */}
                <div
                    className={cn(
                        "absolute right-0 top-1/2 -translate-y-1/2 transition-all duration-700 z-30 flex items-center",
                        (!sidePanelVisible) ? "translate-x-0" : "translate-x-full pointer-events-none"
                    )}
                >
                    {/* Design Studio Label (Vertical) */}
                    <div className="flex flex-col items-center py-6 px-2.5 bg-[#0b0f1a]/60 backdrop-blur-xl border border-white/5 border-r-0 rounded-l-[24px] shadow-2xl mr-[-1px] select-none group hover:bg-[#0b0f1a]/80 transition-colors pointer-events-auto cursor-pointer" onClick={() => setSidePanelVisible(true)}>
                        <Sparkles className="h-3 w-3 text-purple-400 mb-4 animate-pulse" />
                        <div className="flex flex-col gap-3">
                            {"DESIGN STUDIO".split("").map((char, i) => (
                                <span key={i} className="text-[9px] font-black text-slate-500 group-hover:text-white transition-colors leading-[1] text-center">
                                    {char === " " ? "\u00A0" : char}
                                </span>
                            ))}
                        </div>
                        <div className="h-8 w-px bg-gradient-to-b from-purple-500/0 via-purple-500/50 to-purple-500/0 mt-4" />
                    </div>

                    <button
                        onClick={() => setSidePanelVisible(true)}
                        className="w-10 h-24 bg-[#0b0f1a]/80 backdrop-blur-md border border-white/5 border-r-0 rounded-l-[12px] flex flex-col items-center justify-center text-slate-400 hover:text-white transition-all duration-500 group hover:w-12 shadow-2xl relative"
                    >
                        <ChevronLeft className="h-5 w-5 group-hover:-translate-x-1 transition-transform" />
                        <div className="absolute top-0 right-0 bottom-0 w-1 bg-purple-500/30" />
                    </button>
                </div>
            </div>

            {/* Visual Flair: Global Atmosphere Glows */}
            <div className="fixed top-0 right-0 w-[800px] h-[800px] bg-purple-600/5 rounded-full blur-[150px] -mr-64 -mt-64 pointer-events-none z-0" />
            <div className="fixed bottom-0 left-0 w-[800px] h-[800px] bg-indigo-600/5 rounded-full blur-[150px] -ml-64 -mb-64 pointer-events-none z-0" />
        </div>
    );
}
