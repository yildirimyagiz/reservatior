"use client";

import { useTranslation } from "react-i18next";
import { FileText, Upload, CheckCircle, Clock, AlertCircle, Search, Shield, Users, FolderOpen } from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { m } from "framer-motion";

const DOCUMENTS = [
  { id: 1, name: "Lease Agreement - 123 Main St", type: "contract", status: "approved", createdAt: "2024-01-15" },
  { id: 2, name: "Invoice #4521", type: "invoice", status: "pending_review", createdAt: "2024-01-14" },
  { id: 3, name: "Property Inspection Report", type: "property", status: "approved", createdAt: "2024-01-13" },
  { id: 4, name: "Insurance Policy", type: "insurance", status: "draft", createdAt: "2024-01-12" },
];

const TEMPLATES = [
  { id: 1, name: "Standard Lease Agreement", type: "contract", usage: 45 },
  { id: 2, name: "Rental Invoice", type: "invoice", usage: 128 },
  { id: 3, name: "Property Disclosure", type: "property", usage: 67 },
];

const SIGNATURE_REQUESTS = [
  { id: 1, document: "Lease Agreement - 123 Main St", signers: ["john@example.com", "jane@example.com"], status: "pending" },
  { id: 2, document: "Sales Contract - 456 Oak Ave", signers: ["bob@example.com"], status: "completed" },
];

export default function AdminDocumentOSDashboard() {
  const { t } = useTranslation();

  const kpis = [
    { title: "Total Documents", value: 1247, icon: FileText, color: "text-emerald-500", trend: "+23 this week" },
    { title: "Pending Review", value: 18, icon: Clock, color: "text-yellow-400", trend: "Requires attention" },
    { title: "Approved", value: 1189, icon: CheckCircle, color: "text-blue-400", trend: "95.4% approval rate" },
    { title: "Templates", value: 12, icon: FolderOpen, color: "text-purple-400", trend: "+2 new this month" },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-start justify-between">
        <div>
          <h1 className="text-3xl font-bold tracking-tight text-slate-100">Document OS Management</h1>
          <p className="text-slate-400 mt-1">Document management and digital signatures</p>
        </div>
        <Button className="bg-indigo-600 hover:bg-indigo-700">
          <Upload className="h-4 w-4 mr-2" />
          Upload Document
        </Button>
      </div>

      {/* KPIs */}
      <div className="grid gap-4 md:grid-cols-4">
        {kpis.map((kpi, i) => (
          <m.div key={kpi.title} initial={{ opacity: 0, y: 10 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: i * 0.07 }}>
            <Card className="bg-slate-900/60 border-slate-800">
              <CardHeader className="flex flex-row items-center justify-between pb-2">
                <CardTitle className="text-sm font-medium text-slate-400">{kpi.title}</CardTitle>
                <kpi.icon className={`h-4 w-4 ${kpi.color}`} />
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold text-slate-100">{kpi.value}</div>
                <p className="text-xs text-slate-500 mt-1">{kpi.trend}</p>
              </CardContent>
            </Card>
          </m.div>
        ))}
      </div>

      <Tabs defaultValue="documents" className="space-y-4">
        <TabsList className="bg-slate-900/60 border-slate-800">
          <TabsTrigger value="documents">Documents</TabsTrigger>
          <TabsTrigger value="templates">Templates</TabsTrigger>
          <TabsTrigger value="signatures">Signatures</TabsTrigger>
          <TabsTrigger value="approvals">Approvals</TabsTrigger>
        </TabsList>

        <TabsContent value="documents" className="space-y-4">
          <Card className="bg-slate-900/60 border-slate-800">
            <CardHeader>
              <CardTitle className="text-slate-100">Document Library</CardTitle>
              <CardDescription className="text-slate-400">
                All documents in the system
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {DOCUMENTS.map((doc) => (
                  <div key={doc.id} className="flex items-center justify-between p-4 rounded-lg bg-slate-800/50 border border-slate-700">
                    <div className="flex items-center gap-3">
                      <FileText className="h-5 w-5 text-slate-400" />
                      <div>
                        <p className="text-sm font-medium text-slate-200">{doc.name}</p>
                        <p className="text-xs text-slate-500">{doc.type} • {doc.createdAt}</p>
                      </div>
                    </div>
                    <Badge variant={doc.status === 'approved' ? 'default' : doc.status === 'pending_review' ? 'secondary' : 'outline'} className="text-xs">
                      {doc.status}
                    </Badge>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="templates">
          <Card className="bg-slate-900/60 border-slate-800">
            <CardHeader>
              <CardTitle className="text-slate-100">Document Templates</CardTitle>
              <CardDescription className="text-slate-400">
                Reusable document templates
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {TEMPLATES.map((template) => (
                  <div key={template.id} className="flex items-center justify-between p-4 rounded-lg bg-slate-800/50 border border-slate-700">
                    <div className="flex items-center gap-3">
                      <FolderOpen className="h-5 w-5 text-slate-400" />
                      <div>
                        <p className="text-sm font-medium text-slate-200">{template.name}</p>
                        <p className="text-xs text-slate-500">{template.type} • Used {template.usage} times</p>
                      </div>
                    </div>
                    <Button variant="outline" size="sm">Use Template</Button>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="signatures">
          <Card className="bg-slate-900/60 border-slate-800">
            <CardHeader>
              <CardTitle className="text-slate-100">Signature Requests</CardTitle>
              <CardDescription className="text-slate-400">
                Digital signature requests and status
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {SIGNATURE_REQUESTS.map((req) => (
                  <div key={req.id} className="p-4 rounded-lg bg-slate-800/50 border border-slate-700">
                    <div className="flex items-start justify-between mb-2">
                      <div className="flex items-center gap-2">
                        <Shield className="h-4 w-4 text-slate-400" />
                        <p className="text-sm font-medium text-slate-200">{req.document}</p>
                      </div>
                      <Badge variant={req.status === 'completed' ? 'default' : 'secondary'} className="text-xs">
                        {req.status}
                      </Badge>
                    </div>
                    <div className="flex items-center gap-2">
                      <Users className="h-3 w-3 text-slate-500" />
                      <p className="text-xs text-slate-500">{req.signers.join(", ")}</p>
                    </div>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="approvals">
          <Card className="bg-slate-900/60 border-slate-800">
            <CardHeader>
              <CardTitle className="text-slate-100">Document Approvals</CardTitle>
              <CardDescription className="text-slate-400">
                Pending document approvals
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="text-center py-8 text-slate-400">
                <AlertCircle className="h-12 w-12 mx-auto mb-4 opacity-50" />
                <p>Approval queue interface</p>
              </div>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  );
}
