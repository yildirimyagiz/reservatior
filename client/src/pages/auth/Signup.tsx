import { useTranslation } from "react-i18next";
import { useState, useMemo } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Link, useNavigate, useSearchParams } from "react-router-dom";
import { motion, AnimatePresence } from "framer-motion";
import { Github, Mail, Eye, EyeOff, AlertCircle, Check, Zap, ChevronRight, Facebook, Twitter, Building2, User } from "lucide-react";
import { Alert, AlertDescription } from "@/components/ui/alert";
import { useAuth } from "@/lib/auth/hooks";
import { AuthUtils } from "@/lib/auth/utils";
import { toast } from "sonner";
import { Tabs, TabsList, TabsTrigger, TabsContent } from "@/components/ui/tabs";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";

const GoogleIcon = ({ className }: { className?: string }) => (
  <svg viewBox="0 0 24 24" className={className} fill="currentColor" xmlns="http://www.w3.org/2000/svg">
    <path d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z" />
    <path d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" />
    <path d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z" />
    <path d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z" />
  </svg>
);

export default function Signup() {
  const { t } = useTranslation();
  const [accountType, setAccountType] = useState<"INDIVIDUAL" | "CORPORATE">("INDIVIDUAL");
  
  const [formData, setFormData] = useState({
    email: "",
    password: "",
    confirmPassword: "",
    name: "",
    phone: "",
    organizationName: "",
    corporateType: "OWNER_PORTFOLIO"
  });

  const [showPassword, setShowPassword] = useState(false);
  const [showConfirmPassword, setShowConfirmPassword] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  const [agreedToTerms, setAgreedToTerms] = useState(false);
  
  const { register, loading, error } = useAuth();
  const navigate = useNavigate();
  const [searchParams] = useSearchParams();
  const promoCode = searchParams.get("promo") || undefined;
  const leadId = searchParams.get("leadId");

  const handleInputChange = (field: string, value: string) => {
    setFormData((prev) => ({
      ...prev,
      [field]: value,
    }));
  };

  const validateForm = () => {
    const emailValidation = AuthUtils.validateEmail(formData.email);
    const passwordValidation = AuthUtils.validatePassword(formData.password);
    if (!emailValidation) return "Please enter a valid email address";
    if (!passwordValidation.isValid) return passwordValidation.errors[0];
    if (formData.password !== formData.confirmPassword) return "Passwords do not match";
    if (!formData.name.trim()) return "Please enter your name";
    if (accountType === "CORPORATE" && !formData.organizationName.trim()) return "Lütfen kurum adını girin";
    if (!agreedToTerms) return "You must accept the terms of use";
    return null;
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    const validationError = validateForm();
    if (validationError) {
      toast.error(validationError);
      return;
    }
    
    setIsLoading(true);
    try {
      await register(
        formData.email,
        formData.password,
        formData.name,
        formData.phone || undefined,
        promoCode,
        accountType,
        accountType === "CORPORATE" ? formData.corporateType : undefined,
        accountType === "CORPORATE" ? formData.organizationName : undefined
      );
      toast.success("Hesabınız başarıyla oluşturuldu!");
      navigate("/dashboard");
    } catch (err: any) {
      // Handled by auth hook, but we can toast
      toast.error(err?.message || "Kayıt olurken bir hata oluştu");
    } finally {
      setIsLoading(false);
    }
  };

  const isFormValid = useMemo(() => {
    const hasBasicFields = formData.email && formData.password && formData.name && formData.confirmPassword && agreedToTerms;
    const hasCorpFields = accountType === "CORPORATE" ? !!formData.organizationName : true;
    return hasBasicFields && hasCorpFields && validateForm() === null;
  }, [formData, agreedToTerms, accountType]);

  const handleSocialLogin = (provider: string) => {
    if (provider === "google") {
      window.location.href = "http://localhost:3000/api/auth/google";
    } else if (provider === "facebook") {
      window.location.href = "http://localhost:3000/api/auth/facebook";
    } else if (provider === "twitter") {
      window.location.href = "http://localhost:3000/api/auth/twitter";
    } else {
      toast.info(`${provider.charAt(0).toUpperCase() + provider.slice(1)} login is coming soon!`);
    }
  };

  return (
    <div className="min-h-screen bg-[#0a0a0c] flex flex-col font-sans selection:bg-blue-500/30">
      <div className="flex-1 flex justify-center items-center p-4 sm:p-8">
        
        <div className="w-full max-w-xl bg-[#0a0a0c] border border-[#24262f] rounded-3xl p-6 sm:p-10 shadow-2xl relative overflow-hidden">
          <div className="absolute top-0 left-0 right-0 h-1 bg-linear-to-r from-blue-500 via-indigo-500 to-purple-500" />
          
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.5 }}
          >
            <div className="mb-8 text-center">
              <Link to="/" className="inline-flex items-center justify-center w-12 h-12 rounded-xl bg-blue-500/10 mb-6 hover:bg-blue-500/20 transition-colors">
                 <Building2 className="w-6 h-6 text-blue-500" />
              </Link>
              <h2 className="text-3xl sm:text-4xl font-bold text-white mb-3 tracking-tight">
                {t("client.src.create_account")}
              </h2>
              <p className="text-slate-400 text-sm sm:text-base">
                {t("client.src.join_us_today_and")}
              </p>
            </div>

            {leadId && (
              <motion.div
                initial={{ opacity: 0, y: -10 }}
                animate={{ opacity: 1, y: 0 }}
                className="mb-8 p-4 sm:p-5 rounded-2xl bg-linear-to-r from-blue-500/15 to-indigo-500/15 border border-blue-500/25 backdrop-blur-md"
              >
                <div className="flex gap-4">
                  <div className="w-10 h-10 rounded-xl bg-blue-500/25 flex items-center justify-center shrink-0">
                    <Zap className="text-blue-400 w-5 h-5 animate-pulse" />
                  </div>
                  <div>
                    <h4 className="text-white font-bold text-sm tracking-wide">💼 Eşleşen Müşteri Talebiniz Hazır!</h4>
                    <p className="text-slate-300 text-xs mt-1.5 leading-relaxed">
                      Kayıt işleminizi tamamlayarak hazır müşterinizle <b>Taksitli Depozito</b> vb. avantajlarla güvenli sözleşme sürecini hemen başlatabilirsiniz.
                    </p>
                  </div>
                </div>
              </motion.div>
            )}

            <Tabs 
              defaultValue="INDIVIDUAL" 
              className="w-full mb-8"
              onValueChange={(val) => setAccountType(val as any)}
            >
              <TabsList className="grid w-full grid-cols-2 h-14 bg-[#14151a] border border-[#24262f] rounded-2xl p-1 mb-2">
                <TabsTrigger 
                  value="INDIVIDUAL" 
                  className="rounded-xl data-[state=active]:bg-blue-600 data-[state=active]:text-white text-slate-400 transition-all"
                >
                  <User className="w-4 h-4 mr-2" />
                  Bireysel
                </TabsTrigger>
                <TabsTrigger 
                  value="CORPORATE" 
                  className="rounded-xl data-[state=active]:bg-blue-600 data-[state=active]:text-white text-slate-400 transition-all"
                >
                  <Building2 className="w-4 h-4 mr-2" />
                  Kurumsal
                </TabsTrigger>
              </TabsList>
              <p className="text-center text-xs text-slate-500 mt-2">
                {accountType === "INDIVIDUAL" ? "Kiracı veya bireysel kullanıcılar için" : "Ev sahipleri, emlak ofisleri ve işletmeler için"}
              </p>
            </Tabs>

            <form onSubmit={handleSubmit} className="space-y-5">
              
              <AnimatePresence mode="popLayout">
                {accountType === "CORPORATE" && (
                  <motion.div
                    initial={{ opacity: 0, height: 0 }}
                    animate={{ opacity: 1, height: "auto" }}
                    exit={{ opacity: 0, height: 0 }}
                    className="space-y-5 overflow-hidden"
                  >
                    <div className="grid grid-cols-1 sm:grid-cols-2 gap-5 pt-2">
                      <div className="space-y-2">
                        <Label className="text-slate-300 font-medium ml-1">Kurum Tipi</Label>
                        <Select 
                          value={formData.corporateType} 
                          onValueChange={(val) => handleInputChange("corporateType", val)}
                        >
                          <SelectTrigger className="bg-[#14151a] border-[#24262f] h-12 rounded-xl text-slate-200">
                            <SelectValue placeholder="Kurum Tipi Seçin" />
                          </SelectTrigger>
                          <SelectContent className="bg-[#14151a] border-[#24262f] text-white">
                            <SelectItem value="OWNER_PORTFOLIO">Şirket / Ev Sahibi</SelectItem>
                            <SelectItem value="AGENCY">Emlak Ofisi</SelectItem>
                            <SelectItem value="HOTEL">Otel / Tesis</SelectItem>
                            <SelectItem value="OTHER">Diğer</SelectItem>
                          </SelectContent>
                        </Select>
                      </div>
                      <div className="space-y-2">
                        <Label htmlFor="organizationName" className="text-slate-300 font-medium ml-1">Kurum / Şirket Adı <span className="text-red-500">*</span></Label>
                        <Input
                          id="organizationName"
                          placeholder="Örn: Vizyon Gayrimenkul"
                          value={formData.organizationName}
                          onChange={(e) => handleInputChange("organizationName", e.target.value)}
                          className="bg-[#14151a] border-[#24262f] hover:border-slate-700 focus:border-blue-500 h-12 text-slate-200 placeholder:text-slate-600 rounded-xl"
                          required={accountType === "CORPORATE"}
                        />
                      </div>
                    </div>
                  </motion.div>
                )}
              </AnimatePresence>

              <div className="grid grid-cols-1 sm:grid-cols-2 gap-5">
                <div className="space-y-2">
                  <Label htmlFor="name" className="text-slate-300 font-medium ml-1">{t("client.src.full_name")}</Label>
                  <Input
                    id="name"
                    placeholder={t("client.src.eg_john_doe")}
                    value={formData.name}
                    onChange={(e) => handleInputChange("name", e.target.value)}
                    className="bg-[#14151a] border-[#24262f] hover:border-slate-700 focus:border-blue-500 h-12 text-slate-200 rounded-xl"
                    required
                  />
                </div>
                <div className="space-y-2">
                  <Label htmlFor="phone" className="text-slate-300 font-medium ml-1">{t("client.src.phone_number")}</Label>
                  <Input
                    id="phone"
                    type="tel"
                    placeholder="+1 (555) 000 00 00"
                    value={formData.phone}
                    onChange={(e) => handleInputChange("phone", e.target.value)}
                    className="bg-[#14151a] border-[#24262f] hover:border-slate-700 focus:border-blue-500 h-12 text-slate-200 rounded-xl"
                  />
                </div>
              </div>

              <div className="space-y-2">
                <Label htmlFor="email" className="text-slate-300 font-medium ml-1">{t("client.src.email_address")}</Label>
                <Input
                  id="email"
                  type="email"
                  placeholder={t("client.src.johnexamplecom")}
                  value={formData.email}
                  onChange={(e) => handleInputChange("email", e.target.value)}
                  className="bg-[#14151a] border-[#24262f] hover:border-slate-700 focus:border-blue-500 h-12 text-slate-200 rounded-xl"
                  required
                />
              </div>

              <div className="grid grid-cols-1 sm:grid-cols-2 gap-5">
                <div className="space-y-2 relative">
                  <Label htmlFor="password" className="text-slate-300 font-medium ml-1">{t("client.src.password")}</Label>
                  <div className="relative">
                    <Input
                      id="password"
                      type={showPassword ? "text" : "password"}
                      placeholder="••••••••"
                      value={formData.password}
                      onChange={(e) => handleInputChange("password", e.target.value)}
                      className="bg-[#14151a] border-[#24262f] hover:border-slate-700 focus:border-blue-500 h-12 pr-11 text-slate-200 rounded-xl"
                      required
                    />
                    <button
                      type="button"
                      onClick={() => setShowPassword(!showPassword)}
                      className="absolute right-4 top-1/2 -translate-y-1/2 text-slate-500 hover:text-slate-300 transition-colors"
                    >
                      {showPassword ? <EyeOff size={18} /> : <Eye size={18} />}
                    </button>
                  </div>
                </div>
                <div className="space-y-2 relative">
                  <Label htmlFor="confirmPassword" className="text-slate-300 font-medium ml-1">{t("client.src.confirm_password")}</Label>
                  <div className="relative">
                    <Input
                      id="confirmPassword"
                      type={showConfirmPassword ? "text" : "password"}
                      placeholder="••••••••"
                      value={formData.confirmPassword}
                      onChange={(e) => handleInputChange("confirmPassword", e.target.value)}
                      className="bg-[#14151a] border-[#24262f] hover:border-slate-700 focus:border-blue-500 h-12 pr-11 text-slate-200 rounded-xl"
                      required
                    />
                    <button
                      type="button"
                      onClick={() => setShowConfirmPassword(!showConfirmPassword)}
                      className="absolute right-4 top-1/2 -translate-y-1/2 text-slate-500 hover:text-slate-300 transition-colors"
                    >
                      {showConfirmPassword ? <EyeOff size={18} /> : <Eye size={18} />}
                    </button>
                  </div>
                </div>
              </div>

              <div className="flex items-start gap-3 pl-1 pt-2">
                <div className="relative flex items-center h-5">
                  <input
                    type="checkbox"
                    id="terms"
                    checked={agreedToTerms}
                    onChange={(e) => setAgreedToTerms(e.target.checked)}
                    className="w-4.5 h-4.5 rounded text-blue-600 bg-[#14151a] border-[#24262f] focus:ring-blue-500/20 cursor-pointer"
                  />
                </div>
                <Label htmlFor="terms" className="text-sm text-slate-400 leading-tight select-none cursor-pointer">
                  {t("client.src.i_have_read_and")}
                  <Link to="/terms" className="text-blue-400 hover:text-blue-300 transition-colors mx-1 font-medium">{t("client.src.terms_of_use")}</Link>
                  {t("client.src.and")}
                  <Link to="/privacy" className="text-blue-400 hover:text-blue-300 transition-colors ml-1 font-medium">{t("client.src.privacy_policy")}</Link>.
                </Label>
              </div>

              {error && (
                <Alert variant="destructive" className="bg-red-500/10 border-red-500/20 rounded-xl">
                  <AlertCircle className="h-4 w-4 text-red-400" />
                  <AlertDescription className="text-red-400 text-sm font-medium">{error}</AlertDescription>
                </Alert>
              )}

              <Button
                type="submit"
                className="w-full h-14 bg-linear-to-r from-blue-600 to-indigo-600 hover:from-blue-500 hover:to-indigo-500 text-white font-bold text-base rounded-xl transition-all shadow-xl shadow-blue-600/20 group relative overflow-hidden mt-4"
                disabled={!isFormValid || loading || isLoading}
              >
                <span className="relative z-10 flex items-center justify-center gap-2">
                  {loading || isLoading ? "İşleniyor..." : (
                    <>{t("client.src.create_account")}<ChevronRight className="w-5 h-5 group-hover:translate-x-1 transition-transform" /></>
                  )}
                </span>
                <div className="absolute inset-0 bg-linear-to-r from-white/0 via-white/10 to-white/0 -translate-x-full group-hover:animate-[shimmer_1.5s_infinite]" />
              </Button>
            </form>

            <div className="relative my-8 py-2">
              <div className="absolute inset-0 flex items-center">
                <div className="w-full border-t border-[#24262f]"></div>
              </div>
              <div className="relative flex justify-center text-xs">
                <span className="bg-[#0a0a0c] px-4 text-slate-500 font-bold tracking-widest">{t("client.src.or_continue_with")}</span>
              </div>
            </div>

            <div className="grid grid-cols-4 gap-3">
              <Button type="button" variant="outline" className="h-12 bg-[#14151a] border-[#24262f] hover:bg-slate-800/40 text-slate-300 rounded-xl transition-all group px-0" onClick={() => handleSocialLogin("github")}>
                <Github className="h-5 w-5 group-hover:text-white transition-colors" />
              </Button>
              <Button type="button" variant="outline" className="h-12 bg-[#14151a] border-[#24262f] hover:bg-slate-800/40 text-slate-300 rounded-xl transition-all group px-0" onClick={() => handleSocialLogin("google")}>
                <GoogleIcon className="h-5 w-5 group-hover:text-white transition-colors" />
              </Button>
              <Button type="button" variant="outline" className="h-12 bg-[#14151a] border-[#24262f] hover:bg-slate-800/40 text-slate-300 rounded-xl transition-all group px-0" onClick={() => handleSocialLogin("facebook")}>
                <Facebook className="h-5 w-5 group-hover:text-white transition-colors" />
              </Button>
              <Button type="button" variant="outline" className="h-12 bg-[#14151a] border-[#24262f] hover:bg-slate-800/40 text-slate-300 rounded-xl transition-all group px-0" onClick={() => handleSocialLogin("twitter")}>
                <Twitter className="h-5 w-5 group-hover:text-white transition-colors" />
              </Button>
            </div>

            <p className="text-center text-slate-400 mt-8">
              {t("client.src.already_have_an_account")}{" "}
              <Link to="/login" className="text-white hover:text-blue-400 transition-all font-bold underline underline-offset-4 decoration-slate-700 hover:decoration-blue-500">{t("client.src.log_in")}</Link>
            </p>
          </motion.div>
        </div>
      </div>
    </div>
  );
}