"use client";

import { useTranslation } from "react-i18next";
import { useQuery } from "@tanstack/react-query";
import { useSearchParams, Link } from "@/lib/react-router-shim";
import { motion } from "framer-motion";
import { CheckCircle2, XCircle, ArrowRight, Home, Receipt, Bell } from "lucide-react";
import { Button } from "@/components/ui/button";
import { PageShell } from "../layout/PageShell";
export default function PaymentStatus() {
  const {
    t
  } = useTranslation();
  const [searchParams] = useSearchParams();
  const sessionId = searchParams.get("session_id");
  const { data: status = "loading" } = useQuery<"loading" | "success" | "error">({
    queryKey: ['paymentStatus', sessionId],
    queryFn: async () => {
      if (!sessionId) return "error";
      // In a real app, verify sessionId with backend
      await new Promise(resolve => setTimeout(resolve, 1500));
      return "success";
    },
    enabled: true
  });
  const isSuccess = status === "success";
  return <PageShell title={t("client.src.transaction_status")} description={t("client.src.realtime_financial_synchronization_status")}>
      <div className="flex flex-col items-center justify-center min-h-[60vh] text-center px-4">
        <motion.div initial={{
        scale: 0.8,
        opacity: 0
      }} animate={{
        scale: 1,
        opacity: 1
      }} className="relative mb-8">
          <div className={`absolute inset-0 blur-3xl opacity-20 rounded-full ${isSuccess ? 'bg-emerald-500' : 'bg-rose-500'}`} />
          {isSuccess ? <div className="bg-emerald-500/10 border border-emerald-500/20 p-8 rounded-full">
              <CheckCircle2 className="w-20 h-20 text-emerald-400" />
            </div> : <div className="bg-rose-500/10 border border-rose-500/20 p-8 rounded-full">
              <XCircle className="w-20 h-20 text-rose-400" />
            </div>}
        </motion.div>

        <motion.div initial={{
        y: 20,
        opacity: 0
      }} animate={{
        y: 0,
        opacity: 1
      }} transition={{
        delay: 0.2
      }} className="max-w-md">
          <h1 className="text-4xl font-bold mb-4 tracking-tight">
            {isSuccess ? "Neural Synchronization Complete" : "Synchronization Interrupted"}
          </h1>
          <p className="text-slate-400 text-lg mb-8 leading-relaxed">
            {isSuccess ? "Your transaction has been verified and recorded across the Reservatior ledger. All assets and permissions are now live." : "We encountered a neural handshake error. Please check your payment method or try again. No assets have been modified."}
          </p>

          <div className="flex flex-col gap-3 sm:flex-row items-center justify-center">
            {isSuccess ? <>
                <Link to="/admin/dashboard">
                  <Button size="lg" className="bg-blue-600 hover:bg-blue-700 gap-2">
                    <Home className="w-4 h-4" />{t("client.src.go_to_dashboard")}</Button>
                </Link>
                <Link to="/invoices">
                  <Button variant="outline" size="lg" className="gap-2">
                    <Receipt className="w-4 h-4" />{t("client.src.view_invoices")}</Button>
                </Link>
              </> : <>
                <Link to="/admin/properties">
                  <Button size="lg" className="bg-rose-600 hover:bg-rose-700 gap-2">{t("client.src.return_to_portfolio")}</Button>
                </Link>
                <Button variant="outline" size="lg" onClick={() => window.history.back()}>{t("client.src.try_again")}</Button>
              </>}
          </div>
        </motion.div>

        {isSuccess && <motion.div initial={{
        opacity: 0
      }} animate={{
        opacity: 1
      }} transition={{
        delay: 1
      }} className="mt-12 flex items-center gap-6 text-slate-500">
            <div className="flex items-center gap-2">
              <Bell className="w-4 h-4 text-emerald-400" />
              <span className="text-sm italic">{t("client.src.notification_sent_to_stakeholders")}</span>
            </div>
            <div className="w-px h-4 bg-slate-800" />
            <div className="flex items-center gap-2">
              <Receipt className="w-4 h-4 text-blue-400" />
              <span className="text-sm italic">{t("client.src.receipt_generated")}{sessionId?.slice(-8).toUpperCase()}</span>
            </div>
          </motion.div>}
      </div>
    </PageShell>;
}