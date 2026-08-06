import React, { useState } from "react";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription } from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { Textarea } from "@/components/ui/textarea";
import { FileUp, ShieldCheck, UploadCloud, AlertCircle } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { useTranslation } from "react-i18next";
import { apiClient } from "@/lib/api/client";
import { m, AnimatePresence } from "framer-motion";
import { cn } from "@/lib/utils";

interface DocEntry {
  file: File | null;
  preview: string;
}

interface OwnershipClaimModalProps {
  propertyId: string;
  isOpen: boolean;
  onClose: () => void;
  onSuccess?: () => void;
  countryCode?: string;
  stateCode?: string;
  cityCode?: string;
  propertyType?: string;
  orgId?: string;
}

export function OwnershipClaimModal({ propertyId, isOpen, onClose, onSuccess, countryCode = 'TR', stateCode = '34', cityCode = 'IST', propertyType = 'APARTMENT', orgId }: OwnershipClaimModalProps) {
  const { t } = useTranslation();
  const { toast } = useToast();
  const [step, setStep] = useState(1);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [documents, setDocuments] = useState<{ id: DocEntry | null; deed: DocEntry | null }>({
    id: null,
    deed: null,
  });
  const [notes, setNotes] = useState("");

  const handleFileChange = (type: 'id' | 'deed', e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) {
      setDocuments(prev => ({
        ...prev,
        [type]: {
          file,
          preview: URL.createObjectURL(file)
        }
      }));
    }
  };

  const handleSubmit = async () => {
    if (!documents.id?.file || !documents.deed?.file) {
      toast({
        title: "Eksik Belge",
        description: "Lütfen kimlik ve tapu belgelerinizi yükleyin.",
        variant: "destructive"
      });
      return;
    }

    setIsSubmitting(true);
    try {
      // Upload ID document
      const idFormData = new FormData();
      idFormData.append('file', documents.id.file);
      idFormData.append('category', 'documents');
      idFormData.append('type', 'IDENTITY_DOCUMENT');
      idFormData.append('countryCode', countryCode);
      idFormData.append('stateCode', stateCode);
      idFormData.append('cityCode', cityCode);
      idFormData.append('propertyType', propertyType);
      idFormData.append('processingType', 'raw');
      if (orgId) idFormData.append('orgId', orgId);
      idFormData.append('propertyId', propertyId);
      
      const idUploadResponse = await apiClient.post('/media/upload', idFormData) as any;
      if (!idUploadResponse?.success) throw new Error("ID document upload failed");
      
      // Upload Deed document
      const deedFormData = new FormData();
      deedFormData.append('file', documents.deed.file);
      deedFormData.append('category', 'documents');
      deedFormData.append('type', 'TITLE_DEED');
      deedFormData.append('countryCode', countryCode);
      deedFormData.append('stateCode', stateCode);
      deedFormData.append('cityCode', cityCode);
      deedFormData.append('propertyType', propertyType);
      deedFormData.append('processingType', 'raw');
      if (orgId) deedFormData.append('orgId', orgId);
      deedFormData.append('propertyId', propertyId);
      
      const deedUploadResponse = await apiClient.post('/media/upload', deedFormData) as any;
      if (!deedUploadResponse?.success) throw new Error("Deed document upload failed");

      const payload = {
        notes,
        documents: [
          {
            documentType: "OTHER",
            fileName: idUploadResponse.data.originalName,
            fileUrl: idUploadResponse.data.url
          },
          {
            documentType: "TITLE_DEED",
            fileName: deedUploadResponse.data.originalName,
            fileUrl: deedUploadResponse.data.url
          }
        ]
      };

      const response = await apiClient.post(`/property/${propertyId}/claim`, payload) as any;

      if (response?.error) throw new Error(response.error);

      toast({
        title: "Talebiniz Alındı",
        description: "Mülk sahipliği doğrulama talebiniz başarıyla oluşturuldu. Yöneticilerimiz belgelerinizi inceleyecektir.",
      });

      if (onSuccess) onSuccess();
      onClose();
    } catch (error: any) {
      toast({
        title: "Hata",
        description: error.message || "Talep gönderilirken bir hata oluştu.",
        variant: "destructive"
      });
    } finally {
      setIsSubmitting(false);
    }
  };

  const handleNext = () => {
    if (step === 1 && (!documents.id?.file || !documents.deed?.file)) {
       toast({
        title: "Eksik Belge",
        description: "Devam etmek için Kimlik ve Tapu/Sahiplik belgenizi yüklemelisiniz.",
        variant: "destructive"
      });
      return;
    }
    setStep(2);
  }

  return (
    <Dialog open={isOpen} onOpenChange={onClose}>
      <DialogContent className="sm:max-w-[500px] bg-background/90 backdrop-blur-3xl border border-white/10 text-white rounded-3xl overflow-hidden p-0">
        <div className="absolute top-0 left-0 w-full h-1 bg-white/5">
           <div className={cn("h-full bg-orange-500 transition-all duration-500", step === 1 ? "w-1/2" : "w-full")} />
        </div>
        
        <div className="p-8">
          <DialogHeader className="mb-6">
            <DialogTitle className="text-2xl font-black italic tracking-tighter flex items-center gap-2">
              <ShieldCheck className="w-6 h-6 text-orange-500" />
              Mülk Sahipliği Doğrulama
            </DialogTitle>
            <DialogDescription className="text-muted-foreground font-medium italic text-xs">
              Bu mülkün yasal sahibi veya yetkili temsilcisi olduğunuzu doğrulamak için lütfen gerekli belgeleri yükleyin.
            </DialogDescription>
          </DialogHeader>

          <AnimatePresence mode="wait">
            {step === 1 ? (
              <m.div key="step1" initial={{ opacity: 0, x: -20 }} animate={{ opacity: 1, x: 0 }} exit={{ opacity: 0, x: 20 }} className="space-y-6">
                
                {/* ID Upload */}
                <div className="space-y-2">
                  <label className="text-[10px] font-black text-muted-foreground tracking-widest uppercase">Kimlik Belgesi (Önlü Arkalı)</label>
                  <label className={cn("flex flex-col items-center justify-center w-full h-32 border-2 border-dashed rounded-2xl cursor-pointer transition-all", documents.id?.file ? "border-blue-500 bg-success/10" : "border-white/10 hover:border-white/30 hover:bg-white/5")}>
                    <div className="flex flex-col items-center justify-center pt-5 pb-6 text-center">
                      {documents.id?.file ? (
                        <>
                          <ShieldCheck className="w-8 h-8 text-success mb-2" />
                          <p className="text-xs font-bold text-success">{documents.id.file.name}</p>
                        </>
                      ) : (
                        <>
                          <UploadCloud className="w-8 h-8 text-muted-foreground mb-2" />
                          <p className="text-xs font-medium text-muted-foreground">Tıklayın veya sürükleyin</p>
                          <p className="text-[10px] text-muted-foreground mt-1">PDF, JPG, PNG (Max 5MB)</p>
                        </>
                      )}
                    </div>
                    <input type="file" className="hidden" accept=".pdf,image/*" onChange={(e) => handleFileChange('id', e)} />
                  </label>
                </div>

                {/* Deed Upload */}
                <div className="space-y-2">
                  <label className="text-[10px] font-black text-muted-foreground tracking-widest uppercase">Tapu Belgesi / Yetki Belgesi</label>
                  <label className={cn("flex flex-col items-center justify-center w-full h-32 border-2 border-dashed rounded-2xl cursor-pointer transition-all", documents.deed?.file ? "border-blue-500 bg-brand/10" : "border-white/10 hover:border-white/30 hover:bg-white/5")}>
                    <div className="flex flex-col items-center justify-center pt-5 pb-6 text-center">
                      {documents.deed?.file ? (
                        <>
                          <FileUp className="w-8 h-8 text-brand mb-2" />
                          <p className="text-xs font-bold text-brand">{documents.deed.file.name}</p>
                        </>
                      ) : (
                        <>
                          <UploadCloud className="w-8 h-8 text-muted-foreground mb-2" />
                          <p className="text-xs font-medium text-muted-foreground">Tıklayın veya sürükleyin</p>
                          <p className="text-[10px] text-muted-foreground mt-1">PDF (Tercihen E-Devlet Karekodlu)</p>
                        </>
                      )}
                    </div>
                    <input type="file" className="hidden" accept=".pdf,image/*" onChange={(e) => handleFileChange('deed', e)} />
                  </label>
                </div>

                <Button onClick={handleNext} className="w-full h-14 rounded-2xl bg-card text-black hover:bg-muted font-black tracking-widest text-sm">
                  Devam Et
                </Button>

              </m.div>
            ) : (
              <m.div key="step2" initial={{ opacity: 0, x: 20 }} animate={{ opacity: 1, x: 0 }} exit={{ opacity: 0, x: -20 }} className="space-y-6">
                
                <div className="p-4 bg-warning/10 border border-warning/20 rounded-2xl flex gap-3">
                  <AlertCircle className="w-5 h-5 text-orange-500 shrink-0 mt-0.5" />
                  <p className="text-xs font-medium text-orange-200/80 leading-relaxed italic">
                    Belgeleriniz güvenli bir şekilde saklanacak ve sadece yönetim ekibi tarafından doğrulanmak üzere kullanılacaktır.
                  </p>
                </div>

                <div className="space-y-2">
                  <label className="text-[10px] font-black text-muted-foreground tracking-widest uppercase">Ek Notlar (İsteğe Bağlı)</label>
                  <Textarea 
                    value={notes}
                    onChange={(e) => setNotes(e.target.value)}
                    placeholder="Yönetim ekibine iletmek istediğiniz ek bir not varsa buraya yazabilirsiniz..."
                    className="min-h-[120px] bg-white/5 border-white/10 rounded-2xl text-sm placeholder:text-muted-foreground"
                  />
                </div>

                <div className="flex gap-3 pt-4">
                  <Button variant="outline" onClick={() => setStep(1)} className="flex-1 h-14 rounded-2xl border-white/10 bg-white/5 text-white hover:bg-white/10 font-black tracking-widest text-sm">
                    Geri
                  </Button>
                  <Button onClick={handleSubmit} disabled={isSubmitting} className="flex-2 h-14 rounded-2xl bg-orange-600 hover:bg-orange-500 text-white font-black tracking-widest text-sm shadow-xl shadow-orange-600/20">
                    {isSubmitting ? "Gönderiliyor..." : "Talebi Gönder"}
                  </Button>
                </div>

              </m.div>
            )}
          </AnimatePresence>
        </div>
      </DialogContent>
    </Dialog>
  );
}
