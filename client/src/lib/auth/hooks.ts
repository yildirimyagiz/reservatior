import { useEffect } from "react";
import { AuthUtils } from "./utils";
import { useUserStore } from "../store/user-store";
import { authApi } from "../api/auth";

export const useAuth = () => {
  const {
    user,
    token,
    loading,
    error,
    isAuthenticated,
    setUser,
    setToken,
    setLoading,
    setError,
    logout: storeLogout,
  } = useUserStore();

  // Initialize authentication state from localStorage
  useEffect(() => {
    const initializeAuth = () => {
      const storedToken = localStorage.getItem('user-storage');
      if (storedToken) {
        try {
          const parsed = JSON.parse(storedToken);
          if (parsed.state?.token && parsed.state?.user) {
            setUser(parsed.state.user);
            setToken(parsed.state.token);
          }
        } catch (error) {
          console.error('Failed to parse stored auth data:', error);
        }
      }
    };

    initializeAuth();
  }, [setUser, setToken]);

  const login = async (email: string, password: string) => {
    setLoading(true);
    setError(null);

    try {
      const authData = await authApi.login({ email, password });

      setUser(authData.user as any);
      setToken(authData.token);

      // Store token in localStorage via user-storage (handled by zustand persist)
    } catch (err: any) {
      const errorMessage = err.message || "Login failed";
      setError(errorMessage);
      throw err;
    } finally {
      setLoading(false);
    }
  };

  const register = async (
    email: string,
    password: string,
    name: string,
    phone?: string
  ) => {
    setLoading(true);
    setError(null);

    try {
      const authData = await authApi.register({
        email,
        password,
        name,
        phone,
      });

      setUser(authData.user as any);
      setToken(authData.token);
    } catch (err: any) {
      const errorMessage = err.message || "Registration failed";
      setError(errorMessage);
      throw err;
    } finally {
      setLoading(false);
    }
  };

  const logout = async () => {
    try {
      await authApi.logout();
    } catch (err) {
      console.error("Logout API call failed:", err);
    } finally {
      storeLogout();
    }
  };

  const refreshToken = async () => {
    if (!token) return false;
    try {
      // Mock refresh or real call if available
      return true;
    } catch (err) {
      logout();
      return false;
    }
  };

  const hasPermission = (permission: string) => {
    if (!user) return false;
    return AuthUtils.hasPermission(user.permissions || [], permission);
  };

  const hasAnyPermission = (permissions: string[]) => {
    if (!user) return false;
    return AuthUtils.hasAnyPermission(user.permissions || [], permissions);
  };

  const hasAllPermissions = (permissions: string[]) => {
    if (!user) return false;
    return AuthUtils.hasAllPermissions(user.permissions || [], permissions);
  };

  // Check token expiration periodically - DISABLED for debugging
  // useEffect(() => {
  //   if (!token) return;

  //   const checkTokenExpiration = () => {
  //     if (AuthUtils.isTokenExpired(token)) {
  //       logout();
  //     }
  //   };

  //   checkTokenExpiration();
  //   const interval = setInterval(checkTokenExpiration, 30000); // Reduced frequency
  //   return () => clearInterval(interval);
  // }, [token]);

  return {
    user,
    token,
    loading,
    error,
    isAuthenticated,
    setUser,
    setToken,
    login,
    register,
    logout,
    refreshToken,
    hasPermission,
    hasAnyPermission,
    hasAllPermissions,
  };
};

export const useRequireAuth = (requiredPermissions?: string[]) => {
  const { isAuthenticated, hasPermission, hasAnyPermission, user, loading } = useAuth();

  const isAuthorized = requiredPermissions
    ? requiredPermissions.length === 1
      ? hasPermission(requiredPermissions[0])
      : hasAnyPermission(requiredPermissions)
    : isAuthenticated;

  return {
    isAuthorized,
    user,
    isAuthenticated,
    loading,
  };
};
