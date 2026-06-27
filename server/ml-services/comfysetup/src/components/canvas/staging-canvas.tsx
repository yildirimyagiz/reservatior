'use client';

import { forwardRef, useState, useEffect } from 'react';
import Image from 'next/image';
import { useCanvasStore, RoomType, DesignStyle } from '@/lib/store/canvas-store';
import { CanvasItemComponent } from './canvas-item';
import { cn } from '@/lib/utils';
import { AutoCompareSlider } from './auto-compare-slider';
import {
    Sparkles,
    MousePointer2,
    Home,
    Search,
    ChevronRight,
    ArrowRight
} from 'lucide-react';

const SHOWCASE_ROOMS = [
    {
        id: 1,
        before: '/images/rooms/empty/living-room-2.png',
        after: '/images/rooms/staged/living-room-2.png',
        label: 'Coastal Living',
        description: 'Furniture-first staging preserving original architecture.',
        style: 'coastal',
        type: 'living-room'
    },
    {
        id: 2,
        before: '/images/demo/bedroom_empty.png',
        after: '/images/demo/bedroom_staged.png',
        label: 'Modern Minimalist',
        description: 'Seamlessly integrated textures without structural changes.',
        style: 'modern-minimalist',
        type: 'bedroom'
    },
    {
        id: 3,
        before: '/images/rooms/empty/living-room-3.png',
        after: '/images/rooms/staged/living-room-3.png',
        label: 'Refined Contemporary',
        description: 'Atmospheric furniture staging on existing bones.',
        style: 'contemporary',
        type: 'living-room'
    },
];

