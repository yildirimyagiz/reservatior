"use client";

import { Helmet } from "react-helmet-async";
import { useTranslation } from "react-i18next";
import { useState, useMemo, useEffect, useRef } from "react";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Slider } from "@/components/ui/slider";
import { m } from "framer-motion";
import {
  Shield, ArrowRight, CheckCircle2, Users, Building2,
  Lock, Sparkles, Calculator, ArrowLeftRight, Percent, 
  AlertTriangle, PiggyBank, Briefcase, Landmark
} from "lucide-react";
import { useAuth } from "@/lib/auth/hooks";

/* ───── Animated Counter ───── */
function AnimatedCounter({ target, suffix = "", prefix = "", isCurrency = false }: { target: number; suffix?: string; prefix?: string; isCurrency?: boolean }) {
  const [count, setCount] = useState(0);
  const ref = useRef<HTMLSpanElement>(null);
  
  useEffect(() => {
    const obs = new IntersectionObserver(([e]) => {
      if (e.isIntersecting) {
        let s = 0;
        const step = (ts: number) => { 
          s = s || ts; 
          const p = Math.min((ts - s) / 1500, 1); 
          const easeProgress = p === 1 ? 1 : 1 - Math.pow(2, -10 * p);
          setCount(Math.floor(easeProgress * target)); 
          if (p < 1) requestAnimationFrame(step); 
        };
        requestAnimationFrame(step); 
        obs.disconnect();
      }
    }, { threshold: 0.1 });
    if (ref.current) obs.observe(ref.current);
    return () => obs.disconnect();
  }, [target]);

  const formatted = isCurrency 
    ? new Intl.NumberFormat('en-US', { maximumFractionDigits: 0 }).format(count)
    : count.toLocaleString();

  return <span ref={ref}>{prefix}{formatted}{suffix}</span>;
}

type RoleKey = "AGENT" | "TENANT_BUYER" | "OWNER_SELLER" | "AGENCY_ADMIN";
type TransactionMode = "RENT" | "BUY";

