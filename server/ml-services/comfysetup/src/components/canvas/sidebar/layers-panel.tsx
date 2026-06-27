'use client';

import { useCanvasStore } from '@/lib/store/canvas-store';
import {
    Eye,
    EyeOff,
    Lock,
    Unlock,
    Trash2,
    Copy,
    ChevronUp,
    ChevronDown,
    Armchair,
    Layers,
    Type,
    Image as ImageIcon,
    MoreVertical,
    ChevronRight,
} from 'lucide-react';
import { cn } from '@/lib/utils';
import Image from 'next/image';

export function LayersPanel() {
    const {
        items,
        selectedItemIds,
        selectItem,
        updateItem,
        removeItem,
        duplicateItem,
        moveUp,
        moveDown,
        setSidePanelVisible,
    } = useCanvasStore();

    // Sort items by z-index (highest first for layer list)
    const sortedItems = [...items].sort((a, b) => b.zIndex - a.zIndex);

    if (items.length === 0) {
        return (
            <div className="flex h-full flex-col bg-[#0b0f1a] overflow-hidden">
                <div className="p-6 border-b border-white/5 bg-gradient-to-br from-[#1e293b]/50 to-[#0b0f1a]/50 relative overflow-hidden group">
                    <button
                        onClick={() => setSidePanelVisible(false)}
                        className="absolute top-4 right-4 p-2 rounded-xl bg-white/5 border border-white/5 text-slate-500 hover:text-white hover:bg-white/10 transition-all z-20 group/close"
                    >
                        <ChevronRight className="h-4 w-4 group-hover/close:translate-x-0.5 transition-transform" />
                    </button>
                    <div className="flex items-center gap-2 mb-2 relative z-10">
                        <div className="p-2 bg-indigo-500/20 rounded-lg border border-indigo-500/30">
                            <Layers className="h-4 w-4 text-indigo-400" />
                        </div>
                        <h2 className="font-extrabold text-sm tracking-widest uppercase bg-clip-text text-transparent bg-gradient-to-r from-indigo-400 to-purple-400">
                            Scene Layers
                        </h2>
                    </div>
                </div>
                <div className="flex-1 flex flex-col items-center justify-center p-8 text-center">
                    <div className="w-16 h-16 rounded-3xl bg-slate-900/50 border border-white/5 flex items-center justify-center mb-6 opacity-20">
                        <Layers className="h-8 w-8 text-slate-400" />
                    </div>
                    <h3 className="text-xs font-black text-slate-500 uppercase tracking-[0.2em] mb-2">Empty Canvas</h3>
                    <p className="text-[10px] text-slate-600 font-medium max-w-[180px] leading-relaxed uppercase tracking-widest">
                        Your composition is empty. Add assets to see them here.
                    </p>
                </div>
            </div>
        );
    }

    return (
        <div className="flex h-full flex-col bg-[#0b0f1a] text-white overflow-hidden">
            {/* Header */}
            <div className="p-6 border-b border-white/5 bg-gradient-to-br from-[#1e293b]/50 to-[#0b0f1a]/50 relative overflow-hidden group">
                <button
                    onClick={() => setSidePanelVisible(false)}
                    className="absolute top-4 right-4 p-2 rounded-xl bg-white/5 border border-white/5 text-slate-500 hover:text-white hover:bg-white/10 transition-all z-20 group/close"
                >
                    <ChevronRight className="h-4 w-4 group-hover/close:translate-x-0.5 transition-transform" />
                </button>
                <div className="absolute top-0 right-0 -mt-4 -mr-4 w-24 h-24 bg-indigo-500/10 rounded-full blur-3xl" />

                <div className="flex items-center gap-2 mb-2 relative z-10">
                    <div className="p-2 bg-indigo-500/20 rounded-lg border border-indigo-500/30">
                        <Layers className="h-4 w-4 text-indigo-400" />
                    </div>
                    <div>
                        <h2 className="font-extrabold text-sm tracking-widest uppercase bg-clip-text text-transparent bg-gradient-to-r from-indigo-400 to-purple-400">
                            Scene Layers
                        </h2>
                        <div className="h-0.5 w-12 bg-indigo-500/50 rounded-full mt-0.5" />
                    </div>
                </div>
                <p className="text-xs text-slate-400 font-medium tracking-tight relative z-10">
                    Manage {items.length} active elements in your composition.
                </p>
            </div>

            <div className="flex-1 overflow-y-auto p-4 space-y-2 scrollbar-thin">
                {sortedItems.map((item) => {
                    const isSelected = selectedItemIds.includes(item.id);
                    const Icon = item.type === 'furniture' ? Armchair : item.type === 'text' ? Type : ImageIcon;

                    return (
                        <div
                            key={item.id}
                            onClick={() => selectItem(item.id)}
                            className={cn(
                                "group flex items-center gap-3 p-3 rounded-2xl border transition-all duration-300 cursor-pointer relative overflow-hidden",
                                isSelected
                                    ? "bg-white/5 border-purple-500/40 shadow-lg shadow-black/20"
                                    : "bg-slate-900/40 border-white/5 hover:border-white/10 hover:bg-slate-900/60"
                            )}
                        >
                            {/* Layer Indicator */}
                            {isSelected && (
                                <div className="absolute left-0 top-1/2 -translate-y-1/2 w-1 h-8 bg-purple-500 rounded-r-full shadow-[0_0_10px_rgba(168,85,247,0.5)]" />
                            )}

                            {/* Thumbnail Container */}
                            <div className="h-12 w-12 flex-shrink-0 overflow-hidden rounded-xl bg-slate-800 border border-white/5 relative group-hover:scale-105 transition-transform duration-500">
                                {item.src ? (
                                    <Image
                                        src={item.src}
                                        alt={item.name}
                                        fill
                                        className="object-contain p-1"
                                    />
                                ) : (
                                    <div className="flex h-full w-full items-center justify-center text-slate-600">
                                        <Icon className="h-5 w-5" />
                                    </div>
                                )}
                            </div>

                            {/* Info */}
                            <div className="min-w-0 flex-1">
                                <p className={cn(
                                    "truncate text-xs font-black uppercase tracking-tight transition-colors",
                                    isSelected ? "text-white" : "text-slate-400 group-hover:text-slate-200"
                                )}>
                                    {item.name}
                                </p>
                                <div className="flex items-center gap-1.5 mt-0.5">
                                    <Icon className="h-2.5 w-2.5 text-slate-600" />
                                    <span className="text-[9px] font-bold text-slate-600 uppercase tracking-widest">
                                        {item.type} • Z-{item.zIndex}
                                    </span>
                                </div>
                            </div>

                            {/* Layer Actions */}
                            <div className={cn(
                                "flex items-center gap-0.5 transition-all duration-300",
                                isSelected ? "opacity-100" : "opacity-0 group-hover:opacity-100"
                            )}>
                                {/* Order Controls */}
                                <div className="flex flex-col gap-0.5 mr-1">
                                    <button
                                        onClick={(e) => { e.stopPropagation(); moveUp(item.id); }}
                                        className="p-1 rounded-md bg-white/5 hover:bg-white/10 text-slate-500 hover:text-white transition-all shadow-sm"
                                        title="Bring Forward"
                                    >
                                        <ChevronUp className="h-3 w-3" />
                                    </button>
                                    <button
                                        onClick={(e) => { e.stopPropagation(); moveDown(item.id); }}
                                        className="p-1 rounded-md bg-white/5 hover:bg-white/10 text-slate-500 hover:text-white transition-all shadow-sm"
                                        title="Send Backward"
                                    >
                                        <ChevronDown className="h-3 w-3" />
                                    </button>
                                </div>

                                {/* Visibility & Lock */}
                                <div className="flex items-center bg-black/20 rounded-lg p-0.5 border border-white/5 backdrop-blur-sm">
                                    <button
                                        onClick={(e) => { e.stopPropagation(); updateItem(item.id, { visible: !item.visible }); }}
                                        className={cn(
                                            "p-1.5 rounded-md transition-all",
                                            item.visible ? "text-slate-400 hover:text-white hover:bg-white/5" : "text-purple-400 bg-purple-500/10"
                                        )}
                                        title={item.visible ? 'Hide' : 'Show'}
                                    >
                                        {item.visible ? <Eye className="h-3.5 w-3.5" /> : <EyeOff className="h-3.5 w-3.5" />}
                                    </button>
                                    <button
                                        onClick={(e) => { e.stopPropagation(); updateItem(item.id, { locked: !item.locked }); }}
                                        className={cn(
                                            "p-1.5 rounded-md transition-all",
                                            !item.locked ? "text-slate-400 hover:text-white hover:bg-white/5" : "text-amber-400 bg-amber-500/10"
                                        )}
                                        title={item.locked ? 'Unlock' : 'Lock'}
                                    >
                                        {item.locked ? <Lock className="h-3.5 w-3.5" /> : <Unlock className="h-3.5 w-3.5" />}
                                    </button>
                                    <button
                                        onClick={(e) => { e.stopPropagation(); duplicateItem(item.id); }}
                                        className="p-1.5 rounded-md text-slate-400 hover:text-white hover:bg-white/5 transition-all"
                                        title="Duplicate Layer"
                                    >
                                        <Copy className="h-3.5 w-3.5" />
                                    </button>
                                </div>

                                {/* Danger Actions */}
                                <button
                                    onClick={(e) => { e.stopPropagation(); removeItem(item.id); }}
                                    className="p-1.5 ml-1 rounded-lg text-slate-600 hover:text-red-400 hover:bg-red-500/10 transition-all opacity-40 group-hover:opacity-100"
                                    title="Remove Layer"
                                >
                                    <Trash2 className="h-3.5 w-3.5" />
                                </button>
                            </div>
                        </div>
                    );
                })}
            </div>

            {/* Premium Instruction Note */}
            <div className="p-5 border-t border-white/5 bg-[#0a0f1d] relative">
                <div className="flex items-center gap-3">
                    <div className="w-8 h-8 rounded-xl bg-purple-500/10 border border-purple-500/20 flex items-center justify-center text-purple-400">
                        <MoreVertical className="h-4 w-4" />
                    </div>
                    <div>
                        <p className="text-[9px] font-black text-slate-500 uppercase tracking-widest mb-0.5">Selection Hint</p>
                        <p className="text-[10px] text-slate-600 font-bold leading-tight">
                            Elements highlight on select. Drag to reorder layout sequence.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    );
}
