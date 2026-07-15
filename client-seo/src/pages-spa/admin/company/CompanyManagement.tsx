"use client";

import { t } from"i18next";
import { useTranslation } from"react-i18next";
import { useState, useEffect } from"react";
import { PageShell } from"../../client/layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { Button } from"@/components/ui/button";
import { Badge } from"@/components/ui/badge";
import { Progress } from"@/components/ui/progress";
import { Input } from"@/components/ui/input";
import { Textarea } from"@/components/ui/textarea";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from"@/components/ui/select";
import { Building, Users, FileText, CheckCircle, AlertTriangle, Clock, DollarSign, TrendingUp, Calendar, Target, Award, Star, Zap, Shield, Globe, Settings, Plus, Edit, Trash2, Download, Upload } from"lucide-react";
import { motion } from"framer-motion";
import { cn } from"@/lib/utils";
import { useToast } from"@/hooks/use-toast";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger, DialogFooter, DialogDescription } from"@/components/ui/dialog";
import { Label } from"@/components/ui/label";
import { useMutation, useQueryClient } from"@tanstack/react-query";
import { apiClient } from"@/lib/api/client";
import Image from"next/image";

interface CompanyDocument {
 id: string;
 name: string;
 type: 'CONTRACT' | 'AGREEMENT' | 'LICENSE' | 'CERTIFICATE' | 'TAX' | 'INSURANCE';
 status: 'DRAFT' | 'PENDING' | 'APPROVED' | 'EXPIRED';
 uploadDate: string;
 expiryDate?: string;
 fileUrl?: string;
 description: string;
}
interface CompanyMilestone {
 id: string;
 title: string;
 description: string;
 status: 'NOT_STARTED' | 'IN_PROGRESS' | 'COMPLETED' | 'DELAYED';
 dueDate: string;
 completedDate?: string;
 progress: number;
 priority: 'LOW' | 'MEDIUM' | 'HIGH' | 'CRITICAL';
}
interface TeamMember {
 id: string;
 name: string;
 email: string;
 role: string;
 department: string;
 avatar: string;
 joinDate: string;
 status: 'ACTIVE' | 'ON_LEAVE' | 'TERMINATED';
}
export default function CompanyManagement() {
 const { toast } = useToast();
 const queryClient = useQueryClient();
 const deleteMutation = useMutation({
 mutationFn: async (id: string) => apiClient.delete(`/organization/${id}`),
 onSuccess: () => {
 toast({ title:"Deleted", description:"Record deleted successfully" });
 queryClient.invalidateQueries();
 },
 onError: (err: any) => toast({ title:"Error", description: err.message, variant:"destructive" })
 });
 

 
 
 
 const [isAddOpen, setIsAddOpen] = useState(false);
 const [isEditOpen, setIsEditOpen] = useState(false);
 const [editingDoc, setEditingDoc] = useState<CompanyDocument | null>(null);
 const {
 t
 } = useTranslation();

 const [newOrg, setNewOrg] = useState({
 name: '',
 type: 'OWNER_PORTFOLIO',
 region: 'GLOBAL'
 });

 const createMutation = useMutation({
 mutationFn: async (data: any) => {
 return apiClient.post('/organization', data);
 },
 onSuccess: () => {
 setIsAddOpen(false);
 toast({ title:"Success", description:"Organization created successfully" });
 },
 onError: (err: any) => {
 toast({ title:"Error", description: err.message ||"Failed to create organization", variant:"destructive" });
 }
 });
 
 const [activeTab, setActiveTab] = useState<'overview' | 'documents' | 'milestones' | 'team'>('overview');
 const [documents, setDocuments] = useState<CompanyDocument[]>([{
 id:"doc_001",
 name:"Articles of Incorporation",
 type:"CONTRACT",
 status:"APPROVED",
 uploadDate:"2026-03-15T10:00:00Z",
 fileUrl:"/documents/articles_of_incorporation.pdf",
 description: t("admin_company_delaware_llc_incorporation_documents")
 }, {
 id:"doc_002",
 name:"Terms of Service",
 type:"AGREEMENT",
 status:"APPROVED",
 uploadDate:"2026-03-20T14:30:00Z",
 fileUrl:"/documents/terms_of_service.pdf",
 description: t("admin_company_platform_terms_and_conditions")
 }, {
 id:"doc_003",
 name:"Privacy Policy",
 type:"AGREEMENT",
 status:"APPROVED",
 uploadDate:"2026-03-22T09:15:00Z",
 fileUrl:"/documents/privacy_policy.pdf",
 description: t("admin_company_user_privacy_protection_policy")
 }, {
 id:"doc_004",
 name:"Business License",
 type:"LICENSE",
 status:"PENDING",
 uploadDate:"2026-03-25T16:45:00Z",
 description: t("admin_company_real_estate_business_license")
 }]);
 const [milestones, setMilestones] = useState<CompanyMilestone[]>([{
 id:"ms_001",
 title: t("admin_company_company_registration"),
 description: t("admin_company_complete_legal_company_registration"),
 status:"COMPLETED",
 dueDate:"2026-03-30T23:59:59Z",
 completedDate:"2026-03-28T15:30:00Z",
 progress: 100,
 priority:"HIGH"
 }, {
 id:"ms_002",
 title: t("admin_company_bank_account_setup"),
 description: t("admin_company_open_business_banking_accounts"),
 status:"COMPLETED",
 dueDate:"2026-04-05T23:59:59Z",
 completedDate:"2026-04-02T11:20:00Z",
 progress: 100,
 priority:"HIGH"
 }, {
 id:"ms_003",
 title: t("admin_company_domain_registration"),
 description: t("admin_company_register_company_domains"),
 status:"IN_PROGRESS",
 dueDate:"2026-04-10T23:59:59Z",
 progress: 75,
 priority:"MEDIUM"
 }, {
 id:"ms_004",
 title: t("admin_company_ssl_certificate_setup"),
 description: t("admin_company_install_ssl_certificates"),
 status:"NOT_STARTED",
 dueDate:"2026-04-15T23:59:59Z",
 progress: 0,
 priority:"MEDIUM"
 }, {
 id:"ms_005",
 title: t("admin_company_google_cloud_deployment"),
 description: t("admin_company_deploy_to_google_cloud"),
 status:"NOT_STARTED",
 dueDate:"2026-04-20T23:59:59Z",
 progress: 0,
 priority:"HIGH"
 }]);
 const [team, setTeam] = useState<TeamMember[]>([{
 id:"tm_001",
 name:"John Doe",
 email:"john@reservatiormai.com",
 role:"CEO & Founder",
 department:"Executive",
 avatar:"https://api.dicebear.com/7.x/avatars/john",
 joinDate:"2026-03-01T00:00:00Z",
 status:"ACTIVE"
 }, {
 id:"tm_002",
 name:"Jane Smith",
 email:"jane@reservatiormai.com",
 role:"CTO",
 department:"Technology",
 avatar:"https://api.dicebear.com/7.x/avatars/jane",
 joinDate:"2026-03-05T00:00:00Z",
 status:"ACTIVE"
 }, {
 id:"tm_003",
 name:"Mike Johnson",
 email:"mike@reservatiormai.com",
 role:"Full Stack Developer",
 department:"Engineering",
 avatar:"https://api.dicebear.com/7.x/avatars/mike",
 joinDate:"2026-03-10T00:00:00Z",
 status:"ACTIVE"
 }, {
 id:"tm_004",
 name:"Sarah Wilson",
 email:"sarah@reservatiormai.com",
 role:"UI/UX Designer",
 department:"Design",
 avatar:"https://api.dicebear.com/7.x/avatars/sarah",
 joinDate:"2026-03-15T00:00:00Z",
 status:"ACTIVE"
 }]);
 const getDocumentStatusColor = (status: string) => {
 switch (status) {
 case 'APPROVED':
 return 'bg-emerald-500/10 text-emerald-400 border-emerald-500/20';
 case 'PENDING':
 return 'bg-orange-500/10 text-orange-400 border-orange-500/20';
 case 'EXPIRED':
 return 'bg-red-500/10 text-red-400 border-red-500/20';
 case 'DRAFT':
 return 'bg-muted0/10 text-muted-foreground border-slate-500/20';
 default:
 return 'bg-muted0/10 text-muted-foreground border-slate-500/20';
 }
 };
 const getMilestoneStatusColor = (status: string) => {
 switch (status) {
 case 'COMPLETED':
 return 'bg-emerald-500/10 text-emerald-400 border-emerald-500/20';
 case 'IN_PROGRESS':
 return 'bg-muted0/10 text-muted-foreground border-slate-500/20';
 case 'DELAYED':
 return 'bg-red-500/10 text-red-400 border-red-500/20';
 case 'NOT_STARTED':
 return 'bg-muted0/10 text-muted-foreground border-slate-500/20';
 default:
 return 'bg-muted0/10 text-muted-foreground border-slate-500/20';
 }
 };
 const getPriorityColor = (priority: string) => {
 switch (priority) {
 case 'CRITICAL':
 return 'bg-red-500/20 text-red-400';
 case 'HIGH':
 return 'bg-orange-500/20 text-orange-400';
 case 'MEDIUM':
 return 'bg-yellow-500/20 text-yellow-400';
 case 'LOW':
 return 'bg-green-500/20 text-green-400';
 default:
 return 'bg-muted0/20 text-muted-foreground';
 }
 };
 const completedMilestones = milestones.filter(m => m.status === 'COMPLETED').length;
 const totalMilestones = milestones.length;
 const overallProgress = completedMilestones / totalMilestones * 100;
 return <PageShell title={t("admin_company_company_management")} description={t("admin_company_operational_company_setup_and")}>
 <div className="animate-in fade-in slide-in-from-bottom-4 duration-700 max-w-7xl mx-auto px-4 lg:px-8 py-10 space-y-8">
 
 {/* Header */}
 <div className="flex items-center justify-between">
 <div>
 <h1 className="text-3xl font-bold text-foreground bg-clip-text text-transparent bg-gradient-to-r from-slate-200 to-slate-500">{t("admin_company_company_operations")}</h1>
 <p className="text-sm text-muted-foreground mt-1">{t("admin_company_manage_company_setup_documents")}</p>
 </div>
 
 <div className="flex items-center gap-4">
 <Badge className="bg-emerald-500/20 text-emerald-400 border-emerald-500/20 px-4 py-2">
 <div className="flex items-center gap-2">
 <Building className="w-4 h-4" />
 <span className="font-bold text-xs">{t("admin_company_active_setup")}</span>
 </div>
 </Badge>
 </div>
 </div>

 {/* Progress Overview */}
 <Card className="bg-card border-border rounded-3xl p-8">
 <CardHeader>
 <CardTitle className="text-lg font-bold text-foreground flex items-center gap-2">
 <Target className="w-5 h-5 text-slate-500" />{t("admin_company_setup_progress")}</CardTitle>
 </CardHeader>
 <CardContent className="space-y-6">
 <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
 <div className="text-center">
 <div className="text-3xl font-bold text-foreground">{overallProgress.toFixed(0)}%</div>
 <p className="text-xs text-muted-foreground">{t("admin_company_overall_progress")}</p>
 </div>
 
 <div className="text-center">
 <div className="text-3xl font-bold text-foreground">{completedMilestones}{t("/", "/")}{totalMilestones}</div>
 <p className="text-xs text-muted-foreground">{t("admin_company_milestones")}</p>
 </div>
 
 <div className="text-center">
 <div className="text-3xl font-bold text-foreground">{team.filter(t => t.status === 'ACTIVE').length}</div>
 <p className="text-xs text-muted-foreground">{t("admin_company_team_members")}</p>
 </div>
 
 <div className="text-center">
 <div className="text-3xl font-bold text-foreground">{documents.filter(d => d.status === 'APPROVED').length}</div>
 <p className="text-xs text-muted-foreground">{t("admin_company_documents")}</p>
 </div>
 </div>
 
 <div className="mt-6">
 <div className="flex items-center justify-between text-sm mb-2">
 <span>{t("admin_company_setup_progress")}</span>
 <span>{overallProgress.toFixed(0)}%</span>
 </div>
 <Progress value={overallProgress} className="h-3" />
 </div>
 </CardContent>
 </Card>

 {/* Navigation Tabs */}
 <div className="flex space-x-1 border-b border-border">
 {[{
 id: 'overview',
 label: t("admin_company_overview"),
 icon: <Target className="w-4 h-4" />
 }, {
 id: 'documents',
 label: t("admin_company_documents"),
 icon: <FileText className="w-4 h-4" />
 }, {
 id: 'milestones',
 label: t("admin_company_milestones"),
 icon: <Calendar className="w-4 h-4" />
 }, {
 id: 'team',
 label: t("admin_company_team"),
 icon: <Users className="w-4 h-4" />
 }].map(tab => <button key={tab.id} onClick={() => setActiveTab(tab.id as any)} className={cn("px-4 py-3 text-sm font-medium transition-colors border-b-2", activeTab === tab.id ?"text-foreground border-slate-500" :"text-muted-foreground border-transparent hover:text-foreground")}>
 <div className="flex items-center gap-2">
 {tab.icon}
 {tab.label}
 </div>
 </button>)}
 </div>

 {/* Tab Content */}
 <div className="mt-8">
 
 {/* Overview Tab */}
 {activeTab === 'overview' && <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
 <Card className="bg-card border-border rounded-3xl p-8">
 <CardHeader>
 <CardTitle className="text-lg font-bold text-foreground flex items-center gap-2">
 <Award className="w-5 h-5 text-emerald-500" />{t("admin_company_recent_achievements")}</CardTitle>
 </CardHeader>
 <CardContent className="space-y-4">
 <div className="space-y-3">
 <div className="flex items-center gap-3">
 <CheckCircle className="w-5 h-5 text-emerald-400" />
 <div>
 <h4 className="text-sm font-bold text-foreground">{t("admin_company_company_registered")}</h4>
 <p className="text-xs text-muted-foreground">{t("admin_company_delaware_llc_successfully_incorporated")}</p>
 </div>
 </div>
 
 <div className="flex items-center gap-3">
 <Star className="w-5 h-5 text-yellow-400" />
 <div>
 <h4 className="text-sm font-bold text-foreground">{t("admin_company_bank_accounts_opened")}</h4>
 <p className="text-xs text-muted-foreground">{t("admin_company_business_banking_setup_completed")}</p>
 </div>
 </div>
 
 <div className="flex items-center gap-3">
 <Zap className="w-5 h-5 text-muted-foreground" />
 <div>
 <h4 className="text-sm font-bold text-foreground">{t("admin_company_domain_secured")}</h4>
 <p className="text-xs text-muted-foreground">{t("admin_company_reservatiormaicom_registered")}</p>
 </div>
 </div>
 </div>
 </CardContent>
 </Card>

 <Card className="bg-card border-border rounded-3xl p-8">
 <CardHeader>
 <CardTitle className="text-lg font-bold text-foreground flex items-center gap-2">
 <TrendingUp className="w-5 h-5 text-slate-500" />{t("admin_company_key_metrics")}</CardTitle>
 </CardHeader>
 <CardContent className="space-y-4">
 <div className="grid grid-cols-2 gap-4">
 <div>
 <p className="text-xs text-muted-foreground">{t("admin_company_setup_progress")}</p>
 <p className="text-2xl font-bold text-foreground">{overallProgress.toFixed(0)}%</p>
 </div>
 
 <div>
 <p className="text-xs text-muted-foreground">{t("admin_company_time_to_launch")}</p>
 <p className="text-2xl font-bold text-foreground">{t("admin_company_21_days")}</p>
 </div>
 </div>
 
 <div className="grid grid-cols-2 gap-4 pt-4">
 <div>
 <p className="text-xs text-muted-foreground">{t("admin_company_total_investment")}</p>
 <p className="text-2xl font-bold text-foreground">$25,000</p>
 </div>
 
 <div>
 <p className="text-xs text-muted-foreground">{t("admin_company_projected_revenue")}</p>
 <p className="text-2xl font-bold text-foreground">{t("admin_company_15000mo")}</p>
 </div>
 </div>
 </CardContent>
 </Card>
 </div>}

 {/* Documents Tab */}
 {activeTab === 'documents' && <Card className="bg-card border-border rounded-3xl p-8">
 <CardHeader className="flex items-center justify-between">
 <CardTitle className="text-lg font-bold text-foreground flex items-center gap-2">
 <FileText className="w-5 h-5 text-orange-500" />{t("admin_company_company_documents")}</CardTitle>
 
 <Dialog open={isAddOpen} onOpenChange={setIsAddOpen}>
 <DialogTrigger asChild>
 <Button size="sm" className="bg-slate-600 hover:bg-muted0">
 <Plus className="w-4 h-4 mr-2" />{t("admin_company_upload_document")}</Button>
 </DialogTrigger>
 
 <DialogContent className="sm:max-w-[500px] bg-card text-card-foreground">
 <DialogHeader>
 <DialogTitle>{t("admin_auto_create_new_organization", "Create New Organization")}</DialogTitle>
 <DialogDescription>
 {t("admin_auto_register_a_new_organization_company_agen", "Register a new organization (company, agency, vendor) mapped to the backend.")}</DialogDescription>
 </DialogHeader>
 <div className="grid gap-4 py-4">
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="name" className="text-right text-xs">{t("admin_auto_org_name", "Org Name")}</Label>
 <Input id="name" className="col-span-3 h-10" value={newOrg.name} onChange={e => setNewOrg({...newOrg, name: e.target.value})} placeholder={t("admin_auto_acme_corporation", "Acme Corporation")} />
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="type" className="text-right text-xs">{t("admin_auto_org_type", "Org Type")}</Label>
 <Select value={newOrg.type} onValueChange={(v) => setNewOrg({...newOrg, type: v})}>
 <SelectTrigger className="col-span-3 h-10"><SelectValue placeholder={t("client.src.select_type", "Select Type")} /></SelectTrigger>
 <SelectContent>
 <SelectItem value="OWNER_PORTFOLIO">{t("admin_auto_owner_portfolio", "Owner Portfolio")}</SelectItem>
 <SelectItem value="VENDOR_PM">{t("admin_auto_vendor_pm", "Vendor PM")}</SelectItem>
 <SelectItem value="AGENCY">{t("admin_reports_agency", "Agency")}</SelectItem>
 <SelectItem value="ACCOUNTING_FIRM">{t("admin_auto_accounting_firm", "Accounting Firm")}</SelectItem>
 <SelectItem value="PUBLIC_ENTITY">{t("admin_auto_public_entity", "Public Entity")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="region" className="text-right text-xs">{t("admin_auto_region", "Region")}</Label>
 <Select value={newOrg.region} onValueChange={(v) => setNewOrg({...newOrg, region: v})}>
 <SelectTrigger className="col-span-3 h-10"><SelectValue placeholder={t("client.src.select_region", "Select Region")} /></SelectTrigger>
 <SelectContent>
 <SelectItem value="GLOBAL">{t("client.src.global", "Global")}</SelectItem>
 <SelectItem value="TR">{t("admin_auto_turkey", "Turkey")}</SelectItem>
 <SelectItem value="USA">{t("admin_auto_usa", "USA")}</SelectItem>
 <SelectItem value="UK">{t("admin_auto_uk", "UK")}</SelectItem>
 <SelectItem value="UAE">{t("admin_auto_uae", "UAE")}</SelectItem>
 <SelectItem value="FR">{t("admin_auto_france", "France")}</SelectItem>
 <SelectItem value="DE">{t("admin_auto_germany", "Germany")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 </div>
 <DialogFooter>
 <Button variant="outline" onClick={() => setIsAddOpen(false)}>{t("admin_action_cancel", "Cancel")}</Button>
 <Button onClick={() => createMutation.mutate(newOrg)} disabled={createMutation.isPending || !newOrg.name}>
 {createMutation.isPending ?"Saving..." :"Create Organization"}
 </Button>
 </DialogFooter>
 </DialogContent>
 
 </Dialog>
 
 </CardHeader>
 <CardContent className="space-y-4">
 {documents.map(document => <motion.div key={document.id} initial={{
 opacity: 0,
 y: 10
 }} animate={{
 opacity: 1,
 y: 0
 }} className="bg-muted/50 rounded-2xl p-4 border border-border">
 <div className="flex items-center justify-between">
 <div className="flex-1">
 <div className="flex items-center gap-3 mb-2">
 <div className="w-8 h-8 rounded-lg bg-orange-500/20 flex items-center justify-center">
 <FileText className="w-4 h-4 text-orange-400" />
 </div>
 <div>
 <h4 className="text-sm font-bold text-foreground">{document.name}</h4>
 <p className="text-xs text-muted-foreground">{document.description}</p>
 </div>
 </div>
 
 <div className="flex items-center gap-3">
 <Badge className={cn("text-[9px] font-bold px-2", getDocumentStatusColor(document.status))}>
 {document.status}
 </Badge>
 <span className="text-xs text-muted-foreground">{t("admin_company_uploaded")}{new Date(document.uploadDate).toLocaleDateString()}
 </span>
 </div>
 </div>
 
 <div className="flex items-center gap-2">
 {document.fileUrl && <Button size="sm" variant="outline">
 <Download className="w-3 h-3 mr-1" />{t("admin_company_download")}</Button>}
 <Button size="sm" variant="ghost" onClick={() => { setEditingDoc(document); setIsEditOpen(true); }}>
 <Edit className="w-3 h-3 mr-1" />{t("admin_company_edit")}</Button>
 </div>
 </div>
 </motion.div>)}
 </CardContent>
 </Card>}

 {/* Milestones Tab */}
 {activeTab === 'milestones' && <Card className="bg-card border-border rounded-3xl p-8">
 <CardHeader className="flex items-center justify-between">
 <CardTitle className="text-lg font-bold text-foreground flex items-center gap-2">
 <Calendar className="w-5 h-5 text-slate-500" />{t("admin_company_setup_milestones")}</CardTitle>
 <Button size="sm" className="bg-slate-600 hover:bg-muted0">
 <Plus className="w-4 h-4 mr-2" />{t("admin_company_add_milestone")}</Button>
 </CardHeader>
 <CardContent className="space-y-4">
 {milestones.map(milestone => <motion.div key={milestone.id} initial={{
 opacity: 0,
 y: 10
 }} animate={{
 opacity: 1,
 y: 0
 }} className="bg-muted/50 rounded-2xl p-4 border border-border">
 <div className="flex items-center justify-between mb-3">
 <div className="flex items-center gap-3">
 <Badge className={cn("text-[9px] font-bold px-2", getMilestoneStatusColor(milestone.status))}>
 {milestone.status}
 </Badge>
 <Badge className={cn("text-[9px] font-bold px-2", getPriorityColor(milestone.priority))}>
 {milestone.priority}
 </Badge>
 </div>
 
 <div className="text-xs text-muted-foreground">{t("admin_company_due")}{new Date(milestone.dueDate).toLocaleDateString()}
 </div>
 </div>
 
 <div className="space-y-2">
 <h4 className="text-sm font-bold text-foreground">{milestone.title}</h4>
 <p className="text-xs text-muted-foreground">{milestone.description}</p>
 </div>
 
 <div className="space-y-2">
 <div className="flex items-center justify-between text-sm">
 <span className="text-muted-foreground">{t("admin_company_progress")}</span>
 <span className="text-foreground">{milestone.progress}%</span>
 </div>
 <Progress value={milestone.progress} className="h-2" />
 </div>
 </motion.div>)}
 </CardContent>
 </Card>}

 {/* Team Tab */}
 {activeTab === 'team' && <Card className="bg-card border-border rounded-3xl p-8">
 <CardHeader className="flex items-center justify-between">
 <CardTitle className="text-lg font-bold text-foreground flex items-center gap-2">
 <Users className="w-5 h-5 text-emerald-500" />{t("admin_company_team_members")}</CardTitle>
 <Button size="sm" className="bg-slate-600 hover:bg-muted0">
 <Plus className="w-4 h-4 mr-2" />{t("admin_company_add_team_member")}</Button>
 </CardHeader>
 <CardContent className="space-y-4">
 <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
 {team.map(member => <motion.div key={member.id} whileHover={{
 scale: 1.02
 }} className="bg-muted/50 rounded-2xl p-4 border border-border">
 <div className="flex items-center gap-4 relative">
 <Image src={member.avatar} alt={member.name} width={48} height={48} className="rounded-full" />
 <div className="flex-1">
 <h4 className="text-sm font-bold text-foreground">{member.name}</h4>
 <p className="text-xs text-muted-foreground">{member.role}</p>
 <p className="text-xs text-muted-foreground">{member.department}</p>
 <p className="text-xs text-muted-foreground">{t("admin_company_joined")}{new Date(member.joinDate).toLocaleDateString()}
 </p>
 </div>
 
 <div className="flex items-center gap-2">
 <Badge className={cn("text-[9px] font-bold px-2", member.status === 'ACTIVE' ? 'bg-emerald-500/10 text-emerald-400 border-emerald-500/20' : 'bg-muted0/10 text-muted-foreground border-slate-500/20')}>
 {member.status}
 </Badge>
 </div>
 </div>
 </motion.div>)}
 </div>
 </CardContent>
 </Card>}
 </div>
 </div>

 {/* Edit Document Dialog */}
 <Dialog open={isEditOpen} onOpenChange={setIsEditOpen}>
 <DialogContent className="max-w-md bg-card text-card-foreground">
 <DialogHeader>
 <DialogTitle>{t("admin_auto_edit_document", "Edit Document")}</DialogTitle>
 <DialogDescription>{t("admin_auto_update_document_details", "Update document details")}</DialogDescription>
 </DialogHeader>
 {editingDoc && (
 <div className="py-4 space-y-4">
 <div className="space-y-2">
 <Label>{t("admin_auto_document_name", "Document Name")}</Label>
 <Input value={editingDoc.name} onChange={e => setEditingDoc({...editingDoc, name: e.target.value})} />
 </div>
 <div className="space-y-2">
 <Label>{t("admin_auto_status", "Status")}</Label>
 <Select value={editingDoc.status} onValueChange={v => setEditingDoc({...editingDoc, status: v as any})}>
 <SelectTrigger>
 <SelectValue />
 </SelectTrigger>
 <SelectContent>
 <SelectItem value="DRAFT">{t("admin_contract_draft", "Draft")}</SelectItem>
 <SelectItem value="PENDING">{t("admin_ai_pending", "Pending")}</SelectItem>
 <SelectItem value="APPROVED">{t("admin_compliance_status_approved", "Approved")}</SelectItem>
 <SelectItem value="EXPIRED">{t("admin_compliance_status_expired", "Expired")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 <div className="space-y-2">
 <Label>{t("admin_auto_description", "Description")}</Label>
 <Input value={editingDoc.description} onChange={e => setEditingDoc({...editingDoc, description: e.target.value})} />
 </div>
 </div>
 )}
 <DialogFooter>
 <Button variant="outline" onClick={() => setIsEditOpen(false)}>{t("admin_action_cancel", "Cancel")}</Button>
 <Button onClick={() => { setDocuments(documents.map(d => d.id === editingDoc?.id ? editingDoc : d)); setIsEditOpen(false); toast({ title:"Success", description:"Document updated successfully" }); }}>
 {t("admin_ai_save_changes", "Save Changes")}</Button>
 </DialogFooter>
 </DialogContent>
 </Dialog>
 </PageShell>;
}