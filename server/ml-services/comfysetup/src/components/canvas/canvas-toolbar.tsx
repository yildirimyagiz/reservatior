'use client';

import { useRef, useState } from 'react';
import { useCanvasStore } from '@/lib/store/canvas-store';
import NextImage from 'next/image';
import {
    Undo2,
    Redo2,
    Download,
    Sparkles,
    ChevronDown,
    Image as ImageIcon,
    Zap,
    Upload,
    Home,
    Settings2,
    Share2,
} from 'lucide-react';
import {
    DropdownMenu,
    DropdownMenuContent,
    DropdownMenuItem,
    DropdownMenuTrigger,
} from '@/components/ui/dropdown-menu';

import html2canvas from 'html2canvas';
import { toast } from 'sonner';
import { FileText as FileTextIcon } from 'lucide-react';
import { BrochureModal } from './brochure-modal';
import { ComplianceModal } from './compliance-modal';
import { useRouter } from 'next/navigation';
import { ROOM_OPTIONS } from '@/lib/constants/room-types';
import { DESIGN_STYLES } from '@/lib/constants/design-styles';

interface CanvasToolbarProps {
    canvasRef?: React.RefObject<HTMLDivElement>;
}

export function CanvasToolbar({ canvasRef }: CanvasToolbarProps) {
    const {
        roomType,
        style,
        setRoomImage,
        zoom,
        setZoom,
        undo,
        redo,
        historyIndex,
        history,
        generatedImage,
        clearSelection,
    } = useCanvasStore();

    const router = useRouter();
    const [brochureModalOpen, setBrochureModalOpen] = useState(false);
    const [complianceModalOpen, setComplianceModalOpen] = useState(false);

    const canUndo = historyIndex > 0;
    const canRedo = historyIndex < history.length - 1;

    const handleExport = async (scale: number = 2, usingOriginal: boolean = false) => {
        if (!canvasRef?.current) return;

        if (usingOriginal && generatedImage) {
            const link = document.createElement('a');
            link.download = `staging-original-${Date.now()}.png`;
            link.href = generatedImage;
            link.click();
            toast.success('Original AI output downloaded!');
            return;
        }

        clearSelection();
        await new Promise(resolve => setTimeout(resolve, 100));
        const toastId = toast.loading('Exporting canvas...');

        try {
            const canvas = await html2canvas(canvasRef.current, {
                useCORS: true,
                allowTaint: true,
                backgroundColor: null,
                scale: scale,
            });

            const link = document.createElement('a');
            link.download = `staging-${scale > 2 ? 'hq' : 'preview'}-${Date.now()}.png`;
            link.href = canvas.toDataURL('image/png');
            link.click();
            toast.success('Canvas exported successfully!', { id: toastId });
        } catch (error) {
            console.error('Export failed:', error);
            toast.error('Failed to export canvas', { id: toastId });
        }
    };

    const currentRoom = ROOM_OPTIONS.find(r => r.value === roomType);
    const currentStyle = DESIGN_STYLES.find(s => s.value === style);

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

    return (
        <div className="flex h-full items-center justify-between border-b border-white/5 bg-[#020617] px-8 py-2 relative z-50">
            <input
                ref={fileInputRef}
                type="file"
                accept="image/*"
                className="hidden"
                onChange={handleFileChange}
            />

            {/* Left Section: Context & Project */}
            <div className="flex items-center gap-8">
                <button
                    onClick={() => router.push('/')}
                    className="flex h-11 w-11 items-center justify-center rounded-2xl bg-[#0f172a] border border-white/10 hover:border-purple-500/50 hover:bg-purple-600/10 text-slate-400 hover:text-purple-400 transition-all group"
                >
                    <Home className="h-5 w-5 group-hover:scale-110 transition-transform" />
                </button>

                <div className="flex flex-col">
                    <div className="flex items-center gap-2">
                        <div className="w-1.5 h-1.5 rounded-full bg-emerald-500 animate-pulse shadow-[0_0_8px_rgba(16,185,129,0.8)]" />
                        <span className="text-[9px] font-black text-slate-500 uppercase tracking-[0.2em] leading-none">Studio Session</span>
                    </div>
                    <div className="flex items-center gap-2 mt-1.5">
                        <h1 className="text-sm font-black text-white leading-none tracking-tight">Untitled Composition</h1>
                        <button className="p-1 rounded-md text-slate-600 hover:text-white transition-colors">
                            <Settings2 className="h-3 w-3" />
                        </button>
                    </div>
                </div>
            </div>

            {/* Center Section: Stage Configuration Information */}
            <div className="flex items-center bg-black/40 backdrop-blur-xl border border-white/10 rounded-3xl p-1.5 shadow-2xl">
                {/* Space Profile */}
                <div className="flex items-center px-4 py-1.5 gap-3 hover:bg-white/5 rounded-2xl transition-all group cursor-default">
                    <div className="w-9 h-9 rounded-xl bg-indigo-500/10 flex items-center justify-center border border-indigo-500/20 shadow-inner">
                        {currentRoom && <currentRoom.icon className="h-4.5 w-4.5 text-indigo-400" />}
                    </div>
                    <div className="flex flex-col min-w-[100px]">
                        <span className="text-[8px] font-black text-slate-600 uppercase tracking-widest leading-none mb-1 group-hover:text-indigo-500 transition-colors">Target Space</span>
                        <span className="text-xs font-black text-white leading-none">{currentRoom?.label || 'Calibrating...'}</span>
                    </div>
                </div>

                <div className="w-px h-8 bg-white/5 mx-1" />

                {/* Aesthetic Profile */}
                <div className="flex items-center px-4 py-1.5 gap-3 hover:bg-white/5 rounded-2xl transition-all group cursor-default">
                    <div className="w-9 h-9 rounded-xl bg-purple-500/10 flex items-center justify-center border border-purple-500/20 overflow-hidden relative shadow-inner">
                        {currentStyle ? (
                            <NextImage
                                src={currentStyle.image}
                                alt={currentStyle.label}
                                fill
                                className="object-cover opacity-60 group-hover:scale-110 transition-transform duration-700"
                            />
                        ) : (
                            <Sparkles className="h-4.5 w-4.5 text-purple-400 animate-pulse" />
                        )}
                    </div>
                    <div className="flex flex-col min-w-[120px]">
                        <span className="text-[8px] font-black text-slate-600 uppercase tracking-widest leading-none mb-1 group-hover:text-purple-500 transition-colors">Visual Style</span>
                        <span className="text-xs font-black text-white leading-none">{currentStyle?.label || 'Curating...'}</span>
                    </div>
                </div>
            </div>

            {/* Right Section: Tooling & Output */}
            <div className="flex items-center gap-4">
                {/* History & View Controls */}
                <div className="flex items-center bg-[#0f172a] rounded-2xl p-1 border border-white/5 mr-2">
                    <div className="flex items-center px-1">
                        <button
                            onClick={undo}
                            disabled={!canUndo}
                            className="rounded-xl p-2.5 text-slate-500 hover:bg-white/5 hover:text-white disabled:opacity-10 disabled:cursor-not-allowed transition-all"
                            title="Undo (⌘Z)"
                        >
                            <Undo2 className="h-4 w-4" />
                        </button>
                        <button
                            onClick={redo}
                            disabled={!canRedo}
                            className="rounded-xl p-2.5 text-slate-500 hover:bg-white/5 hover:text-white disabled:opacity-10 disabled:cursor-not-allowed transition-all"
                            title="Redo (⌘⇧Z)"
                        >
                            <Redo2 className="h-4 w-4" />
                        </button>
                    </div>

                    <div className="w-px h-5 bg-white/10 mx-1" />

                    <div className="flex items-center px-2">
                        <button
                            onClick={() => setZoom(zoom - 0.1)}
                            disabled={zoom <= 0.25}
                            className="rounded-lg p-2 text-slate-500 hover:bg-white/5 hover:text-white disabled:opacity-10 transition-all font-black text-lg leading-none"
                        >
                            -
                        </button>
                        <span className="min-w-[50px] text-center text-[10px] font-black text-slate-400 uppercase tracking-tighter tabular-nums">
                            {Math.round(zoom * 100)}%
                        </span>
                        <button
                            onClick={() => setZoom(zoom + 0.1)}
                            disabled={zoom >= 2}
                            className="rounded-lg p-2 text-slate-500 hover:bg-white/5 hover:text-white disabled:opacity-10 transition-all font-black text-lg leading-none"
                        >
                            +
                        </button>
                    </div>
                </div>

                <div className="flex items-center gap-2">
                    <button
                        onClick={handleUploadClick}
                        className="h-11 px-5 rounded-2xl bg-[#0f172a] border border-white/10 text-slate-200 font-bold text-[11px] uppercase tracking-widest flex items-center gap-2.5 hover:bg-slate-800 hover:border-white/20 transition-all active:scale-[0.98]"
                    >
                        <Upload className="h-4 w-4 text-purple-400" />
                        <span>Source Image</span>
                    </button>

                    <DropdownMenu>
                        <DropdownMenuTrigger asChild>
                            <button className="h-11 px-6 rounded-2xl bg-white text-black font-black text-[11px] uppercase tracking-[0.2em] flex items-center gap-2.5 hover:shadow-[0_0_30px_rgba(255,255,255,0.2)] transition-all active:scale-[0.98] relative overflow-hidden group">
                                <div className="absolute inset-0 bg-gradient-to-r from-purple-500/20 to-indigo-500/20 translate-y-full group-hover:translate-y-0 transition-transform duration-500" />
                                <Download className="h-4 w-4 relative z-10" />
                                <span className="relative z-10">Export</span>
                                <ChevronDown className="h-3 w-3 opacity-30 group-hover:rotate-180 transition-transform relative z-10" />
                            </button>
                        </DropdownMenuTrigger>
                        <DropdownMenuContent align="end" className="w-72 p-2 bg-[#0b0f1a] border border-white/10 text-white rounded-[24px] shadow-2xl backdrop-blur-3xl animate-in fade-in zoom-in-95 duration-200">
                            <DropdownMenuItem
                                onClick={() => handleExport(2)}
                                className="flex items-center gap-4 p-3.5 rounded-xl hover:bg-white/5 cursor-pointer transition-all outline-none"
                            >
                                <div className="w-11 h-11 rounded-xl bg-blue-500/10 flex items-center justify-center border border-blue-500/20 text-blue-400 shadow-inner">
                                    <ImageIcon className="h-5.5 w-5.5" />
                                </div>
                                <div className="flex flex-col">
                                    <span className="text-xs font-black uppercase tracking-wide">Web Ready</span>
                                    <span className="text-[10px] text-slate-500 font-bold uppercase mt-1 tracking-tighter">1080p • Fast Export</span>
                                </div>
                            </DropdownMenuItem>
                            <DropdownMenuItem
                                onClick={() => handleExport(4)}
                                className="flex items-center gap-4 p-3.5 rounded-xl hover:bg-white/5 cursor-pointer transition-all outline-none"
                            >
                                <div className="w-11 h-11 rounded-xl bg-purple-500/10 flex items-center justify-center border border-purple-500/20 text-purple-400 shadow-inner overflow-hidden relative">
                                    <Zap className="h-5.5 w-5.5 relative z-10" />
                                    <div className="absolute inset-0 bg-gradient-to-tr from-purple-500/20 to-transparent" />
                                </div>
                                <div className="flex flex-col">
                                    <span className="text-xs font-black uppercase tracking-wide">Studio Master</span>
                                    <span className="text-[10px] text-slate-500 font-bold uppercase mt-1 tracking-tighter">4K • Ultra Definition</span>
                                </div>
                            </DropdownMenuItem>

                            <div className="h-px bg-white/5 my-2 mx-1" />

                            <DropdownMenuItem
                                onClick={() => setBrochureModalOpen(true)}
                                className="flex items-center gap-4 p-3.5 rounded-xl hover:bg-white/5 cursor-pointer transition-all outline-none group/item"
                            >
                                <div className="w-11 h-11 rounded-xl bg-emerald-500/10 flex items-center justify-center border border-emerald-500/20 text-emerald-400 shadow-inner">
                                    <FileTextIcon className="h-5.5 w-5.5" />
                                </div>
                                <div className="flex flex-col flex-1">
                                    <div className="flex justify-between items-center">
                                        <span className="text-xs font-black uppercase tracking-wide">Brochure PDF</span>
                                        <span className="bg-emerald-500/20 text-emerald-400 text-[8px] px-1.5 py-0.5 rounded font-black tracking-widest">AI</span>
                                    </div>
                                    <span className="text-[10px] text-slate-500 font-bold uppercase mt-1 tracking-tighter">Automated Design Layout</span>
                                </div>
                            </DropdownMenuItem>
                        </DropdownMenuContent>
                    </DropdownMenu>

                    <button className="h-11 w-11 flex items-center justify-center rounded-2xl bg-[#0f172a] border border-white/5 text-slate-500 hover:text-white transition-all">
                        <Share2 className="h-4.5 w-4.5" />
                    </button>
                </div>
            </div>

            <BrochureModal open={brochureModalOpen} onOpenChange={setBrochureModalOpen} />
            <ComplianceModal open={complianceModalOpen} onOpenChange={setComplianceModalOpen} />
        </div>
    );
}
