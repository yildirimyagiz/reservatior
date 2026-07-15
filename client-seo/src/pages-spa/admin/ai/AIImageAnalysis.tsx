"use client";

import { t } from"i18next";
import { useTranslation } from"react-i18next";
import { useState, useEffect } from"react";
import { PageShell } from"../../client/layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { Button } from"@/components/ui/button";
import { Badge } from"@/components/ui/badge";
import { Input } from"@/components/ui/input";
import { Label } from"@/components/ui/label";
import { Textarea } from"@/components/ui/textarea";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle, DialogTrigger } from"@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from"@/components/ui/select";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuLabel, DropdownMenuSeparator, DropdownMenuTrigger } from"@/components/ui/dropdown-menu";
import { useToast } from"@/hooks/use-toast";
import { aiApi, type AIImageAnalysis } from"@/lib/api/ai";
import { Image, Plus, Edit, Trash2, MoreHorizontal, Eye } from"lucide-react";
export default function AIImageAnalysisPage() {
 const {
 t
 } = useTranslation();
 const [analyses, setAnalyses] = useState<AIImageAnalysis[]>([]);
 const [loading, setLoading] = useState(true);
 const [selectedAnalysis, setSelectedAnalysis] = useState<AIImageAnalysis | null>(null);
 const [isCreateDialogOpen, setIsCreateDialogOpen] = useState(false);
 const [isEditDialogOpen, setIsEditDialogOpen] = useState(false);
 const [isViewDialogOpen, setIsViewDialogOpen] = useState(false);
 const {
 toast
 } = useToast();
 const [form, setForm] = useState({
 propertyId: '',
 imageUrl: '',
 analysisType: '',
 results: '',
 confidence: 0
 });
 useEffect(() => {
 fetchAnalyses();
 }, []);
 const fetchAnalyses = async () => {
 try {
 const response = await aiApi.getImageAnalyses();
 setAnalyses(response);
 } catch (error) {
 toast({
 title: t("admin_ai_error"),
 description: t("admin_ai_failed_to_fetch_image"),
 variant:"destructive"
 });
 } finally {
 setLoading(false);
 }
 };
 const createAnalysis = async () => {
 try {
 const response = await aiApi.createImageAnalysis({
 propertyId: form.propertyId,
 imageUrl: form.imageUrl,
 analysisType: form.analysisType,
 results: JSON.parse(form.results),
 confidence: form.confidence
 });
 setAnalyses([...analyses, response]);
 setIsCreateDialogOpen(false);
 resetForm();
 toast({
 title: t("admin_ai_success"),
 description: t("admin_ai_image_analysis_created_successfully")
 });
 } catch (error) {
 toast({
 title: t("admin_ai_error"),
 description: t("admin_ai_failed_to_create_image"),
 variant:"destructive"
 });
 }
 };
 const updateAnalysis = async () => {
 if (!selectedAnalysis) return;
 try {
 const response = await aiApi.updateImageAnalysis(selectedAnalysis.id, {
 analysisType: form.analysisType,
 results: JSON.parse(form.results),
 confidence: form.confidence
 });
 setAnalyses(analyses.map(analysis => analysis.id === selectedAnalysis.id ? response : analysis));
 setIsEditDialogOpen(false);
 setSelectedAnalysis(null);
 resetForm();
 toast({
 title: t("admin_ai_success"),
 description: t("admin_ai_image_analysis_updated_successfully")
 });
 } catch (error) {
 toast({
 title: t("admin_ai_error"),
 description: t("admin_ai_failed_to_update_image"),
 variant:"destructive"
 });
 }
 };
 const deleteAnalysis = async (id: string) => {
 try {
 await aiApi.deleteImageAnalysis(id);
 setAnalyses(analyses.filter(analysis => analysis.id !== id));
 toast({
 title: t("admin_ai_success"),
 description: t("admin_ai_image_analysis_deleted_successfully")
 });
 } catch (error) {
 toast({
 title: t("admin_ai_error"),
 description: t("admin_ai_failed_to_delete_image"),
 variant:"destructive"
 });
 }
 };
 const resetForm = () => {
 setForm({
 propertyId: '',
 imageUrl: '',
 analysisType: '',
 results: '',
 confidence: 0
 });
 };
 const openEdit = (analysis: AIImageAnalysis) => {
 setSelectedAnalysis(analysis);
 setForm({
 propertyId: analysis.propertyId,
 imageUrl: analysis.imageUrl,
 analysisType: analysis.analysisType,
 results: JSON.stringify(analysis.results, null, 2),
 confidence: analysis.confidence
 });
 setIsEditDialogOpen(true);
 };
 const openView = (analysis: AIImageAnalysis) => {
 setSelectedAnalysis(analysis);
 setForm({
 propertyId: analysis.propertyId,
 imageUrl: analysis.imageUrl,
 analysisType: analysis.analysisType,
 results: JSON.stringify(analysis.results, null, 2),
 confidence: analysis.confidence
 });
 setIsViewDialogOpen(true);
 };
 if (loading) {
 return <PageShell title={t("admin_ai_ai_image_analysis_management")}>
 <div className="flex items-center justify-center h-64">
 <Image className="h-8 w-8 animate-spin" />
 </div>
 </PageShell>;
 }
 return <PageShell title={t("admin_ai_ai_image_analysis_management")}>
 <div className="animate-in fade-in slide-in-from-bottom-4 duration-700 space-y-6">
 <div className="flex justify-between items-center">
 <div>
 <h1 className="text-3xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-slate-200 to-slate-500">{t("admin_ai_ai_image_analysis")}</h1>
 <p className="text-muted-foreground">{t("admin_ai_manage_aipowered_image_analysis")}</p>
 </div>
 <Dialog open={isCreateDialogOpen} onOpenChange={setIsCreateDialogOpen}>
 <DialogTrigger asChild>
 <Button>
 <Plus className="h-4 w-4 mr-2" />{t("admin_ai_add_analysis")}</Button>
 </DialogTrigger>
 <DialogContent className="max-w-2xl">
 <DialogHeader>
 <DialogTitle>{t("admin_ai_add_new_image_analysis")}</DialogTitle>
 <DialogDescription>{t("admin_ai_create_a_new_ai")}</DialogDescription>
 </DialogHeader>
 <div className="grid gap-4 py-4">
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="propertyId" className="text-right">{t("admin_ai_property_id")}</Label>
 <Input id="propertyId" value={form.propertyId} onChange={e => setForm({
 ...form,
 propertyId: e.target.value
 })} className="col-span-3" placeholder={t("admin_ai_prop")} />
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="imageUrl" className="text-right">{t("admin_ai_image_url")}</Label>
 <Input id="imageUrl" value={form.imageUrl} onChange={e => setForm({
 ...form,
 imageUrl: e.target.value
 })} className="col-span-3" placeholder={t("admin_ai_https")} />
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="analysisType" className="text-right">{t("admin_ai_analysis_type")}</Label>
 <Input id="analysisType" value={form.analysisType} onChange={e => setForm({
 ...form,
 analysisType: e.target.value
 })} className="col-span-3" placeholder={t("admin_ai_eg_roomdetection_damagedetection")} />
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="confidence" className="text-right">{t("admin_ai_confidence")}</Label>
 <Input id="confidence" type="number" step="0.01" min="0" max="1" value={form.confidence} onChange={e => setForm({
 ...form,
 confidence: parseFloat(e.target.value)
 })} className="col-span-3" />
 </div>
 <div className="grid grid-cols-4 items-start gap-4">
 <Label htmlFor="results" className="text-right pt-2">{t("admin_ai_results_json")}</Label>
 <Textarea id="results" value={form.results} onChange={e => setForm({
 ...form,
 results: e.target.value
 })} className="col-span-3 min-h-32" placeholder={t("admin_ai_detectedobjects_analysis")} />
 </div>
 </div>
 <DialogFooter>
 <Button onClick={createAnalysis}>{t("admin_ai_create_analysis")}</Button>
 </DialogFooter>
 </DialogContent>
 </Dialog>
 </div>

 <Card>
 <CardHeader>
 <CardTitle>{t("admin_ai_image_analyses")}</CardTitle>
 </CardHeader>
 <CardContent>
 <Table>
 <TableHeader>
 <TableRow>
 <TableHead>{t("admin_ai_property")}</TableHead>
 <TableHead>{t("admin_ai_analysis_type")}</TableHead>
 <TableHead>{t("admin_ai_confidence")}</TableHead>
 <TableHead>{t("admin_ai_processed_at")}</TableHead>
 <TableHead className="text-right">{t("admin_ai_actions")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {analyses.map(analysis => <TableRow key={analysis.id}>
 <TableCell className="font-medium">
 <div className="flex items-center gap-2">
 <Image className="h-4 w-4" />
 {analysis.propertyId}
 </div>
 </TableCell>
 <TableCell>
 <Badge variant="outline">{analysis.analysisType}</Badge>
 </TableCell>
 <TableCell>
 <div className="flex items-center gap-2">
 <div className="w-16 bg-card rounded-full h-2">
 <div className="bg-green-500 h-2 rounded-full" style={{
 width: `${analysis.confidence * 100}%`
 }} />
 </div>
 <span className="text-sm">{(analysis.confidence * 100).toFixed(1)}%</span>
 </div>
 </TableCell>
 <TableCell>
 {new Date(analysis.processedAt).toLocaleDateString()}
 </TableCell>
 <TableCell className="text-right">
 <DropdownMenu>
 <DropdownMenuTrigger asChild>
 <Button variant="ghost" className="h-8 w-8 p-0">
 <MoreHorizontal className="h-4 w-4" />
 </Button>
 </DropdownMenuTrigger>
 <DropdownMenuContent align="end">
 <DropdownMenuLabel>{t("admin_ai_actions")}</DropdownMenuLabel>
 <DropdownMenuItem onClick={() => openView(analysis)}>
 <Eye className="h-4 w-4 mr-2" />{t("admin_ai_view_details")}</DropdownMenuItem>
 <DropdownMenuItem onClick={() => openEdit(analysis)}>
 <Edit className="h-4 w-4 mr-2" />{t("admin_ai_edit")}</DropdownMenuItem>
 <DropdownMenuSeparator />
 <DropdownMenuItem onClick={() => deleteAnalysis(analysis.id)} className="text-red-600">
 <Trash2 className="h-4 w-4 mr-2" />{t("admin_ai_delete")}</DropdownMenuItem>
 </DropdownMenuContent>
 </DropdownMenu>
 </TableCell>
 </TableRow>)}
 </TableBody>
 </Table>
 </CardContent>
 </Card>

 <Dialog open={isEditDialogOpen} onOpenChange={setIsEditDialogOpen}>
 <DialogContent className="max-w-2xl">
 <DialogHeader>
 <DialogTitle>{t("admin_ai_edit_image_analysis")}</DialogTitle>
 <DialogDescription>{t("admin_ai_update_the_image_analysis")}</DialogDescription>
 </DialogHeader>
 <div className="grid gap-4 py-4">
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="edit-analysisType" className="text-right">{t("admin_ai_analysis_type")}</Label>
 <Input id="edit-analysisType" value={form.analysisType} onChange={e => setForm({
 ...form,
 analysisType: e.target.value
 })} className="col-span-3" />
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="edit-confidence" className="text-right">{t("admin_ai_confidence")}</Label>
 <Input id="edit-confidence" type="number" step="0.01" min="0" max="1" value={form.confidence} onChange={e => setForm({
 ...form,
 confidence: parseFloat(e.target.value)
 })} className="col-span-3" />
 </div>
 <div className="grid grid-cols-4 items-start gap-4">
 <Label htmlFor="edit-results" className="text-right pt-2">{t("admin_ai_results_json")}</Label>
 <Textarea id="edit-results" value={form.results} onChange={e => setForm({
 ...form,
 results: e.target.value
 })} className="col-span-3 min-h-32" />
 </div>
 </div>
 <DialogFooter>
 <Button onClick={updateAnalysis}>{t("admin_ai_update_analysis")}</Button>
 </DialogFooter>
 </DialogContent>
 </Dialog>

 <Dialog open={isViewDialogOpen} onOpenChange={setIsViewDialogOpen}>
 <DialogContent className="max-w-2xl">
 <DialogHeader>
 <DialogTitle>{t("admin_ai_view_image_analysis_details")}</DialogTitle>
 <DialogDescription>{t("admin_ai_detailed_view_of_the")}</DialogDescription>
 </DialogHeader>
 <div className="grid gap-4 py-4">
 <div className="grid grid-cols-4 items-center gap-4">
 <Label className="text-right font-medium">{t("admin_ai_property_id")}</Label>
 <span className="col-span-3 font-mono text-sm">{form.propertyId}</span>
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label className="text-right font-medium">{t("admin_ai_image_url")}</Label>
 <span className="col-span-3 font-mono text-sm break-all">{form.imageUrl}</span>
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label className="text-right font-medium">{t("admin_ai_analysis_type")}</Label>
 <Badge variant="outline" className="col-span-3 justify-start">{form.analysisType}</Badge>
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label className="text-right font-medium">{t("admin_ai_confidence")}</Label>
 <span className="col-span-3">{(form.confidence * 100).toFixed(1)}%</span>
 </div>
 <div className="grid grid-cols-4 items-start gap-4">
 <Label className="text-right pt-2 font-medium">{t("admin_ai_results")}</Label>
 <pre className="col-span-3 bg-card p-2 rounded-lg text-xs overflow-auto max-h-48">
 {form.results}
 </pre>
 </div>
 </div>
 </DialogContent>
 </Dialog>
 </div>
 </PageShell>;
}