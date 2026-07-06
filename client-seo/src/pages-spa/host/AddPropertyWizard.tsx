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
import { Building, Bed, Bath, ShieldCheck, ChevronRight, Building2, Home as HomeIcon, Upload, X, Loader2, ChevronDown } from "lucide-react";
import { useTranslation } from "react-i18next";

const COUNTRIES = [
  { code: "TR", name: "Türkiye" },
  { code: "AE", name: "United Arab Emirates" },
  { code: "SA", name: "Saudi Arabia" },
  { code: "UK", name: "United Kingdom" },
  { code: "US", name: "United States" },
  { code: "DE", name: "Germany" },
  { code: "FR", name: "France" },
  { code: "ES", name: "Spain" },
  { code: "IT", name: "Italy" },
  { code: "NL", name: "Netherlands" },
  { code: "CA", name: "Canada" },
  { code: "MX", name: "Mexico" },
  { code: "BR", name: "Brazil" },
  { code: "AR", name: "Argentina" },
  { code: "AU", name: "Australia" },
  { code: "NZ", name: "New Zealand" },
  { code: "JP", name: "Japan" },
  { code: "KR", name: "South Korea" },
  { code: "CN", name: "China" },
  { code: "IN", name: "India" },
  { code: "SG", name: "Singapore" },
  { code: "MY", name: "Malaysia" },
  { code: "TH", name: "Thailand" },
];

