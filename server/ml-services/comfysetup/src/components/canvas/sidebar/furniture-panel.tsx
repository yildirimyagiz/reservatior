'use client';

import { useState, useEffect } from 'react';
import { Search, Loader2, ShoppingBag, ExternalLink, Filter, Sparkles, ChevronRight, Upload } from 'lucide-react';
import Image from 'next/image';
import { cn } from '@/lib/utils';
import type { ShopifyProduct } from '@/types';
import { useCanvasStore } from '@/lib/store/canvas-store';

interface FurnitureItem {
    id: string;
    title: string;
    imageUrl: string;
    price?: string;
    category: string;
    source: 'amazon' | 'shopify';
    shopifyProduct?: ShopifyProduct;
}

const MOCK_INVENTORY: FurnitureItem[] = [
    {
        id: '1',
        title: 'Mid-Century Velvet Sofa',
        imageUrl: 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=500&q=80',
        price: '$1,299',
        category: 'Seating',
        source: 'shopify'
    },
    {
        id: '2',
        title: 'Minimalist Oak Table',
        imageUrl: 'https://images.unsplash.com/photo-1533090161767-e6ffed986c88?w=500&q=80',
        price: '$850',
        category: 'Tables',
        source: 'amazon'
    },
    {
        id: '3',
        title: 'Industrial Floor Lamp',
        imageUrl: 'https://images.unsplash.com/photo-1507473885765-e6ed03442654?w=500&q=80',
        price: '$189',
        category: 'Lighting',
        source: 'amazon'
    },
    {
        id: '4',
        title: 'Art Deco Armchair',
        imageUrl: 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=500&q=80',
        price: '$450',
        category: 'Seating',
        source: 'shopify'
    },
    {
        id: '5',
        title: 'Nordic Bookshelf',
        imageUrl: 'https://images.unsplash.com/photo-1594620302200-9a762244a156?w=500&q=80',
        price: '$320',
        category: 'Storage',
        source: 'amazon'
    },
    {
        id: '6',
        title: 'Round Marble Coffee Table',
        imageUrl: 'https://images.unsplash.com/photo-1581428982868-e410dd047a90?w=500&q=80',
        price: '$580',
        category: 'Tables',
        source: 'shopify'
    }
];

