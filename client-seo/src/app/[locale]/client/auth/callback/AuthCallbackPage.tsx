"use client";

import { useEffect, useState, Suspense } from "react";
import { useRouter, useSearchParams } from "next/navigation";
import { Card, CardContent } from "@/components/ui/card";
import { Loader2, CheckCircle2, XCircle } from "lucide-react";
import { motion } from "framer-motion";
import { useTranslation } from "react-i18next";
import { jwtDecode } from "jwt-decode";
import { useUserStore } from "@/lib/store/user-store";

function CallbackHandler() {
  const { t } = useTranslation();
  const router = useRouter();
  const searchParams = useSearchParams();
  const [status, setStatus] = useState<"loading" | "success" | "error">("loading");
  const [errorMsg, setErrorMsg] = useState("");

  useEffect(() => {
    const token = searchParams.get("token") || searchParams.get("access_token");
    const error = searchParams.get("error");

    if (error) {
      setErrorMsg(error);
      setStatus("error");
      return;
    }

    if (!token) {
      setErrorMsg("No authentication token received");
      setStatus("error");
      return;
    }

    try {
      const decoded: any = jwtDecode(token);
      useUserStore.getState().setToken(token);
      useUserStore.getState().setUser({
        id: decoded.sub,
        email: decoded.email,
        role: decoded.role,
        name: decoded.name || decoded.email?.split("@")[0],
      });
      setStatus("success");
      const adminRoles = ["OWNER", "ORG_ADMIN", "ADMIN", "SUPER_ADMIN", "AGENCY_ADMIN", "VENDOR_MANAGER", "ACCOUNTANT"];
      const dest = adminRoles.includes(decoded.role) ? "/admin/dashboard" : "/";
      setTimeout(() => router.push(dest), 1500);
    } catch (err: any) {
      setErrorMsg(err.message || "Failed to process authentication");
      setStatus("error");
    }
  }, [searchParams, router]);

  return (
    <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
      <CardContent className="p-12 text-center">
        {status === "loading" && (
          <>
            <Loader2 className="w-12 h-12 text-purple-400 animate-spin mx-auto mb-6" />
            <h2 className="text-xl font-bold text-white mb-2">{t("client.src.authenticating")}</h2>
            <p className="text-gray-400">{t("client.src.please_wait")}</p>
          </>
        )}
        {status === "success" && (
          <>
            <CheckCircle2 className="w-12 h-12 text-green-400 mx-auto mb-6" />
            <h2 className="text-xl font-bold text-white mb-2">{t("client.src.authentication_successful")}</h2>
            <p className="text-gray-400">{t("client.src.redirecting")}</p>
          </>
        )}
        {status === "error" && (
          <>
            <XCircle className="w-12 h-12 text-red-400 mx-auto mb-6" />
            <h2 className="text-xl font-bold text-white mb-2">{t("client.src.authentication_failed")}</h2>
            <p className="text-gray-400">{errorMsg}</p>
          </>
        )}
      </CardContent>
    </Card>
  );
}

export default function AuthCallbackPage() {
  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-purple-900 to-slate-900 flex items-center justify-center p-4">
      <motion.div
        initial={{ opacity: 0, scale: 0.9 }}
        animate={{ opacity: 1, scale: 1 }}
        className="w-full max-w-md"
      >
        <Suspense fallback={
          <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
            <CardContent className="p-12 text-center">
              <Loader2 className="w-12 h-12 text-purple-400 animate-spin mx-auto mb-6" />
            </CardContent>
          </Card>
        }>
          <CallbackHandler />
        </Suspense>
      </motion.div>
    </div>
  );
}
