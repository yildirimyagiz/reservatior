'use client';

import { useCanvasStore } from '@/lib/store/canvas-store';
import { Sparkles, Loader2, ImageIcon, RefreshCw, ShoppingBag, ExternalLink } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { useStagingGeneration } from '@/hooks/use-staging-generation';
import { ComfyUISettings } from './comfyui-settings';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { StyleSelector } from './style-selector';
import { RoomSelector } from './room-selector';
import { useSearchParams } from 'next/navigation';
import { useEffect, useState } from 'react';
import { DesignStyle, RoomType } from '@/lib/store/canvas-store';

const PRESET_COLORS = [
    '#F5F5F5', '#2C3E50', '#E67E22', '#8E44AD',
    '#16A085', '#2980B9', '#C0392B', '#F39C12',
];

export function SettingsPanel() {
    const searchParams = useSearchParams();
    const {
        colorPalette,
        roomImage,
        isGenerating,
        generatedImage,
        items,
        setRoomType,
        setStyle,
        setColorPalette,
    } = useCanvasStore();

    // Sync URL params
    useEffect(() => {
        const styleParam = searchParams.get('style');
        const roomParam = searchParams.get('room');

        if (styleParam) {
            setStyle(styleParam as DesignStyle);
        }
        if (roomParam) {
            setRoomType(roomParam as RoomType);
        }
    }, [searchParams, setStyle, setRoomType]);

    const handleColorToggle = (color: string) => {
        if (colorPalette.includes(color)) {
            setColorPalette(colorPalette.filter((c) => c !== color));
        } else if (colorPalette.length < 5) {
            setColorPalette([...colorPalette, color]);
        }
    };

    // Generation Mode State
    const [generationMode, setGenerationMode] = useState<'speed' | 'quality'>('speed');

    const { generateStaging, generateSimpleStaging } = useStagingGeneration();

    const handleGenerate = async () => {
        if (generationMode === 'speed') {
            await generateSimpleStaging();
        } else {
            await generateStaging();
        }
    };

    const shopItems = items.filter(i => i.shopifyProduct) || [];

    return (
        <div className="flex h-full w-80 flex-col border-l border-slate-800 bg-slate-950/50 backdrop-blur-xl">
            {/* Header */}
            <div className="border-b border-slate-800 bg-slate-900/50 px-4 py-4">
                <h3 className="font-semibold text-white">Design Studio</h3>
            </div>

            <Tabs defaultValue="design" className="flex-1 flex flex-col overflow-hidden">
                <div className="px-4 pt-4">
                    <TabsList className="w-full grid grid-cols-4">
                        <TabsTrigger value="design">Design</TabsTrigger>
                        <TabsTrigger value="edit">Edit</TabsTrigger>
                        <TabsTrigger value="history">History</TabsTrigger>
                        <TabsTrigger value="shop">Shop</TabsTrigger>
                    </TabsList>
                </div>

                <div className="flex-1 overflow-y-auto p-4 space-y-6 scrollbar-thin scrollbar-thumb-slate-800">

                    <TabsContent value="design" className="space-y-8 mt-0">
                        {/* Generation Mode Selector */}
                        <div className="bg-slate-900/50 p-3 rounded-lg border border-slate-800">
                            <label className="text-xs font-semibold text-slate-400 mb-2 block uppercase tracking-wider">
                                Generation Mode
                            </label>
                            <div className="grid grid-cols-2 gap-2">
                                <button
                                    onClick={() => setGenerationMode('speed')}
                                    className={`flex flex-col items-center justify-center p-2 rounded-lg border transition-all ${generationMode === 'speed'
                                        ? 'bg-purple-500/10 border-purple-500 text-purple-400'
                                        : 'bg-slate-800 border-slate-700 text-slate-400 hover:bg-slate-700'
                                        }`}
                                >
                                    <span className="font-medium text-sm">Speed (CPU)</span>
                                    <span className="text-[10px] opacity-70">Structure Preserved</span>
                                </button>
                                <button
                                    onClick={() => setGenerationMode('quality')}
                                    className={`flex flex-col items-center justify-center p-2 rounded-lg border transition-all ${generationMode === 'quality'
                                        ? 'bg-purple-500/10 border-purple-500 text-purple-400'
                                        : 'bg-slate-800 border-slate-700 text-slate-400 hover:bg-slate-700'
                                        }`}
                                >
                                    <span className="font-medium text-sm">Quality (GPU)</span>
                                    <span className="text-[10px] opacity-70">High Detail</span>
                                </button>
                            </div>
                            <p className="mt-2 text-[10px] text-slate-500 leading-tight">
                                {generationMode === 'speed'
                                    ? "Recommended for MLS compliance. Preserves room structure strictly."
                                    : "Best for empty rooms or total redesigns. Uses cloud GPU."}
                            </p>
                        </div>

                        {/* Visual Room Selector */}
                        <RoomSelector />

                        {/* Visual Style Selector (Rolling Images) */}
                        <StyleSelector />

                        {/* Generate Button (Main Action) */}
                        <div className="pt-4">
                            <Button
                                onClick={handleGenerate}
                                disabled={!roomImage || isGenerating}
                                className={`w-full gap-2 shadow-lg ${generationMode === 'speed'
                                    ? 'bg-gradient-to-r from-blue-600 to-cyan-600 hover:from-blue-500 hover:to-cyan-500 shadow-blue-900/20'
                                    : 'bg-gradient-to-r from-purple-600 to-pink-600 hover:from-purple-500 hover:to-pink-500 shadow-purple-900/20'
                                    }`}
                                size="lg"
                            >
                                {isGenerating ? (
                                    <>
                                        <Loader2 className="h-5 w-5 animate-spin" />
                                        {generationMode === 'speed' ? 'Staging...' : 'Generating...'}
                                    </>
                                ) : (
                                    <>
                                        <Sparkles className="h-5 w-5" />
                                        {generationMode === 'speed' ? 'Stage Room' : 'Generate'}
                                    </>
                                )}
                            </Button>
                            {!roomImage && (
                                <p className="mt-2 text-center text-xs text-slate-500">
                                    Upload a room photo first
                                </p>
                            )}
                        </div>
                    </TabsContent>

                    <TabsContent value="edit" className="space-y-6 mt-0">
                        {/* Color Palette */}
                        <div>
                            <label className="mb-2 block text-sm font-medium text-slate-300">
                                Color Palette
                            </label>
                            <div className="flex flex-wrap gap-2">
                                {PRESET_COLORS.map((color) => (
                                    <button
                                        key={color}
                                        onClick={() => handleColorToggle(color)}
                                        className={`h-8 w-8 rounded-full border-2 transition-transform ${colorPalette.includes(color)
                                            ? 'border-purple-500 scale-110'
                                            : 'border-slate-600 hover:scale-105'
                                            }`}
                                        style={{ backgroundColor: color }}
                                    />
                                ))}
                            </div>
                        </div>

                        {/* ComfyUI Settings */}
                        <ComfyUISettings />
                    </TabsContent>

                    <TabsContent value="history" className="space-y-4 mt-0">
                        {/* Generated Preview */}
                        {generatedImage ? (
                            <div className="animate-in fade-in zoom-in duration-300">
                                <label className="mb-2 flex items-center gap-2 text-sm font-medium text-slate-300">
                                    <ImageIcon className="h-4 w-4" />
                                    Latest Result
                                </label>
                                <div className="overflow-hidden rounded-lg border border-slate-700 shadow-xl">
                                    {/* eslint-disable-next-line @next/next/no-img-element */}
                                    <img
                                        src={generatedImage}
                                        alt="Generated staging"
                                        className="w-full object-cover"
                                    />
                                </div>
                                <Button
                                    onClick={handleGenerate}
                                    variant="secondary"
                                    size="sm"
                                    className="mt-3 w-full gap-2"
                                >
                                    <RefreshCw className="h-4 w-4" />
                                    Regenerate
                                </Button>
                            </div>
                        ) : (
                            <div className="flex flex-col items-center justify-center py-10 text-slate-500 border border-dashed border-slate-800 rounded-lg">
                                <ImageIcon className="h-8 w-8 mb-2 opacity-50" />
                                <span className="text-sm">No generations yet</span>
                            </div>
                        )}
                    </TabsContent>

                    <TabsContent value="shop" className="space-y-4 mt-0">
                        {shopItems.length > 0 ? (
                            <div className="space-y-4">
                                <p className="text-sm text-slate-400">
                                    Products detected in your design:
                                </p>
                                {shopItems.map((item) => (
                                    <div key={item.id} className="rounded-lg border border-slate-700 bg-slate-800/50 p-3 flex gap-3">
                                        {/* eslint-disable-next-line @next/next/no-img-element */}
                                        <img
                                            src={item.src}
                                            alt={item.name}
                                            className="h-16 w-16 rounded object-cover bg-slate-900"
                                        />
                                        <div className="flex-1 min-w-0">
                                            <p className="font-medium text-white truncate">{item.name}</p>
                                            <p className="text-xs text-slate-400 mb-2 truncate">{item.shopifyProduct?.vendor || 'Premium Furniture'}</p>
                                            <div className="flex gap-2">
                                                <Button size="sm" variant="outline" className="h-7 text-xs flex-1">
                                                    Shopify
                                                </Button>
                                                <Button size="sm" className="h-7 text-xs flex-1 bg-[#FF9900] hover:bg-[#FF9900]/90 text-black border-none">
                                                    Amazon
                                                </Button>
                                            </div>
                                        </div>
                                    </div>
                                ))}
                            </div>
                        ) : (
                            <div className="flex flex-col items-center justify-center py-10 text-center">
                                <ShoppingBag className="h-10 w-10 text-purple-400 mb-4 opacity-50" />
                                <h4 className="font-medium text-white mb-2">Shop the Look</h4>
                                <p className="text-sm text-slate-400 mb-6">
                                    Generate a design to see purchasable furniture items matched to your style.
                                </p>

                                {generatedImage && (
                                    <div className="w-full p-4 rounded-xl bg-gradient-to-br from-slate-800 to-slate-900 border border-slate-700">
                                        <p className="text-xs text-slate-400 mb-3 text-left">Detected in this room:</p>
                                        <div className="space-y-3">
                                            <a href="#" className="flex items-center justify-between group">
                                                <div className="flex items-center gap-2">
                                                    <div className="h-8 w-8 rounded bg-slate-700"></div>
                                                    <span className="text-sm text-slate-200 group-hover:text-purple-400 transition-colors">Nordic Sofa</span>
                                                </div>
                                                <ExternalLink className="h-3 w-3 text-slate-500" />
                                            </a>
                                            <a href="#" className="flex items-center justify-between group">
                                                <div className="flex items-center gap-2">
                                                    <div className="h-8 w-8 rounded bg-slate-700"></div>
                                                    <span className="text-sm text-slate-200 group-hover:text-purple-400 transition-colors">Oak Coffee Table</span>
                                                </div>
                                                <ExternalLink className="h-3 w-3 text-slate-500" />
                                            </a>
                                        </div>
                                        <Button className="w-full mt-4 h-8 text-xs bg-white text-black hover:bg-slate-200">
                                            View on Amazon
                                        </Button>
                                    </div>
                                )}
                            </div>
                        )}
                    </TabsContent>
                </div>
            </Tabs>
        </div>
    );
}
