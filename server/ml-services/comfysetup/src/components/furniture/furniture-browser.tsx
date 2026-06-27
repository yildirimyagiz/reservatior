'use client';

import { useState, useEffect, useCallback } from 'react';
import Image from 'next/image';
import { X, Search, Loader2, ShoppingBag } from 'lucide-react';
import { FurnitureCard } from './furniture-card';
import { Button } from '@/components/ui/button';
import type { ShopifyProduct, ShopifyProductsResponse } from '@/types';

interface FurnitureBrowserProps {
    isOpen: boolean;
    onClose: () => void;
    selectedProducts: ShopifyProduct[];
    onProductSelect: (product: ShopifyProduct) => void;
    onProductRemove: (productId: string) => void;
}

const CATEGORIES = [
    { key: 'all', label: 'All Furniture' },
    { key: 'sofa', label: 'Sofas' },
    { key: 'chair', label: 'Chairs' },
    { key: 'table', label: 'Tables' },
    { key: 'bed', label: 'Beds' },
    { key: 'storage', label: 'Storage' },
    { key: 'lighting', label: 'Lighting' },
    { key: 'decor', label: 'Decor' },
];

export function FurnitureBrowser({
    isOpen,
    onClose,
    selectedProducts,
    onProductSelect,
    onProductRemove,
}: FurnitureBrowserProps) {
    const [products, setProducts] = useState<ShopifyProduct[]>([]);
    const [isLoading, setIsLoading] = useState(false);
    const [error, setError] = useState<string | null>(null);
    const [activeCategory, setActiveCategory] = useState('all');
    const [searchQuery, setSearchQuery] = useState('');
    const [hasNextPage, setHasNextPage] = useState(false);
    const [endCursor, setEndCursor] = useState<string | null>(null);

    const fetchProducts = useCallback(async (isSearch = false) => {
        setIsLoading(true);
        setError(null);

        try {
            const params = new URLSearchParams();
            params.set('first', '20');

            if (isSearch && searchQuery) {
                params.set('search', searchQuery);
            } else if (activeCategory !== 'all') {
                params.set('category', activeCategory);
            }

            const response = await fetch(`/api/v1/integrations/shopify/products?${params}`);
            const data: ShopifyProductsResponse = await response.json();

            if (response.ok) {
                setProducts(data.products || []);
                setHasNextPage(data.pageInfo?.hasNextPage || false);
                setEndCursor(data.pageInfo?.endCursor || null);
            } else {
                setError((data as { message?: string }).message || 'Failed to load products');
            }
        } catch (err) {
            setError('Failed to connect to Shopify');
            console.error('Fetch error:', err);
        } finally {
            setIsLoading(false);
        }
    }, [activeCategory, searchQuery]);

    // Fetch products when modal opens or filters change
    useEffect(() => {
        if (isOpen) {
            fetchProducts();
        }
    }, [isOpen, fetchProducts]);

    // Debounced search
    useEffect(() => {
        if (!isOpen) return;

        const timer = setTimeout(() => {
            if (searchQuery) {
                fetchProducts(true);
            }
        }, 300);

        return () => clearTimeout(timer);
    }, [searchQuery, isOpen, fetchProducts]);

    const loadMore = async () => {
        if (!endCursor || isLoading) return;

        setIsLoading(true);
        try {
            const params = new URLSearchParams();
            params.set('first', '20');
            params.set('after', endCursor);

            if (activeCategory !== 'all') {
                params.set('category', activeCategory);
            }

            const response = await fetch(`/api/v1/integrations/shopify/products?${params}`);
            const data: ShopifyProductsResponse = await response.json();

            if (response.ok) {
                setProducts(prev => [...prev, ...(data.products || [])]);
                setHasNextPage(data.pageInfo?.hasNextPage || false);
                setEndCursor(data.pageInfo?.endCursor || null);
            }
        } catch (err) {
            console.error('Load more error:', err);
        } finally {
            setIsLoading(false);
        }
    };

    const isProductSelected = (productId: string) => {
        return selectedProducts.some(p => p.id === productId);
    };

    const handleProductClick = (product: ShopifyProduct) => {
        if (isProductSelected(product.id)) {
            onProductRemove(product.id);
        } else {
            onProductSelect(product);
        }
    };

    if (!isOpen) return null;

    return (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4">
            {/* Backdrop */}
            <div
                className="absolute inset-0 bg-black/70 backdrop-blur-sm"
                onClick={onClose}
            />

            {/* Modal */}
            <div className="relative flex h-[85vh] w-full max-w-5xl flex-col overflow-hidden rounded-2xl border border-slate-700 bg-slate-900 shadow-2xl">
                {/* Header */}
                <div className="flex items-center justify-between border-b border-slate-700 px-6 py-4">
                    <div className="flex items-center gap-3">
                        <ShoppingBag className="h-6 w-6 text-purple-400" />
                        <h2 className="text-xl font-bold text-white">Browse Furniture</h2>
                        {selectedProducts.length > 0 && (
                            <span className="rounded-full bg-purple-500 px-2 py-0.5 text-xs font-medium text-white">
                                {selectedProducts.length} selected
                            </span>
                        )}
                    </div>
                    <button
                        onClick={onClose}
                        className="rounded-lg p-2 text-slate-400 transition-colors hover:bg-slate-800 hover:text-white"
                    >
                        <X className="h-5 w-5" />
                    </button>
                </div>

                {/* Search & Categories */}
                <div className="space-y-3 border-b border-slate-700 px-6 py-4">
                    {/* Search */}
                    <div className="relative">
                        <Search className="absolute left-3 top-1/2 h-5 w-5 -translate-y-1/2 text-slate-400" />
                        <input
                            type="text"
                            placeholder="Search furniture..."
                            value={searchQuery}
                            onChange={(e) => setSearchQuery(e.target.value)}
                            className="w-full rounded-lg border border-slate-700 bg-slate-800 py-2 pl-10 pr-4 text-white placeholder-slate-400 focus:border-purple-500 focus:outline-none focus:ring-1 focus:ring-purple-500"
                        />
                    </div>

                    {/* Category Tabs */}
                    <div className="flex gap-2 overflow-x-auto pb-1">
                        {CATEGORIES.map((cat) => (
                            <button
                                key={cat.key}
                                onClick={() => {
                                    setActiveCategory(cat.key);
                                    setSearchQuery('');
                                }}
                                className={`whitespace-nowrap rounded-full px-4 py-1.5 text-sm font-medium transition-colors ${activeCategory === cat.key
                                    ? 'bg-purple-500 text-white'
                                    : 'bg-slate-800 text-slate-400 hover:bg-slate-700 hover:text-white'
                                    }`}
                            >
                                {cat.label}
                            </button>
                        ))}
                    </div>
                </div>

                {/* Products Grid */}
                <div className="flex-1 overflow-y-auto p-6">
                    {isLoading && products.length === 0 ? (
                        <div className="flex h-full items-center justify-center">
                            <Loader2 className="h-8 w-8 animate-spin text-purple-400" />
                        </div>
                    ) : error ? (
                        <div className="flex h-full flex-col items-center justify-center text-center text-slate-400">
                            <p className="mb-4">{error}</p>
                            <Button onClick={() => fetchProducts()} variant="secondary">
                                Try Again
                            </Button>
                        </div>
                    ) : products.length === 0 ? (
                        <div className="flex h-full items-center justify-center text-slate-400">
                            <p>No furniture found. Check your Shopify configuration.</p>
                        </div>
                    ) : (
                        <>
                            <div className="grid grid-cols-2 gap-4 sm:grid-cols-3 lg:grid-cols-4">
                                {products.map((product) => (
                                    <FurnitureCard
                                        key={product.id}
                                        product={product}
                                        isSelected={isProductSelected(product.id)}
                                        onSelect={handleProductClick}
                                    />
                                ))}
                            </div>

                            {/* Load More */}
                            {hasNextPage && (
                                <div className="mt-6 flex justify-center">
                                    <Button
                                        onClick={loadMore}
                                        variant="secondary"
                                        disabled={isLoading}
                                    >
                                        {isLoading ? (
                                            <>
                                                <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                                                Loading...
                                            </>
                                        ) : (
                                            'Load More'
                                        )}
                                    </Button>
                                </div>
                            )}
                        </>
                    )}
                </div>

                {/* Footer with Selected Items */}
                {selectedProducts.length > 0 && (
                    <div className="border-t border-slate-700 px-6 py-4">
                        <div className="flex items-center justify-between">
                            <div className="flex gap-2 overflow-x-auto">
                                {selectedProducts.slice(0, 4).map((product) => (
                                    <div
                                        key={product.id}
                                        className="relative h-12 w-12 flex-shrink-0 overflow-hidden rounded-lg border border-slate-600"
                                    >
                                        {product.image?.url ? (
                                            <Image
                                                src={product.image.url}
                                                alt={product.title}
                                                fill
                                                className="object-cover"
                                            />
                                        ) : (
                                            <div className="flex h-full w-full items-center justify-center bg-slate-700 text-xs text-slate-400">
                                                N/A
                                            </div>
                                        )}
                                        <button
                                            onClick={() => onProductRemove(product.id)}
                                            className="absolute -right-1 -top-1 rounded-full bg-red-500 p-0.5 text-white"
                                        >
                                            <X className="h-3 w-3" />
                                        </button>
                                    </div>
                                ))}
                                {selectedProducts.length > 4 && (
                                    <div className="flex h-12 w-12 flex-shrink-0 items-center justify-center rounded-lg border border-slate-600 bg-slate-700 text-sm text-slate-300">
                                        +{selectedProducts.length - 4}
                                    </div>
                                )}
                            </div>
                            <Button onClick={onClose} className="ml-4">
                                Done ({selectedProducts.length})
                            </Button>
                        </div>
                    </div>
                )}
            </div>
        </div>
    );
}
