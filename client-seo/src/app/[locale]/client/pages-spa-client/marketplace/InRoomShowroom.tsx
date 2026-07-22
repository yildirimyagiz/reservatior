import Image from "next/image";
import React, { useState } from 'react';
import { m, AnimatePresence } from 'framer-motion';
import { ShoppingCart, Star, ExternalLink, Info, CheckCircle2, PackageOpen, Zap, Tag } from 'lucide-react';
import { useTranslation } from 'react-i18next';

// Mock Data
const ROOM_ITEMS = [
  {
    id: 1,
    name: "Herman Miller Aeron Chair",
    category: "Workspace",
    price: "$1,200",
    amazonLink: "#",
    image: "https://images.unsplash.com/photo-1505843490538-5133c6c7d0e1?auto=format&fit=crop&q=80&w=800",
    rating: 4.8,
    reviews: 1240,
    tags: ["Ergonomic", "Premium"],
    description: "The ultimate ergonomic chair you are currently sitting on. Designed for comfort and posture."
  },
  {
    id: 2,
    name: "Nespresso Creatista Plus",
    category: "Kitchen",
    price: "$650",
    amazonLink: "#",
    image: "https://images.unsplash.com/photo-1520209268518-aec60b8bb5ca?auto=format&fit=crop&q=80&w=800",
    rating: 4.9,
    reviews: 3200,
    tags: ["Coffee", "Smart"],
    description: "Brew café-quality coffee every morning right from your suite's kitchen."
  },
  {
    id: 3,
    name: "Sony A95K OLED 65\"",
    category: "Living Room",
    price: "$2,400",
    amazonLink: "#",
    image: "https://images.unsplash.com/photo-1593784991095-a205069470b6?auto=format&fit=crop&q=80&w=800",
    rating: 4.9,
    reviews: 840,
    tags: ["4K", "OLED", "Entertainment"],
    description: "Experience the vibrant colors and deep blacks on the television in your living area."
  },
  {
    id: 4,
    name: "Casper Wave Hybrid Snow Mattress",
    category: "Bedroom",
    price: "$2,895",
    amazonLink: "#",
    image: "https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?auto=format&fit=crop&q=80&w=800",
    rating: 4.7,
    reviews: 1560,
    tags: ["Cooling", "Support"],
    description: "The mattress ensuring your perfect night's sleep. Features advanced cooling technology."
  }
];

const CATEGORIES = ["All", "Workspace", "Kitchen", "Living Room", "Bedroom"];

