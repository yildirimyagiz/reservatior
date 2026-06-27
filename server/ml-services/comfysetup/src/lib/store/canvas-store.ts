import { create } from 'zustand';
import type { ShopifyProduct } from '@/types';

// Canvas item types
export interface CanvasItem {
  id: string;
  type: 'furniture' | 'image' | 'room' | 'text';
  name: string;
  src: string;
  x: number;
  y: number;
  width: number;
  height: number;
  rotation: number;
  scaleX: number;
  scaleY: number;
  opacity: number;
  zIndex: number;
  locked: boolean;
  visible: boolean;
  // Shopify product data if from store
  shopifyProduct?: ShopifyProduct;
}

export type RoomType =
  | 'living-room'
  | 'bedroom'
  | 'dining-room'
  | 'kitchen'
  | 'office'
  | 'bathroom'
  | 'outdoor'
  | 'kids-room'
  | 'home-gym'
  | 'add-room';

export type DesignStyle =
  | 'modern-minimalist'
  | 'scandinavian'
  | 'industrial'
  | 'mid-century-modern'
  | 'bohemian'
  | 'contemporary'
  | 'traditional'
  | 'coastal'
  | 'farmhouse'
  | 'luxury'
  | 'cyberpunk'
  | 'japanese'
  | 'biophilic'
  | 'pacific-northwest'
  | 'urban-industrial'
  | 'coastal-modern'
  | 'tech-loft'
  | 'art-deco';

// Tool types matching Collov.ai
export type CanvasTool =
  | 'furniture' // Add Furniture (Default)
  | 'eraser' // Furniture Eraser
  | 'declutter' // Room Declutter
  | 'enhance' // Enhance Photo Quality
  | 'material' // Material Overlay
  | 'seasons' // Changing Seasons
  | 'rain-shine' // Rain to Shine
  | 'natural-twilight' // Natural Twilight
  | 'virtual-twilight' // Virtual Twilight
  | 'water-pool' // Add Water to Empty Pool
  | 'pool-enhancement' // Pool Water Enhancement
  | 'lawn' // Lawn Replacement
  | 'staging' // Virtual Staging Templates
  | 'layers' // Layer Management
  | 'night-day'; // Night to Day

export interface CanvasState {
  // Canvas dimensions
  canvasWidth: number;
  canvasHeight: number;
  zoom: number;

  // Room background
  roomImage: string | null;
  roomImageName: string | null;

  // Items on canvas
  items: CanvasItem[];
  selectedItemIds: string[];

  // History for undo/redo
  history: CanvasItem[][];
  historyIndex: number;

  // Settings
  roomType: RoomType;
  style: DesignStyle;
  colorPalette: string[];

  // Generation
  isGenerating: boolean;

  generatedImage: string | null;

  // ComfyUI
  comfyuiUrl: string;
  selectedCheckpoint: string;
  selectedControlNet: string;

  // Active Tool (from Sidebar)
  activeTool: CanvasTool | null;
  setActiveTool: (tool: CanvasTool | null) => void;

  // Compliance
  watermarkEnabled: boolean;
  setWatermarkEnabled: (enabled: boolean) => void;

  // Comparison Mode
  isCompareMode: boolean;
  setCompareMode: (enabled: boolean) => void;

  // UI State
  sidePanelVisible: boolean;
  setSidePanelVisible: (visible: boolean) => void;

  // Actions - Room
  setRoomImage: (image: string | null, name?: string) => void;
  clearRoom: () => void;

  // Actions - Items
  addItem: (item: Omit<CanvasItem, 'id' | 'zIndex'>) => void;
  updateItem: (id: string, updates: Partial<CanvasItem>) => void;
  removeItem: (id: string) => void;
  duplicateItem: (id: string) => void;

  // Actions - Selection
  selectItem: (id: string, addToSelection?: boolean) => void;
  deselectItem: (id: string) => void;
  clearSelection: () => void;
  selectAll: () => void;

