"use client";

import { useTranslation } from "react-i18next";
import { useState, useMemo, useEffect } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Link, useNavigate, useSearchParams } from "@/lib/react-router-shim";
import { m, AnimatePresence } from "framer-motion";
import { Mail, Eye, EyeOff, AlertCircle, Check, Zap, ChevronRight, Facebook, Twitter, Building2, User, Linkedin } from "lucide-react";
import { Alert, AlertDescription } from "@/components/ui/alert";
import { useAuth } from "@/lib/auth/hooks";
import { AuthUtils } from "@/lib/auth/utils";
import { toast } from "sonner";
import { Tabs, TabsList, TabsTrigger, TabsContent } from "@/components/ui/tabs";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
const API_BASE_URL = process.env.NEXT_PUBLIC_API_URL || "https://reservatior.com";

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
  const [accountType, setAccountType] = useState<"INDIVIDUAL" | "CORPORATE">(() => {
    if (typeof window !== "undefined") {
      const saved = localStorage.getItem("signupAccountType");
      if (saved === "INDIVIDUAL" || saved === "CORPORATE") {
        return saved;
      }
    }
    return "INDIVIDUAL";
  });
  
  const [formData, setFormData] = useState(() => {
    if (typeof window !== "undefined") {
      const saved = localStorage.getItem("signupFormData");
      if (saved) {
        try {
          return JSON.parse(saved);
        } catch {
          return {
            email: "",
            password: "",
            confirmPassword: "",
            name: "",
            phone: "",
            organizationName: "",
            corporateType: "OWNER_PORTFOLIO"
          };
        }
      }
    }
    return {
      email: "",
      password: "",
      confirmPassword: "",
      name: "",
      phone: "",
      organizationName: "",
      corporateType: "OWNER_PORTFOLIO"
    };
  });

  const [showPassword, setShowPassword] = useState(false);
  const [showConfirmPassword, setShowConfirmPassword] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  const [agreedToTerms, setAgreedToTerms] = useState(() => {
    if (typeof window !== "undefined") {
      const saved = localStorage.getItem("signupAgreedToTerms");
      return saved === "true";
    }
    return false;
  });
  
  const { register, loading, error } = useAuth();
  const navigate = useNavigate();
  const searchParams = useSearchParams() ?? new URLSearchParams();
  const promoCode = searchParams?.get("promo") || undefined;
  const leadId = searchParams?.get("leadId");

  const handleInputChange = (field: string, value: string) => {
    setFormData((prev: any) => ({
      ...prev,
      [field]: value,
    }));
  };

  useEffect(() => {
    localStorage.setItem("signupFormData", JSON.stringify(formData));
  }, [formData]);

  useEffect(() => {
    localStorage.setItem("signupAccountType", accountType);
  }, [accountType]);

  useEffect(() => {
    localStorage.setItem("signupAgreedToTerms", agreedToTerms.toString());
  }, [agreedToTerms]);

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
      localStorage.removeItem("signupFormData");
      localStorage.removeItem("signupAccountType");
      localStorage.removeItem("signupAgreedToTerms");
      navigate("/dashboard");
    } catch (err: any) {
      toast.error(err?.message || "Kayıt olurken bir hata oluştu");
    } finally {
      setIsLoading(false);
    }
  };

  const isFormValid = useMemo(() => {
    const hasBasicFields = formData.email && formData.password && formData.name && formData.confirmPassword && agreedToTerms;
    const hasCorpFields = accountType === "CORPORATE" ? !!formData.organizationName : true;
    return hasBasicFields && hasCorpFields;
  }, [formData, agreedToTerms, accountType]);

  const handleSocialLogin = (provider: string) => {
    window.location.href = `${API_BASE_URL}/api/v1/auth/${provider}?origin=${encodeURIComponent(process.env.NEXT_PUBLIC_SITE_URL || window.location.origin)}`;
  };

  return (
    <div className="min-h-screen bg-background relative overflow-hidden flex flex-col font-sans selection:bg-primary/30">
      
      {/* Background Blobs for modern aesthetic */}
      <div className="absolute top-0 left-0 w-full h-full overflow-hidden pointer-events-none -z-10">
        <div className="absolute top-1/4 right-1/4 w-96 h-96 bg-info/10 dark:bg-info/20 rounded-full blur-3xl" />
        <div className="absolute bottom-1/4 left-1/4 w-96 h-96 bg-brand/10 dark:bg-brand/20 rounded-full blur-3xl" />
      </div>

      <div className="flex-1 flex justify-center items-center p-4 sm:p-8 pt-16">
        
        <div className="w-full max-w-xl bg-card/90 backdrop-blur-xl border border-border rounded-[2rem] p-6 sm:p-10 shadow-2xl relative overflow-hidden">
          <div className="absolute top-0 left-0 right-0 h-1 bg-gradient-to-r from-blue-500 via-indigo-500 to-brand/100" />
          
          <m.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.5, ease: "easeOut" }}
          >
            <div className="mb-8 text-center">
              <Link href="/" aria-label="Go to home page" className="inline-flex items-center justify-center w-12 h-12 rounded-xl bg-primary/10 mb-6 hover:bg-primary/20 transition-colors">
                 <Building2 className="w-6 h-6 text-primary" />
              </Link>
              <h2 className="text-3xl sm:text-4xl font-bold text-foreground mb-3 tracking-tight">
                {t("auth.signup.create_account", "Create Account")}
              </h2>
              <p className="text-muted-foreground text-sm sm:text-base">
                Join us today
              </p>
            </div>

            {leadId && (
              <m.div
                initial={{ opacity: 0, y: -10 }}
                animate={{ opacity: 1, y: 0 }}
                className="mb-8 p-4 sm:p-5 rounded-2xl bg-gradient-to-r from-blue-500/10 to-info/10 border border-blue-500/20 backdrop-blur-md"
              >
                <div className="flex gap-4">
                  <div className="w-10 h-10 rounded-xl bg-brand/100/20 flex items-center justify-center shrink-0">
                    <Zap className="text-brand w-5 h-5 animate-pulse" />
                  </div>
                  <div>
                    <h3 className="text-foreground font-bold text-sm tracking-wide">💼 Eşleşen Müşteri Talebiniz Hazır!</h3>
                    <p className="text-muted-foreground text-xs mt-1.5 leading-relaxed">
                      Kayıt işleminizi tamamlayarak hazır müşterinizle <b>Taksitli Depozito</b> vb. avantajlarla güvenli sözleşme sürecini hemen başlatabilirsiniz.
                    </p>
                  </div>
                </div>
              </m.div>
            )}

            <Tabs 
              defaultValue={accountType} 
              className="w-full mb-8"
              onValueChange={(val) => setAccountType(val as any)}
            >
              <TabsList className="grid w-full grid-cols-2 h-14 bg-background border border-border rounded-2xl p-1 mb-2">
                <TabsTrigger 
                  value="INDIVIDUAL" 
                  className="rounded-xl data-[state=active]:bg-primary data-[state=active]:text-primary-foreground text-muted-foreground transition-all"
                >
                  <User className="w-4 h-4 mr-2" />
                  Bireysel
                </TabsTrigger>
                <TabsTrigger 
                  value="CORPORATE" 
                  className="rounded-xl data-[state=active]:bg-primary data-[state=active]:text-primary-foreground text-muted-foreground transition-all"
                >
                  <Building2 className="w-4 h-4 mr-2" />
                  Kurumsal
                </TabsTrigger>
              </TabsList>
              <p className="text-center text-xs text-muted-foreground mt-2">
                {accountType === "INDIVIDUAL" ? "Kiracı veya bireysel kullanıcılar için" : "Ev sahipleri, emlak ofisleri ve işletmeler için"}
              </p>
            </Tabs>

            <form onSubmit={handleSubmit} className="space-y-5">
              
              <AnimatePresence mode="popLayout">
                {accountType === "CORPORATE" && (
                  <m.div
                    initial={{ opacity: 0, height: 0 }}
                    animate={{ opacity: 1, height: "auto" }}
                    exit={{ opacity: 0, height: 0 }}
                    className="space-y-5 overflow-hidden"
                  >
                    <div className="grid grid-cols-1 sm:grid-cols-2 gap-5 pt-2">
                      <div className="space-y-2.5">
                        <Label className="text-foreground font-medium ml-1">Kurum Tipi</Label>
                        <Select 
                          value={formData.corporateType} 
                          onValueChange={(val) => handleInputChange("corporateType", val)}
                        >
                          <SelectTrigger className="bg-background border-input focus:ring-primary/50 focus:border-primary h-12 rounded-xl text-foreground">
                            <SelectValue placeholder="Kurum Tipi Seçin" />
                          </SelectTrigger>
                          <SelectContent className="bg-popover border-border text-popover-foreground">
                            <SelectItem value="OWNER_PORTFOLIO">Şirket / Ev Sahibi</SelectItem>
                            <SelectItem value="AGENCY">Emlak Ofisi</SelectItem>
                            <SelectItem value="HOTEL">Otel / Tesis</SelectItem>
                            <SelectItem value="OTHER">Diğer</SelectItem>
                          </SelectContent>
                        </Select>
                      </div>
                      <div className="space-y-2.5">
                        <Label htmlFor="organizationName" className="text-foreground font-medium ml-1">Kurum / Şirket Adı <span className="text-destructive">*</span></Label>
                        <Input
                          id="organizationName"
                          placeholder="Örn: Vizyon Gayrimenkul"
                          value={formData.organizationName}
                          onChange={(e) => handleInputChange("organizationName", e.target.value)}
                          className="bg-background border-input focus:ring-primary/50 focus:border-primary h-12 text-foreground placeholder:text-muted-foreground rounded-xl"
                          required={accountType === "CORPORATE"}
                        />
                      </div>
                    </div>
                  </m.div>
                )}
              </AnimatePresence>

              <div className="grid grid-cols-1 sm:grid-cols-2 gap-5">
                <div className="space-y-2.5">
                  <Label htmlFor="name" className="text-foreground font-medium ml-1">Full Name</Label>
                  <Input
                    id="name"
                    placeholder="e.g. John Doe"
                    value={formData.name}
                    onChange={(e) => handleInputChange("name", e.target.value)}
                    className="bg-background border-input focus:ring-primary/50 focus:border-primary h-12 text-foreground placeholder:text-muted-foreground rounded-xl"
                    required
                  />
                </div>
                <div className="space-y-2.5">
                  <Label htmlFor="phone" className="text-foreground font-medium ml-1">Phone Number</Label>
                  <Input
                    id="phone"
                    type="tel"
                    placeholder="+1 (555) 000 00 00"
                    value={formData.phone}
                    onChange={(e) => handleInputChange("phone", e.target.value)}
                    className="bg-background border-input focus:ring-primary/50 focus:border-primary h-12 text-foreground placeholder:text-muted-foreground rounded-xl"
                  />
                </div>
              </div>

              <div className="space-y-2.5">
                <Label htmlFor="email" className="text-foreground font-medium ml-1">Email Address</Label>
                <Input
                  id="email"
                  type="email"
                  placeholder="john@example.com"
                  value={formData.email}
                  onChange={(e) => handleInputChange("email", e.target.value)}
                  className="bg-background border-input focus:ring-primary/50 focus:border-primary h-12 text-foreground placeholder:text-muted-foreground rounded-xl"
                  required
                />
              </div>

              <div className="grid grid-cols-1 sm:grid-cols-2 gap-5">
                <div className="space-y-2.5 relative">
                  <Label htmlFor="password" className="text-foreground font-medium ml-1">Password</Label>
                  <div className="relative">
                    <Input
                      id="password"
                      type={showPassword ? "text" : "password"}
                      placeholder="••••••••"
                      value={formData.password}
                      onChange={(e) => handleInputChange("password", e.target.value)}
                      className="bg-background border-input focus:ring-primary/50 focus:border-primary h-12 pr-12 text-foreground placeholder:text-muted-foreground rounded-xl"
                      required
                    />
                    <button
                      type="button"
                      onClick={() => setShowPassword(!showPassword)}
                      className="absolute right-1 top-1 h-10 w-10 flex items-center justify-center rounded-lg text-muted-foreground hover:bg-accent hover:text-foreground transition-colors"
                    >
                      {showPassword ? <EyeOff size={18} /> : <Eye size={18} />}
                    </button>
                  </div>
                </div>
                <div className="space-y-2.5 relative">
                  <Label htmlFor="confirmPassword" className="text-foreground font-medium ml-1">Confirm Password</Label>
                  <div className="relative">
                    <Input
                      id="confirmPassword"
                      type={showConfirmPassword ? "text" : "password"}
                      placeholder="••••••••"
                      value={formData.confirmPassword}
                      onChange={(e) => handleInputChange("confirmPassword", e.target.value)}
                      className="bg-background border-input focus:ring-primary/50 focus:border-primary h-12 pr-12 text-foreground placeholder:text-muted-foreground rounded-xl"
                      required
                    />
                    <button
                      type="button"
                      onClick={() => setShowConfirmPassword(!showConfirmPassword)}
                      className="absolute right-1 top-1 h-10 w-10 flex items-center justify-center rounded-lg text-muted-foreground hover:bg-accent hover:text-foreground transition-colors"
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
                    className="w-4.5 h-4.5 rounded text-primary bg-background border-input focus:ring-primary/50 cursor-pointer"
                  />
                </div>
                <Label htmlFor="terms" className="text-sm text-muted-foreground leading-tight select-none cursor-pointer">
                  I have read and
                  <Link to="/terms" className="text-primary hover:text-primary/80 transition-colors mx-1 font-medium">Terms of Use</Link>
                  and
                  <Link to="/privacy" className="text-primary hover:text-primary/80 transition-colors ml-1 font-medium">Privacy Policy</Link>.
                </Label>
              </div>

              {error && (
                <Alert variant="destructive" className="bg-destructive/10 border-destructive/20 rounded-xl">
                  <AlertCircle className="h-4 w-4 text-destructive" />
                  <AlertDescription className="text-destructive text-sm font-medium">{error}</AlertDescription>
                </Alert>
              )}

              <Button
                type="submit"
                className="w-full h-14 bg-gradient-to-r from-brand to-info hover:from-blue-700 hover:to-info text-white font-bold text-base rounded-xl transition-all shadow-xl shadow-blue-600/20 group relative overflow-hidden mt-4"
                disabled={loading || isLoading}
              >
                <span className="relative z-10 flex items-center justify-center gap-2">
                  {loading || isLoading ? "İşleniyor..." : (
                    <>{t("auth.signup.create_account", "Create Account")}<ChevronRight className="w-5 h-5 group-hover:translate-x-1 transition-transform" /></>
                  )}
                </span>
                <div className="absolute inset-0 bg-gradient-to-r from-white/0 via-white/10 to-white/0 -translate-x-full group-hover:animate-[shimmer_1.5s_infinite]" />
              </Button>
            </form>

            <div className="relative my-8 py-2">
              <div className="absolute inset-0 flex items-center">
                <div className="w-full border-t border-border"></div>
              </div>
              <div className="relative flex justify-center text-xs">
                <span className="bg-card px-4 text-muted-foreground font-bold tracking-widest uppercase">OR CONTINUE WITH</span>
              </div>
            </div>

            <div className="grid grid-cols-4 gap-3">
              <Button type="button" variant="outline" className="h-12 bg-background border-input hover:bg-accent hover:text-accent-foreground text-foreground rounded-xl transition-all px-0" onClick={() => handleSocialLogin("google")} aria-label={t("common.sign_in_with_google")}>
                <GoogleIcon className="h-5 w-5" />
              </Button>
              <Button type="button" variant="outline" className="h-12 bg-background border-input hover:bg-accent hover:text-accent-foreground text-foreground rounded-xl transition-all px-0" onClick={() => handleSocialLogin("facebook")} aria-label={t("common.sign_in_with_facebook")}>
                <Facebook className="h-5 w-5" />
              </Button>
              <Button type="button" variant="outline" className="h-12 bg-background border-input hover:bg-accent hover:text-accent-foreground text-foreground rounded-xl transition-all px-0" onClick={() => handleSocialLogin("twitter")} aria-label={t("common.sign_in_with_twitter")}>
                <Twitter className="h-5 w-5" />
              </Button>
              <Button type="button" variant="outline" className="h-12 bg-background border-input hover:bg-accent hover:text-accent-foreground text-foreground rounded-xl transition-all px-0" onClick={() => handleSocialLogin("linkedin")} aria-label={t("common.sign_in_with_linkedin")}>
                <Linkedin className="h-5 w-5" />
              </Button>
            </div>

            <p className="text-center text-muted-foreground mt-8">
              Already have an account?{" "}
              <Link to="/client/login" className="text-foreground hover:text-primary transition-all font-bold underline underline-offset-4 decoration-border hover:decoration-primary">Log in</Link>
            </p>
          </m.div>
        </div>
      </div>

    </div>
  );
}