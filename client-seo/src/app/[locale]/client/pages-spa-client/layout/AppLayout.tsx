import { useTranslation } from "react-i18next";
import { useLocation } from "@/lib/react-router-shim";
import { AppHeader } from "@/components/layout/AppHeader";
import { Footer } from "@/components/layout/Footer";
import { useAuth } from "@/lib/auth/hooks";

interface AppLayoutProps {
  children: React.ReactNode;
}

export function AppLayout({
  children
}: AppLayoutProps) {
  const { t } = useTranslation();
  const { user } = useAuth();
  
  return (
    <div className="flex flex-col h-screen bg-background overflow-hidden">
      {/* Unified Application Header - Full Width */}
      <AppHeader />

      <div className="flex flex-1 overflow-hidden">
        {/* Main content */}
        <main className="flex-1 overflow-auto bg-[#1b1c22] flex flex-col">
          <div className="flex-1">
            {children}
          </div>
          <Footer />
        </main>
      </div>
    </div>
  );
}