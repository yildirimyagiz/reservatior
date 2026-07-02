import Link from "next/link";
import type { Metadata } from "next";
import { Sparkles } from "lucide-react";

export const metadata: Metadata = {
  title: "404 - Page Not Found | Reservatior",
  description: "The page you are looking for does not exist.",
};

export default function NotFound() {
  return (
    <div className="min-h-screen bg-background flex items-center justify-center p-6">
      <div className="text-center max-w-lg space-y-8">
        <div className="w-20 h-20 rounded-2xl bg-gradient-to-br from-blue-600 to-indigo-600 flex items-center justify-center mx-auto shadow-2xl shadow-blue-600/30">
          <Sparkles className="w-10 h-10 text-white" />
        </div>
        <div className="space-y-3">
          <h1 className="text-7xl font-black text-foreground">404</h1>
          <h2 className="text-2xl font-bold text-foreground">Page Not Found</h2>
          <p className="text-muted-foreground text-lg max-w-md mx-auto">
            The page you&apos;re looking for doesn&apos;t exist or has been moved.
          </p>
        </div>
        <div className="flex gap-4 justify-center">
          <Link href="/" className="inline-flex items-center gap-2 px-6 py-3 rounded-xl bg-gradient-to-r from-blue-600 to-indigo-600 text-white font-bold text-sm hover:from-blue-500 hover:to-indigo-500 transition-all shadow-lg shadow-blue-600/25">
            Go Home
          </Link>
          <Link href="/client/dashboard" className="inline-flex items-center gap-2 px-6 py-3 rounded-xl border border-border bg-background text-foreground font-bold text-sm hover:bg-accent/50 transition-all">
            Dashboard
          </Link>
        </div>
      </div>
    </div>
  );
}