export default function LeaseCare() {
  const { t } = useTranslation();
  const { getUserRole } = useAuth();
  const userRole = getUserRole();

  // Determine if the user should see all roles
  const isAdmin = !userRole || userRole === "ORG_ADMIN" || userRole === "READ_ONLY";

  // Role Management State
  const [activeRole, setActiveRole] = useState<RoleKey>("AGENT");
  const [transactionMode, setTransactionMode] = useState<TransactionMode>("RENT");

  // Force active role based on logged-in user if not admin
  useEffect(() => {
    if (!isAdmin) {
      if (userRole === "TENANT_GUEST") setActiveRole("TENANT_BUYER");
      else if (userRole === "OWNER") setActiveRole("OWNER_SELLER");
      else if (userRole === "AGENCY_ADMIN") setActiveRole("AGENCY_ADMIN");
      else if (userRole === "AGENT") setActiveRole("AGENT");
    }
  }, [userRole, isAdmin]);

  // Calculator state
  const [propertyValue, setPropertyValue] = useState(2000); // Represents Rent or Sale Price
  const [installments, setInstallments] = useState(12);

  // Auto-adjust scale based on transaction mode
  useEffect(() => {
    if (transactionMode === "RENT") {
      setPropertyValue(2000);
      setInstallments(12);
    } else {
      setPropertyValue(500000);
      setInstallments(12);
    }
  }, [transactionMode]);

  const roles: { id: RoleKey; label: string; icon: any }[] = [
    { id: "AGENT", label: t("reoscare.role_agent", "Acente (Agent)"), icon: Briefcase },
    { id: "TENANT_BUYER", label: transactionMode === "RENT" ? t("reoscare.role_tenant", "Kiracı") : t("reoscare.role_buyer", "Alıcı"), icon: Users },
    { id: "OWNER_SELLER", label: transactionMode === "RENT" ? t("reoscare.role_owner", "Ev Sahibi") : t("reoscare.role_seller", "Satıcı"), icon: Building2 },
    { id: "AGENCY_ADMIN", label: t("reoscare.role_agency", "Emlak Ofisi"), icon: Landmark },
  ];

  const calc = useMemo(() => {
    if (transactionMode === "RENT") {
      const annualRent = propertyValue * 12;
      const ownerCommission = annualRent * 0.035;
      const tenantCommission = annualRent * 0.045; 
      const agentTotalCommission = annualRent * 0.07;
      
      const agentUpfront = agentTotalCommission * 0.50;
      const agentDeferredBase = agentTotalCommission * 0.50;
      const agentDeferredWithMarkup = agentDeferredBase * 1.10;
      
      const tenantDepositTotal = propertyValue * 2;
      const tenantMonthlyInstallment = (tenantCommission + tenantDepositTotal) / installments;

      const traditionalDeposit = propertyValue * 3;
      const traditionalCommission = propertyValue * 2;
      const traditionalUpfront = traditionalDeposit + traditionalCommission;
      const leasecareFirstMonth = propertyValue + tenantCommission + tenantDepositTotal;
      const savingsFirstMonth = traditionalUpfront + propertyValue - leasecareFirstMonth;

      return {
        ownerCommission, tenantCommission, agentTotalCommission,
        agentUpfront, agentDeferredWithMarkup,
        tenantDepositTotal, tenantMonthlyInstallment,
        traditionalDeposit, traditionalCommission, traditionalUpfront,
        leasecareFirstMonth, savingsFirstMonth
      };
    } else {
      const buyerCommission = propertyValue * 0.02;
      const sellerCommission = propertyValue * 0.02;
      const agentTotalCommission = buyerCommission + sellerCommission;

      const agentUpfront = agentTotalCommission * 0.50;
      const agentDeferredBase = agentTotalCommission * 0.50;
      const agentDeferredWithMarkup = agentDeferredBase * 1.10;

      const buyerMonthlyInstallment = buyerCommission / installments;

      return {
        ownerCommission: sellerCommission,
        tenantCommission: buyerCommission,
        agentTotalCommission,
        agentUpfront,
        agentDeferredWithMarkup,
        tenantDepositTotal: 0,
        tenantMonthlyInstallment: buyerMonthlyInstallment,
        traditionalDeposit: 0, traditionalCommission: buyerCommission, traditionalUpfront: buyerCommission,
        leasecareFirstMonth: buyerMonthlyInstallment, savingsFirstMonth: buyerCommission - buyerMonthlyInstallment
      };
    }
  }, [propertyValue, installments, transactionMode]);

  return (
    <>
      <Helmet>
        <title>LeaseCare+ - Smart Lease Management | Reservatior</title>
        <meta name="description" content="Automate lease management with AI-powered tools for lease tracking, renewals, and tenant management. Monthly micro-payments instead of traditional upfront commission." />
      </Helmet>

      <div className="min-h-screen bg-background text-foreground overflow-x-hidden selection:bg-success/30">

        {/* ══════ HERO ══════ */}
        <section className="relative pt-32 pb-20 overflow-hidden">
          <div className="absolute inset-0">
            <div className="absolute top-[-10%] left-[20%] w-[500px] h-[400px] rounded-full bg-success/8 dark:bg-success/15 blur-[140px]" />
            <div className="absolute bottom-0 right-[10%] w-[500px] h-[400px] rounded-full bg-brand/6 dark:bg-brand/12 blur-[140px]" />
          </div>

          <div className="relative z-10 container mx-auto px-6 text-center space-y-8">
            <Badge className="bg-success/10 text-success dark:text-success border-success/20 px-4 py-1.5 rounded-full text-xs font-bold tracking-wider gap-2">
              <Sparkles className="w-3.5 h-3.5" /> {t("leasecare.industry_first", "Industry First")}
            </Badge>

            <h1 className="text-5xl lg:text-7xl font-black tracking-tight leading-[0.95]">
              <span className="text-foreground">LeaseCare</span>
              <span className="bg-gradient-to-r from-blue-500 to-blue-500 bg-clip-text text-transparent">+</span>
            </h1>
            <p className="text-xl text-muted-foreground max-w-2xl mx-auto leading-relaxed">
              <span dangerouslySetInnerHTML={{ __html: t("leasecare.hero_desc_hidden", "Traditional <span class='font-bold text-foreground'>upfront deposits</span> and <span class='font-bold text-foreground'>heavy commission burdens</span> are over. Everyone wins with <span class='font-bold text-success dark:text-success'>dynamic micro-payments</span>.") }} />
            </p>

            <div className="flex flex-wrap justify-center gap-4 pt-2">
              <Button size="lg" className="bg-blue-600 hover:bg-success text-white h-13 px-8 rounded-2xl font-bold shadow-lg shadow-blue-600/20 group">
                {t("leasecare.apply_now", "Apply Now")} <ArrowRight className="ml-2 w-4 h-4 group-hover:translate-x-1 transition-transform" />
              </Button>
              <Button size="lg" variant="outline" className="h-13 px-8 rounded-2xl font-semibold">
                <Calculator className="mr-2 w-4 h-4" /> {t("leasecare.calculate", "Calculate")}
              </Button>
            </div>
          </div>
        </section>

        {/* ══════ COMPARISON ══════ */}
        <section className="py-20">
          <div className="container mx-auto px-6">
            <div className="text-center mb-14 space-y-3">
              <h2 className="text-3xl lg:text-4xl font-black text-foreground">
                <span dangerouslySetInnerHTML={{ __html: t("leasecare.traditional_vs_leasecare", "Traditional vs <span class='text-success dark:text-success'>LeaseCare+</span>") }} />
              </h2>
              <p className="text-muted-foreground max-w-lg mx-auto">{t("leasecare.comparison_desc", "Same home, same rent — but a very different move-in cost")}</p>
            </div>

            <div className="grid md:grid-cols-2 gap-6 max-w-4xl mx-auto">
              {/* Traditional */}
              <div className="p-8 rounded-3xl bg-red-500/5 dark:bg-red-500/10 border border-red-500/15 space-y-6">
                <div className="flex items-center gap-3">
                  <div className="w-10 h-10 rounded-xl bg-red-500/10 flex items-center justify-center"><AlertTriangle className="w-5 h-5 text-red-500" /></div>
                  <div>
                    <h3 className="font-bold text-foreground">{t("leasecare.traditional_model", "Traditional Model")}</h3>
                    <p className="text-xs text-muted-foreground">{t("leasecare.first_day_payment", "First day upfront payment")}</p>
                  </div>
                </div>
                <div className="space-y-3">
                  <div className="flex justify-between items-center text-sm"><span className="text-muted-foreground">{t("leasecare.deposit_traditional", "Deposit (Upfront)")}</span><span className="font-bold text-foreground text-red-400">{t("leasecare.very_high", "Very High")}</span></div>
                  <div className="flex justify-between items-center text-sm"><span className="text-muted-foreground">{t("leasecare.commission_traditional", "Commission (Upfront)")}</span><span className="font-bold text-foreground text-red-400">{t("leasecare.very_high", "Very High")}</span></div>
                  <div className="flex justify-between items-center text-sm"><span className="text-muted-foreground">{t("leasecare.first_month_rent", "First month rent")}</span><span className="font-bold text-foreground">${propertyValue.toLocaleString()}</span></div>
                  <div className="h-px bg-red-500/20 my-2" />
                  <div className="flex justify-between items-center text-base"><span className="font-bold text-red-500">{t("leasecare.total_first_day", "Total First Day")}</span><span className="text-2xl font-black text-red-500">{t("leasecare.costly", "Costly")}</span></div>
                </div>
              </div>

              {/* LeaseCare+ */}
              <div className="p-8 rounded-3xl bg-success/5 dark:bg-success/10 border border-success/20 space-y-6 relative overflow-hidden">
                <div className="absolute top-3 right-3"><Badge className="bg-success text-white border-0 text-[10px] font-bold">{t("leasecare.recommended", "RECOMMENDED")}</Badge></div>
                <div className="flex items-center gap-3">
                  <div className="w-10 h-10 rounded-xl bg-success/10 flex items-center justify-center"><Shield className="w-5 h-5 text-success" /></div>
                  <div>
                    <h3 className="font-bold text-foreground">{t("leasecare.leasecare_model", "LeaseCare+ Model")}</h3>
                    <p className="text-xs text-muted-foreground">{t("leasecare.monthly_micro_payment", "Monthly micro-payment")}</p>
                  </div>
                </div>
                <div className="space-y-3">
                  <div className="flex justify-between items-center text-sm"><span className="text-muted-foreground">{t("leasecare.first_month_rent", "First month rent")}</span><span className="font-bold text-foreground">${propertyValue.toLocaleString()}</span></div>
                  <div className="flex justify-between items-center text-sm"><span className="text-muted-foreground">{t("leasecare.micro_commission", "Dynamic Micro Commission")}</span><span className="font-bold text-success">{t("client.src.partner_rate", "Partner Rate")}</span></div>
                  <div className="flex justify-between items-center text-sm"><span className="text-muted-foreground">{t("leasecare.micro_deposit", "Dynamic Micro Deposit")}</span><span className="font-bold text-success">{t("client.src.partner_rate", "Partner Rate")}</span></div>
                  <div className="h-px bg-success/20 my-2" />
                  <div className="flex justify-between items-center text-base"><span className="font-bold text-success dark:text-success">{t("leasecare.total_first_day", "Total First Day")}</span><span className="text-2xl font-black text-success dark:text-success">Minimum</span></div>
                </div>
                <div className="bg-success/10 rounded-xl p-3 text-center">
                  <span className="text-sm font-bold text-success dark:text-success">
                    💰 {t("leasecare.up_to_85_savings", "Up to 85% Savings on Move-in!")}
                  </span>
                </div>
              </div>
            </div>
          </div>
        </section>

        {/* ══════ HOW IT WORKS ══════ */}
        <section className="py-20 bg-muted/30">
          <div className="container mx-auto px-6">
            <h2 className="text-3xl font-black text-foreground text-center mb-14">
              <span dangerouslySetInnerHTML={{ __html: t("leasecare.how_it_works", "How it <span class='text-success dark:text-success'>Works?</span>") }} />
            </h2>
            <div className="grid md:grid-cols-3 gap-6 max-w-5xl mx-auto">
              {[
                { icon: Percent, title: t("leasecare.dynamic_commission", "Dynamic Micro Commission"), desc: t("leasecare.dynamic_commission_desc", "No upfront commission! Tenants and landlords benefit from specialized micro-rates determined by partnership levels."), color: "text-brand" },
                { icon: PiggyBank, title: t("leasecare.dynamic_deposit", "Dynamic Micro Deposit"), desc: t("leasecare.dynamic_deposit_desc", "Tenants accumulate their deposit dynamically alongside their rent via micro-installments."), color: "text-violet-500" },
                { icon: Lock, title: t("leasecare.escrow_assurance", "Escrow Assurance"), desc: t("leasecare.escrow_desc", "All deposits are securely held in Reservatior Escrow account. Neutral mediation in case of dispute."), color: "text-success" },
              ].map((s, i) => (
                <div key={i} className="p-7 rounded-2xl bg-card border border-border/50 hover:border-primary/20 hover:shadow-md transition-all space-y-4 text-center">
                  <div className={`w-14 h-14 rounded-2xl bg-muted flex items-center justify-center mx-auto ${s.color}`}>
                    <s.icon className="w-6 h-6" />
                  </div>
                  <h3 className="text-lg font-bold text-foreground">{s.title}</h3>
                  <p className="text-sm text-muted-foreground leading-relaxed">{s.desc}</p>
                </div>
              ))}
            </div>

            {/* Payment Flow Diagram */}
            <div className="max-w-3xl mx-auto mt-14 p-6 rounded-2xl bg-card border border-border/50">
              <h4 className="text-sm font-bold text-muted-foreground tracking-wider text-center mb-6">{t("leasecare.payment_flow", "Monthly Payment Flow")}</h4>
              <div className="flex items-center justify-between gap-2">
                <div className="text-center space-y-2 flex-1">
                  <div className="w-12 h-12 rounded-full bg-brand/10 flex items-center justify-center mx-auto"><Users className="w-5 h-5 text-brand" /></div>
                  <div className="text-xs font-bold text-foreground">{t("common.tenant", "Tenant")}</div>
                  <div className="text-[10px] text-muted-foreground">{t("leasecare.tenant_calc_dynamic", "Rent + Micro Payments")}</div>
                </div>
                <ArrowLeftRight className="w-5 h-5 text-muted-foreground shrink-0" />
                <div className="text-center space-y-2 flex-1">
                  <div className="w-12 h-12 rounded-full bg-success/10 flex items-center justify-center mx-auto"><Shield className="w-5 h-5 text-success" /></div>
                  <div className="text-xs font-bold text-foreground">{t("leasecare.escrow", "Reservatior Escrow")}</div>
                  <div className="text-[10px] text-muted-foreground">{t("leasecare.secure_storage", "Secure storage")}</div>
                </div>
                <ArrowLeftRight className="w-5 h-5 text-muted-foreground shrink-0" />
                <div className="text-center space-y-2 flex-1">
                  <div className="w-12 h-12 rounded-full bg-amber-500/10 flex items-center justify-center mx-auto"><Building2 className="w-5 h-5 text-amber-500" /></div>
                  <div className="text-xs font-bold text-foreground">{t("leasecare.landlord", "Landlord")}</div>
                  <div className="text-[10px] text-muted-foreground">{t("leasecare.landlord_calc_dynamic", "Rent - Micro Fee")}</div>
                </div>
              </div>
            </div>
          </div>
        </section>

        {/* ══════ CALCULATOR & ROLE TABS ══════ */}
        <section className="py-20 relative z-20">
          <div className="container mx-auto px-4 md:px-6">
            
            <div className="text-center mb-14 space-y-3">
              <Badge className="bg-success/10 text-success dark:text-success border-success/20 px-4 py-1 rounded-full text-xs font-bold tracking-wider">
                <Calculator className="w-3.5 h-3.5 mr-1.5" /> {t("leasecare.interactive_calc", "Interactive Calculator")}
              </Badge>
              <h2 className="text-3xl font-black text-foreground">{t("leasecare.how_much_save", "How much will you save?")}</h2>
            </div>

            {/* Transaction Mode Toggle */}
            <div className="flex justify-center mb-8">
              <div className="bg-muted p-1.5 rounded-full flex gap-2 border border-border shadow-inner">
                <button 
                  onClick={() => setTransactionMode("RENT")}
                  className={`px-8 py-2 rounded-full text-sm font-bold transition-all ${transactionMode === "RENT" ? "bg-background text-success dark:text-success shadow-md" : "text-muted-foreground hover:text-foreground"}`}
                >
                  {t("reoscare.mode_rent", "Kiralık (Rent)")}
                </button>
                <button 
                  onClick={() => setTransactionMode("BUY")}
                  className={`px-8 py-2 rounded-full text-sm font-bold transition-all ${transactionMode === "BUY" ? "bg-background text-success dark:text-success shadow-md" : "text-muted-foreground hover:text-foreground"}`}
                >
                  {t("reoscare.mode_buy", "Satılık (Buy)")}
                </button>
              </div>
            </div>

            {/* Role Tabs */}
            {isAdmin && (
              <div className="flex flex-wrap justify-center gap-3 mb-12">
                {roles.map(role => (
                  <button
                    key={role.id}
                    onClick={() => setActiveRole(role.id)}
                    className={`relative flex items-center gap-2 px-6 py-3 rounded-2xl font-bold text-sm md:text-base transition-all duration-300 ${
                      activeRole === role.id 
                        ? "bg-foreground text-background shadow-xl scale-105" 
                        : "bg-card text-muted-foreground hover:bg-muted border border-border"
                    }`}
                  >
                    <role.icon className={`w-5 h-5 ${activeRole === role.id ? "text-success" : "text-muted-foreground"}`} />
                    {role.label}
                    {activeRole === role.id && (
                      <m.div layoutId="activeRoleIndicatorSPA" className="absolute -bottom-2 left-1/2 -translate-x-1/2 w-8 h-1.5 rounded-full bg-success" />
                    )}
                  </button>
                ))}
              </div>
            )}

            <div className="grid lg:grid-cols-12 gap-8 max-w-7xl mx-auto">
              
              {/* Value Props Content based on Role */}
              <m.div 
                key={`${activeRole}-${transactionMode}`}
                initial={{ opacity: 0, x: -20 }}
                animate={{ opacity: 1, x: 0 }}
                className="lg:col-span-5 flex flex-col justify-center space-y-8 p-8 md:p-12 rounded-[2.5rem] bg-card border border-border shadow-2xl"
              >
                {activeRole === "AGENT" && (
                  <>
                    <h3 className="text-3xl font-black text-foreground leading-tight">
                      {transactionMode === "RENT" ? t("reoscare.agent_rent_title", "Komisyonunu Güvenceye Al, %10 Fazla Kazan") : t("reoscare.agent_buy_title", "Alıcıya Taksit Sun, Satışları Hızlandır")}
                    </h3>
                    <p className="text-lg text-muted-foreground font-medium">
                      {transactionMode === "RENT" 
                        ? t("reoscare.agent_rent_desc", "Klasik kiralama devri bitti. Komisyonunun %50'sini anında nakit al, kalan %50'yi ReosCare güvencesiyle %10 getiriyle taksitli tahsil et. Sisteme bağımlılık ve sürekli nakit akışı yarat.")
                        : t("reoscare.agent_buy_desc", "Satış işlemlerindeki en büyük engel olan alıcı komisyonunu ReosCare ile 12 aya kadar taksitlendir. Likidite sağla ve işlem kapatma hızını uçur.")}
                    </p>
                    <div className="space-y-4">
                      <div className="flex items-start gap-3"><CheckCircle2 className="w-5 h-5 text-brand mt-0.5 shrink-0" /><span className="text-sm font-bold text-foreground">{t("reoscare.agent_adv1", "%50 Peşin Komisyon Anında Hesabında")}</span></div>
                      <div className="flex items-start gap-3"><CheckCircle2 className="w-5 h-5 text-brand mt-0.5 shrink-0" /><span className="text-sm font-bold text-foreground">{t("reoscare.agent_adv2", "Kalan Bakiyeye %10 Ekstra Getiri (Yield)")}</span></div>
                      <div className="flex items-start gap-3"><CheckCircle2 className="w-5 h-5 text-brand mt-0.5 shrink-0" /><span className="text-sm font-bold text-foreground">{t("reoscare.agent_adv3", "Vendor Lock-in ile Kesintisiz Gelir Akışı")}</span></div>
                    </div>
                  </>
                )}

                {activeRole === "TENANT_BUYER" && (
                  <>
                    <h3 className="text-3xl font-black text-foreground leading-tight">
                      {transactionMode === "RENT" ? t("reoscare.tenant_title", "Depozito ve Komisyon Yükünden Kurtul") : t("reoscare.buyer_title", "Komisyonu Taksitle Öde, Ev Sahibi Ol")}
                    </h3>
                    <p className="text-lg text-muted-foreground font-medium">
                      {transactionMode === "RENT" 
                        ? t("reoscare.tenant_desc", "Sadece %1'lik ReosCare koruma primi ile devasa peşinatlar ödemeden yeni evine taşın. Depozito ve komisyonu aylık mikro-ödemelerle rahatça öde.")
                        : t("reoscare.buyer_desc", "Tapu harcı ve peşinatlar zaten zorlayıcı. %2'lik alıcı komisyonunu tek seferde ödemek yerine ReosCare ile aylık taksitlere böl.")}
                    </p>
                    <div className="space-y-4">
                      <div className="flex items-start gap-3"><CheckCircle2 className="w-5 h-5 text-success mt-0.5 shrink-0" /><span className="text-sm font-bold text-foreground">{transactionMode === "RENT" ? t("reoscare.tenant_adv1", "Depozito Taksitlendirmesi") : t("reoscare.buyer_adv1", "%2 Komisyon Taksitlendirmesi")}</span></div>
                      <div className="flex items-start gap-3"><CheckCircle2 className="w-5 h-5 text-success mt-0.5 shrink-0" /><span className="text-sm font-bold text-foreground">{t("reoscare.tenant_adv2", "Güvenli Escrow Hesabı")}</span></div>
                      <div className="flex items-start gap-3"><CheckCircle2 className="w-5 h-5 text-success mt-0.5 shrink-0" /><span className="text-sm font-bold text-foreground">{t("reoscare.tenant_adv3", "Loyalty (Sadakat) Puanı ve Kredi Notu Avantajı")}</span></div>
                    </div>
                  </>
                )}

                {activeRole === "OWNER_SELLER" && (
                  <>
                    <h3 className="text-3xl font-black text-foreground leading-tight">
                      {transactionMode === "RENT" ? t("reoscare.owner_title", "%100 Kira Garantisi, Sıfır Risk") : t("reoscare.seller_title", "Satış Sürtünmesini Ortadan Kaldır")}
                    </h3>
                    <p className="text-lg text-muted-foreground font-medium">
                      {transactionMode === "RENT" 
                        ? t("reoscare.owner_desc", "ReosCare sigorta havuzu sayesinde kiranız devlet destekli kontratlarla (state machine) güvence altında. Üstelik cebinizden sigorta ücreti çıkmaz.")
                        : t("reoscare.seller_desc", "Alıcılara komisyon taksitlendirme imkanı sunarak mülkünüzün satılma hızını artırın. Risksiz, şeffaf süreç.")}
                    </p>
                    <div className="space-y-4">
                      <div className="flex items-start gap-3"><CheckCircle2 className="w-5 h-5 text-amber-500 mt-0.5 shrink-0" /><span className="text-sm font-bold text-foreground">{transactionMode === "RENT" ? t("reoscare.owner_adv1", "Kiracı Tarafından Fonlanan Sigorta Havuzu") : t("reoscare.seller_adv1", "Hızlı İşlem Kapatma (Conversion)")}</span></div>
                      <div className="flex items-start gap-3"><CheckCircle2 className="w-5 h-5 text-amber-500 mt-0.5 shrink-0" /><span className="text-sm font-bold text-foreground">{t("reoscare.owner_adv2", "Algoritmik Fiyatlandırma Avantajı")}</span></div>
                      <div className="flex items-start gap-3"><CheckCircle2 className="w-5 h-5 text-amber-500 mt-0.5 shrink-0" /><span className="text-sm font-bold text-foreground">{t("reoscare.owner_adv3", "Hukuki Yürütme Motoru ile Garanti Altında")}</span></div>
                    </div>
                  </>
                )}

                {activeRole === "AGENCY_ADMIN" && (
                  <>
                    <h3 className="text-3xl font-black text-foreground leading-tight">
                      {t("reoscare.agency_title", "Tüm Portföy İçin Merkezi Finansal Kontrol")}
                    </h3>
                    <p className="text-lg text-muted-foreground font-medium">
                      {t("reoscare.agency_desc", "Ekiplerinizin performansını, olay güdümlü (event-driven) gelir grafiğini ve ofis genelindeki yield (getiri) yönetimini tek ekrandan kontrol edin.")}
                    </p>
                    <div className="space-y-4">
                      <div className="flex items-start gap-3"><CheckCircle2 className="w-5 h-5 text-violet-500 mt-0.5 shrink-0" /><span className="text-sm font-bold text-foreground">{t("reoscare.agency_adv1", "Ekip Performansı ve Gelir İzleme")}</span></div>
                      <div className="flex items-start gap-3"><CheckCircle2 className="w-5 h-5 text-violet-500 mt-0.5 shrink-0" /><span className="text-sm font-bold text-foreground">{t("reoscare.agency_adv2", "Merkezi Escrow ve Finansal Mutabakat")}</span></div>
                      <div className="flex items-start gap-3"><CheckCircle2 className="w-5 h-5 text-violet-500 mt-0.5 shrink-0" /><span className="text-sm font-bold text-foreground">{t("reoscare.agency_adv3", "ReosCare İşletim Sistemi Gücü")}</span></div>
                    </div>
                  </>
                )}
              </m.div>

              {/* Interactive Calculator */}
              <m.div 
                initial={{ opacity: 0, scale: 0.95 }}
                animate={{ opacity: 1, scale: 1 }}
                className="lg:col-span-7 p-8 md:p-12 rounded-[2.5rem] bg-card border border-border shadow-2xl relative overflow-hidden"
              >
                <div className="absolute top-0 right-0 w-64 h-64 bg-success/5 rounded-bl-full pointer-events-none" />
                
                <div className="flex items-center gap-3 mb-8">
                  <div className="w-12 h-12 rounded-2xl bg-success/10 flex items-center justify-center">
                    <Calculator className="w-6 h-6 text-success dark:text-success" />
                  </div>
                  <div>
                    <h4 className="text-xl font-bold text-foreground">{t("reoscare.calc_title", "Financial Simulator")}</h4>
                    <p className="text-sm text-muted-foreground">{t("reoscare.calc_desc", "Select parameters to view your specific outcome.")}</p>
                  </div>
                </div>

                {/* Input Sliders */}
                <div className="space-y-8 mb-10">
                  <div>
                    <label className="flex justify-between items-center mb-4">
                      <span className="font-bold text-foreground">
                        {transactionMode === "RENT" ? t("reoscare.monthly_rent", "Monthly Rent") : t("reoscare.property_value", "Property Value")}
                      </span>
                      <div className="text-2xl font-black bg-muted px-4 py-1.5 rounded-xl border border-border flex items-center gap-1">
                        {t('currency_symbol', '$')}
                        <AnimatedCounter target={propertyValue} isCurrency={true} />
                      </div>
                    </label>
                    <Slider 
                      value={[propertyValue]} 
                      onValueChange={([v]) => setPropertyValue(v)} 
                      min={transactionMode === "RENT" ? 500 : 50000} 
                      max={transactionMode === "RENT" ? 20000 : 5000000} 
                      step={transactionMode === "RENT" ? 100 : 10000} 
                    />
                  </div>

                  <div>
                    <label className="flex justify-between items-center mb-4">
                      <span className="font-bold text-foreground">{t("reoscare.installments", "Installments (Months)")}</span>
                      <div className="text-2xl font-black bg-muted px-4 py-1.5 rounded-xl border border-border">
                        <AnimatedCounter target={installments} />
                      </div>
                    </label>
                    <Slider value={[installments]} onValueChange={([v]) => setInstallments(v)} min={1} max={transactionMode === "RENT" ? 24 : 12} step={1} />
                  </div>
                </div>

                <div className="h-px bg-border w-full mb-8" />

                {/* Calculation Outputs Based on Role */}
                <div className="grid gap-4">
                  {activeRole === "AGENT" && (
                    <>
                      <div className="p-6 rounded-2xl bg-brand/10 border border-blue-500/20 flex justify-between items-center">
                        <span className="font-bold text-foreground">{t("reoscare.total_commission", "Total Commission Base")}</span>
                        <span className="text-2xl font-black text-brand dark:text-brand">{t('currency_symbol', '$')}<AnimatedCounter target={calc.agentTotalCommission} isCurrency={true} /></span>
                      </div>
                      <div className="grid grid-cols-2 gap-4">
                        <div className="p-6 rounded-2xl bg-success/10 border border-success/20">
                          <span className="block text-sm font-bold text-success dark:text-success uppercase tracking-widest mb-2">{t("reoscare.upfront_cash", "50% Upfront")}</span>
                          <span className="text-3xl font-black text-success dark:text-success">{t('currency_symbol', '$')}<AnimatedCounter target={calc.agentUpfront} isCurrency={true} /></span>
                        </div>
                        <div className="p-6 rounded-2xl bg-violet-500/10 border border-violet-500/20">
                          <span className="block text-sm font-bold text-violet-600 dark:text-violet-400 uppercase tracking-widest mb-2">{t("reoscare.installed_yield", "50% Deferred + 10%")}</span>
                          <span className="text-3xl font-black text-violet-600 dark:text-violet-400">{t('currency_symbol', '$')}<AnimatedCounter target={calc.agentDeferredWithMarkup} isCurrency={true} /></span>
                        </div>
                      </div>
                    </>
                  )}

                  {activeRole === "TENANT_BUYER" && (
                    <>
                      {transactionMode === "RENT" ? (
                        <div className="grid grid-cols-2 gap-4">
                          <div className="p-6 rounded-2xl bg-muted border border-border">
                            <span className="block text-sm font-bold text-muted-foreground uppercase tracking-widest mb-2">{t("reoscare.traditional_move_in", "Traditional Cost")}</span>
                            <span className="text-3xl font-black text-muted-foreground line-through decoration-red-500/50">{t('currency_symbol', '$')}<AnimatedCounter target={propertyValue * 3 + calc.agentTotalCommission} isCurrency={true} /></span>
                          </div>
                          <div className="p-6 rounded-2xl bg-success text-white shadow-lg shadow-blue-500/30 relative overflow-hidden">
                            <span className="relative z-10 block text-sm font-bold text-blue-100 uppercase tracking-widest mb-2">{t("reoscare.monthly_payment", "Monthly Installment")}</span>
                            <span className="relative z-10 text-3xl font-black">{t('currency_symbol', '$')}<AnimatedCounter target={calc.tenantMonthlyInstallment} isCurrency={true} /></span>
                            <div className="relative z-10 mt-2 text-xs font-medium text-blue-100 bg-black/10 px-3 py-1 rounded-full inline-block">{t("reoscare.includes_premium", "Includes +1% ReosCare Premium")}</div>
                          </div>
                        </div>
                      ) : (
                        <div className="p-6 rounded-2xl bg-success text-white shadow-lg shadow-blue-500/30 text-center relative overflow-hidden">
                          <span className="relative z-10 block text-sm font-bold text-blue-100 uppercase tracking-widest mb-2">{t("reoscare.monthly_buyer_comm", "Monthly 2% Commission Payment")}</span>
                          <span className="relative z-10 text-5xl font-black">{t('currency_symbol', '$')}<AnimatedCounter target={calc.tenantMonthlyInstallment} isCurrency={true} /></span>
                        </div>
                      )}
                    </>
                  )}

                  {activeRole === "OWNER_SELLER" && (
                    <div className="p-8 rounded-[2rem] bg-gradient-to-r from-amber-400 to-orange-500 text-white text-center shadow-xl shadow-amber-500/20 relative overflow-hidden">
                      <Shield className="w-12 h-12 text-white/80 mx-auto mb-4" />
                      <span className="relative z-10 block text-sm font-bold text-amber-100 uppercase tracking-widest mb-2">{t("reoscare.guaranteed_coverage", "100% Guaranteed Transaction")}</span>
                      <span className="relative z-10 text-xl font-bold">
                        {transactionMode === "RENT" 
                          ? t("reoscare.owner_zero_cost", "Funded entirely by the Tenant's +1% Premium. Zero cost to you.")
                          : t("reoscare.seller_fast_sale", "Speed up your sale by offering buyers flexible commission payments.")}
                      </span>
                    </div>
                  )}

                  {activeRole === "AGENCY_ADMIN" && (
                    <div className="p-8 rounded-[2rem] bg-gradient-to-r from-violet-500 to-fuchsia-500 text-white text-center shadow-xl shadow-violet-500/20 relative overflow-hidden">
                      <Landmark className="w-12 h-12 text-white/80 mx-auto mb-4" />
                      <span className="relative z-10 block text-sm font-bold text-violet-100 uppercase tracking-widest mb-2">{t("reoscare.agency_yield", "Projected Office Yield")}</span>
                      <span className="relative z-10 text-5xl font-black">{t('currency_symbol', '$')}<AnimatedCounter target={calc.agentDeferredWithMarkup * 10} isCurrency={true} />+</span>
                      <div className="relative z-10 mt-3 text-sm font-medium text-violet-100">{t("reoscare.agency_based_on", "Based on 10 active agents executing this volume")}</div>
                    </div>
                  )}

                </div>
              </m.div>

            </div>
          </div>
        </section>

        {/* ══════ BENEFITS ══════ */}
        <section className="py-20 bg-muted/30">
          <div className="container mx-auto px-6">
            <h2 className="text-3xl font-black text-foreground text-center mb-14">{t("leasecare.everyone_wins", "Everyone Wins")}</h2>
            <div className="grid md:grid-cols-2 gap-6 max-w-4xl mx-auto">
              {/* Tenant Benefits */}
              <div className="p-7 rounded-2xl bg-card border border-border/50 space-y-5">
                <div className="flex items-center gap-3">
                  <div className="w-10 h-10 rounded-xl bg-brand/10 flex items-center justify-center"><Users className="w-5 h-5 text-brand" /></div>
                  <h3 className="font-bold text-foreground text-lg">{t("leasecare.tenant_adv_title", "Tenant Advantages")}</h3>
                </div>
                <div className="space-y-3">
                  {[
                    t("leasecare.tenant_adv_1", "Move in with just rent + 3% instead of 5 months upfront"),
                    t("leasecare.tenant_adv_2", "Deposit through monthly accumulation — spreads the financial burden"),
                    t("leasecare.tenant_adv_3", "Escrow protection — your rights are secured"),
                    t("leasecare.tenant_adv_4", "Reduces moving costs by up to 80%"),
                  ].map((b, i) => (
                    <div key={i} className="flex items-start gap-2 text-sm text-muted-foreground">
                      <CheckCircle2 className="w-4 h-4 text-brand mt-0.5 shrink-0" /><span>{b}</span>
                    </div>
                  ))}
                </div>
              </div>
              {/* Landlord Benefits */}
              <div className="p-7 rounded-2xl bg-card border border-border/50 space-y-5">
                <div className="flex items-center gap-3">
                  <div className="w-10 h-10 rounded-xl bg-amber-500/10 flex items-center justify-center"><Building2 className="w-5 h-5 text-amber-500" /></div>
                  <h3 className="font-bold text-foreground text-lg">{t("leasecare.landlord_adv_title", "Landlord Advantages")}</h3>
                </div>
                <div className="space-y-3">
                  {[
                    t("leasecare.landlord_adv_1", "More tenant candidates — lowers the entry barrier"),
                    t("leasecare.landlord_adv_2", "Guaranteed deposit with Escrow"),
                    t("leasecare.landlord_adv_3", "Only 1% monthly commission — instead of traditional 2 months"),
                    t("leasecare.landlord_adv_4", "Long-term, secure tenant relationships"),
                  ].map((b, i) => (
                    <div key={i} className="flex items-start gap-2 text-sm text-muted-foreground">
                      <CheckCircle2 className="w-4 h-4 text-amber-500 mt-0.5 shrink-0" /><span>{b}</span>
                    </div>
                  ))}
                </div>
              </div>
            </div>
          </div>
        </section>

        {/* ══════ CTA ══════ */}
        <section className="py-24">
          <div className="container mx-auto px-6">
            <div className="max-w-3xl mx-auto rounded-3xl overflow-hidden relative">
              <div className="absolute inset-0 bg-gradient-to-r from-blue-600 via-indigo-600 to-brand" />
              <div className="relative z-10 p-12 md:p-16 text-center space-y-6">
                <h2 className="text-3xl md:text-4xl font-black text-white">{t("leasecare.cta_title", "Start Renting with LeaseCare+")}</h2>
                <p className="text-white/70 max-w-md mx-auto">{t("leasecare.cta_desc", "Fair, transparent, and secure rental experience for tenant and landlord from the first month.")}</p>
                <Button size="lg" className="bg-card text-foreground hover:bg-white/90 px-8 h-13 font-bold rounded-2xl shadow-xl">
                  {t("leasecare.apply_free", "Apply for Free")} <ArrowRight className="ml-2 w-4 h-4" />
                </Button>
              </div>
            </div>
          </div>
        </section>
      </div>
    </>
  );
}
