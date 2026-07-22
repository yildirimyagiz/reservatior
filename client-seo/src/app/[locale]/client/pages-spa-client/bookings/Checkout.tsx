"use client";

import { useState } from "react";
import { useLocation, useNavigate, useParams } from "@/lib/react-router-shim";
import { m, AnimatePresence } from "framer-motion";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { ShieldCheck, CreditCard, CheckCircle2, Lock, ArrowLeft, Calendar, Users, Building2 } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { format } from "date-fns";
import Image from "next/image";

export default function Checkout() {
  const { id } = useParams<{ id: string }>();
  const location = useLocation();
  const navigate = useNavigate();
  const { toast } = useToast();
  
  const [isProcessing, setIsProcessing] = useState(false);
  const [isSuccess, setIsSuccess] = useState(false);
  const [installments, setInstallments] = useState(1);

  const state = location.state as {
    property: any;
    dateRange: { from: Date; to: Date };
    guests: number;
    totalAmount: number;
  } | null;

  if (!state || !state.property) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-[#0a0a0a] text-white">
        <p>Eksik parametre. Lütfen ilana dönerek tekrar deneyin.</p>
        <Button onClick={() => navigate(-1)} className="ml-4">Geri Dön</Button>
      </div>
    );
  }

  const { property, dateRange, guests, totalAmount } = state;

  const handlePayment = () => {
    setIsProcessing(true);
    // Simulate Open Banking Escrow / Stripe Pre-Auth
    setTimeout(() => {
      setIsProcessing(false);
      setIsSuccess(true);
      toast({
        title: "Ödeme Başarılı!",
        description: "Tutar Escrow havuzuna alındı. İyi tatiller dileriz.",
      });
      setTimeout(() => {
        navigate("/dashboard");
      }, 2000);
    }, 2000);
  };

  return (
    <div className="min-h-screen bg-[#0a0a0a] text-white py-24 px-4 sm:px-6 lg:px-8">
      <div className="max-w-6xl mx-auto">
        <button onClick={() => navigate(-1)} className="flex items-center text-white/50 hover:text-white transition-colors mb-8">
          <ArrowLeft className="w-5 h-5 mr-2" /> Geri Dön
        </button>

        <div className="grid grid-cols-1 lg:grid-cols-12 gap-12">
          
          {/* LEFT: Payment Form */}
          <div className="lg:col-span-7 space-y-8">
            <div>
              <h1 className="text-4xl font-black mb-2">Ödeme & Escrow Güvencesi</h1>
              <p className="text-white/50">Güvenli ödeme altyapımız sayesinde paranız, siz giriş yapana kadar bizde güvende.</p>
            </div>

            {/* Escrow Banner */}
            <div className="p-6 rounded-3xl bg-emerald-500/10 border border-emerald-500/20 space-y-4">
              <div className="flex items-center gap-3">
                <ShieldCheck className="w-8 h-8 text-emerald-400" />
                <h3 className="font-black text-emerald-400 text-lg">Reservatior SafeStay™ Koruması Aktif</h3>
              </div>
              <p className="text-sm text-emerald-100/70 leading-relaxed">
                Bu ödeme <b>Açık Bankacılık</b> ile Bloke edilir (Pre-Auth). Tutar, ev sahibine hemen <b>geçmez</b>. Havuz hesabımızda tutulur ve siz tesise giriş yaptıktan (check-in) 24 saat sonra bir sorun bildirmezseniz ev sahibinin hesabına aktarılır (Capture).
              </p>
            </div>

            {/* Payment Info */}
            <div className="space-y-6 bg-white/5 p-8 rounded-4xl border border-white/5">
              <div className="flex items-center gap-3 mb-6 border-b border-white/5 pb-6">
                <CreditCard className="w-6 h-6 text-white/50" />
                <h2 className="text-xl font-bold">Ödeme Bilgileri</h2>
              </div>
              
              <div className="space-y-4">
                <div className="space-y-2">
                  <Label className="text-white/70">Kart Üzerindeki İsim</Label>
                  <Input 
                    type="text"
                    placeholder="Ad Soyad"
                    className="bg-black/50 border-white/10 h-12"
                  />
                </div>
                
                <div className="space-y-2">
                  <Label className="text-white/70">Kart Numarası</Label>
                  <div className="relative">
                    <Input 
                      type="text"
                      placeholder="0000 0000 0000 0000"
                      className="bg-black/50 border-white/10 h-12 pl-12"
                    />
                    <CreditCard className="absolute left-4 top-1/2 -translate-y-1/2 w-5 h-5 text-white/30" />
                  </div>
                </div>

                <div className="grid grid-cols-2 gap-4">
                  <div className="space-y-2">
                    <Label className="text-white/70">Son Kullanma (AA/YY)</Label>
                    <Input 
                      type="text"
                      placeholder="MM/YY"
                      className="bg-black/50 border-white/10 h-12"
                    />
                  </div>
                  <div className="space-y-2">
                    <Label className="text-white/70">CVC/CVV</Label>
                    <Input 
                      type="text"
                      placeholder="123"
                      className="bg-black/50 border-white/10 h-12"
                    />
                  </div>
                </div>
              </div>

              <div className="pt-6 border-t border-white/5">
                <Button 
                  onClick={handlePayment} 
                  disabled={isProcessing || isSuccess}
                  className="w-full h-16 rounded-2xl bg-emerald-600 hover:bg-emerald-500 text-white font-black text-lg tracking-widest shadow-2xl shadow-emerald-600/30 flex justify-center items-center gap-2"
                >
                  {isProcessing ? (
                    <m.div animate={{ rotate: 360 }} transition={{ repeat: Infinity, duration: 1, ease: "linear" }}>
                      <Lock className="w-5 h-5" />
                    </m.div>
                  ) : isSuccess ? (
                    <>
                      <CheckCircle2 className="w-5 h-5" /> Başarılı
                    </>
                  ) : (
                    <>
                      <Lock className="w-5 h-5" /> ŞİMDİ ÖDE VE REZERVE ET
                    </>
                  )}
                </Button>
                <p className="text-center text-xs text-white/30 mt-4 flex items-center justify-center gap-1">
                  <Lock className="w-3 h-3" /> 256-bit SSL şifreleme ile korunmaktadır
                </p>
              </div>
            </div>
          </div>

          {/* RIGHT: Summary */}
          <div className="lg:col-span-5">
            <div className="bg-[#14151a] rounded-4xl border border-white/5 p-8 sticky top-24 shadow-2xl">
              <h3 className="text-xl font-bold mb-6">Rezervasyon Özeti</h3>
              
              <div className="flex gap-4 mb-8">
                {property.photos && property.photos.length > 0 ? (
                  <div className="relative w-24 h-24 shrink-0 overflow-hidden rounded-2xl">
                    <Image src={property.photos[0].url} alt={property.name} fill className="object-cover" loading="lazy" sizes="96px" />
                  </div>
                ) : (
                  <div className="w-24 h-24 rounded-2xl bg-white/5 flex items-center justify-center">
                    <Building2 className="w-8 h-8 text-white/20" />
                  </div>
                )}
                <div className="flex flex-col justify-center">
                  <p className="text-xs text-emerald-400 font-bold uppercase tracking-widest mb-1">{property.type}</p>
                  <h4 className="font-bold text-lg leading-tight">{property.name}</h4>
                  <p className="text-sm text-white/50">{property.city}</p>
                </div>
              </div>

              <div className="space-y-4 mb-8">
                <div className="flex justify-between items-center bg-white/5 p-4 rounded-2xl">
                  <div className="flex items-center gap-3">
                    <Calendar className="w-5 h-5 text-emerald-400" />
                    <div>
                      <p className="text-xs text-white/50">Tarihler</p>
                      <p className="text-sm font-semibold">{format(dateRange.from, "MMM d")} - {format(dateRange.to, "MMM d, yyyy")}</p>
                    </div>
                  </div>
                </div>
                <div className="flex justify-between items-center bg-white/5 p-4 rounded-2xl">
                  <div className="flex items-center gap-3">
                    <Users className="w-5 h-5 text-emerald-400" />
                    <div>
                      <p className="text-xs text-white/50">Misafir</p>
                      <p className="text-sm font-semibold">{guests} Misafir</p>
                    </div>
                  </div>
                </div>
              </div>

              <div className="border-t border-white/5 pt-6 space-y-4">
                <div className="flex justify-between items-center bg-emerald-500/10 p-3 rounded-xl border border-emerald-500/20 mb-4">
                  <div className="flex flex-col">
                    <span className="text-sm font-bold text-emerald-400">Reservatior Avantajı Aktif!</span>
                    <span className="text-xs text-emerald-100/70">Komisyon ve depozito yükü aylara bölündü. Peşinat ödemiyorsunuz.</span>
                  </div>
                </div>

                <div className="flex justify-between text-white/70">
                  <span>İlk Ay Kirası</span>
                  <span>${(totalAmount * 0.8).toFixed(0)}</span>
                </div>
                <div className="flex justify-between text-white/70">
                  <span>Aylık Depozito Payı (1/12)</span>
                  <span>${((totalAmount * 0.8) / 12).toFixed(0)}</span>
                </div>
                <div className="flex justify-between text-white/70">
                  <span>Aylık Komisyon Payı (%3.5)</span>
                  <span>${((totalAmount * 0.8) * 0.035).toFixed(0)}</span>
                </div>
                <div className="flex justify-between text-xl font-black pt-4 border-t border-white/5">
                  <span>Bu Ay Ödenecek Toplam</span>
                  <span className="text-emerald-400">
                    ${(
                      (totalAmount * 0.8) + 
                      ((totalAmount * 0.8) / 12) + 
                      ((totalAmount * 0.8) * 0.035)
                    ).toFixed(0)}
                  </span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
