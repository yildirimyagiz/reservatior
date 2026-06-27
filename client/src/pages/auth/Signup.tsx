import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useMemo } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Link, useNavigate } from "react-router-dom";
import { motion, AnimatePresence } from "framer-motion";
import { Github, Mail, Eye, EyeOff, AlertCircle, Check, X, Building2, ShieldCheck, Zap, TrendingUp, ChevronRight, Facebook, Star, Crown, LayoutDashboard, Users } from "lucide-react";
import { Alert, AlertDescription } from "@/components/ui/alert";
import { useAuth } from "@/lib/auth/hooks";
import { AuthUtils } from "@/lib/auth/utils";
import { toast } from "sonner";
import { cn } from "@/lib/utils";

const PLANS = [
  { id: "starter-10", name: "Starter", price: "$19", period: "/mo", properties: 10, users: 1, ai: false, popular: false, icon: Star },
  { id: "growth-25", name: "Growth", price: "$49", period: "/mo", properties: 25, users: 3, ai: false, popular: false, icon: TrendingUp },
  { id: "professional-50", name: "Professional", price: "$80", period: "/mo", properties: 50, users: 5, ai: true, popular: true, icon: Crown },
  { id: "agency-100", name: "Agency", price: "$150", period: "/mo", properties: 100, users: 10, ai: true, popular: false, icon: LayoutDashboard },
];

