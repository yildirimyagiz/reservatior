import { Helmet } from "react-helmet-async";
import { useTranslation } from "react-i18next";
import { Link } from "react-router-dom";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { useState } from "react";
import { motion, AnimatePresence } from "framer-motion";
import { useAuth } from "@/lib/auth/hooks";
import {
  Bot, Video, BarChart3, Shield, Globe2, Zap, Users, Lock,
  Building2, CheckCircle2, ArrowRight, Sparkles, Star,
  Brain, Eye, Target, FileSearch, CreditCard, CalendarCheck,
  MessageSquare, Bell, Palette, TrendingUp, Search, MapPin,
  Camera, Cpu, Workflow, CloudCog, Database, Wifi, Sliders,
  Play, Check, Thermometer, ShieldAlert, KeyRound, Sparkle,
  RefreshCw, UploadCloud, Volume2, Film, ShieldCheck, ClipboardList,
  AlertTriangle, Landmark, FileSpreadsheet, Download, HelpCircle,
  EyeOff, UserCheck, Info
} from "lucide-react";

/* ═══════════════════════════════════════════════════════════════════════════════
   THEME-AWARE & ROLE-BASED EXPLORE PAGE — Enterprise Features Showcase & Simulators
   ═══════════════════════════════════════════════════════════════════════════════ */