  // Actions - Layer ordering
  bringToFront: (id: string) => void;
  sendToBack: (id: string) => void;
  moveUp: (id: string) => void;
  moveDown: (id: string) => void;

  // Actions - History
  undo: () => void;
  redo: () => void;
  saveToHistory: () => void;

  // Actions - Settings
  setRoomType: (type: RoomType) => void;
  setStyle: (style: DesignStyle) => void;
  setColorPalette: (colors: string[]) => void;
  setZoom: (zoom: number) => void;

  // Actions - Generation
  setIsGenerating: (isGenerating: boolean) => void;
  setGeneratedImage: (image: string | null) => void;

  // Actions - ComfyUI
  setComfyUrl: (url: string) => void;
  setCheckpoint: (ckpt: string) => void;
  setControlNet: (model: string) => void;

  // Actions - Reset
  reset: () => void;
}

const generateId = () => `item-${Date.now()}-${Math.random().toString(36).substr(2, 9)}`;

const initialState = {
  canvasWidth: 1024,
  canvasHeight: 768,
  zoom: 1,
  roomImage: null,
  roomImageName: null,
  items: [],
  selectedItemIds: [],
  history: [],
  historyIndex: -1,
  roomType: 'living-room' as RoomType,
  style: 'modern-minimalist' as DesignStyle,
  colorPalette: ['#F5F5F5', '#2C3E50', '#E67E22'],
  isGenerating: false,
  generatedImage: null,
  // ComfyUI Settings
  comfyuiUrl: process.env.NEXT_PUBLIC_COMFY_API_URL || 'http://127.0.0.1:8188',
  selectedCheckpoint: 'sd_xl_base_1.0.safetensors',
  selectedControlNet: 'control_v11f1p_sd15_depth.pth',
  activeTool: 'staging' as CanvasTool, // CHANGED: Default is now 'staging'
  watermarkEnabled: false,
  isCompareMode: true,
  sidePanelVisible: true,
};

