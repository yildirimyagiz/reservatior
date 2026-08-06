"use client";

import { useTranslation } from "react-i18next";
import { useEffect, useState } from "react";
import { useNavigate, useSearchParams } from "@/lib/react-router-shim";
import { apiClient } from "@/lib/api/client";

export default function LinkedInCallback() {
  const { t } = useTranslation();
  const [searchParams] = useSearchParams();
  const navigate = useNavigate();
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const code = searchParams.get("code");
    const errorParam = searchParams.get("error");

    if (errorParam) {
      setError(errorParam);
      setTimeout(() => navigate("/auth/login?error=" + errorParam, { replace: true }), 2000);
      return;
    }

    if (!code) {
      navigate("/auth/login", { replace: true });
      return;
    }

    apiClient.post<{ token: string; user: any }>("/auth/linkedin/callback", { code })
      .then((res) => {
        localStorage.setItem("user-storage", JSON.stringify({
          state: { token: res.token, user: res.user },
          version: 0,
        }));
        const adminRoles = ["OWNER", "ORG_ADMIN", "ADMIN", "SUPER_ADMIN", "AGENCY_ADMIN", "VENDOR_MANAGER", "ACCOUNTANT"];
        if (res.user && adminRoles.includes(res.user.role)) {
          navigate("/admin/dashboard", { replace: true });
        } else {
          navigate("/", { replace: true });
        }
      })
      .catch(() => {
        navigate("/auth/login?error=linkedin_auth_failed", { replace: true });
      });
  }, [searchParams, navigate]);

  return (
    <div className="min-h-screen bg-[#0A0A0B] flex items-center justify-center">
      <div className="text-center space-y-4">
        {error ? (
          <>
            <div className="w-16 h-16 mx-auto rounded-full bg-red-500/20 flex items-center justify-center">
              <span className="text-red-400 text-2xl">!</span>
            </div>
            <h2 className="text-xl font-medium text-red-400">{t("client.src.authentication_failed")}</h2>
            <p className="text-sm text-muted-foreground">{t("client.src.redirecting")}</p>
          </>
        ) : (
          <>
            <div className="w-12 h-12 border-4 border-blue-500/20 border-t-blue-500 rounded-full animate-spin mx-auto" />
            <h2 className="text-xl font-medium text-foreground">{t("client.src.completing_sign_in")}</h2>
          </>
        )}
      </div>
    </div>
  );
}
