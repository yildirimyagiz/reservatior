"use client";

import dynamic from "next/dynamic";

const SpaApp = dynamic(() => import("@/App"), {
  ssr: false,
  loading: () => (
    <div className="min-h-screen bg-[#fafafa] dark:bg-[#0a0a0c]">
      <div className="max-w-[1600px] mx-auto px-6 py-8">
        <div className="flex items-center justify-between mb-12">
          <div className="h-8 w-40 bg-neutral-200 dark:bg-slate-800 rounded-lg animate-pulse" />
          <div className="flex gap-3">
            {[1,2,3,4].map(i => (
              <div key={i} className="h-8 w-20 bg-neutral-200 dark:bg-slate-800 rounded-lg animate-pulse" />
            ))}
          </div>
        </div>
        <div className="space-y-6">
          <div className="h-16 w-3/4 bg-neutral-200 dark:bg-slate-800 rounded-2xl animate-pulse mx-auto" />
          <div className="h-6 w-1/2 bg-neutral-200 dark:bg-slate-800 rounded-xl animate-pulse mx-auto" />
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mt-16">
            {[1,2,3].map(i => (
              <div key={i} className="h-64 bg-neutral-200 dark:bg-slate-800 rounded-[2rem] animate-pulse" />
            ))}
          </div>
        </div>
      </div>
    </div>
  ),
});

export function SpaClient() {
  return <SpaApp />;
}
