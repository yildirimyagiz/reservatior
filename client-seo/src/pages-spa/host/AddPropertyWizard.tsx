"use client";

import { useState, useRef } from "react";
import { useNavigate, useLocation } from "@/lib/react-router-shim";
import { motion, AnimatePresence } from "framer-motion";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Checkbox } from "@/components/ui/checkbox";
import { useToast } from "@/hooks/use-toast";
import { apiClient } from "@/lib/api/client";
import { Building, Bed, Bath, ShieldCheck, ChevronRight, Building2, Home as HomeIcon, Upload, X, Loader2 } from "lucide-react";


const steps = [
  { id: "intro", title: "Temel Bilgiler" },
  { id: "details", title: "Özellikler" },
  { id: "pricing", title: "Fiyatlandırma & Güvence" },
  { id: "media", title: "Görseller" },
  { id: "review", title: "Yayına Al" }
];

export default function AddPropertyWizard() {
  const [currentStep, setCurrentStep] = useState(0);
  const [isLoading, setIsLoading] = useState(false);
  const navigate = useNavigate();
  const { toast } = useToast();

  const location = useLocation();
  const searchParams = new URLSearchParams(location.search);
  const initialListingType = searchParams.get("type") || "BOOKING";

  const [formData, setFormData] = useState<any>({
    name: "",
    type: "APARTMENT",
    listingType: initialListingType,
    city: "",
    addressLine1: "",
    bedrooms: 1,
    bathrooms: 1,
    areaSqm: 50,
    listingPrice: 100,
    currency: "USD",
    acceptsEscrow: initialListingType !== "BOOKING", // only require escrow for booking
    listingStatus: "AVAILABLE",
    photos: []
  });

  const [uploadingPhotos, setUploadingPhotos] = useState(false);
  const [mlProcessing, setMlProcessing] = useState(false);
  const fileInputRef = useRef<HTMLInputElement>(null);

  const handleNext = () => {
    if (currentStep < steps.length - 1) setCurrentStep(prev => prev + 1);
  };

  const handlePrev = () => {
    if (currentStep > 0) {
      setCurrentStep(prev => prev - 1);
    } else {
      navigate("/admin/properties");
    }
  };

  const handlePhotoUpload = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const files = e.target.files;
    if (!files?.length) return;
    setUploadingPhotos(true);
    try {
      for (const file of Array.from(files)) {
        const form = new FormData();
        form.append("file", file);
        form.append("category", "images");
        form.append("type", "PROPERTY_PHOTO");
        form.append("propertyType", formData.type);
        const result = await apiClient.post("/media/upload", form, {
          headers: { "Content-Type": "multipart/form-data" },
        }) as any;
        const photo = result?.data || result;
        setFormData((prev: any) => ({
          ...prev,
          photos: [...prev.photos, { url: photo.url, id: photo.id, name: photo.originalName }],
        }));
      }
      toast({ title: "Fotoğraflar yüklendi", description: `${files.length} fotoğraf başarıyla yüklendi.` });
    } catch (err: any) {
      toast({ title: "Yükleme hatası", description: err.message || "Fotoğraflar yüklenirken hata oluştu.", variant: "destructive" });
    } finally {
      setUploadingPhotos(false);
      if (fileInputRef.current) fileInputRef.current.value = "";
    }
  };

  const removePhoto = (index: number) => {
    setFormData((prev: any) => ({
      ...prev,
      photos: prev.photos.filter((_: any, i: number) => i !== index),
    }));
  };

  const triggerMlProcessing = async (photoUrls: string[]) => {
    setMlProcessing(true);
    const processorUrl = process.env.NEXT_PUBLIC_ML_API_URL || "http://localhost:8080";
    const processed: string[] = [];
    for (const url of photoUrls) {
      try {
        await fetch(`${processorUrl}/skipper/tasks`, {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            workflow: "image-process",
            data: { image_path: url, resize: true, thumbnail: true },
          }),
        });
        processed.push(url);
      } catch {
        // ml service unavailable, continue with raw photos
      }
    }
    setMlProcessing(false);
    return processed;
  };

  const handleSubmit = async () => {
    if (formData.listingType === "BOOKING" && !formData.acceptsEscrow) {
      toast({ title: "Uyarı", description: "SafeStay™ sözleşmesini onaylamanız gerekmektedir.", variant: "destructive" });
      return;
    }
    setIsLoading(true);
    try {
      const photoUrls = formData.photos.map((p: any) => p.url);
      toast({ title: "ML İşleme", description: `${photoUrls.length} fotoğraf ml-services ile işleniyor...` });
      await triggerMlProcessing(photoUrls);
      const result = await apiClient.post("/property", {
        name: formData.name,
        type: formData.type,
        listingType: formData.listingType,
        city: formData.city,
        addressLine1: formData.addressLine1 || "Girilmedi",
        bedrooms: formData.bedrooms,
        bathrooms: formData.bathrooms,
        areaSqm: formData.areaSqm,
        listingPrice: formData.listingPrice,
        listingStatus: formData.listingStatus,
        photos: photoUrls,
      }) as any;
      const propertyId = result?.data?.id || result?.id;
      if (propertyId && photoUrls.length > 0) {
        for (const url of photoUrls) {
          try {
            await apiClient.post("/property-photo", {
              url,
              propertyId,
              isPrimary: url === photoUrls[0],
            });
          } catch {
            // individual photo link failure is non-critical
          }
        }
      }
      toast({ title: "Tebrikler!", description: "Tesisiniz başarıyla eklendi ve incelemeye alındı." });
      navigate("/admin/properties");
    } catch (error: any) {
      toast({ title: "Hata", description: "Tesis eklenirken bir sorun oluştu.", variant: "destructive" });
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-[#0A0A0B] text-white flex flex-col">
      {/* Top Navigation */}
      <div className="h-20 border-b border-white/5 flex items-center justify-between px-8 bg-black/50 backdrop-blur-md sticky top-0 z-50">
        <div className="flex items-center gap-2">
          <Building2 className="w-8 h-8 text-emerald-500" />
          <span className="font-black text-xl tracking-tighter">Reservatior <span className="text-emerald-500">Host</span></span>
        </div>
        <Button variant="ghost" onClick={() => navigate("/admin/properties")} className="text-white/50 hover:text-white">İptal ve Çık</Button>
      </div>

      {/* Progress Bar */}
      <div className="h-1 bg-white/5 w-full">
        <motion.div 
          className="h-full bg-emerald-500"
          initial={{ width: "0%" }}
          animate={{ width: `${((currentStep + 1) / steps.length) * 100}%` }}
          transition={{ duration: 0.3 }}
        />
      </div>

      {/* Main Content Area */}
      <div className="flex-1 flex flex-col items-center justify-center p-6 sm:p-12">
        <div className="w-full max-w-2xl relative min-h-[500px]">
          <AnimatePresence mode="wait">
            <motion.div
              key={currentStep}
              initial={{ opacity: 0, x: 20 }}
              animate={{ opacity: 1, x: 0 }}
              exit={{ opacity: 0, x: -20 }}
              transition={{ duration: 0.3 }}
              className="absolute inset-0 flex flex-col justify-center"
            >
              
              {/* STEP 1: INTRO */}
              {currentStep === 0 && (
                <div className="space-y-8">
                  <div>
                    <h1 className="text-4xl font-black mb-2">Tesisinizden bahsedelim.</h1>
                    <p className="text-white/50">Müşterilerinizin tesisinizi bulması için temel bilgileri girelim.</p>
                  </div>
                  <div className="space-y-6">
                    <div className="space-y-2">
                      <Label className="text-white/70">Tesisinizin Adı</Label>
                      <Input 
                        placeholder="Örn: Sea View Luxury Villa" 
                        className="h-14 bg-white/5 border-white/10 text-lg"
                        value={formData.name}
                        onChange={(e) => setFormData({...formData, name: e.target.value})}
                      />
                    </div>
                    <div className="space-y-2">
                      <Label className="text-white/70">Tesis Tipi</Label>
                      <div className="grid grid-cols-2 gap-4">
                        {[
                          { id: 'HOTEL', label: 'Otel', icon: Building },
                          { id: 'VILLA', label: 'Villa', icon: HomeIcon },
                          { id: 'APARTMENT', label: 'Daire', icon: Building2 }
                        ].map((type) => (
                          <div 
                            key={type.id}
                            onClick={() => setFormData({...formData, type: type.id})}
                            className={`p-4 border rounded-2xl cursor-pointer transition-all flex flex-col gap-3 ${formData.type === type.id ? 'border-emerald-500 bg-emerald-500/10' : 'border-white/10 bg-white/5 hover:border-white/20'}`}
                          >
                            <type.icon className={`w-6 h-6 ${formData.type === type.id ? 'text-emerald-500' : 'text-white/50'}`} />
                            <span className="font-semibold">{type.label}</span>
                          </div>
                        ))}
                      </div>
                    </div>
                    <div className="space-y-2">
                      <Label className="text-white/70">Hangi Şehirde?</Label>
                      <Input 
                        placeholder="Örn: Istanbul, Turkey" 
                        className="h-14 bg-white/5 border-white/10 text-lg"
                        value={formData.city}
                        onChange={(e) => setFormData({...formData, city: e.target.value})}
                      />
                    </div>
                  </div>
                </div>
              )}

              {/* STEP 2: DETAILS */}
              {currentStep === 1 && (
                <div className="space-y-8">
                  <div>
                    <h1 className="text-4xl font-black mb-2">Detayları paylaşın.</h1>
                    <p className="text-white/50">Konukların ne beklemeleri gerektiğini bilmelerini sağlayın.</p>
                  </div>
                  <div className="space-y-6">
                    <div className="flex items-center justify-between p-4 border border-white/10 rounded-2xl bg-white/5">
                      <div className="flex items-center gap-4">
                        <Bed className="w-6 h-6 text-white/50" />
                        <span className="text-lg">Yatak Odası</span>
                      </div>
                      <div className="flex items-center gap-4">
                        <Button variant="outline" className="rounded-full w-10 h-10 p-0 border-white/10" onClick={() => setFormData({...formData, bedrooms: Math.max(1, formData.bedrooms - 1)})}>-</Button>
                        <span className="w-4 text-center font-bold text-lg">{formData.bedrooms}</span>
                        <Button variant="outline" className="rounded-full w-10 h-10 p-0 border-white/10" onClick={() => setFormData({...formData, bedrooms: formData.bedrooms + 1})}>+</Button>
                      </div>
                    </div>
                    <div className="flex items-center justify-between p-4 border border-white/10 rounded-2xl bg-white/5">
                      <div className="flex items-center gap-4">
                        <Bath className="w-6 h-6 text-white/50" />
                        <span className="text-lg">Banyo</span>
                      </div>
                      <div className="flex items-center gap-4">
                        <Button variant="outline" className="rounded-full w-10 h-10 p-0 border-white/10" onClick={() => setFormData({...formData, bathrooms: Math.max(1, formData.bathrooms - 1)})}>-</Button>
                        <span className="w-4 text-center font-bold text-lg">{formData.bathrooms}</span>
                        <Button variant="outline" className="rounded-full w-10 h-10 p-0 border-white/10" onClick={() => setFormData({...formData, bathrooms: formData.bathrooms + 1})}>+</Button>
                      </div>
                    </div>
                    <div className="space-y-2">
                      <Label className="text-white/70">Mülk Büyüklüğü (m²)</Label>
                      <Input 
                        type="number"
                        className="h-14 bg-white/5 border-white/10 text-lg"
                        value={formData.areaSqm}
                        onChange={(e) => setFormData({...formData, areaSqm: Number(e.target.value)})}
                      />
                    </div>
                  </div>
                </div>
              )}

              {/* STEP 3: PRICING & ESCROW */}
              {currentStep === 2 && (
                <div className="space-y-8">
                  <div>
                    <h1 className="text-4xl font-black mb-2">Fiyatınızı belirleyin.</h1>
                    <p className="text-white/50">
                      {formData.listingType === "SALE" ? "Mülkünüzün satış bedelini girin." : 
                       formData.listingType === "RENT" ? "Mülkünüzün aylık kira bedelini girin." : 
                       "Gecelik net fiyatınızı girin ve güvence sözleşmemizi onaylayın."}
                    </p>
                  </div>
                  <div className="space-y-6">
                    <div className="space-y-2">
                      <Label className="text-white/70">
                        {formData.listingType === "SALE" ? "Satış Fiyatı ($)" : 
                         formData.listingType === "RENT" ? "Aylık Kira ($)" : 
                         "Gecelik Fiyat ($)"}
                      </Label>
                      <Input 
                        type="number"
                        className="h-20 bg-white/5 border-white/10 text-4xl font-black text-emerald-400 placeholder:text-emerald-900/50"
                        value={formData.listingPrice}
                        onChange={(e) => setFormData({...formData, listingPrice: Number(e.target.value)})}
                      />
                    </div>

                    {formData.listingType === "BOOKING" && (
                      <div className="mt-8 p-6 rounded-3xl bg-emerald-500/10 border border-emerald-500/20 space-y-4">
                        <div className="flex items-center gap-3">
                          <ShieldCheck className="w-8 h-8 text-emerald-400" />
                          <h3 className="font-black text-emerald-400 text-lg">Reservatior SafeStay™ Sözleşmesi</h3>
                        </div>
                        <p className="text-sm text-emerald-100/70 leading-relaxed">
                          Müşterilerin platforma güvenmesi ve dönüşüm oranlarının %400 artması için Reservatior bir <b>Escrow (Emanet Kasa)</b> modeline sahiptir. Müşteriden çekilen ödeme havuzda tutulur ve konuk sorunsuz şekilde giriş yaptıktan (check-in) 24 saat sonra belirttiğiniz banka hesabına aktarılır.
                        </p>
                        <div className="flex items-start space-x-3 pt-4 border-t border-emerald-500/20">
                          <Checkbox 
                            id="escrow-terms" 
                            checked={formData.acceptsEscrow}
                            onCheckedChange={(checked) => setFormData({...formData, acceptsEscrow: !!checked})}
                            className="border-emerald-500 data-[state=checked]:bg-emerald-500 data-[state=checked]:text-white"
                          />
                          <div className="grid gap-1.5 leading-none">
                            <label htmlFor="escrow-terms" className="text-sm font-semibold text-emerald-200 cursor-pointer">
                              SafeStay™ Escrow modelini anladım ve ödemelerin konaklama sonrası yatırılmasını kabul ediyorum.
                            </label>
                          </div>
                        </div>
                      </div>
                    )}
                  </div>
                </div>
              )}

              {/* STEP 4: MEDIA */}
              {currentStep === 3 && (
                <div className="space-y-8">
                  <div>
                    <h1 className="text-4xl font-black mb-2">Fotoğraflarla süsleyin.</h1>
                    <p className="text-white/50">Harika fotoğraflar konukların tesisinizi seçmesinde en büyük etkendir.</p>
                  </div>
                  <input
                    ref={fileInputRef}
                    type="file"
                    accept="image/*"
                    multiple
                    onChange={handlePhotoUpload}
                    className="hidden"
                  />
                  <div
                    onClick={() => fileInputRef.current?.click()}
                    className="border-2 border-dashed border-white/10 rounded-3xl p-12 flex flex-col items-center justify-center text-center bg-white/5 hover:bg-white/10 hover:border-emerald-500/30 transition-all cursor-pointer group"
                  >
                    <div className="w-16 h-16 bg-white/10 rounded-full flex items-center justify-center mb-4 group-hover:scale-110 transition-transform">
                      {uploadingPhotos ? (
                        <Loader2 className="w-8 h-8 text-emerald-400 animate-spin" />
                      ) : (
                        <Upload className="w-8 h-8 text-white/50 group-hover:text-emerald-400 transition-colors" />
                      )}
                    </div>
                    <h3 className="text-lg font-bold mb-2">
                      {uploadingPhotos ? "Yükleniyor..." : "Fotoğraf Yüklemek İçin Tıklayın"}
                    </h3>
                    <p className="text-sm text-white/50">PNG, JPG, WebP — En fazla 10 fotoğraf</p>
                  </div>
                  {formData.photos.length > 0 && (
                    <div className="grid grid-cols-3 gap-3">
                      {formData.photos.map((photo: any, idx: number) => (
                        <div key={idx} className="relative group aspect-square rounded-2xl overflow-hidden bg-white/5 border border-white/10">
                          <img
                            src={photo.url}
                            alt={photo.name || `Fotoğraf ${idx + 1}`}
                            className="w-full h-full object-cover"
                            onError={(e) => { (e.target as HTMLImageElement).style.display = "none"; }}
                          />
                          <div className="absolute inset-0 bg-black/50 opacity-0 group-hover:opacity-100 transition-opacity flex items-center justify-center">
                            <Button
                              variant="ghost"
                              size="icon"
                              onClick={(e) => { e.stopPropagation(); removePhoto(idx); }}
                              className="text-red-400 hover:text-red-300 hover:bg-red-500/10"
                            >
                              <X className="w-5 h-5" />
                            </Button>
                          </div>
                          {idx === 0 && (
                            <span className="absolute top-2 left-2 text-[10px] font-black tracking-widest bg-emerald-500/80 text-white px-2 py-0.5 rounded-full">
                              KAPAK
                            </span>
                          )}
                        </div>
                      ))}
                    </div>
                  )}
                </div>
              )}

              {/* STEP 5: REVIEW */}
              {currentStep === 4 && (
                <div className="space-y-8 text-center">
                  <div className="w-24 h-24 bg-emerald-500/20 rounded-full flex items-center justify-center mx-auto">
                    <Building2 className="w-12 h-12 text-emerald-400" />
                  </div>
                  <div>
                    <h1 className="text-4xl font-black mb-4">Her şey hazır!</h1>
                    <p className="text-white/50 text-lg max-w-md mx-auto">Tesisiniz <b>{formData.name}</b>, {formData.city} lokasyonunda yayınlanmaya hazır.</p>
                    <div className="mt-6 flex flex-wrap items-center justify-center gap-4 text-sm text-white/40">
                      <span>{formData.bedrooms} yatak odası</span>
                      <span className="w-1 h-1 bg-white/20 rounded-full" />
                      <span>{formData.bathrooms} banyo</span>
                      <span className="w-1 h-1 bg-white/20 rounded-full" />
                      <span>{formData.areaSqm} m²</span>
                      <span className="w-1 h-1 bg-white/20 rounded-full" />
                      <span>${formData.listingPrice}</span>
                      <span className="w-1 h-1 bg-white/20 rounded-full" />
                      <span>{formData.photos.length} fotoğraf</span>
                    </div>
                  </div>
                </div>
              )}

            </motion.div>
          </AnimatePresence>
        </div>
      </div>

      {/* Bottom Action Bar */}
      <div className="h-24 border-t border-white/5 px-8 flex items-center justify-between bg-[#0A0A0B]">
        <Button 
          variant="ghost" 
          onClick={handlePrev}
          className="text-white/50 hover:text-white"
        >
          <u>{currentStep === 0 ? "Çık" : "Geri Dön"}</u>
        </Button>
        
        {currentStep < steps.length - 1 ? (
          <Button 
            onClick={handleNext}
            disabled={currentStep === 0 && (!formData.name || !formData.city)}
            className="bg-white text-black hover:bg-white/90 rounded-xl px-8 h-12 font-bold flex items-center gap-2"
          >
            İleri <ChevronRight className="w-4 h-4" />
          </Button>
        ) : (
          <Button 
            onClick={handleSubmit}
            disabled={isLoading}
            className="bg-emerald-500 text-white hover:bg-emerald-400 rounded-xl px-8 h-12 font-bold shadow-xl shadow-emerald-500/20 flex items-center gap-2"
          >
            {isLoading ? "Yayınlanıyor..." : "Tesisimi Yayınla"}
          </Button>
        )}
      </div>
    </div>
  );
}
