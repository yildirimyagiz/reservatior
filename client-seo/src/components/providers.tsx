"use client";

import { useEffect, Suspense, lazy } from "react";
import { QueryClientProvider } from "@tanstack/react-query";
import { queryClient } from "@/lib/query-client";
import { MapProviderWrapper } from "@/components/map/MapProvider";
import { useRegionsStore } from "@/lib/store/regions-store";
import { ThemeProvider } from "next-themes";
import dynamic from "next/dynamic";
import { LazyMotion, domAnimation } from "framer-motion";
import { I18nextProvider } from "react-i18next";
import i18n from "@/i18n";

import { AuthProvider } from "@/lib/auth/AuthProvider";

const Toaster = dynamic(() => import("@/components/ui/toaster").then(m => m.Toaster), { ssr: false });
const ReactQueryDevtools = lazy(() =>
  import("@tanstack/react-query-devtools").then(res => ({
    default: res.ReactQueryDevtools,
  }))
);

function RegionBootstrap() {
  const loadRegions = useRegionsStore((s) => s.loadRegions);
  const autoDetectRegion = useRegionsStore((s) => s.autoDetectRegion);

  useEffect(() => {
    const timer = setTimeout(() => {
      loadRegions().then(() => autoDetectRegion()).catch(() => {});
    }, 1500);
    return () => clearTimeout(timer);
  }, []);

  return null;
}

export function Providers({ children }: { children: React.ReactNode }) {
  return (
    <QueryClientProvider client={queryClient}>
      <ThemeProvider attribute="class" defaultTheme="dark" enableSystem>
        <I18nextProvider i18n={i18n}>
          <AuthProvider>
          <MapProviderWrapper>
            <LazyMotion features={domAnimation}>
              <RegionBootstrap />
              {children}
            </LazyMotion>
            <Toaster />
          </MapProviderWrapper>
          </AuthProvider>
        </I18nextProvider>
      </ThemeProvider>
      {process.env.NODE_ENV === "development" && (
        <Suspense fallback={null}>
          <ReactQueryDevtools initialIsOpen={false} />
        </Suspense>
      )}
    </QueryClientProvider>
  );
}
