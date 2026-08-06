"use client";

import React, { useState } from "react";
import { m, AnimatePresence } from "framer-motion";
import {
  Building2,
  ShieldCheck,
  CheckCircle2,
  FileText,
  CreditCard,
  Download,
  ChevronRight,
  UserCheck,
  Award,
  Star,
  MapPin,
  Phone,
  Shield,
  FileCheck,
  Sparkles,
} from "lucide-react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { toast } from "sonner";

// Mock Licensed Real Estate Agencies & Agents
const RECOMMENDED_AGENTS = [
  {
    id: "ag_101",
    name: "Murat Yılmaz",
    agency: "Vizyon Gayrimenkul Kadıköy",
    licenseNo: "34001928",
    rating: 4.9,
    dealsCount: 142,
    commissionShare: "%3.5 Standart",
    photo: "https://images.unsplash.com/photo-1560250097-0b93528c311a?w=150&h=150&fit=crop",
    verified: true,
  },
  {
    id: "ag_102",
    name: "Selin Kaya",
    agency: "Turyap Beşiktaş Yetkili Ofisi",
    licenseNo: "34008102",
    rating: 4.8,
    dealsCount: 98,
    commissionShare: "%3.5 Standart",
    photo: "https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=150&h=150&fit=crop",
    verified: true,
  },
  {
    id: "ag_103",
    name: "Reservatior Direkt (Emlakçısız)",
    agency: "Yalnızca Platform Hizmeti",
    licenseNo: "RESERV-DIRECT",
    rating: 5.0,
    dealsCount: 1500,
    commissionShare: "%1.5 İndirimli",
    photo: "https://images.unsplash.com/photo-1570129477492-45c003edd2be?w=150&h=150&fit=crop",
    verified: true,
  },
];