export const useCanvasStore = create<CanvasState>((set, get) => ({
  ...initialState,

  // Room actions
  setRoomImage: (image, name) =>
    set({
      roomImage: image,
      roomImageName: name ?? null,
      generatedImage: null, // Clear generated image when room changes
    }),

  clearRoom: () =>
    set({
      roomImage: null,
      roomImageName: null,
      generatedImage: null,
    }),

  // Item actions
  addItem: (item) => {
    const state = get();
    const maxZIndex = state.items.reduce((max, i) => Math.max(max, i.zIndex), 0);
    const newItem: CanvasItem = {
      ...item,
      id: generateId(),
      zIndex: maxZIndex + 1,
    };
    set({ items: [...state.items, newItem] });
    get().saveToHistory();
  },

  updateItem: (id, updates) => {
    set((state) => ({
      items: state.items.map((item) => (item.id === id ? { ...item, ...updates } : item)),
    }));
  },

  removeItem: (id) => {
    set((state) => ({
      items: state.items.filter((item) => item.id !== id),
      selectedItemIds: state.selectedItemIds.filter((itemId) => itemId !== id),
    }));
    get().saveToHistory();
  },

  duplicateItem: (id) => {
    const state = get();
    const item = state.items.find((i) => i.id === id);
    if (!item) return;

    const maxZIndex = state.items.reduce((max, i) => Math.max(max, i.zIndex), 0);
    const newItem: CanvasItem = {
      ...item,
      id: generateId(),
      x: item.x + 20,
      y: item.y + 20,
      zIndex: maxZIndex + 1,
    };
    set({ items: [...state.items, newItem], selectedItemIds: [newItem.id] });
    get().saveToHistory();
  },

  // Selection actions
  selectItem: (id, addToSelection = false) => {
    set((state) => ({
      selectedItemIds: addToSelection
        ? [...state.selectedItemIds.filter((itemId) => itemId !== id), id]
        : [id],
    }));
  },

  deselectItem: (id) => {
    set((state) => ({
      selectedItemIds: state.selectedItemIds.filter((itemId) => itemId !== id),
    }));
  },

  clearSelection: () => set({ selectedItemIds: [] }),

  selectAll: () => {
    set((state) => ({
      selectedItemIds: state.items.filter((i) => !i.locked).map((i) => i.id),
    }));
  },

  // Layer ordering
  bringToFront: (id) => {
    const state = get();
    const maxZIndex = state.items.reduce((max, i) => Math.max(max, i.zIndex), 0);
    set({
      items: state.items.map((item) =>
        item.id === id ? { ...item, zIndex: maxZIndex + 1 } : item
      ),
    });
  },

  sendToBack: (id) => {
    const state = get();
    const minZIndex = state.items.reduce((min, i) => Math.min(min, i.zIndex), Infinity);
    set({
      items: state.items.map((item) =>
        item.id === id ? { ...item, zIndex: minZIndex - 1 } : item
      ),
    });
  },

  moveUp: (id) => {
    const state = get();
    const item = state.items.find((i) => i.id === id);
    if (!item) return;

    const itemsAbove = state.items.filter((i) => i.zIndex > item.zIndex);
    if (itemsAbove.length === 0) return;

    const nextItem = itemsAbove.reduce((closest, i) => (i.zIndex < closest.zIndex ? i : closest));

    set({
      items: state.items.map((i) => {
        if (i.id === id) return { ...i, zIndex: nextItem.zIndex };
        if (i.id === nextItem.id) return { ...i, zIndex: item.zIndex };
        return i;
      }),
    });
  },

  moveDown: (id) => {
    const state = get();
    const item = state.items.find((i) => i.id === id);
    if (!item) return;

    const itemsBelow = state.items.filter((i) => i.zIndex < item.zIndex);
    if (itemsBelow.length === 0) return;

    const prevItem = itemsBelow.reduce((closest, i) => (i.zIndex > closest.zIndex ? i : closest));

    set({
      items: state.items.map((i) => {
        if (i.id === id) return { ...i, zIndex: prevItem.zIndex };
        if (i.id === prevItem.id) return { ...i, zIndex: item.zIndex };
        return i;
      }),
    });
  },

  // History actions
  saveToHistory: () => {
    const state = get();
    const newHistory = state.history.slice(0, state.historyIndex + 1);
    newHistory.push([...state.items]);
    set({
      history: newHistory.slice(-50), // Keep last 50 states
      historyIndex: newHistory.length - 1,
    });
  },

  undo: () => {
    const state = get();
    if (state.historyIndex <= 0) return;
    const newIndex = state.historyIndex - 1;
    set({
      items: [...state.history[newIndex]],
      historyIndex: newIndex,
      selectedItemIds: [],
    });
  },

  redo: () => {
    const state = get();
    if (state.historyIndex >= state.history.length - 1) return;
    const newIndex = state.historyIndex + 1;
    set({
      items: [...state.history[newIndex]],
      historyIndex: newIndex,
      selectedItemIds: [],
    });
  },

  // Settings actions
  setRoomType: (roomType) => set({ roomType }),
  setStyle: (style) => set({ style }),
  setColorPalette: (colorPalette) => set({ colorPalette }),
  setZoom: (zoom) => set({ zoom: Math.max(0.25, Math.min(2, zoom)) }),

  // Generation actions
  setIsGenerating: (isGenerating) => set({ isGenerating }),
  setGeneratedImage: (generatedImage) => set({ generatedImage }),

  // ComfyUI actions
  setComfyUrl: (comfyuiUrl) => set({ comfyuiUrl }),
  setCheckpoint: (selectedCheckpoint) => set({ selectedCheckpoint }),
  setControlNet: (selectedControlNet) => set({ selectedControlNet }),

  setActiveTool: (activeTool) => set({ activeTool }),

  // Compliance
  setWatermarkEnabled: (watermarkEnabled) => set({ watermarkEnabled }),

  // Comparison Mode
  setCompareMode: (isCompareMode) => set({ isCompareMode }),

  setSidePanelVisible: (sidePanelVisible) => set({ sidePanelVisible }),

  // Reset
  reset: () => set(initialState),
}));
