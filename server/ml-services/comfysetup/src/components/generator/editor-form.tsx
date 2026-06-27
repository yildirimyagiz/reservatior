'use client';

import { useState } from 'react';
import { useEditorStore } from '@/lib/store/editor-store';
import { Select } from '@/components/ui/select';
import { ToggleGroup } from '@/components/ui/toggle';
import { Button } from '@/components/ui/button';
import { Dropzone } from '@/components/upload/dropzone';
import { PromptOutput } from '@/components/generator/prompt-output';
import { GenerationResult } from '@/components/generator/generation-result';
import { FurnitureBrowser, FurnitureSelection } from '@/components/furniture';
import {
    generateStagingPrompt,
    generateRecolorPrompt,
    generateStyleTransferPrompt,
    generate3DPrompt,
} from '@/lib/prompt-engine';
import { Layers, Palette, Wand2, Box, Info, Sparkles, FileText, Loader2, ShoppingBag } from 'lucide-react';
import type { Dictionary } from '@/lib/i18n/config';
import type { RoomType, InteriorStyle, PromptMode } from '@/types';

interface EditorFormProps {
    dictionary: Dictionary;
}

const roomTypeOptions: { value: RoomType; label: string }[] = [
    { value: 'living-room', label: 'Living Room' },
    { value: 'bedroom', label: 'Bedroom' },
    { value: 'office', label: 'Home Office' },
    { value: 'dining-room', label: 'Dining Room' },
    { value: 'kitchen', label: 'Kitchen' },
    { value: 'bathroom', label: 'Bathroom' },
    { value: 'outdoor', label: 'Outdoor/Patio' },
];

const styleOptions: { value: InteriorStyle; label: string }[] = [
    { value: 'modern-minimalist', label: 'Modern Minimalist' },
    { value: 'scandinavian', label: 'Scandinavian' },
    { value: 'industrial', label: 'Industrial' },
    { value: 'mid-century-modern', label: 'Mid-Century Modern' },
    { value: 'bohemian', label: 'Bohemian' },
    { value: 'traditional', label: 'Traditional' },
    { value: 'coastal', label: 'Coastal' },
    { value: 'farmhouse', label: 'Farmhouse' },
    { value: 'contemporary', label: 'Contemporary' },
    { value: 'rustic', label: 'Rustic' },
];

const extrasOptions = [
    { key: 'plants', label: 'Indoor Plants' },
    { key: 'lighting', label: 'Decorative Lighting' },
    { key: 'wallArt', label: 'Wall Art' },
    { key: 'rugs', label: 'Area Rugs' },
    { key: 'cushions', label: 'Throw Pillows' },
    { key: 'curtains', label: 'Curtains/Drapes' },
];