export default function Explore() {
  const { t } = useTranslation();
  const { user } = useAuth();
  const [activeTab, setActiveTab] = useState("ai");

  // Determine user role and default perspective
  const userRole = user?.role || "USER";
  const isAgentOrAdmin = ["SUPER_ADMIN", "ORG_ADMIN", "AGENCY_ADMIN", "AGENT"].includes(userRole);
  
  // Simulation perspective (Guest/Tenant, Landlord/Owner, Agent/Admin)
  const [perspective, setPerspective] = useState<"guest" | "landlord" | "agent">(
    isAgentOrAdmin ? "agent" : "guest"
  );

  // ─── SIMULATOR 1: AI PRICE VALUATION (AI Engine) ──────────────────────────
  const [valPropertyType, setValPropertyType] = useState("villa");
  const [valArea, setValArea] = useState(150);
  const [valLocation, setValLocation] = useState("quasar");
  const [isValuating, setIsValuating] = useState(false);
  const [valuationResult, setValuationResult] = useState<null | {
    price: string;
    rent: string;
    confidence: number;
    score: number;
  }>(null);

  const handleValuation = () => {
    setIsValuating(true);
    setValuationResult(null);
    setTimeout(() => {
      const basePrice = valPropertyType === "villa" ? 22000 : valPropertyType === "apartment" ? 12000 : 16000;
      const locationMultiplier = valLocation === "quasar" ? 1.6 : valLocation === "buyukyali" ? 1.45 : 1.3;
      const calculatedPrice = Math.round(valArea * basePrice * locationMultiplier);
      const calculatedRent = Math.round(calculatedPrice / 220);
      const confidence = Math.floor(Math.random() * 4) + 94; // 94% - 97%
      const score = Math.floor(Math.random() * 8) + 89;      // 89 - 96
      
      setValuationResult({
        price: calculatedPrice.toLocaleString("tr-TR") + " ₺",
        rent: calculatedRent.toLocaleString("tr-TR") + " ₺",
        confidence,
        score
      });
      setIsValuating(false);
    }, 1200);
  };

  // ─── SIMULATOR 2: FINTECH ESCROW & SPLIT COMMISSION ──────────────────────────
  const [escMonthlyRent, setEscMonthlyRent] = useState(65000);
  const [escDepositMonths, setEscDepositMonths] = useState(2);
  const [depositSolution, setDepositSolution] = useState<"cash" | "installments" | "insurance">("installments");
  const [splitCommRate, setSplitCommRate] = useState(2.5); // Hidden split commission rate (e.g. 2.5% Kiracı + 2.5% Ev Sahibi)
  const [isFintechCalculating, setIsFintechCalculating] = useState(false);
  
  // Agent Split Result
  const [fintechResult, setFintechResult] = useState<null | {
    escrowVault: string;
    tenantFee: string;
    landlordFee: string;
    combinedRevenue: string;
    depositPaymentMode: string;
    depositPaymentDetail: string;
    systemShare?: string;
    agentShare?: string;
    stateShare?: string;
  }>(null);

  // Guest Escrow Result (No commission splits or landlord fees shown!)
  const [guestFintechResult, setGuestFintechResult] = useState<null | {
    rentBase: string;
    serviceFee: string;
    totalMonthlyInvoice: string;
    depositDetails: string;
    depositTitle: string;
  }>(null);

  // Landlord Escrow Result (No commission splits or tenant convenience fees shown!)
  const [landlordFintechResult, setLandlordFintechResult] = useState<null | {
    rentBase: string;
    managementFee: string;
    netPayout: string;
    depositStatus: string;
    leaseCareActive: boolean;
  }>(null);

  const handleFintechCalculate = () => {
    setIsFintechCalculating(true);
    setFintechResult(null);
    setGuestFintechResult(null);
    setLandlordFintechResult(null);

    setTimeout(() => {
      // Basic calculations
      const totalDepositValue = escMonthlyRent * escDepositMonths;
      const tenantFeeVal = (escMonthlyRent * splitCommRate) / 100;
      const landlordFeeVal = (escMonthlyRent * splitCommRate) / 100;
      const combinedRevenueVal = tenantFeeVal + landlordFeeVal;
      const waiverFeeVal = escMonthlyRent * 0.02; // 2% Continuous waiver fee

      let depositModeLabel = "Peşin Nakit (Escrow Lock)";
      let depositDetailText = `${totalDepositValue.toLocaleString("tr-TR")} ₺ peşin kilitlendi.`;
      let guestDepositText = `${totalDepositValue.toLocaleString("tr-TR")} ₺ (Peşin Güvende)`;
      let landlordDepositText = `Emanet hesabında korumada (${totalDepositValue.toLocaleString("tr-TR")} ₺)`;

      if (depositSolution === "installments") {
        depositModeLabel = "Aylık Taksitli Depozito";
        const monthlyInstallment = totalDepositValue / 3;
        depositDetailText = `Kira faturasına ek: 3 ay boyunca ${Math.round(monthlyInstallment).toLocaleString("tr-TR")} ₺ / Ay`;
        guestDepositText = `3 Taksitle Ödeniyor: ${Math.round(monthlyInstallment).toLocaleString("tr-TR")} ₺ / Ay`;
        landlordDepositText = `Aylık Taksitli Tahsilat Güvencede`;
      } else if (depositSolution === "insurance") {
        depositModeLabel = "Kaldıkça Öde (%2 Depozito Muafiyeti)";
        depositDetailText = `Sürekli Depozitosuz Kiralama: ${Math.round(waiverFeeVal).toLocaleString("tr-TR")} ₺ / Ay (Geri İadesiz Teminat Havuzu)`;
        guestDepositText = `Sürekli Depozito Muafiyet Bedeli: ${Math.round(waiverFeeVal).toLocaleString("tr-TR")} ₺ / Ay`;
        landlordDepositText = `LeaseCare+ Sigorta Güvencesi Aktif (Maddi hasarlara karşı 100.000 ₺ hasar havuzu koruması)`;
      }

      if (perspective === "agent") {
        const totalAgentRevenue = depositSolution === "insurance" ? (combinedRevenueVal + waiverFeeVal) : combinedRevenueVal;
        const revenuePercent = depositSolution === "insurance" ? "%7" : "%5";
        
        // 3-2-2 Sovereign Split calculations for 7% model
        const sysPct = depositSolution === "insurance" ? 3 : 2.5;
        const agPct = depositSolution === "insurance" ? 2 : 2.5;
        const stPct = depositSolution === "insurance" ? 2 : 0;

        const systemShare = ((escMonthlyRent * sysPct) / 100).toLocaleString("tr-TR") + " ₺ / Ay";
        const agentShare = ((escMonthlyRent * agPct) / 100).toLocaleString("tr-TR") + " ₺ / Ay";
        const stateShare = ((escMonthlyRent * stPct) / 100).toLocaleString("tr-TR") + " ₺ / Ay";

        setFintechResult({
          escrowVault: depositSolution === "insurance" ? "Teminat Havuzu Güvencesi" : (totalDepositValue.toLocaleString("tr-TR") + " ₺"),
          tenantFee: tenantFeeVal.toLocaleString("tr-TR") + " ₺ / Ay",
          landlordFee: landlordFeeVal.toLocaleString("tr-TR") + " ₺ / Ay",
          combinedRevenue: totalAgentRevenue.toLocaleString("tr-TR") + ` ₺ / Ay (${revenuePercent} Toplam Platform Geliri)`,
          depositPaymentMode: depositModeLabel,
          depositPaymentDetail: depositDetailText,
          systemShare,
          agentShare,
          stateShare
        });
      } else if (perspective === "guest") {
        const waiverCost = depositSolution === "insurance" ? waiverFeeVal : 0;
        const totalInvoice = escMonthlyRent + tenantFeeVal + waiverCost;
        setGuestFintechResult({
          rentBase: escMonthlyRent.toLocaleString("tr-TR") + " ₺",
          serviceFee: tenantFeeVal.toLocaleString("tr-TR") + " ₺",
          totalMonthlyInvoice: totalInvoice.toLocaleString("tr-TR") + " ₺ / Ay",
          depositTitle: depositSolution === "cash" ? "Geleneksel Peşin Depozito" : depositSolution === "installments" ? "Taksitli Depozito Kolaylığı" : "Depozitosuz Kiralama (%2 Kaldıkça Öde)",
          depositDetails: guestDepositText
        });
      } else {
        // Landlord Perspective
        const netPayout = escMonthlyRent - landlordFeeVal;
        setLandlordFintechResult({
          rentBase: escMonthlyRent.toLocaleString("tr-TR") + " ₺",
          managementFee: landlordFeeVal.toLocaleString("tr-TR") + " ₺",
          netPayout: netPayout.toLocaleString("tr-TR") + " ₺ / Ay",
          depositStatus: landlordDepositText,
          leaseCareActive: depositSolution === "insurance"
        });
      }
      setIsFintechCalculating(false);
    }, 1000);
  };

  // ─── SIMULATOR 3: BOOKING RISK & AUTO-SLA TASKS ───────────────────────────────
  const [guestName, setGuestName] = useState("Mark van der Berg");
  const [stayNights, setStayNights] = useState(7);
  const [isRiskScreening, setIsRiskScreening] = useState(false);
  
  // Agent Output
  const [riskResult, setRiskResult] = useState<null | {
    riskScore: number;
    fraudFlags: string[];
    generatedTasks: { title: string; type: string; priority: string; sla: number }[];
  }>(null);

  // Guest Output (No fraud screening metrics!)
  const [guestBookingResult, setGuestBookingResult] = useState<null | {
    bookingStatus: string;
    checkInCode: string;
    iotKlimaTemp: number;
    wifiName: string;
  }>(null);

  // Landlord Output (No fraud details, focus on occupant occupancy and scheduling verify!)
  const [landlordBookingResult, setLandlordBookingResult] = useState<null | {
    occupancyStatus: string;
    tenantIdentityVerified: boolean;
    nextCleaningSchedule: string;
    guaranteedRentPayout: string;
  }>(null);

  const handleRiskScreening = () => {
    setIsRiskScreening(true);
    setRiskResult(null);
    setGuestBookingResult(null);
    setLandlordBookingResult(null);

    setTimeout(() => {
      if (perspective === "agent") {
        const isHighRisk = guestName.toLowerCase().includes("disposable") || guestName.length < 5;
        const riskScore = isHighRisk ? 78 : Math.floor(Math.random() * 15) + 6;
        const fraudFlags = isHighRisk 
          ? ["Geçici E-Posta Algılandı (High Risk)", "Geçersiz Ödeme Kartı Hızı", "Defter Doğrulaması Başarısız"]
          : ["Güvenli Ağ İmzası Eşleşti", "KVKK Kara Liste Temiz", "Mülk Sahipliği Doğrulandı"];
          
        setRiskResult({
          riskScore,
          fraudFlags,
          generatedTasks: [
            { title: "Giriş / Anahtar Teslim & Protokol Kontrolü", type: "CHECK_IN", priority: "HIGH", sla: 2 },
            { title: "Çıkış Sonrası Profesyonel Temizlik & Hijyen", type: "CLEANING", priority: "MEDIUM", sla: 24 },
            { title: "Akıllı Ev IoT Klima & Kapı Kilit Kalibrasyonu", type: "MAINTENANCE", priority: "LOW", sla: 48 }
          ]
        });
      } else if (perspective === "guest") {
        setGuestBookingResult({
          bookingStatus: "ONAYLANDI & GÜVENLİ",
          checkInCode: "🔑 IoT-" + Math.floor(1000 + Math.random() * 9000),
          iotKlimaTemp: 22,
          wifiName: "Reservatior-Guest-5G"
        });
      } else {
        // Landlord output
        setLandlordBookingResult({
          occupancyStatus: `${stayNights} Günlük Aktif Kiralama Rezervasyonu`,
          tenantIdentityVerified: true,
          nextCleaningSchedule: "Çıkış sonrası profesyonel temizlik otomatik planlandı",
          guaranteedRentPayout: (escMonthlyRent).toLocaleString("tr-TR") + " ₺ (LeaseCare+ Güvencesiyle Kiracı Ödemese Bile Havuzdan Ödenir)"
        });
      }
      setIsRiskScreening(false);
    }, 1400);
  };

  // ─── SIMULATOR 4: ENTERPRISE AUDIT & CRYPTO LEDGER ────────────────────────────
  const [reportType, setReportType] = useState("financial_income");
  const [isCompilingReport, setIsCompilingReport] = useState(false);
  
  // Agent Output
  const [reportResult, setReportResult] = useState<null | {
    reportId: string;
    hash: string;
    downloadUrl: string;
    status: string;
  }>(null);

  // Guest Output (No ledger records, purely personal data audit logs!)
  const [guestReportResult, setGuestReportResult] = useState<null | {
    auditId: string;
    dataLogged: string[];
    isCompliant: boolean;
    timestamp: string;
  }>(null);

  // Landlord Output (Portfolio Yield and Tax Ledger summary)
  const [landlordReportResult, setLandlordReportResult] = useState<null | {
    portfolioYield: string;
    taxExemptionApplied: string;
    ledgerVerified: boolean;
    statementPeriod: string;
  }>(null);

  const handleReportCompile = () => {
    setIsCompilingReport(true);
    setReportResult(null);
    setGuestReportResult(null);
    setLandlordReportResult(null);

    setTimeout(() => {
      const chars = "abcdef0123456789";
      let generatedHash = "0x";
      for (let i = 0; i < 40; i++) {
        generatedHash += chars[Math.floor(Math.random() * chars.length)];
      }

      if (perspective === "agent") {
        setReportResult({
          reportId: "rep_" + Math.random().toString(36).substr(2, 9).toUpperCase(),
          hash: generatedHash,
          downloadUrl: `/exports/report-${reportType}-${Date.now()}.pdf`,
          status: "COMPLETED_AND_HASHED"
        });
      } else if (perspective === "guest") {
        setGuestReportResult({
          auditId: "aud_" + Math.random().toString(36).substr(2, 9).toUpperCase(),
          dataLogged: ["Ad Soyad", "E-Posta", "Telefon No", "Kira Sözleşme Geçmişi (Şifrelenmiş)"],
          isCompliant: true,
          timestamp: new Date().toLocaleString()
        });
      } else {
        // Landlord Report
        setLandlordReportResult({
          portfolioYield: "%8.4 Yıllık Net Getiri (Optimal Seviyede)",
          taxExemptionApplied: "Emlak Vergisi Muafiyeti İşlendi",
          ledgerVerified: true,
          statementPeriod: "Mayıs 2026 Gelir Raporu"
        });
      }
      setIsCompilingReport(false);
    }, 1300);
  };

  // Define tab descriptions dynamically based on the active perspective (agent vs guest vs landlord)
  const tabContent: Record<"agent" | "guest" | "landlord", Record<string, { title: string; desc: string; badge: string; color: string; features: { icon: any; name: string; detail: string }[] }>> = {
    agent: {
      ai: {
        title: t("explore.ai_engine", "AI Değerleme Motoru"),
        badge: "AGENT INSIGHTS: DEEP LEARNING",
        color: "from-blue-500/20 to-cyan-500/20 border-blue-500/30 text-blue-600 dark:text-blue-400",
        desc: "Gayrimenkul sektörü için özel eğitilmiş derin öğrenme modellerimizle mülklerinizi analiz edin, fiyatlandırın ve piyasa trendlerini anlık tahminleyin.",
        features: [
          { icon: Brain, name: "Yapay Zeka Değerleme", detail: "%96 doğruluk oranı ile anlık piyasa değeri tahmini (Prisma AnalysisJob uyumlu)" },
          { icon: Target, name: "Dinamik Fiyatlandırma", detail: "Mevsimsellik, talep ve rakip analizine göre fiyat optimizasyonu" },
          { icon: Eye, name: "Görsel Nitelik Tespiti", detail: "Mülk fotoğraflarından şömine, havuz, manzara gibi lüks özelliklerin tespiti" },
          { icon: TrendingUp, name: "Gelecek Trend Analizi", detail: "Bölgesel bazda önümüzdeki 12 aylık değer artış projeksiyonları" },
        ]
      },
      video: {
        title: "Fintech, Emanet & Komisyon",
        badge: "ESCROWACCOUNT & COMMISSION RULES",
        color: "from-violet-500/20 to-fuchsia-500/20 border-violet-500/30 text-violet-600 dark:text-violet-400",
        desc: "Yıkıcı depozito modelleri (Taksitli & Sigortalı) ve gizli bölüştürülmüş komisyon kuralları ile kira tahsilatlarını hızlandırın ve toplam platform take-rate oranını maksimize edin.",
        features: [
          { icon: Landmark, name: "Platform Gelir Kırılımı", detail: "Kiracıdan %2.5 + Ev Sahibinden %2.5 olmak üzere toplam %5 sürekli aylık gelir akışı" },
          { icon: ShieldCheck, name: "Yıkıcı Depozito Entegrasyonu", detail: "Taksitli depozito veya kiralama sigortası opsiyonları ile kiralama işlemlerini 3 kat hızlandırma" },
          { icon: Lock, name: "Çift Taraflı Gizlilik Şifrelemesi", detail: "Kiracı ve Ev Sahibi taraflarının birbirine kesilen komisyon ve hizmet faturalarını görmesini engelleyen maskeleme" },
          { icon: AlertTriangle, name: "Otomatik Tahsis & Emanet", detail: "Girişteki depozitoların TDS onaylı resmi koruma fonu hesaplarına anında aktarılması" },
        ]
      },
      management: {
        title: "Smart Rezervasyon & Görev SLA",
        badge: "BOOKING & TASK ENGINE",
        color: "from-emerald-500/20 to-teal-500/20 border-emerald-500/30 text-emerald-600 dark:text-emerald-400",
        desc: "Booking ve Task modellerimiz sayesinde rezervasyon risk taramalarını yapın, sahteciliği önleyin ve her rezervasyon için otomatik SLA'li operasyonel görevler oluşturun.",
        features: [
          { icon: CalendarCheck, name: "Rezervasyon Doğrulama", detail: "Mülk sahipliği kontrolü (PropertyOwnershipVerification) ve çakışmasız takvim bloklama" },
          { icon: ShieldAlert, name: "Otomatik Risk Tarama", detail: "Rezervasyon talebinde sahtecilik ve finansal güvenilirlik puanlama (riskScore & fraudFlags)" },
          { icon: ClipboardList, name: "SLA Tanımlı Görevler", detail: "Temizlik, anahtar teslim ve bakım için otomatik atanan ve geri sayımı olan Task modelleri" },
          { icon: Wifi, name: "IoT Kapı Kilit Entegrasyonu", detail: "Sözleşme başlangıcıyla birlikte akıllı kapı şifrelerinin kiracıya otomatik iletilmesi" },
        ]
      },
      security: {
        title: "Raporlama & Kriptografik Defter",
        badge: "REPORT & LEDGER SYSTEM",
        color: "from-amber-500/20 to-orange-500/20 border-amber-500/30 text-amber-600 dark:text-amber-400",
        desc: "Report, ReportExecution ve LedgerEntry modellerimiz aracılığıyla, kurumsal performans raporlarınızı otomatik derleyin ve işlem geçmişlerini blockchain ağında güvenceye alın.",
        features: [
          { icon: FileSpreadsheet, name: "Otomatik Finansal Raporlama", detail: "Belirlenen aralıklarda çalıştırılan JSON konfigürasyonlu SQL/Prisma analiz raporları" },
          { icon: Database, name: "Rapor Geçmişi (Executions)", detail: "Oluşturulan raporların indirme bağlantıları ve hata günlüklerinin takibi" },
          { icon: Lock, name: "Defter Girişleri (LedgerEntry)", detail: "Gelir-gider tablolarında çift taraflı kayıt (double-entry) muhasebe uyumluluğu" },
          { icon: Shield, name: "Kriptografik Güvence", detail: "Tüm muhasebe ve tapu hareketlerinin SHA-256 hash imzalarıyla korunması" },
        ]
      },
      superapp: {
        title: "Super App & Çapraz Satış",
        badge: "ANCILLARY REVENUE ENGINE",
        color: "from-pink-500/20 to-rose-500/20 border-pink-500/30 text-pink-600 dark:text-pink-400",
        desc: "Konaklamanın ötesine geçin. Misafirlere sunulan B2B oteller, turlar, VIP transferler ve özel deneyimlerle sepet tutarını büyütün.",
        features: [
          { icon: Globe2, name: "B2B Otel Entegrasyonu", detail: "WebBeds/HotelBeds üzerinden anlık müsaitlik ve dinamik marjlı satış" },
          { icon: Zap, name: "Deneyim (Experience) Modeli", detail: "Yat turları, şef yemekleri gibi yerel deneyimlerin rezervasyon anında sunulması" },
          { icon: Bot, name: "AI Çapraz Satış Önerisi", detail: "Misafir profili ve lokasyona göre en uygun transfer/tur paketinin otomatik önerilmesi" },
          { icon: Landmark, name: "Tek Sepet (Escrow) Tahsilat", detail: "Konaklama + Transfer + Tur bedelinin tek ödemede alınıp Escrow ile sağlayıcılara dağıtılması" },
        ]
      },
    },
    guest: {
      ai: {
        title: "Hızlı AI Mülk Değerleme",
        badge: "GUEST: FREE VALUATION TOOL",
        color: "from-blue-500/20 to-cyan-500/20 border-blue-500/30 text-blue-600 dark:text-blue-400",
        desc: "Sahip olduğunuz veya kiralamak istediğiniz mülkün adil piyasa değerini ve kira karşılığını ücretsiz test edin.",
        features: [
          { icon: Brain, name: "Ücretsiz Fiyat Analizi", detail: "Metrekare ve lokasyon bazında hızlı pazar araştırması" },
          { icon: Target, name: "Akıllı Lokasyon Kıyası", detail: "Büyükyalı, Quasar ve Validebağ projeleri arasında fiyat karşılaştırmaları" },
          { icon: Eye, name: "Kiralık/Satılık Tahminleri", detail: "Hızlı veri analizleriyle en mantıklı kiralama oranları" },
          { icon: TrendingUp, name: "Kişisel Yatırım Skoru", detail: "Mülkünüzün pazar trendlerine göre yatırım çekicilik analizi" },
        ]
      },
      video: {
        title: "Esnek Depozito & Kolay Kiralama",
        badge: "FINANCIAL FLEXIBILITY & ZERO DEPOSIT",
        color: "from-violet-500/20 to-fuchsia-500/20 border-violet-500/30 text-violet-600 dark:text-violet-400",
        desc: "Kiralama işlemlerinde artık 3-4 aylık devasa nakit depozitolar ödemenize gerek yok! Size en uygun esnek finansal çözümü seçip kiralama sürecinizi hemen başlatın.",
        features: [
          { icon: ShieldCheck, name: "Aylık Taksitli Depozito Kolaylığı", detail: "Depozito bedelini peşin değil, ilk 3 kira faturanıza bölerek bütçenizi zorlamadan ödeyin." },
          { icon: Zap, name: "Sıfır Nakit: Depozito Sigortası", detail: "Hiçbir toplu para vermeden, aylık ufak bir sigorta bedeliyle dairenizi anında tutun." },
          { icon: CreditCard, name: "Sadece Kiracı Hizmet Bedeli (%2.5)", detail: "Geleneksel yüksek emlakçı komisyonu yerine faturanıza ek sadece %2.5 aylık şeffaf hizmet bedeli." },
          { icon: Landmark, name: "Tarafsız TDS Depozito Koruması", detail: "Depozitonuz ev sahibinin şahsi hesabında değil, tarafsız resmi devlet koruması altında güvendedir." },
        ]
      },
      management: {
        title: "Dijital Konaklama & IoT Rehberi",
        badge: "SMART STAY GUIDE & INTERACTION",
        color: "from-emerald-500/20 to-teal-500/20 border-emerald-500/30 text-emerald-600 dark:text-emerald-400",
        desc: "Rezervasyonunuz onaylandığı an akıllı ev sistemlerimizle doğrudan etkileşime geçin. Anahtar teslim, IoT ayarları ve Wi-Fi bilgilerinize anında ulaşın.",
        features: [
          { icon: KeyRound, name: "Akıllı Giriş Kodları (IoT)", detail: "Rezervasyon gününde aktif olan, telefondan açılabilir şifreli giriş anahtarları" },
          { icon: Wifi, name: "Anlık Wi-Fi Bilgileri", detail: "Mülke girdiğinizde tek tıkla QR kod ile otomatik Wi-Fi bağlantısı" },
          { icon: Thermometer, name: "IoT Klima & Isı Ayarları", detail: "Daha eve girmeden klimanızı veya sıcaklığı dilediğiniz gibi uzaktan kontrol edin" },
          { icon: MessageSquare, name: "7/24 Dijital Konsiyerj", detail: "Mülkle veya bölgeyle ilgili tüm sorularınız için yapay zeka destekli rehberlik" },
        ]
      },
      security: {
        title: "Kişisel Veri Audit & KVKK Uyum",
        badge: "GDPR / KVKK PRIVACY CONTROL",
        color: "from-amber-500/20 to-orange-500/20 border-amber-500/30 text-amber-600 dark:text-amber-400",
        desc: "Kişisel verilerinizin nasıl korunduğunu denetleyin. Hangi verilerinizin Reservatior üzerinde loglandığını tamamen şeffaf bir şekilde analiz edin.",
        features: [
          { icon: Users, name: "Kişisel Veri Şeffaflığı", detail: "Sistemde adınıza kayıtlı olan iletişim, sözleşme ve fatura bilgilerini inceleme" },
          { icon: Shield, name: "Uyumlu Şifreleme", detail: "Tüm kimlik ve tapu bilgisi kontrollerinin endüstriyel kripto şifreleme standartlarında tutulması" },
          { icon: FileSearch, name: "Veri Silme (Unutulma Hakkı)", detail: "Sözleşmeniz bittikten sonra KVKK/GDPR gereği verilerinizin sistemden silinmesini talep etme" },
          { icon: Lock, name: "Sıfır Bilgi Kanıtı (Zero Knowledge)", detail: "Ödeme ve işlem şifrelerinizin hiçbir Reservatior çalışanı tarafından görülememesi" },
        ]
      },
      superapp: {
        title: "Turlar, Oteller ve Transfer",
        badge: "ONE STOP TRAVEL APP",
        color: "from-pink-500/20 to-rose-500/20 border-pink-500/30 text-pink-600 dark:text-pink-400",
        desc: "Sadece bir ev kiralamakla kalmayın. Seyahatinizi planlarken havaalanı transferinizi ve bölgedeki en iyi turları tek sepet üzerinden alın.",
        features: [
          { icon: Globe2, name: "Alternatif Otel Seçenekleri", detail: "Kiralık ev bulamadığınızda WebBeds entegrasyonu ile en iyi otellere anında ulaşın" },
          { icon: Users, name: "Lokal Deneyimler", detail: "Gideceğiniz bölgedeki şarap tadımları, yat turları ve rehberli gezileri kolayca rezerve edin" },
          { icon: Zap, name: "Havalimanı VIP Transfer", detail: "Konaklamanız onaylandığında size özel tahsis edilen lüks araçlarla güvenle ulaşım sağlayın" },
          { icon: CreditCard, name: "Tek Çekim Kolaylığı", detail: "Ev + Transfer + Tur paketini tek bir güvenli ödeme ile tamamlayın" },
        ]
      },
    },
    landlord: {
      ai: {
        title: "Ev Sahibi Gelir & AI Fiyat Analizi",
        badge: "LANDLORD: YIELD MAXIMIZER",
        color: "from-blue-500/20 to-cyan-500/20 border-blue-500/30 text-blue-600 dark:text-blue-400",
        desc: "Mülkünüzün en hızlı ve en karlı şekilde kiralanması için yapay zeka destekli bölgesel getiri analizlerini inceleyin.",
        features: [
          { icon: Brain, name: "Getiri Optimizasyonu", detail: "Çevredeki benzer mülklerin doluluk ve kira analizlerine göre gelir artırma planı" },
          { icon: Target, name: "Optimal Kira Belirleme", detail: "Mülkünüzün boş kalmasını önleyen, AI destekli en doğru kira değeri tespiti" },
          { icon: Star, name: "Doluluk Tahmin Modelleri", detail: "Bölgenizdeki dönemsel kiralama ve konaklama taleplerine yönelik doluluk analizleri" },
          { icon: TrendingUp, name: "Bölgesel Değer Artışı", detail: "Quasar, Büyükyalı ve Validebağ bölgelerindeki yıllık gayrimenkul değer değişimleri" }
        ]
      },
      video: {
        title: "Garantili Gelir & Kolay Yönetim",
        badge: "GUARANTEED YIELD & PROPERTY PROTECTION",
        color: "from-violet-500/20 to-fuchsia-500/20 border-violet-500/30 text-violet-600 dark:text-violet-400",
        desc: "Reservatior platformunun esnek kiralama çözümleri ile evinizi kiraya vermek hiç olmadığı kadar zahmetsiz ve korumalı! Kiracı aramaya son.",
        features: [
          { icon: ShieldCheck, name: "LeaseCare+ Ödeme Garantisi", detail: "Depozito sigortası sistemiyle, kiracı kirasını aksatsa dahi ödemeniz havuzdan her ay tam gününde yatırılır." },
          { icon: Landmark, name: "Sadece Ev Sahibi Yönetim Bedeli (%2.5)", detail: "Geleneksel 1 aylık yüksek emlak komisyonu yerine aylık sadece %2.5 hizmet/yönetim bedeli." },
          { icon: Lock, name: "Komisyon Gizlilik Güvencesi", detail: "Kiracıyla aranızda hiçbir komisyon tartışması yaşanmaz. Her iki tarafın komisyon faturası tamamen bağımsızdır." },
          { icon: Building2, name: "Maddi Hasarlara Karşı Tam Koruma", detail: "Geleneksel depozitolara kıyasla 2-3 kat daha yüksek hasar poliçesiyle eviniz fiziksel olarak güvenceye alınır." }
        ]
      },
      management: {
        title: "Mülk Durumu & Kiracı Takip",
        badge: "PROPERTY MONITORING & STATUS",
        color: "from-emerald-500/20 to-teal-500/20 border-emerald-500/30 text-emerald-600 dark:text-emerald-400",
        desc: "Evinizin doluluk durumunu, kiracınızın kimlik doğrulama raporlarını ve mülkünüzde planlanan operasyonları şeffaf bir şekilde izleyin.",
        features: [
          { icon: UserCheck, name: "Kimlik Doğrulanmış Kiracılar", detail: "Yasal olarak sabıka kaydı, kredi skoru ve kimliği 100% onaylanmış güvenilir profiller." },
          { icon: ClipboardList, name: "Otomatik Bakım & SLA Takibi", detail: "Acentemizin mülkünüzde yaptığı temizlik ve kontrol hizmetlerinin anlık raporları." },
          { icon: CalendarCheck, name: "Şeffaf Doluluk Takvimi", detail: "Mülkünüzün hangi tarihler arasında kiralandığını ve boş kalacağı dönemleri canlı izleme." },
          { icon: MessageSquare, name: "Ev Sahibi Destek Hattı", detail: "Mülkünüzle ilgili her türlü teknik veya idari konuda 7/24 direkt uzman desteği." }
        ]
      },
      security: {
        title: "Yıllık Finansal Raporlar & Stopaj",
        badge: "FINANCIAL YIELD & TAX AUDITS",
        color: "from-amber-500/20 to-orange-500/20 border-amber-500/30 text-amber-600 dark:text-amber-400",
        desc: "Mülklerinizden elde ettiğiniz gelirlerin mali tablolarını derleyin, stopaj ve emlak vergisi muafiyetlerinizi otomatik analiz edin.",
        features: [
          { icon: FileSpreadsheet, name: "Resmi Vergi Raporları", detail: "Yıllık kira geliri beyannamenize doğrudan ekleyebileceğiniz hazır PDF finansal raporlar." },
          { icon: Landmark, name: "Emlak Vergisi Muafiyet Takibi", detail: "Bölgesel emlak ve gelir vergisi indirim fırsatlarının sistem tarafından otomatik tespiti." },
          { icon: Shield, name: "Kripto Kayıt Güvencesi", detail: "Tüm kira girişlerinizin yasal kurumlar karşısında değiştirilemez kriptografik doğruluğu." },
          { icon: Download, name: "Tek Tıkla Rapor İndirme", detail: "Mali müşavirinize iletmek üzere tüm hesap özetlerini anında Excel/PDF formatında indirme." }
        ]
      },
      superapp: {
        title: "Bölgesel Ek Gelir (Ancillary)",
        badge: "ADDITIONAL REVENUE STREAMS",
        color: "from-pink-500/20 to-rose-500/20 border-pink-500/30 text-pink-600 dark:text-pink-400",
        desc: "Sadece kira geliriyle sınırlı kalmayın. Misafirlerinize sunulan transfer ve yerel deneyim satışlarından komisyon payı elde edin.",
        features: [
          { icon: TrendingUp, name: "Çapraz Satış Komisyonu", detail: "Evinizde kalan misafir tur veya transfer satın aldığında ekstra %1 pasif gelir kazanın" },
          { icon: Users, name: "Yerel Partnerlik", detail: "Kendi düzenlediğiniz turları (örn: aşçılık atölyesi) sisteme Experience olarak ekleyerek misafirlere satın" },
          { icon: Eye, name: "AI Misafir Analizi", detail: "Hangi misafir kitlesinin hangi deneyimleri satın aldığını görerek hedef kitlenizi tanıyın" },
          { icon: Landmark, name: "Ledger'da Ek Gelir", detail: "Ana kira gelirinize ek olarak, çapraz satışlardan gelen gelirleri cüzdanınızda şeffafça izleyin" },
        ]
      }
    }
  };

  const tabs = [
    { id: "ai", label: "AI Değerleme", icon: Bot },
    { 
      id: "video", 
      label: perspective === "agent" ? "Finans & Emanet" : perspective === "landlord" ? "Gelir & Güvence" : "Esnek Depozito", 
      icon: Landmark 
    },
    { 
      id: "management", 
      label: perspective === "agent" ? "Rezervasyon & Görev" : perspective === "landlord" ? "Mülk Durumu" : "Akıllı Konaklama", 
      icon: CalendarCheck 
    },
    { 
      id: "security", 
      label: perspective === "agent" ? "Raporlama & Defter" : perspective === "landlord" ? "Yıllık Raporlar" : "Veri Şeffaflığı", 
      icon: FileSpreadsheet 
    },
    { 
      id: "superapp", 
      label: perspective === "agent" ? "Super App (Çapraz Satış)" : perspective === "landlord" ? "Ek Gelir (Turlar)" : "Deneyim & Transfer", 
      icon: Sparkles 
    },
  ];

  return (
    <>
      <Helmet>
        <title>{t("explore.meta_title", "Explore Features - Powerful Real Estate Tools | Reservatior")}</title>
        <meta name="description" content={t("explore.meta_desc", "Discover Reservatior's powerful real estate management features including AI valuation, smart search, analytics, and automation.")} />
        <meta property="og:title" content={t("explore.meta_title", "Explore Features - Powerful Real Estate Tools | Reservatior")} />
        <meta property="og:description" content={t("explore.meta_desc", "Discover Reservatior's powerful real estate management features including AI valuation, smart search, analytics, and automation.")} />
        <meta property="og:type" content="website" />
        <meta property="og:url" content={window.location.href} />
        <meta name="twitter:card" content="summary_large_image" />
        <meta name="twitter:title" content={t("explore.meta_title", "Explore Features - Powerful Real Estate Tools | Reservatior")} />
        <meta name="twitter:description" content={t("explore.meta_desc", "Discover Reservatior's powerful real estate management features including AI valuation, smart search, analytics, and automation.")} />
        <link rel="canonical" href={window.location.href} />
      </Helmet>

      <div className="min-h-screen bg-background text-foreground overflow-x-hidden relative selection:bg-primary selection:text-white transition-colors duration-300">
        
        {/* Dynamic Glowing Backgrounds */}
        <div className="absolute inset-0 pointer-events-none overflow-hidden">
          <div className="absolute top-[5%] left-[-10%] w-[60vw] h-[60vw] rounded-full bg-radial from-blue-600/5 dark:from-blue-600/10 to-transparent blur-[160px]" />
          <div className="absolute top-[30%] right-[-10%] w-[50vw] h-[50vw] rounded-full bg-radial from-violet-600/4 dark:from-violet-600/8 to-transparent blur-[160px]" />
          <div className="absolute bottom-[10%] left-[20%] w-[55vw] h-[55vw] rounded-full bg-radial from-emerald-600/3 dark:from-emerald-600/5 to-transparent blur-[160px]" />
          <div className="absolute inset-0 opacity-[0.015] dark:opacity-[0.03]" style={{
            backgroundImage: `linear-gradient(to right, rgba(255,255,255,0.1) 1px, transparent 1px), linear-gradient(to bottom, rgba(255,255,255,0.1) 1px, transparent 1px)`,
            backgroundSize: "60px 60px"
          }} />
        </div>

        {/* ══════════════ HERO SECTION ══════════════ */}
        <section className="relative pt-36 pb-12 overflow-hidden">
          <div className="relative z-10 container mx-auto px-6 text-center space-y-8">
            <motion.div 
              initial={{ opacity: 0, y: -20 }} 
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.6 }}
              className="inline-flex"
            >
              <Badge className="bg-muted dark:bg-white/5 border border-border dark:border-white/10 text-foreground dark:text-white/90 px-4 py-1.5 rounded-full text-xs font-black tracking-widest uppercase italic backdrop-blur-md shadow-lg flex items-center gap-2">
                <Sparkles className="w-3.5 h-3.5 text-amber-500 animate-pulse" /> 
                RESERVATIOR DUAL-LENS PRIVACY ENGINE
              </Badge>
            </motion.div>

            <motion.h1 
              initial={{ opacity: 0, scale: 0.95 }}
              animate={{ opacity: 1, scale: 1 }}
              transition={{ duration: 0.8, delay: 0.1 }}
              className="text-6xl md:text-8xl font-black tracking-tighter leading-[0.9] uppercase italic"
            >
              <span className="text-muted-foreground dark:text-white/40">GELİŞMİŞ VERİ TABANI</span><br />
              <span className="bg-gradient-to-r from-blue-600 dark:from-blue-400 via-violet-600 dark:via-violet-400 to-indigo-600 dark:to-indigo-400 bg-clip-text text-transparent">
                YETENEKLERİNİ KEŞFEDİN
              </span>
            </motion.h1>

            <motion.p 
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.8, delay: 0.2 }}
              className="text-muted-foreground text-lg md:text-xl max-w-3xl mx-auto leading-relaxed font-medium"
            >
              Prisma veri modelimizin gücünü doğrudan test edin. Finanstan güvenliğe, yapay zekadan operasyonel görev takibine kadar tüm platform mekanizmalarını deneyimleyin.
            </motion.p>
          </div>
        </section>

        {/* ══════════════ ROLE PERSPECTIVE SELECTOR ══════════════ */}
        <section className="pb-8 relative z-20">
          <div className="container mx-auto px-6 max-w-5xl">
            <div className="bg-card/40 dark:bg-black/20 border border-border dark:border-white/5 rounded-4xl p-5 backdrop-blur-md flex flex-col md:flex-row items-center justify-between gap-4 shadow-sm relative overflow-hidden">
              <div className="absolute top-0 left-0 w-2 h-full bg-primary" />
              <div className="space-y-1 text-left">
                <span className="text-[9px] font-black uppercase tracking-widest text-primary italic block">ÇİFT TARAFLI ERİŞİM GÜVENLİĞİ VE GİZLİLİK SİMÜLASYONU</span>
                <h3 className="text-sm font-black text-foreground uppercase italic flex items-center gap-1.5">
                  <UserCheck className="w-4 h-4 text-emerald-500" />
                  Aktif Görünüm Modu: <span className="text-primary italic font-black">
                    {perspective === "guest" ? "Kiracı Portalı" : perspective === "landlord" ? "Ev Sahibi Portalı" : "Platform Acentesi / Admin"}
                  </span>
                </h3>
                <p className="text-xs text-muted-foreground font-medium">
                  {perspective === "guest" && "👤 Kiracı olarak oturum açtınız. Sadece sizinle ilgili komisyonlar ve esnek depozito planı faturalandırılır."}
                  {perspective === "landlord" && "🏡 Ev Sahibi olarak oturum açtınız. Kiracının ödediği komisyonlardan gizli olarak hak edişlerinizi ve kiralama güvencenizi izlersiniz."}
                  {perspective === "agent" && "🔑 Yönetici/Acente olarak oturum açtınız. Kiracı ve ev sahibinin birbirini görmediği toplam komisyon ve ciro dağılımı önünüzdedir."}
                </p>
              </div>

              {/* Toggle Perspective (Open for demonstration) */}
              <div className="flex flex-wrap gap-1 bg-muted p-1 rounded-2xl border border-border shrink-0">
                <button
                  onClick={() => { setPerspective("guest"); setFintechResult(null); setRiskResult(null); setReportResult(null); }}
                  className={`px-3 py-2.5 rounded-xl text-[9px] font-black uppercase tracking-wider italic transition-all cursor-pointer flex items-center gap-1 ${
                    perspective === "guest"
                      ? "bg-background text-foreground shadow-md font-bold"
                      : "text-muted-foreground hover:text-foreground"
                  }`}
                >
                  <Users className="w-3.5 h-3.5" />
                  Kiracı Görünümü
                </button>

                <button
                  onClick={() => { setPerspective("landlord"); setFintechResult(null); setRiskResult(null); setReportResult(null); }}
                  className={`px-3 py-2.5 rounded-xl text-[9px] font-black uppercase tracking-wider italic transition-all cursor-pointer flex items-center gap-1 ${
                    perspective === "landlord"
                      ? "bg-background text-foreground shadow-md font-bold"
                      : "text-muted-foreground hover:text-foreground"
                  }`}
                >
                  <Building2 className="w-3.5 h-3.5" />
                  Ev Sahibi Görünümü
                </button>
                
                <button
                  onClick={() => { setPerspective("agent"); setGuestFintechResult(null); setLandlordFintechResult(null); setGuestBookingResult(null); setLandlordBookingResult(null); setGuestReportResult(null); setLandlordReportResult(null); }}
                  className={`px-3 py-2.5 rounded-xl text-[9px] font-black uppercase tracking-wider italic transition-all cursor-pointer flex items-center gap-1 ${
                    perspective === "agent"
                      ? "bg-background text-foreground shadow-md font-bold"
                      : "text-muted-foreground hover:text-foreground"
                  }`}
                >
                  <Lock className="w-3.5 h-3.5" />
                  Acente / Admin
                </button>
              </div>
            </div>
          </div>
        </section>

        {/* ══════════════ TABS & INTERACTIVE SHOWCASE ══════════════ */}
        <section className="py-8 relative z-20">
          <div className="container mx-auto px-6">
            
            {/* Tab Selector Buttons */}
            <div className="flex flex-wrap justify-center gap-3 mb-16 max-w-5xl mx-auto bg-card/60 dark:bg-black/30 backdrop-blur-xl border border-border dark:border-white/5 p-2 rounded-3xl shadow-xl">
              {tabs.map((tab) => {
                const isActive = activeTab === tab.id;
                return (
                  <button
                    key={tab.id}
                    onClick={() => setActiveTab(tab.id)}
                    className={`flex items-center gap-3 px-5 py-4 rounded-2xl text-[10px] font-black uppercase tracking-widest italic transition-all duration-500 flex-1 justify-center cursor-pointer
                      ${isActive
                        ? "bg-foreground text-background dark:bg-white dark:text-black shadow-2xl scale-102 font-black"
                        : "text-muted-foreground hover:bg-muted dark:hover:bg-white/5 hover:text-foreground"
                      }`}
                  >
                    <tab.icon className={`w-4 h-4 transition-transform duration-300 ${isActive ? "scale-110" : ""}`} />
                    {tab.label}
                  </button>
                );
              })}
            </div>

            {/* Main Core Showcase Card */}
            <div className="max-w-7xl mx-auto bg-card/50 dark:bg-black/40 backdrop-blur-2xl border border-border dark:border-white/5 rounded-5xl p-8 lg:p-12 shadow-3xl relative overflow-hidden">
              <div className="absolute top-0 right-0 w-80 h-80 bg-radial from-primary/10 to-transparent blur-3xl rounded-full" />
              
              <div className="grid lg:grid-cols-12 gap-12 items-center relative z-10">
                
                {/* LEFT SIDE: Feature Details */}
                <div className="lg:col-span-6 space-y-8">
                  <div>
                    <Badge className={`bg-transparent border ${tabContent[perspective][activeTab].color} px-3 py-1 text-[10px] font-black uppercase tracking-widest italic mb-4`}>
                      {tabContent[perspective][activeTab].badge}
                    </Badge>
                    <h2 className="text-4xl lg:text-5xl font-black text-foreground italic tracking-tight uppercase leading-tight">
                      {tabContent[perspective][activeTab].title}
                    </h2>
                    <p className="text-muted-foreground text-base leading-relaxed mt-4 font-medium">
                      {tabContent[perspective][activeTab].desc}
                    </p>
                  </div>

                  <div className="grid gap-4">
                    {tabContent[perspective][activeTab].features.map((f, i) => (
                      <div 
                        key={i} 
                        className="flex items-start gap-4 p-4 rounded-2xl bg-muted/30 dark:bg-[#0d0e12] border border-border dark:border-white/5 hover:border-border/80 dark:hover:border-white/10 hover:bg-muted/80 dark:hover:bg-[#13151b] transition-all duration-300 group cursor-default"
                      >
                        <div className="w-11 h-11 rounded-xl bg-muted/60 dark:bg-white/5 flex items-center justify-center shrink-0 group-hover:bg-primary/10 transition-colors">
                          <f.icon className="w-5 h-5 text-blue-500 dark:text-blue-400 group-hover:scale-110 transition-transform" />
                        </div>
                        <div>
                          <h4 className="font-black uppercase italic tracking-wider text-xs text-foreground group-hover:text-primary transition-colors">{f.name}</h4>
                          <p className="text-xs text-muted-foreground mt-1 font-medium leading-relaxed">{f.detail}</p>
                        </div>
                      </div>
                    ))}
                  </div>
                </div>

                {/* RIGHT SIDE: Interactive Real-Time Simulators */}
                <div className="lg:col-span-6">
                  <div className="bg-card dark:bg-[#0b0c10] border border-border dark:border-white/10 rounded-4xl p-6 md:p-8 shadow-2xl relative overflow-hidden group/card">
                    <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-blue-500 via-violet-500 to-indigo-500" />
                    
                    <AnimatePresence mode="wait">
                      
                      {/* SIMULATOR 1: AI Pricing */}
                      {activeTab === "ai" && (
                        <motion.div 
                          key="ai-sim"
                          initial={{ opacity: 0, scale: 0.95 }}
                          animate={{ opacity: 1, scale: 1 }}
                          exit={{ opacity: 0, scale: 0.95 }}
                          className="space-y-6"
                        >
                          <div className="flex justify-between items-center">
                            <span className="text-[10px] font-black tracking-widest text-muted-foreground uppercase italic">RESERVATIOR NEURAL ENGINE v4</span>
                            <Badge className="bg-blue-500/10 text-blue-600 dark:text-blue-400 border-blue-500/20 font-black italic text-[9px]">SİMÜLATÖR</Badge>
                          </div>
                          
                          <div className="space-y-4">
                            <div className="space-y-2">
                              <label className="text-[10px] font-black tracking-widest text-muted-foreground uppercase italic">MÜLK TİPİ</label>
                              <div className="grid grid-cols-3 gap-2">
                                {["villa", "apartment", "penthouse"].map((t) => (
                                  <button
                                    key={t}
                                    onClick={() => { setValPropertyType(t); setValuationResult(null); }}
                                    className={`px-3 py-2.5 rounded-xl text-[10px] font-black uppercase tracking-wider italic border transition-all cursor-pointer ${
                                      valPropertyType === t 
                                        ? "bg-blue-500/10 border-blue-500/50 text-blue-600 dark:text-blue-400"
                                        : "bg-muted dark:bg-white/5 border border-border dark:border-white/5 text-muted-foreground dark:text-slate-400 hover:bg-muted/80 dark:hover:bg-white/10"
                                    }`}
                                  >
                                    {t === "villa" ? "Villa" : t === "apartment" ? "Daire" : "Rezidans"}
                                  </button>
                                ))}
                              </div>
                            </div>

                            <div className="space-y-2">
                              <label className="text-[10px] font-black tracking-widest text-muted-foreground uppercase italic">PROJE LOKASYONU</label>
                              <div className="grid grid-cols-3 gap-2">
                                {["quasar", "buyukyali", "validebag"].map((loc) => (
                                  <button
                                    key={loc}
                                    onClick={() => { setValLocation(loc); setValuationResult(null); }}
                                    className={`px-3 py-2.5 rounded-xl text-[10px] font-black uppercase tracking-wider italic border transition-all cursor-pointer ${
                                      valLocation === loc 
                                        ? "bg-blue-500/10 border-blue-500/50 text-blue-600 dark:text-blue-400"
                                        : "bg-muted dark:bg-white/5 border border-border dark:border-white/5 text-muted-foreground dark:text-slate-400 hover:bg-muted/80 dark:hover:bg-white/10"
                                    }`}
                                  >
                                    {loc === "quasar" ? "Quasar" : loc === "buyukyali" ? "Büyükyalı" : "Validebağ"}
                                  </button>
                                ))}
                              </div>
                            </div>

                            <div className="space-y-2">
                              <div className="flex justify-between text-[10px] font-black tracking-widest text-muted-foreground uppercase italic">
                                <span>MÜLK BÜYÜKLÜĞÜ</span>
                                <span className="text-blue-500 dark:text-blue-400 font-black">{valArea} m²</span>
                              </div>
                              <input 
                                type="range" 
                                min="50" 
                                max="600" 
                                step="10"
                                value={valArea}
                                onChange={(e) => { setValArea(Number(e.target.value)); setValuationResult(null); }}
                                className="w-full h-1 bg-muted dark:bg-white/10 rounded-lg appearance-none cursor-pointer accent-blue-600 dark:accent-blue-500"
                              />
                            </div>
                          </div>

                          <Button 
                            onClick={handleValuation}
                            disabled={isValuating}
                            className="w-full bg-blue-600 hover:bg-blue-500 text-white font-black uppercase text-xs tracking-widest italic py-6 rounded-2xl shadow-lg shadow-blue-500/10 cursor-pointer"
                          >
                            {isValuating ? (
                              <div className="flex items-center gap-2">
                                <RefreshCw className="w-4 h-4 animate-spin" />
                                <span>ANALİZ EDİLİYOR...</span>
                              </div>
                            ) : (
                              <div className="flex items-center gap-2">
                                <Brain className="w-4 h-4" />
                                <span>{perspective === "landlord" ? "YILLIK GETİRİ ANALİZİ YAP" : "YAPAY ZEKA DEĞERLEMESİ YAP"}</span>
                              </div>
                            )}
                          </Button>

                          <AnimatePresence>
                            {valuationResult && (
                              <motion.div 
                                initial={{ opacity: 0, y: 15 }}
                                animate={{ opacity: 1, y: 0 }}
                                className="bg-muted/40 dark:bg-[#12131a] border border-border dark:border-white/5 rounded-3xl p-5 space-y-4"
                              >
                                <div className="grid grid-cols-2 gap-4">
                                  <div>
                                    <span className="text-[9px] font-black text-muted-foreground tracking-widest uppercase italic block">TAHMİNİ DEĞER</span>
                                    <span className="text-xl font-black text-foreground tracking-tight block mt-1">{valuationResult.price}</span>
                                  </div>
                                  <div>
                                    <span className="text-[9px] font-black text-muted-foreground tracking-widest uppercase italic block">
                                      {perspective === "landlord" ? "ÖNERİLEN OPTİMAL KİRA" : "AYLIK KİRA TAHMİNİ"}
                                    </span>
                                    <span className="text-xl font-black text-emerald-600 dark:text-emerald-400 tracking-tight block mt-1">{valuationResult.rent}</span>
                                  </div>
                                </div>

                                <div className="border-t border-border dark:border-white/5 pt-3 space-y-2">
                                  <div className="flex justify-between text-[9px] font-black text-muted-foreground tracking-widest uppercase italic">
                                    <span>AI GÜVEN ENDEKSİ</span>
                                    <span className="text-blue-600 dark:text-blue-400">%{valuationResult.confidence}</span>
                                  </div>
                                  <div className="w-full h-1 bg-muted dark:bg-white/5 rounded-full overflow-hidden">
                                    <div className="h-full bg-blue-600 dark:bg-blue-500 rounded-full" style={{ width: `${valuationResult.confidence}%` }} />
                                  </div>
                                </div>
                              </motion.div>
                            )}
                          </AnimatePresence>
                        </motion.div>
                      )}

                      {/* SIMULATOR 2: FINTECH ESCROW & SPLIT COMMISSION */}
                      {activeTab === "video" && (
                        <motion.div 
                          key="fintech-sim"
                          initial={{ opacity: 0, scale: 0.95 }}
                          animate={{ opacity: 1, scale: 1 }}
                          exit={{ opacity: 0, scale: 0.95 }}
                          className="space-y-6"
                        >
                          <div className="flex justify-between items-center">
                            <span className="text-[10px] font-black tracking-widest text-muted-foreground uppercase italic">
                              {perspective === "agent" ? "ROUTING GATEWAY (PRO)" : perspective === "landlord" ? "LANDLORD PROTECTION" : "TENANT TRANSACTION WIDGET"}
                            </span>
                            <Badge className="bg-violet-500/10 text-violet-600 dark:text-violet-400 border-violet-500/20 font-black italic text-[9px]">SİMÜLATÖR</Badge>
                          </div>

                          <div className="space-y-4">
                            <div className="space-y-2">
                              <div className="flex justify-between text-[10px] font-black tracking-widest text-muted-foreground uppercase italic">
                                <span>AYLIK KİRA BEDELİ</span>
                                <span className="text-violet-600 dark:text-violet-400 font-black">{escMonthlyRent.toLocaleString()} ₺</span>
                              </div>
                              <input 
                                type="range" 
                                min="10000" 
                                max="250000" 
                                step="5000"
                                value={escMonthlyRent}
                                onChange={(e) => { setEscMonthlyRent(Number(e.target.value)); setFintechResult(null); setGuestFintechResult(null); setLandlordFintechResult(null); }}
                                className="w-full h-1 bg-muted dark:bg-white/10 rounded-lg appearance-none cursor-pointer accent-violet-600 dark:accent-violet-500"
                              />
                            </div>

                            {/* DEPOSIT SOLUTIONS - PropTech Innovation */}
                            <div className="space-y-2">
                              <label className="text-[10px] font-black tracking-widest text-muted-foreground uppercase italic">DEPOZİTO ÖDEME MODELİ</label>
                              <div className="grid grid-cols-3 gap-2">
                                {[
                                  { id: "cash", label: "🔒 Peşin Depozito" },
                                  { id: "installments", label: "🗓️ 3 Taksitli" },
                                  { id: "insurance", label: "🛡️ Kaldıkça %2 Öde" }
                                ].map((sol) => (
                                  <button
                                    key={sol.id}
                                    onClick={() => { setDepositSolution(sol.id as any); setFintechResult(null); setGuestFintechResult(null); setLandlordFintechResult(null); }}
                                    className={`px-2 py-3 rounded-xl text-[9px] font-black uppercase tracking-wider italic border transition-all cursor-pointer ${
                                      depositSolution === sol.id 
                                        ? "bg-violet-500/10 border-violet-500/50 text-violet-600 dark:text-violet-400"
                                        : "bg-muted dark:bg-white/5 border border-border dark:border-white/5 text-muted-foreground dark:text-slate-400 hover:bg-muted/80 dark:hover:bg-white/10"
                                    }`}
                                  >
                                    {sol.label}
                                  </button>
                                ))}
                              </div>
                            </div>

                            <div className="grid grid-cols-2 gap-4">
                              <div className="space-y-2">
                                <label className="text-[10px] font-black tracking-widest text-muted-foreground uppercase italic">KORUMA (AY)</label>
                                <div className="grid grid-cols-3 gap-1 bg-muted dark:bg-white/5 p-1 rounded-xl border border-border dark:border-white/5">
                                  {[1, 2, 3].map((m) => (
                                    <button
                                      key={m}
                                      onClick={() => { setEscDepositMonths(m); setFintechResult(null); setGuestFintechResult(null); setLandlordFintechResult(null); }}
                                      className={`py-1.5 rounded-lg text-[10px] font-black italic cursor-pointer ${
                                        escDepositMonths === m 
                                          ? "bg-violet-500/10 dark:bg-violet-500/20 text-violet-600 dark:text-violet-400 border border-violet-500/30"
                                          : "text-muted-foreground hover:text-foreground"
                                      }`}
                                    >
                                      {m} Ay
                                    </button>
                                  ))}
                                </div>
                              </div>

                              <div className="space-y-2">
                                <label className="text-[10px] font-black tracking-widest text-muted-foreground uppercase italic">ACENTE BÖLÜŞÜMÜ</label>
                                <div className="w-full bg-card dark:bg-[#14151a] border border-border dark:border-white/5 rounded-xl px-3 py-2 text-xs font-bold text-foreground italic flex items-center gap-1">
                                  <Sliders className="w-3.5 h-3.5 text-violet-500" />
                                  %{splitCommRate} + %{splitCommRate} Gizli
                                </div>
                              </div>
                            </div>
                          </div>

                          <Button 
                            onClick={handleFintechCalculate}
                            disabled={isFintechCalculating}
                            className="w-full bg-violet-600 hover:bg-violet-500 text-white font-black uppercase text-xs tracking-widest italic py-6 rounded-2xl shadow-lg shadow-violet-500/10 cursor-pointer"
                          >
                            {isFintechCalculating ? (
                              <div className="flex items-center gap-2">
                                <RefreshCw className="w-4 h-4 animate-spin" />
                                <span>HESAPLANIYOR...</span>
                              </div>
                            ) : (
                              <div className="flex items-center gap-2">
                                <Landmark className="w-4 h-4" />
                                <span>
                                  {perspective === "agent" && "ACENTE CİRO DAĞILIMI"}
                                  {perspective === "guest" && "FATURAYI VE ÖDEME PLANINI GÖR"}
                                  {perspective === "landlord" && "NET GELİR VE KORUMA PLANINI AL"}
                                </span>
                              </div>
                            )}
                          </Button>

                          <AnimatePresence>
                            
                            {/* 🔑 AGENT VIEW: Full combined ciro streams */}
                            {perspective === "agent" && fintechResult && (
                              <motion.div 
                                initial={{ opacity: 0, y: 15 }}
                                animate={{ opacity: 1, y: 0 }}
                                className="bg-muted/40 dark:bg-[#12131a] border border-border dark:border-white/5 rounded-3xl p-5 space-y-4 animate-pulse-subtle"
                              >
                                <div className="grid grid-cols-2 gap-4 border-b border-border dark:border-white/5 pb-3">
                                  <div>
                                    <span className="text-[8px] font-black text-muted-foreground tracking-widest uppercase italic block">DEPOZİTO YAPISI</span>
                                    <span className="text-xs font-black text-amber-500 tracking-tight block mt-0.5">{fintechResult.depositPaymentMode}</span>
                                    <span className="text-[7.5px] text-muted-foreground font-medium block mt-0.5">{fintechResult.depositPaymentDetail}</span>
                                  </div>
                                  <div>
                                    <span className="text-[8px] font-black text-muted-foreground tracking-widest uppercase italic block">ESCROW KASASI</span>
                                    <span className="text-xs font-black text-violet-500 tracking-tight block mt-0.5">{fintechResult.escrowVault}</span>
                                    <span className="text-[7.5px] text-emerald-500 font-bold block mt-0.5">TDS Güvencesi</span>
                                  </div>
                                </div>

                                <div className="space-y-2">
                                  <span className="text-[9px] font-black text-primary tracking-widest uppercase italic block">
                                    ACENTE ÇİFT TARAFLI GELİR HAKEDİŞLERİ (GİZLİ):
                                  </span>
                                  
                                  <div className="grid grid-cols-2 gap-2 text-[9px] font-black tracking-wider uppercase italic pt-1">
                                    <div className="p-2.5 rounded-xl bg-card border border-border space-y-1">
                                      <span className="text-muted-foreground">KİRACI PAYI (%{splitCommRate}):</span>
                                      <span className="text-emerald-500 block text-xs">{fintechResult.tenantFee}</span>
                                    </div>
                                    <div className="p-2.5 rounded-xl bg-card border border-border space-y-1">
                                      <span className="text-muted-foreground">EV SAHİBİ PAYI (%{splitCommRate}):</span>
                                      <span className="text-emerald-500 block text-xs">{fintechResult.landlordFee}</span>
                                    </div>
                                  </div>

                                  <div className="p-3 rounded-xl bg-violet-500/5 border border-violet-500/10 text-center space-y-1">
                                    <span className="text-[8px] font-black text-violet-600 dark:text-violet-400 tracking-widest uppercase italic block">TOPLAM PLATFORM AYLIK MÜKERRER GELİRİ (MRR)</span>
                                    <span className="text-sm font-black text-violet-600 dark:text-violet-400">{fintechResult.combinedRevenue}</span>
                                  </div>
                                </div>
                              </motion.div>
                            )}

                            {/* 👤 KIRACI (GUEST) VIEW: No landlord info! */}
                            {perspective === "guest" && guestFintechResult && (
                              <motion.div 
                                initial={{ opacity: 0, y: 15 }}
                                animate={{ opacity: 1, y: 0 }}
                                className="bg-muted/40 dark:bg-[#12131a] border border-border dark:border-white/5 rounded-3xl p-5 space-y-4"
                              >
                                <div className="flex justify-between items-start border-b border-border dark:border-white/5 pb-3">
                                  <div>
                                    <span className="text-[9px] font-black text-muted-foreground tracking-widest uppercase italic block">KİRA BEDELİ</span>
                                    <span className="text-base font-black text-foreground tracking-tight block mt-0.5">{guestFintechResult.rentBase}</span>
                                  </div>
                                  <div className="text-right">
                                    <span className="text-[9px] font-black text-muted-foreground tracking-widest uppercase italic block">HİZMET BEDELİ (%2.5)</span>
                                    <span className="text-xs font-black text-violet-600 dark:text-violet-400 block mt-0.5">{guestFintechResult.serviceFee}</span>
                                  </div>
                                </div>

                                <div className="bg-card p-3.5 rounded-2xl border border-border space-y-2">
                                  <div className="flex items-center gap-2">
                                    <ShieldCheck className="w-4 h-4 text-emerald-500" />
                                    <span className="text-[10px] font-black uppercase italic tracking-wider text-foreground">
                                      {guestFintechResult.depositTitle}
                                    </span>
                                  </div>
                                  <p className="text-xs text-muted-foreground leading-normal">{guestFintechResult.depositDetails}</p>
                                </div>

                                <div className="p-3 rounded-2xl bg-emerald-500/5 border border-emerald-500/10 flex items-center justify-between">
                                  <div className="space-y-0.5">
                                    <span className="text-[8px] font-black text-emerald-600 dark:text-emerald-400 tracking-widest uppercase italic block">TOPLAM AYLIK FATURA</span>
                                    <span className="text-base font-black text-emerald-600 dark:text-emerald-400">{guestFintechResult.totalMonthlyInvoice}</span>
                                  </div>
                                  <Badge className="bg-emerald-500/10 border-emerald-500/20 text-emerald-600 dark:text-emerald-400 font-black italic text-[9px] py-1">GÜVENLİ İŞLEM</Badge>
                                </div>
                              </motion.div>
                            )}

                            {/* 🏡 EV SAHİBİ (LANDLORD) VIEW: No tenant info! */}
                            {perspective === "landlord" && landlordFintechResult && (
                              <motion.div 
                                initial={{ opacity: 0, y: 15 }}
                                animate={{ opacity: 1, y: 0 }}
                                className="bg-muted/40 dark:bg-[#12131a] border border-border dark:border-white/5 rounded-3xl p-5 space-y-4"
                              >
                                <div className="flex justify-between items-start border-b border-border dark:border-white/5 pb-3">
                                  <div>
                                    <span className="text-[9px] font-black text-muted-foreground tracking-widest uppercase italic block">BRÜT KİRA GELİRİ</span>
                                    <span className="text-base font-black text-foreground tracking-tight block mt-0.5">{landlordFintechResult.rentBase}</span>
                                  </div>
                                  <div className="text-right">
                                    <span className="text-[9px] font-black text-muted-foreground tracking-widest uppercase italic block">YÖNETİM BEDELİ (%2.5)</span>
                                    <span className="text-xs font-black text-rose-500 block mt-0.5">-{landlordFintechResult.managementFee}</span>
                                  </div>
                                </div>

                                <div className="bg-card p-3.5 rounded-2xl border border-border space-y-1">
                                  <div className="flex items-center gap-2">
                                    <ShieldCheck className="w-4 h-4 text-emerald-500" />
                                    <span className="text-[9px] font-black uppercase italic tracking-wider text-foreground">GÜVENCE DURUMU</span>
                                  </div>
                                  <span className="text-xs text-muted-foreground leading-normal block mt-1 font-bold italic">{landlordFintechResult.depositStatus}</span>
                                </div>

                                <div className="p-3 rounded-2xl bg-emerald-500/5 border border-emerald-500/10 flex items-center justify-between">
                                  <div className="space-y-0.5">
                                    <span className="text-[8px] font-black text-emerald-600 dark:text-emerald-400 tracking-widest uppercase italic block">GARANTİLİ EV SAHİBİ ÖDEMESİ</span>
                                    <span className="text-base font-black text-emerald-600 dark:text-emerald-400">{landlordFintechResult.netPayout}</span>
                                  </div>
                                  <Badge className="bg-emerald-500/10 border-emerald-500/20 text-emerald-600 dark:text-emerald-400 font-black italic text-[9px] py-1">LEASECARE+ AKTİF</Badge>
                                </div>
                              </motion.div>
                            )}

                          </AnimatePresence>
                        </motion.div>
                      )}

                      {/* SIMULATOR 3: BOOKING RISK & AUTO-SLA TASKS */}
                      {activeTab === "management" && (
                        <motion.div 
                          key="booking-sim"
                          initial={{ opacity: 0, scale: 0.95 }}
                          animate={{ opacity: 1, scale: 1 }}
                          exit={{ opacity: 0, scale: 0.95 }}
                          className="space-y-6"
                        >
                          <div className="flex justify-between items-center">
                            <span className="text-[10px] font-black tracking-widest text-muted-foreground uppercase italic">
                              {perspective === "agent" ? "OPERATIONAL COMPLIANCE" : perspective === "landlord" ? "MÜLK VE DOLULUK TAKİBİ" : "DİJİTAL REZERVASYON REHBERİ"}
                            </span>
                            <Badge className="bg-emerald-500/10 text-emerald-600 dark:text-emerald-400 border-emerald-500/20 font-black italic text-[9px]">SİMÜLATÖR</Badge>
                          </div>

                          <div className="space-y-4">
                            <div className="space-y-2">
                              <label className="text-[10px] font-black tracking-widest text-muted-foreground uppercase italic">
                                {perspective === "agent" ? "MİSAFİR İSMİ (TEST)" : "REZERVASYON SAHİBİ"}
                              </label>
                              <Input 
                                type="text"
                                value={guestName}
                                onChange={(e) => { setGuestName(e.target.value); setRiskResult(null); setGuestBookingResult(null); setLandlordBookingResult(null); }}
                                placeholder="Misafir adı yazınız..."
                                className="bg-card dark:bg-white/5 border border-border dark:border-white/5 rounded-xl text-xs text-foreground dark:text-white font-bold"
                              />
                            </div>

                            <div className="space-y-2">
                              <div className="flex justify-between text-[10px] font-black tracking-widest text-muted-foreground uppercase italic">
                                <span>REZERVASYON SÜRESİ</span>
                                <span className="text-emerald-600 dark:text-emerald-400 font-black">{stayNights} Gece</span>
                              </div>
                              <input 
                                type="range" 
                                min="1" 
                                max="30" 
                                value={stayNights}
                                onChange={(e) => { setStayNights(Number(e.target.value)); setRiskResult(null); setGuestBookingResult(null); setLandlordBookingResult(null); }}
                                className="w-full h-1 bg-muted dark:bg-white/10 rounded-lg appearance-none cursor-pointer accent-emerald-600 dark:accent-emerald-500"
                              />
                            </div>
                          </div>

                          <Button 
                            onClick={handleRiskScreening}
                            disabled={isRiskScreening}
                            className="w-full bg-emerald-600 hover:bg-emerald-500 text-white font-black uppercase text-xs tracking-widest italic py-6 rounded-2xl shadow-lg shadow-emerald-500/10 cursor-pointer"
                          >
                            {isRiskScreening ? (
                              <div className="flex items-center gap-2">
                                <RefreshCw className="w-4 h-4 animate-spin" />
                                <span>VERİLER SENKRONİZE EDİLİYOR...</span>
                              </div>
                            ) : (
                              <div className="flex items-center gap-2">
                                {perspective === "agent" ? <ShieldAlert className="w-4 h-4" /> : perspective === "landlord" ? <Building2 className="w-4 h-4" /> : <Wifi className="w-4 h-4" />}
                                <span>
                                  {perspective === "agent" && "REZERVASYON RİSK ANALİZİ YAP"}
                                  {perspective === "guest" && "AKILLI EV BAĞLANTISINI TEST ET"}
                                  {perspective === "landlord" && "MÜLK DOLULUK RAPORU AL"}
                                </span>
                              </div>
                            )}
                          </Button>

                          <AnimatePresence>
                            {/* AGENT VIEW: Risk and Task breakdown */}
                            {perspective === "agent" && riskResult && (
                              <motion.div 
                                initial={{ opacity: 0, y: 15 }}
                                animate={{ opacity: 1, y: 0 }}
                                className="bg-muted/40 dark:bg-[#12131a] border border-border dark:border-white/5 rounded-3xl p-5 space-y-4"
                              >
                                <div className="flex justify-between items-center border-b border-border dark:border-white/5 pb-3">
                                  <div>
                                    <span className="text-[9px] font-black text-muted-foreground tracking-widest uppercase italic block">FRAUD / RİSK SKORU</span>
                                    <span className={`text-lg font-black tracking-tight block mt-1 ${
                                      riskResult.riskScore > 50 ? "text-rose-500" : "text-emerald-600 dark:text-emerald-400"
                                    }`}>%{riskResult.riskScore}</span>
                                  </div>
                                  <Badge className={
                                    riskResult.riskScore > 50 
                                      ? "bg-rose-500/10 border-rose-500/20 text-rose-500 font-black italic text-[9px]"
                                      : "bg-emerald-500/10 border-emerald-500/20 text-emerald-600 dark:text-emerald-400 font-black italic text-[9px]"
                                  }>
                                    {riskResult.riskScore > 50 ? "ŞÜPHELİ REZERVASYON" : "GÜVENLİ TALEBİ"}
                                  </Badge>
                                </div>

                                <div className="space-y-1.5">
                                  <span className="text-[9px] font-black text-muted-foreground tracking-widest uppercase italic block">SİSTEM GÜVENLİK FLAGLERİ:</span>
                                  <div className="flex flex-wrap gap-1.5 pt-1">
                                    {riskResult.fraudFlags.map((flag, idx) => (
                                      <span 
                                        key={idx} 
                                        className={`px-2 py-1 rounded-lg text-[8px] font-bold border ${
                                          riskResult.riskScore > 50 
                                            ? "bg-rose-500/5 border-rose-500/20 text-rose-600 dark:text-rose-300"
                                            : "bg-card dark:bg-white/5 border border-border dark:border-white/5 text-muted-foreground dark:text-slate-300"
                                        }`}
                                      >
                                        {flag}
                                      </span>
                                    ))}
                                  </div>
                                </div>

                                <div className="border-t border-border dark:border-white/5 pt-3 space-y-2">
                                  <span className="text-[9px] font-black text-muted-foreground tracking-widest uppercase italic block">OTOMATİK ÜRETİLEN SLA GÖREVLERİ:</span>
                                  <div className="space-y-2">
                                    {riskResult.generatedTasks.map((t, idx) => (
                                      <div key={idx} className="flex justify-between items-center bg-card dark:bg-white/2 p-2 rounded-xl border border-border dark:border-white/2 text-[9px]">
                                        <div className="flex items-center gap-2">
                                          <div className={`w-1.5 h-1.5 rounded-full ${
                                            t.priority === "HIGH" ? "bg-rose-500" : t.priority === "MEDIUM" ? "bg-amber-500" : "bg-blue-500"
                                          }`} />
                                          <span className="text-foreground dark:text-white font-bold">{t.title}</span>
                                        </div>
                                        <span className="text-muted-foreground font-black italic">SLA: {t.sla} Saat</span>
                                      </div>
                                    ))}
                                  </div>
                                </div>
                              </motion.div>
                            )}

                            {/* GUEST VIEW: Smart stay details, wifi, climate control, IoT keys */}
                            {perspective === "guest" && guestBookingResult && (
                              <motion.div 
                                initial={{ opacity: 0, y: 15 }}
                                animate={{ opacity: 1, y: 0 }}
                                className="bg-muted/40 dark:bg-[#12131a] border border-border dark:border-white/5 rounded-3xl p-5 space-y-4"
                              >
                                <div className="flex justify-between items-center border-b border-border dark:border-white/5 pb-3">
                                  <div>
                                    <span className="text-[9px] font-black text-muted-foreground tracking-widest uppercase italic block">REZERVASYON DURUMU</span>
                                    <span className="text-sm font-black text-emerald-600 dark:text-emerald-400 tracking-tight block mt-1">
                                      {guestBookingResult.bookingStatus}
                                    </span>
                                  </div>
                                  <Badge className="bg-blue-500/10 border-blue-500/20 text-blue-600 dark:text-blue-400 font-black italic text-[9px] flex items-center gap-1">
                                    <KeyRound className="w-3.5 h-3.5 animate-bounce" /> ANAHTAR AKTİF
                                  </Badge>
                                </div>

                                <div className="grid grid-cols-2 gap-4">
                                  <div className="bg-card dark:bg-[#191b24] p-3 rounded-2xl border border-border dark:border-white/5 space-y-1">
                                    <span className="text-[8px] font-black text-muted-foreground tracking-widest uppercase italic block">KAPILARI AÇAN ŞİFRE</span>
                                    <span className="text-sm font-black text-foreground font-mono">{guestBookingResult.checkInCode}</span>
                                  </div>
                                  <div className="bg-card dark:bg-[#191b24] p-3 rounded-2xl border border-border dark:border-white/5 space-y-1">
                                    <span className="text-[8px] font-black text-muted-foreground tracking-widest uppercase italic block">DAİRE Wi-Fi ADI</span>
                                    <span className="text-sm font-black text-foreground font-mono">{guestBookingResult.wifiName}</span>
                                  </div>
                                </div>

                                <div className="border-t border-border dark:border-white/5 pt-3 space-y-2">
                                  <div className="flex justify-between items-center text-[9px] font-black text-muted-foreground tracking-widest uppercase italic">
                                    <span>AKILLI EV ISISI (IoT)</span>
                                    <span className="text-emerald-600 dark:text-emerald-400 font-black">{guestBookingResult.iotKlimaTemp} °C (Optimum)</span>
                                  </div>
                                  <div className="flex items-center gap-3">
                                    <button 
                                      onClick={() => setGuestBookingResult(prev => prev ? { ...prev, iotKlimaTemp: prev.iotKlimaTemp - 1 } : null)}
                                      className="w-8 h-8 rounded-lg bg-muted border border-border text-foreground hover:bg-muted/80 text-xs font-bold cursor-pointer"
                                    >
                                      -
                                    </button>
                                    <div className="flex-1 h-1 bg-muted dark:bg-white/10 rounded-full overflow-hidden">
                                      <div className="h-full bg-emerald-500 rounded-full" style={{ width: `${(guestBookingResult.iotKlimaTemp / 35) * 100}%` }} />
                                    </div>
                                    <button 
                                      onClick={() => setGuestBookingResult(prev => prev ? { ...prev, iotKlimaTemp: prev.iotKlimaTemp + 1 } : null)}
                                      className="w-8 h-8 rounded-lg bg-muted border border-border text-foreground hover:bg-muted/80 text-xs font-bold cursor-pointer"
                                    >
                                      +
                                    </button>
                                  </div>
                                </div>
                              </motion.div>
                            )}

                            {/* 🏡 LANDLORD VIEW: Occupancy and scheduling confirmations */}
                            {perspective === "landlord" && landlordBookingResult && (
                              <motion.div 
                                initial={{ opacity: 0, y: 15 }}
                                animate={{ opacity: 1, y: 0 }}
                                className="bg-muted/40 dark:bg-[#12131a] border border-border dark:border-white/5 rounded-3xl p-5 space-y-4"
                              >
                                <div className="flex justify-between items-center border-b border-border dark:border-white/5 pb-3">
                                  <div>
                                    <span className="text-[9px] font-black text-muted-foreground tracking-widest uppercase italic block">DOLULUK BİLGİSİ</span>
                                    <span className="text-sm font-black text-foreground block mt-1">
                                      {landlordBookingResult.occupancyStatus}
                                    </span>
                                  </div>
                                  <Badge className="bg-emerald-500/10 border-emerald-500/20 text-emerald-600 dark:text-emerald-400 font-black italic text-[9px] flex items-center gap-1">
                                    <UserCheck className="w-3.5 h-3.5" /> KİRACI ONAYLI
                                  </Badge>
                                </div>

                                <div className="space-y-3">
                                  <div>
                                    <span className="text-[8px] font-black text-muted-foreground tracking-widest uppercase italic block">KİRACI PROFİL DOĞRULAMASI</span>
                                    <div className="text-xs font-bold text-foreground mt-0.5 flex items-center gap-1.5">
                                      <CheckCircle2 className="w-4 h-4 text-emerald-500" />
                                      Kimlik, Adli Sicil ve Finansal Skor 100% Doğrulandı
                                    </div>
                                  </div>
                                  <div>
                                    <span className="text-[8px] font-black text-muted-foreground tracking-widest uppercase italic block">OPERASYONEL TEMİZLİK BİLGİSİ</span>
                                    <span className="text-xs font-medium text-slate-700 dark:text-slate-300 block mt-0.5">{landlordBookingResult.nextCleaningSchedule}</span>
                                  </div>
                                </div>

                                <div className="bg-violet-500/5 border border-violet-500/10 p-3.5 rounded-2xl">
                                  <span className="text-[8px] font-black text-violet-600 dark:text-violet-400 tracking-widest uppercase italic block">HAK EDİŞ TEMİNATI (LEASECARE+)</span>
                                  <span className="text-xs font-black text-slate-800 dark:text-white block mt-1">{landlordBookingResult.guaranteedRentPayout}</span>
                                </div>
                              </motion.div>
                            )}
                          </AnimatePresence>
                        </motion.div>
                      )}

                      {/* SIMULATOR 4: ENTERPRISE AUDIT & CRYPTO LEDGER */}
                      {activeTab === "security" && (
                        <motion.div 
                          key="ledger-sim"
                          initial={{ opacity: 0, scale: 0.95 }}
                          animate={{ opacity: 1, scale: 1 }}
                          exit={{ opacity: 0, scale: 0.95 }}
                          className="space-y-6"
                        >
                          <div className="flex justify-between items-center">
                            <span className="text-[10px] font-black tracking-widest text-muted-foreground uppercase italic">
                              {perspective === "agent" ? "REPORT COMPILER SERVICE" : perspective === "landlord" ? "FINANCIAL STATEMENT" : "GDPR & KVKK COMPLIANCE AUDIT"}
                            </span>
                            <Badge className="bg-amber-500/10 text-amber-600 dark:text-amber-400 border-amber-500/20 font-black italic text-[9px]">SİMÜLATÖR</Badge>
                          </div>

                          <div className="space-y-4">
                            <div className="space-y-2">
                              <label className="text-[10px] font-black tracking-widest text-muted-foreground uppercase italic">
                                {perspective === "agent" ? "RAPOR KATEGORİSİ" : "SORGULAMA TİPİ"}
                              </label>
                              
                              {perspective === "agent" ? (
                                <div className="grid grid-cols-2 gap-2">
                                  {[
                                    { id: "financial_income", label: "📈 Gelir Analizi" },
                                    { id: "compliance_gdpr", label: "⚖️ KVKK / GDPR Uyum" }
                                  ].map((r) => (
                                    <button
                                      key={r.id}
                                      onClick={() => { setReportType(r.id); setReportResult(null); }}
                                      className={`px-3 py-3 rounded-xl text-[10px] font-black uppercase tracking-wider italic border transition-all cursor-pointer ${
                                        reportType === r.id 
                                          ? "bg-amber-500/10 border-amber-500/50 text-amber-600 dark:text-amber-400"
                                          : "bg-muted dark:bg-white/5 border border-border dark:border-white/10 text-muted-foreground dark:text-slate-400 hover:bg-muted/80 dark:hover:bg-white/10"
                                      }`}
                                    >
                                      {r.label}
                                    </button>
                                  ))}
                                </div>
                              ) : (
                                <div className="w-full bg-muted border border-border rounded-xl px-3 py-3 text-xs font-bold text-foreground italic flex items-center gap-2">
                                  <ShieldAlert className="w-4 h-4 text-amber-500" />
                                  Kişisel Veri Kaydı ve Şeffaflık Log Sorgusu
                                </div>
                              )}
                            </div>
                          </div>

                          <Button 
                            onClick={handleReportCompile}
                            disabled={isCompilingReport}
                            className="w-full bg-amber-600 hover:bg-amber-500 text-white font-black uppercase text-xs tracking-widest italic py-6 rounded-2xl shadow-lg shadow-amber-500/10 cursor-pointer"
                          >
                            {isCompilingReport ? (
                              <div className="flex items-center gap-2">
                                <RefreshCw className="w-4 h-4 animate-spin" />
                                <span>VERİLER ANALİZ EDİLİYOR...</span>
                              </div>
                            ) : (
                              <div className="flex items-center gap-2">
                                <FileSpreadsheet className="w-4 h-4" />
                                <span>
                                  {perspective === "agent" && "AKILLI GELİR/UYUM RAPORU DERLE"}
                                  {perspective === "guest" && "ŞEFFAFLIK & KVKK AUDIT BAŞLAT"}
                                  {perspective === "landlord" && "MÜLK FİNANSAL RAPORU DERLE"}
                                </span>
                              </div>
                            )}
                          </Button>

                          <AnimatePresence>
                            {/* AGENT VIEW: Report and blockchain Ledger hash */}
                            {perspective === "agent" && reportResult && (
                              <motion.div 
                                initial={{ opacity: 0, y: 15 }}
                                animate={{ opacity: 1, y: 0 }}
                                className="bg-muted/40 dark:bg-[#12131a] border border-border dark:border-white/5 rounded-3xl p-5 space-y-4"
                              >
                                <div className="flex justify-between items-start border-b border-border dark:border-white/5 pb-3">
                                  <div>
                                    <span className="text-[9px] font-black text-muted-foreground tracking-widest uppercase italic block">EXECUTION ID</span>
                                    <span className="text-xs font-mono font-bold text-foreground block mt-1">{reportResult.reportId}</span>
                                  </div>
                                  <Badge className="bg-emerald-500/10 border-emerald-500/20 text-emerald-600 dark:text-emerald-400 font-black italic text-[9px]">
                                    {reportResult.status}
                                  </Badge>
                                </div>

                                <div className="space-y-1.5 font-mono text-[9px] text-foreground dark:text-slate-300">
                                  <span className="text-muted-foreground uppercase tracking-widest block font-sans font-black">MUTATION BLOCK HASH:</span>
                                  <span className="break-all block leading-normal bg-card dark:bg-white/2 p-2.5 rounded-xl border border-border dark:border-white/5 text-[8.5px]">
                                    {reportResult.hash}
                                  </span>
                                </div>

                                <div className="flex items-center justify-between bg-card dark:bg-white/2 p-3 rounded-2xl border border-border dark:border-white/5 mt-2">
                                  <div className="flex items-center gap-2 text-xs font-bold text-foreground dark:text-white">
                                    <Check className="w-4 h-4 text-emerald-500 dark:text-emerald-400" />
                                    <span>Rapor PDF Yayına Hazır</span>
                                  </div>
                                  <Button size="sm" variant="ghost" className="h-8 text-amber-600 dark:text-amber-400 hover:text-amber-500 p-0 text-[10px] font-black uppercase tracking-widest italic flex items-center gap-1.5 cursor-pointer">
                                    <Download className="w-3.5 h-3.5" /> İNDİR (PDF)
                                  </Button>
                                </div>
                              </motion.div>
                            )}

                            {/* GUEST VIEW: KVKK Compliance and data usage transparency logging */}
                            {perspective === "guest" && guestReportResult && (
                              <motion.div 
                                initial={{ opacity: 0, y: 15 }}
                                animate={{ opacity: 1, y: 0 }}
                                className="bg-muted/40 dark:bg-[#12131a] border border-border dark:border-white/5 rounded-3xl p-5 space-y-4"
                              >
                                <div className="flex justify-between items-center border-b border-border dark:border-white/5 pb-3">
                                  <div>
                                    <span className="text-[9px] font-black text-muted-foreground tracking-widest uppercase italic block">VERİ AUDIT KODU</span>
                                    <span className="text-xs font-mono font-bold text-foreground block mt-0.5">{guestReportResult.auditId}</span>
                                  </div>
                                  <Badge className="bg-emerald-500/10 border-emerald-500/20 text-emerald-600 dark:text-emerald-400 font-black italic text-[9px] flex items-center gap-1">
                                    <ShieldCheck className="w-3.5 h-3.5" /> %100 UYUMLU
                                  </Badge>
                                </div>

                                <div className="space-y-2">
                                  <span className="text-[9px] font-black text-muted-foreground tracking-widest uppercase italic block">SİSTEMDE KAYITLI KİŞİSEL VERİLERİNİZ:</span>
                                  <div className="grid grid-cols-2 gap-1.5">
                                    {guestReportResult.dataLogged.map((data, idx) => (
                                      <div key={idx} className="bg-card p-2 rounded-xl border border-border text-[9px] font-bold text-foreground flex items-center gap-1.5">
                                        <Check className="w-3.5 h-3.5 text-emerald-500" />
                                        {data}
                                      </div>
                                    ))}
                                  </div>
                                </div>

                                <div className="border-t border-border dark:border-white/5 pt-3 text-[8.5px] text-muted-foreground space-y-1">
                                  <div className="flex justify-between">
                                    <span>Son Analiz Zamanı:</span>
                                    <span className="font-bold text-foreground">{guestReportResult.timestamp}</span>
                                  </div>
                                  <div className="flex justify-between">
                                    <span>Sıfır Bilgi Şifreleme (ZKP):</span>
                                    <span className="font-bold text-emerald-600 dark:text-emerald-400">AKTİF (AES-256)</span>
                                  </div>
                                </div>
                              </motion.div>
                            )}

                            {/* 🏡 LANDLORD VIEW: Yield and tax statements */}
                            {perspective === "landlord" && landlordReportResult && (
                              <motion.div 
                                initial={{ opacity: 0, y: 15 }}
                                animate={{ opacity: 1, y: 0 }}
                                className="bg-muted/40 dark:bg-[#12131a] border border-border dark:border-white/5 rounded-3xl p-5 space-y-4"
                              >
                                <div className="flex justify-between items-center border-b border-border dark:border-white/5 pb-3">
                                  <div>
                                    <span className="text-[9px] font-black text-muted-foreground tracking-widest uppercase italic block">FİNANSAL DÖNEM</span>
                                    <span className="text-xs font-bold text-foreground block mt-0.5">{landlordReportResult.statementPeriod}</span>
                                  </div>
                                  <Badge className="bg-emerald-500/10 border-emerald-500/20 text-emerald-600 dark:text-emerald-400 font-black italic text-[9px] flex items-center gap-1">
                                    <ShieldCheck className="w-3.5 h-3.5" /> DEFTER ONAYLI
                                  </Badge>
                                </div>

                                <div className="space-y-3">
                                  <div>
                                    <span className="text-[8px] font-black text-muted-foreground tracking-widest uppercase italic block">YILLIK NET PORTFÖY VERİMLİLİĞİ</span>
                                    <span className="text-xs font-black text-emerald-600 dark:text-emerald-400 block mt-0.5">{landlordReportResult.portfolioYield}</span>
                                  </div>
                                  <div>
                                    <span className="text-[8px] font-black text-muted-foreground tracking-widest uppercase italic block">UYGULANAN STOPAJ / VERGİ MUAFİYETİ</span>
                                    <span className="text-xs font-bold text-foreground block mt-0.5">{landlordReportResult.taxExemptionApplied}</span>
                                  </div>
                                </div>

                                <div className="flex items-center justify-between bg-card dark:bg-white/2 p-3 rounded-2xl border border-border dark:border-white/5 mt-2">
                                  <div className="flex items-center gap-2 text-xs font-bold text-foreground dark:text-white">
                                    <Check className="w-4 h-4 text-emerald-500 dark:text-emerald-400" />
                                    <span>Stopaj Beyan Belgesi Hazır</span>
                                  </div>
                                  <Button size="sm" variant="ghost" className="h-8 text-amber-600 dark:text-amber-400 hover:text-amber-500 p-0 text-[10px] font-black uppercase tracking-widest italic flex items-center gap-1.5 cursor-pointer">
                                    <Download className="w-3.5 h-3.5" /> İNDİR (PDF)
                                  </Button>
                                </div>
                              </motion.div>
                            )}

                          </AnimatePresence>
                        </motion.div>
                      )}

                    </AnimatePresence>
                  </div>
                </div>

              </div>
            </div>

          </div>
        </section>

        {/* ══════════════ COMPREHENSIVE FEATURES GRID ══════════════ */}
        <section className="py-24 relative z-10">
          <div className="container mx-auto px-6">
            <div className="text-center mb-16 space-y-4">
              <h2 className="text-4xl lg:text-5xl font-black text-foreground italic uppercase tracking-tight">
                Tüm <span className="bg-gradient-to-r from-blue-600 dark:from-blue-400 to-indigo-600 dark:to-indigo-400 bg-clip-text text-transparent">PLATFORM ÖZELLİKLERİ</span>
              </h2>
              <p className="text-muted-foreground max-w-xl mx-auto font-medium">Uygulamamızın kurumsal standartlarda sunduğu entegre ve üst düzey tüm araçlar.</p>
            </div>

            <div className="grid sm:grid-cols-2 lg:grid-cols-4 gap-4 max-w-6xl mx-auto">
              {[
                { icon: Bot, name: "AI Değerleme", desc: "Gayrimenkullerin anlık ve objektif fiyat tahmini." },
                { icon: Video, name: "Video Turları", desc: "Görsellerden otomatik 4K tanıtım videosu." },
                { icon: Search, name: "Akıllı Arama", desc: "Semantik ve filtre bazlı lüks arama." },
                { icon: MapPin, name: "Harita Entegrasyonu", desc: "Harita üzerinde konum ve çevre analizi." },
                { icon: Building2, name: "Portföy Yönetimi", desc: "Tüm varlıkların tek merkezden takibi." },
                { icon: CalendarCheck, name: "Rezervasyonlar", desc: "Dijital takvim ve çakışmasız planlama." },
                { icon: CreditCard, name: "Ödeme Sistemi", desc: "Hızlı, güvenli ve düzenli kira tahsilatı." },
                { icon: Users, name: "CRM & Müşteriler", desc: "Tüm müşteri ilişkileri veritabanı." },
                { icon: FileSearch, name: "Dijital Sözleşmeler", desc: "Yasal uyumlu e-imzalı sözleşme takibi." },
                { icon: Bell, name: "Otomatik Bildirimler", desc: "Gecikme ve hatırlatma anlık duyuruları." },
                { icon: Globe2, name: "20+ Dil Desteği", desc: "Global emlak pazarı entegrasyonu." },
                { icon: BarChart3, name: "Gelişmiş Analitik", desc: "Gelir-gider tabloları ve finansal raporlar." },
                { icon: Shield, name: "Defter Güvenliği", desc: "Kriptografik blockchain koruması." },
                { icon: Wifi, name: "IoT Entegrasyonu", desc: "Akıllı ev kilit ve kontrol sistemleri." },
                { icon: Cpu, name: "Kurumsal API", desc: "Harici CRM yazılımlarıyla entegrasyon." },
                { icon: Star, name: "Vip Destek", desc: "7/24 kesintisiz kurumsal müşteri hizmeti." },
              ].map((f, i) => (
                <div 
                  key={i} 
                  className="group p-6 rounded-3xl bg-card border border-border hover:bg-muted dark:hover:bg-[#121319] hover:border-border/80 dark:hover:border-white/10 transition-all duration-500 cursor-default flex flex-col justify-between gap-4 shadow-sm"
                >
                  <div className="flex items-center gap-3">
                    <div className="w-10 h-10 rounded-xl bg-muted flex items-center justify-center shrink-0 group-hover:bg-primary/10 transition-colors">
                      <f.icon className="w-5 h-5 text-blue-500 dark:text-blue-400 group-hover:scale-110 transition-transform" />
                    </div>
                    <span className="text-xs font-black uppercase italic tracking-wider text-foreground">{f.name}</span>
                  </div>
                  <p className="text-muted-foreground text-xs font-medium leading-relaxed">{f.desc}</p>
                </div>
              ))}
            </div>
          </div>
        </section>

        {/* ══════════════ DYNAMIC CALL TO ACTION (CTA) ══════════════ */}
        <section className="py-28 relative z-10">
          <div className="container mx-auto px-6">
            <div className="relative max-w-5xl mx-auto rounded-5xl overflow-hidden p-1 bg-gradient-to-r from-blue-500 via-violet-500 to-indigo-500">
              <div className="bg-card dark:bg-[#0b0c11] rounded-[calc(2.5rem-1px)] p-12 md:p-16 text-center space-y-8 relative overflow-hidden">
                <div className="absolute inset-0 bg-radial from-violet-500/10 to-transparent blur-2xl pointer-events-none" />
                
                <h2 className="text-4xl md:text-5xl font-black text-foreground dark:text-white italic uppercase tracking-tight leading-none">
                  ŞİMDİ KEŞFETMEYE BAŞLAYIN
                </h2>
                
                <p className="text-muted-foreground max-w-lg mx-auto font-medium text-base">
                  14 günlük ücretsiz kurumsal deneme sürümü ile tüm özelliklere sınırsız erişim sağlayın. Kredi kartı gerekmez.
                </p>
                
                <div className="flex flex-wrap justify-center gap-4 pt-4">
                  <Link to="/auth/signup">
                    <Button size="lg" className="bg-foreground text-background dark:bg-white dark:text-black hover:bg-foreground/90 dark:hover:bg-slate-100 px-8 h-14 font-black uppercase text-xs tracking-widest italic rounded-2xl shadow-2xl transition-transform hover:-translate-y-0.5 cursor-pointer">
                      ÜCRETSİZ BAŞLA
                      <ArrowRight className="ml-2 w-4 h-4 text-background dark:text-slate-900" />
                    </Button>
                  </Link>
                </div>
              </div>
            </div>
          </div>
        </section>

      </div>
    </>
  );
}
