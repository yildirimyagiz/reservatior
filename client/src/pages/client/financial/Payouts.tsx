import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { useQuery } from "@tanstack/react-query";
import { PageShell } from "../layout/PageShell";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { useToast } from "@/hooks/use-toast";
import { financialsApi, type Payout } from "@/lib/api/financials";
import { MoreHorizontal, Loader2, RefreshCw, Eye } from "lucide-react";
const STATUS: Record<string, {
  label: string;
  cls: string;
}> = {
  PAID: {
    label: t("client.src.paid"),
    cls: "bg-green-100 text-green-700"
  },
  PENDING: {
    label: t("client.src.pending"),
    cls: "bg-yellow-100 text-yellow-700"
  },
  SCHEDULED: {
    label: t("client.src.scheduled"),
    cls: "bg-blue-100 text-blue-700"
  },
  FAILED: {
    label: t("client.src.failed"),
    cls: "bg-red-100 text-red-700"
  }
};
export default function Payouts() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const [search, setSearch] = useState("");
  const { data: payoutsData = [], isLoading: loading, refetch: fetchPayouts } = useQuery<Payout[]>({
    queryKey: ['myPayouts'],
    queryFn: async () => {
      try {
        const response = (await financialsApi.getPayouts({
          orgId: 'current-user'
        })) as any;
        const data = Array.isArray(response) ? response : response?.data || [];
        return data.map((payout: any) => ({
          ...payout,
          id: payout?.id || 'unknown',
          status: payout?.status || 'pending',
          amount: payout?.amount || 0,
          currency: payout?.currency || 'USD',
          scheduledAt: payout?.scheduledAt || new Date().toISOString(),
          createdAt: payout?.createdAt || new Date().toISOString()
        }));
      } catch (error) {
        toast({
          title: t("client.src.error"),
          description: t("client.src.failed_to_load_your"),
          variant: "destructive"
        });
        return [];
      }
    }
  });

  const payouts = payoutsData || [];
  const filtered = payouts.filter(row => row.status?.toLowerCase().includes(search.toLowerCase()) || row.id?.toLowerCase().includes(search.toLowerCase()));

  // Client users can only view, not create/edit/delete
  const handleViewDetails = (payout: Payout) => {
    toast({
      title: t("client.src.payout_details"),
      description: `Amount: $${payout.amount} ${payout.currency} | Status: ${payout.status}`
    });
  };
  return <PageShell title={t("client.src.my_payouts")} description={t("client.src.view_your_payment_history")}>
      <div className="flex items-center justify-between mb-6">
        <div className="flex items-center gap-3 flex-1">
          <Input placeholder={t("client.src.search_payouts")} value={search} onChange={e => setSearch(e.target.value)} className="max-w-sm" />
        </div>
        <Button variant="outline" onClick={() => fetchPayouts()} disabled={loading}>
          {loading ? <Loader2 className="w-4 h-4 animate-spin mr-2" /> : <RefreshCw className="w-4 h-4 mr-2" />}{t("client.src.refresh")}</Button>
      </div>

      <div className="bg-card border border-border rounded-xl overflow-hidden shadow-sm">
        <div className="grid gap-4 p-6">
          {loading ? <div className="text-center py-12"><Loader2 className="w-6 h-6 animate-spin mx-auto" /></div> : filtered.length === 0 ? <div className="text-center py-12 text-muted-foreground">{t("client.src.no_payouts_found")}</div> : filtered.map(row => <div key={row.id} className="flex items-center justify-between p-4 border rounded-lg hover:bg-muted/40">
                <div className="flex-1">
                  <div className="flex items-center gap-4 mb-2">
                    <span className="text-sm font-mono text-muted-foreground">{row.id.slice(0, 8)}...</span>
                    {STATUS[row.status] ? <Badge className={`${STATUS[row.status].cls} border-0 text-xs shadow-sm`}>{STATUS[row.status].label}</Badge> : <span className="text-xs text-muted-foreground">{row.status}</span>}
                  </div>
                  <div className="flex items-center gap-6 text-sm">
                    <span className="font-semibold">${row.amount.toLocaleString()} {row.currency}</span>
                    <span className="text-muted-foreground">{row.scheduledAt ? new Date(row.scheduledAt).toLocaleDateString() : "—"}</span>
                  </div>
                </div>
                <Button variant="ghost" size="sm" onClick={() => handleViewDetails(row)}>
                  <Eye className="w-4 h-4 mr-2" />{t("client.src.view")}</Button>
              </div>)}
        </div>
      </div>
    </PageShell>;
}