'use client';

import { useState, useEffect } from "react";
import {
    Dialog,
    DialogContent,
    DialogHeader,
    DialogTitle,
    DialogDescription,
} from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";  // Added import
import { useCanvasStore } from "@/lib/store/canvas-store";
import { brochureService, BrochureTemplate, BrochureInput } from "@/services/brochure-service";
import { Loader2, FileText, CheckCircle2 } from "lucide-react";
import { cn } from "@/lib/utils";
import { Select } from "@/components/ui/select";
import { toast } from "sonner";
import Image from "next/image";

interface BrochureModalProps {
    open: boolean;
    onOpenChange: (open: boolean) => void;
}

interface Property {
    id: string;
    title: string;
    address: string;
}

export function BrochureModal({ open, onOpenChange }: BrochureModalProps) {
    const { roomImage, generatedImage } = useCanvasStore();
    
    // States
    const [templates, setTemplates] = useState<BrochureTemplate[]>([]);
    const [selectedTemplateId, setSelectedTemplateId] = useState("");
    
    // Brochure details
    const [properties, setProperties] = useState<Property[]>([]);
    const [selectedPropertyId, setSelectedPropertyId] = useState("");
    const [useAdHoc, setUseAdHoc] = useState(false);
    
    // Ad hoc fields
    const [title, setTitle] = useState("Modern Living Room");
    const [address, setAddress] = useState("");
    const [price, setPrice] = useState("");
    const [description, setDescription] = useState("");
    const [bedrooms, setBedrooms] = useState("");
    const [bathrooms, setBathrooms] = useState("");
    const [sqft, setSqft] = useState("");
    
    const [loading, setLoading] = useState(false);

    useEffect(() => {
        if (open) {
            setup();
        }
    }, [open]);

    const setup = async () => {
        try {
            const [tpls, props] = await Promise.all([
                brochureService.getTemplates(),
                fetch("/api/v1/properties").then(res => res.json().catch(() => []))
            ]);
            setTemplates(tpls);
            setProperties(props);
            
            // If no properties, default to ad-hoc mode
            if (!props || props.length === 0) {
                setUseAdHoc(true);
            }
        } catch (e) {
            console.error(e);
            toast.error("Failed to load templates");
        }
    };

    const handleGenerate = async () => {
        if (!selectedTemplateId) {
            toast.error("Please select a template");
            return;
        }

        const imageToUse = generatedImage || roomImage;
        if (!imageToUse) {
            toast.error("No image available on canvas");
            return;
        }

        setLoading(true);
        try {
            const payload: BrochureInput = {
                templateId: selectedTemplateId,
                customPhotos: [imageToUse], // Send current canvas image as photo
            };

            if (useAdHoc || !selectedPropertyId) {
                payload.title = title;
                payload.address = address;
                payload.price = parseFloat(price) || 0;
                payload.description = description;
                payload.bedrooms = parseInt(bedrooms) || 0;
                payload.bathrooms = parseFloat(bathrooms) || 0;
                payload.sqft = parseFloat(sqft) || 0;
            } else {
                payload.propertyId = selectedPropertyId;
            }

            const pdfBlob = await brochureService.generate(payload);
            
            // Download
            const url = window.URL.createObjectURL(pdfBlob);
            const link = document.createElement('a');
            link.href = url;
            link.setAttribute('download', `brochure_${Date.now()}.pdf`);
            document.body.appendChild(link);
            link.click();
            link.remove();
            
            toast.success("Brochure downloaded!");
            onOpenChange(false);
        } catch (error) {
            console.error("Brochure Generation Error", error);
            toast.error("Failed to generate brochure");
        } finally {
            setLoading(false);
        }
    };

    return (
        <Dialog open={open} onOpenChange={onOpenChange}>
            <DialogContent className="max-w-4xl bg-slate-900 border-slate-800 text-white max-h-[90vh] overflow-y-auto">
                <DialogHeader>
                    <DialogTitle>Create Marketing Brochure</DialogTitle>
                    <DialogDescription className="text-slate-400">
                        Convert your staged design into a professional PDF brochure.
                    </DialogDescription>
                </DialogHeader>

                <div className="grid grid-cols-1 lg:grid-cols-2 gap-8 mt-4">
                    {/* Left: Fields */}
                    <div className="space-y-6">
                         <div className="aspect-video bg-slate-950 rounded-lg border border-slate-800 relative overflow-hidden mb-4 ">
                             {generatedImage ? (
                                 <Image src={generatedImage} alt="Staged" fill className="object-cover" />
                             ) : roomImage ? (
                                 <Image src={roomImage} alt="Room" fill className="object-cover" />
                             ) : (
                                 <div className="flex items-center justify-center h-full text-slate-500">No Image</div>
                             )}
                             <div className="absolute top-2 right-2 bg-black/60 text-white text-xs px-2 py-1 rounded">
                                 {generatedImage ? "Staged Result" : "Original Upload"}
                             </div>
                         </div>

                         <div className="space-y-4">
                             {properties.length > 0 && (
                                <div className="space-y-2">
                                    <Label>Select Property (Optional)</Label>
                                    <Select
                                        value={selectedPropertyId}
                                        onChange={(v) => {
                                            setSelectedPropertyId(v);
                                            setUseAdHoc(false);
                                        }}
                                        options={properties.map(p => ({ value: p.id, label: p.title }))}
                                        placeholder="Choose existing property..."
                                        className="w-full"
                                    />
                                </div>
                             )}
                             
                             {(!selectedPropertyId || useAdHoc) && (
                                 <div className="space-y-4 p-5 bg-slate-950/50 rounded-lg border border-slate-800">
                                     <h3 className="text-sm font-semibold text-white/90 mb-2 border-b border-slate-800 pb-2">Property Details</h3>
                                     
                                     <div className="grid grid-cols-1 gap-3">
                                         <div className="space-y-1">
                                             <Label className="text-xs text-slate-400">Title</Label>
                                             <Input 
                                                value={title} 
                                                onChange={e => setTitle(e.target.value)} 
                                                placeholder="Ex: Modern Downtown Condo"
                                                className="bg-slate-900 border-slate-700"
                                             />
                                         </div>
                                         <div className="space-y-1">
                                             <Label className="text-xs text-slate-400">Address</Label>
                                             <Input 
                                                value={address} 
                                                onChange={e => setAddress(e.target.value)} 
                                                placeholder="Ex: 123 Main St, New York, NY"
                                                className="bg-slate-900 border-slate-700"
                                             />
                                         </div>
                                     </div>

                                     <div className="grid grid-cols-2 gap-3">
                                         <div className="space-y-1">
                                             <Label className="text-xs text-slate-400">Price</Label>
                                             <div className="relative">
                                                <span className="absolute left-3 top-2.5 text-slate-500 text-sm">$</span>
                                                <Input 
                                                    type="number"
                                                    value={price} 
                                                    onChange={e => setPrice(e.target.value)} 
                                                    placeholder="500000"
                                                    className="bg-slate-900 border-slate-700 pl-6"
                                                />
                                             </div>
                                         </div>
                                         <div className="space-y-1">
                                             <Label className="text-xs text-slate-400">Sqft</Label>
                                              <Input 
                                                type="number"
                                                value={sqft} 
                                                onChange={e => setSqft(e.target.value)} 
                                                placeholder="1200"
                                                className="bg-slate-900 border-slate-700"
                                             />
                                         </div>
                                     </div>

                                     <div className="grid grid-cols-2 gap-3">
                                         <div className="space-y-1">
                                             <Label className="text-xs text-slate-400">Bedrooms</Label>
                                             <Input 
                                                type="number"
                                                value={bedrooms} 
                                                onChange={e => setBedrooms(e.target.value)} 
                                                placeholder="2"
                                                className="bg-slate-900 border-slate-700"
                                             />
                                         </div>
                                         <div className="space-y-1">
                                             <Label className="text-xs text-slate-400">Bathrooms</Label>
                                             <Input 
                                                type="number"
                                                value={bathrooms} 
                                                onChange={e => setBathrooms(e.target.value)} 
                                                placeholder="2"
                                                className="bg-slate-900 border-slate-700"
                                             />
                                         </div>
                                     </div>

                                     <div className="space-y-1">
                                         <Label className="text-xs text-slate-400">Description</Label>
                                         <Textarea 
                                            value={description} 
                                            onChange={e => setDescription(e.target.value)} 
                                            placeholder="Describe the property highlights..."
                                            className="bg-slate-900 border-slate-700 min-h-[80px]"
                                         />
                                     </div>
                                 </div>
                             )}
                         </div>
                    </div>

                    {/* Right: Template Selection */}
                    <div className="space-y-4">
                        <Label>Select Template</Label>
                        <div className="grid grid-cols-2 gap-3 max-h-[400px] overflow-y-auto pr-2">
                            {templates.map(tpl => (
                                <div 
                                    key={tpl.id}
                                    onClick={() => setSelectedTemplateId(tpl.id)}
                                    className={cn(
                                        "cursor-pointer relative rounded-lg border-2 transition-all p-2 bg-slate-950",
                                        selectedTemplateId === tpl.id 
                                            ? "border-primary ring-1 ring-primary/50" 
                                            : "border-transparent border-slate-800 hover:border-slate-700"
                                    )}
                                >
                                    <div className="aspect-[3/4] bg-slate-900 rounded mb-2 overflow-hidden relative">
                                         {tpl.thumbnailUrl ? (
                                             <Image src={tpl.thumbnailUrl} alt={tpl.name} fill className="object-cover" />
                                         ) : (
                                             <div className="flex items-center justify-center h-full">
                                                <FileText className="w-8 h-8 text-slate-700" />
                                             </div>
                                         )}
                                          {selectedTemplateId === tpl.id && (
                                            <div className="absolute top-1 right-1 bg-primary text-white p-0.5 rounded-full shadow-lg">
                                                <CheckCircle2 className="w-3 h-3" />
                                            </div>
                                         )}
                                    </div>
                                    <div className="text-xs font-medium truncate">{tpl.name}</div>
                                </div>
                            ))}
                        </div>

                        <div className="pt-4 border-t border-slate-800">
                             <Button 
                                onClick={handleGenerate} 
                                className="w-full"
                                disabled={loading || !selectedTemplateId || ((!selectedPropertyId) && (!title || !address))}
                            >
                                {loading && <Loader2 className="mr-2 h-4 w-4 animate-spin" />}
                                Generate PDF
                             </Button>
                        </div>
                    </div>
                </div>

            </DialogContent>
        </Dialog>
    );
}
