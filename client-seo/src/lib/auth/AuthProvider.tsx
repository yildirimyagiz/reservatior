"use client";

import { createContext, useContext, useEffect, ReactNode, useState } from "react";
import { useAuth, useRequireAuth } from "./hooks";
import { apiClient } from "@/lib/api/client";

interface AuthContextType {
  user: any;
  token: string | null;
  loading: boolean;
  error: string | null;
  isAuthenticated: boolean;
  setUser: (user: any) => void;
  setToken: (token: string | null) => void;
  login: (email: string, password: string) => Promise<void>;
  register: (
    email: string,
    password: string,
    name: string,
    phone?: string
  ) => Promise<void>;
  logout: () => Promise<void>;
  refreshToken: () => Promise<boolean>;
  hasPermission: (permission: string) => boolean;
  hasAnyPermission: (permissions: string[]) => boolean;
  hasAllPermissions: (permissions: string[]) => boolean;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

interface AuthProviderProps {
  children: ReactNode;
}

export function AuthProvider({ children }: AuthProviderProps) {
  const auth = useAuth();
  const [initializing, setInitializing] = useState(false);

  // Initialize auth state from token on mount. Only blocks rendering while a
  // stored token is being validated against the backend; anonymous visitors
  // (and SSR) render children immediately so the marketing site can SSR.
  useEffect(() => {
    const initAuth = async () => {
      const token = auth.token;
      if (token) {
        setInitializing(true);
        try {
          // Sync with backend /me
          const response = await apiClient.get<any>("/auth/me");

          if (response.data?.user) {
            auth.setUser(response.data.user);
          }
        } catch (error: any) {
          if (error.status === 401) {
            auth.logout();
          }
          console.error("Auth initialization failed:", error);
        }
        setInitializing(false);
      }
    };

    initAuth();
  }, []);

  if (initializing) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-background">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary"></div>
      </div>
    );
  }

  return <AuthContext.Provider value={auth}>{children}</AuthContext.Provider>;
}

export function useAuthContext() {
  const context = useContext(AuthContext);
  if (context === undefined) {
    throw new Error("useAuthContext must be used within an AuthProvider");
  }
  return context;
}

// Higher-order component for protecting routes
export function withAuth<P extends object>(
  Component: React.ComponentType<P>,
  requiredPermissions?: string[]
) {
  return function AuthenticatedComponent(props: P) {
    const { isAuthorized, isAuthenticated, loading } = useRequireAuth(requiredPermissions);

    if (loading) return null;

    if (!isAuthenticated) {
        // Handle redirect to login if needed
        return null; 
    }

    if (!isAuthorized) {
      return (
        <div className="min-h-screen flex items-center justify-center">
          <div className="text-center">
            <h1 className="text-2xl font-bold mb-4">Access Denied</h1>
            <p className="text-muted-foreground">
              You don't have permission to access this page.
            </p>
          </div>
        </div>
      );
    }

    return <Component {...props} />;
  };
}
