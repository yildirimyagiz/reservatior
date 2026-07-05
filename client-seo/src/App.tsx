import { useTranslation } from "react-i18next";
import { Suspense } from "react";
import { QueryClientProvider } from "@tanstack/react-query";
import { Toaster } from "@/components/ui/toaster";
import { TooltipProvider } from "@/components/ui/tooltip";
import { ErrorBoundary } from "@/components/ui/error-boundary";
// Note: AppRouter moved to Next.js App Router. Legacy SPA entry kept for reference.
import { queryClient } from "./lib/query-client";
import { CustomerSupport } from "@/components/support/CustomerSupport";
import { HelmetProvider } from "react-helmet-async";
import { AuthProvider } from "./lib/auth/AuthProvider";
import { MapProviderWrapper } from "@/components/map/MapProvider";
import { GeoInit } from "./components/auth/GeoInit";
import "./i18n";
function App() {
  const {
    t
  } = useTranslation();
  return <ErrorBoundary>
      <HelmetProvider>
        <QueryClientProvider client={queryClient}>
          <TooltipProvider>
            <MapProviderWrapper>
              <AuthProvider>
                <GeoInit />
                <Suspense fallback={<div className="min-h-screen bg-[#0A0A0B] flex items-center justify-center">
                    <div className="text-center space-y-4">
                      <div className="w-12 h-12 border-4 border-blue-500/20 border-t-blue-500 rounded-full animate-spin mx-auto" />
                      <h2 className="text-xl font-medium text-slate-200">{t("client.src.loading_platform")}</h2>
                    </div>
                  </div>}>
                  <div className="text-center text-slate-400 p-8">
                    {/* Legacy SPA wrapper - routing handled by Next.js App Router */}
                  </div>
                </Suspense>
                <CustomerSupport />
                <Toaster />
              </AuthProvider>
            </MapProviderWrapper>
          </TooltipProvider>
        </QueryClientProvider>
      </HelmetProvider>
    </ErrorBoundary>;
}
export default App;