export const StagingCanvas = forwardRef<HTMLDivElement>((props, ref) => {
    const {
        items,
        roomImage,
        setRoomImage,
        selectedItemIds,
        clearSelection,
        generatedImage,
        isCompareMode,
        zoom,
        updateItem,
        selectItem,
        setStyle,
        setRoomType,
        setSidePanelVisible
    } = useCanvasStore();

    const [activeIndex, setActiveIndex] = useState(0);

    // Auto-rotate the showcase focus
    useEffect(() => {
        const timer = setInterval(() => {
            setActiveIndex((current) => (current + 1) % SHOWCASE_ROOMS.length);
        }, 12000);
        return () => clearInterval(timer);
    }, []);

    const handleDrop = (e: React.DragEvent) => {
        e.preventDefault();
        const data = e.dataTransfer.getData('application/furniture');
        if (!data) return;

        const parsedData = JSON.parse(data);
        const rect = (e.currentTarget as HTMLDivElement).getBoundingClientRect();

        const x = (e.clientX - rect.left) / zoom;
        const y = (e.clientY - rect.top) / zoom;

        useCanvasStore.getState().addItem({
            type: 'furniture',
            name: parsedData.title,
            src: parsedData.imageUrl,
            x: x - 100,
            y: y - 100,
            width: 200,
            height: 200,
            rotation: 0,
            scaleX: 1,
            scaleY: 1,
            opacity: 1,
            locked: false,
            visible: true,
            shopifyProduct: parsedData.shopifyProduct
        });
    };

    const handleDragOver = (e: React.DragEvent) => {
        e.preventDefault();
        e.dataTransfer.dropEffect = 'copy';
    };

    if (!roomImage) {
        return (
            <div className="w-[1240px] max-w-full aspect-[16/9] bg-[#020617] rounded-[64px] overflow-hidden flex flex-col items-center justify-between py-12 px-12 border border-white/5 shadow-2xl relative group/canvas select-none">
                {/* Visual Flair */}
                <div className="absolute top-0 right-0 w-[800px] h-[800px] bg-purple-600/5 rounded-full blur-[160px] pointer-events-none -translate-y-1/2 translate-x-1/2 opacity-30" />
                <div className="absolute bottom-0 left-0 w-[800px] h-[800px] bg-indigo-600/5 rounded-full blur-[160px] pointer-events-none translate-y-1/2 -translate-x-1/2 opacity-30" />

                <div className="relative z-10 w-full flex flex-col items-center flex-1 justify-center gap-10">

                     {/* 3D Perspective Showcase - Coordinated Scale fixed overlap */}
                     <div className="relative w-full h-[380px] perspective-[3000px] flex items-center justify-center">
                        {SHOWCASE_ROOMS.map((room, idx) => {
                            const isCenter = idx === activeIndex;
                            const isPrev = idx === (activeIndex - 1 + SHOWCASE_ROOMS.length) % SHOWCASE_ROOMS.length;
                            const isNext = idx === (activeIndex + 1) % SHOWCASE_ROOMS.length;

                            let transformStyle = 'translateX(0) scale(0.5) rotateY(0deg)';
                            let opacity = 0;
                            let zIndex = 0;

                            if (isCenter) {
                                transformStyle = 'translateX(0) scale(1.1) rotateY(0deg)';
                                opacity = 1;
                                zIndex = 30;
                            } else if (isPrev) {
                                transformStyle = 'translateX(-440px) scale(0.75) rotateY(35deg)';
                                opacity = 0.1;
                                zIndex = 20;
                            } else if (isNext) {
                                transformStyle = 'translateX(440px) scale(0.75) rotateY(-35deg)';
                                opacity = 0.1;
                                zIndex = 20;
                            }

                            return (
                                <div
                                    key={room.id}
                                    onClick={() => {
                                        if (isCenter) {
                                            setRoomImage(room.before, 'sample.png');
                                            setStyle(room.style as DesignStyle);
                                            setRoomType(room.type as RoomType);
                                            setSidePanelVisible(true);
                                        } else {
                                            setActiveIndex(idx);
                                        }
                                    }}
                                    className={cn(
                                        "absolute w-[480px] h-[320px] transition-all duration-1000 ease-[cubic-bezier(0.23,1,0.32,1)] cursor-pointer",
                                    )}
                                    style={{
                                        transform: transformStyle,
                                        opacity: opacity,
                                        zIndex: zIndex,
                                        transformStyle: 'preserve-3d',
                                    }}
                                >
                                    <div
                                        className={cn(
                                            "w-full h-full relative rounded-[40px] overflow-hidden border border-white/10 shadow-[0_45px_100px_rgba(0,0,0,0.8)] group-hover:border-purple-500/50 transition-all duration-700",
                                            isCenter && "ring-1 ring-purple-500/30"
                                        )}
                                    >
                                        {isCenter ? (
                                            <AutoCompareSlider
                                                key={`slider-${idx}-${activeIndex}`}
                                                beforeImage={room.before}
                                                afterImage={room.after}
                                                className="w-full h-full"
                                                duration={12000}
                                            />
                                        ) : (
                                            <Image
                                                src={room.after}
                                                alt={room.label}
                                                fill
                                                className="object-cover"
                                            />
                                        )}

                                        {/* Status Badge */}
                                        <div className={cn(
                                            "absolute top-6 left-6 z-30 transition-all duration-500",
                                            isCenter ? "opacity-100 translate-y-0" : "opacity-0 translate-y-4"
                                        )}>
                                            <div className="px-3 py-1.5 bg-black/60 backdrop-blur-xl border border-white/10 rounded-xl flex items-center gap-2">
                                                <Home className="h-3 w-3 text-emerald-400" />
                                                <span className="text-[9px] font-black text-white uppercase tracking-widest whitespace-nowrap">Original Bones</span>
                                            </div>
                                        </div>

                                        {/* Content Overlay */}
                                        <div className={cn(
                                            "absolute bottom-0 inset-x-0 p-8 bg-gradient-to-t from-black via-black/40 to-transparent transition-opacity duration-700",
                                            isCenter ? "opacity-100" : "opacity-0"
                                        )}>
                                            <h3 className="text-2xl font-black text-white uppercase tracking-tight mb-2 underline decoration-purple-500/50 decoration-4 underline-offset-8">{room.label}</h3>
                                            <p className="text-[10px] text-slate-400 font-bold uppercase tracking-[0.1em] leading-tight opacity-80">{room.description}</p>
                                        </div>

                                        {/* Interaction Indicator */}
                                        {isCenter && (
                                            <div className="absolute top-1/2 right-6 -translate-y-1/2 flex items-center justify-center w-10 h-10 bg-white/10 backdrop-blur-xl border border-white/20 rounded-full text-white opacity-0 group-hover:opacity-100 transition-all duration-500 hover:bg-white hover:text-black hover:scale-110">
                                                <ArrowRight className="h-4 w-4" />
                                            </div>
                                        )}
                                    </div>

                                    {/* Subsurface Glow */}
                                    {isCenter && (
                                        <div className="absolute -bottom-20 left-1/2 -translate-x-1/2 w-[80%] h-14 bg-purple-600/10 blur-[80px] rounded-full pointer-events-none" />
                                    )}
                                </div>
                            );
                        })}
                     </div>

                     {/* Call to action center - Refined Spacing fixed overlap */}
                     <div className="flex flex-col items-center gap-8 animate-in fade-in slide-in-from-bottom-8 duration-1000 delay-500 relative z-40">
                        <div className="flex flex-col items-center text-center max-w-2xl">
                             <div className="inline-flex items-center gap-2.5 px-4 py-1.5 rounded-full bg-slate-900/40 border border-white/5 text-slate-500 text-[9px] font-black uppercase tracking-[0.5em] mb-4">
                                <Sparkles className="h-3.5 w-3.5 text-purple-400" />
                                Neural Architecture Hub
                             </div>
                             <h2 className="text-3xl font-black text-white uppercase tracking-tighter mb-3 leading-none">
                                Pure Virtual <span className="text-purple-400">Staging</span>
                             </h2>
                             <p className="text-slate-500 text-[11px] font-bold tracking-[0.05em] leading-relaxed max-w-md opacity-80">
                                Photorealistic AI furniture integration while maintaining <b>100% architectural integrity</b> and structural bones.
                             </p>
                        </div>

                        <div className="flex items-center gap-8">
                             {/* Primary Start Button */}
                            <button
                                onClick={() => setSidePanelVisible(true)}
                                className="px-10 py-4.5 rounded-[24px] bg-white text-black font-black text-[10px] uppercase tracking-[0.2em] shadow-[0_15px_40px_-10px_rgba(255,255,255,0.2)] hover:bg-purple-100 hover:shadow-purple-500/20 active:scale-[0.98] transition-all flex items-center gap-3 group/btn"
                            >
                                <MousePointer2 className="h-3.5 h-3.5 group-hover/btn:-translate-y-0.5 transition-transform" />
                                Start Designing
                            </button>

                            {/* Secondary Hint */}
                            <div className="flex flex-col items-start opacity-30 hover:opacity-100 transition-all cursor-pointer group/hint" onClick={() => setSidePanelVisible(true)}>
                                <div className="flex items-center gap-2 mb-1">
                                    <Search className="h-3 w-3 text-purple-400" />
                                    <span className="text-[9px] font-black uppercase tracking-widest text-white">Upload Sync</span>
                                </div>
                                <div className="flex items-center gap-1.5">
                                    <span className="text-[8px] font-bold text-slate-500 uppercase tracking-tighter">Use the sidebar console</span>
                                    <ChevronRight className="h-2.5 w-2.5 text-slate-600 transition-transform group-hover/hint:translate-x-1" />
                                </div>
                            </div>
                        </div>
                     </div>
                </div>

                {/* Footer Badges - Optimized Alignment */}
                <div className="w-full flex items-center justify-between border-t border-white/5 pt-6 opacity-30 hover:opacity-100 transition-opacity duration-1000 mt-auto">
                    <div className="flex items-center gap-3">
                        <div className="w-1 h-1 rounded-full bg-purple-500" />
                        <span className="text-[8px] font-black uppercase tracking-[0.5em] text-white">Neural Synthesis v3.0</span>
                    </div>

                    <div className="flex items-center gap-10">
                        <span className="text-[8px] font-black uppercase tracking-[0.5em] text-white">Structure Lock</span>
                        <div className="w-px h-2.5 bg-white/10" />
                        <span className="text-[8px] font-black uppercase tracking-[0.5em] text-white">Precision Apex</span>
                    </div>

                    <div className="flex items-center gap-3">
                        <span className="text-[8px] font-black uppercase tracking-[0.5em] text-white">Atlas VS</span>
                        <div className="w-1 h-1 rounded-full bg-indigo-500" />
                    </div>
                </div>
            </div>
        );
    }

    const currentImage = generatedImage || roomImage;

    return (
        <div
            className="relative bg-black transition-all duration-500 outline-none"
            style={{ zoom: zoom }}
            onDrop={handleDrop}
            onDragOver={handleDragOver}
            onClick={(e) => {
                if (e.target === e.currentTarget) clearSelection();
            }}
        >
            <div
                ref={ref}
                className="relative bg-[#020617] shadow-2xl overflow-hidden"
                style={{
                    width: 'auto',
                    minWidth: '800px',
                    height: 'auto',
                    minHeight: '500px',
                    maxHeight: '85vh',
                }}
            >
                {isCompareMode && generatedImage && roomImage ? (
                    <div className="relative w-full h-full aspect-[16/9]">
                         <AutoCompareSlider
                            beforeImage={roomImage}
                            afterImage={generatedImage}
                            duration={10000}
                            className="w-full h-full"
                        />
                        <div className="absolute top-4 left-1/2 -translate-x-1/2 px-4 py-2 bg-black/60 backdrop-blur-xl border border-white/10 rounded-full flex items-center gap-2 z-20">
                            <Sparkles className="h-3 w-3 text-purple-400" />
                            <span className="text-[10px] font-black uppercase tracking-widest text-white">Compare Rendering</span>
                        </div>
                    </div>
                ) : (
                    <>
                        <Image
                            src={currentImage}
                            alt="Room"
                            width={1920}
                            height={1080}
                            className={cn(
                                "max-w-full h-auto object-contain transition-all duration-1000",
                                !roomImage && "opacity-0"
                            )}
                            priority
                            draggable={false}
                        />

                        <div className="absolute inset-0 pointer-events-none">
                            {items.map((item) => (
                                <CanvasItemComponent
                                    key={item.id}
                                    item={item}
                                    isSelected={selectedItemIds.includes(item.id)}
                                    zoom={zoom}
                                    onUpdate={(updates) => updateItem(item.id, updates)}
                                    onSelect={(addToSelection) => selectItem(item.id, addToSelection)}
                                />
                            ))}
                        </div>
                    </>
                )}
            </div>

            {selectedItemIds.length > 0 && (
                 <div className="absolute -top-12 left-0 right-0 flex justify-center pointer-events-none animate-in fade-in slide-in-from-bottom-2">
                    <div className="px-4 py-1.5 bg-purple-600 text-white text-[10px] font-black uppercase tracking-widest rounded-full shadow-lg border border-purple-400/30">
                        {selectedItemIds.length} Object{selectedItemIds.length > 1 ? 's' : ''} Selected
                    </div>
                 </div>
            )}
        </div>
    );
});

StagingCanvas.displayName = 'StagingCanvas';
