"use client";

import { useEffect } from "react";
import { useRouter } from "next/navigation";
import { useAuth } from "@/contexts/AuthContext";
import { canAccessOSModule } from "@/lib/auth/role-based-routing";

interface RoleGuardProps {
  osModule: string;
  children: React.ReactNode;
}

export function RoleGuard({ osModule, children }: RoleGuardProps) {
  const { user, isAuthenticated } = useAuth();
  const router = useRouter();

  useEffect(() => {
    if (!isAuthenticated) {
      router.push("/auth/login");
      return;
    }

    if (!canAccessOSModule(user, osModule)) {
      router.push("/unauthorized");
      return;
    }
  }, [user, isAuthenticated, osModule, router]);

  if (!isAuthenticated || !canAccessOSModule(user, osModule)) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-background">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary"></div>
      </div>
    );
  }

  return <>{children}</>;
}
