"use client";

import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { useNavigate, useSearchParams } from "@/lib/react-router-shim";
import { m } from "framer-motion";
import { CheckCircle, XCircle, Loader2 } from "lucide-react";
import { Button } from "@/components/ui/button";
import { apiClient } from "@/lib/api/client";
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
      
      <div className="flex-1 flex items-center justify-center p-4">
        <m.div initial={{
        opacity: 0,
        scale: 0.95
      }} animate={{
        opacity: 1,
        scale: 1
      }} className="w-full max-w-md bg-background/80 backdrop-blur-xl border border-border/50 p-8 rounded-3xl shadow-2xl relative text-center">
          <div className="absolute top-0 inset-x-0 h-px bg-gradient-to-r from-transparent via-blue-500/50 to-transparent"></div>

          {status === "loading" && <div className="py-8">
              <Loader2 className="w-12 h-12 text-brand animate-spin mx-auto mb-4" />
              <h2 className="text-2xl font-bold text-white mb-2">{t("client.src.verifying_your_email")}</h2>
              <p className="text-muted-foreground">{t("client.src.please_wait_while_we")}</p>
            </div>}

          {status === "success" && <div className="py-8">
              <div className="w-16 h-16 bg-blue-500/20 rounded-2xl flex items-center justify-center mx-auto mb-6">
                <CheckCircle className="w-8 h-8 text-blue-500" />
              </div>
              <h2 className="text-2xl font-bold text-white mb-2">{t("client.src.email_verified")}</h2>
              <p className="text-muted-foreground mb-8">{t("client.src.your_email_has_been")}</p>
              <Button onClick={() => navigate("/login")} className="w-full h-11 bg-primary text-primary-foreground hover:bg-primary/90 text-white rounded-xl shadow-lg shadow-blue-600/20">{t("client.src.continue_to_login")}</Button>
            </div>}

          {status === "error" && <div className="py-8">
              <div className="w-16 h-16 bg-red-500/20 rounded-2xl flex items-center justify-center mx-auto mb-6">
                <XCircle className="w-8 h-8 text-red-500" />
              </div>
              <h2 className="text-2xl font-bold text-white mb-2">{t("client.src.verification_failed")}</h2>
              <p className="text-muted-foreground mb-8">{t("client.src.we_couldnt_verify_your")}</p>
              <Button onClick={() => navigate("/signup")} className="w-full h-11 bg-muted hover:bg-muted text-white rounded-xl mb-3">{t("client.src.back_to_sign_up")}</Button>
            </div>}
        </m.div>
      </div>
    </div>;
}