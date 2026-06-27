'use client';

import { useState } from 'react';
import { useCanvasStore, RoomType, DesignStyle } from '@/lib/store/canvas-store';
import { ChevronLeft, Sparkles, ChevronRight, Loader2 } from 'lucide-react';
import { cn } from '@/lib/utils';
import { SelectionModal } from './settings/selection-modal';
import { useStagingGeneration } from '@/hooks/use-staging-generation';
import { ROOM_OPTIONS } from '@/lib/constants/room-types';
import { DESIGN_STYLES } from '@/lib/constants/design-styles';

export function CanvasBottomToolbar() {
    const { roomType, setRoomType, style, setStyle, isGenerating, roomImage } = useCanvasStore();
    const { generateStaging } = useStagingGeneration();

    const [roomModalOpen, setRoomModalOpen] = useState(false);
    const [styleModalOpen, setStyleModalOpen] = useState(false);

    if (!roomImage) return null;

    const currentRoom = ROOM_OPTIONS.find(r => r.value === roomType) || ROOM_OPTIONS[0];
    const currentStyle = DESIGN_STYLES.find(s => s.value === style) || DESIGN_STYLES[0];

    return (
        <div className="absolute bottom-10 left-1/2 -translate-x-1/2 z-50">
            <div className="bg-[#0f172a]/80 backdrop-blur-2xl border border-white/10 shadow-[0_20px_50px_-12px_rgba(0,0,0,0.8)] rounded-[24px] px-2 py-2 flex items-center gap-1.5 transition-all hover:bg-[#0f172a]/90">

                {/* Back Button */}
                <button
                    onClick={() => useCanvasStore.getState().setRoomImage(null, '')}
                    className="h-12 w-12 flex items-center justify-center rounded-2xl hover:bg-white/5 text-slate-500 hover:text-white transition-all group"
                    title="Back to Gallery"
                >
                    <ChevronLeft className="h-5 w-5 group-hover:-translate-x-0.5 transition-transform" />
                </button>

                <div className="h-8 w-px bg-white/5 mx-1" />

                {/* Selection Controls Group */}
                <div className="flex items-center gap-1 bg-black/20 rounded-[18px] p-1 border border-white/5">
                    {/* Room Type Selector */}
                    <button
                        onClick={() => setRoomModalOpen(true)}
                        className="h-10 px-4 flex items-center gap-3 rounded-[14px] hover:bg-white/5 transition-all group"
                    >
                         <div className="flex flex-col items-start">
                            <span className="text-[8px] font-black text-slate-500 uppercase tracking-widest leading-none mb-1">Room Type</span>
                            <span className="text-xs font-bold text-white leading-none">{currentRoom.label}</span>
                        </div>
                        <ChevronRight className="h-3 w-3 text-slate-600 rotate-90 opacity-0 group-hover:opacity-100 transition-opacity" />
                    </button>

                    <div className="h-6 w-px bg-white/5" />

                    {/* Design Style Selector */}
                    <button
                        onClick={() => setStyleModalOpen(true)}
                        className="h-10 px-4 flex items-center gap-3 rounded-[14px] hover:bg-white/5 transition-all group"
                    >
                        <div className="flex flex-col items-start">
                            <span className="text-[8px] font-black text-slate-500 uppercase tracking-widest leading-none mb-1">Design Style</span>
                            <span className="text-xs font-bold text-white leading-none">{currentStyle.label}</span>
                        </div>
                        <ChevronRight className="h-3 w-3 text-slate-600 rotate-90 opacity-0 group-hover:opacity-100 transition-opacity" />
                    </button>
                </div>

                <div className="h-8 w-px bg-white/5 mx-1" />

                {/* Generate Button Refinement */}
                <button
                    onClick={generateStaging}
                    disabled={isGenerating}
                    className={cn(
                        "h-12 px-8 rounded-[18px] font-black text-[11px] uppercase tracking-[0.2em] flex items-center gap-3 transition-all relative overflow-hidden group/btn",
                        isGenerating
                            ? "bg-slate-800 text-slate-500"
                            : "bg-white text-black shadow-[0_10px_20px_-5px_rgba(255,255,255,0.1)] hover:shadow-[0_10px_30px_-5px_rgba(255,255,255,0.2)] hover:scale-[1.02] active:scale-95"
                    )}
                >
                    {!isGenerating && <div className="absolute inset-0 bg-gradient-to-r from-purple-500 to-indigo-500 opacity-0 group-hover/btn:opacity-100 transition-opacity" />}

                    <div className="relative z-10 flex items-center gap-2 group-hover/btn:text-white transition-colors">
                        {isGenerating ? (
                            <>
                                <Loader2 className="h-4 w-4 animate-spin" />
                                Synthesizing...
                            </>
                        ) : (
                            <>
                                <Sparkles className="h-3.5 w-3.5" />
                                Stage Now
                            </>
                        )}
                    </div>
                </button>
            </div>

            {/* Modals */}
            <SelectionModal
                open={roomModalOpen}
                onOpenChange={setRoomModalOpen}
                title="Select Room Type"
                options={ROOM_OPTIONS}
                selectedValue={roomType}
                onSelect={(val) => {
                    setRoomType(val as RoomType);
                    setRoomModalOpen(false);
                }}
            />

            <SelectionModal
                open={styleModalOpen}
                onOpenChange={setStyleModalOpen}
                title="Select Design Style"
                options={DESIGN_STYLES}
                selectedValue={style}
                onSelect={(val) => {
                    setStyle(val as DesignStyle);
                    setStyleModalOpen(false);
                }}
            />
        </div>
    );
}
