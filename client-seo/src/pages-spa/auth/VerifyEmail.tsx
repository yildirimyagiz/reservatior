"use client";

import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { useNavigate, useSearchParams } from "@/lib/react-router-shim";
import { motion } from "framer-motion";
import { CheckCircle, XCircle, Loader2 } from "lucide-react";
import { Button } from "@/components/ui/button";
import { apiClient } from "@/lib/api/client";
import { Header } from "@/components/home/Header";
export default function VerifyEmail() {
  const {
    t
  } = useTranslation();
  const [status, setStatus] = useState<"loading" | "success" | "error">("loading");
  const [searchParams] = useSearchParams();
  const navigate = useNavigate();
  const token = searchParams.get("token");
  useEffect(() => {
    const verify = async () => {
      if (!token) {
        setStatus("error");
        return;
      }
      try {
        await apiClient.post("/auth/verify-email", {
          token
        });
        setStatus("success");
      } catch (error) {
        setStatus("error");
      }
    };
    verify();
  }, [token]);
  return <div className="min-h-screen bg-background flex flex-col">
      <Header />
      <div className="flex-1 flex items-center justify-center p-4">
        <motion.div initial={{
        opacity: 0,
        scale: 0.95
      }} animate={{
        opacity: 1,
        scale: 1
      }} className="w-full max-w-md bg-[#14151a]/80 backdrop-blur-xl border border-slate-800/50 p-8 rounded-3xl shadow-2xl relative text-center">
          <div className="absolute top-0 inset-x-0 h-px bg-gradient-to-r from-transparent via-blue-500/50 to-transparent"></div>

          {status === "loading" && <div className="py-8">
              <Loader2 className="w-12 h-12 text-blue-500 animate-spin mx-auto mb-4" />
              <h2 className="text-2xl font-bold text-white mb-2">{t("client.src.verifying_your_email")}</h2>
              <p className="text-slate-400">{t("client.src.please_wait_while_we")}</p>
            </div>}

          {status === "success" && <div className="py-8">
              <div className="w-16 h-16 bg-green-500/20 rounded-2xl flex items-center justify-center mx-auto mb-6">
                <CheckCircle className="w-8 h-8 text-green-500" />
              </div>
              <h2 className="text-2xl font-bold text-white mb-2">{t("client.src.email_verified")}</h2>
              <p className="text-slate-400 mb-8">{t("client.src.your_email_has_been")}</p>
              <Button onClick={() => navigate("/login")} className="w-full h-11 bg-blue-600 hover:bg-blue-700 text-white rounded-xl shadow-lg shadow-blue-600/20">{t("client.src.continue_to_login")}</Button>
            </div>}

          {status === "error" && <div className="py-8">
              <div className="w-16 h-16 bg-red-500/20 rounded-2xl flex items-center justify-center mx-auto mb-6">
                <XCircle className="w-8 h-8 text-red-500" />
              </div>
              <h2 className="text-2xl font-bold text-white mb-2">{t("client.src.verification_failed")}</h2>
              <p className="text-slate-400 mb-8">{t("client.src.we_couldnt_verify_your")}</p>
              <Button onClick={() => navigate("/signup")} className="w-full h-11 bg-slate-800 hover:bg-slate-700 text-white rounded-xl mb-3">{t("client.src.back_to_sign_up")}</Button>
            </div>}
        </motion.div>
      </div>
    </div>;
}