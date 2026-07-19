"use client";

import { useEffect, Suspense, lazy } from "react";
import { QueryClientProvider } from "@tanstack/react-query";
import { TooltipProvider } from "@/components/ui/tooltip";
import { queryClient } from "@/lib/query-client";
import { MapProviderWrapper } from "@/components/map/MapProvider";
import { useRegionsStore } from "@/lib/store/regions-store";
import { ThemeProvider } from "next-themes";
import dynamic from "next/dynamic";
import "@/i18n";

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
        <TooltipProvider>
          <MapProviderWrapper>
            <RegionBootstrap />
            {children}
            <Toaster />
          </MapProviderWrapper>
        </TooltipProvider>
      </ThemeProvider>
      {process.env.NODE_ENV === "development" && (
        <Suspense fallback={null}>
          <ReactQueryDevtools initialIsOpen={false} />
        </Suspense>
      )}
    </QueryClientProvider>
  );
}
