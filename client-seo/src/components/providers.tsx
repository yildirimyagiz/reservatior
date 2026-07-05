"use client";

import { useEffect, Suspense, lazy } from "react";
import { QueryClientProvider } from "@tanstack/react-query";
import { Toaster } from "@/components/ui/toaster";
import { TooltipProvider } from "@/components/ui/tooltip";
import { queryClient } from "@/lib/query-client";
import { MapProviderWrapper } from "@/components/map/MapProvider";
import { useRegionsStore } from "@/lib/store/regions-store";
import { ThemeProvider } from "next-themes";
import { Navbar } from "@/components/layout/Navbar";
import "@/i18n";

// Lazy load Devtools so it doesn't inflate the Next.js dev server compilation graph
const ReactQueryDevtools = lazy(() =>
  import("@tanstack/react-query-devtools").then(res => ({
    default: res.ReactQueryDevtools,
  }))
);

function RegionBootstrap() {
  const loadRegions = useRegionsStore((s) => s.loadRegions);
  const autoDetectRegion = useRegionsStore((s) => s.autoDetectRegion);

  useEffect(() => {
    loadRegions().then(() => autoDetectRegion()).catch(() => {});
  }, []); // eslint-disable-line react-hooks/exhaustive-deps

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
