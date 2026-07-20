"use client";

import { useTranslation } from "react-i18next";
import { useState, useMemo } from "react";
import { useSearchParams, useNavigate } from "@/lib/react-router-shim";
import { motion, AnimatePresence } from "framer-motion";
import { CreditCard, ShieldCheck, Zap, Receipt, AlertCircle, Check, FileText, ChevronRight, ChevronLeft, Building2, Rocket, Globe } from "lucide-react";
import { Button } from "@/components/ui/button";
import { PageShell } from "../layout/PageShell";
import { apiClient } from "@/lib/api/client";
import { useToast } from "@/hooks/use-toast";
import { useRegionsStore } from "@/lib/store";
import { getContractForRegion } from "@/config/contract-clauses";

const PLAN_CATALOG: Record<string, { name: string; priceCents: number | null; maxProperties: number | null; maxUsers: number | null; maxListings: number | null; ai: boolean; integrations: boolean; support: boolean }> = {
  "starter-10":       { name: "STARTER (10 PROPERTIES)",   priceCents: 1900,  maxProperties: 10,   maxUsers: 1,  maxListings: 25,   ai: false, integrations: false, support: false },
  "growth-25":        { name: "GROWTH (25 PROPERTIES)",     priceCents: 4900,  maxProperties: 25,   maxUsers: 3,  maxListings: 100,  ai: false, integrations: false, support: false },
  "professional-50":  { name: "PRO (50 PROPERTIES)",        priceCents: 8000,  maxProperties: 50,   maxUsers: 5,  maxListings: 250,  ai: true,  integrations: false, support: true },
  "agency-100":       { name: "AGENCY (100 PROPERTIES)",    priceCents: 15000, maxProperties: 100,  maxUsers: 10, maxListings: 500,  ai: true,  integrations: false, support: true },
  "enterprise":       { name: "ENTERPRISE",           priceCents: null,  maxProperties: null, maxUsers: null, maxListings: null, ai: true, integrations: true, support: true },
};

