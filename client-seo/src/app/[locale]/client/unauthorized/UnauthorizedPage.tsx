"use client";

import { useRouter } from "next/navigation";
import { Button } from "@/components/ui/button";
import { Shield, Home, LogIn } from "lucide-react";
import { motion } from "framer-motion";
import { useTranslation } from "react-i18next";

export default function UnauthorizedPage() {
    const { t } = useTranslation();
  const router = useRouter();

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-purple-900 to-slate-900 flex items-center justify-center">
      <div className="text-center max-w-md">
        <motion.div
          initial={{ opacity: 0, scale: 0.9 }}
          animate={{ opacity: 1, scale: 1 }}
          className="mb-8"
        >
          <div className="p-6 rounded-full bg-red-500/20 mx-auto mb-6 w-fit">
            <Shield className="w-16 h-16 text-red-400" />
          </div>
          <h1 className="text-4xl font-bold text-white mb-4">{t("unauthorized.unauthorizedpage.auto_ext_1")}</h1>
          <p className="text-gray-400 mb-8">{t("unauthorized.unauthorizedpage.auto_ext_2")}</p>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2 }}
          className="flex gap-4 justify-center"
        >
          <Button
            onClick={() => router.push('/')}
            className="bg-purple-600 hover:bg-purple-700"
          >
            <Home className="w-4 h-4 mr-2" />
            {t("unauthorized.unauthorizedpage.auto_ext_3")}
                                </Button>
          <Button
            onClick={() => router.push('/login')}
            variant="outline"
            className="bg-white/10 border-purple-500/30 text-white"
          >
            <LogIn className="w-4 h-4 mr-2" />
            {t("unauthorized.unauthorizedpage.auto_ext_4")}
                                </Button>
        </motion.div>
      </div>
    </div>
  );
}
