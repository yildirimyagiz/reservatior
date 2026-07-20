import React, { useState } from 'react';
import { motion } from 'framer-motion';
import { Sparkles, Image as ImageIcon, Camera, RefreshCw, ShoppingCart, Layers } from 'lucide-react';
import { useTranslation } from 'react-i18next';
import { Card, CardContent } from '@/components/ui/card';

const PACKAGES = [
  { id: 'pkg-1', name: 'Scandi Minimal', price: '$2,400', tags: ['Light Wood', 'Neutral', 'Airy'], img: 'https://images.unsplash.com/photo-1554995207-c18c203602cb?auto=format&fit=crop&q=80&w=400' },
  { id: 'pkg-2', name: 'Industrial Edge', price: '$3,100', tags: ['Metal', 'Leather', 'Dark'], img: 'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?auto=format&fit=crop&q=80&w=400' },
  { id: 'pkg-3', name: 'Mid-Century', price: '$2,850', tags: ['Walnut', 'Retro', 'Warm'], img: 'https://images.unsplash.com/photo-1593784991095-a205069470b6?auto=format&fit=crop&q=80&w=400' },
];

export default function AIDesignStudio() {
  const { t } = useTranslation();
  const [selectedPackage, setSelectedPackage] = useState(PACKAGES[0]);
  const [isGenerating, setIsGenerating] = useState(false);
  const [generatedImage, setGeneratedImage] = useState<string | null>(null);

  const handleGenerate = () => {
    setIsGenerating(true);
    setGeneratedImage(null);
    
    // Simulate AI generation process matching the selected package
    setTimeout(() => {
      setIsGenerating(false);
      // Dummy generated result based on package selection
      setGeneratedImage(selectedPackage.img.replace('w=400', 'w=1200')); 
    }, 4000);
  };

  return (
    <div className="min-h-screen bg-slate-50 dark:bg-[#050505] text-slate-900 dark:text-slate-100 p-6 md:p-12 font-sans">
      
      {/* Header */}
      <motion.div 
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        className="mb-12 text-center max-w-3xl mx-auto"
      >
        <div className="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-purple-100 dark:bg-purple-900/30 text-purple-700 dark:text-purple-400 font-bold text-sm mb-6">
          <Sparkles className="w-4 h-4" /> Powered by ControlNet AI
        </div>
        <h1 className="text-4xl md:text-5xl font-black tracking-tight mb-4">Style Refresh Studio</h1>
        <p className="text-lg text-slate-600 dark:text-slate-400 leading-relaxed">
          Bored of your current setup? Snap a photo of your empty room and visualize our premium furniture packages in your space before committing to a style refresh.
        </p>
      </motion.div>

      <div className="grid grid-cols-1 lg:grid-cols-12 gap-8 max-w-7xl mx-auto">
        
        {/* Left: Packages & Controls */}
        <div className="lg:col-span-4 space-y-6">
          
          <div className="bg-white dark:bg-slate-900/50 rounded-3xl p-6 border border-slate-200 dark:border-slate-800 shadow-xl">
            <h3 className="text-xl font-bold mb-4 flex items-center gap-2">
              <Layers className="w-5 h-5 text-blue-600" /> Choose a Vibe
            </h3>
            
            <div className="space-y-4">
              {PACKAGES.map(pkg => (
                <div 
                  key={pkg.id}
                  onClick={() => setSelectedPackage(pkg)}
                  className={`relative p-4 rounded-2xl border-2 transition-all cursor-pointer overflow-hidden group ${
                    selectedPackage.id === pkg.id 
                      ? 'border-blue-600 bg-blue-50/50 dark:bg-blue-900/10' 
                      : 'border-transparent hover:border-slate-200 dark:hover:border-slate-700 bg-slate-50 dark:bg-slate-800/50'
                  }`}
                >
                  <div className="flex gap-4 relative z-10">
                    <img src={pkg.img} alt={pkg.name} className="w-20 h-20 rounded-xl object-cover" />
                    <div>
                      <h4 className="font-bold text-slate-900 dark:text-white">{pkg.name}</h4>
                      <p className="text-sm font-black text-blue-600 dark:text-blue-400 mt-1">{pkg.price} <span className="text-xs font-normal text-slate-500">one-time</span></p>
                      <div className="flex gap-1 mt-2 flex-wrap">
                        {pkg.tags.map(tag => (
                          <span key={tag} className="text-[10px] uppercase font-bold bg-white dark:bg-black/50 px-2 py-0.5 rounded-full text-slate-500">
                            {tag}
                          </span>
                        ))}
                      </div>
                    </div>
                  </div>
                  {selectedPackage.id === pkg.id && (
                    <div className="absolute top-0 right-0 p-3">
                      <div className="w-3 h-3 bg-blue-600 rounded-full animate-pulse" />
                    </div>
                  )}
                </div>
              ))}
            </div>
          </div>

          <button
            onClick={handleGenerate}
            disabled={isGenerating}
            className={`w-full py-4 rounded-2xl font-black text-white flex items-center justify-center gap-2 transition-all ${
              isGenerating 
                ? 'bg-purple-400 cursor-not-allowed' 
                : 'bg-purple-600 hover:bg-purple-700 shadow-xl shadow-purple-600/30 active:scale-95 hover:-translate-y-1'
            }`}
          >
            {isGenerating ? (
              <><RefreshCw className="w-5 h-5 animate-spin" /> Visualizing Space...</>
            ) : (
              <><Sparkles className="w-5 h-5" /> Generate My Room</>
            )}
          </button>

        </div>

        {/* Right: AI Canvas */}
        <div className="lg:col-span-8">
          <Card className="border-none shadow-2xl dark:bg-slate-900/50 h-full min-h-[500px] overflow-hidden rounded-3xl relative">
            <CardContent className="p-0 h-full flex flex-col items-center justify-center bg-slate-100 dark:bg-black/50 relative">
              
              {!isGenerating && !generatedImage && (
                <div className="text-center p-8">
                  <div className="w-24 h-24 bg-white dark:bg-slate-800 rounded-full flex items-center justify-center mx-auto mb-6 shadow-lg">
                    <Camera className="w-10 h-10 text-slate-400" />
                  </div>
                  <h3 className="text-2xl font-bold mb-2">Upload your room</h3>
                  <p className="text-slate-500 dark:text-slate-400 mb-6 max-w-sm mx-auto">
                    Take a photo of your empty living room or bedroom. Our AI will automatically map the walls, windows, and floors.
                  </p>
                  <label className="inline-flex items-center gap-2 px-6 py-3 bg-white dark:bg-slate-800 text-slate-900 dark:text-white font-bold rounded-full shadow-md cursor-pointer hover:scale-105 transition-transform">
                    <ImageIcon className="w-5 h-5" /> Browse Photo
                    <input type="file" className="hidden" accept="image/*" />
                  </label>
                </div>
              )}

              {isGenerating && (
                <div className="text-center z-10">
                  <motion.div 
                    animate={{ scale: [1, 1.2, 1], rotate: [0, 180, 360] }}
                    transition={{ repeat: Infinity, duration: 3, ease: "easeInOut" }}
                    className="w-20 h-20 border-4 border-purple-500/30 border-t-purple-600 rounded-full mx-auto mb-6"
                  />
                  <h3 className="text-2xl font-bold text-slate-800 dark:text-slate-200">Applying {selectedPackage.name}...</h3>
                  <p className="text-slate-500 mt-2">ControlNet is preserving your room's geometry.</p>
                </div>
              )}

              {generatedImage && !isGenerating && (
                <motion.div 
                  initial={{ opacity: 0 }}
                  animate={{ opacity: 1 }}
                  className="w-full h-full relative"
                >
                  <img src={generatedImage} alt="AI Generated Room" className="w-full h-full object-cover" />
                  
                  {/* Floating Action Button */}
                  <div className="absolute bottom-8 left-1/2 -translate-x-1/2">
                    <button className="flex items-center gap-2 px-8 py-4 bg-black/90 backdrop-blur-md text-white rounded-full font-black text-lg shadow-2xl hover:scale-105 transition-transform">
                      <ShoppingCart className="w-5 h-5" /> Order Refresh
                    </button>
                  </div>
                </motion.div>
              )}

            </CardContent>
          </Card>
        </div>

      </div>
    </div>
  );
}
