import { useState, useEffect, useRef } from "react";
import { useNavigate, useLocation } from "react-router-dom";
import { motion, AnimatePresence } from "framer-motion";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Checkbox } from "@/components/ui/checkbox";
import { useToast } from "@/hooks/use-toast";
import { apiClient } from "@/lib/api/client";
import { Building, MapPin, Bed, Bath, ShieldCheck, CheckCircle2, ChevronRight, ChevronLeft, Building2, Home as HomeIcon, Upload, X, Film, Image as ImageIcon, Trash2, Loader2 } from "lucide-react";


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

  const [uploading, setUploading] = useState(false);
  const [uploadProgress, setUploadProgress] = useState<string | null>(null);
  const fileInputRef = useRef<HTMLInputElement>(null);

  const [formData, setFormData] = useState<any>({
    name: "",
    type: "APARTMENT",
    listingType: initialListingType,
    city: "",
    countryCode: "",
    addressLine1: "",
    bedrooms: 1,
    bathrooms: 1,
    areaSqm: 50,
    listingPrice: 100,
    currency: "USD",
    acceptsEscrow: initialListingType !== "BOOKING",
    listingStatus: "AVAILABLE",
    photos: []
  });

  const handleNext = () => {
    if (currentStep < steps.length - 1) setCurrentStep(prev => prev + 1);
  };

  const handlePrev = () => {
    if (currentStep > 0) setCurrentStep(prev => prev - 1);
  };

  const handleSubmit = async () => {
    if (formData.listingType === "BOOKING" && !formData.acceptsEscrow) {
      toast({ title: "Uyarı", description: "SafeStay™ sözleşmesini onaylamanız gerekmektedir.", variant: "destructive" });
      return;
    }
    setIsLoading(true);
    try {
      const property: any = await apiClient.post("/property", {
        name: formData.name,
        type: formData.type,
        listingType: formData.listingType,
        city: formData.city,
        countryCode: formData.countryCode || undefined,
        addressLine1: formData.addressLine1 || "Girilmedi",
        bedrooms: formData.bedrooms,
        bathrooms: formData.bathrooms,
        areaSqm: formData.areaSqm,
        listingPrice: formData.listingPrice,
        listingStatus: formData.listingStatus
      });

      const propertyId = property?.data?.id || property?.id;
      if (propertyId && formData.photos.length > 0) {
        await Promise.all(formData.photos.map((media: any) =>
          apiClient.post("/property-photo", {
            propertyId,
            url: media.url,
            fileName: media.fileName,
            originalName: media.originalName,
            category: media.category,
            mimeType: media.mimeType,
            fileSize: media.size,
            isPrimary: false,
            sortOrder: 0,
          }).catch((err: any) => console.error("Photo save failed:", err))
        ));
      }

      if (formData.acceptsEscrow && propertyId) {
        try {
          const user: any = await apiClient.getCurrentUser();
          const email = user?.email || user?.data?.email;
          if (email) {
            const existing: any = await apiClient.get("/agent", { email });
            let agentId = existing?.data?.[0]?.id || existing?.[0]?.id;
            if (!agentId) {
              const created: any = await apiClient.post("/agent", {
                name: user?.name || email,
                email,
                status: "ACTIVE",
              });
              agentId = created?.data?.id || created?.id;
            }
            if (agentId) {
              await apiClient.post("/escrow/split-config", {
                propertyId,
                agentId,
                blockageDays: 15,
              });
            }
          }
        } catch (err) {
          console.error("Escrow split config failed:", err);
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
    <div className="min-h-screen bg-background text-foreground flex flex-col">
      {/* Top Navigation */}
      <div className="h-20 border-b border-border flex items-center justify-between px-8 bg-background/80 backdrop-blur-md sticky top-0 z-50">
        <div className="flex items-center gap-2">
          <Building2 className="w-8 h-8 text-emerald-500" />
          <span className="font-black text-xl tracking-tighter">Reservatior <span className="text-emerald-500">Host</span></span>
        </div>
        <Button variant="ghost" onClick={() => navigate("/admin/properties")} className="text-muted-foreground hover:text-foreground">İptal ve Çık</Button>
      </div>

      {/* Progress Bar */}
      <div className="h-1 bg-muted w-full">
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
                    <p className="text-muted-foreground">Müşterilerinizin tesisinizi bulması için temel bilgileri girelim.</p>
                  </div>
                  <div className="space-y-6">
                    <div className="space-y-2">
                      <Label className="text-foreground/70">Tesisinizin Adı</Label>
                      <Input 
                        placeholder="Örn: Sea View Luxury Villa" 
                        className="h-14 bg-card border-border text-lg"
                        value={formData.name}
                        onChange={(e) => setFormData({...formData, name: e.target.value})}
                      />
                    </div>
                    <div className="space-y-2">
                      <Label className="text-foreground/70">Tesis Tipi</Label>
                      <div className="grid grid-cols-2 gap-4">
                        {[
                          { id: 'HOTEL', label: 'Otel', icon: Building },
                          { id: 'VILLA', label: 'Villa', icon: HomeIcon },
                          { id: 'APARTMENT', label: 'Daire', icon: Building2 }
                        ].map((type) => (
                          <div 
                            key={type.id}
                            onClick={() => setFormData({...formData, type: type.id})}
                            className={`p-4 border rounded-2xl cursor-pointer transition-all flex flex-col gap-3 ${formData.type === type.id ? 'border-emerald-500 bg-emerald-500/10' : 'border-border bg-card hover:border-foreground/20'}`}
                          >
                            <type.icon className={`w-6 h-6 ${formData.type === type.id ? 'text-emerald-500' : 'text-muted-foreground'}`} />
                            <span className="font-semibold">{type.label}</span>
                          </div>
                        ))}
                      </div>
                    </div>
                    <div className="space-y-2">
                      <Label className="text-foreground/70">Ülke Kodu</Label>
                      <Input
                        placeholder="Örn: TR"
                        className="h-14 bg-card border-border text-lg uppercase"
                        value={formData.countryCode}
                        onChange={(e) => setFormData({...formData, countryCode: e.target.value.toUpperCase()})}
                      />
                    </div>
                    <div className="space-y-2">
                      <Label className="text-foreground/70">Şehir</Label>
                      <Input
                        placeholder="Örn: İstanbul"
                        className="h-14 bg-card border-border text-lg"
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
                    <p className="text-muted-foreground">Konukların ne beklemeleri gerektiğini bilmelerini sağlayın.</p>
                  </div>
                  <div className="space-y-6">
                    <div className="flex items-center justify-between p-4 border border-border rounded-2xl bg-card">
                      <div className="flex items-center gap-4">
                        <Bed className="w-6 h-6 text-muted-foreground" />
                        <span className="text-lg">Yatak Odası</span>
                      </div>
                      <div className="flex items-center gap-4">
                        <Button variant="outline" className="rounded-full w-10 h-10 p-0" onClick={() => setFormData({...formData, bedrooms: Math.max(1, formData.bedrooms - 1)})}>-</Button>
                        <span className="w-4 text-center font-bold text-lg">{formData.bedrooms}</span>
                        <Button variant="outline" className="rounded-full w-10 h-10 p-0" onClick={() => setFormData({...formData, bedrooms: formData.bedrooms + 1})}>+</Button>
                      </div>
                    </div>
                    <div className="flex items-center justify-between p-4 border border-border rounded-2xl bg-card">
                      <div className="flex items-center gap-4">
                        <Bath className="w-6 h-6 text-muted-foreground" />
                        <span className="text-lg">Banyo</span>
                      </div>
                      <div className="flex items-center gap-4">
                        <Button variant="outline" className="rounded-full w-10 h-10 p-0" onClick={() => setFormData({...formData, bathrooms: Math.max(1, formData.bathrooms - 1)})}>-</Button>
                        <span className="w-4 text-center font-bold text-lg">{formData.bathrooms}</span>
                        <Button variant="outline" className="rounded-full w-10 h-10 p-0" onClick={() => setFormData({...formData, bathrooms: formData.bathrooms + 1})}>+</Button>
                      </div>
                    </div>
                    <div className="space-y-2">
                      <Label className="text-foreground/70">Mülk Büyüklüğü (m²)</Label>
                      <Input 
                        type="number"
                        className="h-14 bg-card border-border text-lg"
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
                    <p className="text-muted-foreground">
                      {formData.listingType === "SALE" ? "Mülkünüzün satış bedelini girin." : 
                       formData.listingType === "RENT" ? "Mülkünüzün aylık kira bedelini girin." : 
                       "Gecelik net fiyatınızı girin ve güvence sözleşmemizi onaylayın."}
                    </p>
                  </div>
                  <div className="space-y-6">
                    <div className="space-y-2">
                      <Label className="text-foreground/70">
                        {formData.listingType === "SALE" ? "Satış Fiyatı ($)" : 
                         formData.listingType === "RENT" ? "Aylık Kira ($)" : 
                         "Gecelik Fiyat ($)"}
                      </Label>
                      <Input 
                        type="number"
                        className="h-20 bg-card border-border text-4xl font-black text-emerald-500 placeholder:text-muted-foreground/50"
                        value={formData.listingPrice}
                        onChange={(e) => setFormData({...formData, listingPrice: Number(e.target.value)})}
                      />
                    </div>

                    {formData.listingType === "BOOKING" && (
                      <div className="mt-8 p-6 rounded-3xl bg-emerald-500/10 border border-emerald-500/20 space-y-4">
                        <div className="flex items-center gap-3">
                          <ShieldCheck className="w-8 h-8 text-emerald-500" />
                          <h3 className="font-black text-emerald-500 text-lg">Reservatior SafeStay™ Sözleşmesi</h3>
                        </div>
                        <p className="text-sm text-emerald-700 dark:text-emerald-100/70 leading-relaxed">
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
                            <label htmlFor="escrow-terms" className="text-sm font-semibold text-emerald-600 dark:text-emerald-200 cursor-pointer">
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
                    <p className="text-muted-foreground">Harika fotoğraflar konukların tesisinizi seçmesinde en büyük etkendir.</p>
                  </div>

                  {/* Upload Area */}
                  <div
                    onClick={() => fileInputRef.current?.click()}
                    className="border-2 border-dashed border-border rounded-3xl p-12 flex flex-col items-center justify-center text-center bg-card hover:bg-accent transition-colors cursor-pointer group"
                  >
                    <div className="w-16 h-16 bg-muted rounded-full flex items-center justify-center mb-4 group-hover:scale-110 transition-transform">
                      <Upload className="w-8 h-8 text-muted-foreground" />
                    </div>
                    <h3 className="text-lg font-bold mb-2">Fotoğraf veya Video Yükle</h3>
                    <p className="text-sm text-muted-foreground mb-4">PNG, JPG, GIF, MP4, WebM — en fazla 50MB</p>
                    <Button variant="outline" size="sm" className="rounded-xl" type="button">
                      Dosya Seç
                    </Button>
                    <input
                      ref={fileInputRef}
                      type="file"
                      multiple
                      accept="image/*,video/*"
                      className="hidden"
                      onChange={async (e) => {
                        const files = Array.from(e.target.files || []);
                        if (files.length === 0) return;

                        setUploading(true);
                        for (const file of files) {
                          setUploadProgress(`${file.name} yükleniyor...`);
                          try {
                            const fd = new FormData();
                            fd.append("file", file);
                            fd.append("category", file.type.startsWith("video/") ? "videos" : "images");
                            fd.append("type", "PROPERTY_MEDIA");
                            if (formData.countryCode) fd.append("countryCode", formData.countryCode);
                            if (formData.city) fd.append("cityCode", formData.city);
                            fd.append("propertyType", formData.type);

                            const result: any = await apiClient.post("/media/upload", fd);
                            if (result?.data) {
                              setFormData((prev: any) => ({
                                ...prev,
                                photos: [...prev.photos, result.data]
                              }));
                            }
                          } catch (err) {
                            console.error("Upload failed:", err);
                          }
                        }
                        setUploadProgress(null);
                        setUploading(false);
                        if (fileInputRef.current) fileInputRef.current.value = "";
                      }}
                    />
                  </div>

                  {uploadProgress && (
                    <div className="flex items-center gap-3 text-sm text-muted-foreground p-4 bg-card rounded-2xl border border-border">
                      <Loader2 className="w-4 h-4 animate-spin text-primary" />
                      {uploadProgress}
                    </div>
                  )}

                  {/* Uploaded Media Grid */}
                  {formData.photos.length > 0 && (
                    <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 gap-4">
                      {formData.photos.map((media: any, idx: number) => (
                        <div key={idx} className="relative group rounded-2xl overflow-hidden border border-border bg-card aspect-square">
                          {media.category === "videos" ? (
                            <div className="w-full h-full flex items-center justify-center bg-muted">
                              <Film className="w-10 h-10 text-muted-foreground" />
                            </div>
                          ) : (
                            <img
                              src={media.url}
                              alt={media.originalName}
                              className="w-full h-full object-cover"
                              onError={(e) => {
                                (e.target as HTMLImageElement).src = ""; // fallback
                                (e.target as HTMLImageElement).style.display = "none";
                              }}
                            />
                          )}
                          <div className="absolute inset-0 bg-black/40 opacity-0 group-hover:opacity-100 transition-opacity flex items-center justify-center gap-2">
                            <Button
                              variant="destructive"
                              size="icon"
                              className="w-8 h-8 rounded-full"
                              type="button"
                              onClick={() => {
                                setFormData((prev: any) => ({
                                  ...prev,
                                  photos: prev.photos.filter((_: any, i: number) => i !== idx)
                                }));
                              }}
                            >
                              <Trash2 className="w-4 h-4" />
                            </Button>
                          </div>
                          <div className="absolute bottom-0 left-0 right-0 p-2 bg-gradient-to-t from-black/60 to-transparent">
                            <p className="text-[10px] text-white truncate">{media.originalName}</p>
                          </div>
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
                    <Building2 className="w-12 h-12 text-emerald-500" />
                  </div>
                  <div>
                    <h1 className="text-4xl font-black mb-4">Her şey hazır!</h1>
                    <p className="text-muted-foreground text-lg max-w-md mx-auto">Tesisiniz <b>{formData.name}</b>, {formData.city} lokasyonunda ${formData.listingPrice} gecelik fiyatla Reservatior ağında yayınlanmaya hazır.</p>
                  </div>
                </div>
              )}

            </motion.div>
          </AnimatePresence>
        </div>
      </div>

      {/* Bottom Action Bar */}
      <div className="h-24 border-t border-border px-8 flex items-center justify-between bg-background">
        <Button 
          variant="ghost" 
          onClick={handlePrev} 
          disabled={currentStep === 0}
          className="text-muted-foreground hover:text-foreground"
        >
          <u>Geri Dön</u>
        </Button>
        
        {currentStep < steps.length - 1 ? (
          <Button 
            onClick={handleNext}
            disabled={currentStep === 0 && (!formData.name || !formData.city)}
            className="bg-primary text-primary-foreground hover:bg-primary/90 rounded-xl px-8 h-12 font-bold flex items-center gap-2"
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