export function FurniturePanel() {
    // State
    const { roomImage, setRoomImage, setSidePanelVisible } = useCanvasStore();
    const [activeTab, setActiveTab] = useState<'all' | 'amazon' | 'shopify'>('all');
    const [searchQuery, setSearchQuery] = useState('');
    const [products, setProducts] = useState<FurnitureItem[]>([]);
    const [amazonProducts, setAmazonProducts] = useState<FurnitureItem[]>([]);
    const [isLoading, setIsLoading] = useState(false);

    // Fetch Amazon products
    const fetchAmazonProducts = async (query: string = '') => {
        try {
            const response = await fetch(`/api/amazon/search?category=furniture&q=${encodeURIComponent(query)}&limit=20`);
            if (!response.ok) {
                throw new Error('API error');
            }
            const data = await response.json();
            const transformed: FurnitureItem[] = data.products.map((product: unknown) => {
                const p = product as {
                    id: string;
                    title: string;
                    image?: { url?: string };
                    price?: { amount?: string };
                };
                return {
                    id: p.id,
                    title: p.title,
                    imageUrl: p.image?.url || 'https://via.placeholder.com/500x500?text=No+Image',
                    price: `$${p.price?.amount || '0'}`,
                    category: 'Furniture',
                    source: 'amazon',
                    shopifyProduct: p as ShopifyProduct
                };
            });
            setAmazonProducts(transformed);
        } catch (error) {
            console.error('Failed to fetch Amazon products:', error);
        }
    };

    // Filtering and fetching logic
    useEffect(() => {
        setIsLoading(true);
        const timer = setTimeout(async () => {
            const trimmedQuery = searchQuery.toLowerCase().trim();

            // Always have mock shopify products
            const shopifyFiltered = MOCK_INVENTORY.filter(item => item.source === 'shopify');

            let amazonFiltered: FurnitureItem[] = [];
            if (activeTab === 'all' || activeTab === 'amazon') {
                if (amazonProducts.length === 0 || trimmedQuery !== '') {
                    await fetchAmazonProducts(trimmedQuery);
                }
                amazonFiltered = amazonProducts.filter(item =>
                    item.title.toLowerCase().includes(trimmedQuery) ||
                    item.category.toLowerCase().includes(trimmedQuery)
                );
            }

            let combined = [...shopifyFiltered, ...amazonFiltered];
            if (activeTab === 'amazon') {
                combined = amazonFiltered;
            } else if (activeTab === 'shopify') {
                combined = shopifyFiltered;
            }

            setProducts(combined);
            setIsLoading(false);
        }, 300);
        return () => clearTimeout(timer);
    }, [searchQuery, activeTab, amazonProducts]);

    const handleDragStart = (e: React.DragEvent, item: FurnitureItem) => {
        e.dataTransfer.setData('application/furniture', JSON.stringify({
            title: item.title,
            imageUrl: item.imageUrl,
            shopifyProduct: item.shopifyProduct
        }));
    };

    const handleUploadClick = () => {
        const input = document.createElement('input');
        input.type = 'file';
        input.accept = 'image/*';
        input.onchange = (e) => {
            const file = (e.target as HTMLInputElement).files?.[0];
            if (!file) return;
            const reader = new FileReader();
            reader.onload = (event) => {
                setRoomImage(event.target?.result as string, file.name);
            };
            reader.readAsDataURL(file);
        };
        input.click();
    };

    if (!roomImage) {
        return (
            <div className="flex h-full flex-col items-center justify-center p-8 bg-[#0b0f1a] text-center">
                <div className="w-16 h-16 rounded-3xl bg-slate-900/50 border border-white/5 flex items-center justify-center mb-6 opacity-20">
                    <ShoppingBag className="h-8 w-8 text-slate-400" />
                </div>
                <h3 className="text-xs font-black text-slate-500 uppercase tracking-[0.2em] mb-2">Space Not Calibrated</h3>
                <p className="text-[10px] text-slate-600 font-medium max-w-[200px] leading-relaxed uppercase tracking-widest mb-8">
                    Please upload a room image to start browsing our asset library.
                </p>
                <button
                    onClick={handleUploadClick}
                    className="bg-white text-black px-6 py-3 rounded-2xl font-black text-[10px] uppercase tracking-widest hover:bg-purple-100 transition-all flex items-center gap-2 shadow-xl"
                >
                    <Upload className="h-4 w-4" />
                    Upload Room
                </button>
            </div>
        );
    }

    return (
        <div className="flex h-full flex-col bg-[#0b0f1a] text-white overflow-hidden relative">
            {/* Header: Search & Filter */}
            <div className="sticky top-0 z-10 space-y-5 bg-gradient-to-b from-[#1e293b]/50 to-[#0b0f1a] p-6 pt-7 shadow-2xl border-b border-white/5">
                <button
                    onClick={() => setSidePanelVisible(false)}
                    className="absolute top-4 right-4 p-2 rounded-xl bg-white/5 border border-white/5 text-slate-500 hover:text-white hover:bg-white/10 transition-all z-20 group/close"
                >
                    <ChevronRight className="h-4 w-4 group-hover/close:translate-x-0.5 transition-transform" />
                </button>
                <div className="flex items-center justify-between mb-4">
                    <h2 className="text-sm font-black uppercase tracking-[0.2em] text-purple-400">Assets Library</h2>
                    <span className="text-[10px] font-bold text-slate-500 uppercase tracking-widest">{products.length} Items</span>
                </div>

                <div className="relative group">
                    <Search className="absolute left-4 top-1/2 -translate-y-1/2 h-4 w-4 text-slate-600 group-focus-within:text-purple-400 transition-colors" />
                    <input
                        type="search"
                        placeholder="Search items, brands, styles..."
                        value={searchQuery}
                        onChange={(e) => setSearchQuery(e.target.value)}
                        className="w-full bg-[#020617]/50 border border-white/5 rounded-2xl py-3.5 pl-11 pr-4 text-xs font-medium focus:outline-none focus:ring-2 focus:ring-purple-500/30 focus:border-purple-500/50 transition-all placeholder:text-slate-700 placeholder:uppercase placeholder:tracking-widest placeholder:text-[9px]"
                    />
                </div>

                <div className="flex p-1 bg-slate-900/50 rounded-[1.25rem] border border-white/5">
                    {(['all', 'amazon', 'shopify'] as const).map((tab) => (
                        <button
                            key={tab}
                            onClick={() => setActiveTab(tab)}
                            className={cn(
                                "flex-1 py-2 text-[10px] font-black uppercase tracking-widest rounded-2xl transition-all duration-300",
                                activeTab === tab
                                    ? "bg-white text-black shadow-lg"
                                    : "text-slate-500 hover:text-white"
                            )}
                        >
                            {tab}
                        </button>
                    ))}
                </div>
            </div>

            {/* Inventory Grid */}
            <div className="flex-1 overflow-y-auto p-5 scrollbar-thin">
                {isLoading ? (
                    <div className="flex flex-col items-center justify-center h-64 opacity-20">
                        <Loader2 className="h-8 w-8 animate-spin text-purple-400 mb-4" />
                        <span className="text-[10px] font-black uppercase tracking-widest">Scanning Catalog...</span>
                    </div>
                ) : products.length > 0 ? (
                    <div className="grid grid-cols-2 gap-4">
                        {products.map((item) => (
                            <div
                                key={item.id}
                                draggable
                                onDragStart={(e) => handleDragStart(e, item)}
                                className="group bg-slate-900/40 border border-white/5 rounded-[2rem] p-1 pb-4 hover:bg-slate-900/60 hover:border-purple-500/30 transition-all duration-500 cursor-grab active:cursor-grabbing hover:shadow-2xl hover:shadow-purple-900/10"
                            >
                                <div className="aspect-square relative rounded-[1.75rem] overflow-hidden bg-[#020617] mb-3">
                                    <Image
                                        src={item.imageUrl}
                                        alt={item.title}
                                        fill
                                        className="object-cover group-hover:scale-110 transition-transform duration-700 opacity-80 group-hover:opacity-100"
                                    />
                                    <div className="absolute top-2 right-2 px-2 py-1 bg-black/60 backdrop-blur-md rounded-full border border-white/5 flex items-center gap-1">
                                        <Sparkles className="h-2.5 w-2.5 text-purple-400" />
                                        <span className="text-[8px] font-black text-white uppercase tracking-tighter">AI Ready</span>
                                    </div>
                                    {/* Drag Hint */}
                                    <div className="absolute inset-0 bg-black/40 opacity-0 group-hover:opacity-100 transition-opacity flex items-center justify-center">
                                        <span className="bg-white text-black px-3 py-1.5 rounded-full text-[8px] font-black uppercase tracking-widest translate-y-2 group-hover:translate-y-0 transition-transform duration-500">Drag to Stage</span>
                                    </div>
                                </div>
                                <div className="px-3 pt-1">
                                    <p className="text-[10px] font-black text-slate-200 truncate uppercase tracking-tight group-hover:text-purple-400 transition-colors">{item.title}</p>
                                    <div className="flex items-center justify-between mt-2">
                                        <span className="text-[10px] font-bold text-slate-500">{item.price}</span>
                                        <div className="flex items-center gap-2">
                                            <div className="flex items-center gap-1 text-[8px] font-bold text-slate-600 uppercase tracking-tighter bg-white/5 px-2 py-0.5 rounded-full">
                                                {item.source === 'shopify' ? <ShoppingBag className="h-2.5 w-2.5 text-emerald-400" /> : <ExternalLink className="h-2.5 w-2.5 text-blue-400" />}
                                                {item.source}
                                            </div>
                                            {item.source === 'amazon' && (
                                                <button
                                                    onClick={(e) => {
                                                        e.stopPropagation();
                                                        // Open Amazon product page (construct URL using ASIN)
                                                        const asin = item.shopifyProduct?.id;
                                                        if (asin) {
                                                            window.open(`https://www.amazon.com/dp/${asin}`, '_blank');
                                                        }
                                                    }}
                                                    className="text-[8px] font-bold text-purple-400 hover:text-purple-300 uppercase tracking-tighter bg-purple-500/10 hover:bg-purple-500/20 px-2 py-0.5 rounded-full transition-colors"
                                                >
                                                    Buy
                                                </button>
                                            )}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        ))}
                    </div>
                ) : (
                    <div className="flex flex-col items-center justify-center h-64 text-center">
                        <Filter className="h-8 w-8 text-slate-800 mb-4" />
                        <h4 className="text-[11px] font-black text-slate-500 uppercase tracking-widest mb-1">No matches found</h4>
                        <p className="text-[9px] text-slate-700 font-bold uppercase tracking-tight">Try adjusting your filters or search query</p>
                    </div>
                )}
            </div>

            {/* Premium Bottom Note */}
            <div className="p-4 bg-slate-900/20 border-t border-white/5 flex items-center gap-3">
                <div className="w-8 h-8 rounded-xl bg-purple-500/10 border border-purple-500/20 flex items-center justify-center text-purple-400">
                    <ShoppingBag className="h-3.5 w-3.5" />
                </div>
                <div>
                    <p className="text-[9px] font-black text-slate-400 uppercase tracking-widest mb-0.5">Commercial Ready</p>
                    <p className="text-[9px] text-slate-600 font-bold leading-tight uppercase tracking-tighter">Direct checkout support for active listings.</p>
                </div>
            </div>
        </div>
    );
}
