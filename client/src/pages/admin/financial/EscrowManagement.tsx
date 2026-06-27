import { t } from "i18next";
import { useState, useEffect } from "react";
import { PageShell } from "../../client/layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { DollarSign, Shield, AlertTriangle, Clock, Eye, FileText, Scale, Plus, Search, Loader2 } from "lucide-react";
import { useTranslation } from "react-i18next";
import { useToast } from "@/hooks/use-toast";
import { cn } from "@/lib/utils";
import { apiClient } from "@/lib/api";
import { useQuery } from "@tanstack/react-query";
interface EscrowAccount {
  id: string;
  accountNumber: string;
  propertyName: string;
  buyerName: string;
  sellerName: string;
  totalAmount: number;
  currentBalance: number;
  status: 'PENDING' | 'FUNDED' | 'RELEASED' | 'DISPUTED' | 'CLOSED';
  createdAt: string;
  releaseDate?: string;
  dealId: string;
  isZeroDeposit?: boolean;
}
interface EscrowRelease {
  id: string;
  escrowAccountId: string;
  amount: number;
  releaseType: 'FULL' | 'PARTIAL' | 'CONTINGENT';
  recipient: string;
  status: 'PENDING' | 'APPROVED' | 'REJECTED' | 'COMPLETED';
  requestedAt: string;
  processedAt?: string;
  notes?: string;
}
interface EscrowDispute {
  id: string;
  escrowAccountId: string;
  initiatedBy: string;
  disputeType: 'FUNDS' | 'TIMELINE' | 'DOCUMENTS' | 'OTHER';
  description: string;
  status: 'OPEN' | 'INVESTIGATING' | 'RESOLVED' | 'CLOSED';
  createdAt: string;
  resolvedAt?: string;
  resolution?: string;
}
export default function EscrowManagement() {
  const { data: accountsData, isLoading: loadingAccounts } = useQuery({
    queryKey: ['escrowAccounts'],
    queryFn: () => apiClient.get('/escrow/accounts') as Promise<{ data: EscrowAccount[] }>
  });
  
  const { data: releasesData, isLoading: loadingReleases } = useQuery({
    queryKey: ['escrowReleases'],
    queryFn: () => apiClient.get('/escrow-release') as Promise<{ data: EscrowRelease[] }>
  });

  const { data: disputesData, isLoading: loadingDisputes } = useQuery({
    queryKey: ['escrowDisputes'],
    queryFn: () => apiClient.get('/escrow-dispute') as Promise<{ data: EscrowDispute[] }>
  });

  const accounts = Array.isArray(accountsData) ? accountsData : (accountsData?.data || []);
  const releases = releasesData?.data || [];
  const disputes = disputesData?.data || [];
  const loading = loadingAccounts || loadingReleases || loadingDisputes;

  const [searchTerm, setSearchTerm] = useState("");
  const [statusFilter, setStatusFilter] = useState("ALL");
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const getStatusColor = (status: string) => {
    switch (status) {
      case 'PENDING':
        return 'bg-yellow-500';
      case 'FUNDED':
        return 'bg-blue-500';
      case 'RELEASED':
      case 'COMPLETED':
        return 'bg-green-500';
      case 'DISPUTED':
      case 'OPEN':
        return 'bg-red-500';
      case 'CLOSED':
      case 'RESOLVED':
        return 'bg-gray-500';
      case 'APPROVED':
        return 'bg-green-600';
      case 'REJECTED':
        return 'bg-red-600';
      case 'INVESTIGATING':
        return 'bg-orange-500';
      default:
        return 'bg-gray-500';
    }
  };
  const getLocalizedStatus = (status: string) => {
    const map: Record<string, string> = {
      'PENDING': t('admin.financial.pending', 'Bekliyor'),
      'FUNDED': t('admin.financial.funded', 'Fona Aktarıldı'),
      'RELEASED': t('admin.financial.released', 'Serbest Bırakıldı'),
      'DISPUTED': t('admin.financial.disputed', 'İhtilaflı'),
      'CLOSED': t('admin.financial.closed', 'Kapalı'),
      'COMPLETED': t('admin.financial.completed', 'Tamamlandı'),
      'OPEN': t('admin.financial.open', 'Açık'),
      'RESOLVED': t('admin.financial.resolved', 'Çözüldü'),
      'APPROVED': t('admin.financial.approved', 'Onaylandı'),
      'REJECTED': t('admin.financial.rejected', 'Reddedildi'),
      'INVESTIGATING': t('admin.financial.investigating', 'İnceleniyor')
    };
    return map[status] || status;
  };

  const getLocalizedType = (type: string) => {
    const map: Record<string, string> = {
      'FULL': t('admin.financial.full', 'Tam'),
      'PARTIAL': t('admin.financial.partial', 'Kısmi'),
      'CONTINGENT': t('admin.financial.contingent', 'Şarta Bağlı'),
      'FUNDS': t('admin.financial.funds', 'Fonlar'),
      'TIMELINE': t('admin.financial.timeline', 'Zaman Çizelgesi'),
      'DOCUMENTS': t('admin.financial.documents', 'Belgeler'),
      'OTHER': t('admin.financial.other', 'Diğer')
    };
    return map[type] || type;
  };

  const formatCurrency = (amount: number) => {
    return new Intl.NumberFormat('en-US', {
      style: 'currency',
      currency: 'USD'
    }).format(amount);
  };
  const filteredAccounts = accounts.filter(account => {
    const matchesSearch = account.propertyName.toLowerCase().includes(searchTerm.toLowerCase()) || account.buyerName.toLowerCase().includes(searchTerm.toLowerCase()) || account.sellerName.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesStatus = statusFilter === "ALL" || account.status === statusFilter;
    return matchesSearch && matchesStatus;
  });
  const totalEscrowAmount = accounts.reduce((sum, account) => sum + account.totalAmount, 0);
  const totalCurrentBalance = accounts.reduce((sum, account) => sum + account.currentBalance, 0);
  const totalZeroDepositValue = accounts.filter(a => a.isZeroDeposit).reduce((sum, a) => sum + a.totalAmount, 0);
  const activeDisputes = disputes.filter(d => d.status === 'OPEN' || d.status === 'INVESTIGATING').length;
  const pendingReleases = releases.filter(r => r.status === 'PENDING').length;
  if (loading) {
    return <PageShell title={t("admin.financial.escrow_title", "Güvenli Ödeme Yönetimi")}>
        <div className="flex items-center justify-center h-64">
          <Loader2 className="h-8 w-8 animate-spin text-muted-foreground" />
        </div>
      </PageShell>;
  }
  return <PageShell title={t("admin.financial.escrow_title", "Güvenli Ödeme Yönetimi")} description={t("admin.financial.escrow_desc", "Güvenli ödeme işlemlerini, fon aktarımlarını ve ihtilafları yönetin.")}>
      <div className="space-y-10 pb-20">
        {/* KPI Neural Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-5 gap-6 px-4">
           <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t transition-all hover:bg-card">
             <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-muted-foreground">
               <DollarSign className="w-10 h-10" />
             </div>
             <CardContent className="p-8">
               <p className="text-[10px] font-bold text-muted-foreground mb-1">{t("admin.financial.total", "TOPLAM")}</p>
               <h3 className="text-3xl font-bold text-foreground leading-none">{formatCurrency(totalEscrowAmount)}</h3>
               <p className="text-[10px] text-muted-foreground mt-2 font-bold">{accounts.length}{t("admin.financial.active_accounts", "Aktif Hesap")}</p>
             </CardContent>
           </Card>

           <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t transition-all hover:bg-card">
             <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-emerald-500">
               <Shield className="w-10 h-10" />
             </div>
             <CardContent className="p-8">
               <p className="text-[10px] font-bold text-muted-foreground mb-1">{t("admin.financial.balance", "BAKİYE")}</p>
               <h3 className="text-3xl font-bold text-emerald-400 leading-none">{formatCurrency(totalCurrentBalance)}</h3>
               <p className="text-[10px] text-muted-foreground mt-2 font-bold">{t("admin.financial.held_funds", "Güvencede Tutulan Fon")}</p>
             </CardContent>
           </Card>

           {/* ZERO-DEPOSIT KART */}
           <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t transition-all hover:bg-card">
             <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-blue-500">
               <Shield className="w-10 h-10" />
             </div>
             <CardContent className="p-8">
               <p className="text-[10px] font-bold text-muted-foreground mb-1">ZERO-DEPOSIT (SİGORTA)</p>
               <h3 className="text-3xl font-bold text-blue-400 leading-none">{formatCurrency(totalZeroDepositValue)}</h3>
               <p className="text-[10px] text-muted-foreground mt-2 font-bold">Teminat Altındaki Fon</p>
             </CardContent>
           </Card>

           <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t transition-all hover:bg-card">
             <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-red-500">
               <AlertTriangle className="w-10 h-10" />
             </div>
             <CardContent className="p-8">
               <p className="text-[10px] font-bold text-muted-foreground mb-1">{t("admin.financial.disputes", "İHTİLAFLAR")}</p>
               <h3 className="text-3xl font-bold text-red-400 leading-none">{activeDisputes}</h3>
               <p className="text-[10px] text-muted-foreground mt-2 font-bold">{t("admin.financial.require_attention", "Dikkat Gerektirir")}</p>
             </CardContent>
           </Card>

           <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t transition-all hover:bg-card">
             <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-orange-500">
               <Clock className="w-10 h-10" />
             </div>
             <CardContent className="p-8">
               <p className="text-[10px] font-bold text-muted-foreground mb-1">{t("admin.financial.pending_releases", "Bekleyen Çıkışlar")}</p>
               <h3 className="text-3xl font-bold text-orange-400 leading-none">{pendingReleases}</h3>
               <p className="text-[10px] text-muted-foreground mt-2 font-bold">{t("admin.financial.awaiting_approval", "Onay Bekleyen")}</p>
             </CardContent>
           </Card>
        </div>

        <Tabs defaultValue="accounts" className="space-y-8 px-4">
          <TabsList className="bg-card border-border p-1 rounded-2xl border-l border-t mb-4">
            <TabsTrigger value="accounts" className="rounded-xl px-8 font-bold text-[10px] data-[state=active]:bg-orange-500 data-[state=active]:text-foreground">
              {t("admin.financial.accounts", "Güvenli Ödeme Hesapları")}
            </TabsTrigger>
            <TabsTrigger value="releases" className="rounded-xl px-8 font-bold text-[10px] data-[state=active]:bg-orange-500 data-[state=active]:text-foreground">
              {t("admin.financial.releases", "Serbest Bırakılanlar")}
            </TabsTrigger>
            <TabsTrigger value="disputes" className="rounded-xl px-8 font-bold text-[10px] data-[state=active]:bg-orange-500 data-[state=active]:text-foreground">
              {t("admin.financial.disputes", "İhtilaflar")}
            </TabsTrigger>
          </TabsList>

          <TabsContent value="accounts" className="space-y-4">
            <div className="flex flex-col lg:flex-row items-center justify-between gap-6 mb-8">
              <div className="flex flex-wrap items-center gap-3 flex-1">
                <div className="relative group min-w-[320px]">
                  <Search className="absolute left-4 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground group-focus-within:text-orange-500 transition-colors" />
                  <Input placeholder={t("admin.financial.search", "Ara...")} value={searchTerm} onChange={e => setSearchTerm(e.target.value)} className="bg-card border-border rounded-2xl pl-12 h-14 text-foreground focus:ring-orange-500/20 focus:border-orange-500/40 transition-all font-medium border-l border-t shadow-2xl" />
                </div>
                <Select value={statusFilter} onValueChange={setStatusFilter}>
                  <SelectTrigger className="h-14 w-44 bg-card border-border rounded-2xl text-[10px] font-bold tracking-[0.2em] text-muted-foreground focus:ring-orange-500/20 border-l border-t transition-all">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent className="bg-card border-border rounded-2xl">
                    <SelectItem value="ALL" className="font-bold text-[10px]">{t("admin.financial.all_status")}</SelectItem>
                    <SelectItem value="PENDING" className="font-bold text-[10px]">{t("admin.financial.pending")}</SelectItem>
                    <SelectItem value="FUNDED" className="font-bold text-[10px]">{t("admin.financial.funded")}</SelectItem>
                    <SelectItem value="RELEASED" className="font-bold text-[10px]">{t("admin.financial.released")}</SelectItem>
                    <SelectItem value="DISPUTED" className="font-bold text-[10px]">{t("admin.financial.disputed")}</SelectItem>
                    <SelectItem value="CLOSED" className="font-bold text-[10px]">{t("admin.financial.closed")}</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <Button className="bg-blue-600 hover:bg-blue-500 text-foreground h-14 px-8 rounded-2xl font-bold text-[10px] gap-3 shadow-xl shadow-blue-600/20">
                <Plus className="h-4 w-4" />
                {t("admin.financial.new_escrow", "Yeni Güvenli Ödeme Hesabı")}
              </Button>
            </div>

            <Card>
              <CardHeader>
                <CardTitle>{t("admin.financial.escrow_accounts")}</CardTitle>
              </CardHeader>
              <CardContent>
                <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead>{t("admin.financial.account")}</TableHead>
                      <TableHead>{t("admin.financial.property")}</TableHead>
                      <TableHead>{t("admin.financial.parties")}</TableHead>
                      <TableHead>Type</TableHead>
                      <TableHead>{t("admin.financial.amount")}</TableHead>
                      <TableHead>{t("admin.financial.balance")}</TableHead>
                      <TableHead>{t("admin.financial.status")}</TableHead>
                      <TableHead>{t("admin.financial.created")}</TableHead>
                      <TableHead>{t("admin.financial.actions")}</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {filteredAccounts.map(account => <TableRow key={account.id}>
                        <TableCell className="font-medium">
                          #{account.accountNumber}
                        </TableCell>
                        <TableCell>{account.propertyName}</TableCell>
                        <TableCell>
                          <div className="text-sm">
                            <div>{t("admin.financial.buyer")}{account.buyerName}</div>
                            <div>{t("admin.financial.seller")}{account.sellerName}</div>
                          </div>
                        </TableCell>
                        <TableCell>
                          {account.isZeroDeposit ? (
                            <Badge className="bg-blue-500/20 text-blue-500 border-0 text-xs">Surety Bond</Badge>
                          ) : (
                            <Badge className="bg-emerald-500/20 text-emerald-500 border-0 text-xs">Cash Escrow</Badge>
                          )}
                        </TableCell>
                        <TableCell>{formatCurrency(account.totalAmount)}</TableCell>
                        <TableCell>{formatCurrency(account.currentBalance)}</TableCell>
                        <TableCell>
                          <div className="flex items-center gap-2">
                            <div className={`w-2 h-2 rounded-full ${getStatusColor(account.status)}`} />
                            <span>{getLocalizedStatus(account.status)}</span>
                          </div>
                        </TableCell>
                        <TableCell>{new Date(account.createdAt).toLocaleDateString()}</TableCell>
                        <TableCell>
                          <Button variant="ghost" size="sm">
                            <Eye className="h-4 w-4" />
                          </Button>
                        </TableCell>
                      </TableRow>)}
                  </TableBody>
                </Table>
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="releases" className="space-y-4">
            <Card>
              <CardHeader>
                <CardTitle>{t("admin.financial.release_requests")}</CardTitle>
              </CardHeader>
              <CardContent>
                <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead>{t("admin.financial.account")}</TableHead>
                      <TableHead>{t("admin.financial.amount")}</TableHead>
                      <TableHead>{t("admin.financial.type")}</TableHead>
                      <TableHead>{t("admin.financial.recipient")}</TableHead>
                      <TableHead>{t("admin.financial.status")}</TableHead>
                      <TableHead>{t("admin.financial.requested")}</TableHead>
                      <TableHead>{t("admin.financial.processed")}</TableHead>
                      <TableHead>{t("admin.financial.actions")}</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {releases.map(release => <TableRow key={release.id}>
                        <TableCell className="font-medium">
                          #{release.escrowAccountId}
                        </TableCell>
                        <TableCell>{formatCurrency(release.amount)}</TableCell>
                        <TableCell>
                          <Badge variant="outline">{getLocalizedType(release.releaseType)}</Badge>
                        </TableCell>
                        <TableCell>{release.recipient}</TableCell>
                        <TableCell>
                          <div className="flex items-center gap-2">
                            <div className={`w-2 h-2 rounded-full ${getStatusColor(release.status)}`} />
                            <span>{getLocalizedStatus(release.status)}</span>
                          </div>
                        </TableCell>
                        <TableCell>{new Date(release.requestedAt).toLocaleDateString()}</TableCell>
                        <TableCell>
                          {release.processedAt ? new Date(release.processedAt).toLocaleDateString() : '-'}
                        </TableCell>
                        <TableCell>
                          <Button variant="ghost" size="sm">
                            <FileText className="h-4 w-4" />
                          </Button>
                        </TableCell>
                      </TableRow>)}
                  </TableBody>
                </Table>
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="disputes" className="space-y-4">
            <div className="flex justify-end">
              <Button>
                <Plus className="h-4 w-4 mr-2" />{t("admin.financial.new_dispute")}</Button>
            </div>

            <Card>
              <CardHeader>
                <CardTitle>{t("admin.financial.escrow_disputes")}</CardTitle>
              </CardHeader>
              <CardContent>
                <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead>{t("admin.financial.account")}</TableHead>
                      <TableHead>{t("admin.financial.initiated_by")}</TableHead>
                      <TableHead>{t("admin.financial.type")}</TableHead>
                      <TableHead>{t("admin.financial.description")}</TableHead>
                      <TableHead>{t("admin.financial.status")}</TableHead>
                      <TableHead>{t("admin.financial.created")}</TableHead>
                      <TableHead>{t("admin.financial.resolution")}</TableHead>
                      <TableHead>{t("admin.financial.actions")}</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {disputes.map(dispute => <TableRow key={dispute.id}>
                        <TableCell className="font-medium">
                          #{dispute.escrowAccountId}
                        </TableCell>
                        <TableCell>{dispute.initiatedBy}</TableCell>
                        <TableCell>
                          <Badge variant="outline">{getLocalizedType(dispute.disputeType)}</Badge>
                        </TableCell>
                        <TableCell className="max-w-xs truncate">
                          {dispute.description}
                        </TableCell>
                        <TableCell>
                          <div className="flex items-center gap-2">
                            <div className={`w-2 h-2 rounded-full ${getStatusColor(dispute.status)}`} />
                            <span>{getLocalizedStatus(dispute.status)}</span>
                          </div>
                        </TableCell>
                        <TableCell>{new Date(dispute.createdAt).toLocaleDateString()}</TableCell>
                        <TableCell>
                          {dispute.resolution ? <span className="text-sm text-green-600">{dispute.resolution}</span> : <span className="text-sm text-muted-foreground">{t("admin.financial.pending")}</span>}
                        </TableCell>
                        <TableCell>
                          <Button variant="ghost" size="sm">
                            <Scale className="h-4 w-4" />
                          </Button>
                        </TableCell>
                      </TableRow>)}
                  </TableBody>
                </Table>
              </CardContent>
            </Card>
          </TabsContent>
        </Tabs>
      </div>
    </PageShell>;
}