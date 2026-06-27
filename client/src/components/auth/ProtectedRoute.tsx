import { useTranslation } from "react-i18next";
import { ReactNode } from "react";
import { Button } from "@/components/ui/button";
import { Link } from "wouter";
import { Lock, ArrowRight } from "lucide-react";
import { useRequireAuth } from "@/lib/auth";
interface ProtectedRouteProps {
  children: ReactNode;
  requiredPermissions?: string[];
  fallback?: ReactNode;
}
export function ProtectedRoute({
  children,
  requiredPermissions,
  fallback
}: ProtectedRouteProps) {
  const {
    t
  } = useTranslation();
  const {
    isAuthorized,
    user,
    isAuthenticated
  } = useRequireAuth(requiredPermissions);
  if (!isAuthenticated) {
    // User is not logged in
    if (fallback) {
      return <>{fallback}</>;
    }
    return <div className="min-h-screen bg-background flex items-center justify-center p-4">
        <div className="text-center max-w-md">
          <div className="w-16 h-16 bg-muted rounded-full flex items-center justify-center mx-auto mb-6">
            <Lock className="w-8 h-8 text-muted-foreground" />
          </div>
          <h1 className="text-2xl font-bold mb-4">{t("client.src.authentication_required")}</h1>
          <p className="text-muted-foreground mb-8">{t("client.src.please_sign_in_to")}</p>
          <div className="space-y-4">
            <Link href="/login">
              <Button className="w-full">{t("client.src.sign_in")}<ArrowRight className="ml-2 h-4 w-4" />
              </Button>
            </Link>
            <Link href="/signup">
              <Button variant="outline" className="w-full">{t("client.src.create_account")}</Button>
            </Link>
          </div>
        </div>
      </div>;
  }
  if (!isAuthorized) {
    // User is logged in but doesn't have required permissions
    if (fallback) {
      return <>{fallback}</>;
    }
    return <div className="min-h-screen bg-background flex items-center justify-center p-4">
        <div className="text-center max-w-md">
          <div className="w-16 h-16 bg-orange-500/20 rounded-full flex items-center justify-center mx-auto mb-6">
            <Lock className="w-8 h-8 text-orange-500" />
          </div>
          <h1 className="text-2xl font-bold mb-4">{t("client.src.access_denied")}</h1>
          <p className="text-muted-foreground mb-4">{t("client.src.you_dont_have_the")}</p>
          {user && <p className="text-sm text-muted-foreground mb-8">{t("client.src.logged_in_as")}<span className="font-medium">{user.email}</span>
            </p>}
          <div className="space-y-4">
            <Link href="/dashboard">
              <Button variant="outline" className="w-full">{t("client.src.back_to_dashboard")}</Button>
            </Link>
            <Link href="/settings">
              <Button variant="ghost" className="w-full">{t("client.src.contact_support")}</Button>
            </Link>
          </div>
        </div>
      </div>;
  }
  return <>{children}</>;
}

// Higher-order component for wrapping pages
export function withAuth<P extends object>(Component: React.ComponentType<P>, requiredPermissions?: string[]) {
  return function AuthenticatedComponent(props: P) {
    return <ProtectedRoute requiredPermissions={requiredPermissions}>
        <Component {...props} />
      </ProtectedRoute>;
  };
}