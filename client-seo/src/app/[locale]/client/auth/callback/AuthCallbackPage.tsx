"use client";

import { useEffect } from "react";
import { useRouter } from "next/navigation";
import { Card, CardContent } from "@/components/ui/card";
import { Loader2 } from "lucide-react";
import { motion } from "framer-motion";

export default function AuthCallbackPage() {
  const router = useRouter();

  useEffect(() => {
    // Handle OAuth callback logic here
    const timer = setTimeout(() => {
      router.push('/dashboard');
    }, 2000);

    return () => clearTimeout(timer);
  }, [router]);

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-purple-900 to-slate-900 flex items-center justify-center p-4">
      <motion.div
        initial={{ opacity: 0, scale: 0.9 }}
        animate={{ opacity: 1, scale: 1 }}
        className="w-full max-w-md"
      >
        <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
          <CardContent className="p-12 text-center">
            <Loader2 className="w-12 h-12 text-purple-400 animate-spin mx-auto mb-6" />
            <h2 className="text-xl font-bold text-white mb-2">Authenticating...</h2>
            <p className="text-gray-400">Please wait while we complete your authentication</p>
          </CardContent>
        </Card>
      </motion.div>
    </div>
  );
}
