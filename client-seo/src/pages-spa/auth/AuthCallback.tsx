"use client";

import { useSearchParams } from "next/navigation";
import { useEffect } from "react";

import { useAuth } from "../../lib/auth/hooks";
import { useNavigate } from "../../lib/react-router-shim";


export default function AuthCallback() {
  const searchParams = useSearchParams();
  const navigate = useNavigate();
  const {
    setToken,
    setUser
  } = useAuth();
  useEffect(() => {
    const token = searchParams?.get("token");
    const userStr = searchParams?.get("user");
    const error = searchParams?.get("error");
    if (error) {
      console.error("Auth error:", error);
      navigate("/auth/login?error=" + error, {
        replace: true
      });
      return;
    }
    if (token && userStr) {
      try {
        const user = JSON.parse(userStr);
        setToken(token);
        setUser(user);

        // Setup local storage properly since Zustand's persist handles it normally
        localStorage.setItem('user-storage', JSON.stringify({
          state: {
            token,
            user
          },
          version: 0
        }));
        const adminRoles = ['OWNER', 'ORG_ADMIN', 'ADMIN', 'SUPER_ADMIN', 'AGENCY_ADMIN', 'VENDOR_MANAGER', 'ACCOUNTANT'];
        if (user && adminRoles.includes(user.role)) {
          navigate("/admin/dashboard", {
            replace: true
          });
        } else {
          navigate("/dashboard", {
            replace: true
          });
        }
      } catch (err) {
        console.error("Failed to parse user data:", err);
        navigate("/auth/login", {
          replace: true
        });
      }
    } else {
      navigate("/auth/login", {
        replace: true
      });
    }
  }, [searchParams, navigate, setToken, setUser]);
  return <div className="min-h-screen bg-[#0A0A0B] flex items-center justify-center">
      <div className="text-center space-y-4">
        <div className="w-12 h-12 border-4 border-blue-500/20 border-t-blue-500 rounded-full animate-spin mx-auto" />
        <h2 className="text-xl font-medium text-foreground">Completing sign in process</h2>
      </div>
    </div>;
}