export function EditorForm({ dictionary }: EditorFormProps) {
    const {
        roomImage,
        roomImageName,
        roomType,
        style,
        extras,
        computeMode,
        promptMode,
        selectedShopifyProducts,
        setRoomImage,
        setRoomType,
        setStyle,
        toggleExtra,
        setComputeMode,
        setPromptMode,
        setGeneratedPrompt,
        addShopifyProduct,
        removeShopifyProduct,
        clearShopifyProducts,
    } = useEditorStore();

    // Generation state
    const [isGenerating, setIsGenerating] = useState(false);
    const [generatedImage, setGeneratedImage] = useState<string | null>(null);
    const [generationProgress, setGenerationProgress] = useState<string>('');
    const [generationError, setGenerationError] = useState<string | null>(null);

    // Furniture browser modal state
    const [isFurnitureBrowserOpen, setIsFurnitureBrowserOpen] = useState(false);

    // Use translated labels from dictionary
    const translatedRoomTypes = roomTypeOptions.map((opt) => ({
        ...opt,
        label: dictionary.roomTypes[opt.value] || opt.label,
    }));

    const translatedStyles = styleOptions.map((opt) => ({
        ...opt,
        label: dictionary.styles[opt.value as keyof typeof dictionary.styles]?.name || opt.label,
    }));

    const translatedExtras = extrasOptions.map((opt) => ({
        ...opt,
        label: dictionary.extras[opt.key as keyof typeof dictionary.extras] || opt.label,
    }));

    const handleGeneratePrompt = () => {
        // Include selected Shopify product names in furniture list
        const furnitureNames = selectedShopifyProducts.map(p => p.title);

        let prompt;

        switch (promptMode) {
            case 'staging':
                prompt = generateStagingPrompt(roomType, style, furnitureNames, extras, computeMode);
                break;
            case 'recolor':
                prompt = generateRecolorPrompt(['#8B4513', '#F5F5DC'], computeMode);
                break;
            case 'style-transfer':
                prompt = generateStyleTransferPrompt(style, computeMode);
                break;
            case '3d-generation':
                prompt = generate3DPrompt('front', computeMode);
                break;
            default:
                prompt = generateStagingPrompt(roomType, style, furnitureNames, extras, computeMode);
        }

        setGeneratedPrompt(prompt);
    };

    const handleGenerateImage = async () => {
        if (!roomImage) {
            setGenerationError('Please upload an image first');
            return;
        }

        setIsGenerating(true);
        setGenerationError(null);
        setGeneratedImage(null);
        setGenerationProgress('Connecting to AI Engine...');

        try {
            // Start generation
            setGenerationProgress('Uploading image to AI Engine...');
            const response = await fetch('/api/v1/staging/generate', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    imageData: roomImage,
                    imageName: roomImageName || `room_${Date.now()}.png`,
                    roomType,
                    style,
                    extras,
                    computeMode,
                    furniture: selectedShopifyProducts.map(p => p.title),
                }),
            });

            if (!response.ok) {
                const error = await response.json();
                throw new Error(error.error || 'Generation failed');
            }

            const { promptId } = await response.json();
            setGenerationProgress('Processing with AI Engine...');

            // Poll for result
            let attempts = 0;
            const maxAttempts = 150; // 5 minutes with 2s intervals

            while (attempts < maxAttempts) {
                await new Promise((resolve) => setTimeout(resolve, 2000));

                const statusResponse = await fetch(`/api/v1/staging/status/${promptId}`);
                const statusData = await statusResponse.json();

                if (statusData.status === 'complete') {
                    if (statusData.imageBase64) {
                        setGeneratedImage(statusData.imageBase64);
                    } else if (statusData.images?.[0]) {
                        setGeneratedImage(statusData.images[0]);
                    }
                    setGenerationProgress('');
                    break;
                }

                attempts++;
                setGenerationProgress(`Processing... (${attempts * 2}s)`);
            }

            if (attempts >= maxAttempts) {
                throw new Error('Generation timed out. Please try again.');
            }
        } catch (error) {
            console.error('Generation error:', error);
            setGenerationError(error instanceof Error ? error.message : 'Generation failed');
            setGenerationProgress('');
        } finally {
            setIsGenerating(false);
        }
    };

    return (
        <div className="space-y-6">
            {/* Image Upload */}
            <div>
                <Dropzone
                    onImageUpload={(data, name) => setRoomImage(data, name)}
                    currentImage={roomImage}
                    onClear={() => {
                        setRoomImage(null);
                        setGeneratedImage(null);
                    }}
                    dictionary={{
                        uploadRoom: dictionary.editor.uploadRoom,
                        dragDrop: dictionary.editor.dragDrop,
                    }}
                />
            </div>

            {/* Prompt Mode */}
            <div>
                <label className="mb-2 block text-sm font-medium text-slate-300">
                    {dictionary.editor.promptMode}
                </label>
                <div className="grid grid-cols-2 gap-2 sm:grid-cols-4">
                    {[
                        { value: 'staging', icon: Layers, label: dictionary.editor.staging },
                        { value: 'recolor', icon: Palette, label: dictionary.editor.recolor },
                        { value: 'style-transfer', icon: Wand2, label: dictionary.editor.styleTransfer },
                        { value: '3d-generation', icon: Box, label: dictionary.editor['3dGeneration'] },
                    ].map((mode) => (
                        <button
                            key={mode.value}
                            onClick={() => setPromptMode(mode.value as PromptMode)}
                            className={`flex flex-col items-center gap-2 rounded-lg border p-3 text-center transition-colors ${promptMode === mode.value
                                ? 'border-purple-500 bg-purple-500/10 text-purple-300'
                                : 'border-slate-700 bg-slate-800/50 text-slate-400 hover:border-slate-600'
                                }`}
                        >
                            <mode.icon className="h-5 w-5" />
                            <span className="text-xs">{mode.label}</span>
                        </button>
                    ))}
                </div>
            </div>

            {/* Room Type */}
            <Select
                label={dictionary.editor.roomType}
                value={roomType}
                onChange={(v) => setRoomType(v as RoomType)}
                options={translatedRoomTypes}
            />

            {/* Style */}
            <Select
                label={dictionary.editor.style}
                value={style}
                onChange={(v) => setStyle(v as InteriorStyle)}
                options={translatedStyles}
            />

            {/* Furniture Selection */}
            <div>
                <label className="mb-2 block text-sm font-medium text-slate-300">
                    Furniture from Shop
                </label>
                <Button
                    onClick={() => setIsFurnitureBrowserOpen(true)}
                    variant="secondary"
                    className="w-full justify-start gap-2"
                >
                    <ShoppingBag className="h-4 w-4" />
                    Browse Furniture
                    {selectedShopifyProducts.length > 0 && (
                        <span className="ml-auto rounded-full bg-purple-500 px-2 py-0.5 text-xs">
                            {selectedShopifyProducts.length}
                        </span>
                    )}
                </Button>

                {/* Show selected products */}
                {selectedShopifyProducts.length > 0 && (
                    <div className="mt-3">
                        <FurnitureSelection
                            products={selectedShopifyProducts}
                            onRemove={removeShopifyProduct}
                            onClear={clearShopifyProducts}
                        />
                    </div>
                )}
            </div>

            {/* Extras */}
            <div>
                <label className="mb-2 block text-sm font-medium text-slate-300">
                    {dictionary.editor.extras}
                </label>
                <div className="flex flex-wrap gap-2">
                    {translatedExtras.map((extra) => (
                        <button
                            key={extra.key}
                            onClick={() => toggleExtra(extra.key)}
                            className={`rounded-full px-3 py-1.5 text-xs font-medium transition-colors ${extras.includes(extra.key)
                                ? 'bg-purple-600 text-white'
                                : 'bg-slate-800 text-slate-400 hover:bg-slate-700'
                                }`}
                        >
                            {extra.label}
                        </button>
                    ))}
                </div>
            </div>

            {/* Compute Mode */}
            <div>
                <label className="mb-2 block text-sm font-medium text-slate-300">
                    {dictionary.editor.computeMode}
                </label>
                <ToggleGroup
                    value={computeMode}
                    onChange={(v) => setComputeMode(v as 'cpu' | 'gpu')}
                    options={[
                        { value: 'cpu', label: dictionary.editor.cpu },
                        { value: 'gpu', label: dictionary.editor.gpu },
                    ]}
                />
                <p className="mt-2 text-xs text-slate-500">
                    {computeMode === 'cpu'
                        ? dictionary.editor.cpuDesc
                        : dictionary.editor.gpuDesc}
                </p>
            </div>

            {/* IP-Adapter Note */}
            <div className="flex items-start gap-2 rounded-lg border border-slate-700 bg-slate-800/30 p-3">
                <Info className="mt-0.5 h-4 w-4 shrink-0 text-slate-400" />
                <p className="text-xs text-slate-400">{dictionary.editor.ipAdapterNote}</p>
            </div>

            {/* Error Display */}
            {generationError && (
                <div className="rounded-lg border border-red-500/20 bg-red-500/10 p-3">
                    <p className="text-sm text-red-300">{generationError}</p>
                </div>
            )}

            {/* Action Buttons */}
            <div className="grid gap-3 sm:grid-cols-2">
                <Button
                    onClick={handleGenerateImage}
                    size="lg"
                    disabled={!roomImage || isGenerating}
                    className="gap-2"
                >
                    {isGenerating ? (
                        <>
                            <Loader2 className="h-4 w-4 animate-spin" />
                            Generating...
                        </>
                    ) : (
                        <>
                            <Sparkles className="h-4 w-4" />
                            Generate Image
                        </>
                    )}
                </Button>
                <Button
                    onClick={handleGeneratePrompt}
                    size="lg"
                    variant="secondary"
                    className="gap-2"
                >
                    <FileText className="h-4 w-4" />
                    {dictionary.editor.generatePrompt}
                </Button>
            </div>

            {/* Generation Result */}
            <GenerationResult
                originalImage={roomImage}
                generatedImage={generatedImage}
                isGenerating={isGenerating}
                progress={generationProgress}
                onRegenerate={handleGenerateImage}
                dictionary={dictionary}
            />

            {/* Prompt Output */}
            <PromptOutput dictionary={dictionary} />

            {/* Furniture Browser Modal */}
            <FurnitureBrowser
                isOpen={isFurnitureBrowserOpen}
                onClose={() => setIsFurnitureBrowserOpen(false)}
                selectedProducts={selectedShopifyProducts}
                onProductSelect={addShopifyProduct}
                onProductRemove={removeShopifyProduct}
            />
        </div>
    );
}
