import { useTranslation } from "react-i18next";
import { useState, useMemo } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Link, useNavigate } from "react-router-dom";
import { motion } from "framer-motion";
import { Github, Mail, Eye, EyeOff, AlertCircle, Facebook, Twitter, Linkedin } from "lucide-react";
import { useAuth } from "@/lib/auth/hooks";
import { Alert, AlertDescription } from "@/components/ui/alert";
import { Header } from "@/components/home/Header";
import { toast } from "sonner";

const GoogleIcon = ({ className }: { className?: string }) => (
  <svg viewBox="0 0 24 24" className={className} fill="currentColor" xmlns="http://www.w3.org/2000/svg">
    <path d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z" />
    <path d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" />
    <path d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z" />
    <path d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z" />
  </svg>
);

export default function Login() {
  const {
    t
  } = useTranslation();
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [showPassword, setShowPassword] = useState(false);
  const [rememberMe, setRememberMe] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  const {
    login,
    loading,
    error
  } = useAuth();
  const navigate = useNavigate();
  const isFormValid = useMemo(() => {
    return email.trim() !== "" && password.trim() !== "";
  }, [email, password]);
  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsLoading(true);
    try {
      await login(email, password);
      if (rememberMe) {
        localStorage.setItem("remembered_email", email);
      } else {
        localStorage.removeItem("remembered_email");
      }
      const {
        useUserStore
      } = await import("@/lib/store/user-store");
      const user = useUserStore.getState().user;
      const adminRoles = ['OWNER', 'ORG_ADMIN', 'ADMIN', 'SUPER_ADMIN', 'AGENCY_ADMIN', 'VENDOR_MANAGER', 'ACCOUNTANT'];
      if (user && adminRoles.includes(user.role)) {
        navigate("/admin/dashboard");
      } else if (user?.role === 'TENANT' || user?.role === 'USER' || user?.role === 'TENANT_GUEST') {
        navigate("/");
      } else {
        navigate("/dashboard");
      }
    } catch (err) {
      // Error is handled by the auth hook
    } finally {
      setIsLoading(false);
    }
  };
  const API_BASE = process.env.NEXT_PUBLIC_API_URL || "http://localhost:3000";
  const handleSocialLogin = (provider: string) => {
    if (provider === 'google') {
      window.location.href = `${API_BASE}/api/auth/google`;
    } else if (provider === 'facebook') {
      window.location.href = `${API_BASE}/api/auth/facebook`;
    } else if (provider === 'twitter') {
      window.location.href = `${API_BASE}/api/auth/twitter`;
    } else if (provider === 'linkedin') {
      window.location.href = `${API_BASE}/api/auth/linkedin`;
    } else {
      toast.info(`${provider.charAt(0).toUpperCase() + provider.slice(1)} login is coming soon!`);
    }
  };
  return <div className="min-h-screen bg-background relative overflow-hidden flex flex-col">
      <Header />
      {/* Background Blobs */}
      <div className="absolute top-0 left-0 w-full h-full overflow-hidden -z-10">
        <div className="absolute top-1/4 left-1/4 w-96 h-96 bg-blue-500/20 rounded-full blur-3xl animate-pulse" />
        <div className="absolute bottom-1/4 right-1/4 w-96 h-96 bg-purple-500/20 rounded-full blur-3xl animate-pulse delay-1000" />
      </div>

      <div className="flex-1 flex items-center justify-center p-4">
        <motion.div initial={{
        opacity: 0,
        scale: 0.95
      }} animate={{
        opacity: 1,
        scale: 1
      }} className="w-full max-w-md bg-[#14151a]/80 backdrop-blur-xl border border-slate-800/50 p-8 rounded-3xl shadow-2xl relative">
          {/* Spotlight Effect */}
          <div className="absolute top-0 inset-x-0 h-px bg-gradient-to-r from-transparent via-blue-500/50 to-transparent"></div>
          
          <div className="text-center mb-8">
            <h1 className="text-3xl font-display font-bold mb-2 text-white tracking-tight">{t("client.src.welcome_to_reservatior")}</h1>
            <p className="text-slate-400 font-medium">{t("client.src.intelligence_in_real_estate")}</p>
          </div>

          {error && <Alert variant="destructive" className="mb-6">
              <AlertCircle className="h-4 w-4" />
              <AlertDescription>{error}</AlertDescription>
            </Alert>}

          <form onSubmit={handleSubmit} className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="email">{t("client.src.email_address")}</Label>
              <Input id="email" type="email" placeholder={t("client.src.agentexamplecom")} value={email} onChange={e => setEmail(e.target.value)} className="bg-[#1b1c22] border-slate-800 focus:ring-blue-500/50 h-11 lowercase text-slate-200 placeholder:text-slate-500 rounded-xl transition-all" style={{
              textTransform: 'none'
            }} required disabled={loading || isLoading} />
            </div>

            <div className="space-y-2">
              <div className="flex justify-between">
                <Label htmlFor="password">{t("client.src.password")}</Label>
                <Link to="/forgot-password" className="text-xs text-blue-400 hover:text-blue-300 hover:underline transition-colors">{t("client.src.forgot_password")}</Link>
              </div>
              <div className="relative">
                <Input id="password" type={showPassword ? "text" : "password"} placeholder={t("client.src.enter_your_password")} value={password} onChange={e => setPassword(e.target.value)} className="bg-[#1b1c22] border-slate-800 focus:ring-blue-500/50 h-11 pr-10 text-slate-200 placeholder:text-slate-500 rounded-xl transition-all" style={{
                textTransform: 'none'
              }} required disabled={loading || isLoading} />
                <Button type="button" variant="ghost" size="sm" className="absolute right-0 top-0 h-full px-3 py-2 hover:bg-transparent" onClick={() => setShowPassword(!showPassword)} disabled={loading || isLoading}>
                  {showPassword ? <EyeOff className="h-4 w-4 text-slate-400" /> : <Eye className="h-4 w-4 text-slate-400" />}
                </Button>
              </div>
            </div>

            <div className="flex items-center justify-between">
              <div className="flex items-center space-x-2">
                <input type="checkbox" id="remember" checked={rememberMe} onChange={e => setRememberMe(e.target.checked)} className="w-4 h-4 rounded border-slate-800 bg-[#1b1c22] text-blue-600 focus:ring-blue-500/50" />
                <Label htmlFor="remember" className="text-sm text-slate-400 cursor-pointer">{t("client.src.remember_my_password")}</Label>
              </div>
            </div>

            <Button type="submit" className="w-full h-11 bg-blue-600 hover:bg-blue-700 text-white font-medium mt-2 rounded-xl transition-all shadow-lg shadow-blue-600/20" disabled={!isFormValid || loading || isLoading}>
              {loading || isLoading ? "Signing in..." : "Sign In"}
            </Button>
          </form>

          <div className="relative my-8">
            <div className="absolute inset-0 flex items-center">
              <div className="w-full border-t border-slate-800/50"></div>
            </div>
            <div className="relative flex justify-center text-xs">
              <span className="bg-[#14151a] px-2 text-slate-500 tracking-wider font-semibold">{t("client.src.or_continue_with")}</span>
            </div>
          </div>

          <div className="grid grid-cols-5 gap-3">
            <Button variant="outline" className="h-11 bg-[#1b1c22] border-slate-800 hover:bg-slate-800 text-slate-300 rounded-xl transition-all px-0" onClick={() => handleSocialLogin("github")} disabled={loading || isLoading}>
              <Github className="h-4 w-4" /></Button>
            <Button variant="outline" className="h-11 bg-[#1b1c22] border-slate-800 hover:bg-slate-800 text-slate-300 rounded-xl transition-all px-0" onClick={() => handleSocialLogin("google")} disabled={loading || isLoading}>
              <GoogleIcon className="h-4 w-4" /></Button>
            <Button variant="outline" className="h-11 bg-[#1b1c22] border-slate-800 hover:bg-slate-800 text-slate-300 rounded-xl transition-all px-0" onClick={() => handleSocialLogin("facebook")} disabled={loading || isLoading}>
              <Facebook className="h-4 w-4" /></Button>
            <Button variant="outline" className="h-11 bg-[#1b1c22] border-slate-800 hover:bg-slate-800 text-slate-300 rounded-xl transition-all px-0" onClick={() => handleSocialLogin("twitter")} disabled={loading || isLoading}>
              <Twitter className="h-4 w-4" /></Button>
            <Button variant="outline" className="h-11 bg-[#1b1c22] border-slate-800 hover:bg-slate-800 text-slate-300 rounded-xl transition-all px-0" onClick={() => handleSocialLogin("linkedin")} disabled={loading || isLoading}>
              <Linkedin className="h-4 w-4" /></Button>
          </div>

          <p className="text-center text-sm text-slate-400 mt-8">{t("client.src.dont_have_an_account")}{" "}
            <Link to="/signup" className="text-blue-400 hover:text-blue-300 hover:underline transition-colors font-medium">{t("client.src.sign_up_now")}</Link>
          </p>
        </motion.div>
      </div>
    </div>;
}