export default function Signup() {
  const {
    t
  } = useTranslation();
  const [formData, setFormData] = useState({
    email: "",
    password: "",
    confirmPassword: "",
    name: "",
    phone: "",
    organizationName: ""
  });
  const [selectedPlan, setSelectedPlan] = useState<string>("starter-10");
  const [showPassword, setShowPassword] = useState(false);
  const [showConfirmPassword, setShowConfirmPassword] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  const [agreedToTerms, setAgreedToTerms] = useState(false);
  const {
    register,
    loading,
    error
  } = useAuth();
  const navigate = useNavigate();
  const handleInputChange = (field: string, value: string) => {
    setFormData(prev => ({
      ...prev,
      [field]: value
    }));
    setValidationError(null);
  };
  const [validationError, setValidationError] = useState<string | null>(null);
  const validateForm = () => {
    const emailValidation = AuthUtils.validateEmail(formData.email);
    const passwordValidation = AuthUtils.validatePassword(formData.password);
    if (!emailValidation) return "Please enter a valid email address";
    if (!passwordValidation.isValid) return passwordValidation.errors[0];
    if (formData.password !== formData.confirmPassword) return "Passwords do not match";
    if (!formData.name.trim()) return "Please enter your name";
    if (!agreedToTerms) return "You must accept the terms of use";
    return null;
  };
  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    const err = validateForm();
    if (err) { setValidationError(err); return; }
    setValidationError(null);
    setIsLoading(true);
    try {
      await register(formData.email, formData.password, formData.name, formData.phone || undefined, formData.organizationName || undefined, selectedPlan);
      navigate("/dashboard");
    } catch (err) {
      // Handled by auth hook
    } finally {
      setIsLoading(false);
    }
  };
  const isFormValid = useMemo(() => {
    const hasBasicFields = formData.email && formData.password && formData.name && formData.confirmPassword && agreedToTerms;
    return hasBasicFields && validateForm() === null;
  }, [formData, agreedToTerms]);
  const handleSocialLogin = (provider: string) => {
    const apiUrl = import.meta.env.VITE_API_URL || '';
    if (provider === 'google') {
      window.location.href = `${apiUrl}/api/auth/google`;
    } else if (provider === 'facebook') {
      window.location.href = `${apiUrl}/api/auth/facebook`;
    } else {
      toast.info(`${provider.charAt(0).toUpperCase() + provider.slice(1)} login is coming soon!`);
    }
  };
  return <div className="min-h-screen bg-[#0a0a0c] flex flex-col font-sans selection:bg-blue-500/30">
      <div className="flex-1 flex overflow-hidden">
        {/* Left Side: Marketing Visual - Hidden on mobile */}
        <motion.div initial={{
        opacity: 0,
        x: -20
      }} animate={{
        opacity: 1,
        x: 0
      }} transition={{
        duration: 0.8,
        ease: "easeOut"
      }} className="hidden lg:flex lg:w-1/2 relative p-12 flex-col justify-between overflow-hidden">
          {/* Background Image Container */}
          <div className="absolute inset-0 z-0 scale-105">
            <img src="/Users/os2026/.gemini/antigravity/brain/6bad611c-3d47-4562-a8e5-28da8061d20b/signup_marketing_visual_1774809203445.png" alt={t("client.src.marketing_visual")} className="w-full h-full object-cover opacity-60 mix-blend-screen" />
            <div className="absolute inset-0 bg-linear-to-br from-[#0a0a0c] via-transparent to-[#0a0a0c]/80" />
            <div className="absolute inset-0 bg-linear-to-t from-[#0a0a0c] via-transparent to-transparent opacity-90" />
          </div>

          <div className="relative z-10 max-w-lg mb-12">
            <motion.div initial={{
            opacity: 0,
            y: 20
          }} animate={{
            opacity: 1,
            y: 0
          }} transition={{
            delay: 0.3,
            duration: 0.6
          }}>
              <h2 className="text-5xl font-bold text-white leading-[1.1] mb-6 tracking-tight">{t("client.src.aipowered")}<span className="text-transparent bg-clip-text bg-linear-to-r from-blue-400 to-indigo-400">{t("client.src.intelligence")}</span>{t("client.src.for_real_estate")}</h2>
              <p className="text-xl text-slate-300/80 leading-relaxed mb-8">{t("client.src.from_market_analysis_to")}</p>

              <div className="grid grid-cols-2 gap-6">
                <div className="flex gap-4 p-4 rounded-2xl bg-white/5 backdrop-blur-md border border-white/10 hover:bg-white/10 transition-colors">
                  <div className="w-10 h-10 rounded-lg bg-blue-500/20 flex items-center justify-center shrink-0">
                    <ShieldCheck className="text-blue-400 w-6 h-6" />
                  </div>
                  <div>
                    <h4 className="text-white font-semibold text-sm">{t("client.src.secure_data")}</h4>
                    <p className="text-slate-400 text-xs mt-1">{t("client.src.endtoend_encrypted_data_protection")}</p>
                  </div>
                </div>
                <div className="flex gap-4 p-4 rounded-2xl bg-white/5 backdrop-blur-md border border-white/10 hover:bg-white/10 transition-colors">
                  <div className="w-10 h-10 rounded-lg bg-indigo-500/20 flex items-center justify-center shrink-0">
                    <TrendingUp className="text-indigo-400 w-6 h-6" />
                  </div>
                  <div>
                    <h4 className="text-white font-semibold text-sm">{t("client.src.smart_analysis")}</h4>
                    <p className="text-slate-400 text-xs mt-1">{t("client.src.aipowered_market_predictions")}</p>
                  </div>
                </div>
              </div>
            </motion.div>
          </div>

          <div className="relative z-10 flex items-center gap-6 py-4 border-t border-white/5">
            <div className="flex -space-x-3">
              {[1, 2, 3, 4].map(i => <div key={i} className="w-10 h-10 rounded-full border-2 border-[#0a0a0c] bg-slate-800 overflow-hidden shadow-xl">
                  <img src={`https://i.pravatar.cc/100?u=${i}`} alt={t("client.src.user")} className="w-full h-full object-cover" />
                </div>)}
              <div className="w-10 h-10 rounded-full border-2 border-[#0a0a0c] bg-blue-600 flex items-center justify-center shadow-xl text-[10px] font-bold text-white">
                500+
              </div>
            </div>
            <div className="text-sm">
              <span className="text-white font-medium">{t("client.src.join_our_professional_team")}</span>
              <p className="text-slate-400 text-xs">{t("client.src.trusted_by_10000_users")}</p>
            </div>
          </div>
        </motion.div>

        {/* Right Side: Signup Form */}
        <div className="w-full lg:w-1/2 flex flex-col md:overflow-y-auto custom-scrollbar bg-[#0a0a0c]">
          <div className="max-w-[520px] w-full mx-auto px-6 py-12 flex flex-col justify-center min-h-full">
            <motion.div initial={{
            opacity: 0,
            y: 20
          }} animate={{
            opacity: 1,
            y: 0
          }} transition={{
            delay: 0.1,
            duration: 0.5
          }}>
              <div className="mb-10 text-center lg:text-left">
                <h2 className="text-4xl font-bold text-white mb-3 tracking-tight">{t("client.src.create_account")}</h2>
                <p className="text-slate-400 text-lg">{t("client.src.join_us_today_and")}</p>
              </div>

              <form onSubmit={handleSubmit} className="space-y-6">
                <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                  <div className="space-y-2.5">
                    <Label htmlFor="name" className="text-slate-300 font-medium ml-1">{t("client.src.full_name")}</Label>
                    <div className="relative group">
                      <Input id="name" placeholder={t("client.src.eg_john_doe")} value={formData.name} onChange={e => handleInputChange("name", e.target.value)} className="bg-[#14151a] border-[#24262f] hover:border-slate-700 focus:border-blue-500 focus:ring-blue-500/20 h-12 text-slate-200 placeholder:text-slate-600 rounded-2xl transition-all duration-300" required disabled={loading || isLoading} />
                    </div>
                  </div>
                  <div className="space-y-2.5">
                    <Label htmlFor="phone" className="text-slate-300 font-medium ml-1">{t("client.src.phone_number")}</Label>
                    <Input id="phone" type="tel" placeholder="+1 (555) 000 00 00" value={formData.phone} onChange={e => handleInputChange("phone", e.target.value)} className="bg-[#14151a] border-[#24262f] hover:border-slate-700 focus:border-blue-500 focus:ring-blue-500/20 h-12 text-slate-200 placeholder:text-slate-600 rounded-2xl transition-all duration-300" disabled={loading || isLoading} />
                  </div>
                </div>

                <div className="space-y-2.5">
                  <Label htmlFor="email" className="text-slate-300 font-medium ml-1">{t("client.src.email_address")}</Label>
                  <Input id="email" type="email" placeholder={t("client.src.johnexamplecom")} value={formData.email} onChange={e => handleInputChange("email", e.target.value)} className="bg-[#14151a] border-[#24262f] hover:border-slate-700 focus:border-blue-500 focus:ring-blue-500/20 h-12 text-slate-200 placeholder:text-slate-600 rounded-2xl transition-all duration-300" required disabled={loading || isLoading} />
                </div>

                <div className="space-y-2.5">
                  <Label htmlFor="organizationName" className="text-slate-300 font-medium ml-1">{t("client.src.organization_name_optional")}</Label>
                  <Input id="organizationName" placeholder={t("client.src.eg_vision_real_estate")} value={formData.organizationName} onChange={e => handleInputChange("organizationName", e.target.value)} className="bg-[#14151a] border-[#24262f] hover:border-slate-700 focus:border-blue-500 focus:ring-blue-500/20 h-12 text-slate-200 placeholder:text-slate-600 rounded-2xl transition-all duration-300" disabled={loading || isLoading} />
                </div>

                {/* Plan Selection */}
                <div className="space-y-3">
                  <Label className="text-slate-300 font-medium ml-1">Choose your plan</Label>
                  <div className="grid grid-cols-2 lg:grid-cols-4 gap-3">
                    {PLANS.map((plan) => {
                      const Icon = plan.icon;
                      const isSelected = selectedPlan === plan.id;
                      return (
                        <button
                          type="button"
                          key={plan.id}
                          onClick={() => setSelectedPlan(plan.id)}
                          className={cn(
                            "relative p-4 rounded-2xl border text-left transition-all duration-200",
                            isSelected
                              ? "border-blue-500 bg-blue-500/10 shadow-lg shadow-blue-500/10"
                              : "border-[#24262f] bg-[#14151a] hover:border-slate-700 hover:bg-[#1a1b22]"
                          )}
                        >
                          {plan.popular && (
                            <span className="absolute -top-2 -right-2 px-2 py-0.5 bg-blue-600 text-white text-[8px] font-bold rounded-full">POPULAR</span>
                          )}
                          <div className="flex items-center gap-2 mb-2">
                            <Icon className={cn("w-4 h-4", isSelected ? "text-blue-400" : "text-slate-500")} />
                            <span className={cn("text-sm font-bold", isSelected ? "text-white" : "text-slate-300")}>{plan.name}</span>
                          </div>
                          <div className="mb-2">
                            <span className="text-lg font-extrabold text-white">{plan.price}</span>
                            <span className="text-[10px] text-slate-500 ml-0.5">{plan.period}</span>
                          </div>
                          <div className="space-y-1">
                            <div className="flex items-center gap-1.5">
                              <Building2 className="w-3 h-3 text-slate-600" />
                              <span className="text-[10px] text-slate-500">{plan.properties} properties</span>
                            </div>
                            <div className="flex items-center gap-1.5">
                              <Users className="w-3 h-3 text-slate-600" />
                              <span className="text-[10px] text-slate-500">{plan.users} user{plan.users > 1 ? 's' : ''}</span>
                            </div>
                            {plan.ai && (
                              <div className="flex items-center gap-1.5">
                                <Zap className="w-3 h-3 text-amber-500" />
                                <span className="text-[10px] text-amber-500 font-semibold">AI Features</span>
                              </div>
                            )}
                          </div>
                          {isSelected && (
                            <div className="absolute top-2 left-2 w-5 h-5 rounded-full bg-blue-600 flex items-center justify-center">
                              <Check className="w-3 h-3 text-white" />
                            </div>
                          )}
                        </button>
                      );
                    })}
                  </div>
                </div>

                <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                  <div className="space-y-2.5 relative">
                    <Label htmlFor="password" className="text-slate-300 font-medium ml-1">{t("client.src.password")}</Label>
                    <div className="relative group">
                      <Input id="password" type={showPassword ? "text" : "password"} placeholder="••••••••" value={formData.password} onChange={e => handleInputChange("password", e.target.value)} className="bg-[#14151a] border-[#24262f] hover:border-slate-700 focus:border-blue-500 focus:ring-blue-500/20 h-12 pr-11 text-slate-200 placeholder:text-slate-600 rounded-2xl transition-all duration-300" required disabled={loading || isLoading} />
                      <button type="button" onClick={() => setShowPassword(!showPassword)} className="absolute right-4 top-1/2 -translate-y-1/2 text-slate-500 hover:text-slate-300 transition-colors" disabled={loading || isLoading}>
                        {showPassword ? <EyeOff size={18} /> : <Eye size={18} />}
                      </button>
                    </div>
                  </div>
                  <div className="space-y-2.5 relative">
                    <Label htmlFor="confirmPassword" className="text-slate-300 font-medium ml-1">{t("client.src.confirm_password")}</Label>
                    <div className="relative group">
                      <Input id="confirmPassword" type={showConfirmPassword ? "text" : "password"} placeholder="••••••••" value={formData.confirmPassword} onChange={e => handleInputChange("confirmPassword", e.target.value)} className="bg-[#14151a] border-[#24262f] hover:border-slate-700 focus:border-blue-500 focus:ring-blue-500/20 h-12 pr-11 text-slate-200 placeholder:text-slate-600 rounded-2xl transition-all duration-300" required disabled={loading || isLoading} />
                      <button type="button" onClick={() => setShowConfirmPassword(!showConfirmPassword)} className="absolute right-4 top-1/2 -translate-y-1/2 text-slate-500 hover:text-slate-300 transition-colors" disabled={loading || isLoading}>
                        {showConfirmPassword ? <EyeOff size={18} /> : <Eye size={18} />}
                      </button>
                    </div>
                  </div>
                </div>

                <AnimatePresence>
                  {formData.password && <motion.div initial={{
                  opacity: 0,
                  height: 0
                }} animate={{
                  opacity: 1,
                  height: "auto"
                }} exit={{
                  opacity: 0,
                  height: 0
                }} className="grid grid-cols-2 gap-2 mt-4 p-4 rounded-2xl bg-[#14151a] border border-[#24262f] overflow-hidden">
                      {[{
                    label: t("client.src.at_least_8_characters"),
                    check: formData.password.length >= 8
                  }, {
                    label: t("client.src.uppercase_letter"),
                    check: /[A-Z]/.test(formData.password)
                  }, {
                    label: t("client.src.lowercase_letter"),
                    check: /[a-z]/.test(formData.password)
                  }, {
                    label: t("client.src.number"),
                    check: /\d/.test(formData.password)
                  }].map((req, i) => <div key={i} className="flex items-center gap-2">
                          {req.check ? <Check className="w-3.5 h-3.5 text-emerald-500 shrink-0" /> : <div className="w-3.5 h-3.5 rounded-full border border-slate-700 shrink-0" />}
                          <span className={`text-[11px] font-medium transition-colors ${req.check ? "text-emerald-500" : "text-slate-500"}`}>
                            {req.label}
                          </span>
                        </div>)}
                    </motion.div>}
                </AnimatePresence>

                <div className="flex items-start gap-3 pl-1">
                  <div className="relative flex items-center h-5">
                    <input type="checkbox" id="terms" checked={agreedToTerms} onChange={e => setAgreedToTerms(e.target.checked)} className="w-4.5 h-4.5 rounded text-blue-600 bg-[#14151a] border-[#24262f] focus:ring-blue-500/20 transition-colors cursor-pointer" disabled={loading || isLoading} />
                  </div>
                  <Label htmlFor="terms" className="text-sm text-slate-400 leading-tight select-none cursor-pointer">{t("client.src.i_have_read_and")}<Link to="/terms" className="text-blue-400 hover:text-blue-300 transition-colors font-medium">{t("client.src.terms_of_use")}</Link>{t("client.src.and")}<Link to="/privacy" className="text-blue-400 hover:text-blue-300 transition-colors font-medium">{t("client.src.privacy_policy")}</Link>.
                  </Label>
                </div>

                {(validationError || error) && <Alert variant="destructive" className="bg-red-500/10 border-red-500/20 rounded-2xl animate-in fade-in slide-in-from-top-2 duration-300">
                    <AlertCircle className="h-4 w-4 text-red-400" />
                    <AlertDescription className="text-red-400 text-sm font-medium">{validationError || error}</AlertDescription>
                  </Alert>}

                <Button type="submit" className="w-full h-14 bg-linear-to-r from-blue-600 to-indigo-600 hover:from-blue-500 hover:to-indigo-500 text-white font-bold text-base rounded-2xl transition-all duration-300 shadow-xl shadow-blue-600/20 group relative overflow-hidden" disabled={!isFormValid || loading || isLoading}>
                  <span className="relative z-10 flex items-center justify-center gap-2">
                    {loading || isLoading ? t("client.src.creating_account") : t("client.src.create_account")}
                  </span>
                  <div className="absolute inset-0 bg-linear-to-r from-white/0 via-white/10 to-white/0 -translate-x-full group-hover:animate-shimmer" />
                </Button>
              </form>

              <div className="relative my-10 py-2">
                <div className="absolute inset-0 flex items-center">
                  <div className="w-full border-t border-[#24262f]"></div>
                </div>
                <div className="relative flex justify-center text-xs">
                  <span className="bg-[#0a0a0c] px-4 text-slate-500 font-bold tracking-widest">{t("client.src.or_continue_with")}</span>
                </div>
              </div>

              <div className="grid grid-cols-3 gap-4">
                <Button type="button" variant="outline" className="h-12 bg-[#14151a] border-[#24262f] hover:bg-slate-800/40 text-slate-300 rounded-2xl transition-all group" disabled={loading || isLoading} onClick={() => handleSocialLogin("github")}>
                  <Github className="mr-2 h-5 w-5 group-hover:text-white transition-colors" />{t("client.src.github")}</Button>
                <Button type="button" variant="outline" className="h-12 bg-[#14151a] border-[#24262f] hover:bg-slate-800/40 text-slate-300 rounded-2xl transition-all group" disabled={loading || isLoading} onClick={() => handleSocialLogin("google")}>
                  <Mail className="mr-2 h-5 w-5 group-hover:text-white transition-colors" />{t("client.src.google")}</Button>
                <Button type="button" variant="outline" className="h-12 bg-[#14151a] border-[#24262f] hover:bg-slate-800/40 text-slate-300 rounded-2xl transition-all group" disabled={loading || isLoading} onClick={() => handleSocialLogin("facebook")}>
                  <Facebook className="mr-2 h-5 w-5 group-hover:text-white transition-colors" />{t("client.src.facebook")}</Button>
              </div>

              <p className="text-center text-slate-400 mt-10">{t("client.src.already_have_an_account")}{" "}
                <Link to="/login" className="text-white hover:text-blue-400 transition-all font-bold underline underline-offset-4 decoration-slate-700 hover:decoration-blue-500">{t("client.src.log_in")}</Link>
              </p>
            </motion.div>
          </div>
        </div>
      </div>
    </div>;
}