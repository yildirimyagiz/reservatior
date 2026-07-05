"use client";

import { useTranslation } from "react-i18next";
import { useState } from "react";
import { Link, useNavigate } from "@/lib/react-router-shim";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Alert, AlertDescription } from "@/components/ui/alert";
import { motion } from "framer-motion";
import { ArrowLeft, Mail, CheckCircle } from "lucide-react";
import { apiClient } from "@/lib/api/client";
import { Header } from "@/components/home/Header";
export default function ForgotPassword() {
  const {
    t
  } = useTranslation();
  const [email, setEmail] = useState("");
  const [isSubmitted, setIsSubmitted] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  const navigate = useNavigate();
  const [error, setError] = useState<string | null>(null);
  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsLoading(true);
    setError(null);
    try {
      await apiClient.post("/auth/forgot-password", {
        email
      });
      setIsSubmitted(true);
    } catch (err) {
      setError("Failed to send reset email. Please try again.");
    } finally {
      setIsLoading(false);
    }
  };
  if (isSubmitted) {
    return <div className="min-h-screen bg-background flex flex-col">
        <Header />
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
            
            <div className="text-center">
              <div className="w-16 h-16 bg-green-500/20 rounded-2xl flex items-center justify-center mx-auto mb-6">
                <CheckCircle className="w-8 h-8 text-green-500" />
              </div>
              <h2 className="text-2xl font-bold mb-2 text-white">{t("client.src.check_your_email")}</h2>
              <p className="text-slate-400 mb-8">{t("client.src.weve_sent_a_password")}<strong className="text-white">{email}</strong>{t("client.src.please_check_your_email")}</p>
              <div className="space-y-3">
                <Button onClick={() => navigate("/login")} className="w-full h-11 bg-blue-600 hover:bg-blue-700 text-white rounded-xl shadow-lg shadow-blue-600/20 transition-all font-medium">{t("client.src.back_to_login")}</Button>
                <Button variant="ghost" onClick={() => setIsSubmitted(false)} className="w-full h-11 text-slate-400 hover:text-white hover:bg-slate-800/50 rounded-xl">{t("client.src.send_another_email")}</Button>
              </div>
            </div>
          </motion.div>
        </div>
      </div>;
  }
  return <div className="min-h-screen bg-background flex flex-col">
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

          {/* Back Button */}
          <div className="mb-6 -mt-2">
            <Button variant="ghost" size="sm" className="text-slate-400 hover:text-white hover:bg-slate-800/50 -ml-2" onClick={() => navigate("/login")}>
              <ArrowLeft className="w-4 h-4 mr-2" />{t("client.src.back_to_login")}</Button>
          </div>

          <div className="text-center mb-8">
            <div className="w-16 h-16 bg-blue-600/10 border border-blue-500/20 rounded-2xl flex items-center justify-center mx-auto mb-4">
              <Mail className="w-8 h-8 text-blue-500" />
            </div>
            <h2 className="text-3xl font-display font-bold mb-2 text-white tracking-tight">{t("client.src.forgot_password")}</h2>
            <p className="text-slate-400 font-medium">{t("client.src.enter_your_email_address")}</p>
          </div>

          {error && <Alert className="mb-6 bg-red-500/10 border-red-500/20 text-red-400" variant="destructive">
              <AlertDescription>{error}</AlertDescription>
            </Alert>}

          <form onSubmit={handleSubmit} className="space-y-6">
            <div className="space-y-2">
              <Label htmlFor="email" className="text-slate-200">{t("client.src.email_address")}</Label>
              <Input id="email" type="email" placeholder={t("client.src.enter_your_email")} value={email} onChange={e => setEmail(e.target.value)} className="bg-[#1b1c22] border-slate-800 focus:ring-blue-500/50 h-11 text-slate-200 placeholder:text-slate-500 rounded-xl transition-all" required disabled={isLoading} />
            </div>

            <Button type="submit" className="w-full h-11 bg-blue-600 hover:bg-blue-700 text-white font-medium rounded-xl transition-all shadow-lg shadow-blue-600/20" disabled={!email || isLoading}>
              {isLoading ? "Sending..." : "Send Reset Link"}
            </Button>
          </form>

          <div className="mt-8 text-center">
            <p className="text-sm text-slate-400">{t("client.src.remember_your_password")}{" "}
              <Link to="/client/login" className="text-blue-400 hover:text-blue-300 hover:underline transition-colors font-medium">{t("client.src.sign_in")}</Link>
            </p>
          </div>
        </motion.div>
      </div>
    </div>;
}