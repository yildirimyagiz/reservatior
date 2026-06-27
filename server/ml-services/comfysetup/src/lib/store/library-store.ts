import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import type { FurnitureItem, FurnitureCategory } from '@/types';
import { generateId } from '@/lib/utils';

interface LibraryState {
    furniture: FurnitureItem[];

    // Actions
    addFurniture: (item: Omit<FurnitureItem, 'id' | 'createdAt'>) => string;
    removeFurniture: (id: string) => void;
    updateFurniture: (id: string, updates: Partial<FurnitureItem>) => void;
    getFurnitureByCategory: (category: FurnitureCategory) => FurnitureItem[];
    getFurnitureById: (id: string) => FurnitureItem | undefined;
    clearAll: () => void;
}

// Built-in templates
const defaultTemplates: FurnitureItem[] = [
    {
        id: 'template-modern-sofa',
        name: 'Modern Sofa',
        category: 'sofa',
        imageData: '',
        source: 'template',
        createdAt: Date.now(),
    },
    {
        id: 'template-dining-table',
        name: 'Dining Table',
        category: 'table',
        imageData: '',
        source: 'template',
        createdAt: Date.now(),
    },
    {
        id: 'template-accent-chair',
        name: 'Accent Chair',
        category: 'chair',
        imageData: '',
        source: 'template',
        createdAt: Date.now(),
    },
    {
        id: 'template-floor-lamp',
        name: 'Floor Lamp',
        category: 'lighting',
        imageData: '',
        source: 'template',
        createdAt: Date.now(),
    },
];

export const useLibraryStore = create<LibraryState>()(
    persist(
        (set, get) => ({
            furniture: defaultTemplates,

            addFurniture: (item) => {
                const id = generateId();
                const newItem: FurnitureItem = {
                    ...item,
                    id,
                    createdAt: Date.now(),
                };
                set((state) => ({
                    furniture: [...state.furniture, newItem],
                }));
                return id;
            },

            removeFurniture: (id) =>
                set((state) => ({
                    furniture: state.furniture.filter((f) => f.id !== id),
                })),

            updateFurniture: (id, updates) =>
                set((state) => ({
                    furniture: state.furniture.map((f) =>
                        f.id === id ? { ...f, ...updates } : f
                    ),
                })),

            getFurnitureByCategory: (category) =>
                get().furniture.filter((f) => f.category === category),

            getFurnitureById: (id) =>
                get().furniture.find((f) => f.id === id),

            clearAll: () => set({ furniture: defaultTemplates }),
        }),
        {
            name: 'furniture-library',
        }
    )
);
