"use client";

import React, { useState, useMemo } from "react";
import { m, AnimatePresence } from "framer-motion";
import { X, SlidersHorizontal, Check, ShieldCheck, Award, Building2, Home, Sparkles, DollarSign, Key, TrendingUp, HelpCircle } from "lucide-react";
import { Button } from "@/components/ui/button";
import { useRouter } from "next/navigation";

interface AdvancedFilterModalProps {
  isOpen: boolean;
  onClose: () => void;
  searchMode: "STAY" | "BUY" | "RENT" | "INVEST";
  selectedCountry: string;
}

export function AdvancedFilterModal({ isOpen, onClose, searchMode, selectedCountry }: AdvancedFilterModalProps) {
  const router = useRouter();

  // Selected State
  const [selectedRooms, setSelectedRooms] = useState<string[]>([]);
  const [selectedCompliance, setSelectedCompliance] = useState<string[]>([]);
  const [selectedTypes, setSelectedTypes] = useState<string[]>([]);
  const [selectedAmenities, setSelectedAmenities] = useState<string[]>([]);
  const [priceRange, setPriceRange] = useState<string>("all");
  const [minRoi, setMinRoi] = useState<string>("all");

  // Çok uluslu gayrimenkul alan standadı algılayıcısı (m² vs sq ft)
  const isImperialCountry = useMemo(() => {
    const code = (selectedCountry || "").toUpperCase().trim();
    return ["US", "GB", "CA", "IN", "MY"].includes(code);
  }, [selectedCountry]);

  const areaUnit = isImperialCountry ? "sq ft" : (selectedCountry || "").toUpperCase() === "AE" ? "m² / sq ft" : "m²";
  const areaPresets = isImperialCountry 
    ? ["500+ sq ft", "1,000+ sq ft", "2,000+ sq ft", "3,500+ sq ft", "5,000+ sq ft", "10,000+ sq ft"]
    : ["50+ m²", "100+ m²", "180+ m²", "320+ m²", "500+ m²", "1.000+ m²"];

  // Profesyonel, sektörel ve ülkeye özgü içerik kurgusu
  const modalConfig = useMemo(() => {
    const countryCode = selectedCountry.toUpperCase();

    // 1. STAY (Kısa Dönem Konaklama) & RENT (Uzun Dönem Kiralık)
    if (searchMode === "STAY" || searchMode === "RENT") {
      const complianceItems = [
        "SafeStay™ Depozito ve Güvence Hesabı Korumalı",
        "Dijital Akıllı Kira Sözleşmesi ile Anlaşılır Koşullar",
        "Ev Sahibi ile %0 Komisyon Doğrudan Ödeme Seçeneği",
        "Düzenli Temizlik ve Profesyonel Site Tesis Desteği"
      ];

      if (countryCode === "AE" || countryCode === "DUBAI" || countryCode === "AED") {
        complianceItems.push(
          "EJARI Resmi Kiralama Kaydı Mevcut",
          "Chiller Free (Klima ve Soğutma Giderleri Aidattan Muaf)",
          "DEWA Depozitosu ve Ön Abonelik Kurulumu Tamamlandı"
        );
      } else if (countryCode === "GB" || countryCode === "UK") {
        complianceItems.push(
          "EICR (Elektrik Tesisat Güvenlik Sertifikası) Onaylı",
          "Gaz Güvenlik Sertifikası (Gas Safety Certificate) Geçerli",
          "Düşük Vergi Dilimi (Council Tax Band A/B)",
          "TDS (Tenancy Deposit Scheme) Mevduat Koruması"
        );
      } else if (countryCode === "TR") {
        complianceItems.push(
          "Site İçi Güvenlik ve Sosyal Tesis İki Yetkili Kiralama",
          "Aidat ve Merkezi Isıtma Giderleri Dâhil Şeffaf Kontrat",
          "İskan Ruhsatanı Alınmış Güvenli Konutlar",
          "Aile ve Evcil Hayvan Yaşamına Tam Uyumlu Site"
        );
      } else if (countryCode === "US" || countryCode === "CA") {
        complianceItems.push(
          "Depozitosuz Kiralama Seçeneği (SafeStay Sigorta Opsiyonu)",
          "Isıtma, Su ve Temel Faturalar Dâhil (Utilities Included)",
          "Özel Garaj ve Misafir Otoparki Dâhil"
        );
      }

      return {
        themeColor: "text-purple-400",
        badgeBg: "bg-purple-500/10 text-purple-400 border-purple-500/20",
        headerTitle: searchMode === "STAY" ? "Günlük ve Kısa Dönem Konaklama Filtreleri" : "Uzun Dönem Kiralık Konut Filtreleri",
        headerSubtitle: "Kiralama Güvencesi, Sözleşme Tipi ve Yaşam Donanımları",
        section1Title: "Kiralama Güvenceleri ve Ülke Kuralları",
        section1Badge: "Yasal Uygunluk",
        section1Items: complianceItems,
        section2Title: "Sözleşme Koşulları ve Ev Kriterleri",
        section2Items: [
          "Evcil Hayvan Kabul Ediyor",
          "Tüm Faturalar Kiraya Dâhil",
          "Tam Eşyalı (Beyaz Eşya ve Mobilyalı)",
          "Anında Rezervasyon ve Çevrimiçi Onay",
          "Özel Otopark veya Kapalı Garaj Mevcut",
          "Sigara İçilmeyen Temiz Yaşam Alanı",
          "Çok Yüksek Hızlı Fiber İnternet Altyapısı",
          "Yüksek Giriş Katı veya Engelsiz Erişim"
        ],
        showRoi: false,
        buttonText: searchMode === "STAY" ? "Konaklama Filtrelerini Uygula" : "Kiralama Filtrelerini Uygula",
        priceLabels: [
          { label: "Tüm Bütçeler", val: "all" },
          { label: "$50 - $120 / Gün", val: "50-120" },
          { label: "$120 - $250 / Gün", val: "120-250" },
          { label: "$250+ / Gün", val: "250-plus" }
        ]
      };
    }

    // 2. INVEST (Yatırımcı ve Getiri Odaklı Filtreler)
    if (searchMode === "INVEST") {
      const investItems = [
        "Partner OS Profesyonel Mülk Yönetimi ve Operasyon Desteği",
        "Piyasa Değerlemesinin Altında (Arbitraj Fırsatlı Portföyler)",
        "Kısa Dönem Kiralamaya Uygun (Yüksek Ciro ve Doluluk Potansiyeli)",
        "Yapay Zeka Destekli 5 Yıllık Değerleme ve Trend Analiz Raporlu",
        "SafeStay™ Escrow Korumalı Düzenli Nakit Akışı Operasyonu",
        "Dövize Endeksli veya Teminatlı Aylık Yüksek Kira Getirisi"
      ];

      if (countryCode === "AE" || countryCode === "DUBAI") {
        investItems.unshift(
          "≥2M AED Dubai Golden Visa Başvurusuna Uygun Projeler",
          "RERA Escrow Banka Korumalı ve DLD Onaylı Ödeme Planı",
          "DLD Taqyoom Değerleme Raporlu Oqood Kayıtlı Proje"
        );
      } else if (countryCode === "TR") {
        investItems.unshift(
          "$400,000 ve Üzeri İstisnai Vatandaşlık Başvurusuna Uygun",
          "SPK Lisanslı Kurum Tarafından Onaylı Yüksek Ekspertiz Değeri",
          "Projeden Taksitli ve İnşaat Aşamasında Yüksek Değer Kazançlı"
        );
      } else if (countryCode === "GB" || countryCode === "UK") {
        investItems.unshift(
          "Buy-to-Let (Yıllık %8+ GBP Net Kira Getiri Doğrulamalı)",
          "RICS Lisanslı Bağımsız Ekspertiz Değerlendirmesi Yapıldı",
          "EPC A/B Enerji Verimlilik Sertifikası ile Düşük Faizli Yeşil Kredi"
        );
      }

      return {
        themeColor: "text-emerald-400",
        badgeBg: "bg-emerald-500/10 text-emerald-400 border-emerald-500/20",
        headerTitle: "Yatırım, ROI ve Gayrimenkul Finansı Filtreleri",
        headerSubtitle: "Getiri Oranları, Operasyon Modelleri ve Risk Değerleme Raporları",
        section1Title: "Finansal Güvenlik ve Yatırım Kriterleri",
        section1Badge: "Finansal Doğrulama",
        section1Items: investItems,
        section2Title: "Operasyon ve Yönetim Stratejisi",
        section2Items: [
          "Anahtar Teslim Profesyonel Mülk Yönetimi",
          "Escrow Güvenceli Düzenli Kira Havuzu",
          "Kısa Dönem Kiralama (STR / Airbnb) İzinli Mülk",
          "İnşaat Aşamasında (Off-Plan) Erken Dönem Projeler",
          "Ticari ve Kurumsal Yeniden Satış (Resale) Fırsatları",
          "Restorasyon veya Yenileme ile Katma Değer Yaratma"
        ],
        showRoi: true,
        buttonText: "Yatırım Filtrelerini Uygula",
        priceLabels: [
          { label: "Tüm Yatırım Bütçeleri", val: "all" },
          { label: "$100,000 - $250,000", val: "100k-250k" },
          { label: "$250,000 - $500,000", val: "250k-500k" },
          { label: "$500,000 ve Üzeri", val: "500k-plus" }
        ]
      };
    }

    // 3. BUY (Satılık Mülkler - Standart Alım Filtreleri)
    const buyCompliance = [
      "Bağımsız Lisanslı Değerleme Raporu Mevcut (SPK / RICS Onaylı)",
      "Banka Kredi ve Mortgage Kullanımına %100 Uygun",
      "İskan (Yapı Kullanım İznin) Alınmış Kat Mülkiyetli Bina",
      "Tapu ve İpotek Temizliği Doğrulanmış (Sıfır Hukuki Pürüz)",
      "Akıllı Ev ve Yüksek Enerji Verimliliği Standartlarına Uygun"
    ];

    let ownershipTypes = ["Kat Mülkiyeti (Tam Müstakil Tapu)", "Kat İrtifakı (Projeden)", "Müstakil Arsa Paylı", "Ticari İzinli Konut"];

    if (countryCode === "TR") {
      buyCompliance.unshift(
        "$400,000 ve Üzeri Türk Vatandaşlığı Başvurusuna Uygun", 
        "SPK Lisanslı Değerleme ve Ekspertiz Raporlu", 
        "2018 ve Sonrası Güncel Deprem Yönetmeliğine Uyumlu Yapı"
      );
      ownershipTypes = ["Kat Mülkiyetli (İskanlı)", "Kat İrtifaklı Tapu", "Müstakil Tapulu Konut", "Arsa Paylı Lüks Villa", "Takasa Uygun Mülk"];
    } else if (countryCode === "AE" || countryCode === "DUBAI" || countryCode === "AED") {
      buyCompliance.unshift(
        "≥2M AED 10 Yıllık Dubai Golden Visa Uyumlu Projeler", 
        "DLD Taqyoom Lisanslı Değerleme ve Oqood Belgesi Mevcut", 
        "Chiller Free (Klima Gideri Aidattan Muaf)"
      );
      ownershipTypes = ["Freehold (Yabancılara Süresiz Tam Mülkiyet)", "Leasehold (99 Yıl Kiralama Hakkı)", "Off-Plan (DLD Kayıtlı Proje)", "Hemen Teslim (Ready to Move)"];
    } else if (countryCode === "GB" || countryCode === "UK") {
      buyCompliance.unshift(
        "RICS Chartered Surveyor Tarafından Değerleme Yapıldı", 
        "EPC Enerji Verimliliği (Rating A veya B)", 
        "EWS1 Yangın Güvenliği Sertifikasına Sahip"
      );
      ownershipTypes = ["Freehold (Süresiz ve Arsa Paylı Tam Mülkiyet)", "Leasehold (999 Yıl Kira Değeri)", "Share of Freehold (Paylı Mülkiyet)", "Yeni İnşaat (New Build)"];
    } else if (countryCode === "US" || countryCode === "CA") {
      buyCompliance.unshift(
        "Düşük Site ve HOA Aidat Giderleri (< $200 / ay)", 
        "RPAC veya Resmi Lisanslı Appraisal Raporlu", 
        "Title Insurance (Tapu Temizliği Sigortalanmış)"
      );
      ownershipTypes = ["Müstakil Ev (Single Family Residence)", "Rezidans ve Penthouse (Condo)", "Dupleks ve İkiz Konut (Townhouse)", "Ticari veya İmar Arsa"];
    }

    return {
      themeColor: "text-amber-400",
      badgeBg: "bg-amber-500/10 text-amber-400 border-amber-500/20",
      headerTitle: "Satılık Gayrimenkul ve Tapu Filtreleri",
      headerSubtitle: "Mülkiyet Tipi, Yasal Uygunluk ve Bağımsız Ekspertiz Raporları",
      section1Title: "Yasal Uygunluk ve Ekspertiz Kriterleri",
      section1Badge: "Resmi Belge & Değerleme",
      section1Items: buyCompliance,
      section2Title: "Mülkiyet Tipi ve Tapu Durumu",
      section2Items: ownershipTypes,
      showRoi: true,
      buttonText: "Satılık Mülk Filtrelerini Uygula",
      priceLabels: [
        { label: "Tüm Satış Bütçeleri", val: "all" },
        { label: "$100,000 - $250,000", val: "100k-250k" },
        { label: "$250,000 - $500,000", val: "250k-500k" },
        { label: "$500,000 ve Üzeri", val: "500k-plus" }
      ]
    };
  }, [searchMode, selectedCountry]);

  const toggleItem = (list: string[], setList: (arr: string[]) => void, item: string) => {
    if (list.includes(item)) {
      setList(list.filter((i) => i !== item));
    } else {
      setList([...list, item]);
    }
  };

  const handleApply = () => {
    const params = new URLSearchParams();
    params.append("listingType", searchMode === "STAY" ? "RENT" : searchMode);
    params.append("country", selectedCountry);
    if (selectedRooms.length > 0) params.append("rooms", selectedRooms.join(","));
    if (selectedTypes.length > 0) params.append("types", selectedTypes.join(","));
    if (selectedCompliance.length > 0) params.append("compliance", selectedCompliance.join(","));
    if (selectedAmenities.length > 0) params.append("amenities", selectedAmenities.join(","));
    if (priceRange !== "all") params.append("price", priceRange);
    if (minRoi !== "all") params.append("roi", minRoi);

    router.push(`/property?${params.toString()}`);
    onClose();
  };

  const handleReset = () => {
    setSelectedRooms([]);
    setSelectedCompliance([]);
    setSelectedTypes([]);
    setSelectedAmenities([]);
    setPriceRange("all");
    setMinRoi("all");
  };

  if (!isOpen) return null;

  return (
    <AnimatePresence>
      <div className="fixed inset-0 z-[110] flex items-center justify-center p-3 sm:p-6">
        {/* Arka Plan Karartma */}
        <m.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          exit={{ opacity: 0 }}
          onClick={onClose}
          className="fixed inset-0 bg-black/70 backdrop-blur-md"
        />

        {/* Modal Window */}
        <m.div
          initial={{ opacity: 0, scale: 0.96, y: 16 }}
          animate={{ opacity: 1, scale: 1, y: 0 }}
          exit={{ opacity: 0, scale: 0.96, y: 16 }}
          transition={{ duration: 0.25, ease: [0.16, 1, 0.3, 1] }}
          className="relative z-10 w-full max-w-4xl max-h-[90vh] bg-background dark:bg-[#0f1117] border border-border/70 rounded-[1.75rem] shadow-2xl overflow-hidden flex flex-col backdrop-blur-xl"
        >
          {/* Başlık (Header) */}
          <div className="px-6 py-5 border-b border-border/70 flex items-center justify-between bg-muted/20">
            <div className="flex items-center gap-3.5">
              <div className="w-11 h-11 rounded-2xl bg-gradient-to-br from-slate-800 via-indigo-600 to-purple-600 flex items-center justify-center text-white shadow-md border border-white/10 shrink-0">
                {searchMode === "STAY" || searchMode === "RENT" ? <Key className="w-5 h-5 text-purple-300" /> : searchMode === "INVEST" ? <TrendingUp className="w-5 h-5 text-emerald-300" /> : <Building2 className="w-5 h-5 text-amber-300" />}
              </div>
              <div>
                <div className="flex items-center gap-2 flex-wrap mb-0.5">
                  <h2 className="text-base md:text-lg font-extrabold tracking-tight text-foreground">
                    {modalConfig.headerTitle}
                  </h2>
                  <span className={`text-[11px] font-bold uppercase px-2.5 py-0.5 rounded-full border ${modalConfig.badgeBg}`}>
                    {selectedCountry.toUpperCase()} Bölgesi
                  </span>
                </div>
                <p className="text-xs text-muted-foreground font-medium flex items-center gap-1.5">
                  <span>{modalConfig.headerSubtitle}</span>
                </p>
              </div>
            </div>
            <button
              onClick={onClose}
              className="w-9 h-9 rounded-full bg-white/5 hover:bg-white/10 border border-white/10 flex items-center justify-center text-muted-foreground hover:text-white transition-colors shrink-0"
            >
              <X className="w-4 h-4" />
            </button>
          </div>

          {/* İçeriği Kayan Alan */}
          <div className="flex-1 overflow-y-auto p-6 md:p-8 space-y-7 no-scrollbar">
            
            {/* BÖLÜM 1: ÜLKEYE ÖZEL YASAL UYGUNLUK VE EKSPERTİZ */}
            <div className="space-y-3.5">
              <div className="flex items-center justify-between">
                <div className="flex items-center gap-2">
                  <ShieldCheck className={`w-5 h-5 ${modalConfig.themeColor}`} />
                  <h3 className="font-bold text-base text-foreground tracking-tight">{modalConfig.section1Title}</h3>
                </div>
                <span className="text-[11px] font-semibold px-2.5 py-1 bg-muted text-muted-foreground rounded-md border border-border/60">
                  {modalConfig.section1Badge}
                </span>
              </div>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-2">
                {modalConfig.section1Items.map((item, idx) => {
                  const isSelected = selectedCompliance.includes(item);
                  return (
                    <div
                      key={idx}
                      onClick={() => toggleItem(selectedCompliance, setSelectedCompliance, item)}
                      className={`p-3.5 rounded-xl border cursor-pointer transition-all flex items-center justify-between text-xs sm:text-sm font-medium select-none ${
                        isSelected
                          ? "bg-primary/10 border-primary text-primary font-semibold shadow-sm"
                          : "bg-muted/30 hover:bg-muted/60 border-border/70 text-muted-foreground hover:text-foreground"
                      }`}
                    >
                      <span className="pr-2 leading-relaxed">{item}</span>
                      <div className={`w-5 h-5 rounded-md flex items-center justify-center border transition-colors shrink-0 ${
                        isSelected ? "bg-primary border-primary text-primary-foreground" : "border-muted-foreground/40 bg-transparent"
                      }`}>
                        {isSelected && <Check className="w-3 h-3 stroke-[3]" />}
                      </div>
                    </div>
                  );
                })}
              </div>
            </div>

            <div className="h-[1px] w-full bg-border/50" />

            {/* BÖLÜM 2: ODA SAYISI VE MÜLKİYET / KONUT ÖZELLİKLERİ */}
            <div className="space-y-5">
              {/* Oda Sayısı Seçimleri */}
              <div>
                <div className="flex items-center gap-2 mb-3">
                  <Home className="w-5 h-5 text-amber-400" />
                  <h3 className="font-bold text-base text-foreground tracking-tight">Oda Sayısı ve Mülk Tipi</h3>
                </div>
                <div className="flex flex-wrap gap-2">
                  {["1+0", "1+1", "2+1", "3+1", "4+1", "5+1+", "Villa / Müstakil", "Penthouse", "Arsa / Arazi"].map((room) => {
                    const isSelected = selectedRooms.includes(room);
                    return (
                      <button
                        key={room}
                        type="button"
                        onClick={() => toggleItem(selectedRooms, setSelectedRooms, room)}
                        className={`px-4 py-2.5 rounded-xl text-xs font-semibold transition-all border ${
                          isSelected
                            ? "bg-amber-500 text-black border-amber-500 font-bold shadow-sm"
                            : "bg-muted/40 hover:bg-muted text-muted-foreground hover:text-foreground border-border/70"
                        }`}
                      >
                        {room}
                      </button>
                    );
                  })}
                </div>
              </div>

              {/* Çok Uluslu Mülk Alanı (m² / sq ft) */}
              <div className="pt-3 border-t border-border/40">
                <div className="flex items-center justify-between mb-3">
                  <div className="flex items-center gap-2">
                    <span className="text-sm font-black text-amber-500">📐</span>
                    <h3 className="font-bold text-base text-foreground tracking-tight">
                      Minimum Mülk Alanı <span className="text-amber-500 font-normal">({areaUnit})</span>
                    </h3>
                  </div>
                  <span className="text-[10px] font-bold uppercase tracking-wider text-muted-foreground bg-muted px-2.5 py-1 rounded-full border border-border/50">
                    {selectedCountry || "GLOBAL"} ÖLÇÜM STANDARDLARI
                  </span>
                </div>
                <div className="flex flex-wrap gap-2">
                  {areaPresets.map((area) => (
                    <button
                      key={area}
                      type="button"
                      onClick={() => toggleItem(selectedRooms, setSelectedRooms, area)}
                      className={`px-4 py-2 rounded-xl text-xs font-semibold transition-all border ${
                        selectedRooms.includes(area)
                          ? "bg-amber-500/20 text-amber-400 border-amber-500/60 font-bold shadow-sm"
                          : "bg-muted/30 hover:bg-muted/50 text-muted-foreground hover:text-foreground border-border/50"
                      }`}
                    >
                      {area}
                    </button>
                  ))}
                </div>
              </div>

              {/* Mülkiyet Tipi veya Sözleşme Şartları */}
              <div>
                <h4 className="text-[11px] font-bold uppercase tracking-widest text-muted-foreground mb-2.5 flex items-center gap-1.5">
                  <Award className="w-3.5 h-3.5 text-indigo-400" />
                  <span>{modalConfig.section2Title}</span>
                </h4>
                <div className="grid grid-cols-2 sm:grid-cols-3 gap-2">
                  {modalConfig.section2Items.map((typeItem) => {
                    const isSelected = selectedTypes.includes(typeItem);
                    return (
                      <div
                        key={typeItem}
                        onClick={() => toggleItem(selectedTypes, setSelectedTypes, typeItem)}
                        className={`p-3 rounded-xl border text-center text-xs cursor-pointer transition-all flex items-center justify-center font-medium ${
                          isSelected
                            ? "bg-indigo-500/15 border-indigo-500 text-indigo-300 font-bold shadow-sm"
                            : "bg-muted/30 hover:bg-muted/60 border-border/70 text-muted-foreground hover:text-foreground"
                        }`}
                      >
                        {typeItem}
                      </div>
                    );
                  })}
                </div>
              </div>
            </div>

            <div className="h-[1px] w-full bg-border/50" />

            {/* BÖLÜM 3: BÜTÇE ARALIĞI VE GETİRİ ORANLARI */}
            <div className={`grid grid-cols-1 ${modalConfig.showRoi ? "md:grid-cols-2" : ""} gap-6`}>
              {/* Bütçe */}
              <div className="space-y-3">
                <div className="flex items-center gap-2">
                  <DollarSign className="w-5 h-5 text-emerald-400" />
                  <h3 className="font-bold text-base text-foreground tracking-tight">Fiyat ve Bütçe Hedefi</h3>
                </div>
                <div className="grid grid-cols-2 sm:grid-cols-4 md:grid-cols-2 lg:grid-cols-4 gap-2">
                  {modalConfig.priceLabels.map((btn) => (
                    <button
                      key={btn.val}
                      type="button"
                      onClick={() => setPriceRange(btn.val)}
                      className={`py-2.5 px-3 rounded-xl text-xs font-semibold border transition-all truncate ${
                        priceRange === btn.val
                          ? "bg-emerald-600 text-white font-bold border-transparent shadow-sm"
                          : "bg-muted/30 hover:bg-muted text-muted-foreground border-border/70"
                      }`}
                    >
                      {btn.label}
                    </button>
                  ))}
                </div>
              </div>

              {/* Yatırım Getiri Oranı (Sadece BUY ve INVEST için) */}
              {modalConfig.showRoi && (
                <div className="space-y-3">
                  <div className="flex items-center gap-2">
                    <TrendingUp className="w-5 h-5 text-purple-400" />
                    <h3 className="font-bold text-base text-foreground tracking-tight">Minimum Yıllık Kira Getirisi (ROI)</h3>
                  </div>
                  <div className="grid grid-cols-2 gap-2">
                    {[
                      { label: "Tüm Getiri Oranları", val: "all" },
                      { label: "%6+ Dövize Endeksli", val: "6-plus" },
                      { label: "%8 - %10 Yüksek Getiri", val: "8-10" },
                      { label: "%12+ Değer Artış Odaklı", val: "12-plus" }
                    ].map((btn) => (
                      <button
                        key={btn.val}
                        type="button"
                        onClick={() => setMinRoi(btn.val)}
                        className={`py-2.5 px-3 rounded-xl text-xs font-semibold border transition-all truncate ${
                          minRoi === btn.val
                            ? "bg-purple-600 text-white font-bold border-transparent shadow-sm"
                            : "bg-muted/30 hover:bg-muted text-muted-foreground border-border/70"
                        }`}
                      >
                        {btn.label}
                      </button>
                    ))}
                  </div>
                </div>
              )}
            </div>

            <div className="h-[1px] w-full bg-border/50" />

            {/* BÖLÜM 4: DONANIMLAR VE TEKNik ÖZELLİKLER */}
            <div className="space-y-3 pb-1">
              <div className="flex items-center gap-2">
                <Sparkles className="w-5 h-5 text-indigo-400" />
                <h3 className="font-bold text-base text-foreground tracking-tight">Konut Donanımları ve Site Olanakları</h3>
              </div>
              <div className="flex flex-wrap gap-2">
                {[
                  "Akıllı Ev Sistemi (Smart Home)",
                  "Özel Yüzme Havuzu",
                  "Deniz ve Boğaz Manzarası",
                  "7/24 Özel Güvenlik ve Kamera",
                  "Sauna, Hamam ve Spor Salonu",
                  "Yerden Isıtma ve VRF Klima",
                  "Denize ve Plaja Sıfır Konum",
                  "Kapalı Garaj ve Elektrikli Şarj",
                  "Jeneratör ve Su Deposu Altyapısı"
                ].map((amenity) => {
                  const isSelected = selectedAmenities.includes(amenity);
                  return (
                    <button
                      key={amenity}
                      type="button"
                      onClick={() => toggleItem(selectedAmenities, setSelectedAmenities, amenity)}
                      className={`px-3.5 py-2 rounded-xl text-xs font-medium transition-all border ${
                        isSelected
                          ? "bg-indigo-500/15 border-indigo-500 text-indigo-300 font-semibold"
                          : "bg-muted/30 hover:bg-muted/60 border-border/70 text-muted-foreground hover:text-foreground"
                      }`}
                    >
                      {amenity}
                    </button>
                  );
                })}
              </div>
            </div>

          </div>

          {/* Alt Bilgi Barı */}
          <div className="px-6 py-4 border-t border-border/70 bg-muted/20 flex items-center justify-between gap-4">
            <button
              type="button"
              onClick={handleReset}
              className="text-xs font-semibold text-muted-foreground hover:text-foreground underline transition-colors px-2"
            >
              Seçimleri Temizle
            </button>
            <Button
              type="button"
              onClick={handleApply}
              className="rounded-full bg-gradient-to-r from-slate-900 to-slate-800 dark:from-white dark:to-slate-100 dark:text-black hover:opacity-95 text-white font-bold px-7 py-5 text-sm shadow-md transition-all hover:scale-[1.01]"
            >
              <span>{modalConfig.buttonText}</span>
              <Check className="w-4 h-4 ml-2 stroke-[3]" />
            </Button>
          </div>
        </m.div>
      </div>
    </AnimatePresence>
  );
}
