import { useTranslation } from "react-i18next";
import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Briefcase, Building2, UserCircle, Scale, Clock, CheckCircle2, DollarSign, Plus, MessageSquare, Phone, Mail, ExternalLink, UserCheck } from "lucide-react";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { PageShell } from "../layout/PageShell";
interface SolicitorRecord {
  id: string;
  name: string;
  firm: string;
  type: 'conveyancing' | 'litigation' | 'corporate' | 'family' | 'probate';
  contact: {
    email: string;
    phone: string;
  };
  assignments: Array<{
    dealId: string;
    dealName: string;
    status: 'engaged' | 'instructed' | 'contract-exchange' | 'completed' | 'on-hold' | 'verified';
    engagedAt: string;
    fee: number;
    currency: string;
  }>;
}
const MOCK_SOLICITORS: SolicitorRecord[] = [{
  id: "s1",
  name: "Alistair Cook",
  firm: "Cook & Partners LLP",
  type: "conveyancing",
  contact: {
    email: "acook@cookllp.com",
    phone: "+44 20 7123 4567"
  },
  assignments: [{
    dealId: "d1",
    dealName: "Sunrise Villa Acquisition",
    status: "instructed",
    engagedAt: "2024-03-01",
    fee: 1250,
    currency: "GBP"
  }, {
    dealId: "d2",
    dealName: "Harbor View Sale",
    status: "contract-exchange",
    engagedAt: "2024-02-15",
    fee: 1800,
    currency: "GBP"
  }]
}, {
  id: "s2",
  name: "Sarah Jenkins",
  firm: "Westminster Legal",
  type: "litigation",
  contact: {
    email: "sjenkins@westlegal.com",
    phone: "+44 20 7456 7890"
  },
  assignments: [{
    dealId: "d3",
    dealName: "Tenant Dispute - Apt 12",
    status: "engaged",
    engagedAt: "2024-03-10",
    fee: 450,
    currency: "GBP"
  }]
}];
export default function SolicitorManagement() {
  const {
    t
  } = useTranslation();
  const [solicitors] = useState<SolicitorRecord[]>(MOCK_SOLICITORS);
  const getStatusBadge = (status: SolicitorRecord['assignments'][0]['status']) => {
    switch (status) {
      case 'verified':
        return <Badge className="bg-emerald-100 text-emerald-800 border-emerald-200 font-bold"><UserCheck className="w-3 h-3 mr-1" />{t("client.src.fully_verified")}</Badge>;
      case 'completed':
        return <Badge className="bg-emerald-100 text-emerald-800 border-emerald-200 font-bold"><CheckCircle2 className="w-3 h-3 mr-1" />{t("client.src.completed")}</Badge>;
      case 'engaged':
        return <Badge variant="outline" className="text-blue-600 border-blue-200 bg-blue-50 font-bold"><Scale className="w-3 h-3 mr-1" />{t("client.src.engaged")}</Badge>;
      case 'instructed':
        return <Badge className="bg-amber-100 text-amber-800 border-amber-200 font-bold">{t("client.src.instructed")}</Badge>;
      case 'contract-exchange':
        return <Badge className="bg-indigo-100 text-indigo-800 border-indigo-200 font-bold">{t("client.src.exchange")}</Badge>;
      case 'on-hold':
        return <Badge variant="destructive" className="font-bold underline">{t("client.src.on_hold")}</Badge>;
    }
  };
  return <PageShell title={t("client.src.solicitor_management")} description={t("client.src.manage_legal_engagements_conveyancing")}>
      <div className="space-y-6">
        {/* Quick Actions */}
        <div className="flex flex-col md:flex-row gap-4 justify-between items-center bg-muted/20 p-6 rounded-2xl border">
          <div className="max-w-md">
            <h3 className="text-xl font-bold mb-1">{t("client.src.legal_dashboard")}</h3>
            <p className="text-sm text-muted-foreground">{t("client.src.you_are_currently_managing")}</p>
          </div>
          <div className="flex gap-2 w-full md:w-auto">
             <Button className="bg-indigo-600 hover:bg-indigo-700 shadow-md shadow-indigo-100"><Plus className="w-4 h-4 mr-2" />{t("client.src.instruct_solicitor")}</Button>
          </div>
        </div>

        {/* Content Tabs */}
        <Tabs defaultValue="solicitors" className="w-full">
          <TabsList className="mb-4">
            <TabsTrigger value="solicitors">{t("client.src.solicitors_list")}</TabsTrigger>
            <TabsTrigger value="instructions">{t("client.src.active_instructions")}</TabsTrigger>
          </TabsList>

          <TabsContent value="solicitors">
            <div className="grid gap-6 md:grid-cols-2">
              {solicitors.map(solicitor => <Card key={solicitor.id} className="hover:shadow-lg transition-all border-none shadow-sm ring-1 ring-muted">
                  <CardHeader className="bg-muted/30 pb-4">
                    <div className="flex justify-between items-start">
                      <div className="flex items-center gap-4">
                        <div className="w-14 h-14 bg-white rounded-xl shadow-sm border flex items-center justify-center">
                          <UserCircle className="w-8 h-8 text-indigo-500" />
                        </div>
                        <div>
                          <CardTitle className="text-xl font-bold">{solicitor.name}</CardTitle>
                          <CardDescription className="flex items-center mt-1 font-semibold">
                            <Building2 className="w-4 h-4 mr-1.5 text-muted-foreground" />
                            {solicitor.firm}
                          </CardDescription>
                        </div>
                      </div>
                      <Badge variant="secondary" className="bg-indigo-50 text-indigo-700 hover:bg-indigo-100 border-indigo-100 font-bold">
                        {solicitor.type}
                      </Badge>
                    </div>
                  </CardHeader>
                  <CardContent className="pt-6 space-y-6 text-sm">
                    {/* Contact Details */}
                    <div className="flex flex-wrap gap-4 text-xs font-medium text-muted-foreground">
                       <span className="flex items-center"><Mail className="w-3.5 h-3.5 mr-1.5 text-indigo-500" /> {solicitor.contact.email}</span>
                       <span className="flex items-center"><Phone className="w-3.5 h-3.5 mr-1.5 text-indigo-500" /> {solicitor.contact.phone}</span>
                    </div>

                    {/* Assignments */}
                    <div>
                      <h4 className="font-bold tracking-wider text-xs text-muted-foreground mb-3 border-b pb-1">{t("client.src.current_deals")}</h4>
                      <div className="space-y-3">
                        {solicitor.assignments.map(assign => <div key={assign.dealId} className="bg-white/50 border rounded-lg p-3 flex justify-between items-center group hover:bg-indigo-50/50 transition-colors">
                            <div>
                              <p className="font-bold text-foreground mb-1 group-hover:text-indigo-700 transition-colors tracking-tighter">{assign.dealName}</p>
                              <p className="text-xs text-muted-foreground flex items-center">
                                <Clock className="w-3 h-3 mr-1" />{t("client.src.instructed")}{assign.engagedAt}
                              </p>
                            </div>
                            <div className="text-right">
                              {getStatusBadge(assign.status)}
                              <p className="text-xs font-bold mt-1 text-emerald-600 flex items-center justify-end">
                                <DollarSign className="w-2.5 h-2.5 mr-0.5" /> {assign.fee}
                              </p>
                            </div>
                          </div>)}
                      </div>
                    </div>

                    {/* Quick Buttons */}
                    <div className="flex gap-2 pt-2 border-t mt-4">
                      <Button variant="outline" size="sm" className="flex-1 font-bold">
                        <MessageSquare className="w-4 h-4 mr-2 text-indigo-500" />{t("client.src.message")}</Button>
                      <Button variant="outline" size="sm" className="flex-1 font-bold">
                        <Plus className="w-4 h-4 mr-2 text-indigo-500" />{t("client.src.new_task")}</Button>
                      <Button variant="ghost" size="sm" className="p-2">
                        <ExternalLink className="w-4 h-4 text-muted-foreground" />
                      </Button>
                    </div>
                  </CardContent>
                </Card>)}
            </div>
          </TabsContent>
        </Tabs>

        {/* Legal Resource Section */}
        <Card className="border-l-4 border-l-indigo-600 bg-white">
          <CardHeader className="pb-2">
             <CardTitle className="text-lg flex items-center font-bold">
               <Briefcase className="w-5 h-5 mr-3 text-indigo-600" />{t("client.src.conveyancing_workflow_integration")}</CardTitle>
          </CardHeader>
          <CardContent className="text-sm">{t("client.src.our_solicitor_management_tool")}</CardContent>
        </Card>
      </div>
    </PageShell>;
}