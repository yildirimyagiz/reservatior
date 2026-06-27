'use client';

import { useRef, useState } from 'react';
import { 
    Upload, 
    Plus, 
    X, 
    Layers, 
    Eraser, 
    Wand2, 
    Armchair, 
    Droplets, 
    ScanLine 
} from 'lucide-react';
import { useCanvasStore, type CanvasTool } from '@/lib/store/canvas-store';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { useStagingGeneration } from '@/hooks/use-staging-generation';

interface UploadedImage {
    id: string;
    name: string;
    src: string;
}

const TOOLS = [
    {
        id: 'material-overlay',
        label: 'Material',
        icon: Layers,
        example: {
            label: 'Empty Room',
            src: 'https://images.unsplash.com/photo-1513584685908-95c9e2d0197c?w=800&q=80'
        }
    },
    {
        id: 'enhance-quality',
        label: 'Enhance',
        icon: ScanLine,
        example: {
            label: 'Low Quality',
            src: 'https://images.unsplash.com/photo-1502005097973-6a7082348e28?w=800&q=80'
        }
    },
    {
        id: 'room-declutter',
        label: 'Declutter',
        icon: Eraser,
        example: {
            label: 'Cluttered Room',
            src: 'https://images.unsplash.com/photo-1519710889408-a67e1c7e0452?w=800&q=80'
        }
    },
    {
        id: 'furniture-eraser',
        label: 'Eraser',
        icon: Wand2,
        example: {
            label: 'Furnished Room',
            src: 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=800&q=80'
        }
    },
    {
        id: 'add-furniture',
        label: 'Furniture',
        icon: Armchair,
        example: {
            label: 'Empty Space',
            src: 'https://images.unsplash.com/photo-1595428774223-ef52624120d2?w=800&q=80'
        }
    },
    {
        id: 'add-water',
        label: 'Water',
        icon: Droplets,
        example: {
            label: 'Empty Pool',
            src: 'https://images.unsplash.com/photo-1576013551627-0cc20b96c2a7?w=800&q=80'
        }
    }
];

