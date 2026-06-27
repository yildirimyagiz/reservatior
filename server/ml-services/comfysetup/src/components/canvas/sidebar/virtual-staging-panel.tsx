'use client';

import { useState, useRef, useMemo } from 'react';
import Image from 'next/image';
import {
    Wand2,
    Sparkles,
    ChevronRight,
    Loader2,
    Info,
    CheckCircle2,
    Upload,
    MousePointer2,
    LayoutGrid,
    Armchair,
    Grid3X3,
    ChevronDown,
    Sofa
} from 'lucide-react';
import { useCanvasStore, RoomType, DesignStyle } from '@/lib/store/canvas-store';
import { DESIGN_STYLES, STAGING_TEMPLATES, FURNITURE_PLACEMENT_PRESETS, type StagingTemplate, type FurniturePlacementPreset } from '@/lib/constants/design-styles';
import { ROOM_OPTIONS } from '@/lib/constants/room-types';
import { cn } from '@/lib/utils';

type PanelTab = 'staging' | 'templates' | 'furniture';

export function VirtualStagingPanel() {
    const {
        roomImage,
        setRoomImage,
        roomType,
        style,
        setRoomType,
        setStyle,
        isGenerating,
        setIsGenerating,
        setGeneratedImage,
        setCompareMode,
        setSidePanelVisible
    } = useCanvasStore();

    const [loading, setLoading] = useState(false);
    const [activeTab, setActiveTab] = useState<PanelTab>('staging');
    const [expandedStyles, setExpandedStyles] = useState(false);
    const fileInputRef = useRef<HTMLInputElement>(null);

    const handleUploadClick = () => {
        fileInputRef.current?.click();
    };

    const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
        const file = e.target.files?.[0];
        if (!file) return;
        const reader = new FileReader();
        reader.onload = (event) => {
            setRoomImage(event.target?.result as string, file.name);
        };
        reader.readAsDataURL(file);
    };

    const handleGenerate = async () => {
        if (!roomImage) return;

        setLoading(true);
        setIsGenerating(true);

        try {
            const response = await fetch('/api/v1/staging/generate', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    imageData: roomImage,
                    roomType,
                    style,
                    extras: [],
                    computeMode: 'gpu',
                    engine: 'auto'
                }),
            });

            if (!response.ok) throw new Error('Generation failed');

            const data = await response.json();
            if (data.images && data.images.length > 0) {
                setGeneratedImage(data.images[0]);
                setCompareMode(true);
            }
        } catch (error) {
            console.error('Staging error:', error);
        } finally {
            setLoading(false);
            setIsGenerating(false);
        }
    };

    // Apply a staging template: sets the style+room and triggers generation
    const handleTemplateSelect = (template: StagingTemplate) => {
        setStyle(template.style);
        setRoomType(template.roomType as RoomType);
        setActiveTab('staging');
    };

    // Apply a furniture layout preset
    const handleLayoutPreset = (preset: FurniturePlacementPreset) => {
        const store = useCanvasStore.getState();
        preset.items.forEach((item) => {
            store.addItem({
                type: 'furniture',
                name: item.name,
                src: '', // Will be replaced with real furniture images from Shopify
                x: item.relativeX * store.canvasWidth,
                y: item.relativeY * store.canvasHeight,
                width: item.relativeWidth * store.canvasWidth,
                height: item.relativeHeight * store.canvasHeight,
                rotation: 0,
                scaleX: 1,
                scaleY: 1,
                opacity: 0.85,
                locked: false,
                visible: true,
            });
        });
    };

    // Filter templates by current room type
    const filteredTemplates = useMemo(() =>
        STAGING_TEMPLATES.filter(t => t.roomType === roomType),
        [roomType]
    );

    // Filter layout presets by current room type
    const filteredLayouts = useMemo(() =>
        FURNITURE_PLACEMENT_PRESETS.filter(p => p.roomType === roomType),
        [roomType]
    );

    const displayedStyles = expandedStyles ? DESIGN_STYLES : DESIGN_STYLES.slice(0, 6);

    const TABS = [
        { key: 'staging' as PanelTab, label: 'AI Staging', icon: Sparkles },
        { key: 'templates' as PanelTab, label: 'Templates', icon: LayoutGrid },
        { key: 'furniture' as PanelTab, label: 'Furniture', icon: Armchair },
    ];

    return (
        <div className="flex h-full flex-col bg-[#0b0f1a] text-white overflow-hidden">
            {/* Header */}
            <div className="p-5 border-b border-white/5 bg-gradient-to-br from-[#1e293b]/50 to-[#0b0f1a]/50 relative overflow-hidden group">
                <button
                    onClick={() => setSidePanelVisible(false)}
                    className="absolute top-4 right-4 p-2 rounded-xl bg-white/5 border border-white/5 text-slate-500 hover:text-white hover:bg-white/10 transition-all z-20 group/close"
                >
                    <ChevronRight className="h-4 w-4 group-hover/close:translate-x-0.5 transition-transform" />
                </button>
                <div className="absolute top-0 right-0 -mt-4 -mr-4 w-24 h-24 bg-purple-500/10 rounded-full blur-3xl group-hover:bg-purple-500/20 transition-all duration-700" />

                <div className="flex items-center gap-2 mb-2 relative z-10">
                    <div className="p-2 bg-purple-500/20 rounded-lg border border-purple-500/30">
                        <Sparkles className="h-4 w-4 text-purple-400" />
                    </div>
                    <div>
                        <h2 className="font-extrabold text-sm tracking-widest uppercase bg-clip-text text-transparent bg-gradient-to-r from-purple-400 to-indigo-400">
                            Staging Studio
                        </h2>
                        <div className="h-0.5 w-12 bg-purple-500/50 rounded-full mt-0.5" />
                    </div>
                </div>
                <p className="text-xs text-slate-400 font-medium leading-relaxed relative z-10">
                    Precision AI environment staging &amp; furniture placement.
                </p>
            </div>

            {/* Tab Navigation */}
            <div className="flex items-center gap-1 p-3 border-b border-white/5 bg-[#070b14]">
                {TABS.map((tab) => {
                    const Icon = tab.icon;
                    return (
                        <button
                            key={tab.key}
                            onClick={() => setActiveTab(tab.key)}
                            className={cn(
                                "flex-1 flex items-center justify-center gap-1.5 py-2.5 px-3 rounded-xl text-[9px] font-black uppercase tracking-widest transition-all duration-300",
                                activeTab === tab.key
                                    ? "bg-purple-600/20 text-purple-400 border border-purple-500/30 shadow-lg shadow-purple-900/10"
                                    : "text-slate-500 hover:text-slate-300 hover:bg-white/5 border border-transparent"
                            )}
                        >
                            <Icon className="h-3.5 w-3.5" />
                            <span className="hidden sm:inline">{tab.label}</span>
                        </button>
                    );
                })}
            </div>

            <div className="flex-1 overflow-y-auto p-5 space-y-6 scrollbar-thin">

                {/* ====== TAB: AI Staging ====== */}
                {activeTab === 'staging' && (
                    <>
                        {/* Step 1: Upload */}
                        <div className="space-y-3">
                            <label className="text-[10px] font-black text-slate-500 uppercase tracking-[0.2em] flex items-center gap-2">
                                <span className="flex items-center justify-center w-5 h-5 rounded-md bg-purple-500/20 text-purple-400 text-[10px] border border-purple-500/30 font-bold">1</span>
                                Scene Initialization
                            </label>

                            <button
                                onClick={handleUploadClick}
                                className={cn(
                                    "w-full group/upload relative rounded-[20px] border-2 border-dashed transition-all p-5 flex flex-col items-center gap-2.5 overflow-hidden",
                                    roomImage
                                        ? "bg-emerald-500/5 border-emerald-500/30"
                                        : "bg-white/5 border-white/5 hover:bg-white/[0.08] hover:border-purple-500/30"
                                )}
                            >
                                <input ref={fileInputRef} type="file" accept="image/*" className="hidden" onChange={handleFileChange} />
                                <div className={cn(
                                    "w-10 h-10 rounded-2xl flex items-center justify-center border shadow-2xl transition-all duration-500",
                                    roomImage ? "bg-emerald-500/20 border-emerald-500/30 scale-90" : "bg-slate-900 border-white/10 group-hover/upload:scale-110"
                                )}>
                                    <Upload className={cn("h-4 w-4", roomImage ? "text-emerald-400" : "text-purple-400")} />
                                </div>
                                <div className="text-center">
                                    <p className="text-[10px] font-black text-white uppercase tracking-widest">
                                        {roomImage ? "Image Uploaded" : "Upload Your Space"}
                                    </p>
                                    <p className="text-[8px] text-slate-500 font-bold uppercase tracking-tighter mt-0.5">
                                        {roomImage ? "Change source" : "PNG, JPG up to 10MB"}
                                    </p>
                                </div>

                                {roomImage && (
                                    <div className="absolute top-2 right-2 flex items-center gap-1 px-2 py-0.5 rounded-full bg-emerald-500/10 border border-emerald-500/20">
                                        <CheckCircle2 className="h-2.5 w-2.5 text-emerald-400" />
                                        <span className="text-[8px] font-black text-emerald-400 uppercase">Synced</span>
                                    </div>
                                )}
                            </button>

                            {!roomImage && (
                                <div className="flex items-center justify-center gap-2 opacity-30 mt-1">
                                    <MousePointer2 className="h-3 w-3" />
                                    <span className="text-[8px] font-black uppercase tracking-widest">Or Drag & Drop Assets</span>
                                </div>
                            )}
                        </div>

                        {/* Step 2: Room Context */}
                        <div className="space-y-3">
                            <div className="flex items-center justify-between">
                                <label className="text-[10px] font-black text-slate-500 uppercase tracking-[0.2em] flex items-center gap-2">
                                    <span className="flex items-center justify-center w-5 h-5 rounded-md bg-slate-800 text-slate-400 text-[10px] border border-slate-700 font-bold">2</span>
                                    Room Context
                                </label>
                                <span className="text-[9px] text-purple-400 font-black px-2 py-0.5 rounded-full bg-purple-500/10 border border-purple-500/20 tracking-tighter uppercase">Required</span>
                            </div>

                            <div className="grid grid-cols-3 gap-2">
                                {ROOM_OPTIONS.slice(0, 6).map((type) => {
                                    const Icon = type.icon;
                                    const isActive = roomType === type.value;
                                    return (
                                        <button
                                            key={type.value}
                                            onClick={() => setRoomType(type.value as RoomType)}
                                            className={cn(
                                                "flex flex-col items-center gap-1.5 p-2.5 rounded-xl border text-xs font-bold transition-all duration-300 relative group overflow-hidden",
                                                isActive
                                                    ? "bg-purple-600/10 border-purple-500/50 text-white shadow-lg shadow-purple-900/20"
                                                    : "bg-slate-900/20 border-slate-800/50 text-slate-500 hover:border-slate-700 hover:text-slate-300 hover:bg-slate-800/30"
                                            )}
                                        >
                                            <Icon className={cn(
                                                "h-4 w-4 transition-all duration-300",
                                                isActive ? "text-purple-400 scale-110" : "opacity-40 group-hover:opacity-80"
                                            )} />
                                            <span className="truncate w-full text-center tracking-tight text-[9px]">{type.label}</span>
                                        </button>
                                    );
                                })}
                            </div>
                        </div>

                        {/* Step 3: Design Styles with staged template images */}
                        <div className="space-y-3 pb-4">
                            <label className="text-[10px] font-black text-slate-500 uppercase tracking-[0.2em] flex items-center gap-2">
                                <span className="flex items-center justify-center w-5 h-5 rounded-md bg-slate-800 text-slate-400 text-[10px] border border-slate-700 font-bold">3</span>
                                Artistic Direction
                            </label>

                            <div className="grid grid-cols-1 gap-3">
                                {displayedStyles.map((designStyle) => {
                                    const isActive = style === designStyle.value;
                                    return (
                                        <button
                                            key={designStyle.value}
                                            onClick={() => setStyle(designStyle.value as DesignStyle)}
                                            className={cn(
                                                "group relative flex flex-col p-1 rounded-2xl border transition-all duration-500 overflow-hidden",
                                                isActive
                                                    ? "bg-white/5 border-purple-500/50 shadow-2xl shadow-purple-900/20 ring-1 ring-purple-500/30"
                                                    : "bg-slate-900/40 border-slate-800/50 hover:border-slate-700"
                                            )}
                                        >
                                            <div className="aspect-[16/7] w-full rounded-[14px] overflow-hidden relative">
                                                <Image
                                                    src={designStyle.image}
                                                    alt={designStyle.label}
                                                    fill
                                                    className={cn(
                                                        "object-cover transition-transform duration-1000",
                                                        isActive ? "scale-105" : "group-hover:scale-110 opacity-70 grayscale-[40%] group-hover:grayscale-0"
                                                    )}
                                                />
                                                <div className="absolute inset-x-0 bottom-0 h-2/3 bg-gradient-to-t from-black via-black/50 to-transparent" />
                                                
                                                {/* Style Label & Tags */}
                                                <div className="absolute bottom-2.5 left-3 right-3">
                                                    <span className="text-[11px] font-black text-white uppercase tracking-widest block">{designStyle.label}</span>
                                                    <span className="text-[8px] text-slate-300/70 font-semibold block mt-0.5 leading-tight">{designStyle.description}</span>
                                                </div>
                                            </div>
                                            
                                            {/* Tags row */}
                                            {isActive && designStyle.tags && (
                                                <div className="flex items-center gap-1 px-2 py-1.5 animate-in fade-in slide-in-from-top-1 duration-300">
                                                    {designStyle.tags.map((tag) => (
                                                        <span key={tag} className="text-[7px] font-black uppercase tracking-widest px-2 py-0.5 rounded-full bg-purple-500/10 text-purple-400 border border-purple-500/20">
                                                            {tag}
                                                        </span>
                                                    ))}
                                                </div>
                                            )}
                                            
                                            {isActive && (
                                                <div className="absolute top-3 right-3 bg-purple-500 rounded-full p-1.5 shadow-xl">
                                                    <CheckCircle2 className="h-3 w-3 text-white" />
                                                </div>
                                            )}
                                        </button>
                                    );
                                })}
                            </div>

                            {/* Show More / Less */}
                            {DESIGN_STYLES.length > 6 && (
                                <button
                                    onClick={() => setExpandedStyles(!expandedStyles)}
                                    className="w-full flex items-center justify-center gap-2 py-2.5 rounded-xl bg-white/5 border border-white/5 text-slate-500 hover:text-white hover:bg-white/10 transition-all text-[9px] font-black uppercase tracking-widest"
                                >
                                    <ChevronDown className={cn("h-3.5 w-3.5 transition-transform", expandedStyles && "rotate-180")} />
                                    {expandedStyles ? 'Show Less' : `Show All ${DESIGN_STYLES.length} Styles`}
                                </button>
                            )}
                        </div>

                        {/* Info Note */}
                        <div className="p-3 rounded-2xl bg-indigo-500/5 border border-indigo-500/10 flex gap-3">
                            <div className="shrink-0 flex items-center justify-center w-7 h-7 rounded-lg bg-indigo-500/10 border border-indigo-500/20 text-indigo-400">
                                <Info className="h-3.5 w-3.5" />
                            </div>
                            <div>
                                <p className="text-[8px] font-black text-indigo-400 uppercase tracking-widest mb-0.5">Architecture Intel</p>
                                <p className="text-[9px] text-slate-400 leading-relaxed font-semibold">
                                    Neural engine calibrated to <b className="text-indigo-300">{style}</b>. Window light and shadows preserved.
                                </p>
                            </div>
                        </div>
                    </>
                )}

                {/* ====== TAB: Staging Templates ====== */}
                {activeTab === 'templates' && (
                    <div className="space-y-5">
                        <div>
                            <label className="text-[10px] font-black text-slate-500 uppercase tracking-[0.2em] flex items-center gap-2 mb-3">
                                <Grid3X3 className="h-4 w-4 text-purple-400" />
                                Staged Templates for {roomType.replace('-', ' ')}
                            </label>

                            {filteredTemplates.length === 0 ? (
                                <div className="p-6 rounded-2xl bg-slate-800/30 border border-slate-700/30 text-center">
                                    <LayoutGrid className="h-8 w-8 mx-auto mb-3 text-slate-600" />
                                    <p className="text-[10px] font-bold text-slate-500 uppercase tracking-widest">No templates for this room type</p>
                                    <p className="text-[9px] text-slate-600 mt-1">Switch to Living Room, Bedroom, or Office</p>
                                </div>
                            ) : (
                                <div className="space-y-3">
                                    {filteredTemplates.map((template) => {
                                        const isActive = style === template.style;
                                        return (
                                            <button
                                                key={template.id}
                                                onClick={() => handleTemplateSelect(template)}
                                                className={cn(
                                                    "w-full group relative rounded-2xl border overflow-hidden transition-all duration-500",
                                                    isActive
                                                        ? "border-purple-500/50 ring-1 ring-purple-500/20 shadow-xl shadow-purple-900/10"
                                                        : "border-slate-800/50 hover:border-slate-700"
                                                )}
                                            >
                                                <div className="aspect-[16/9] relative">
                                                    <Image
                                                        src={template.thumbnail}
                                                        alt={template.label}
                                                        fill
                                                        className={cn(
                                                            "object-cover transition-all duration-700",
                                                            isActive ? "scale-100" : "opacity-60 grayscale-[30%] group-hover:opacity-100 group-hover:grayscale-0 group-hover:scale-105"
                                                        )}
                                                    />
                                                    <div className="absolute inset-0 bg-gradient-to-t from-black via-black/30 to-transparent" />
                                                    
                                                    <div className="absolute bottom-3 left-3 right-3">
                                                        <h4 className="text-[11px] font-black text-white uppercase tracking-widest">{template.label}</h4>
                                                        <p className="text-[8px] text-slate-300/80 font-semibold mt-0.5">{template.description}</p>
                                                    </div>

                                                    {isActive && (
                                                        <div className="absolute top-3 right-3 bg-purple-500 rounded-full p-1.5 shadow-xl animate-in zoom-in duration-300">
                                                            <CheckCircle2 className="h-3 w-3 text-white" />
                                                        </div>
                                                    )}
                                                </div>
                                            </button>
                                        );
                                    })}
                                </div>
                            )}
                        </div>

                        {/* All Templates (other room types) */}
                        {STAGING_TEMPLATES.filter(t => t.roomType !== roomType).length > 0 && (
                            <div>
                                <label className="text-[10px] font-black text-slate-600 uppercase tracking-[0.2em] flex items-center gap-2 mb-3">
                                    Other Styles
                                </label>
                                <div className="grid grid-cols-2 gap-2">
                                    {STAGING_TEMPLATES.filter(t => t.roomType !== roomType).map((template) => (
                                        <button
                                            key={template.id}
                                            onClick={() => handleTemplateSelect(template)}
                                            className="group relative rounded-xl border border-slate-800/50 overflow-hidden hover:border-slate-700 transition-all"
                                        >
                                            <div className="aspect-[4/3] relative">
                                                <Image
                                                    src={template.thumbnail}
                                                    alt={template.label}
                                                    fill
                                                    className="object-cover opacity-50 grayscale-[50%] group-hover:opacity-100 group-hover:grayscale-0 transition-all duration-500 group-hover:scale-105"
                                                />
                                                <div className="absolute inset-0 bg-gradient-to-t from-black/80 to-transparent" />
                                                <div className="absolute bottom-2 left-2 right-2">
                                                    <span className="text-[8px] font-black text-white uppercase tracking-wider">{template.label}</span>
                                                    <span className="block text-[7px] text-slate-400 font-bold uppercase tracking-tighter mt-0.5">{template.roomType.replace('-', ' ')}</span>
                                                </div>
                                            </div>
                                        </button>
                                    ))}
                                </div>
                            </div>
                        )}
                    </div>
                )}

                {/* ====== TAB: Furniture Placement ====== */}
                {activeTab === 'furniture' && (
                    <div className="space-y-5">
                        {/* Layout Presets */}
                        <div>
                            <label className="text-[10px] font-black text-slate-500 uppercase tracking-[0.2em] flex items-center gap-2 mb-3">
                                <Sofa className="h-4 w-4 text-purple-400" />
                                Furniture Layout Presets
                            </label>

                            {filteredLayouts.length === 0 ? (
                                <div className="p-6 rounded-2xl bg-slate-800/30 border border-slate-700/30 text-center">
                                    <Armchair className="h-8 w-8 mx-auto mb-3 text-slate-600" />
                                    <p className="text-[10px] font-bold text-slate-500 uppercase tracking-widest">No layout presets for {roomType.replace('-', ' ')}</p>
                                    <p className="text-[9px] text-slate-600 mt-1">Try Living Room, Bedroom, or Office</p>
                                </div>
                            ) : (
                                <div className="space-y-3">
                                    {filteredLayouts.map((preset) => (
                                        <button
                                            key={preset.id}
                                            onClick={() => handleLayoutPreset(preset)}
                                            className="w-full group flex items-start gap-4 p-4 rounded-2xl border border-slate-800/50 bg-slate-900/30 hover:border-purple-500/30 hover:bg-purple-500/5 transition-all duration-300"
                                        >
                                            {/* Layout Preview Grid */}
                                            <div className="shrink-0 w-16 h-14 rounded-xl bg-slate-800/50 border border-white/5 relative overflow-hidden">
                                                {preset.items.map((item, idx) => (
                                                    <div
                                                        key={idx}
                                                        className="absolute bg-purple-500/30 border border-purple-500/50 rounded-sm group-hover:bg-purple-500/50 transition-colors"
                                                        style={{
                                                            left: `${item.relativeX * 100}%`,
                                                            top: `${item.relativeY * 100}%`,
                                                            width: `${item.relativeWidth * 100}%`,
                                                            height: `${item.relativeHeight * 100}%`,
                                                        }}
                                                    />
                                                ))}
                                            </div>
                                            
                                            <div className="text-left flex-1 min-w-0">
                                                <h4 className="text-[11px] font-black text-white uppercase tracking-widest truncate group-hover:text-purple-300 transition-colors">
                                                    {preset.label}
                                                </h4>
                                                <p className="text-[9px] text-slate-500 font-semibold mt-0.5 leading-relaxed">
                                                    {preset.description}
                                                </p>
                                                <div className="flex items-center gap-2 mt-2">
                                                    <span className="text-[7px] font-black uppercase tracking-widest px-2 py-0.5 rounded-full bg-slate-800 text-slate-400 border border-slate-700">
                                                        {preset.items.length} items
                                                    </span>
                                                    <span className="text-[7px] font-black uppercase tracking-widest text-purple-400 opacity-0 group-hover:opacity-100 transition-opacity">
                                                        Click to apply →
                                                    </span>
                                                </div>
                                            </div>
                                        </button>
                                    ))}
                                </div>
                            )}
                        </div>

                        {/* Manual Furniture Info */}
                        <div className="p-3 rounded-2xl bg-amber-500/5 border border-amber-500/10 flex gap-3">
                            <div className="shrink-0 flex items-center justify-center w-7 h-7 rounded-lg bg-amber-500/10 border border-amber-500/20 text-amber-400">
                                <Armchair className="h-3.5 w-3.5" />
                            </div>
                            <div>
                                <p className="text-[8px] font-black text-amber-400 uppercase tracking-widest mb-0.5">Drag & Drop</p>
                                <p className="text-[9px] text-slate-400 leading-relaxed font-semibold">
                                    Use the <b className="text-amber-300">Furniture Browser</b> in the toolbar to drag individual pieces onto the canvas for custom placement.
                                </p>
                            </div>
                        </div>
                    </div>
                )}
            </div>

            {/* Sticky Action Footer */}
            <div className="p-5 bg-gradient-to-t from-[#0f172a] via-[#0f172a]/95 to-transparent backdrop-blur-xl border-t border-white/5 relative">
                <div className="absolute inset-x-0 -top-px h-px bg-gradient-to-r from-transparent via-purple-500/30 to-transparent" />

                <button
                    onClick={handleGenerate}
                    disabled={!roomImage || isGenerating || loading}
                    className={cn(
                        "group relative w-full py-4.5 rounded-[20px] font-black text-xs uppercase tracking-[0.2em] flex items-center justify-center gap-3 transition-all duration-500 overflow-hidden",
                        roomImage && !isGenerating && !loading
                            ? "bg-white text-black shadow-[0_12px_40px_-10px_rgba(255,255,255,0.2)]"
                            : "bg-slate-800 text-slate-500 cursor-not-allowed grayscale"
                    )}
                >
                    <div className="absolute inset-0 bg-gradient-to-r from-purple-500 to-indigo-500 opacity-0 group-hover:opacity-100 transition-opacity duration-500" />
                    <div className="relative z-10 flex items-center gap-3 group-hover:text-white transition-colors duration-300">
                        {isGenerating || loading ? (
                            <>
                                <Loader2 className="h-5 w-5 animate-spin" />
                                <span className="animate-pulse">Synthesizing...</span>
                            </>
                        ) : (
                            <>
                                <Wand2 className="h-5 w-5 transition-transform group-hover:rotate-12" />
                                <span>Generate Scene</span>
                            </>
                        )}
                    </div>
                </button>
            </div>
        </div>
    );
}
