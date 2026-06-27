import { Helmet } from "react-helmet-async";
import { useTranslation } from "react-i18next";
import { useState, useMemo } from "react";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Slider } from "@/components/ui/slider";
import {
  Shield, ArrowRight, CheckCircle2, Users, Building2,
  Wallet, TrendingDown, Lock, Sparkles, Calculator,
  ArrowLeftRight, Percent, Calendar, CreditCard, Scale,
  AlertTriangle, Star, ChevronRight, PiggyBank
} from "lucide-react";

/* ═══════════════════════════════════════════════════════════════════════════════
   LEASECARE+ — Innovative Commission & Deposit Model
   ═══════════════════════════════════════════════════════════════════════════════ */
export default function LeaseCare() {
  const { t } = useTranslation();

  // Calculator state
  const [rent, setRent] = useState(2000);
  const [months, setMonths] = useState(12);

  const calc = useMemo(() => {
    const tenantCommission = rent * 0.01;   // %1 kiracı komisyon
    const landlordCommission = rent * 0.01; // %1 ev sahibi komisyon
    const tenantDeposit = rent * 0.02;      // %2 kiracı depozito
    const monthlyTenantTotal = tenantCommission + tenantDeposit;
    const depositMonths = Math.min(months, 3);
    const totalDeposit = tenantDeposit * depositMonths * (rent / (rent * 0.02)); // = rent * 3 max
    const totalDepositActual = Math.min(rent * 0.02 * months, rent * 3);

    // Traditional model comparison
    const traditionalDeposit = rent * 3;    // 3 aylık depozito peşin
    const traditionalCommission = rent * 2; // 2 aylık komisyon peşin
    const traditionalUpfront = traditionalDeposit + traditionalCommission;

    // LeaseCare model
    const leasecareFirstMonth = rent + tenantCommission + tenantDeposit;
    const savingsFirstMonth = traditionalUpfront + rent - leasecareFirstMonth;

    return {
      tenantCommission, landlordCommission, tenantDeposit,
      monthlyTenantTotal, totalDepositActual,
      traditionalUpfront, leasecareFirstMonth, savingsFirstMonth,
      traditionalDeposit, traditionalCommission,
    };
  }, [rent, months]);

  return (
    <>
      <Helmet>
        <title>LeaseCare+ — Yeni Nesil Kira Komisyonu | Reservatior</title>
        <meta name="description" content="Monthly micro-payments instead of traditional upfront commission. Fair, transparent, and secure for tenants and landlords." />
      </Helmet>

      <div className="min-h-screen bg-background text-foreground overflow-x-hidden">

        {/* ══════ HERO ══════ */}
        <section className="relative pt-32 pb-20 overflow-hidden">
          <div className="absolute inset-0">
            <div className="absolute top-[-10%] left-[20%] w-[500px] h-[400px] rounded-full bg-emerald-500/8 dark:bg-emerald-500/15 blur-[140px]" />
            <div className="absolute bottom-0 right-[10%] w-[500px] h-[400px] rounded-full bg-blue-500/6 dark:bg-blue-500/12 blur-[140px]" />
          </div>

          <div className="relative z-10 container mx-auto px-6 text-center space-y-8">
            <Badge className="bg-emerald-500/10 text-emerald-600 dark:text-emerald-400 border-emerald-500/20 px-4 py-1.5 rounded-full text-xs font-bold tracking-wider gap-2">
              <Sparkles className="w-3.5 h-3.5" /> {t("leasecare.industry_first", "Industry First")}
            </Badge>

            <h1 className="text-5xl lg:text-7xl font-black tracking-tight leading-[0.95]">
              <span className="text-foreground">LeaseCare</span>
              <span className="bg-linear-to-r from-emerald-500 to-blue-500 bg-clip-text text-transparent">+</span>
            </h1>
            <p className="text-xl text-muted-foreground max-w-2xl mx-auto leading-relaxed">
              <span dangerouslySetInnerHTML={{ __html: t("leasecare.hero_desc_hidden", "Traditional <span class='font-bold text-foreground'>upfront deposits</span> and <span class='font-bold text-foreground'>heavy commission burdens</span> are over. Everyone wins with <span class='font-bold text-emerald-600 dark:text-emerald-400'>dynamic micro-payments</span>.") }} />
            </p>

            <div className="flex flex-wrap justify-center gap-4 pt-2">
              <Button size="lg" className="bg-emerald-600 hover:bg-emerald-500 text-white h-13 px-8 rounded-2xl font-bold shadow-lg shadow-emerald-600/20 group">
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
                <span dangerouslySetInnerHTML={{ __html: t("leasecare.traditional_vs_leasecare", "Traditional vs <span class='text-emerald-600 dark:text-emerald-400'>LeaseCare+</span>") }} />
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
                  <div className="flex justify-between items-center text-sm"><span className="text-muted-foreground">{t("leasecare.deposit_traditional", "Deposit (Upfront)")}</span><span className="font-bold text-foreground text-red-400">Çok Yüksek</span></div>
                  <div className="flex justify-between items-center text-sm"><span className="text-muted-foreground">{t("leasecare.commission_traditional", "Commission (Upfront)")}</span><span className="font-bold text-foreground text-red-400">Çok Yüksek</span></div>
                  <div className="flex justify-between items-center text-sm"><span className="text-muted-foreground">{t("leasecare.first_month_rent", "First month rent")}</span><span className="font-bold text-foreground">${rent.toLocaleString()}</span></div>
                  <div className="h-px bg-red-500/20 my-2" />
                  <div className="flex justify-between items-center text-base"><span className="font-bold text-red-500">{t("leasecare.total_first_day", "Total First Day")}</span><span className="text-2xl font-black text-red-500">Maliyetli</span></div>
                </div>
              </div>

              {/* LeaseCare+ */}
              <div className="p-8 rounded-3xl bg-emerald-500/5 dark:bg-emerald-500/10 border border-emerald-500/20 space-y-6 relative overflow-hidden">
                <div className="absolute top-3 right-3"><Badge className="bg-emerald-500 text-white border-0 text-[10px] font-bold">{t("leasecare.recommended", "RECOMMENDED")}</Badge></div>
                <div className="flex items-center gap-3">
                  <div className="w-10 h-10 rounded-xl bg-emerald-500/10 flex items-center justify-center"><Shield className="w-5 h-5 text-emerald-500" /></div>
                  <div>
                    <h3 className="font-bold text-foreground">{t("leasecare.leasecare_model", "LeaseCare+ Model")}</h3>
                    <p className="text-xs text-muted-foreground">{t("leasecare.monthly_micro_payment", "Monthly micro-payment")}</p>
                  </div>
                </div>
                <div className="space-y-3">
                  <div className="flex justify-between items-center text-sm"><span className="text-muted-foreground">{t("leasecare.first_month_rent", "First month rent")}</span><span className="font-bold text-foreground">${rent.toLocaleString()}</span></div>
                  <div className="flex justify-between items-center text-sm"><span className="text-muted-foreground">{t("leasecare.micro_commission", "Dynamic Micro Commission")}</span><span className="font-bold text-emerald-500">{t("client.src.partner_rate", "Partner Rate")}</span></div>
                  <div className="flex justify-between items-center text-sm"><span className="text-muted-foreground">{t("leasecare.micro_deposit", "Dynamic Micro Deposit")}</span><span className="font-bold text-emerald-500">{t("client.src.partner_rate", "Partner Rate")}</span></div>
                  <div className="h-px bg-emerald-500/20 my-2" />
                  <div className="flex justify-between items-center text-base"><span className="font-bold text-emerald-600 dark:text-emerald-400">{t("leasecare.total_first_day", "Total First Day")}</span><span className="text-2xl font-black text-emerald-600 dark:text-emerald-400">Minimum</span></div>
                </div>
                <div className="bg-emerald-500/10 rounded-xl p-3 text-center">
                  <span className="text-sm font-bold text-emerald-600 dark:text-emerald-400">
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
              <span dangerouslySetInnerHTML={{ __html: t("leasecare.how_it_works", "How it <span class='text-emerald-600 dark:text-emerald-400'>Works?</span>") }} />
            </h2>
            <div className="grid md:grid-cols-3 gap-6 max-w-5xl mx-auto">
              {[
                { icon: Percent, title: t("leasecare.dynamic_commission", "Dynamic Micro Commission"), desc: t("leasecare.dynamic_commission_desc", "No upfront commission! Tenants and landlords benefit from specialized micro-rates determined by partnership levels."), color: "text-blue-500" },
                { icon: PiggyBank, title: t("leasecare.dynamic_deposit", "Dynamic Micro Deposit"), desc: t("leasecare.dynamic_deposit_desc", "Tenants accumulate their deposit dynamically alongside their rent via micro-installments."), color: "text-violet-500" },
                { icon: Lock, title: t("leasecare.escrow_assurance", "Escrow Assurance"), desc: t("leasecare.escrow_desc", "All deposits are securely held in Reservatior Escrow account. Neutral mediation in case of dispute."), color: "text-emerald-500" },
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
                  <div className="w-12 h-12 rounded-full bg-blue-500/10 flex items-center justify-center mx-auto"><Users className="w-5 h-5 text-blue-500" /></div>
                  <div className="text-xs font-bold text-foreground">{t("client.src.tenant", "Tenant")}</div>
                  <div className="text-[10px] text-muted-foreground">{t("leasecare.tenant_calc_dynamic", "Rent + Micro Payments")}</div>
                </div>
                <ArrowLeftRight className="w-5 h-5 text-muted-foreground shrink-0" />
                <div className="text-center space-y-2 flex-1">
                  <div className="w-12 h-12 rounded-full bg-emerald-500/10 flex items-center justify-center mx-auto"><Shield className="w-5 h-5 text-emerald-500" /></div>
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

        {/* ══════ CALCULATOR ══════ */}
        <section className="py-20">
          <div className="container mx-auto px-6">
            <div className="text-center mb-14 space-y-3">
              <Badge className="bg-blue-500/10 text-blue-600 dark:text-blue-400 border-blue-500/20 px-4 py-1 rounded-full text-xs font-bold tracking-wider">
                <Calculator className="w-3.5 h-3.5 mr-1.5" /> {t("leasecare.interactive_calc", "Interactive Calculator")}
              </Badge>
              <h2 className="text-3xl font-black text-foreground">{t("leasecare.how_much_save", "How much will you save?")}</h2>
            </div>

            <div className="max-w-2xl mx-auto p-8 rounded-3xl bg-card border border-border/50 shadow-lg space-y-8">
              {/* Rent Input */}
              <div className="space-y-3">
                <label className="text-sm font-semibold text-foreground flex items-center justify-between">
                  {t("leasecare.monthly_rent_amount", "Monthly Rent Amount")}
                  <span className="text-2xl font-black text-primary">${rent.toLocaleString()}</span>
                </label>
                <Slider value={[rent]} onValueChange={([v]) => setRent(v)} min={500} max={20000} step={100} className="py-2" />
                <div className="flex justify-between text-xs text-muted-foreground"><span>$500</span><span>$20,000</span></div>
              </div>
              {/* {t("leasecare.lease_duration", "Lease Duration")} */}
              <div className="space-y-3">
                <label className="text-sm font-semibold text-foreground flex items-center justify-between">
                  {t("leasecare.lease_duration", "Lease Duration")}
                  <span className="text-2xl font-black text-primary">{months} months</span>
                </label>
                <Slider value={[months]} onValueChange={([v]) => setMonths(v)} min={1} max={36} step={1} className="py-2" />
                <div className="flex justify-between text-xs text-muted-foreground"><span>1 month</span><span>36 months</span></div>
              </div>

              {/* Results */}
              <div className="grid grid-cols-2 gap-4 pt-4">
                <div className="p-4 rounded-xl bg-red-500/5 border border-red-500/10 text-center space-y-1">
                  <div className="text-xs text-muted-foreground">{t("leasecare.traditional_first_day", "Traditional First Day")}</div>
                  <div className="text-xl font-black text-red-500">${(rent * 6).toLocaleString()}</div>
                </div>
                <div className="p-4 rounded-xl bg-emerald-500/5 border border-emerald-500/10 text-center space-y-1">
                  <div className="text-xs text-muted-foreground">{t("leasecare.leasecare_first_day", "LeaseCare+ First Day")}</div>
                  <div className="text-xl font-black text-emerald-600 dark:text-emerald-400">${calc.leasecareFirstMonth.toLocaleString()}</div>
                </div>
              </div>
              <div className="p-4 rounded-xl bg-linear-to-r from-emerald-500/10 to-blue-500/10 border border-emerald-500/15 text-center">
                <div className="text-sm text-muted-foreground">{t("leasecare.your_savings", "Your First Day Savings")}</div>
                <div className="text-3xl font-black text-emerald-600 dark:text-emerald-400 mt-1">${calc.savingsFirstMonth.toLocaleString()}</div>
                <div className="text-xs text-muted-foreground mt-1">{t("leasecare.compared_to_traditional", "Compared to traditional")} {Math.round((calc.savingsFirstMonth / (rent * 6)) * 100)}% {t("leasecare.less_payment", "less payment")}</div>
              </div>
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
                  <div className="w-10 h-10 rounded-xl bg-blue-500/10 flex items-center justify-center"><Users className="w-5 h-5 text-blue-500" /></div>
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
                      <CheckCircle2 className="w-4 h-4 text-blue-500 mt-0.5 shrink-0" /><span>{b}</span>
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
              <div className="absolute inset-0 bg-linear-to-r from-emerald-600 via-indigo-600 to-blue-600" />
              <div className="relative z-10 p-12 md:p-16 text-center space-y-6">
                <h2 className="text-3xl md:text-4xl font-black text-white">{t("leasecare.cta_title", "Start Renting with LeaseCare+")}</h2>
                <p className="text-white/70 max-w-md mx-auto">{t("leasecare.cta_desc", "Fair, transparent, and secure rental experience for tenant and landlord from the first month.")}</p>
                <Button size="lg" className="bg-white text-slate-900 hover:bg-white/90 px-8 h-13 font-bold rounded-2xl shadow-xl">
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
