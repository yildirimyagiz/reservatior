import { create } from 'zustand';
import type {
    RoomType,
    InteriorStyle,
    ComputeMode,
    PromptMode,
    GeneratedPrompt,
    ShopifyProduct,
} from '@/types';

interface EditorState {
    // Room image
    roomImage: string | null;
    roomImageName: string | null;

    // Configuration
    roomType: RoomType;
    style: InteriorStyle;
    colorPalette: string[];
    extras: string[];
    computeMode: ComputeMode;
    promptMode: PromptMode;
    selectedFurniture: string[];

    // Shopify products
    selectedShopifyProducts: ShopifyProduct[];

    // Output
    generatedPrompt: GeneratedPrompt | null;

    // Actions
    setRoomImage: (image: string | null, name?: string) => void;
    setRoomType: (type: RoomType) => void;
    setStyle: (style: InteriorStyle) => void;
    setColorPalette: (colors: string[]) => void;
    addColor: (color: string) => void;
    removeColor: (color: string) => void;
    setExtras: (extras: string[]) => void;
    toggleExtra: (extra: string) => void;
    setComputeMode: (mode: ComputeMode) => void;
    setPromptMode: (mode: PromptMode) => void;
    setSelectedFurniture: (ids: string[]) => void;
    toggleFurniture: (id: string) => void;
    setGeneratedPrompt: (prompt: GeneratedPrompt | null) => void;

    // Shopify product actions
    addShopifyProduct: (product: ShopifyProduct) => void;
    removeShopifyProduct: (productId: string) => void;
    clearShopifyProducts: () => void;

    reset: () => void;
}

const initialState = {
    roomImage: null,
    roomImageName: null,
    roomType: 'living-room' as RoomType,
    style: 'modern-minimalist' as InteriorStyle,
    colorPalette: ['#F5F5F5', '#2C3E50', '#E67E22'],
    extras: ['plants', 'lighting'],
    computeMode: 'gpu' as ComputeMode,
    promptMode: 'staging' as PromptMode,
    selectedFurniture: [],
    selectedShopifyProducts: [],
    generatedPrompt: null,
};

export const useEditorStore = create<EditorState>((set) => ({
    ...initialState,

    setRoomImage: (image, name) =>
        set({ roomImage: image, roomImageName: name ?? null }),

    setRoomType: (roomType) => set({ roomType }),

    setStyle: (style) => set({ style }),

    setColorPalette: (colorPalette) => set({ colorPalette }),

    addColor: (color) =>
        set((state) => ({
            colorPalette: state.colorPalette.includes(color)
                ? state.colorPalette
                : [...state.colorPalette, color],
        })),

    removeColor: (color) =>
        set((state) => ({
            colorPalette: state.colorPalette.filter((c) => c !== color),
        })),

    setExtras: (extras) => set({ extras }),

    toggleExtra: (extra) =>
        set((state) => ({
            extras: state.extras.includes(extra)
                ? state.extras.filter((e) => e !== extra)
                : [...state.extras, extra],
        })),

    setComputeMode: (computeMode) => set({ computeMode }),

    setPromptMode: (promptMode) => set({ promptMode }),

    setSelectedFurniture: (selectedFurniture) => set({ selectedFurniture }),

    toggleFurniture: (id) =>
        set((state) => ({
            selectedFurniture: state.selectedFurniture.includes(id)
                ? state.selectedFurniture.filter((f) => f !== id)
                : [...state.selectedFurniture, id],
        })),

    setGeneratedPrompt: (generatedPrompt) => set({ generatedPrompt }),

    // Shopify product actions
    addShopifyProduct: (product) =>
        set((state) => ({
            selectedShopifyProducts: state.selectedShopifyProducts.some(
                (p) => p.id === product.id
            )
                ? state.selectedShopifyProducts
                : [...state.selectedShopifyProducts, product],
        })),

    removeShopifyProduct: (productId) =>
        set((state) => ({
            selectedShopifyProducts: state.selectedShopifyProducts.filter(
                (p) => p.id !== productId
            ),
        })),

    clearShopifyProducts: () => set({ selectedShopifyProducts: [] }),

    reset: () => set(initialState),
}));
