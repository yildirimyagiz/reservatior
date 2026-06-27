'use client';

import { X } from 'lucide-react';
import Image from 'next/image';
import type { ShopifyProduct } from '@/types';

interface FurnitureSelectionProps {
    products: ShopifyProduct[];
    onRemove: (productId: string) => void;
    onClear: () => void;
}

export function FurnitureSelection({
    products,
    onRemove,
    onClear,
}: FurnitureSelectionProps) {
    if (products.length === 0) {
        return null;
    }

    return (
        <div className="rounded-lg border border-slate-700 bg-slate-800/50 p-4">
            <div className="mb-3 flex items-center justify-between">
                <h3 className="text-sm font-medium text-slate-300">
                    Selected Furniture ({products.length})
                </h3>
                <button
                    onClick={onClear}
                    className="text-xs text-slate-500 hover:text-slate-300"
                >
                    Clear all
                </button>
            </div>
            <div className="flex flex-wrap gap-2">
                {products.map((product) => (
                    <div
                        key={product.id}
                        className="group relative flex items-center gap-2 rounded-lg border border-slate-600 bg-slate-700/50 py-1 pl-1 pr-2"
                    >
                        {/* Thumbnail */}
                        <div className="h-8 w-8 overflow-hidden rounded">
                            {product.image?.url ? (
                                <Image
                                    src={product.image.url}
                                    alt={product.title}
                                    fill
                                    className="object-cover"
                                />
                            ) : (
                                <div className="flex h-full w-full items-center justify-center bg-slate-600 text-xs text-slate-400">
                                    N/A
                                </div>
                            )}
                        </div>

                        {/* Title */}
                        <span className="max-w-[100px] truncate text-xs text-slate-300">
                            {product.title}
                        </span>

                        {/* Remove button */}
                        <button
                            onClick={() => onRemove(product.id)}
                            className="rounded-full p-0.5 text-slate-500 hover:bg-slate-600 hover:text-white"
                        >
                            <X className="h-3 w-3" />
                        </button>
                    </div>
                ))}
            </div>
        </div>
    );
}
