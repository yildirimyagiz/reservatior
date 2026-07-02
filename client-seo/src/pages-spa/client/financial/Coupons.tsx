import React, { useEffect, useState } from "react";
import { useUserStore } from "@/lib/store/user-store";
import { apiClient } from "@/lib/api/client";
import { Wallet, Gift, ArrowRight, Activity, TrendingUp, AlertCircle } from "lucide-react";
import { useTranslation } from "react-i18next";

export function Coupons() {
  const { t } = useTranslation();
  const { user } = useUserStore();
  const [loading, setLoading] = useState(true);
  const [wallet, setWallet] = useState<any>(null);

  useEffect(() => {
    const fetchWallet = async () => {
      try {
        // Fetch from the user's origin region if available
        const response = await apiClient.get<any>("/escrow/wallet", {
          // If we had a specific backend endpoint for wallets, we'd call it here
          // For now, we simulate fetching the Global Wallet from the origin region
        });
        setWallet(response.data);
      } catch (err) {
        console.error("Failed to fetch wallet", err);
      } finally {
        setLoading(false);
      }
    };
    fetchWallet();
  }, [user]);

  // Simulated Global Wallet for UI Demonstration
  const mockWallet = {
    balance: 450.00,
    currency: user?.originRegion === "TR" ? "TRY" : "USD",
    coupons: [
      { id: "1", code: "SUMMER2026", discount: 10, type: "PERCENTAGE", expiresAt: "2026-08-31", region: "GLOBAL" },
      { id: "2", code: "WELCOME", discount: 50, type: "FIXED", expiresAt: "2026-12-31", region: user?.originRegion || "GLOBAL" }
    ],
    history: [
      { id: "h1", date: "2026-06-10", type: "CREDIT", amount: 100, description: "Loyalty Reward" },
      { id: "h2", date: "2026-05-20", type: "DEBIT", amount: -50, description: "Applied to Booking #892" }
    ]
  };

  const displayWallet = wallet || mockWallet;

  return (
    <div className="p-6 md:p-8 max-w-6xl mx-auto space-y-8 animate-in fade-in slide-in-from-bottom-4 duration-700">
      <div className="flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
        <div>
          <h1 className="text-3xl font-bold tracking-tight bg-gradient-to-r from-primary to-primary/60 bg-clip-text text-transparent">{t("client.financial.global_wallet", "Global Wallet & Coupons")}</h1>
          <p className="text-muted-foreground mt-1">{t("client.financial.manage_balances", "Manage your global balances and promotional codes.")}</p>
        </div>
        <div className="flex items-center gap-2 bg-secondary/30 text-secondary-foreground px-4 py-2 rounded-full border border-secondary/50 backdrop-blur-sm shadow-sm">
          <Activity className="w-4 h-4" />
          <span className="text-sm font-medium">{t("client.financial.origin", "Origin:")} <span className="font-bold">{user?.originRegion || "Unknown"}</span></span>
        </div>
      </div>

      {user?.originRegion !== (localStorage.getItem("regions-store") ? JSON.parse(localStorage.getItem("regions-store")!).state?.selectedRegion?.code : "US") && (
        <div className="bg-blue-500/10 border border-blue-500/20 text-blue-600 dark:text-blue-400 p-4 rounded-2xl flex items-start gap-3 backdrop-blur-md">
          <AlertCircle className="w-5 h-5 shrink-0 mt-0.5" />
          <div>
            <h4 className="font-semibold">{t("client.financial.cross_region_active", "Cross-Region Browsing Active")}</h4>
            <p className="text-sm opacity-90">{t("client.financial.cross_region_desc", "You are currently browsing a region different from your origin. Your wallet balance is securely held in your origin region ({{region}}) and will be dynamically converted upon checkout.", { region: user?.originRegion })}</p>
          </div>
        </div>
      )}

      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        {/* Wallet Balance Card */}
        <div className="md:col-span-1 bg-gradient-to-br from-zinc-900 to-zinc-800 dark:from-zinc-800 dark:to-zinc-950 text-white rounded-3xl p-8 relative overflow-hidden shadow-xl border border-white/10 group">
          <div className="absolute top-0 right-0 -mt-8 -mr-8 w-32 h-32 bg-white/5 rounded-full blur-2xl group-hover:bg-white/10 transition-all duration-700"></div>
          <div className="absolute bottom-0 left-0 -mb-8 -ml-8 w-32 h-32 bg-primary/20 rounded-full blur-2xl group-hover:bg-primary/30 transition-all duration-700"></div>
          
          <div className="relative z-10 flex flex-col h-full justify-between">
            <div>
              <div className="flex items-center gap-2 text-white/70 mb-2">
                <Wallet className="w-5 h-5" />
                <span className="font-medium text-sm tracking-wider uppercase">{t("client.financial.available_balance", "Available Balance")}</span>
              </div>
              <div className="flex items-baseline gap-2">
                <span className="text-5xl font-extrabold tracking-tighter">
                  {displayWallet.balance.toFixed(2)}
                </span>
                <span className="text-xl font-medium text-white/60">{displayWallet.currency}</span>
              </div>
            </div>
            <div className="mt-8 pt-6 border-t border-white/10">
              <button className="w-full bg-white/10 hover:bg-white/20 text-white font-medium py-3 px-4 rounded-xl transition-all duration-300 flex items-center justify-center gap-2 backdrop-blur-sm">{t("client.financial.add_funds", "Add Funds")}
                <ArrowRight className="w-4 h-4" />
              </button>
            </div>
          </div>
        </div>

        {/* Coupons List */}
        <div className="md:col-span-2 space-y-6">
          <div className="bg-card border shadow-sm rounded-3xl p-6 md:p-8 relative overflow-hidden">
            <div className="flex items-center justify-between mb-6">
              <h2 className="text-xl font-bold flex items-center gap-2">
                <Gift className="w-5 h-5 text-primary" />{t("client.financial.active_coupons", "Active Coupons")}</h2>
            </div>
            
            <div className="space-y-4">
              {displayWallet.coupons.map((coupon: any) => (
                <div key={coupon.id} className="group relative overflow-hidden border rounded-2xl p-5 hover:border-primary/50 hover:shadow-md transition-all bg-background">
                  <div className="absolute top-0 left-0 w-1 h-full bg-primary/40 group-hover:bg-primary transition-colors"></div>
                  <div className="flex flex-col md:flex-row md:items-center justify-between gap-4 pl-3">
                    <div>
                      <div className="flex items-center gap-3 mb-1">
                        <span className="font-mono text-lg font-bold tracking-widest text-foreground bg-secondary px-3 py-1 rounded-md">
                          {coupon.code}
                        </span>
                        <span className="text-xs font-semibold px-2 py-0.5 rounded-full bg-primary/10 text-primary">
                          {coupon.region}
                        </span>
                      </div>
                      <p className="text-sm text-muted-foreground">
                        {coupon.type === "PERCENTAGE" ? `${coupon.discount}% ${t("client.financial.off", "off")}` : `${coupon.discount} ${displayWallet.currency} ${t("client.financial.off", "off")}`} {t("client.financial.on_next_booking", "on your next eligible booking.")}
                      </p>
                    </div>
                    <div className="text-right">
                      <p className="text-xs font-medium text-muted-foreground uppercase tracking-wider mb-1">{t("client.financial.expires", "Expires")}</p>
                      <p className="text-sm font-semibold">{new Date(coupon.expiresAt).toLocaleDateString()}</p>
                    </div>
                  </div>
                </div>
              ))}
            </div>
          </div>
        </div>
      </div>

      {/* Transaction History */}
      <div className="bg-card border shadow-sm rounded-3xl p-6 md:p-8">
        <h2 className="text-xl font-bold mb-6 flex items-center gap-2">
          <TrendingUp className="w-5 h-5 text-primary" />{t("client.financial.recent_transactions", "Recent Transactions")}</h2>
        <div className="divide-y border rounded-2xl overflow-hidden">
          {displayWallet.history.map((tx: any) => (
            <div key={tx.id} className="p-4 flex items-center justify-between bg-background hover:bg-secondary/20 transition-colors">
              <div className="flex items-center gap-4">
                <div className={`w-10 h-10 rounded-full flex items-center justify-center ${tx.type === 'CREDIT' ? 'bg-green-500/10 text-green-600' : 'bg-red-500/10 text-red-600'}`}>
                  {tx.type === 'CREDIT' ? <TrendingUp className="w-5 h-5" /> : <TrendingUp className="w-5 h-5 rotate-180" />}
                </div>
                <div>
                  <p className="font-semibold">{tx.description}</p>
                  <p className="text-sm text-muted-foreground">{new Date(tx.date).toLocaleDateString()}</p>
                </div>
              </div>
              <div className={`font-bold text-lg ${tx.type === 'CREDIT' ? 'text-green-600' : ''}`}>
                {tx.type === 'CREDIT' ? '+' : ''}{tx.amount} {displayWallet.currency}
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}

export default Coupons;
