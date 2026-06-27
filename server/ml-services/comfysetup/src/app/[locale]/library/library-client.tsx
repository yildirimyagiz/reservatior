'use client';

import { useState, useEffect, useCallback } from 'react';
import { Search, Loader2, ShoppingBag, AlertCircle } from 'lucide-react';
import { FurnitureCard } from '@/components/furniture/furniture-card';
import type { ShopifyProduct, ShopifyProductsResponse } from '@/types';

interface LibraryClientProps {
    title: string;
    description: string;
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

export function LibraryClient({ title, description }: LibraryClientProps) {
    const [products, setProducts] = useState<ShopifyProduct[]>([]);
    const [isLoading, setIsLoading] = useState(true);
    const [error, setError] = useState<string | null>(null);
    const [activeCategory, setActiveCategory] = useState('all');
    const [searchQuery, setSearchQuery] = useState('');
    const [hasNextPage, setHasNextPage] = useState(false);
    const [endCursor, setEndCursor] = useState<string | null>(null);
    const [source, setSource] = useState<'shopify' | 'amazon'>('shopify');

    const fetchProducts = useCallback(async (isSearch = false) => {
        setIsLoading(true);
        setError(null);

        try {
            const params = new URLSearchParams();
            params.set('first', '24');
            params.set('limit', '24'); // for amazon

            if (isSearch && searchQuery) {
                params.set('search', searchQuery);
            } else if (activeCategory !== 'all') {
                params.set('category', activeCategory);
            }

            const endpoint = source === 'shopify' 
                ? `/api/v1/integrations/shopify/products?${params}`
                : `/api/v1/integrations/amazon/products?${params}`;

            const response = await fetch(endpoint);
            const data: ShopifyProductsResponse & { error?: string; message?: string } = await response.json();

            if (response.ok && !data.error) {
                setProducts(data.products || []);
                setHasNextPage(data.pageInfo?.hasNextPage || false);
                setEndCursor(data.pageInfo?.endCursor || null);
            } else {
                setError(data.message || data.error || 'Failed to load products');
            }
        } catch (err) {
            setError(`Failed to connect to ${source === 'shopify' ? 'Shopify' : 'Amazon'}`);
            console.error('Fetch error:', err);
        } finally {
            setIsLoading(false);
        }
    }, [activeCategory, searchQuery, source]);

    // Handle source change
    useEffect(() => {
        fetchProducts();
    }, [source, fetchProducts]);

    // Debounced search
    useEffect(() => {
        const timer = setTimeout(() => {
            // Reset products when starting a new search
            if (searchQuery) {
                fetchProducts(true);
            }
        }, 300);

        return () => clearTimeout(timer);
    }, [searchQuery, fetchProducts]);

    // Handle category changes and initial load
    useEffect(() => {
        if (!searchQuery) {
            fetchProducts();
        }
    }, [activeCategory, fetchProducts, searchQuery]);



    const loadMore = async () => {
        if (!endCursor || isLoading) return;

        setIsLoading(true);
        try {
            const params = new URLSearchParams();
            params.set('first', '24');
            params.set('limit', '24');
            
            if (endCursor) params.set('after', endCursor);

            if (activeCategory !== 'all') {
                params.set('category', activeCategory);
            }
            if (searchQuery) {
                params.set('search', searchQuery);
            }

            const endpoint = source === 'shopify' 
                ? `/api/v1/integrations/shopify/products?${params}`
                : `/api/v1/integrations/amazon/products?${params}`;

            const response = await fetch(endpoint);
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

    const handleProductClick = (product: ShopifyProduct) => {
        if (source === 'shopify') {
            const storeUrl = process.env.NEXT_PUBLIC_SHOPIFY_STORE_URL;
            if (storeUrl) {
                window.open(`${storeUrl}/products/${product.handle}`, '_blank');
            }
        } else {
            // Amazon links
            window.open(`https://www.amazon.com/dp/${product.handle}`, '_blank');
        }
    };

    return (
        <div className="space-y-6">
            {/* Header */}
            <div className="flex flex-col sm:flex-row items-start sm:items-center justify-between gap-4">
                <div className="flex items-center gap-3">
                    <ShoppingBag className="h-8 w-8 text-purple-400" />
                    <div>
                        <h1 className="text-3xl font-bold text-white sm:text-4xl">
                            {title}
                        </h1>
                        <p className="mt-1 text-slate-400">{description}</p>
                    </div>
                </div>

                {/* Source Toggle */}
                <div className="flex bg-slate-800 p-1 rounded-lg">
                    <button
                        onClick={() => setSource('shopify')}
                        className={`px-4 py-2 rounded-md text-sm font-medium transition-colors ${
                            source === 'shopify' 
                                ? 'bg-purple-600 text-white shadow' 
                                : 'text-slate-400 hover:text-white'
                        }`}
                    >
                        Shopify
                    </button>
                    <button
                        onClick={() => setSource('amazon')}
                        className={`px-4 py-2 rounded-md text-sm font-medium transition-colors ${
                            source === 'amazon' 
                                ? 'bg-orange-500 text-white shadow' 
                                : 'text-slate-400 hover:text-white'
                        }`}
                    >
                        Amazon
                    </button>
                </div>
            </div>

            {/* Search & Filters */}
            <div className="space-y-4">
                {/* Search */}
                <div className="relative">
                    <Search className="absolute left-3 top-1/2 h-5 w-5 -translate-y-1/2 text-slate-400" />
                    <input
                        type="text"
                        placeholder={`Search ${source === 'shopify' ? 'furniture' : 'Amazon'}...`}
                        value={searchQuery}
                        onChange={(e) => setSearchQuery(e.target.value)}
                        className="w-full rounded-xl border border-slate-700 bg-slate-800/50 py-3 pl-10 pr-4 text-white placeholder-slate-400 focus:border-purple-500 focus:outline-none focus:ring-1 focus:ring-purple-500"
                    />
                </div>

                {/* Category Tabs */}
                <div className="flex gap-2 overflow-x-auto pb-2">
                    {CATEGORIES.map((cat) => (
                        <button
                            key={cat.key}
                            onClick={() => {
                                setActiveCategory(cat.key);
                                setSearchQuery('');
                            }}
                            className={`whitespace-nowrap rounded-full px-4 py-2 text-sm font-medium transition-colors ${activeCategory === cat.key
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
            {isLoading && products.length === 0 ? (
                <div className="flex h-64 items-center justify-center">
                    <Loader2 className="h-8 w-8 animate-spin text-purple-400" />
                </div>
            ) : error ? (
                <div className="flex h-64 flex-col items-center justify-center rounded-xl border border-dashed border-slate-700 bg-slate-800/30 p-8 text-center">
                    <AlertCircle className="mb-3 h-10 w-10 text-yellow-500" />
                    <p className="mb-2 text-slate-300">{error}</p>
                    <p className="text-sm text-slate-500">
                        {source === 'shopify' 
                             ? 'Check your Shopify credentials.' 
                             : 'Amazon API might be rate limited or unavailable.'}
                    </p>
                    <button
                        onClick={() => fetchProducts()}
                        className="mt-4 rounded-lg bg-slate-700 px-4 py-2 text-sm text-white hover:bg-slate-600"
                    >
                        Try Again
                    </button>
                </div>
            ) : products.length === 0 ? (
                <div className="flex h-64 items-center justify-center rounded-xl border border-dashed border-slate-700 bg-slate-800/30 p-8 text-center">
                    <div>
                        <ShoppingBag className="mx-auto mb-3 h-10 w-10 text-slate-600" />
                        <p className="text-slate-400">No products found.</p>
                        <p className="mt-1 text-sm text-slate-500">
                            Try a different category or search term.
                        </p>
                    </div>
                </div>
            ) : (
                <>
                    <div className="grid grid-cols-2 gap-4 sm:grid-cols-3 lg:grid-cols-4">
                        {products.map((product) => (
                            <FurnitureCard
                                key={product.id}
                                product={product}
                                onSelect={handleProductClick}
                            />
                        ))}
                    </div>

                    {/* Load More */}
                    {(hasNextPage || (source === 'amazon' && products.length > 0)) && (
                        <div className="flex justify-center pt-6">
                            <button
                                onClick={loadMore}
                                disabled={isLoading}
                                className="rounded-lg bg-slate-800 px-6 py-2 text-white hover:bg-slate-700 disabled:opacity-50"
                            >
                                {isLoading ? (
                                    <span className="flex items-center gap-2">
                                        <Loader2 className="h-4 w-4 animate-spin" />
                                        Loading...
                                    </span>
                                ) : (
                                    'Load More'
                                )}
                            </button>
                        </div>
                    )}
                </>
            )}
        </div>
    );
}
