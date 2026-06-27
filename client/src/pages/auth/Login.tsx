import { useTranslation } from "react-i18next";
import { useState, useMemo } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Link, useNavigate } from "react-router-dom";
import { motion } from "framer-motion";
import { Github, Mail, Eye, EyeOff, AlertCircle, Facebook, Twitter } from "lucide-react";
import { useAuth } from "@/lib/auth/hooks";
import { Alert, AlertDescription } from "@/components/ui/alert";
import { Header } from "@/components/home/Header";
import { toast } from "sonner";
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
  const handleSocialLogin = (provider: string) => {
    if (provider === 'google') {
      window.location.href = "http://localhost:3000/api/auth/google";
    } else if (provider === 'facebook') {
      window.location.href = "http://localhost:3000/api/auth/facebook";
    } else if (provider === 'twitter') {
      window.location.href = "http://localhost:3000/api/auth/twitter";
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
          <div className="absolute top-0 inset-x-0 h-px bg-linear-to-r from-transparent via-blue-500/50 to-transparent"></div>
          
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

          <div className="grid grid-cols-4 gap-4">
            <Button variant="outline" className="h-11 bg-[#1b1c22] border-slate-800 hover:bg-slate-800 text-slate-300 rounded-xl transition-all px-0" onClick={() => handleSocialLogin("github")} disabled={loading || isLoading}>
              <Github className="h-4 w-4" /></Button>
            <Button variant="outline" className="h-11 bg-[#1b1c22] border-slate-800 hover:bg-slate-800 text-slate-300 rounded-xl transition-all px-0" onClick={() => handleSocialLogin("google")} disabled={loading || isLoading}>
              <Mail className="h-4 w-4" /></Button>
            <Button variant="outline" className="h-11 bg-[#1b1c22] border-slate-800 hover:bg-slate-800 text-slate-300 rounded-xl transition-all px-0" onClick={() => handleSocialLogin("facebook")} disabled={loading || isLoading}>
              <Facebook className="h-4 w-4" /></Button>
            <Button variant="outline" className="h-11 bg-[#1b1c22] border-slate-800 hover:bg-slate-800 text-slate-300 rounded-xl transition-all px-0" onClick={() => handleSocialLogin("twitter")} disabled={loading || isLoading}>
              <Twitter className="h-4 w-4" /></Button>
          </div>

          <p className="text-center text-sm text-slate-400 mt-8">{t("client.src.dont_have_an_account")}{" "}
            <Link to="/signup" className="text-blue-400 hover:text-blue-300 hover:underline transition-colors font-medium">{t("client.src.sign_up_now")}</Link>
          </p>
        </motion.div>
      </div>
    </div>;
}