export default function Checkout() {
  const { t } = useTranslation();
  const [searchParams] = useSearchParams();
  const navigate = useNavigate();
  const { toast } = useToast();
  const [loading, setLoading] = useState(false);
  const [step, setStep] = useState(0); // 0=Summary, 1=Contract, 2=Payment
  const [contractAccepted, setContractAccepted] = useState(false);
  const { selectedRegion } = useRegionsStore();
  const regionContract = useMemo(() => getContractForRegion(selectedRegion?.countryCode), [selectedRegion?.countryCode]);

  const planId = searchParams.get("plan");
  const plan = planId ? PLAN_CATALOG[planId] : null;

  // Legacy generic checkout params
  const amount = parseFloat(searchParams.get("amount") || "0");
  const currency = searchParams.get("currency") || "USD";
  const type = searchParams.get("type") || "COMMISSION_PAYMENT";
  const bookingId = searchParams.get("bookingId");

  const isPlanCheckout = !!plan;
  const displayPrice = plan?.priceCents ? `$${(plan.priceCents / 100).toFixed(0)}` : t("checkout.custom", "CUSTOM");

  const steps = [
    { label: t("checkout.step_summary", "Plan Summary"), icon: Receipt },
    { label: t("checkout.step_contract", "Contract"), icon: FileText },
    { label: t("checkout.step_payment", "Payment"), icon: CreditCard },
  ];

  const handleCheckout = async () => {
    if (!contractAccepted) {
      toast({ title: t("checkout.contract_required", "Contract Approval Required"), description: t("checkout.please_accept", "Please accept the service agreement to continue."), variant: "destructive" });
      return;
    }
    try {
      setLoading(true);
      const payload = isPlanCheckout
        ? { planId, amount: plan!.priceCents, currency: "USD", paymentType: "SUBSCRIPTION", description: `Reservatior ${plan!.name} Subscription` }
        : { amount, currency, paymentType: type, bookingId, description: `Reservatior: ${type.replace(/_/g, " ")}` };

      const response = await apiClient.post<any>("/payment/create-checkout-session", payload);
      if (response?.url) {
        window.location.href = response.url;
      } else {
        toast({ title: t("checkout.success_demo", "Demo Mode"), description: t("checkout.demo_desc", "Payment infrastructure not yet integrated. Your transaction has been recorded.") });
        navigate("/payment/success?demo=true");
      }
    } catch (error) {
      console.error("Checkout error:", error);
      toast({ title: t("checkout.success_demo", "Demo Mode"), description: t("checkout.demo_desc", "Payment infrastructure not yet integrated. Your transaction has been recorded.") });
      navigate("/payment/success?demo=true");
    } finally {
      setLoading(false);
    }
  };

  const planFeatures = useMemo(() => {
    if (!plan) return [];
    const f: string[] = [];
    f.push(plan.maxProperties ? `${plan.maxProperties} Properties Portfolio` : "Unlimited Property Portfolio");
    f.push(plan.maxUsers ? `${plan.maxUsers} User Access` : "Unlimited Users");
    f.push(plan.maxListings ? `${plan.maxListings} Active Listings` : "Unlimited Listings");
    if (plan.ai) f.push("AI-Powered Analytics");
    if (plan.integrations) f.push("Custom Integrations & ERP");
    f.push(plan.support ? "24/7 Priority Support" : "Email Support");
    return f;
  }, [plan]);

  if (!isPlanCheckout && !bookingId && amount === 0) {
    return (
      <PageShell title={t("checkout.no_plan", "No Plan Selected")} description="">
        <div className="flex flex-col items-center justify-center py-20 gap-6">
          <AlertCircle className="w-16 h-16 text-yellow-500" />
          <p className="text-slate-400 text-sm">{t("checkout.select_plan_first", "Please select a plan first.")}</p>
          <Button onClick={() => navigate("/pricing")} className="bg-blue-600 hover:bg-blue-500">
            <ChevronLeft className="w-4 h-4 mr-2" /> {t("checkout.back_to_pricing", "Back to Pricing")}
          </Button>
        </div>
      </PageShell>
    );
  }

  return (
    <PageShell
      title={isPlanCheckout ? t("checkout.subscribe_title", "Create Subscription") : t("client.src.secure_neural_checkout")}
      description={isPlanCheckout ? t("checkout.subscribe_desc", "Review your selected plan and accept the agreement to start your subscription.") : t("client.src.finalize_your_portfolio_transaction")}
    >
      {/* Step Progress Bar */}
      <div className="max-w-3xl mx-auto mb-12 px-4">
        <div className="flex items-center justify-between">
          {steps.map((s, i) => (
            <div key={i} className="flex items-center flex-1">
              <div className="flex flex-col items-center gap-2">
                <div className={`w-12 h-12 rounded-full flex items-center justify-center border-2 transition-all duration-500 ${i <= step ? "bg-blue-600 border-blue-500 text-white shadow-lg shadow-blue-600/30" : "bg-[#1a1b1e] border-slate-700 text-slate-500"}`}>
                  {i < step ? <Check className="w-5 h-5" /> : <s.icon className="w-5 h-5" />}
                </div>
                <span className={`text-[10px] font-bold tracking-widest uppercase ${i <= step ? "text-blue-400" : "text-slate-600"}`}>{s.label}</span>
              </div>
              {i < steps.length - 1 && (
                <div className="flex-1 mx-4 mb-6">
                  <div className={`h-0.5 rounded transition-all duration-500 ${i < step ? "bg-blue-500" : "bg-slate-800"}`} />
                </div>
              )}
            </div>
          ))}
        </div>
      </div>

      <div className="max-w-4xl mx-auto px-4">
        <AnimatePresence mode="wait">
          {/* STEP 0: Plan Summary */}
          {step === 0 && (
            <motion.div key="summary" initial={{ opacity: 0, x: -30 }} animate={{ opacity: 1, x: 0 }} exit={{ opacity: 0, x: 30 }} className="grid md:grid-cols-2 gap-8">
              <div className="bg-[#1a1b1e]/60 backdrop-blur-xl border border-slate-800 p-8 rounded-3xl">
                <div className="flex items-center gap-3 mb-6">
                  <Building2 className="w-6 h-6 text-blue-400" />
                  <h2 className="text-lg font-black text-white tracking-wide">{isPlanCheckout ? plan!.name : type.replace(/_/g, " ")}</h2>
                </div>
                {isPlanCheckout && (
                  <>
                    <div className="flex items-baseline gap-2 mb-8">
                      <span className="text-5xl font-black text-white italic">{displayPrice}</span>
                      {plan!.priceCents && <span className="text-slate-500 text-xs font-bold tracking-wider">/ PER UNIT MONTHLY</span>}
                    </div>
                    <div className="space-y-3">
                      {planFeatures.map((feat, i) => (
                        <div key={i} className="flex items-center gap-3">
                          <div className="w-5 h-5 rounded-full bg-blue-500/10 border border-blue-500/20 flex items-center justify-center shrink-0">
                            <Check className="w-3 h-3 text-blue-400" />
                          </div>
                          <span className="text-sm text-slate-300">{feat}</span>
                        </div>
                      ))}
                    </div>
                  </>
                )}
                {!isPlanCheckout && (
                  <div className="bg-blue-600/5 border border-blue-600/20 p-6 rounded-xl">
                    <div className="text-slate-400 text-sm mb-1">{t("client.src.total_synchronized_amount")}</div>
                    <div className="text-3xl font-black text-blue-400">{currency} {amount.toLocaleString()}</div>
                  </div>
                )}
              </div>

              <div className="flex flex-col justify-between">
                <div className="space-y-4 mb-8">
                  <div className="bg-[#1a1b1e]/60 border border-slate-800 p-6 rounded-2xl">
                    <h4 className="font-bold flex items-center gap-2 mb-2 text-white"><Zap className="w-4 h-4 text-yellow-400" /> Instant Activation</h4>
                    <p className="text-xs text-slate-400 leading-relaxed">Your account becomes active immediately after payment confirmation, giving you access to all features.</p>
                  </div>
                  <div className="bg-[#1a1b1e]/60 border border-slate-800 p-6 rounded-2xl">
                    <h4 className="font-bold flex items-center gap-2 mb-2 text-white"><ShieldCheck className="w-4 h-4 text-emerald-400" /> Secure Transaction</h4>
                    <p className="text-xs text-slate-400 leading-relaxed">All payment information is protected with AES-256 encryption. Your card details are not stored on our servers.</p>
                  </div>
                </div>
                <Button onClick={() => setStep(1)} className="w-full h-14 bg-blue-600 hover:bg-blue-500 text-white font-bold text-sm tracking-wider rounded-2xl gap-2">
                  {t("checkout.continue_contract", "Continue to Contract")} <ChevronRight className="w-4 h-4" />
                </Button>
              </div>
            </motion.div>
          )}

          {/* STEP 1: Contract */}
          {step === 1 && (
            <motion.div key="contract" initial={{ opacity: 0, x: -30 }} animate={{ opacity: 1, x: 0 }} exit={{ opacity: 0, x: 30 }}>
              <div className="bg-[#1a1b1e]/60 backdrop-blur-xl border border-slate-800 p-8 rounded-3xl mb-6">
                <div className="flex items-center justify-between mb-6">
                  <h2 className="text-lg font-black text-white flex items-center gap-3"><FileText className="w-6 h-6 text-blue-400" /> {t("checkout.service_agreement", "Service Agreement")}</h2>
                  <div className="flex items-center gap-2 bg-blue-600/10 border border-blue-500/20 px-4 py-2 rounded-full">
                    <Globe className="w-4 h-4 text-blue-400" />
                    <span className="text-xs font-bold text-blue-300 tracking-wider">{regionContract.flag} {regionContract.jurisdiction}</span>
                  </div>
                </div>
                <div className="bg-[#0e0f11] border border-slate-800 rounded-2xl p-6 max-h-[400px] overflow-y-auto text-sm text-slate-400 leading-relaxed space-y-4 scrollbar-thin scrollbar-thumb-slate-700">
                  <h3 className="text-white font-bold text-base">{regionContract.heading}</h3>
                  <p className="text-xs text-slate-500">Last updated: May 31, 2026</p>
                  <p>{regionContract.intro}</p>
                  {regionContract.clauses.map((clause, i) => (
                    <div key={i}>
                      <h4 className="text-white font-semibold mt-4">{clause.title}</h4>
                      <p>{clause.body}</p>
                    </div>
                  ))}
                </div>
              </div>

              <div className="bg-[#1a1b1e]/60 border border-slate-800 p-6 rounded-2xl mb-6">
                <label className="flex items-start gap-4 cursor-pointer group" onClick={() => setContractAccepted(!contractAccepted)}>
                  <div className={`w-6 h-6 rounded-lg border-2 flex items-center justify-center shrink-0 mt-0.5 transition-all duration-300 ${contractAccepted ? "bg-blue-600 border-blue-500" : "border-slate-600 group-hover:border-slate-400"}`}>
                    {contractAccepted && <Check className="w-4 h-4 text-white" />}
                  </div>
                  <span className="text-sm text-slate-300 leading-relaxed">
                    {regionContract.acceptanceText}
                  </span>
                </label>
              </div>

              <div className="flex gap-4">
                <Button onClick={() => setStep(0)} variant="outline" className="flex-1 h-14 rounded-2xl border-slate-700 text-slate-300 hover:bg-slate-800 font-bold text-sm gap-2">
                  <ChevronLeft className="w-4 h-4" /> {t("checkout.back", "Back")}
                </Button>
                <Button onClick={() => { if (contractAccepted) setStep(2); else toast({ title: "Contract Approval Required", description: "Please accept the contract to continue.", variant: "destructive" }); }} className={`flex-1 h-14 rounded-2xl font-bold text-sm gap-2 transition-all ${contractAccepted ? "bg-blue-600 hover:bg-blue-500 text-white" : "bg-slate-800 text-slate-500 cursor-not-allowed"}`}>
                  {t("checkout.continue_payment", "Continue to Payment")} <ChevronRight className="w-4 h-4" />
                </Button>
              </div>
            </motion.div>
          )}

          {/* STEP 2: Payment */}
          {step === 2 && (
            <motion.div key="payment" initial={{ opacity: 0, x: -30 }} animate={{ opacity: 1, x: 0 }} exit={{ opacity: 0, x: 30 }} className="grid md:grid-cols-2 gap-8">
              <div className="bg-[#1a1b1e]/60 backdrop-blur-xl border border-slate-800 p-8 rounded-3xl">
                <h2 className="text-lg font-black text-white flex items-center gap-3 mb-8"><CreditCard className="w-6 h-6 text-blue-400" /> {t("checkout.payment_info", "Payment Information")}</h2>

                <div className="bg-blue-600/5 border border-blue-600/20 p-6 rounded-xl flex justify-between items-center mb-8">
                  <div>
                    <div className="text-slate-500 text-xs font-bold tracking-wider mb-1">TOTAL AMOUNT</div>
                    <div className="text-slate-300 text-sm">{isPlanCheckout ? plan!.name : type.replace(/_/g, " ")}</div>
                  </div>
                  <div className="text-4xl font-black text-blue-400 italic">{isPlanCheckout ? displayPrice : `${currency} ${amount}`}</div>
                </div>

                <div className="space-y-3 mb-8">
                  <div className="flex items-center gap-3 text-sm text-slate-400">
                    <Check className="w-4 h-4 text-emerald-400 shrink-0" />
                    <span>Contract approved ✓</span>
                  </div>
                  <div className="flex items-center gap-3 text-sm text-slate-400">
                    <ShieldCheck className="w-4 h-4 text-emerald-400 shrink-0" />
                    <span>Payment protected with 256-bit SSL encryption</span>
                  </div>
                  <div className="flex items-center gap-3 text-sm text-slate-400">
                    <Zap className="w-4 h-4 text-yellow-400 shrink-0" />
                    <span>Instant account activation</span>
                  </div>
                </div>

                <Button onClick={handleCheckout} disabled={loading} className="w-full h-16 bg-blue-600 hover:bg-blue-500 text-white font-black text-sm tracking-widest rounded-2xl gap-3 shadow-xl shadow-blue-600/20 transition-all">
                  {loading ? (
                    <span className="flex items-center gap-2"><div className="w-5 h-5 border-2 border-white/30 border-t-white rounded-full animate-spin" /> Processing...</span>
                  ) : (
                    <><CreditCard className="w-5 h-5" /> {t("checkout.pay_now", "PAY NOW")}</>
                  )}
                </Button>
              </div>

              <div className="flex flex-col gap-4">
                <div className="bg-[#1a1b1e]/60 border border-slate-800 p-6 rounded-2xl">
                  <h4 className="font-bold flex items-center gap-2 mb-2 text-white"><Rocket className="w-4 h-4 text-blue-400" /> Next Steps</h4>
                  <ul className="space-y-2 text-xs text-slate-400">
                    <li className="flex items-start gap-2"><span className="text-blue-400 font-bold">1.</span> Your account will be activated after successful payment</li>
                    <li className="flex items-start gap-2"><span className="text-blue-400 font-bold">2.</span> You will be redirected to the dashboard</li>
                    <li className="flex items-start gap-2"><span className="text-blue-400 font-bold">3.</span> You can start adding properties immediately</li>
                  </ul>
                </div>

                <div className="mt-auto flex items-start gap-4 p-4 bg-yellow-600/5 border border-yellow-600/20 rounded-xl">
                  <AlertCircle className="w-8 h-8 text-yellow-500 shrink-0" />
                  <div>
                    <h5 className="font-bold text-sm text-yellow-500 mb-1">Cancellation Policy</h5>
                    <p className="text-xs text-slate-400 leading-relaxed">You can cancel your subscription at any time. Your service will continue until the end of the current billing period after cancellation.</p>
                  </div>
                </div>

                <Button onClick={() => setStep(1)} variant="outline" className="h-12 rounded-2xl border-slate-700 text-slate-400 hover:bg-slate-800 font-bold text-xs gap-2">
                  <ChevronLeft className="w-4 h-4" /> {t("checkout.back_contract", "Back to Contract")}
                </Button>
              </div>
            </motion.div>
          )}
        </AnimatePresence>
      </div>
    </PageShell>
  );
}