export default function InRoomShowroom() {
  const { t } = useTranslation();
  const [activeCategory, setActiveCategory] = useState("All");
  const [selectedItem, setSelectedItem] = useState<number | null>(null);

  const filteredItems = activeCategory === "All" 
    ? ROOM_ITEMS 
    : ROOM_ITEMS.filter(item => item.category === activeCategory);

  return (
    <div className="min-h-screen bg-slate-50 dark:bg-[#050505] text-slate-900 dark:text-slate-100 p-6 md:p-12 font-sans">
      
      {/* Header Section */}
      <m.div 
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        className="mb-12"
      >
        <div className="flex items-center gap-3 mb-4">
          <div className="w-12 h-12 rounded-full bg-blue-100 dark:bg-blue-900/30 flex items-center justify-center text-blue-600 dark:text-blue-400">
            <PackageOpen className="w-6 h-6" />
          </div>
          <h1 className="text-4xl md:text-5xl font-black tracking-tight">In-Room Showroom</h1>
        </div>
        <p className="text-lg text-slate-600 dark:text-slate-400 max-w-2xl leading-relaxed">
          Love what you see? Every piece of furniture and appliance in your suite is carefully curated. Purchase them directly via Amazon and have them delivered to your home.
        </p>
      </m.div>

      {/* Category Filter */}
      <div className="flex flex-wrap gap-3 mb-8">
        {CATEGORIES.map(category => (
          <button
            key={category}
            onClick={() => setActiveCategory(category)}
            className={`px-6 py-2.5 rounded-full text-sm font-bold transition-all duration-300 ${
              activeCategory === category 
                ? 'bg-blue-600 text-white shadow-lg shadow-blue-500/25' 
                : 'bg-white dark:bg-slate-800/50 text-slate-600 dark:text-slate-400 hover:bg-slate-100 dark:hover:bg-slate-800 border border-slate-200 dark:border-slate-800'
            }`}
          >
            {category}
          </button>
        ))}
      </div>

      {/* Grid */}
      <m.div layout className="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-6">
        <AnimatePresence>
          {filteredItems.map(item => (
            <m.div
              layout
              initial={{ opacity: 0, scale: 0.9 }}
              animate={{ opacity: 1, scale: 1 }}
              exit={{ opacity: 0, scale: 0.9 }}
              key={item.id}
              className="group bg-white dark:bg-slate-900/50 rounded-3xl overflow-hidden border border-slate-200 dark:border-slate-800/60 hover:border-blue-500/50 dark:hover:border-blue-500/50 transition-all duration-500 hover:shadow-2xl hover:shadow-blue-500/10 flex flex-col"
            >
              {/* Image Container */}
              <div className="relative h-64 overflow-hidden bg-slate-100 dark:bg-slate-800">
                <Image 
                  src={item.image} 
                  alt={item.name} 
                  fill
                  loading="lazy"
                  className="object-cover group-hover:scale-105 transition-transform duration-700"
                  sizes="400px"
                />
                <div className="absolute top-4 left-4 flex gap-2">
                  <span className="px-3 py-1 rounded-full bg-white/90 dark:bg-black/80 backdrop-blur-md text-xs font-bold flex items-center gap-1 shadow-sm">
                    <Tag className="w-3 h-3 text-blue-500" />
                    {item.category}
                  </span>
                </div>
                <div className="absolute top-4 right-4 bg-white/90 dark:bg-black/80 backdrop-blur-md px-3 py-1 rounded-full flex items-center gap-1 shadow-sm">
                  <Star className="w-3.5 h-3.5 fill-amber-500 text-amber-500" />
                  <span className="text-xs font-bold">{item.rating}</span>
                </div>
              </div>

              {/* Content */}
              <div className="p-6 flex-1 flex flex-col">
                <div className="flex justify-between items-start mb-2">
                  <h3 className="text-xl font-bold leading-tight group-hover:text-blue-600 dark:group-hover:text-blue-400 transition-colors">
                    {item.name}
                  </h3>
                  <span className="text-xl font-black text-slate-900 dark:text-white">{item.price}</span>
                </div>
                
                <p className="text-sm text-slate-500 dark:text-slate-400 mb-6 flex-1 line-clamp-2">
                  {item.description}
                </p>

                {/* Tags */}
                <div className="flex flex-wrap gap-2 mb-6">
                  {item.tags.map(tag => (
                    <span key={tag} className="px-2.5 py-1 rounded-md bg-slate-100 dark:bg-slate-800/50 text-xs font-medium text-slate-600 dark:text-slate-300">
                      {tag}
                    </span>
                  ))}
                </div>

                {/* Actions */}
                <div className="flex items-center gap-3 mt-auto">
                  <a 
                    href={item.amazonLink}
                    target="_blank"
                    rel="noreferrer"
                    className="flex-1 flex items-center justify-center gap-2 bg-slate-900 dark:bg-white text-white dark:text-slate-900 hover:bg-slate-800 dark:hover:bg-slate-100 py-3 rounded-xl font-bold transition-all hover:scale-[1.02] active:scale-95"
                  >
                    <ShoppingCart className="w-4 h-4" />
                    Buy on Amazon
                  </a>
                  <button 
                    onClick={() => setSelectedItem(selectedItem === item.id ? null : item.id)}
                    aria-label="More info"
                    className="w-12 h-12 flex items-center justify-center rounded-xl bg-slate-100 dark:bg-slate-800 hover:bg-blue-50 dark:hover:bg-blue-900/30 text-slate-600 dark:text-slate-300 hover:text-blue-600 dark:hover:text-blue-400 transition-colors"
                  >
                    <Info className="w-5 h-5" />
                  </button>
                </div>

                {/* Expandable Info */}
                <AnimatePresence>
                  {selectedItem === item.id && (
                    <m.div
                      initial={{ opacity: 0, height: 0, marginTop: 0 }}
                      animate={{ opacity: 1, height: 'auto', marginTop: 16 }}
                      exit={{ opacity: 0, height: 0, marginTop: 0 }}
                      className="overflow-hidden"
                    >
                      <div className="p-4 rounded-xl bg-blue-50 dark:bg-blue-900/10 border border-blue-100 dark:border-blue-900/30">
                        <h4 className="text-sm font-bold text-blue-900 dark:text-blue-300 mb-2 flex items-center gap-1">
                          <CheckCircle2 className="w-4 h-4" /> Affiliate Notice
                        </h4>
                        <p className="text-xs text-blue-800/80 dark:text-blue-200/70 leading-relaxed">
                          Purchasing this item via the link above supports our ecosystem. As an Amazon Associate, Reservatior earns from qualifying purchases. This specific item is currently deployed in your suite for your trial.
                        </p>
                      </div>
                    </m.div>
                  )}
                </AnimatePresence>

              </div>
            </m.div>
          ))}
        </AnimatePresence>
      </m.div>

    </div>
  );
}
