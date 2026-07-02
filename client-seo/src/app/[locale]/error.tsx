"use client";

import { useEffect } from "react";
import { Sparkles } from "lucide-react";

export default function Error({
  error,
  reset,
}: {
  error: Error & { digest?: string };
  reset: () => void;
}) {
  useEffect(() => {
    console.error(error);
  }, [error]);

  return (
    <div className="min-h-screen bg-background flex items-center justify-center p-6">
      <div className="text-center max-w-lg space-y-8">
        <div className="w-20 h-20 rounded-2xl bg-gradient-to-br from-red-500 to-orange-500 flex items-center justify-center mx-auto shadow-2xl shadow-red-500/30">
          <Sparkles className="w-10 h-10 text-white" />
        </div>
        <div className="space-y-3">
          <h1 className="text-5xl font-black text-foreground">Something went wrong</h1>
          <p className="text-muted-foreground text-lg max-w-md mx-auto">
            An unexpected error occurred. Please try again.
          </p>
        </div>
        <button
          onClick={reset}
          className="inline-flex items-center gap-2 px-6 py-3 rounded-xl bg-gradient-to-r from-blue-600 to-indigo-600 text-white font-bold text-sm hover:from-blue-500 hover:to-indigo-500 transition-all shadow-lg shadow-blue-600/25"
        >
          Try Again
        </button>
      </div>
    </div>
  );
}
