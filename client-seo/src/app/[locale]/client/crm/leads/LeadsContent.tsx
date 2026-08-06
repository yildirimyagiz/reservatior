"use client";

import { useEffect, useState } from "react";
import { useTranslation } from "react-i18next";
import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Facebook, User, DollarSign, Clock, ShieldCheck } from "lucide-react";
import { formatDistanceToNow } from "date-fns";
import { useToast } from "@/hooks/use-toast";

// Use apiClient or fetch directly. For simplicity, we use fetch to our backend.
const API_URL = process.env.NEXT_PUBLIC_API_URL || "http://localhost:3000/api/v1";
const WEBHOOKS_URL = "http://localhost:3000/api/webhooks/ads";

export function LeadsContent() {
  const { t } = useTranslation();
  const { toast } = useToast();
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  const [leads, setLeads] = useState<any[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [isSimulating, setIsSimulating] = useState(false);

  const fetchLeads = async () => {
    try {
      const token = localStorage.getItem("auth_token");
      const res = await fetch(`${API_URL}/lead`, {
        headers: {
          'Authorization': `Bearer ${token}`
        }
      });
      if (res.ok) {
        const data = await res.json();
        setLeads(data.data || []);
      }
    } catch (error) {
      console.error("Failed to fetch leads", error);
    } finally {
      setIsLoading(false);
    }
  };

  useEffect(() => {
    fetchLeads();
    const interval = setInterval(fetchLeads, 5000);
    return () => clearInterval(interval);
  }, []);

  const simulateLead = async () => {
    setIsSimulating(true);
    try {
      const res = await fetch(`${WEBHOOKS_URL}/lead`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          firstName: "John",
          lastName: "Doe",
          email: "john.ad.click@example.com",
          phone: "555-010-9999",
          campaignId: "cmp_demo_auto_reels"
        })
      });
      if (res.ok) {
        toast({
          title: t("leads.ad_lead_created"),
          description: t("leads.ad_lead_created_desc")
        });
        fetchLeads();
      }
    } catch (error) {
      console.error("Simulation failed", error);
    } finally {
      setIsSimulating(false);
    }
  };

  const closeDeal = async (leadId: string) => {
    try {
      const price = Math.floor(Math.random() * 500000) + 300000;
      
      const res = await fetch(`${WEBHOOKS_URL}/${leadId}/close-deal`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          price: price,
          commissionRate: 3.0
        })
      });
      
      if (res.ok) {
        toast({
          title: t("leads.deal_closed"),
          description: t("leads.deal_closed_desc", { price: price.toLocaleString() }),
          variant: "default"
        });
        fetchLeads();
      }
    } catch (error) {
      console.error("Close deal failed", error);
    }
  };

  if (isLoading) return <div className="p-8">{t("leads.loading_pipeline")}</div>;

  return (
    <div className="container mx-auto p-6 space-y-8">
      <div className="flex justify-between items-center">
        <div>
          <h1 className="text-3xl font-bold">{t("leads.sales_pipeline")}</h1>
          <p className="text-muted-foreground">{t("leads.sales_pipeline_desc")}</p>
        </div>
        
        <Button onClick={simulateLead} disabled={isSimulating} className="bg-blue-600 hover:bg-brand text-white gap-2">
          <Facebook className="w-4 h-4" />
          {t("leads.simulate_meta_ad")}
        </Button>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-6">
        {/* NEW LEADS */}
        <div className="space-y-4">
          <div className="flex items-center justify-between border-b pb-2">
            <h3 className="font-semibold text-lg flex items-center gap-2">
              <span className="w-2 h-2 rounded-full bg-brand/100"></span>
              {t("leads.new_leads")}
            </h3>
            <Badge variant="secondary">{leads.filter(l => l.status === 'NEW').length}</Badge>
          </div>
          
          {leads.filter(l => l.status === 'NEW').map(lead => (
            <Card key={lead.id} className="border-l-4 border-l-blue-500 hover:shadow-md transition-all">
              <CardContent className="p-4 space-y-4">
                <div className="flex justify-between items-start">
                  <div>
                    <h4 className="font-bold flex items-center gap-2">
                      <User className="w-4 h-4 text-muted-foreground" />
                      {lead.firstName} {lead.lastName}
                    </h4>
                    <p className="text-xs text-muted-foreground truncate">{lead.email}</p>
                  </div>
                  <Badge variant="outline" className="text-[10px] bg-brand/10 text-brand border-border">{t("leads.ai_ads")}</Badge>
                </div>
                
                <div className="flex items-center gap-2 text-xs text-muted-foreground">
                  <Clock className="w-3 h-3" />
                  {formatDistanceToNow(new Date(lead.createdAt), { addSuffix: true })}
                </div>

                <div className="pt-2 border-t flex justify-end">
                  <Button size="sm" onClick={() => closeDeal(lead.id)} className="w-full bg-blue-600 hover:bg-blue-700 text-white">
                    <DollarSign className="w-4 h-4 mr-1" /> {t("leads.close_deal")}
                  </Button>
                </div>
              </CardContent>
            </Card>
          ))}
          {leads.filter(l => l.status === 'NEW').length === 0 && (
            <div className="text-center p-8 border border-dashed rounded-xl text-muted-foreground text-sm">
              {t("leads.waiting_for_interactions")}
            </div>
          )}
        </div>

        {/* QUALIFIED / CLOSED */}
        <div className="space-y-4">
          <div className="flex items-center justify-between border-b pb-2">
            <h3 className="font-semibold text-lg flex items-center gap-2">
              <span className="w-2 h-2 rounded-full bg-success"></span>
              {t("leads.closed_won")}
            </h3>
            <Badge variant="secondary">{leads.filter(l => l.status === 'QUALIFIED').length}</Badge>
          </div>
          
          {leads.filter(l => l.status === 'QUALIFIED').map(lead => (
            <Card key={lead.id} className="border-l-4 border-l-blue-500 bg-blue-50/50 opacity-80">
              <CardContent className="p-4 space-y-4">
                <div className="flex justify-between items-start">
                  <div>
                    <h4 className="font-bold flex items-center gap-2 line-through text-muted-foreground">
                      <User className="w-4 h-4 text-muted-foreground" />
                      {lead.firstName} {lead.lastName}
                    </h4>
                  </div>
                  <Badge className="text-[10px] bg-success hover:bg-blue-600">{t("leads.won")}</Badge>
                </div>
                <div className="flex items-center gap-2 text-xs text-success font-medium">
                  <ShieldCheck className="w-4 h-4" />
                  {t("leads.commission_installments_offered")}
                </div>
              </CardContent>
            </Card>
          ))}
        </div>

      </div>
    </div>
  );
}
