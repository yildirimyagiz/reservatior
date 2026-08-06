"use client";

import { t } from"i18next";
import { useTranslation } from"react-i18next";
import { useState } from"react";
import { PageShell } from "@/pages-spa/admin/layout/PageShell";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from"@/components/ui/card";
import { Button } from"@/components/ui/button";
import { Badge } from"@/components/ui/badge";
import { Input } from"@/components/ui/input";
import { Label } from"@/components/ui/label";
import { Textarea } from"@/components/ui/textarea";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from"@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription, DialogFooter } from"@/components/ui/dialog";
import { Switch } from"@/components/ui/switch";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from"@/components/ui/dropdown-menu";
import { useToast } from"@/hooks/use-toast";
import { useQuery, useMutation, useQueryClient } from"@tanstack/react-query";
import { communicationTemplatesApi } from"@/lib/api/communication-templates";
import { Mail, Send, FileText, MessageSquare, Bell, Smartphone, Edit, Trash2, Plus, MoreHorizontal, Copy, TestTube, CheckCircle, Loader2 } from"lucide-react";
import { apiClient } from"@/lib/api";
interface CommunicationTemplate {
 id: string;
 name: string;
 type:"EMAIL" |"SMS" |"PUSH" |"IN_APP";
 category: string;
 subject?: string;
 content: string;
 variables: string[];
 isActive: boolean;
 language: string;
 createdAt: string;
 updatedAt: string;
 createdBy: string;
 usageCount: number;
 lastUsed?: string;
}
interface TemplateVariable {
 name: string;
 description: string;
 example: string;
}
const MOCK_TEMPLATES: CommunicationTemplate[] = [{
 id:"1",
 name:"Welcome Email",
 type:"EMAIL",
 category:"Onboarding",
 subject:"Welcome to Reservatior!",
 content:"Hello {{user_name}},\n\nWelcome to Reservatior! We're excited to have you on board.\n\nYour account has been successfully created with email: {{user_email}}.\n\nBest regards,\nThe Reservatior Team",
 variables: ["user_name","user_email"],
 isActive: true,
 language:"en",
 createdAt:"2024-03-20",
 updatedAt:"2024-03-28",
 createdBy:"admin",
 usageCount: 156,
 lastUsed:"2024-03-28"
}, {
 id:"2",
 name:"Booking Confirmation",
 type:"EMAIL",
 category:"Bookings",
 subject:"Booking Confirmed - {{property_name}}",
 content:"Hi {{user_name}},\n\nYour booking for {{property_name}} has been confirmed!\n\nBooking Details:\n- Property: {{property_name}}\n- Check-in: {{check_in_date}}\n- Check-out: {{check_out_date}}\n- Total: {{total_price}}\n\nPlease arrive at {{check_in_time}} for check-in.\n\nThank you!",
 variables: ["user_name","property_name","check_in_date","check_out_date","total_price","check_in_time"],
 isActive: true,
 language:"en",
 createdAt:"2024-03-15",
 updatedAt:"2024-03-25",
 createdBy:"admin",
 usageCount: 342,
 lastUsed:"2024-03-27"
}, {
 id:"3",
 name:"Payment Reminder",
 type:"SMS",
 category:"Payments",
 content:"Hi {{user_name}}, this is a reminder that your payment of {{amount}} for {{property_name}} is due on {{due_date}}. Please ensure timely payment to avoid late fees.",
 variables: ["user_name","amount","property_name","due_date"],
 isActive: true,
 language:"en",
 createdAt:"2024-03-10",
 updatedAt:"2024-03-20",
 createdBy:"admin",
 usageCount: 89,
 lastUsed:"2024-03-26"
}, {
 id:"4",
 name:"New Lead Notification",
 type:"EMAIL",
 category:"Leads",
 subject:"New Lead: {{lead_name}} - {{property_interest}}",
 content:"A new lead has been generated:\n\nName: {{lead_name}}\nEmail: {{lead_email}}\nPhone: {{lead_phone}}\nProperty Interest: {{property_interest}}\nBudget: {{budget}}\nTimeline: {{timeline}}\n\nPlease follow up as soon as possible.",
 variables: ["lead_name","lead_email","lead_phone","property_interest","budget","timeline"],
 isActive: true,
 language:"en",
 createdAt:"2024-03-05",
 updatedAt:"2024-03-22",
 createdBy:"admin",
 usageCount: 234,
 lastUsed:"2024-03-28"
}];
const TEMPLATE_VARIABLES: TemplateVariable[] = [{
 name:"user_name",
 description: t("admin_communication_users_full_name"),
 example:"John Doe"
}, {
 name:"user_email",
 description: t("admin_communication_users_email_address"),
 example:"john@example.com"
}, {
 name:"property_name",
 description: t("admin_communication_property_name"),
 example:"Luxury Downtown Apartment"
}, {
 name:"check_in_date",
 description: t("admin_communication_checkin_date"),
 example:"2024-04-15"
}, {
 name:"check_out_date",
 description: t("admin_communication_checkout_date"),
 example:"2024-04-22"
}, {
 name:"total_price",
 description: t("admin_communication_total_booking_price"),
 example:"$1,200"
}];
export default function CommunicationTemplates() {
 const {
 t
 } = useTranslation();
 const {
 toast
 } = useToast();
 const queryClient = useQueryClient();
 const deleteMutation = useMutation({
 mutationFn: async (id: string) => apiClient.delete(`/unknown/${id}`),
 onSuccess: () => {
 toast({ title:"Deleted", description:"Record deleted successfully" });
 queryClient.invalidateQueries();
 },
 onError: (err: any) => toast({ title:"Error", description: err.message, variant:"destructive" })
 });
 

 const [templateDialogOpen, setTemplateDialogOpen] = useState(false);
 const [testDialogOpen, setTestDialogOpen] = useState(false);
 const [selectedTemplate, setSelectedTemplate] = useState<CommunicationTemplate | null>(null);
 const [filterType, setFilterType] = useState("all");
 const [filterCategory, setFilterCategory] = useState("all");

 const { data: templatesData, isLoading } = useQuery({
 queryKey: ['communicationTemplates'],
 queryFn: async () => {
 const res = await communicationTemplatesApi.getAll("current");
 const apiTemplates = Array.isArray(res) ? res : ((res as any).data || []);
 
 return apiTemplates.map((t: any) => ({
 id: t.id,
 name: t.name ||"Unnamed Template",
 type: t.type ==="EMAIL" || t.type ==="SMS" || t.type ==="PUSH" || t.type ==="IN_APP" ? t.type :"EMAIL",
 category: t.category ||"General",
 subject: t.subject ||"",
 content: t.content ||"",
 variables: t.variables?.map((v: any) => v.name) || [],
 isActive: t.isActive !== false,
 language:"en",
 createdAt: t.createdAt || new Date().toISOString(),
 updatedAt: t.updatedAt || new Date().toISOString(),
 createdBy: t.createdBy ||"system",
 usageCount: t.usage?.totalSent || 0,
 lastUsed: t.usage?.lastUsedAt
 })) as CommunicationTemplate[];
 }
 });

 const templates = templatesData && templatesData.length > 0 ? templatesData : MOCK_TEMPLATES;

 const toggleTemplateMutation = useMutation({
 mutationFn: async (template: CommunicationTemplate) => {
 return await communicationTemplatesApi.updateStatus("current", template.id, {
 isActive: !template.isActive
 });
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['communicationTemplates'] });
 toast({
 title: t("admin_communication_template_updated"),
 description: t("admin_communication_template_status_has_been")
 });
 },
 onError: (error: any) => {
 toast({
 title: t("admin_communication_error", "Eşit"),
 description: error.message,
 variant:"destructive"
 });
 }
 });
 const getTypeIcon = (type: string) => {
 switch (type) {
 case"EMAIL":
 return <Mail className="w-4 h-4" />;
 case"SMS":
 return <MessageSquare className="w-4 h-4" />;
 case"PUSH":
 return <Bell className="w-4 h-4" />;
 case"IN_APP":
 return <Smartphone className="w-4 h-4" />;
 default:
 return <FileText className="w-4 h-4" />;
 }
 };
 const getTypeColor = (type: string) => {
 switch (type) {
 case"EMAIL":
 return"bg-muted text-muted-foreground";
 case"SMS":
 return"bg-blue-100 text-blue-700";
 case"PUSH":
 return"bg-muted text-muted-foreground";
 case"IN_APP":
 return"bg-orange-100 text-orange-700";
 default:
 return"bg-card text-muted-foreground";
 }
 };
 const toggleTemplate = (template: CommunicationTemplate) => {
 toggleTemplateMutation.mutate(template);
 };
 const deleteTemplateMutation = useMutation({
 mutationFn: async (id: string) => {
 await communicationTemplatesApi.delete("current", id);
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['communicationTemplates'] });
 toast({
 title: t("admin_communication_template_deleted"),
 description: t("admin_communication_template_has_been_removed")
 });
 },
 onError: (error: any) => {
 toast({
 title: t("admin_communication_error", "Eşit"),
 description: error.message,
 variant:"destructive"
 });
 }
 });

 const deleteTemplate = (templateId: string) => {
 deleteTemplateMutation.mutate(templateId);
 };
 const duplicateTemplateMutation = useMutation({
 mutationFn: async (template: CommunicationTemplate) => {
 return await communicationTemplatesApi.clone("current", template.id, {
 name: `${template.name} (Copy)`
 });
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['communicationTemplates'] });
 toast({
 title: t("admin_communication_template_duplicated"),
 description: t("admin_communication_template_has_been_duplicated")
 });
 },
 onError: (error: any) => {
 toast({
 title: t("admin_communication_error", "Eşit"),
 description: error.message,
 variant:"destructive"
 });
 }
 });

 const duplicateTemplate = (template: CommunicationTemplate) => {
 duplicateTemplateMutation.mutate(template);
 };
 const testTemplate = (template: CommunicationTemplate) => {
 setSelectedTemplate(template);
 setTestDialogOpen(true);
 };
 const sendTestMessage = () => {
 toast({
 title: t("admin_communication_test_message_sent"),
 description: t("admin_communication_test_message_has_been")
 });
 setTestDialogOpen(false);
 };
 const filteredTemplates = templates.filter(template => {
 const matchesType = filterType ==="all" || template.type === filterType;
 const matchesCategory = filterCategory ==="all" || template.category === filterCategory;
 return matchesType && matchesCategory;
 });
 const stats = {
 total: templates.length,
 active: templates.filter(t => t.isActive).length,
 email: templates.filter(t => t.type ==="EMAIL").length,
 sms: templates.filter(t => t.type ==="SMS").length,
 push: templates.filter(t => t.type ==="PUSH").length,
 inApp: templates.filter(t => t.type ==="IN_APP").length,
 totalUsage: templates.reduce((sum, t) => sum + t.usageCount, 0)
 };
 return <PageShell title={t("admin_communication_communication_templates")} description={t("admin_communication_manage_email_sms_and")}>
 <div className="animate-in fade-in slide-in-from-bottom-4 duration-700 space-y-6">
 {/* Stats Cards */}
 <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
 <Card>
 <CardContent className="p-4">
 <div className="flex items-center justify-between">
 <div>
 <p className="text-sm font-medium text-muted-foreground">{t("admin_communication_total_templates")}</p>
 <p className="text-2xl font-bold">{stats.total}</p>
 <p className="text-xs text-muted-foreground">{t("admin_communication_all_types")}</p>
 </div>
 <FileText className="w-8 h-8 text-muted-foreground" />
 </div>
 </CardContent>
 </Card>
 <Card>
 <CardContent className="p-4">
 <div className="flex items-center justify-between">
 <div>
 <p className="text-sm font-medium text-muted-foreground">{t("admin_communication_active")}</p>
 <p className="text-2xl font-bold text-blue-600">{stats.active}</p>
 <p className="text-xs text-muted-foreground">{t("admin_communication_currently_enabled")}</p>
 </div>
 <CheckCircle className="w-8 h-8 text-blue-600" />
 </div>
 </CardContent>
 </Card>
 <Card>
 <CardContent className="p-4">
 <div className="flex items-center justify-between">
 <div>
 <p className="text-sm font-medium text-muted-foreground">{t("admin_communication_email_templates")}</p>
 <p className="text-2xl font-bold text-muted-foreground">{stats.email}</p>
 <p className="text-xs text-muted-foreground">{t("admin_communication_email_type")}</p>
 </div>
 <Mail className="w-8 h-8 text-muted-foreground" />
 </div>
 </CardContent>
 </Card>
 <Card>
 <CardContent className="p-4">
 <div className="flex items-center justify-between">
 <div>
 <p className="text-sm font-medium text-muted-foreground">{t("admin_communication_total_usage")}</p>
 <p className="text-2xl font-bold">{stats.totalUsage.toLocaleString()}</p>
 <p className="text-xs text-muted-foreground">{t("admin_communication_all_time")}</p>
 </div>
 <Send className="w-8 h-8 text-muted-foreground" />
 </div>
 </CardContent>
 </Card>
 </div>

 {/* Filters and Actions */}
 <div className="flex flex-col sm:flex-row gap-4 items-start sm:items-center justify-between">
 <div className="flex flex-col sm:flex-row gap-4 flex-1">
 <Select value={filterType} onValueChange={setFilterType}>
 <SelectTrigger className="w-[150px]">
 <SelectValue placeholder={t("admin_communication_type")} />
 </SelectTrigger>
 <SelectContent>
 <SelectItem value="all">{t("admin_communication_all_types")}</SelectItem>
 <SelectItem value="EMAIL">{t("admin_communication_email")}</SelectItem>
 <SelectItem value="SMS">{t("admin_communication_sms")}</SelectItem>
 <SelectItem value="PUSH">{t("admin_communication_push")}</SelectItem>
 <SelectItem value="IN_APP">{t("admin_communication_inapp")}</SelectItem>
 </SelectContent>
 </Select>
 <Select value={filterCategory} onValueChange={setFilterCategory}>
 <SelectTrigger className="w-[150px]">
 <SelectValue placeholder={t("admin_communication_category")} />
 </SelectTrigger>
 <SelectContent>
 <SelectItem value="all">{t("admin_communication_all_categories")}</SelectItem>
 <SelectItem value="Onboarding">{t("admin_communication_onboarding")}</SelectItem>
 <SelectItem value="Bookings">{t("admin_communication_bookings")}</SelectItem>
 <SelectItem value="Payments">{t("admin_communication_payments")}</SelectItem>
 <SelectItem value="Leads">{t("admin_communication_leads")}</SelectItem>
 <SelectItem value="Marketing">{t("admin_communication_marketing")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 <Button onClick={() => setTemplateDialogOpen(true)}>
 <Plus className="w-4 h-4 mr-2" />{t("admin_communication_new_template")}</Button>
 </div>

 {/* Templates Table */}
 <Card>
 <CardHeader>
 <CardTitle>{t("admin_communication_templates")}{filteredTemplates.length})</CardTitle>
 <CardDescription>{t("admin_communication_manage_your_communication_templates")}</CardDescription>
 </CardHeader>
 <CardContent>
 <Table>
 <TableHeader>
 <TableRow>
 <TableHead>{t("admin_communication_name")}</TableHead>
 <TableHead>{t("admin_communication_type")}</TableHead>
 <TableHead>{t("admin_communication_category")}</TableHead>
 <TableHead>{t("admin_communication_variables")}</TableHead>
 <TableHead>{t("admin_communication_usage")}</TableHead>
 <TableHead>{t("admin_communication_status")}</TableHead>
 <TableHead>{t("admin_communication_actions")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {isLoading ? (
 <TableRow>
 <TableCell colSpan={7} className="text-center py-12">
 <Loader2 className="w-8 h-8 animate-spin mx-auto text-muted-foreground" />
 </TableCell>
 </TableRow>
 ) : (
 filteredTemplates.map(template => <TableRow key={template.id}>
 <TableCell>
 <div>
 <div className="font-medium">{template.name}</div>
 <div className="text-sm text-muted-foreground">
 {template.subject && `Subject: ${template.subject}`}
 </div>
 <div className="text-xs text-muted-foreground">{t("admin_communication_created")}{new Date(template.createdAt).toLocaleDateString()}
 </div>
 </div>
 </TableCell>
 <TableCell>
 <div className="flex items-center gap-2">
 {getTypeIcon(template.type)}
 <Badge className={getTypeColor(template.type)}>
 {template.type}
 </Badge>
 </div>
 </TableCell>
 <TableCell>
 <Badge variant="outline">{template.category}</Badge>
 </TableCell>
 <TableCell>
 <div className="flex flex-wrap gap-1">
 {template.variables.slice(0, 3).map((variable, index) => <Badge key={index} variant="secondary" className="text-xs">
 {variable}
 </Badge>)}
 {template.variables.length > 3 && <Badge variant="secondary" className="text-xs">
 +{template.variables.length - 3}
 </Badge>}
 </div>
 </TableCell>
 <TableCell>
 <div>
 <div className="font-medium">{template.usageCount}</div>
 {template.lastUsed && <div className="text-xs text-muted-foreground">{t("admin_communication_last")}{new Date(template.lastUsed).toLocaleDateString()}
 </div>}
 </div>
 </TableCell>
 <TableCell>
 <div className="flex items-center gap-2">
 <Switch checked={template.isActive} onCheckedChange={() => toggleTemplate(template)} />
 <Badge variant={template.isActive ?"default" :"secondary"}>
 {template.isActive ?"Active" :"Inactive"}
 </Badge>
 </div>
 </TableCell>
 <TableCell>
 <DropdownMenu>
 <DropdownMenuTrigger asChild>
 <Button variant="ghost" size="sm" aria-label={t("common.more")}>
 <MoreHorizontal className="w-4 h-4" />
 </Button>
 </DropdownMenuTrigger>
 <DropdownMenuContent>
 <DropdownMenuItem onClick={() => testTemplate(template)}>
 <TestTube className="w-4 h-4 mr-2" />{t("admin_communication_test")}</DropdownMenuItem>
 <DropdownMenuItem onClick={() => duplicateTemplate(template)}>
 <Copy className="w-4 h-4 mr-2" />{t("admin_communication_duplicate")}</DropdownMenuItem>
 <DropdownMenuItem>
 <Edit className="w-4 h-4 mr-2" />{t("admin_communication_edit")}</DropdownMenuItem>
 <DropdownMenuItem onClick={() => deleteTemplate(template.id)} className="text-red-600">
 <Trash2 className="w-4 h-4 mr-2" />{t("admin_communication_delete")}</DropdownMenuItem>
 </DropdownMenuContent>
 </DropdownMenu>
 </TableCell>
 </TableRow>)
 )}
 </TableBody>
 </Table>
 </CardContent>
 </Card>

 {/* Template Variables Reference */}
 <Card>
 <CardHeader>
 <CardTitle>{t("admin_communication_template_variables")}</CardTitle>
 <CardDescription>{t("admin_communication_available_variables_you_can")}</CardDescription>
 </CardHeader>
 <CardContent>
 <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
 {TEMPLATE_VARIABLES.map((variable, index) => <div key={index} className="p-3 border rounded-lg">
 <div className="font-mono text-sm font-medium">
 {variable.name}
 </div>
 <div className="text-sm text-muted-foreground mt-1">
 {variable.description}
 </div>
 <div className="text-xs text-muted-foreground mt-1">{t("admin_communication_example")}{variable.example}
 </div>
 </div>)}
 </div>
 </CardContent>
 </Card>
 </div>

 {/* Create/Edit Template Dialog */}
 <Dialog open={templateDialogOpen} onOpenChange={setTemplateDialogOpen}>
 <DialogContent className="max-w-2xl">
 <DialogHeader>
 <DialogTitle>{t("admin_communication_create_new_template")}</DialogTitle>
 <DialogDescription>{t("admin_communication_create_a_new_communication")}</DialogDescription>
 </DialogHeader>
 <div className="grid grid-cols-2 gap-4 py-4">
 <div className="space-y-2">
 <Label>{t("admin_communication_template_name")}</Label>
 <Input placeholder={t("admin_communication_enter_template_name")} />
 </div>
 <div className="space-y-2">
 <Label>{t("admin_communication_type")}</Label>
 <Select>
 <SelectTrigger>
 <SelectValue placeholder={t("admin_communication_select_type")} />
 </SelectTrigger>
 <SelectContent>
 <SelectItem value="EMAIL">{t("admin_communication_email")}</SelectItem>
 <SelectItem value="SMS">{t("admin_communication_sms")}</SelectItem>
 <SelectItem value="PUSH">{t("admin_communication_push_notification")}</SelectItem>
 <SelectItem value="IN_APP">{t("admin_communication_inapp_message")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 <div className="space-y-2">
 <Label>{t("admin_communication_category")}</Label>
 <Select>
 <SelectTrigger>
 <SelectValue placeholder={t("admin_communication_select_category")} />
 </SelectTrigger>
 <SelectContent>
 <SelectItem value="Onboarding">{t("admin_communication_onboarding")}</SelectItem>
 <SelectItem value="Bookings">{t("admin_communication_bookings")}</SelectItem>
 <SelectItem value="Payments">{t("admin_communication_payments")}</SelectItem>
 <SelectItem value="Leads">{t("admin_communication_leads")}</SelectItem>
 <SelectItem value="Marketing">{t("admin_communication_marketing")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 <div className="space-y-2">
 <Label>{t("admin_communication_language")}</Label>
 <Select>
 <SelectTrigger>
 <SelectValue placeholder={t("admin_communication_select_language")} />
 </SelectTrigger>
 <SelectContent>
 <SelectItem value="en">{t("admin_communication_english")}</SelectItem>
 <SelectItem value="es">{t("admin_communication_spanish")}</SelectItem>
 <SelectItem value="fr">{t("admin_communication_french")}</SelectItem>
 <SelectItem value="de">{t("admin_communication_german")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 <div className="space-y-2 col-span-2">
 <Label>{t("admin_communication_subject_email_only")}</Label>
 <Input placeholder={t("admin_communication_email_subject_line")} />
 </div>
 <div className="space-y-2 col-span-2">
 <Label>{t("admin_communication_content")}</Label>
 <Textarea placeholder={t("admin_communication_template_content_with_variables")} rows={8} />
 </div>
 <div className="space-y-2 col-span-2">
 <div className="flex items-center space-x-2">
 <Switch />
 <Label>{t("admin_communication_activate_template")}</Label>
 </div>
 </div>
 </div>
 <DialogFooter>
 <Button variant="outline" onClick={() => setTemplateDialogOpen(false)}>{t("admin_communication_cancel")}</Button>
 <Button onClick={() => setTemplateDialogOpen(false)}>{t("admin_communication_create_template")}</Button>
 </DialogFooter>
 </DialogContent>
 </Dialog>

 {/* Test Template Dialog */}
 <Dialog open={testDialogOpen} onOpenChange={setTestDialogOpen}>
 <DialogContent className="max-w-md">
 <DialogHeader>
 <DialogTitle>{t("admin_communication_test_template")}</DialogTitle>
 <DialogDescription>{t("admin_communication_send_a_test_message")}</DialogDescription>
 </DialogHeader>
 {selectedTemplate && <div className="py-4 space-y-4">
 <div className="space-y-2">
 <Label>{t("admin_communication_test_email_address")}</Label>
 <Input type="email" placeholder={t("admin_communication_testexamplecom")} defaultValue="admin@reservatior.com" />
 </div>
 <div className="space-y-2">
 <Label>{t("admin_communication_test_variables")}</Label>
 <div className="space-y-2">
 {selectedTemplate.variables.map((variable, index) => <div key={index} className="flex items-center gap-2">
 <Label className="text-sm w-24">{variable}{t("mobile.leftovers.", ":")}</Label>
 <Input placeholder={`Enter ${variable}`} defaultValue={variable.includes("name") ?"Test User" : variable.includes("email") ?"test@example.com" : variable.includes("property") ?"Test Property" :"Test Value"} />
 </div>)}
 </div>
 </div>
 </div>}
 <DialogFooter>
 <Button variant="outline" onClick={() => setTestDialogOpen(false)}>{t("admin_communication_cancel")}</Button>
 <Button onClick={sendTestMessage}>
 <Send className="w-4 h-4 mr-2" />{t("admin_communication_send_test")}</Button>
 </DialogFooter>
 </DialogContent>
 </Dialog>
 </PageShell>;
}