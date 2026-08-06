"use client";

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

const fadeIn = {
  hidden: { opacity: 0, y: 20 },
  visible: { opacity: 1, y: 0, transition: { duration: 0.6 } }
};

const staggerContainer = {
  hidden: { opacity: 0 },
  visible: {
    opacity: 1,
    transition: { staggerChildren: 0.1 }
  }
};

type RoleKey = "AGENT" | "TENANT_BUYER" | "OWNER_SELLER" | "AGENCY_ADMIN";
type TransactionMode = "RENT" | "BUY";

export default function LeaseCarePage() {
  const { t, i18n } = useTranslation();
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
    <div className="min-h-screen bg-muted dark:bg-muted text-foreground overflow-x-hidden selection:bg-success/30 pb-20">

      {/* ══════ HERO ══════ */}
      <section className="relative pt-32 pb-20 overflow-hidden min-h-[80vh] flex items-center">
        <div className="absolute inset-0 pointer-events-none">
          <div className="absolute top-[-10%] left-[10%] w-[600px] h-[600px] rounded-full bg-success/10 dark:bg-success/15 blur-[160px]" />
          <div className="absolute bottom-[-10%] right-[10%] w-[600px] h-[600px] rounded-full bg-brand/100/10 dark:bg-blue-600/15 blur-[160px]" />
          <div className="absolute top-[20%] right-[30%] w-[300px] h-[300px] rounded-full bg-violet-500/5 dark:bg-violet-500/10 blur-[120px]" />
        </div>

        <div className="relative z-10 container mx-auto px-6">
          <m.div 
            className="text-center max-w-4xl mx-auto space-y-8"
            initial="hidden"
            animate="visible"
            variants={staggerContainer}
          >
            <m.div variants={fadeIn}>
              <Badge className="bg-white/50 dark:bg-card/50 backdrop-blur-md text-success dark:text-success border-success/20 px-5 py-2 rounded-full text-xs font-bold tracking-widest uppercase shadow-sm">
                <Sparkles className="w-4 h-4 mr-2 inline-block" /> {t("leasecare.industry_first", "Industry First Model")}
              </Badge>
            </m.div>

            <m.h1 variants={fadeIn} className="text-5xl md:text-7xl lg:text-8xl font-black tracking-tight leading-[0.95] drop-shadow-sm">
              <span className="text-foreground dark:text-white">LeaseCare</span>
              <span className="bg-gradient-to-r from-blue-500 to-blue-500 bg-clip-text text-transparent drop-shadow-md">+</span>
            </m.h1>

            <m.p variants={fadeIn} className="text-xl md:text-2xl text-muted-foreground dark:text-muted-foreground max-w-2xl mx-auto leading-relaxed font-medium">
              <span dangerouslySetInnerHTML={{ __html: t("leasecare.hero_desc_hidden", "Traditional <span class='font-bold text-foreground dark:text-white'>upfront deposits</span> and <span class='font-bold text-foreground dark:text-white'>heavy commission burdens</span> are over. Everyone wins with <span class='font-bold text-success dark:text-success'>dynamic micro-payments</span>.") }} />
            </m.p>

            <m.div variants={fadeIn} className="flex flex-wrap justify-center gap-4 pt-6">
              <Button size="lg" className="bg-gradient-to-r from-blue-500 to-blue-600 hover:from-blue-600 hover:to-blue-700 text-white h-14 px-8 rounded-2xl font-bold shadow-xl shadow-blue-500/20 group text-lg transition-all hover:scale-105">
                {t("leasecare.apply_now", "Apply Now")} <ArrowRight className="ml-2 w-5 h-5 group-hover:translate-x-1 transition-transform" />
              </Button>
              <Button size="lg" variant="outline" className="h-14 px-8 rounded-2xl font-semibold bg-white/50 dark:bg-card/50 backdrop-blur-md border-border dark:border-border hover:bg-card dark:hover:bg-muted text-lg transition-all hover:scale-105 shadow-sm">
                <Calculator className="mr-2 w-5 h-5 text-success" /> {t("leasecare.calculate", "Calculate")}
              </Button>
            </m.div>
          </m.div>
        </div>
      </section>

      {/* ══════ COMPARISON ══════ */}
      <section className="py-24 relative z-20">
        <div className="container mx-auto px-6">
          <m.div 
            initial="hidden"
            whileInView="visible"
            viewport={{ once: true, margin: "-100px" }}
            variants={fadeIn}
            className="text-center mb-16 space-y-4"
          >
            <h2 className="text-3xl md:text-5xl font-black text-foreground dark:text-white">
              <span dangerouslySetInnerHTML={{ __html: t("leasecare.traditional_vs_leasecare", "Traditional vs <span class='text-success'>LeaseCare+</span>") }} />
            </h2>
            <p className="text-lg text-muted-foreground dark:text-muted-foreground max-w-xl mx-auto font-medium">
              {t("leasecare.comparison_desc", "Same home, same rent — but a very different move-in cost")}
            </p>
          </m.div>

          <m.div 
            initial="hidden"
            whileInView="visible"
            viewport={{ once: true, margin: "-100px" }}
            variants={staggerContainer}
            className="grid md:grid-cols-2 gap-8 max-w-5xl mx-auto"
          >
            {/* Traditional */}
            <m.div 
              variants={fadeIn}
              whileHover={{ y: -5 }}
              className="p-8 md:p-10 rounded-[2.5rem] bg-white/40 dark:bg-card/40 backdrop-blur-2xl border border-red-500/20 shadow-2xl shadow-red-500/5 space-y-8 relative overflow-hidden transition-all duration-300"
            >
              <div className="absolute top-0 right-0 w-32 h-32 bg-red-500/10 rounded-bl-full -z-10" />
              <div className="flex items-center gap-4">
                <div className="w-14 h-14 rounded-2xl bg-gradient-to-br from-red-500/20 to-rose-500/20 flex items-center justify-center shadow-inner">
                  <AlertTriangle className="w-7 h-7 text-red-500" />
                </div>
                <div>
                  <h3 className="text-xl font-bold text-foreground dark:text-white">{t("leasecare.traditional_model", "Traditional Model")}</h3>
                  <p className="text-sm text-muted-foreground dark:text-muted-foreground font-medium">{t("leasecare.first_day_payment", "First day upfront payment")}</p>
                </div>
              </div>
              
              <div className="space-y-5">
                <div className="flex justify-between items-center text-base"><span className="text-muted-foreground dark:text-muted-foreground font-medium">{t("leasecare.deposit_traditional", "Deposit (Upfront)")}</span><span className="font-bold text-red-500 bg-red-500/10 px-3 py-1 rounded-lg">{t("leasecare.very_high", "Very High")}</span></div>
                <div className="flex justify-between items-center text-base"><span className="text-muted-foreground dark:text-muted-foreground font-medium">{t("leasecare.commission_traditional", "Commission (Upfront)")}</span><span className="font-bold text-red-500 bg-red-500/10 px-3 py-1 rounded-lg">{t("leasecare.very_high", "Very High")}</span></div>
                <div className="flex justify-between items-center text-base"><span className="text-muted-foreground dark:text-muted-foreground font-medium">{t("leasecare.first_month_rent", "First month rent")}</span><span className="font-bold text-foreground dark:text-white bg-muted dark:bg-muted px-3 py-1 rounded-lg">${propertyValue.toLocaleString()}</span></div>
                
                <div className="h-px bg-red-500/20 my-4" />
                
                <div className="flex justify-between items-center"><span className="font-bold text-lg text-red-500">{t("leasecare.total_first_day", "Total First Day")}</span><span className="text-3xl font-black text-red-500 drop-shadow-sm">{t("leasecare.costly", "Costly")}</span></div>
              </div>
            </m.div>

            {/* LeaseCare+ */}
            <m.div 
              variants={fadeIn}
              whileHover={{ y: -5 }}
              className="p-8 md:p-10 rounded-[2.5rem] bg-white/60 dark:bg-card backdrop-blur-3xl border border-blue-500/30 shadow-2xl shadow-blue-500/10 space-y-8 relative overflow-hidden transition-all duration-300 ring-1 ring-white/20 dark:ring-white/10"
            >
              <div className="absolute top-0 right-0 w-64 h-64 bg-success/10 rounded-bl-full -z-10 blur-2xl" />
              <div className="absolute top-5 right-5">
                <Badge className="bg-gradient-to-r from-blue-500 to-blue-400 text-white border-0 text-xs py-1 px-3 shadow-lg shadow-blue-500/20 font-bold tracking-wider">
                  {t("leasecare.recommended", "RECOMMENDED")}
                </Badge>
              </div>

              <div className="flex items-center gap-4">
                <div className="w-14 h-14 rounded-2xl bg-gradient-to-br from-blue-400 to-blue-600 flex items-center justify-center shadow-lg shadow-blue-500/30">
                  <Shield className="w-7 h-7 text-white" />
                </div>
                <div>
                  <h3 className="text-xl font-bold text-foreground dark:text-white">{t("leasecare.leasecare_model", "LeaseCare+ Model")}</h3>
                  <p className="text-sm text-success/80 dark:text-success/80 font-medium">{t("leasecare.monthly_micro_payment", "Monthly micro-payment")}</p>
                </div>
              </div>
              
              <div className="space-y-5">
                <div className="flex justify-between items-center text-base"><span className="text-muted-foreground dark:text-muted-foreground font-medium">{t("leasecare.first_month_rent", "First month rent")}</span><span className="font-bold text-foreground dark:text-white bg-white/50 dark:bg-muted/50 backdrop-blur-sm px-3 py-1 rounded-lg border border-border dark:border-border">${propertyValue.toLocaleString()}</span></div>
                <div className="flex justify-between items-center text-base"><span className="text-muted-foreground dark:text-muted-foreground font-medium">{t("leasecare.micro_commission", "Dynamic Micro Commission")}</span><span className="font-bold text-success dark:text-success bg-success/10 px-3 py-1 rounded-lg border border-success/20">{t("client.src.partner_rate", "Partner Rate")}</span></div>
                <div className="flex justify-between items-center text-base"><span className="text-muted-foreground dark:text-muted-foreground font-medium">{t("leasecare.micro_deposit", "Dynamic Micro Deposit")}</span><span className="font-bold text-success dark:text-success bg-success/10 px-3 py-1 rounded-lg border border-success/20">{t("client.src.partner_rate", "Partner Rate")}</span></div>
                
                <div className="h-px bg-success/30 my-4" />
                
                <div className="flex justify-between items-center">
                  <span className="font-bold text-lg text-success dark:text-success">{t("leasecare.total_first_day", "Total First Day")}</span>
                  <span className="text-3xl font-black text-transparent bg-clip-text bg-gradient-to-r from-blue-600 to-blue-400 drop-shadow-sm">Minimum</span>
                </div>
              </div>
              
              <div className="bg-gradient-to-r from-blue-500/10 to-blue-500/10 rounded-2xl p-4 text-center border border-success/20 shadow-inner">
                <span className="text-base font-bold text-blue-700 dark:text-blue-300 flex items-center justify-center gap-2">
                  <PiggyBank className="w-5 h-5" /> 
                  {t("leasecare.up_to_85_savings", "Up to 85% Savings on Move-in!")}
                </span>
              </div>
            </m.div>
          </m.div>
        </div>
      </section>

      {/* ══════ HOW IT WORKS ══════ */}
      <section className="py-24 relative">
        <div className="container mx-auto px-6">
          <m.div 
            initial="hidden"
            whileInView="visible"
            viewport={{ once: true, margin: "-100px" }}
            variants={fadeIn}
            className="text-center mb-16"
          >
            <h2 className="text-3xl md:text-5xl font-black text-foreground dark:text-white">
              <span dangerouslySetInnerHTML={{ __html: t("leasecare.how_it_works", "How it <span class='text-success'>Works?</span>") }} />
            </h2>
          </m.div>

          <m.div 
            initial="hidden"
            whileInView="visible"
            viewport={{ once: true, margin: "-100px" }}
            variants={staggerContainer}
            className="grid md:grid-cols-3 gap-8 max-w-6xl mx-auto"
          >
            {[
              { icon: Percent, title: t("leasecare.dynamic_commission", "Dynamic Micro Commission"), desc: t("leasecare.dynamic_commission_desc", "No upfront commission! Tenants and landlords benefit from specialized micro-rates determined by partnership levels."), color: "from-blue-500 to-info", shadow: "shadow-blue-500/20" },
              { icon: PiggyBank, title: t("leasecare.dynamic_deposit", "Dynamic Micro Deposit"), desc: t("leasecare.dynamic_deposit_desc", "Tenants accumulate their deposit dynamically alongside their rent via micro-installments."), color: "from-violet-500 to-fuchsia-500", shadow: "shadow-violet-500/20" },
              { icon: Lock, title: t("leasecare.escrow_assurance", "Escrow Assurance"), desc: t("leasecare.escrow_desc", "All deposits are securely held in Reservatior Escrow account. Neutral mediation in case of dispute."), color: "from-blue-400 to-blue-600", shadow: "shadow-blue-500/20" },
            ].map((s, i) => (
              <m.div 
                key={i} 
                variants={fadeIn}
                whileHover={{ y: -10, scale: 1.02 }}
                className="p-8 md:p-10 rounded-[2rem] bg-white/50 dark:bg-card/50 backdrop-blur-xl border border-white/20 dark:border-border hover:border-slate-300 dark:hover:border-border transition-all space-y-6 text-center group shadow-xl shadow-slate-200/20 dark:shadow-none"
              >
                <div className={`w-20 h-20 rounded-[1.5rem] bg-gradient-to-br ${s.color} flex items-center justify-center mx-auto shadow-lg ${s.shadow} group-hover:scale-110 transition-transform duration-500`}>
                  <s.icon className="w-10 h-10 text-white" />
                </div>
                <h3 className="text-xl font-bold text-foreground dark:text-white">{s.title}</h3>
                <p className="text-base text-muted-foreground dark:text-muted-foreground font-medium leading-relaxed">{s.desc}</p>
              </m.div>
            ))}
          </m.div>

          {/* Payment Flow Diagram */}
          <m.div 
            initial="hidden"
            whileInView="visible"
            viewport={{ once: true }}
            variants={fadeIn}
            className="max-w-4xl mx-auto mt-20 p-8 md:p-12 rounded-[2.5rem] bg-white/40 dark:bg-card/40 backdrop-blur-2xl border border-white/20 dark:border-border shadow-2xl shadow-slate-200/40 dark:shadow-none relative overflow-hidden"
          >
            <div className="absolute inset-0 bg-gradient-to-r from-blue-500/5 via-blue-500/5 to-amber-500/5" />
            
            <h4 className="relative z-10 text-sm font-bold text-muted-foreground dark:text-muted-foreground tracking-widest uppercase text-center mb-10">
              {t("leasecare.payment_flow", "Monthly Payment Flow")}
            </h4>
            
            <div className="relative z-10 flex flex-col md:flex-row items-center justify-between gap-6 md:gap-2">
              
              {/* Tenant Node */}
              <div className="text-center space-y-4 flex-1">
                <div className="w-20 h-20 rounded-full bg-gradient-to-br from-brand to-brand flex items-center justify-center mx-auto shadow-lg shadow-blue-500/30 relative">
                  <Users className="w-8 h-8 text-white" />
                  <div className="absolute inset-0 rounded-full border-2 border-blue-500 animate-ping opacity-20" style={{ animationDuration: '3s' }} />
                </div>
                <div className="space-y-1">
                  <div className="text-base font-bold text-foreground dark:text-white">{t("common.tenant", "Tenant")}</div>
                  <Badge variant="outline" className="text-xs text-brand dark:text-brand border-border dark:border-blue-800 bg-brand/10 dark:bg-blue-900/20">{t("leasecare.tenant_calc_dynamic", "Rent + Micro Payments")}</Badge>
                </div>
              </div>

              <div className="hidden md:flex flex-col items-center flex-1">
                <div className="w-full h-1 bg-gradient-to-r from-blue-500 to-blue-500 rounded-full relative overflow-hidden">
                  <m.div 
                    className="absolute top-0 bottom-0 left-0 w-1/3 bg-white/50 blur-[2px]"
                    animate={{ x: ["-100%", "300%"] }}
                    transition={{ duration: 2, repeat: Infinity, ease: "linear" }}
                  />
                </div>
              </div>
              
              <div className="md:hidden">
                <ArrowLeftRight className="w-6 h-6 text-muted-foreground rotate-90" />
              </div>

              {/* Escrow Node */}
              <div className="text-center space-y-4 flex-1">
                <div className="w-24 h-24 rounded-full bg-gradient-to-br from-blue-400 to-blue-600 flex items-center justify-center mx-auto shadow-xl shadow-blue-500/40 relative z-10">
                  <Shield className="w-10 h-10 text-white" />
                </div>
                <div className="space-y-1">
                  <div className="text-base font-bold text-foreground dark:text-white">{t("leasecare.escrow", "Reservatior Escrow")}</div>
                  <Badge variant="outline" className="text-xs text-success dark:text-success border-blue-200 dark:border-blue-800 bg-blue-50 dark:bg-blue-900/20">{t("leasecare.secure_storage", "Secure storage")}</Badge>
                </div>
              </div>

              <div className="hidden md:flex flex-col items-center flex-1">
                <div className="w-full h-1 bg-gradient-to-r from-blue-500 to-amber-500 rounded-full relative overflow-hidden">
                  <m.div 
                    className="absolute top-0 bottom-0 left-0 w-1/3 bg-white/50 blur-[2px]"
                    animate={{ x: ["-100%", "300%"] }}
                    transition={{ duration: 2, delay: 1, repeat: Infinity, ease: "linear" }}
                  />
                </div>
              </div>
              
              <div className="md:hidden">
                <ArrowLeftRight className="w-6 h-6 text-muted-foreground rotate-90" />
              </div>

              {/* Landlord Node */}
              <div className="text-center space-y-4 flex-1">
                <div className="w-20 h-20 rounded-full bg-gradient-to-br from-amber-400 to-amber-600 flex items-center justify-center mx-auto shadow-lg shadow-amber-500/30">
                  <Building2 className="w-8 h-8 text-white" />
                </div>
                <div className="space-y-1">
                  <div className="text-base font-bold text-foreground dark:text-white">{t("leasecare.landlord", "Landlord")}</div>
                  <Badge variant="outline" className="text-xs text-amber-600 dark:text-amber-400 border-amber-200 dark:border-amber-800 bg-amber-50 dark:bg-amber-900/20">{t("leasecare.landlord_calc_dynamic", "Rent - Micro Fee")}</Badge>
                </div>
              </div>

            </div>
          </m.div>
        </div>
      </section>

      {/* ══════ CALCULATOR ══════ */}
      <section className="py-24 relative overflow-hidden">
        <div className="absolute inset-0 bg-brand/10/50 dark:bg-card/30" />
        <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[800px] h-[800px] bg-success/5 rounded-full blur-[120px] pointer-events-none" />
        
        <div className="container mx-auto px-6 relative z-10">
          <m.div 
            initial="hidden"
            whileInView="visible"
            viewport={{ once: true, margin: "-100px" }}
            variants={fadeIn}
            className="text-center mb-16 space-y-6"
          >
            <Badge className="bg-white/80 dark:bg-muted/80 backdrop-blur-md text-brand dark:text-brand border-blue-500/20 px-5 py-2 rounded-full text-xs font-bold tracking-widest shadow-sm">
              <Calculator className="w-4 h-4 mr-2 inline-block" /> {String(t("leasecare.interactive_calc", "Interactive Calculator")).toLocaleUpperCase(i18n.language === 'tr' ? 'tr-TR' : 'en-US')}
            </Badge>
            <h2 className="text-3xl md:text-5xl font-black text-foreground dark:text-white">
              {t("leasecare.how_much_save", "How much will you save?")}
            </h2>
          </m.div>

          {/* Transaction Mode Toggle */}
          <div className="flex justify-center mb-10">
            <div className="bg-white/80 dark:bg-muted/80 backdrop-blur-md p-1.5 rounded-full flex gap-2 border border-border dark:border-border shadow-sm">
              <button 
                onClick={() => setTransactionMode("RENT")}
                className={`px-8 py-3 rounded-full text-sm font-bold transition-all ${transactionMode === "RENT" ? "bg-primary text-primary-foreground shadow-md" : "text-muted-foreground hover:text-foreground"}`}
              >
                {t("leasecare.mode_rent", "Rent")}
              </button>
              <button 
                onClick={() => setTransactionMode("BUY")}
                className={`px-8 py-3 rounded-full text-sm font-bold transition-all ${transactionMode === "BUY" ? "bg-primary text-primary-foreground shadow-md" : "text-muted-foreground hover:text-foreground"}`}
              >
                {t("leasecare.mode_buy", "Buy")}
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
                  className={`relative flex items-center gap-2 px-6 py-4 rounded-2xl font-bold text-sm md:text-base transition-all duration-300 ${
                    activeRole === role.id 
                      ? "bg-card dark:bg-card text-white dark:text-foreground shadow-xl scale-105" 
                      : "bg-white/50 dark:bg-card/50 text-muted-foreground dark:text-muted-foreground hover:bg-card dark:hover:bg-muted border border-border dark:border-border"
                  }`}
                >
                  <role.icon className={`w-5 h-5 ${activeRole === role.id ? "text-success" : "text-muted-foreground"}`} />
                  {role.label}
                  {activeRole === role.id && (
                    <m.div layoutId="activeRoleIndicatorAppRouter" className="absolute -bottom-2 left-1/2 -translate-x-1/2 w-8 h-1.5 rounded-full bg-success" />
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
              className="lg:col-span-5 flex flex-col justify-center space-y-8 p-8 md:p-12 rounded-[2.5rem] bg-white/40 dark:bg-card/40 backdrop-blur-2xl border border-white/40 dark:border-border shadow-2xl"
            >
              {activeRole === "AGENT" && (
                <>
                  <h3 className="text-3xl font-black text-foreground dark:text-white leading-tight">
                    {transactionMode === "RENT" ? t("reoscare.agent_rent_title", "Komisyonunu Güvenceye Al, %10 Fazla Kazan") : t("reoscare.agent_buy_title", "Alıcıya Taksit Sun, Satışları Hızlandır")}
                  </h3>
                  <p className="text-lg text-muted-foreground dark:text-muted-foreground font-medium">
                    {transactionMode === "RENT" 
                      ? t("reoscare.agent_rent_desc", "Klasik kiralama devri bitti. Komisyonunun %50'sini anında nakit al, kalan %50'yi ReosCare güvencesiyle %10 getiriyle taksitli tahsil et. Sisteme bağımlılık ve sürekli nakit akışı yarat.")
                      : t("reoscare.agent_buy_desc", "Satış işlemlerindeki en büyük engel olan alıcı komisyonunu ReosCare ile 12 aya kadar taksitlendir. Likidite sağla ve işlem kapatma hızını uçur.")}
                  </p>
                  <div className="space-y-4">
                    <div className="flex items-start gap-3"><CheckCircle2 className="w-5 h-5 text-brand mt-0.5 shrink-0" /><span className="text-sm font-bold text-muted-foreground dark:text-muted-foreground">{t("reoscare.agent_adv1", "%50 Peşin Komisyon Anında Hesabında")}</span></div>
                    <div className="flex items-start gap-3"><CheckCircle2 className="w-5 h-5 text-brand mt-0.5 shrink-0" /><span className="text-sm font-bold text-muted-foreground dark:text-muted-foreground">{t("reoscare.agent_adv2", "Kalan Bakiyeye %10 Ekstra Getiri (Yield)")}</span></div>
                    <div className="flex items-start gap-3"><CheckCircle2 className="w-5 h-5 text-brand mt-0.5 shrink-0" /><span className="text-sm font-bold text-muted-foreground dark:text-muted-foreground">{t("reoscare.agent_adv3", "Vendor Lock-in ile Kesintisiz Gelir Akışı")}</span></div>
                  </div>
                </>
              )}

              {activeRole === "TENANT_BUYER" && (
                <>
                  <h3 className="text-3xl font-black text-foreground dark:text-white leading-tight">
                    {transactionMode === "RENT" ? t("reoscare.tenant_title", "Depozito ve Komisyon Yükünden Kurtul") : t("reoscare.buyer_title", "Komisyonu Taksitle Öde, Ev Sahibi Ol")}
                  </h3>
                  <p className="text-lg text-muted-foreground dark:text-muted-foreground font-medium">
                    {transactionMode === "RENT" 
                      ? t("reoscare.tenant_desc", "Sadece %1'lik ReosCare koruma primi ile devasa peşinatlar ödemeden yeni evine taşın. Depozito ve komisyonu aylık mikro-ödemelerle rahatça öde.")
                      : t("reoscare.buyer_desc", "Tapu harcı ve peşinatlar zaten zorlayıcı. %2'lik alıcı komisyonunu tek seferde ödemek yerine ReosCare ile aylık taksitlere böl.")}
                  </p>
                  <div className="space-y-4">
                    <div className="flex items-start gap-3"><CheckCircle2 className="w-5 h-5 text-success mt-0.5 shrink-0" /><span className="text-sm font-bold text-muted-foreground dark:text-muted-foreground">{transactionMode === "RENT" ? t("reoscare.tenant_adv1", "Depozito Taksitlendirmesi") : t("reoscare.buyer_adv1", "%2 Komisyon Taksitlendirmesi")}</span></div>
                    <div className="flex items-start gap-3"><CheckCircle2 className="w-5 h-5 text-success mt-0.5 shrink-0" /><span className="text-sm font-bold text-muted-foreground dark:text-muted-foreground">{t("reoscare.tenant_adv2", "Güvenli Escrow Hesabı")}</span></div>
                    <div className="flex items-start gap-3"><CheckCircle2 className="w-5 h-5 text-success mt-0.5 shrink-0" /><span className="text-sm font-bold text-muted-foreground dark:text-muted-foreground">{t("reoscare.tenant_adv3", "Loyalty (Sadakat) Puanı ve Kredi Notu Avantajı")}</span></div>
                  </div>
                </>
              )}

              {activeRole === "OWNER_SELLER" && (
                <>
                  <h3 className="text-3xl font-black text-foreground dark:text-white leading-tight">
                    {transactionMode === "RENT" ? t("reoscare.owner_title", "%100 Kira Garantisi, Sıfır Risk") : t("reoscare.seller_title", "Satış Sürtünmesini Ortadan Kaldır")}
                  </h3>
                  <p className="text-lg text-muted-foreground dark:text-muted-foreground font-medium">
                    {transactionMode === "RENT" 
                      ? t("reoscare.owner_desc", "ReosCare sigorta havuzu sayesinde kiranız devlet destekli kontratlarla (state machine) güvence altında. Üstelik cebinizden sigorta ücreti çıkmaz.")
                      : t("reoscare.seller_desc", "Alıcılara komisyon taksitlendirme imkanı sunarak mülkünüzün satılma hızını artırın. Risksiz, şeffaf süreç.")}
                  </p>
                  <div className="space-y-4">
                    <div className="flex items-start gap-3"><CheckCircle2 className="w-5 h-5 text-amber-500 mt-0.5 shrink-0" /><span className="text-sm font-bold text-muted-foreground dark:text-muted-foreground">{transactionMode === "RENT" ? t("reoscare.owner_adv1", "Kiracı Tarafından Fonlanan Sigorta Havuzu") : t("reoscare.seller_adv1", "Hızlı İşlem Kapatma (Conversion)")}</span></div>
                    <div className="flex items-start gap-3"><CheckCircle2 className="w-5 h-5 text-amber-500 mt-0.5 shrink-0" /><span className="text-sm font-bold text-muted-foreground dark:text-muted-foreground">{t("reoscare.owner_adv2", "Algoritmik Fiyatlandırma Avantajı")}</span></div>
                    <div className="flex items-start gap-3"><CheckCircle2 className="w-5 h-5 text-amber-500 mt-0.5 shrink-0" /><span className="text-sm font-bold text-muted-foreground dark:text-muted-foreground">{t("reoscare.owner_adv3", "Hukuki Yürütme Motoru ile Garanti Altında")}</span></div>
                  </div>
                </>
              )}

              {activeRole === "AGENCY_ADMIN" && (
                <>
                  <h3 className="text-3xl font-black text-foreground dark:text-white leading-tight">
                    {t("reoscare.agency_title", "Tüm Portföy İçin Merkezi Finansal Kontrol")}
                  </h3>
                  <p className="text-lg text-muted-foreground dark:text-muted-foreground font-medium">
                    {t("reoscare.agency_desc", "Ekiplerinizin performansını, olay güdümlü (event-driven) gelir grafiğini ve ofis genelindeki yield (getiri) yönetimini tek ekrandan kontrol edin.")}
                  </p>
                  <div className="space-y-4">
                    <div className="flex items-start gap-3"><CheckCircle2 className="w-5 h-5 text-violet-500 mt-0.5 shrink-0" /><span className="text-sm font-bold text-muted-foreground dark:text-muted-foreground">{t("reoscare.agency_adv1", "Ekip Performansı ve Gelir İzleme")}</span></div>
                    <div className="flex items-start gap-3"><CheckCircle2 className="w-5 h-5 text-violet-500 mt-0.5 shrink-0" /><span className="text-sm font-bold text-muted-foreground dark:text-muted-foreground">{t("reoscare.agency_adv2", "Merkezi Escrow ve Finansal Mutabakat")}</span></div>
                    <div className="flex items-start gap-3"><CheckCircle2 className="w-5 h-5 text-violet-500 mt-0.5 shrink-0" /><span className="text-sm font-bold text-muted-foreground dark:text-muted-foreground">{t("reoscare.agency_adv3", "ReosCare İşletim Sistemi Gücü")}</span></div>
                  </div>
                </>
              )}
            </m.div>

            {/* Interactive Calculator */}
            <m.div 
              initial={{ opacity: 0, scale: 0.95 }}
              animate={{ opacity: 1, scale: 1 }}
              className="lg:col-span-7 p-8 md:p-12 rounded-[2.5rem] bg-card dark:bg-card border border-border dark:border-border shadow-2xl relative overflow-hidden"
            >
              <div className="absolute top-0 right-0 w-64 h-64 bg-success/5 rounded-bl-full pointer-events-none" />
              
              <div className="flex items-center gap-3 mb-8">
                <div className="w-12 h-12 rounded-2xl bg-blue-50 dark:bg-blue-900/20 flex items-center justify-center">
                  <Calculator className="w-6 h-6 text-success dark:text-success" />
                </div>
                <div>
                  <h4 className="text-xl font-bold text-foreground dark:text-white">{t("reoscare.calc_title", "Financial Simulator")}</h4>
                  <p className="text-sm text-muted-foreground">{t("reoscare.calc_desc", "Select parameters to view your specific outcome.")}</p>
                </div>
              </div>

              {/* Input Sliders */}
              <div className="space-y-8 mb-10">
                <div>
                  <label className="flex justify-between items-center mb-4">
                    <span className="font-bold text-muted-foreground dark:text-muted-foreground">
                      {transactionMode === "RENT" ? t("reoscare.monthly_rent", "Monthly Rent") : t("reoscare.property_value", "Property Value")}
                    </span>
                    <div className="text-2xl font-black bg-muted dark:bg-muted px-4 py-1.5 rounded-xl border border-border dark:border-border flex items-center gap-1">
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
                    <span className="font-bold text-muted-foreground dark:text-muted-foreground">{t("reoscare.installments", "Installments (Months)")}</span>
                    <div className="text-2xl font-black bg-muted dark:bg-muted px-4 py-1.5 rounded-xl border border-border dark:border-border">
                      <AnimatedCounter target={installments} />
                    </div>
                  </label>
                  <Slider value={[installments]} onValueChange={([v]) => setInstallments(v)} min={1} max={transactionMode === "RENT" ? 24 : 12} step={1} />
                </div>
              </div>

              <div className="h-px bg-muted dark:bg-muted w-full mb-8" />

              {/* Calculation Outputs Based on Role */}
              <div className="grid gap-4">
                {activeRole === "AGENT" && (
                  <>
                    <div className="p-6 rounded-2xl bg-brand/10 dark:bg-blue-900/10 border border-blue-100 dark:border-blue-900/30 flex justify-between items-center">
                      <span className="font-bold text-muted-foreground dark:text-muted-foreground">{t("reoscare.total_commission", "Total Commission Base")}</span>
                      <span className="text-2xl font-black text-brand dark:text-brand">{t('currency_symbol', '$')}<AnimatedCounter target={calc.agentTotalCommission} isCurrency={true} /></span>
                    </div>
                    <div className="grid grid-cols-2 gap-4">
                      <div className="p-6 rounded-2xl bg-blue-50 dark:bg-blue-900/10 border border-blue-100 dark:border-blue-900/30">
                        <span className="block text-sm font-bold text-success dark:text-success uppercase tracking-widest mb-2">{t("reoscare.upfront_cash", "50% Upfront")}</span>
                        <span className="text-3xl font-black text-success dark:text-success">{t('currency_symbol', '$')}<AnimatedCounter target={calc.agentUpfront} isCurrency={true} /></span>
                      </div>
                      <div className="p-6 rounded-2xl bg-violet-50 dark:bg-violet-900/10 border border-violet-100 dark:border-violet-900/30">
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
                        <div className="p-6 rounded-2xl bg-muted dark:bg-muted border border-border dark:border-border">
                          <span className="block text-sm font-bold text-muted-foreground uppercase tracking-widest mb-2">{t("reoscare.traditional_move_in", "Traditional Cost")}</span>
                          <span className="text-3xl font-black text-muted-foreground line-through decoration-red-500/50">{t('currency_symbol', '$')}<AnimatedCounter target={propertyValue * 3 + calc.agentTotalCommission} isCurrency={true} /></span>
                        </div>
                        <div className="p-6 rounded-2xl bg-success text-white shadow-lg shadow-blue-500/30 relative overflow-hidden">
                          <div className="absolute inset-0 bg-[url('https://www.transparenttextures.com/patterns/cubes.png')] opacity-10 mix-blend-overlay" />
                          <span className="relative z-10 block text-sm font-bold text-blue-100 uppercase tracking-widest mb-2">{t("reoscare.monthly_payment", "Monthly Installment")}</span>
                          <span className="relative z-10 text-3xl font-black">{t('currency_symbol', '$')}<AnimatedCounter target={calc.tenantMonthlyInstallment} isCurrency={true} /></span>
                          <div className="relative z-10 mt-2 text-xs font-medium text-blue-100 bg-black/10 px-3 py-1 rounded-full inline-block">{t("reoscare.includes_premium", "Includes +1% ReosCare Premium")}</div>
                        </div>
                      </div>
                    ) : (
                      <div className="p-6 rounded-2xl bg-success text-white shadow-lg shadow-blue-500/30 text-center relative overflow-hidden">
                        <div className="absolute inset-0 bg-[url('https://www.transparenttextures.com/patterns/cubes.png')] opacity-10 mix-blend-overlay" />
                        <span className="relative z-10 block text-sm font-bold text-blue-100 uppercase tracking-widest mb-2">{t("reoscare.monthly_buyer_comm", "Monthly 2% Commission Payment")}</span>
                        <span className="relative z-10 text-5xl font-black">{t('currency_symbol', '$')}<AnimatedCounter target={calc.tenantMonthlyInstallment} isCurrency={true} /></span>
                      </div>
                    )}
                  </>
                )}

                {activeRole === "OWNER_SELLER" && (
                  <div className="p-8 rounded-[2rem] bg-gradient-to-r from-amber-400 to-orange-500 text-white text-center shadow-xl shadow-amber-500/20 relative overflow-hidden">
                    <div className="absolute inset-0 bg-[url('https://www.transparenttextures.com/patterns/cubes.png')] opacity-10 mix-blend-overlay" />
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
                    <div className="absolute inset-0 bg-[url('https://www.transparenttextures.com/patterns/cubes.png')] opacity-10 mix-blend-overlay" />
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
      <section className="py-24 bg-muted/50 dark:bg-card/50">
        <div className="container mx-auto px-6">
          <m.div 
            initial="hidden"
            whileInView="visible"
            viewport={{ once: true, margin: "-100px" }}
            variants={fadeIn}
            className="text-center mb-16"
          >
            <h2 className="text-3xl md:text-5xl font-black text-foreground dark:text-white">
              {t("leasecare.everyone_wins", "Everyone Wins")}
            </h2>
          </m.div>

          <m.div 
            initial="hidden"
            whileInView="visible"
            viewport={{ once: true, margin: "-100px" }}
            variants={staggerContainer}
            className="grid md:grid-cols-2 gap-8 max-w-5xl mx-auto"
          >
            {/* Tenant Benefits */}
            <m.div variants={fadeIn} className="p-8 md:p-10 rounded-[2.5rem] bg-card dark:bg-card border border-border dark:border-border shadow-xl shadow-slate-200/50 dark:shadow-none space-y-8">
              <div className="flex items-center gap-4">
                <div className="w-14 h-14 rounded-2xl bg-brand/10 dark:bg-blue-900/20 flex items-center justify-center">
                  <Users className="w-7 h-7 text-brand dark:text-brand" />
                </div>
                <h3 className="text-2xl font-bold text-foreground dark:text-white">{t("leasecare.tenant_adv_title", "Tenant Advantages")}</h3>
              </div>
              <div className="space-y-4">
                {[
                  t("leasecare.tenant_adv_1", "Move in with just rent + 3% instead of 5 months upfront"),
                  t("leasecare.tenant_adv_2", "Deposit through monthly accumulation — spreads the financial burden"),
                  t("leasecare.tenant_adv_3", "Escrow protection — your rights are secured"),
                  t("leasecare.tenant_adv_4", "Reduces moving costs by up to 80%"),
                ].map((b, i) => (
                  <div key={i} className="flex items-start gap-3 text-muted-foreground dark:text-muted-foreground font-medium">
                    <CheckCircle2 className="w-5 h-5 text-brand mt-0.5 shrink-0" /><span>{b}</span>
                  </div>
                ))}
              </div>
            </m.div>

            {/* Landlord Benefits */}
            <m.div variants={fadeIn} className="p-8 md:p-10 rounded-[2.5rem] bg-card dark:bg-card border border-border dark:border-border shadow-xl shadow-slate-200/50 dark:shadow-none space-y-8">
              <div className="flex items-center gap-4">
                <div className="w-14 h-14 rounded-2xl bg-amber-50 dark:bg-amber-900/20 flex items-center justify-center">
                  <Building2 className="w-7 h-7 text-amber-600 dark:text-amber-400" />
                </div>
                <h3 className="text-2xl font-bold text-foreground dark:text-white">{t("leasecare.landlord_adv_title", "Landlord Advantages")}</h3>
              </div>
              <div className="space-y-4">
                {[
                  t("leasecare.landlord_adv_1", "More tenant candidates — lowers the entry barrier"),
                  t("leasecare.landlord_adv_2", "Guaranteed deposit with Escrow"),
                  t("leasecare.landlord_adv_3", "Only 1% monthly commission — instead of traditional 2 months"),
                  t("leasecare.landlord_adv_4", "Long-term, secure tenant relationships"),
                ].map((b, i) => (
                  <div key={i} className="flex items-start gap-3 text-muted-foreground dark:text-muted-foreground font-medium">
                    <CheckCircle2 className="w-5 h-5 text-amber-500 mt-0.5 shrink-0" /><span>{b}</span>
                  </div>
                ))}
              </div>
            </m.div>
          </m.div>
        </div>
      </section>

      {/* ══════ CTA ══════ */}
      <section className="py-32">
        <div className="container mx-auto px-6">
          <m.div 
            initial={{ opacity: 0, y: 40 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ duration: 0.8 }}
            className="max-w-5xl mx-auto rounded-[3rem] overflow-hidden relative shadow-2xl"
          >
            <div className="absolute inset-0 bg-gradient-to-br from-blue-500 via-blue-600 to-info" />
            <div className="absolute inset-0 bg-[url('https://www.transparenttextures.com/patterns/cubes.png')] opacity-10 mix-blend-overlay" />
            
            <div className="relative z-10 p-12 md:p-20 text-center space-y-8">
              <h2 className="text-4xl md:text-6xl font-black text-white leading-tight">
                {t("leasecare.cta_title", "Start Renting with LeaseCare+")}
              </h2>
              <p className="text-xl text-white/80 max-w-2xl mx-auto font-medium">
                {t("leasecare.cta_desc", "Fair, transparent, and secure rental experience for tenant and landlord from the first month.")}
              </p>
              <div className="pt-4">
                <Button size="lg" className="bg-card text-foreground hover:bg-muted px-10 h-16 text-lg font-bold rounded-2xl shadow-xl transition-transform hover:scale-105">
                  {t("leasecare.apply_free", "Apply for Free")} <ArrowRight className="ml-2 w-5 h-5" />
                </Button>
              </div>
            </div>
          </m.div>
        </div>
      </section>

    </div>
  );
}