export default function EDevletContractWizard() {
  const [activeStep, setActiveStep] = useState<1 | 2 | 3 | 4>(1);
  const [loading, setLoading] = useState(false);

  // Form State
  const [formData, setFormData] = useState({
    listingTitle: "Moda Cad. 2+1 Lüks Kiralık Daire",
    tapuTakbisId: "16749021",
    landlordTckn: "12345678901",
    landlordPhone: "+90 532 000 0000",
    tenantTckn: "98765432109",
    monthlyRent: "35000",
    depositAmount: "70000",
    startDate: "2026-08-01",
    selectedAgentId: "ag_101",
    approvalMethod: "SMS_OTP_INTERNAL", // 'SMS_OTP_INTERNAL' | 'EDEVLET_SSO'
  });

  // Verification & Status States
  const [eidsVerified, setEidsVerified] = useState(false);
  const [smsSent, setSmsSent] = useState(false);
  const [smsCode, setSmsCode] = useState("");
  const [internalApproved, setInternalApproved] = useState(false);
  const [contractId, setContractId] = useState<string | null>(null);
  const [barcodeNo, setBarcodeNo] = useState<string | null>(null);

  // Step 1: EİDS & Local Verification
  const handleVerifyEIDS = async () => {
    setLoading(true);
    try {
      await new Promise((resolve) => setTimeout(resolve, 600));
      setEidsVerified(true);
      toast.success("EİDS İlan & Mülkiyet Doğrulaması Platform İçinde Tamamlandı! 🟢");
    } finally {
      setLoading(false);
    }
  };

  // Step 1 Submit: Create Listing & Contract Draft
  const handleCreateContract = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    try {
      const generatedId = `rsv_cnt_${Date.now().toString(36)}`;
      setContractId(generatedId);
      setActiveStep(2);
      toast.success("İlan ve Sözleşme Taslağı Oluşturuldu. Emlakçı Yetkilendirme & Onay Adımına Geçildi.");
    } finally {
      setLoading(false);
    }
  };

  // Step 2: Send Internal SMS OTP Code for Direct In-App Approval
  const handleSendSMS = async () => {
    setLoading(true);
    try {
      await new Promise((resolve) => setTimeout(resolve, 800));
      setSmsSent(true);
      toast.success(`Onay Kodu (${formData.landlordPhone}) Numarasına Gönderildi: [884192]`);
    } finally {
      setLoading(false);
    }
  };

  // Step 2: Verify SMS OTP Code Directly Inside Reservatior (No e-Devlet Redirect)
  const handleVerifySMS = async () => {
    if (smsCode !== "884192" && smsCode.length < 6) {
      toast.error("Geçersiz SMS Doğrulama Kodu! (Demo Kodu: 884192)");
      return;
    }
    setLoading(true);
    try {
      await new Promise((resolve) => setTimeout(resolve, 1000));
      setInternalApproved(true);
      setActiveStep(3);
      toast.success("İlan Onayı ve Emlakçı Yetkilendirmesi Platform İçinde Başarıyla İmzalandı! ⚡");
    } finally {
      setLoading(false);
    }
  };

  // Step 3: Kiracı Onayı
  const handleTenantApproval = async () => {
    setLoading(true);
    try {
      await new Promise((resolve) => setTimeout(resolve, 1200));
      const generatedBarcode = `TR-RSV-2026-${Math.floor(10000000 + Math.random() * 90000000)}`;
      setBarcodeNo(generatedBarcode);
      setActiveStep(4);
      toast.success("Sözleşme ve İlan Onayı Tamamlandı! Barkodlu Resmi Kontrat Üretildi.");
    } finally {
      setLoading(false);
    }
  };

  const selectedAgent = RECOMMENDED_AGENTS.find((a) => a.id === formData.selectedAgentId);

  return (
    <div className="min-h-screen bg-background p-4 sm:p-8 flex flex-col items-center justify-center font-sans">
      <div className="w-full max-w-4xl space-y-8">
        
        {/* Header */}
        <div className="text-center space-y-3">
          <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-primary/10 text-primary text-xs font-semibold tracking-wide uppercase">
            <Sparkles className="w-4 h-4" />
            Reservatior Akıllı İlan & Onay Motoru
          </div>
          <h1 className="text-3xl sm:text-4xl font-extrabold text-foreground tracking-tight">
            İlan Verme, Emlakçı Seçimi & Platform İçi Onay
          </h1>
          <p className="text-muted-foreground text-sm sm:text-base max-w-xl mx-auto">
            e-Devlet karmaşasına gerek kalmadan ilan onayınızı platform içinde verin, lisanslı danışmanınızı seçin ve güvenli sözleşmenizi oluşturun.
          </p>
        </div>

        {/* Wizard Steps */}
        <div className="grid grid-cols-4 gap-2 sm:gap-4">
          {[
            { step: 1, title: "İlan & Emlakçı Seçimi", icon: Building2 },
            { step: 2, title: "Platform İçi İlan Onayı", icon: UserCheck },
            { step: 3, title: "Kiracı Onayı", icon: CreditCard },
            { step: 4, title: "Resmi Kontrat", icon: FileCheck },
          ].map((item) => {
            const Icon = item.icon;
            const isDone = activeStep > item.step;
            const isCurrent = activeStep === item.step;
            return (
              <div
                key={item.step}
                className={`flex flex-col items-center p-3 rounded-2xl border transition-all ${
                  isCurrent
                    ? "bg-primary/10 border-primary text-primary shadow-lg shadow-primary/10"
                    : isDone
                    ? "bg-blue-500/10 border-blue-500/30 text-blue-600 dark:text-blue-400"
                    : "bg-card border-border text-muted-foreground opacity-60"
                }`}
              >
                <div className="flex items-center justify-center w-8 h-8 rounded-full bg-background mb-1.5 font-bold text-xs">
                  {isDone ? <CheckCircle2 className="w-5 h-5 text-blue-500" /> : <Icon className="w-4 h-4" />}
                </div>
                <span className="text-xs font-bold text-center hidden sm:inline">{item.title}</span>
              </div>
            );
          })}
        </div>

        {/* Main Form Card */}
        <Card className="border border-border/80 shadow-2xl backdrop-blur-xl bg-card/95 rounded-[2.5rem] overflow-hidden">
          <div className="h-1.5 bg-gradient-to-r from-blue-500 via-indigo-500 to-purple-500" />
          <CardContent className="p-6 sm:p-10">
            <AnimatePresence mode="wait">
              
              {/* ──────────────── STEP 1: İlan Detayları & Emlakçı Seçimi ──────────────── */}
              {activeStep === 1 && (
                <m.div
                  key="step1"
                  initial={{ opacity: 0, x: -20 }}
                  animate={{ opacity: 1, x: 0 }}
                  exit={{ opacity: 0, x: 20 }}
                  className="space-y-6"
                >
                  <div className="flex items-center justify-between border-b pb-4">
                    <div>
                      <h2 className="text-xl font-bold text-foreground">1. İlan Bilgileri & Emlakçı / Danışman Seçimi</h2>
                      <p className="text-xs text-muted-foreground">Mülkünüzü yayınlarken hizmet almak istediğiniz yetkili danışmanı belirleyin.</p>
                    </div>
                    <Badge variant={eidsVerified ? "default" : "outline"} className={eidsVerified ? "bg-blue-600 text-white" : ""}>
                      {eidsVerified ? "Doğrulanmış Taşınmaz" : "EİDS Kontrolü"}
                    </Badge>
                  </div>

                  <form onSubmit={handleCreateContract} className="space-y-5">
                    
                    <div>
                      <Label>İlan Başlığı</Label>
                      <Input
                        value={formData.listingTitle}
                        onChange={(e) => setFormData({ ...formData, listingTitle: e.target.value })}
                        className="mt-1 rounded-xl"
                      />
                    </div>

                    <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                      <div>
                        <Label>Takbis / Tapu ID</Label>
                        <div className="flex gap-2 mt-1">
                          <Input
                            value={formData.tapuTakbisId}
                            onChange={(e) => setFormData({ ...formData, tapuTakbisId: e.target.value })}
                            className="rounded-xl"
                          />
                          <Button type="button" onClick={handleVerifyEIDS} disabled={loading} variant="secondary" className="rounded-xl shrink-0">
                            {loading ? "..." : "Sorgula"}
                          </Button>
                        </div>
                      </div>

                      <div>
                        <Label>Aylık Kira Bedeli (TL)</Label>
                        <Input
                          value={formData.monthlyRent}
                          onChange={(e) => setFormData({ ...formData, monthlyRent: e.target.value })}
                          className="mt-1 rounded-xl font-semibold text-primary"
                        />
                      </div>
                    </div>

                    {/* 🏢 Emlakçı Seçim Modülü */}
                    <div className="space-y-3 pt-2">
                      <Label className="text-foreground font-bold flex items-center gap-2">
                        <Award className="w-4 h-4 text-primary" /> Yetkili Emlak Danışmanı / Acente Seçimi
                      </Label>
                      <div className="grid grid-cols-1 sm:grid-cols-3 gap-3">
                        {RECOMMENDED_AGENTS.map((agent) => {
                          const isSelected = formData.selectedAgentId === agent.id;
                          return (
                            <div
                              key={agent.id}
                              onClick={() => setFormData({ ...formData, selectedAgentId: agent.id })}
                              className={`p-4 rounded-2xl border cursor-pointer transition-all flex flex-col justify-between ${
                                isSelected
                                  ? "bg-primary/10 border-primary shadow-lg shadow-primary/10"
                                  : "bg-card border-border hover:border-primary/50"
                              }`}
                            >
                              <div className="flex items-center gap-3 mb-2">
                                <img src={agent.photo} alt={agent.name} className="w-10 h-10 rounded-full object-cover" />
                                <div>
                                  <h4 className="text-xs font-bold text-foreground leading-tight">{agent.name}</h4>
                                  <span className="text-[10px] text-muted-foreground block">{agent.agency}</span>
                                </div>
                              </div>
                              <div className="text-[11px] space-y-1 border-t pt-2 border-border/50">
                                <div className="flex justify-between">
                                  <span className="text-muted-foreground">Lisans No:</span>
                                  <span className="font-mono text-foreground font-medium">{agent.licenseNo}</span>
                                </div>
                                <div className="flex justify-between">
                                  <span className="text-muted-foreground">Komisyon:</span>
                                  <span className="font-bold text-blue-500">{agent.commissionShare}</span>
                                </div>
                              </div>
                            </div>
                          );
                        })}
                      </div>
                    </div>

                    <Button
                      type="submit"
                      disabled={!eidsVerified || loading}
                      className="w-full h-12 bg-gradient-to-r from-blue-600 to-indigo-600 text-white font-bold rounded-xl shadow-xl shadow-blue-500/20"
                    >
                      Devam Et: İlan Onayı Adımına Geç <ChevronRight className="w-5 h-5 ml-1" />
                    </Button>
                  </form>
                </m.div>
              )}

              {/* ──────────────── STEP 2: Platform İçi Onay (No e-Devlet Redirect) ──────────────── */}
              {activeStep === 2 && (
                <m.div
                  key="step2"
                  initial={{ opacity: 0, x: -20 }}
                  animate={{ opacity: 1, x: 0 }}
                  exit={{ opacity: 0, x: 20 }}
                  className="space-y-6 text-center"
                >
                  <div className="w-16 h-16 rounded-2xl bg-primary/10 text-primary flex items-center justify-center mx-auto">
                    <UserCheck className="w-8 h-8" />
                  </div>

                  <div>
                    <h2 className="text-2xl font-bold text-foreground">2. Adım: Platform İçi Doğrudan İlan Onayı</h2>
                    <p className="text-sm text-muted-foreground mt-1 max-w-md mx-auto">
                      e-Devlet menülerinde vakit kaybetmeyin. Telefonunuza gelen SMS onay kodu ile ilanınızı ve seçtiğiniz emlakçıyı anında yetkilendirin.
                    </p>
                  </div>

                  {/* Selected Agent Summary Box */}
                  {selectedAgent && (
                    <div className="p-4 rounded-2xl bg-accent/50 border border-border text-left flex items-center justify-between text-xs">
                      <div className="flex items-center gap-3">
                        <img src={selectedAgent.photo} alt="" className="w-10 h-10 rounded-full" />
                        <div>
                          <p className="font-bold text-foreground">{selectedAgent.name}</p>
                          <p className="text-muted-foreground">{selectedAgent.agency} (Lisans: {selectedAgent.licenseNo})</p>
                        </div>
                      </div>
                      <Badge className="bg-blue-600 text-white">Yetkilendirilecek</Badge>
                    </div>
                  )}

                  {!smsSent ? (
                    <Button
                      onClick={handleSendSMS}
                      disabled={loading}
                      className="w-full h-14 bg-gradient-to-r from-blue-600 to-indigo-600 text-white font-bold rounded-xl text-base shadow-xl shadow-blue-600/20"
                    >
                      {loading ? "SMS Gönderiliyor..." : "SMS Onay Kodu Gönder (Platform İçi Doğrulama)"}
                    </Button>
                  ) : (
                    <div className="space-y-4 max-w-xs mx-auto">
                      <div>
                        <Label className="text-xs">SMS Onay Kodunu Girin (Demo: 884192)</Label>
                        <Input
                          placeholder="6 Haneli Kod"
                          value={smsCode}
                          onChange={(e) => setSmsCode(e.target.value)}
                          className="text-center font-mono text-lg font-bold tracking-widest mt-1 rounded-xl"
                        />
                      </div>
                      <Button
                        onClick={handleVerifySMS}
                        disabled={loading}
                        className="w-full h-12 bg-blue-600 hover:bg-blue-700 text-white font-bold rounded-xl"
                      >
                        {loading ? "Doğrulanıyor..." : "İlanı Onayla & Yetkilendir"}
                      </Button>
                    </div>
                  )}
                </m.div>
              )}

              {/* ──────────────── STEP 3: Kiracı Onayı ──────────────── */}
              {activeStep === 3 && (
                <m.div
                  key="step3"
                  initial={{ opacity: 0, x: -20 }}
                  animate={{ opacity: 1, x: 0 }}
                  exit={{ opacity: 0, x: 20 }}
                  className="space-y-6 text-center"
                >
                  <div className="w-16 h-16 rounded-2xl bg-indigo-500/10 text-indigo-600 flex items-center justify-center mx-auto">
                    <CreditCard className="w-8 h-8" />
                  </div>

                  <div>
                    <h2 className="text-2xl font-bold text-foreground">3. Adım: Kiracı Onayı & Depozito Hesabı</h2>
                    <p className="text-sm text-muted-foreground mt-1 max-w-md mx-auto">
                      Mülk sahibi ve Emlakçı yetkilendirme onayı alındı! 🟢 Kiracı ödeme ve imza sürecini başlatacaktır.
                    </p>
                  </div>

                  <Button
                    onClick={handleTenantApproval}
                    disabled={loading}
                    className="w-full h-14 bg-gradient-to-r from-blue-600 to-blue-600 text-white font-bold rounded-xl text-base shadow-xl shadow-blue-600/20"
                  >
                    {loading ? "Kontrat Hazırlanıyor..." : "Kiracı Onayını Tamamla"}
                  </Button>
                </m.div>
              )}

              {/* ──────────────── STEP 4: Tamamlanan Sözleşme ──────────────── */}
              {activeStep === 4 && (
                <m.div
                  key="step4"
                  initial={{ opacity: 0, scale: 0.95 }}
                  animate={{ opacity: 1, scale: 1 }}
                  className="space-y-6 text-center"
                >
                  <div className="w-20 h-20 rounded-3xl bg-blue-500/20 text-blue-500 flex items-center justify-center mx-auto animate-bounce">
                    <CheckCircle2 className="w-10 h-10" />
                  </div>

                  <div>
                    <h2 className="text-3xl font-extrabold text-foreground">İlan & Sözleşme Başarıyla Yayınlandı!</h2>
                    <p className="text-sm text-muted-foreground mt-1">
                      Platform içi doğrudan onay ile resmi zaman damgalı sözleşmeniz üretildi.
                    </p>
                  </div>

                  <div className="p-4 rounded-2xl bg-card border border-border text-left space-y-2 text-xs">
                    <div className="flex justify-between">
                      <span className="text-muted-foreground">Yetkili Emlak Danışmanı:</span>
                      <span className="font-bold text-foreground">{selectedAgent?.name} ({selectedAgent?.agency})</span>
                    </div>
                    <div className="flex justify-between">
                      <span className="text-muted-foreground">Barkod Referans No:</span>
                      <span className="font-mono font-bold text-primary">{barcodeNo}</span>
                    </div>
                  </div>

                  <Button
                    onClick={() => toast.success("Sözleşme indiriliyor...")}
                    className="w-full h-12 bg-primary text-primary-foreground font-bold rounded-xl"
                  >
                    <Download className="w-5 h-5 mr-2" /> Barkodlu Kontratı İndir
                  </Button>
                </m.div>
              )}

            </AnimatePresence>
          </CardContent>
        </Card>

      </div>
    </div>
  );
}
