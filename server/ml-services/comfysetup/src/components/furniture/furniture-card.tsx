'use client';

import Image from 'next/image';
import type { ShopifyProduct } from '@/types';

interface FurnitureCardProps {
    product: ShopifyProduct;
    isSelected?: boolean;
    onSelect?: (product: ShopifyProduct) => void;
    showPrice?: boolean;
}

export function FurnitureCard({
    product,
    isSelected = false,
    onSelect,
    showPrice = true,
}: FurnitureCardProps) {
    const formatPrice = (amount: string, currencyCode: string) => {
        const num = parseFloat(amount);
        return new Intl.NumberFormat('en-US', {
            style: 'currency',
            currency: currencyCode,
        }).format(num);
    };

    const imageUrl = product.image?.url || product.images[0]?.url;
    const imageAlt = product.image?.altText || product.title;

    return (
        <div
            onClick={() => onSelect?.(product)}
            className={`group relative cursor-pointer overflow-hidden rounded-xl border transition-all duration-200 ${isSelected
                    ? 'border-purple-500 bg-purple-500/10 ring-2 ring-purple-500/50'
                    : 'border-slate-700 bg-slate-800/50 hover:border-slate-600 hover:bg-slate-800'
                }`}
        >
            {/* Product Image */}
            <div className="relative aspect-square overflow-hidden bg-slate-900">
                {imageUrl ? (
                    <Image
                        src={imageUrl}
                        alt={imageAlt}
                        fill
                        className="object-cover transition-transform duration-300 group-hover:scale-105"
                        sizes="(max-width: 640px) 50vw, (max-width: 1024px) 33vw, 25vw"
                    />
                ) : (
                    <div className="flex h-full items-center justify-center text-slate-600">
                        <svg
                            className="h-12 w-12"
                            fill="none"
                            viewBox="0 0 24 24"
                            stroke="currentColor"
                        >
                            <path
                                strokeLinecap="round"
                                strokeLinejoin="round"
                                strokeWidth={1.5}
                                d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"
                            />
                        </svg>
                    </div>
                )}

                {/* Selection Indicator */}
                {isSelected && (
                    <div className="absolute right-2 top-2 rounded-full bg-purple-500 p-1">
                        <svg
                            className="h-4 w-4 text-white"
                            fill="none"
                            viewBox="0 0 24 24"
                            stroke="currentColor"
                        >
                            <path
                                strokeLinecap="round"
                                strokeLinejoin="round"
                                strokeWidth={2}
                                d="M5 13l4 4L19 7"
                            />
                        </svg>
                    </div>
                )}
            </div>

            {/* Product Info */}
            <div className="p-3">
                <h3 className="truncate text-sm font-medium text-white">
                    {product.title}
                </h3>
                {product.vendor && (
                    <p className="mt-0.5 truncate text-xs text-slate-500">
                        {product.vendor}
                    </p>
                )}
                {showPrice && product.price && (
                    <p className="mt-1 text-sm font-semibold text-purple-400">
                        {formatPrice(product.price.amount, product.price.currencyCode)}
                    </p>
                )}
            </div>
        </div>
    );
}
