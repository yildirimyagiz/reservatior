import { useCanvasStore } from '@/lib/store/canvas-store';
import { toast } from 'sonner';

export function useStagingGeneration() {
    const {
        roomImage,
        roomType,
        style,
        setIsGenerating,
        setGeneratedImage,
        watermarkEnabled, // Compliance
    } = useCanvasStore();

    const generateStaging = async () => {
        if (!roomImage) {
            toast.error('Please upload a room image first');
            return;
        }

        setIsGenerating(true);
        setGeneratedImage(null);

        try {
            // Collect furniture names can be used for logging or future prompt enhancement
            // const furnitureNames = items.map((item) => item.name);
            const state = useCanvasStore.getState();

            // Call the new production-ready CDN endpoint
            const response = await fetch('/api/v1/staging/generate-cdn', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    imageData: roomImage,
                    roomType,
                    style,
                    computeMode: 'gpu',
                    // Pass extras from store if needed
                    extras: [],
                    // Optional legacy settings if needed by backend
                    comfyuiUrl: state.comfyuiUrl,
                    watermarkEnabled, // Compliance
                }),
            });

            const data = await response.json();

            if (!response.ok) {
                throw new Error(data.error || 'Generation failed');
            }

            // Handle synchronous response from A1111/RunPod
            if (data.success && data.images) {
                // Use the full image or preview
                setGeneratedImage(data.images.full || data.images.preview);
                toast.success(`Staging complete! (${(data.processingTime / 1000).toFixed(1)}s)`);
                setIsGenerating(false);
                return;
            }

            // Fallback for async paths (if we re-introduce ComfyUI polling later)
            if (data.id) {
                toast.success('Generation started (async)...');
                // Poll logic would go here if needed
                return;
            }

            throw new Error('Invalid response from server');

        } catch (error) {
            console.error('Generation error:', error);
            toast.error(error instanceof Error ? error.message : 'Failed to generate staging');
            setIsGenerating(false);
        }
    };

    const generateSimpleStaging = async () => {
        if (!roomImage) {
            toast.error('Please upload a room image first');
            return;
        }

        setIsGenerating(true);
        setGeneratedImage(null);

        const { activeTool } = useCanvasStore.getState();

        try {
            const response = await fetch('/api/v1/staging/generate-simple', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    imageData: roomImage,
                    roomType,
                    style,
                    computeMode: 'cpu',
                    activeTool: activeTool || 'furniture',
                }),
            });

            const data = await response.json();

            if (!response.ok) {
                throw new Error(data.error || 'Simple staging failed');
            }

            if (data.success && data.imageData) {
                setGeneratedImage(data.imageData);
                toast.success('Simple staging complete! (CPU Optimized)');
                setIsGenerating(false);
                return;
            }

            throw new Error('Invalid response from server');

        } catch (error) {
            console.error('Simple generation error:', error);
            toast.error(error instanceof Error ? error.message : 'Failed to generate simple staging');
            setIsGenerating(false);
        }
    };

    return { generateStaging, generateSimpleStaging };
}
