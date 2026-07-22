"use client";

import { useRouter } from "next/navigation";
import { Button } from "@/components/ui/button";
import { Home, ArrowLeft } from "lucide-react";
import { m } from "framer-motion";
import { useTranslation } from "react-i18next";

export default function NotFoundPage() {
    const { t } = useTranslation();
  const router = useRouter();

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-purple-900 to-slate-900 flex items-center justify-center">
      <div className="text-center">
        <m.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="mb-8"
        >
          <h1 className="text-9xl font-bold text-white mb-4">404</h1>
          <p className="text-2xl text-gray-400 mb-8">{t("not_found.notfoundpage.auto_ext_1")}</p>
        </m.div>

        <m.div
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
            {t("not_found.notfoundpage.auto_ext_2")}
                                </Button>
          <Button
            onClick={() => router.back()}
            variant="outline"
            className="bg-white/10 border-purple-500/30 text-white"
          >
            <ArrowLeft className="w-4 h-4 mr-2" />
            {t("not_found.notfoundpage.auto_ext_3")}
                                </Button>
        </m.div>
      </div>
    </div>
  );
}
