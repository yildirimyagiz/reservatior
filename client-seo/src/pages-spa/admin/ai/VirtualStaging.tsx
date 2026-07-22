import Image from "next/image";
import React, { useState } from 'react';
import { m, AnimatePresence } from 'framer-motion';
import { Wand2, Image as ImageIcon, Upload, Loader2, SlidersHorizontal, ArrowRight, CheckCircle2 } from 'lucide-react';
import { useTranslation } from 'react-i18next';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';

const STYLES = ["Modern Minimalist", "Industrial Loft", "Scandinavian", "Mid-Century Modern", "Bohemian", "Coastal"];
const ROOM_TYPES = ["Living Room", "Bedroom", "Home Office", "Dining Room", "Kitchen"];

export default function VirtualStaging() {
  const { t } = useTranslation();
  const [selectedStyle, setSelectedStyle] = useState(STYLES[0]);
  const [selectedRoom, setSelectedRoom] = useState(ROOM_TYPES[0]);
  const [isGenerating, setIsGenerating] = useState(false);
  const [isGenerated, setIsGenerated] = useState(false);
  const [sliderPosition, setSliderPosition] = useState(50);

  const [uploadedImage, setUploadedImage] = useState<string | null>(null);
  
  // Dummy images for demo purposes
  const beforeImage = uploadedImage || "https://images.unsplash.com/photo-1616047006789-b7af5afb8c20?auto=format&fit=crop&q=80&w=1200"; // Empty room
  const afterImage = "https://images.unsplash.com/photo-1600210492486-724fe5c67fb0?auto=format&fit=crop&q=80&w=1200"; // Furnished room

  const handleFileUpload = (e: React.ChangeEvent<HTMLInputElement>) => {
    if (e.target.files && e.target.files[0]) {
      const reader = new FileReader();
      reader.onload = (event) => {
        setUploadedImage(event.target?.result as string);
        setIsGenerated(false); // Reset on new upload
      };
      reader.readAsDataURL(e.target.files[0]);
    }
  };

  const handleGenerate = () => {
    if (!uploadedImage && !beforeImage) return;
    setIsGenerating(true);
    
    // Simulate API call to RunPod endpoint
    setTimeout(() => {
      setIsGenerating(false);
      setIsGenerated(true);
      setSliderPosition(50);
    }, 3500);
  };

  return (
    <div className="p-6 md:p-8 space-y-8 animate-in fade-in duration-500">
      
      {/* Header */}
      <div>
        <h1 className="text-3xl font-black text-slate-900 dark:text-white tracking-tight flex items-center gap-3 bg-clip-text text-transparent bg-gradient-to-r from-slate-200 to-slate-500">
          <Wand2 className="w-8 h-8 text-blue-600" /> {t("admin_auto_virtual_staging_ai", "Virtual Staging AI")}</h1>
        <p className="text-slate-500 dark:text-slate-400 mt-1">{t("admin_auto_transform_empty_spaces_into_beautifully_", "Transform empty spaces into beautifully furnished properties using ControlNet and Stable Diffusion.")}</p>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-12 gap-8">
        
        {/* Left Panel: Controls */}
        <Card className="lg:col-span-4 border-none shadow-sm dark:bg-slate-900/50">
          <CardHeader>
            <CardTitle className="text-xl flex items-center gap-2">
              <SlidersHorizontal className="w-5 h-5 text-slate-500" /> {t("admin_auto_configuration", "Configuration")}</CardTitle>
          </CardHeader>
          <CardContent className="space-y-6">
            
            {/* Upload Area */}
            <div>
              <label className="block text-sm font-bold text-slate-700 dark:text-slate-300 mb-2">{t("admin_auto_source_image", "Source Image")}</label>
              <label className="border-2 border-dashed border-slate-300 dark:border-slate-700 rounded-xl p-6 flex flex-col items-center justify-center cursor-pointer hover:bg-slate-50 dark:hover:bg-slate-800/50 transition-colors">
                <Upload className="w-8 h-8 text-slate-400 mb-2" />
                <span className="text-sm text-slate-600 dark:text-slate-400 font-medium text-center">
                  {t("mobile.auto.click_to_upload_empty_room_photo", "Click to upload empty room photo")}</span>
                <input type="file" className="hidden" accept="image/*" onChange={handleFileUpload} />
              </label>
            </div>

            {/* Room Type */}
            <div>
              <label className="block text-sm font-bold text-slate-700 dark:text-slate-300 mb-2">{t("admin_auto_room_type", "Room Type")}</label>
              <div className="grid grid-cols-2 gap-2">
                {ROOM_TYPES.map(room => (
                  <button
                    key={room}
                    onClick={() => setSelectedRoom(room)}
                    className={`px-3 py-2 rounded-lg text-xs font-bold transition-colors ${
                      selectedRoom === room 
                        ? 'bg-blue-600 text-white shadow-md' 
                        : 'bg-slate-100 dark:bg-slate-800 text-slate-600 dark:text-slate-300 hover:bg-slate-200 dark:hover:bg-slate-700'
                    }`}
                  >
                    {room}
                  </button>
                ))}
              </div>
            </div>

            {/* Style Selection */}
            <div>
              <label className="block text-sm font-bold text-slate-700 dark:text-slate-300 mb-2">{t("admin_auto_design_style", "Design Style")}</label>
              <div className="grid grid-cols-2 gap-2">
                {STYLES.map(style => (
                  <button
                    key={style}
                    onClick={() => setSelectedStyle(style)}
                    className={`px-3 py-2 rounded-lg text-xs font-bold transition-colors ${
                      selectedStyle === style 
                        ? 'bg-purple-600 text-white shadow-md' 
                        : 'bg-slate-100 dark:bg-slate-800 text-slate-600 dark:text-slate-300 hover:bg-slate-200 dark:hover:bg-slate-700'
                    }`}
                  >
                    {style}
                  </button>
                ))}
              </div>
            </div>

            {/* Generate Button */}
            <button
              onClick={handleGenerate}
              disabled={isGenerating}
              className={`w-full py-3.5 rounded-xl font-bold text-white flex items-center justify-center gap-2 transition-all ${
                isGenerating 
                  ? 'bg-blue-400 cursor-not-allowed' 
                  : 'bg-blue-600 hover:bg-blue-700 shadow-lg shadow-blue-600/30 active:scale-95'
              }`}
            >
              {isGenerating ? (
                <><Loader2 className="w-5 h-5 animate-spin" /> {t("admin_auto_generating_design", "Generating Design...")}</>
              ) : (
                <><Wand2 className="w-5 h-5" /> {t("admin_auto_stage_property", "Stage Property")}</>
              )}
            </button>

          </CardContent>
        </Card>

        {/* Right Panel: Preview & Before/After */}
        <div className="lg:col-span-8 flex flex-col">
          <Card className="border-none shadow-sm dark:bg-slate-900/50 flex-1 overflow-hidden flex flex-col">
            <CardHeader className="flex flex-row items-center justify-between">
              <CardTitle className="text-xl flex items-center gap-2">
                <ImageIcon className="w-5 h-5 text-slate-500" /> {t("admin_documents_preview", "Preview")}</CardTitle>
              {isGenerated && (
                <button className="flex items-center gap-1.5 px-3 py-1.5 bg-emerald-100 dark:bg-emerald-900/30 text-emerald-700 dark:text-emerald-400 rounded-lg text-sm font-bold hover:bg-emerald-200 dark:hover:bg-emerald-900/50 transition-colors">
                  <CheckCircle2 className="w-4 h-4" /> {t("admin_auto_save_to_listing", "Save to Listing")}</button>
              )}
            </CardHeader>
            <CardContent className="flex-1 p-0 flex items-center justify-center bg-slate-50 dark:bg-slate-950/50 relative min-h-[400px]">
              
              {!isGenerated && !isGenerating && (
                <div className="text-center p-8">
                  {uploadedImage ? (
                    <Image src={uploadedImage} alt="Uploaded Empty Room" width={500} height={500} loading="lazy" sizes="500px" className="max-h-[500px] object-contain rounded-xl shadow-lg mx-auto" />
                  ) : (
                    <div className="flex flex-col items-center">
                      <ImageIcon className="w-16 h-16 text-slate-300 dark:text-slate-700 mb-4" />
                      <p className="text-slate-500 dark:text-slate-400 font-medium">{t("admin_auto_upload_an_image_and_click_stage_property", "Upload an image and click \"Stage Property\" to see the magic.")}</p>
                    </div>
                  )}
                </div>
              )}

              {isGenerating && (
                <div className="absolute inset-0 flex flex-col items-center justify-center bg-white/50 dark:bg-slate-950/50 backdrop-blur-sm z-10">
                  <m.div 
                    animate={{ rotate: 360 }}
                    transition={{ repeat: Infinity, duration: 2, ease: "linear" }}
                  >
                    <Wand2 className="w-12 h-12 text-blue-600 mb-4" />
                  </m.div>
                  <p className="text-lg font-bold text-slate-800 dark:text-slate-200">{t("admin_auto_ai_is_analyzing_spatial_geometry", "AI is analyzing spatial geometry...")}</p>
                  <div className="w-48 h-2 bg-slate-200 dark:bg-slate-800 rounded-full mt-4 overflow-hidden">
                    <m.div 
                      className="h-full bg-blue-600 rounded-full"
                      initial={{ width: "0%" }}
                      animate={{ width: "100%" }}
                      transition={{ duration: 3.5, ease: "easeInOut" }}
                    />
                  </div>
                </div>
              )}

              {isGenerated && !isGenerating && (
                <div className="relative w-full h-full min-h-[500px] select-none">
                  {/* After Image (Furnished) - Background */}
                  <div className="absolute inset-0 w-full h-full">
                    <Image src={afterImage} alt="Furnished Room" fill loading="lazy" className="object-cover" sizes="100vw" />
                  </div>
                  
                  {/* Before Image (Empty) - Foreground, clipped by slider */}
                  <div 
                    className="absolute inset-0 w-full h-full"
                    style={{ clipPath: `polygon(0 0, ${sliderPosition}% 0, ${sliderPosition}% 100%, 0 100%)` }}
                  >
                    <Image src={beforeImage} alt="Empty Room" fill loading="lazy" className="object-cover grayscale" sizes="100vw" />
                  </div>

                  {/* Slider Control */}
                  <div 
                    className="absolute inset-y-0 flex items-center justify-center w-1 bg-white cursor-ew-resize hover:w-1.5 transition-all"
                    style={{ left: `calc(${sliderPosition}% - 2px)` }}
                  >
                    <div className="w-8 h-8 bg-white rounded-full shadow-lg flex items-center justify-center border border-slate-200">
                      <SlidersHorizontal className="w-4 h-4 text-slate-500" />
                    </div>
                  </div>

                  {/* Native Input Range overlay for dragging */}
                  <input
                    type="range"
                    min="0"
                    max="100"
                    value={sliderPosition}
                    onChange={(e) => setSliderPosition(parseInt(e.target.value))}
                    className="absolute inset-0 w-full h-full opacity-0 cursor-ew-resize z-20"
                  />

                  {/* Labels */}
                  <div className="absolute bottom-4 left-4 px-3 py-1 bg-black/60 backdrop-blur-md text-white text-xs font-bold rounded-full shadow-lg z-10 pointer-events-none">
                    {t("admin_security_before", "Before")}</div>
                  <div className="absolute bottom-4 right-4 px-3 py-1 bg-blue-600/90 backdrop-blur-md text-white text-xs font-bold rounded-full shadow-lg z-10 pointer-events-none">
                    {t("admin_auto_ai_staged", "AI Staged")}</div>
                </div>
              )}

            </CardContent>
          </Card>
        </div>

      </div>
    </div>
  );
}