export function UploadsPanel() {
    const fileInputRef = useRef<HTMLInputElement>(null);
    const toolFileInputRef = useRef<HTMLInputElement>(null);
    const [uploads, setUploads] = useState<UploadedImage[]>([]);
    const { addItem, roomImage, activeTool, setActiveTool, setRoomImage } = useCanvasStore();
    const { generateStaging } = useStagingGeneration();

    // Reset active tool when unmounting? No, keep state.
    
    const handleValueChange = (val: string) => {
        if (val === 'my-uploads') {
            setActiveTool(null);
        } else {
            setActiveTool(val as CanvasTool);
        }
    };

    const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
        const files = Array.from(e.target.files || []);

        files.forEach((file) => {
            if (!file.type.startsWith('image/')) return;

            const reader = new FileReader();
            reader.onload = (event) => {
                const newUpload: UploadedImage = {
                    id: `upload-${Date.now()}-${Math.random().toString(36).substr(2, 9)}`,
                    name: file.name,
                    src: event.target?.result as string,
                };
                setUploads((prev) => [...prev, newUpload]);
            };
            reader.readAsDataURL(file);
        });

        if (fileInputRef.current) fileInputRef.current.value = '';
    };
    
    const handleToolFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
        const files = Array.from(e.target.files || []);
        if (files.length === 0) return;
        const file = files[0];
        
        const reader = new FileReader();
        reader.onload = (event) => {
            const src = event.target?.result as string;
            
            // If no room image set yet, set it now so generation works
            if (!roomImage) {
                setRoomImage(src, file.name);
            }
            
            // Add to canvas centered
            addItem({
                type: 'image',
                name: file.name,
                src: src,
                x: 100,
                y: 100,
                width: 400,
                height: 300,
                rotation: 0,
                scaleX: 1,
                scaleY: 1,
                opacity: 1,
                locked: false,
                visible: true,
            });
        };
        reader.readAsDataURL(file);
        if (toolFileInputRef.current) toolFileInputRef.current.value = '';
    };

    const handleRemoveUpload = (id: string) => {
        setUploads((prev) => prev.filter((u) => u.id !== id));
    };

    const handleDragStart = (e: React.DragEvent, upload: UploadedImage) => {
        const data = {
            title: upload.name,
            imageUrl: upload.src,
        };
        e.dataTransfer.setData('application/furniture', JSON.stringify(data));
        e.dataTransfer.effectAllowed = 'copy';
    };

    const handleAddToCanvas = (upload: UploadedImage) => {
        if (!roomImage) return;

        addItem({
            type: 'image',
            name: upload.name,
            src: upload.src,
            x: 100,
            y: 100,
            width: 150,
            height: 150,
            rotation: 0,
            scaleX: 1,
            scaleY: 1,
            opacity: 1,
            locked: false,
            visible: true,
        });
    };
    
    // Check if we have an active tool that matches our list, otherwise default to my-uploads
    const currentTab = activeTool && TOOLS.some(t => t.id === activeTool) ? activeTool : 'my-uploads';

    return (
        <div className="flex h-full flex-col">
            <Tabs value={currentTab} onValueChange={handleValueChange} className="flex-1 flex flex-col">
                <div className="px-3 pt-3 pb-2 border-b border-slate-800">
                    <TabsList className="bg-transparent p-0 w-full flex justify-start gap-2 overflow-x-auto scrollbar-none h-auto">
                        <TabsTrigger 
                            value="my-uploads"
                            className="data-[state=active]:bg-purple-600 data-[state=active]:text-white text-xs px-3 py-1.5 h-8 border border-transparent data-[state=active]:border-transparent border-slate-700 text-slate-400 rounded-full"
                        >
                            Uploads
                        </TabsTrigger>
                        {TOOLS.map((tool) => (
                            <TabsTrigger 
                                key={tool.id}
                                value={tool.id}
                                className="data-[state=active]:bg-purple-600 data-[state=active]:text-white text-xs px-3 py-1.5 h-8 border border-transparent data-[state=active]:border-transparent border-slate-700 text-slate-400 rounded-full flex items-center gap-2"
                            >
                                <tool.icon className="h-3 w-3" />
                                <span className="hidden sm:inline-block md:hidden lg:inline-block">{tool.label}</span>
                            </TabsTrigger>
                        ))}
                    </TabsList>
                </div>
                
                {/* My Uploads Content */}
                <TabsContent value="my-uploads" className="flex-1 flex flex-col m-0 data-[state=inactive]:hidden">
                     {/* Upload Button */}
                    <div className="p-3 border-b border-slate-800">
                        <input
                            ref={fileInputRef}
                            type="file"
                            accept="image/*"
                            multiple
                            onChange={handleFileChange}
                            className="hidden"
                        />
                        <button
                            onClick={() => fileInputRef.current?.click()}
                            className="flex w-full items-center justify-center gap-2 rounded-lg border-2 border-dashed border-slate-600 bg-slate-800/50 py-4 text-sm text-slate-400 transition-colors hover:border-purple-500 hover:bg-slate-800 hover:text-purple-400"
                        >
                            <Plus className="h-5 w-5" />
                            Upload Furniture Img
                        </button>
                    </div>
                    
                    <div className="px-3 py-2">
                        <h3 className="text-xs font-bold text-slate-500 uppercase tracking-wider mb-2">My Uploads</h3>
                    </div>

                    <div className="flex-1 overflow-y-auto px-3 pb-3">
                        {uploads.length === 0 ? (
                            <div className="flex flex-col items-center justify-center py-8 text-center text-slate-400">
                                <Upload className="mb-2 h-10 w-10 text-slate-600" />
                                <p className="text-sm">No uploads yet</p>
                                <p className="mt-1 text-xs text-slate-500">
                                    Upload PNG images with transparent backgrounds
                                </p>
                            </div>
                        ) : (
                            <div className="grid grid-cols-2 gap-2">
                                {uploads.map((upload) => (
                                    <div
                                        key={upload.id}
                                        draggable
                                        onDragStart={(e) => handleDragStart(e, upload)}
                                        onClick={() => handleAddToCanvas(upload)}
                                        className="group relative cursor-grab overflow-hidden rounded-lg border border-slate-700 bg-slate-800 transition-all hover:border-purple-500 active:cursor-grabbing"
                                    >
                                        <div className="aspect-square bg-[url('/checkerboard.svg')] bg-repeat">
                                            {/* eslint-disable-next-line @next/next/no-img-element */}
                                            <img
                                                src={upload.src}
                                                alt={upload.name}
                                                className="h-full w-full object-contain"
                                                draggable={false}
                                            />
                                        </div>
                                        <button
                                            onClick={(e) => {
                                                e.stopPropagation();
                                                handleRemoveUpload(upload.id);
                                            }}
                                            className="absolute right-1 top-1 rounded-full bg-red-500 p-1 text-white opacity-0 transition-opacity group-hover:opacity-100"
                                        >
                                            <X className="h-3 w-3" />
                                        </button>
                                        <div className="p-2">
                                            <p className="truncate text-xs text-slate-400">{upload.name}</p>
                                        </div>
                                    </div>
                                ))}
                            </div>
                        )}
                    </div>
                </TabsContent>
                
                {/* Tool Contents */}
                {TOOLS.map((tool) => (
                    <TabsContent key={tool.id} value={tool.id} className="flex-1 flex flex-col m-0 p-3 data-[state=inactive]:hidden">
                        <div className="space-y-4">
                            <input
                                ref={toolFileInputRef}
                                type="file"
                                accept="image/*"
                                onChange={handleToolFileChange}
                                className="hidden"
                            />
                             
                             <div className="flex items-center gap-2 text-slate-400 mb-2">
                                <tool.icon className="h-4 w-4" />
                                <span className="text-sm font-medium">{tool.label} Workspace</span>
                             </div>
                             
                             <button 
                                onClick={() => toolFileInputRef.current?.click()}
                                className="w-full h-32 border-2 border-dashed border-slate-700 rounded-xl flex flex-col items-center justify-center gap-3 text-slate-500 hover:text-purple-400 hover:border-purple-500/50 hover:bg-slate-800 transition-all group"
                            >
                                <div className="p-3 bg-slate-800 rounded-full group-hover:bg-purple-500/10 transition-colors">
                                    <Upload className="h-6 w-6" />
                                </div>
                                <span className="text-sm font-medium">Upload {tool.label} Image</span>
                            </button>
                            
                            <div>
                                <h4 className="text-xs font-bold text-slate-500 uppercase tracking-wider mb-3">Try with Example</h4>
                                <button 
                                    onClick={() => {
                                        addItem({
                                            type: 'image',
                                            name: tool.example.label,
                                            src: tool.example.src,
                                            x: 100, y: 100, width: 400, height: 300,
                                            rotation: 0, scaleX: 1, scaleY: 1, opacity: 1, locked: false, visible: true
                                        });
                                        if (!roomImage) setRoomImage(tool.example.src, tool.example.label);
                                    }}
                                    className="group relative w-full aspect-video rounded-lg overflow-hidden border border-slate-700 hover:border-purple-500 transition-all"
                                >
                                    {/* eslint-disable-next-line @next/next/no-img-element */}
                                    <img 
                                        src={tool.example.src} 
                                        alt={tool.example.label} 
                                        className="w-full h-full object-cover transition-transform group-hover:scale-105"
                                    />
                                    <div className="absolute inset-0 bg-black/40 flex items-center justify-center opacity-0 group-hover:opacity-100 transition-opacity">
                                        <span className="text-sm font-bold text-white shadow-sm">Load Example</span>
                                    </div>
                                    <div className="absolute bottom-2 left-2 text-xs font-medium text-white/90 drop-shadow-md">
                                        {tool.example.label}
                                    </div>
                                </button>
                            </div>
                            
                            <button 
                                onClick={() => generateStaging()}
                                className="w-full py-3 bg-purple-600 hover:bg-purple-500 text-white text-sm font-bold rounded-lg shadow-lg shadow-purple-900/20 transition-all mt-4"
                            >
                                Generate Result
                            </button>
                        </div>
                    </TabsContent>
                ))}
            </Tabs>
        </div>
    );
}
