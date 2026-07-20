"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { PageShell } from "../layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { FileText, Pen, CheckCircle, Send, Download, Plus, Search, Eye, Shield, Lock, Unlock } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { apiClient } from "@/lib/api/client";
interface Contract {
  id: string;
  title: string;
  type: 'PURCHASE' | 'LEASE' | 'SERVICE' | 'NDA' | 'OTHER';
  status: 'DRAFT' | 'PENDING_SIGNATURE' | 'SIGNED' | 'EXECUTED' | 'EXPIRED' | 'TERMINATED';
  version: number;
  parties: string[];
  createdDate: string;
  lastModified: string;
  executionDate?: string;
  expiryDate?: string;
}
interface SignatureRequest {
  id: string;
  contractId: string;
  contractTitle: string;
  signerName: string;
  signerEmail: string;
  status: 'PENDING' | 'SIGNED' | 'DECLINED' | 'EXPIRED';
  sentDate: string;
  signedDate?: string;
  signatureMethod: 'EMAIL' | 'IN_PERSON' | 'DIGITAL';
  reminderCount: number;
}
interface DocumentTemplate {
  id: string;
  name: string;
  category: 'CONTRACT' | 'AGREEMENT' | 'DISCLOSURE' | 'FORM' | 'OTHER';
  description: string;
  isActive: boolean;
  usageCount: number;
  lastUsed?: string;
  createdAt: string;
}
export default function DocumentWorkflow() {
  const {
    t
  } = useTranslation();
  const [contracts, setContracts] = useState<Contract[]>([]);
  const [signatureRequests, setSignatureRequests] = useState<SignatureRequest[]>([]);
  // const [signers, setSigners] = useState<SignatureSigner[]>([]);
  const [templates, setTemplates] = useState<DocumentTemplate[]>([]);
  const [loading, setLoading] = useState(true);
  const [searchTerm, setSearchTerm] = useState("");
  const [statusFilter, setStatusFilter] = useState("ALL");
  // const [showSignatureDialog, setShowSignatureDialog] = useState(false);
  // const [showContractDialog, setShowContractDialog] = useState(false);
  const {
    toast
  } = useToast();
  useEffect(() => {
    fetchDocumentData();
  }, []);
  const fetchDocumentData = async () => {
    try {
      const [contractsRes, signaturesRes, templatesRes] = await Promise.all([apiClient.get('/documents/contracts') as Promise<{
        data: Contract[];
      }>, apiClient.get('/documents/signature-requests') as Promise<{
        data: SignatureRequest[];
      }>, apiClient.get('/documents/templates') as Promise<{
        data: DocumentTemplate[];
      }>]);
      setContracts(contractsRes.data);
      setSignatureRequests(signaturesRes.data);
      setTemplates(templatesRes.data);
    } catch (error) {
      toast({
        title: t("client.src.error"),
        description: t("client.src.failed_to_fetch_document"),
        variant: "destructive"
      });
    } finally {
      setLoading(false);
    }
  };
  const getStatusColor = (status: string) => {
    switch (status) {
      case 'DRAFT':
        return 'bg-gray-500';
      case 'PENDING_SIGNATURE':
      case 'PENDING':
        return 'bg-yellow-500';
      case 'SIGNED':
      case 'EXECUTED':
        return 'bg-green-500';
      case 'DECLINED':
      case 'TERMINATED':
        return 'bg-red-500';
      case 'EXPIRED':
        return 'bg-orange-500';
      default:
        return 'bg-gray-500';
    }
  };
  const filteredContracts = contracts.filter(contract => {
    const matchesSearch = contract.title.toLowerCase().includes(searchTerm.toLowerCase()) || contract.parties.some(party => party.toLowerCase().includes(searchTerm.toLowerCase()));
    const matchesStatus = statusFilter === "ALL" || contract.status === statusFilter;
    return matchesSearch && matchesStatus;
  });
  const pendingSignatures = signatureRequests.filter(s => s.status === 'PENDING').length;
  const signedToday = signatureRequests.filter(s => s.status === 'SIGNED' && s.signedDate && new Date(s.signedDate).toDateString() === new Date().toDateString()).length;
  const activeTemplates = templates.filter(t => t.isActive).length;
  const totalContracts = contracts.length;
  if (loading) {
    return <PageShell title={t("client.src.document_workflow")}>
        <div className="flex items-center justify-center h-64">
          <FileText className="h-8 w-8 animate-spin" />
        </div>
      </PageShell>;
  }
  return <PageShell title={t("client.src.document_workflow")}>
      <div className="space-y-6">
        {/* Overview Cards */}
        <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("client.src.total_contracts")}</CardTitle>
              <FileText className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{totalContracts}</div>
              <p className="text-xs text-muted-foreground">{t("client.src.all_documents")}</p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("client.src.pending_signatures")}</CardTitle>
              <Pen className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-yellow-600">{pendingSignatures}</div>
              <p className="text-xs text-muted-foreground">{t("client.src.awaiting_signature")}</p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("client.src.signed_today")}</CardTitle>
              <CheckCircle className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-green-600">{signedToday}</div>
              <p className="text-xs text-muted-foreground">{t("client.src.completed_today")}</p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("client.src.active_templates")}</CardTitle>
              <Shield className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{activeTemplates}</div>
              <p className="text-xs text-muted-foreground">{t("client.src.of")}{templates.length}{t("client.src.total")}</p>
            </CardContent>
          </Card>
        </div>

        <Tabs defaultValue="contracts" className="space-y-4">
          <TabsList>
            <TabsTrigger value="contracts">{t("client.src.contracts")}</TabsTrigger>
            <TabsTrigger value="signatures">{t("client.src.signature_requests")}</TabsTrigger>
            <TabsTrigger value="templates">{t("client.src.templates")}</TabsTrigger>
          </TabsList>

          <TabsContent value="contracts" className="space-y-4">
            <div className="flex justify-between items-center">
              <div className="flex gap-2">
                <div className="relative">
                  <Search className="absolute left-2 top-2.5 h-4 w-4 text-muted-foreground" />
                  <Input placeholder={t("client.src.search_contracts")} value={searchTerm} onChange={e => setSearchTerm(e.target.value)} className="pl-8 w-64" />
                </div>
                <Select value={statusFilter} onValueChange={setStatusFilter}>
                  <SelectTrigger className="w-32">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="ALL">{t("client.src.all_status")}</SelectItem>
                    <SelectItem value="DRAFT">{t("client.src.draft")}</SelectItem>
                    <SelectItem value="PENDING_SIGNATURE">{t("client.src.pending")}</SelectItem>
                    <SelectItem value="SIGNED">{t("client.src.signed")}</SelectItem>
                    <SelectItem value="EXECUTED">{t("client.src.executed")}</SelectItem>
                    <SelectItem value="EXPIRED">{t("client.src.expired")}</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <Button>
                <Plus className="h-4 w-4 mr-2" />{t("client.src.new_contract")}</Button>
            </div>

            <Card>
              <CardHeader>
                <CardTitle>{t("client.src.contracts")}</CardTitle>
              </CardHeader>
              <CardContent>
                <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead>{t("client.src.title")}</TableHead>
                      <TableHead>{t("client.src.type")}</TableHead>
                      <TableHead>{t("client.src.parties")}</TableHead>
                      <TableHead>{t("client.src.status")}</TableHead>
                      <TableHead>{t("client.src.version")}</TableHead>
                      <TableHead>{t("client.src.created")}</TableHead>
                      <TableHead>{t("client.src.execution")}</TableHead>
                      <TableHead>{t("client.src.actions")}</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {filteredContracts.map(contract => <TableRow key={contract.id}>
                        <TableCell className="font-medium">{contract.title}</TableCell>
                        <TableCell>
                          <Badge variant="outline">{contract.type}</Badge>
                        </TableCell>
                        <TableCell>
                          <div className="text-sm">
                            {contract.parties.slice(0, 2).join(', ')}
                            {contract.parties.length > 2 && ` +${contract.parties.length - 2}`}
                          </div>
                        </TableCell>
                        <TableCell>
                          <div className="flex items-center gap-2">
                            <div className={`w-2 h-2 rounded-full ${getStatusColor(contract.status)}`} />
                            <span className="capitalize">{contract.status.toLowerCase().replace('_', ' ')}</span>
                          </div>
                        </TableCell>
                        <TableCell>v{contract.version}</TableCell>
                        <TableCell>{new Date(contract.createdDate).toLocaleDateString()}</TableCell>
                        <TableCell>
                          {contract.executionDate ? new Date(contract.executionDate).toLocaleDateString() : '-'}
                        </TableCell>
                        <TableCell>
                          <div className="flex gap-1">
                            <Button variant="ghost" size="sm">
                              <Eye className="h-4 w-4" />
                            </Button>
                            <Button variant="ghost" size="sm">
                              <Download className="h-4 w-4" />
                            </Button>
                          </div>
                        </TableCell>
                      </TableRow>)}
                  </TableBody>
                </Table>
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="signatures" className="space-y-4">
            <div className="flex justify-end">
              <Button>
                <Plus className="h-4 w-4 mr-2" />{t("client.src.request_signature")}</Button>
            </div>

            <Card>
              <CardHeader>
                <CardTitle>{t("client.src.signature_requests")}</CardTitle>
              </CardHeader>
              <CardContent>
                <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead>{t("client.src.contract")}</TableHead>
                      <TableHead>{t("client.src.signer")}</TableHead>
                      <TableHead>{t("client.src.email")}</TableHead>
                      <TableHead>{t("client.src.method")}</TableHead>
                      <TableHead>{t("client.src.status")}</TableHead>
                      <TableHead>{t("client.src.sent")}</TableHead>
                      <TableHead>{t("client.src.signed")}</TableHead>
                      <TableHead>{t("client.src.actions")}</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {signatureRequests.map(request => <TableRow key={request.id}>
                        <TableCell className="font-medium">{request.contractTitle}</TableCell>
                        <TableCell>{request.signerName}</TableCell>
                        <TableCell>{request.signerEmail}</TableCell>
                        <TableCell>
                          <Badge variant="outline">{request.signatureMethod}</Badge>
                        </TableCell>
                        <TableCell>
                          <div className="flex items-center gap-2">
                            <div className={`w-2 h-2 rounded-full ${getStatusColor(request.status)}`} />
                            <span className="capitalize">{request.status.toLowerCase()}</span>
                          </div>
                        </TableCell>
                        <TableCell>{new Date(request.sentDate).toLocaleDateString()}</TableCell>
                        <TableCell>
                          {request.signedDate ? new Date(request.signedDate).toLocaleDateString() : '-'}
                        </TableCell>
                        <TableCell>
                          <div className="flex gap-1">
                            <Button variant="ghost" size="sm">
                              <Eye className="h-4 w-4" />
                            </Button>
                            {request.status === 'PENDING' && <Button variant="ghost" size="sm">
                                <Send className="h-4 w-4" />
                              </Button>}
                          </div>
                        </TableCell>
                      </TableRow>)}
                  </TableBody>
                </Table>
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="templates" className="space-y-4">
            <Card>
              <CardHeader>
                <CardTitle>{t("client.src.document_templates")}</CardTitle>
              </CardHeader>
              <CardContent>
                <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead>{t("client.src.name")}</TableHead>
                      <TableHead>{t("client.src.category")}</TableHead>
                      <TableHead>{t("client.src.description")}</TableHead>
                      <TableHead>{t("client.src.usage")}</TableHead>
                      <TableHead>{t("client.src.last_used")}</TableHead>
                      <TableHead>{t("client.src.status")}</TableHead>
                      <TableHead>{t("client.src.actions")}</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {templates.map(template => <TableRow key={template.id}>
                        <TableCell className="font-medium">{template.name}</TableCell>
                        <TableCell>
                          <Badge variant="outline">{template.category}</Badge>
                        </TableCell>
                        <TableCell className="max-w-xs truncate">{template.description}</TableCell>
                        <TableCell>{template.usageCount}</TableCell>
                        <TableCell>
                          {template.lastUsed ? new Date(template.lastUsed).toLocaleDateString() : 'Never'}
                        </TableCell>
                        <TableCell>
                          <div className="flex items-center gap-2">
                            {template.isActive ? <Unlock className="h-4 w-4 text-green-600" /> : <Lock className="h-4 w-4 text-gray-400" />}
                            <span className="capitalize">
                              {template.isActive ? 'Active' : 'Inactive'}
                            </span>
                          </div>
                        </TableCell>
                        <TableCell>
                          <div className="flex gap-1">
                            <Button variant="ghost" size="sm">
                              <Eye className="h-4 w-4" />
                            </Button>
                            <Button variant="ghost" size="sm">
                              <Download className="h-4 w-4" />
                            </Button>
                          </div>
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