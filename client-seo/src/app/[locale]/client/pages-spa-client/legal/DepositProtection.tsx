"use client";

import { useTranslation } from "react-i18next";
import { useState } from "react";
import { Card, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { ShieldCheck, ShieldAlert, FileText, Calendar, DollarSign, Search, Plus, ExternalLink, ArrowRightLeft } from "lucide-react";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { PageShell } from "../layout/PageShell";
import { useEffect } from "react";
import { apiClient } from "@/lib/api/client";
interface DepositRecord {
  id: string;
  leaseId: string;
  property: string;
  tenant: string;
  amount: number;
  currency: string;
  provider: string; // TDS, DPS, MyDeposits
  scheme: string; // Custodial, Insured
  reference: string;
  status: 'pending' | 'protected' | 'claimed' | 'returned' | 'disputed';
  protectedAt?: string;
  expiresAt?: string;
}
export default function DepositProtection() {
  const {
    t
  } = useTranslation();
  const [deposits, setDeposits] = useState<DepositRecord[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [searchQuery, setSearchQuery] = useState("");

  useEffect(() => {
    const fetchDeposits = async () => {
      try {
        setIsLoading(true);
        const res: any = await apiClient.get('/legal/deposits').catch(() => null);
        if (res && res.data) {
          setDeposits(res.data);
        } else {
          setDeposits([]);
        }
      } catch (error) {
        console.error('Failed to fetch deposits:', error);
      } finally {
        setIsLoading(false);
      }
    };
    fetchDeposits();
  }, []);
  const getStatusBadge = (status: DepositRecord['status']) => {
    switch (status) {
      case 'protected':
        return <Badge className="bg-blue-100 text-blue-800 border-blue-200"><ShieldCheck className="w-3 h-3 mr-1" />{t("client.src.protected")}</Badge>;
      case 'pending':
        return <Badge variant="outline" className="text-yellow-600 border-yellow-200 bg-yellow-50"><Calendar className="w-3 h-3 mr-1" />{t("common.processing")}</Badge>;
      case 'claimed':
        return <Badge className="bg-orange-100 text-orange-800 border-orange-200">{t("client.src.claimed")}</Badge>;
      case 'returned':
        return <Badge className="bg-blue-100 text-blue-800 border-border">{t("client.src.returned")}</Badge>;
      case 'disputed':
        return <Badge variant="destructive"><ShieldAlert className="w-3 h-3 mr-1" />{t("common.disputed")}</Badge>;
    }
  };
  return <PageShell title={t("client.src.deposit_protection")} description={t("client.src.manage_tenancy_deposits_and")}>
      <div className="space-y-6">
        {/* Stats */}
        <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
          <Card className="bg-gradient-to-br from-brand to-white">
            <CardContent className="pt-4">
              <div className="flex justify-between items-center text-brand">
                <ShieldCheck className="w-8 h-8" />
                <span className="text-2xl font-bold">128</span>
              </div>
              <p className="text-sm text-muted-foreground mt-2 font-medium">{t("client.src.active_protections")}</p>
            </CardContent>
          </Card>
          <Card className="bg-gradient-to-r from-blue-600 to-info text-white shadow-xl border-none">
            <CardContent className="pt-4">
              <div className="flex justify-between items-center text-yellow-600">
                <Calendar className="w-8 h-8" />
                <span className="text-2xl font-bold">12</span>
              </div>
              <p className="text-sm text-muted-foreground mt-2 font-medium">{t("client.src.pending_registration")}</p>
            </CardContent>
          </Card>
          <Card className="bg-gradient-to-br from-blue-50 to-white">
            <CardContent className="pt-4">
              <div className="flex justify-between items-center text-blue-600">
                <DollarSign className="w-8 h-8" />
                <span className="text-2xl font-bold">{t("client.src.1842k")}</span>
              </div>
              <p className="text-sm text-muted-foreground mt-2 font-medium">{t("client.src.total_funds_held")}</p>
            </CardContent>
          </Card>
          <Card className="bg-gradient-to-br from-red-50 to-white">
            <CardContent className="pt-4">
              <div className="flex justify-between items-center text-red-600">
                <ShieldAlert className="w-8 h-8" />
                <span className="text-2xl font-bold">3</span>
              </div>
              <p className="text-sm text-muted-foreground mt-2 font-medium">{t("client.src.disputes_open")}</p>
            </CardContent>
          </Card>
        </div>

        {/* Actions & Search */}
        <div className="flex flex-col md:flex-row gap-4 justify-between items-center">
          <div className="relative w-full md:w-96">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
            <Input placeholder={t("client.src.search_by_tenant_or")} className="pl-10" value={searchQuery} onChange={e => setSearchQuery(e.target.value)} />
          </div>
          <div className="flex gap-2 w-full md:w-auto">
            <Button variant="outline"><FileText className="w-4 h-4 mr-2" />{t("client.src.export_report")}</Button>
            <Button className="bg-brand hover:bg-brand shadow-lg shadow-indigo-100"><Plus className="w-4 h-4 mr-2" />{t("client.src.new_protection")}</Button>
          </div>
        </div>

        {/* Main Content */}
        <Tabs defaultValue="all" className="w-full">
          <TabsList>
            <TabsTrigger value="all">{t("client.src.all_deposits")}</TabsTrigger>
            <TabsTrigger value="active">{t("common.active")}</TabsTrigger>
            <TabsTrigger value="pending">{t("common.processing")}</TabsTrigger>
            <TabsTrigger value="disputes">{t("client.src.disputes")}</TabsTrigger>
          </TabsList>

          <TabsContent value="all" className="mt-4">
            <div className="grid gap-4">
              {isLoading ? (
                <p className="text-muted-foreground">Loading...</p>
              ) : deposits.length === 0 ? (
                <p className="text-muted-foreground">No deposits found.</p>
              ) : deposits.map(deposit => <Card key={deposit.id} className="hover:shadow-md transition-all border-l-4 border-l-indigo-500 overflow-hidden">
                  <CardContent className="p-0">
                    <div className="flex flex-col md:flex-row">
                      <div className="p-6 flex-1">
                        <div className="flex justify-between items-start mb-4">
                          <div>
                            <h3 className="text-lg font-bold">{deposit.property}</h3>
                            <p className="text-sm text-muted-foreground flex items-center">{t("common.tenant")}<span className="font-semibold text-foreground ml-1">{deposit.tenant}</span>
                            </p>
                          </div>
                          {getStatusBadge(deposit.status)}
                        </div>

                        <div className="grid grid-cols-2 md:grid-cols-4 gap-4 text-sm">
                          <div>
                            <p className="text-muted-foreground flex items-center"><DollarSign className="w-3 h-3 mr-1" />{t("common.amount")}</p>
                            <p className="font-bold text-lg">{deposit.currency} {deposit.amount.toLocaleString()}</p>
                          </div>
                          <div>
                            <p className="text-muted-foreground">{t("client.src.providerscheme")}</p>
                            <p className="font-medium text-brand">{deposit.provider} ({deposit.scheme})</p>
                          </div>
                          <div>
                            <p className="text-muted-foreground">{t("client.src.reference")}</p>
                            <p className="font-mono bg-muted px-2 py-0.5 rounded text-xs inline-block">{deposit.reference}</p>
                          </div>
                          <div>
                            <p className="text-muted-foreground">{t("client.src.protected_at")}</p>
                            <p className="font-medium text-foreground">{deposit.protectedAt || 'N/A'}</p>
                          </div>
                        </div>
                      </div>

                      <div className="bg-muted/30 p-4 flex md:flex-col justify-center gap-2 border-t md:border-t-0 md:border-l w-full md:w-48">
                        <Button variant="ghost" size="sm" className="w-full justify-start hover:bg-card">
                          <FileText className="w-4 h-4 mr-2 text-brand" />{t("client.src.certificate")}</Button>
                        <Button variant="ghost" size="sm" className="w-full justify-start hover:bg-card text-warning">
                          <ArrowRightLeft className="w-4 h-4 mr-2" />{t("client.src.start_claim")}</Button>
                        <Button variant="ghost" size="sm" className="w-full justify-start hover:bg-card">
                          <ExternalLink className="w-4 h-4 mr-2" />{t("client.src.provider_portal")}</Button>
                      </div>
                    </div>
                  </CardContent>
                </Card>)}
            </div>
          </TabsContent>
        </Tabs>

        {/* Info Banner */}
        <div className="bg-brand rounded-2xl p-6 text-white flex items-center justify-between">
          <div>
            <h3 className="text-xl font-bold mb-1">{t("client.src.stay_compliant_stay_protected")}</h3>
            <p className="text-brand max-w-xl">{t("client.src.legally_tenancy_deposits_must")}</p>
          </div>
          <Button variant="secondary" className="hidden lg:flex text-brand font-bold">{t("client.src.learn_more")}</Button>
        </div>
      </div>
    </PageShell>;
}