export default function AddPropertyWizard() {
  const { t } = useTranslation();
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
    country: "",
    city: "",
    district: "",
    neighborhood: "",
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

  const steps = [
    { id: "intro", title: t('add_property.step_intro', 'Basic Info') },
    { id: "details", title: t('add_property.step_details', 'Features') },
    { id: "pricing", title: t('add_property.step_pricing', 'Pricing & Guarantee') },
    { id: "media", title: t('add_property.step_media', 'Media') },
    { id: "review", title: t('add_property.step_review', 'Publish') }
  ];

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
      toast({ title: t('add_property.photos_uploaded', 'Photos uploaded'), description: t('add_property.photos_uploaded_desc', '{{count}} photos successfully uploaded.', { count: files.length }) });
    } catch (err: any) {
      toast({ title: t('add_property.upload_error', 'Upload error'), description: err.message || t('add_property.upload_error_desc', 'Error occurred while uploading photos.'), variant: "destructive" });
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
    const meta = {
      country: formData.country,
      city: formData.city,
      district: formData.district,
      neighborhood: formData.neighborhood,
      listingType: formData.listingType,
      propertyType: formData.type,
    };
    for (const url of photoUrls) {
      try {
        await fetch(`${processorUrl}/skipper/tasks`, {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            workflow: "image-process",
            data: { image_path: url, resize: true, thumbnail: true, ...meta },
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
      toast({ title: t('add_property.warning', 'Warning'), description: t('add_property.accept_contract', 'You must accept the SafeStay™ agreement.'), variant: "destructive" });
      return;
    }
    setIsLoading(true);
    try {
      const photoUrls = formData.photos.map((p: any) => p.url);
      toast({ title: t('add_property.ml_processing', 'ML Processing'), description: t('add_property.ml_processing_desc', 'Processing {{count}} photos with ML services...', { count: photoUrls.length }) });
      await triggerMlProcessing(photoUrls);
      const result = await apiClient.post("/property", {
        name: formData.name,
        type: formData.type,
        listingType: formData.listingType,
        country: formData.country,
        city: formData.city,
        district: formData.district,
        neighborhood: formData.neighborhood,
        addressLine1: formData.addressLine1 || t('add_property.not_entered', 'Not entered'),
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
      toast({ title: t('add_property.congratulations', 'Congratulations!'), description: t('add_property.success_added', 'Your property was successfully added and is under review.') });
      navigate("/admin/properties");
    } catch (error: any) {
      toast({ title: t('add_property.error', 'Error'), description: t('add_property.error_added', 'There was a problem adding the property.'), variant: "destructive" });
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-background text-foreground flex flex-col">
      {/* Top Navigation */}
      <div className="h-20 border-b border-border flex items-center justify-between px-8 bg-background/80 backdrop-blur-md sticky top-0 z-50">
        <div className="flex items-center gap-2">
          <Building2 className="w-8 h-8 text-blue-500" />
          <span className="font-black text-xl tracking-tighter">Reservatior <span className="text-blue-500">Host</span></span>
        </div>
        <Button variant="ghost" onClick={() => navigate("/admin/properties")} className="text-muted-foreground hover:text-foreground">
          {t('add_property.cancel_exit', 'Cancel & Exit')}
        </Button>
      </div>

      {/* Progress Bar */}
      <div className="h-1 bg-muted/20 w-full">
        <motion.div 
          className="h-full bg-blue-500"
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
                    <h1 className="text-4xl font-black mb-2">{t('add_property.intro_heading', 'Let\'s talk about your property.')}</h1>
                    <p className="text-muted-foreground">{t('add_property.intro_subheading', 'Let\'s enter basic info so guests can find your property.')}</p>
                  </div>
                  <div className="space-y-6">
                    <div className="space-y-2">
                      <Label className="text-muted-foreground">{t('add_property.property_name', 'Property Name')}</Label>
                      <Input 
                        placeholder={t('add_property.ex_property_name', 'Ex: Sea View Luxury Villa')}
                        className="h-14 bg-muted/20 border-border text-lg"
                        value={formData.name}
                        onChange={(e) => setFormData({...formData, name: e.target.value})}
                      />
                    </div>
                    <div className="space-y-2">
                      <Label className="text-muted-foreground">{t('add_property.property_type', 'Property Type')}</Label>
                      <div className="grid grid-cols-2 gap-4">
                        {[
                          { id: 'HOTEL', label: t('add_property.hotel', 'Hotel'), icon: Building },
                          { id: 'VILLA', label: t('add_property.villa', 'Villa'), icon: HomeIcon },
                          { id: 'APARTMENT', label: t('add_property.apartment', 'Apartment'), icon: Building2 }
                        ].map((type) => (
                          <div 
                            key={type.id}
                            onClick={() => setFormData({...formData, type: type.id})}
                            className={`p-4 border rounded-2xl cursor-pointer transition-all flex flex-col gap-3 ${formData.type === type.id ? 'border-blue-500 bg-blue-500/10' : 'border-border bg-muted/20 hover:border-border'}`}
                          >
                            <type.icon className={`w-6 h-6 ${formData.type === type.id ? 'text-blue-500' : 'text-muted-foreground'}`} />
                            <span className="font-semibold">{type.label}</span>
                          </div>
                        ))}
                      </div>
                    </div>
                    <div className="grid grid-cols-2 gap-4">
                      <div className="space-y-2">
                        <Label className="text-muted-foreground">{t('add_property.country', 'Country')}</Label>
                        <div className="relative">
                          <select
                            className="h-14 w-full bg-muted/20 border border-border rounded-xl px-4 text-lg text-foreground appearance-none cursor-pointer focus:outline-none focus:ring-2 focus:ring-blue-500/50"
                            value={formData.country}
                            onChange={(e) => setFormData({...formData, country: e.target.value})}
                          >
                            <option value="" disabled>{t('add_property.select_country', 'Select a country')}</option>
                            {COUNTRIES.map((c) => (
                              <option key={c.code} value={c.code}>{c.name}</option>
                            ))}
                          </select>
                          <ChevronDown className="absolute right-4 top-1/2 -translate-y-1/2 w-5 h-5 text-muted-foreground pointer-events-none" />
                        </div>
                      </div>
                      <div className="space-y-2">
                        <Label className="text-muted-foreground">{t('add_property.which_city', 'Which City?')}</Label>
                        <Input 
                          placeholder={t('add_property.ex_city', 'Ex: Istanbul, Turkey')}
                          className="h-14 bg-muted/20 border-border text-lg"
                          value={formData.city}
                          onChange={(e) => setFormData({...formData, city: e.target.value})}
                        />
                      </div>
                    </div>
                    <div className="grid grid-cols-2 gap-4">
                      <div className="space-y-2">
                        <Label className="text-muted-foreground">{t('add_property.district', 'District')}</Label>
                        <Input 
                          placeholder={t('add_property.ex_district', 'Ex: Kadıköy')}
                          className="h-14 bg-muted/20 border-border text-lg"
                          value={formData.district}
                          onChange={(e) => setFormData({...formData, district: e.target.value})}
                        />
                      </div>
                      <div className="space-y-2">
                        <Label className="text-muted-foreground">{t('add_property.neighborhood', 'Neighborhood')}</Label>
                        <Input 
                          placeholder={t('add_property.ex_neighborhood', 'Ex: Caferağa')}
                          className="h-14 bg-muted/20 border-border text-lg"
                          value={formData.neighborhood}
                          onChange={(e) => setFormData({...formData, neighborhood: e.target.value})}
                        />
                      </div>
                    </div>
                  </div>
                </div>
              )}

              {/* STEP 2: DETAILS */}
              {currentStep === 1 && (
                <div className="space-y-8">
                  <div>
                    <h1 className="text-4xl font-black mb-2">{t('add_property.details_heading', 'Share the details.')}</h1>
                    <p className="text-muted-foreground">{t('add_property.details_subheading', 'Let guests know what to expect.')}</p>
                  </div>
                  <div className="space-y-6">
                    <div className="flex items-center justify-between p-4 border border-border rounded-2xl bg-muted/20">
                      <div className="flex items-center gap-4">
                        <Bed className="w-6 h-6 text-muted-foreground" />
                        <span className="text-lg">{t('add_property.bedrooms', 'Bedrooms')}</span>
                      </div>
                      <div className="flex items-center gap-4">
                        <Button variant="outline" className="rounded-full w-10 h-10 p-0 border-border" onClick={() => setFormData({...formData, bedrooms: Math.max(1, formData.bedrooms - 1)})}>-</Button>
                        <span className="w-4 text-center font-bold text-lg">{formData.bedrooms}</span>
                        <Button variant="outline" className="rounded-full w-10 h-10 p-0 border-border" onClick={() => setFormData({...formData, bedrooms: formData.bedrooms + 1})}>+</Button>
                      </div>
                    </div>
                    <div className="flex items-center justify-between p-4 border border-border rounded-2xl bg-muted/20">
                      <div className="flex items-center gap-4">
                        <Bath className="w-6 h-6 text-muted-foreground" />
                        <span className="text-lg">{t('add_property.bathrooms', 'Bathrooms')}</span>
                      </div>
                      <div className="flex items-center gap-4">
                        <Button variant="outline" className="rounded-full w-10 h-10 p-0 border-border" onClick={() => setFormData({...formData, bathrooms: Math.max(1, formData.bathrooms - 1)})}>-</Button>
                        <span className="w-4 text-center font-bold text-lg">{formData.bathrooms}</span>
                        <Button variant="outline" className="rounded-full w-10 h-10 p-0 border-border" onClick={() => setFormData({...formData, bathrooms: formData.bathrooms + 1})}>+</Button>
                      </div>
                    </div>
                    <div className="space-y-2">
                      <Label className="text-muted-foreground">{t('add_property.area', 'Property Size (m²)')}</Label>
                      <Input 
                        type="number"
                        className="h-14 bg-muted/20 border-border text-lg"
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
                    <h1 className="text-4xl font-black mb-2">{t('add_property.pricing_heading', 'Set your price.')}</h1>
                    <p className="text-muted-foreground">
                      {formData.listingType === "SALE" ? t('add_property.enter_sale_price', 'Enter the sale price of your property.') : 
                       formData.listingType === "RENT" ? t('add_property.enter_rent_price', 'Enter the monthly rent price of your property.') : 
                       t('add_property.enter_booking_price', 'Enter your net nightly price and accept our guarantee agreement.')}
                    </p>
                  </div>
                  <div className="space-y-6">
                    <div className="space-y-2">
                      <Label className="text-muted-foreground">
                        {formData.listingType === "SALE" ? t('add_property.sale_price', 'Sale Price ($)') : 
                         formData.listingType === "RENT" ? t('add_property.rent_price', 'Monthly Rent ($)') : 
                         t('add_property.nightly_price', 'Nightly Price ($)')}
                      </Label>
                      <Input 
                        type="number"
                        className="h-20 bg-muted/20 border-border text-4xl font-black text-blue-400 placeholder:text-blue-900/50"
                        value={formData.listingPrice}
                        onChange={(e) => setFormData({...formData, listingPrice: Number(e.target.value)})}
                      />
                    </div>

                    {formData.listingType === "BOOKING" && (
                      <div className="mt-8 p-6 rounded-3xl bg-blue-500/10 border border-blue-500/20 space-y-4">
                        <div className="flex items-center gap-3">
                          <ShieldCheck className="w-8 h-8 text-blue-400" />
                          <h3 className="font-black text-blue-400 text-lg">{t('add_property.safestay_contract', 'Reservatior SafeStay™ Agreement')}</h3>
                        </div>
                        <p className="text-sm text-blue-100/70 leading-relaxed" dangerouslySetInnerHTML={{ __html: t('add_property.safestay_desc', 'For customer trust and a 400% increase in conversion rates, Reservatior features an <b>Escrow</b> model. Payments collected from customers are held in a pool and transferred to your bank account 24 hours after the guest smoothly checks in.') }} />
                        <div className="flex items-start space-x-3 pt-4 border-t border-blue-500/20">
                          <Checkbox 
                            id="escrow-terms" 
                            checked={formData.acceptsEscrow}
                            onCheckedChange={(checked) => setFormData({...formData, acceptsEscrow: !!checked})}
                            className="border-blue-500 data-[state=checked]:bg-blue-500 data-[state=checked]:text-white"
                          />
                          <div className="grid gap-1.5 leading-none">
                            <label htmlFor="escrow-terms" className="text-sm font-semibold text-blue-200 cursor-pointer">
                              {t('add_property.safestay_accept', 'I understand the SafeStay™ Escrow model and accept that payments will be deposited post-stay.')}
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
                    <h1 className="text-4xl font-black mb-2">{t('add_property.media_heading', 'Decorate with photos.')}</h1>
                    <p className="text-muted-foreground">{t('add_property.media_subheading', 'Great photos are the biggest factor for guests choosing your property.')}</p>
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
                    className="border-2 border-dashed border-border rounded-3xl p-12 flex flex-col items-center justify-center text-center bg-muted/20 hover:bg-muted/30 hover:border-blue-500/30 transition-all cursor-pointer group"
                  >
                    <div className="w-16 h-16 bg-muted/20 rounded-full flex items-center justify-center mb-4 group-hover:scale-110 transition-transform">
                      {uploadingPhotos ? (
                        <Loader2 className="w-8 h-8 text-blue-400 animate-spin" />
                      ) : (
                        <Upload className="w-8 h-8 text-muted-foreground group-hover:text-blue-400 transition-colors" />
                      )}
                    </div>
                    <h3 className="text-lg font-bold mb-2">
                      {uploadingPhotos ? t('add_property.uploading', 'Uploading...') : t('add_property.click_to_upload', 'Click to Upload Photos')}
                    </h3>
                    <p className="text-sm text-muted-foreground">{t('add_property.photo_limits', 'PNG, JPG, WebP — Max 10 photos')}</p>
                  </div>
                  {formData.photos.length > 0 && (
                    <div className="grid grid-cols-3 gap-3">
                      {formData.photos.map((photo: any, idx: number) => (
                        <div key={idx} className="relative group aspect-square rounded-2xl overflow-hidden bg-muted/20 border border-border">
                          <img
                            src={photo.url}
                            alt={photo.name || `Photo ${idx + 1}`}
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
                            <span className="absolute top-2 left-2 text-[10px] font-black tracking-widest bg-blue-500/80 text-white px-2 py-0.5 rounded-full">
                              {t('add_property.cover', 'COVER')}
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
                  <div className="w-24 h-24 bg-blue-500/20 rounded-full flex items-center justify-center mx-auto">
                    <Building2 className="w-12 h-12 text-blue-400" />
                  </div>
                  <div>
                    <h1 className="text-4xl font-black mb-4">{t('add_property.ready_heading', 'Everything is ready!')}</h1>
                    <p className="text-muted-foreground text-lg max-w-md mx-auto" dangerouslySetInnerHTML={{ __html: t('add_property.ready_desc', 'Your property <b>{{name}}</b> is ready to be published in {{city}}, {{district}}.', { name: formData.name, city: formData.city, district: formData.district }) }} />
                    <div className="mt-6 flex flex-wrap items-center justify-center gap-4 text-sm text-muted-foreground/70">
                      <span>{formData.bedrooms} {t('add_property.bedroom_count', 'bedrooms')}</span>
                      <span className="w-1 h-1 bg-border rounded-full" />
                      <span>{formData.bathrooms} {t('add_property.bathroom_count', 'bathrooms')}</span>
                      <span className="w-1 h-1 bg-border rounded-full" />
                      <span>{formData.areaSqm} m²</span>
                      <span className="w-1 h-1 bg-border rounded-full" />
                      <span>${formData.listingPrice}</span>
                      <span className="w-1 h-1 bg-border rounded-full" />
                      <span>{formData.photos.length} {t('add_property.photo_count', 'photos')}</span>
                    </div>
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
          className="text-muted-foreground hover:text-foreground"
        >
          <u>{currentStep === 0 ? t('add_property.exit', 'Exit') : t('add_property.go_back', 'Go Back')}</u>
        </Button>
        
        {currentStep < steps.length - 1 ? (
          <Button 
            onClick={handleNext}
            disabled={currentStep === 0 && (!formData.name || !formData.country || !formData.city || !formData.district || !formData.neighborhood)}
            className="bg-primary text-primary-foreground hover:bg-primary/90 rounded-xl px-8 h-12 font-bold flex items-center gap-2"
          >
            {t('add_property.next', 'Next')} <ChevronRight className="w-4 h-4" />
          </Button>
        ) : (
          <Button 
            onClick={handleSubmit}
            disabled={isLoading}
            className="bg-blue-500 text-white hover:bg-blue-400 rounded-xl px-8 h-12 font-bold shadow-xl shadow-blue-500/20 flex items-center gap-2"
          >
            {isLoading ? t('add_property.publishing', 'Publishing...') : t('add_property.publish_property', 'Publish My Property')}
          </Button>
        )}
      </div>
    </div>
  );
}
