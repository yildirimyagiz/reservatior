"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { PageShell } from "../../client/layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle, DialogTrigger } from "@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuLabel, DropdownMenuSeparator, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { useToast } from "@/hooks/use-toast";
import { aiApi, type AiBrochureGeneration } from "@/lib/api/ai";
import { FileText, Download, Plus, Edit, Trash2, MoreHorizontal, Eye } from "lucide-react";
export default function AiBrochureGenerationPage() {
  const {
    t
  } = useTranslation();
  const [brochures, setBrochures] = useState<AiBrochureGeneration[]>([]);
  const [loading, setLoading] = useState(true);
  const [selectedBrochure, setSelectedBrochure] = useState<AiBrochureGeneration | null>(null);
  const [isCreateDialogOpen, setIsCreateDialogOpen] = useState(false);
  const [isEditDialogOpen, setIsEditDialogOpen] = useState(false);
  const [isViewDialogOpen, setIsViewDialogOpen] = useState(false);
  const {
    toast
  } = useToast();
  const [form, setForm] = useState({
    propertyId: '',
    listingId: '',
    pdfUrl: '',
    language: '',
    status: 'PENDING'
  });
  useEffect(() => {
    fetchBrochures();
  }, []);
  const fetchBrochures = async () => {
    try {
      const response = await aiApi.getServiceTasks({
        taskType: 'BROCHURE_GEN'
      });
      // Transform to brochure format - this would come from a separate brochure API
      const mockBrochures: AiBrochureGeneration[] = response.map(task => ({
        id: task.id,
        propertyId: task.propertyId || '',
        listingId: task.listingId,
        pdfUrl: `https://example.com/brochure/${task.id}.pdf`,
        language: 'en',
        status: task.status as any,
        generatedAt: task.createdAt
      }));
      setBrochures(mockBrochures);
    } catch (error) {
      toast({
        title: t("admin.ai.error"),
        description: t("admin.ai.failed_to_fetch_brochure"),
        variant: "destructive"
      });
    } finally {
      setLoading(false);
    }
  };
  const createBrochure = async () => {
    try {
      const response = await aiApi.createServiceTask({
        propertyId: form.propertyId || undefined,
        listingId: form.listingId || undefined,
        taskType: 'BROCHURE_GEN',
        inputData: {
          language: form.language
        }
      });
      const newBrochure: AiBrochureGeneration = {
        id: response.id,
        propertyId: form.propertyId,
        listingId: form.listingId,
        pdfUrl: form.pdfUrl,
        language: form.language,
        status: form.status as any,
        generatedAt: new Date().toISOString()
      };
      setBrochures([...brochures, newBrochure]);
      setIsCreateDialogOpen(false);
      resetForm();
      toast({
        title: t("admin.ai.success"),
        description: t("admin.ai.brochure_generation_task_created")
      });
    } catch (error) {
      toast({
        title: t("admin.ai.error"),
        description: t("admin.ai.failed_to_create_brochure"),
        variant: "destructive"
      });
    }
  };
  const updateBrochure = async () => {
    if (!selectedBrochure) return;
    try {
      const response = await aiApi.updateServiceTask(selectedBrochure.id, {
        progress: selectedBrochure.status === 'COMPLETED' ? 100 : 50
      });
      const updatedBrochure = {
        ...selectedBrochure,
        status: form.status as any,
        language: form.language
      };
      setBrochures(brochures.map(brochure => brochure.id === selectedBrochure.id ? updatedBrochure : brochure));
      setIsEditDialogOpen(false);
      setSelectedBrochure(null);
      resetForm();
      toast({
        title: t("admin.ai.success"),
        description: t("admin.ai.brochure_generation_updated_successfully")
      });
    } catch (error) {
      toast({
        title: t("admin.ai.error"),
        description: t("admin.ai.failed_to_update_brochure"),
        variant: "destructive"
      });
    }
  };
  const deleteBrochure = async (id: string) => {
    try {
      await aiApi.cancelServiceTask(id);
      setBrochures(brochures.filter(brochure => brochure.id !== id));
      toast({
        title: t("admin.ai.success"),
        description: t("admin.ai.brochure_generation_deleted_successfully")
      });
    } catch (error) {
      toast({
        title: t("admin.ai.error"),
        description: t("admin.ai.failed_to_delete_brochure"),
        variant: "destructive"
      });
    }
  };
  const resetForm = () => {
    setForm({
      propertyId: '',
      listingId: '',
      pdfUrl: '',
      language: '',
      status: 'PENDING'
    });
  };
  const openEdit = (brochure: AiBrochureGeneration) => {
    setSelectedBrochure(brochure);
    setForm({
      propertyId: brochure.propertyId,
      listingId: brochure.listingId || '',
      pdfUrl: brochure.pdfUrl,
      language: brochure.language || '',
      status: brochure.status
    });
    setIsEditDialogOpen(true);
  };
  const openView = (brochure: AiBrochureGeneration) => {
    setSelectedBrochure(brochure);
    setForm({
      propertyId: brochure.propertyId,
      listingId: brochure.listingId || '',
      pdfUrl: brochure.pdfUrl,
      language: brochure.language || '',
      status: brochure.status
    });
    setIsViewDialogOpen(true);
  };
  const getStatusColor = (status: string) => {
    switch (status) {
      case 'COMPLETED':
        return 'bg-green-100 text-green-800';
      case 'FAILED':
        return 'bg-red-100 text-red-800';
      case 'PROCESSING':
        return 'bg-slate-100 text-slate-800';
      case 'PENDING':
        return 'bg-yellow-100 text-yellow-800';
      default:
        return 'bg-white/5 text-slate-300';
    }
  };
  if (loading) {
    return <PageShell title={t("admin.ai.ai_brochure_generation_management")}>
        <div className="flex items-center justify-center h-64">
          <FileText className="h-8 w-8 animate-spin" />
        </div>
      </PageShell>;
  }
  return <PageShell title={t("admin.ai.ai_brochure_generation_management")}>
      <div className="space-y-6">
        <div className="flex justify-between items-center">
          <div>
            <h1 className="text-3xl font-bold">{t("admin.ai.ai_brochure_generation")}</h1>
            <p className="text-muted-foreground">{t("admin.ai.manage_aigenerated_property_brochures")}</p>
          </div>
          <Dialog open={isCreateDialogOpen} onOpenChange={setIsCreateDialogOpen}>
            <DialogTrigger asChild>
              <Button>
                <Plus className="h-4 w-4 mr-2" />{t("admin.ai.generate_brochure")}</Button>
            </DialogTrigger>
            <DialogContent className="max-w-2xl">
              <DialogHeader>
                <DialogTitle>{t("admin.ai.generate_new_property_brochure")}</DialogTitle>
                <DialogDescription>{t("admin.ai.create_a_new_aigenerated")}</DialogDescription>
              </DialogHeader>
              <div className="grid gap-4 py-4">
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label htmlFor="propertyId" className="text-right">{t("admin.ai.property_id")}</Label>
                  <Input id="propertyId" value={form.propertyId} onChange={e => setForm({
                  ...form,
                  propertyId: e.target.value
                })} className="col-span-3" placeholder={t("admin.ai.prop")} />
                </div>
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label htmlFor="listingId" className="text-right">{t("admin.ai.listing_id")}</Label>
                  <Input id="listingId" value={form.listingId} onChange={e => setForm({
                  ...form,
                  listingId: e.target.value
                })} className="col-span-3" placeholder={t("admin.ai.listing")} />
                </div>
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label htmlFor="pdfUrl" className="text-right">{t("admin.ai.pdf_url")}</Label>
                  <Input id="pdfUrl" value={form.pdfUrl} onChange={e => setForm({
                  ...form,
                  pdfUrl: e.target.value
                })} className="col-span-3" placeholder={t("admin.ai.https")} />
                </div>
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label htmlFor="language" className="text-right">{t("admin.ai.language")}</Label>
                  <Select value={form.language} onValueChange={value => setForm({
                  ...form,
                  language: value
                })}>
                    <SelectTrigger className="col-span-3">
                      <SelectValue placeholder={t("admin.ai.select_language")} />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="en">{t("admin.ai.english")}</SelectItem>
                      <SelectItem value="tr">{t("admin.ai.turkish")}</SelectItem>
                      <SelectItem value="ar">{t("admin.ai.arabic")}</SelectItem>
                      <SelectItem value="es">{t("admin.ai.spanish")}</SelectItem>
                      <SelectItem value="fr">{t("admin.ai.french")}</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label htmlFor="status" className="text-right">{t("admin.ai.status")}</Label>
                  <Select value={form.status} onValueChange={value => setForm({
                  ...form,
                  status: value
                })}>
                    <SelectTrigger className="col-span-3">
                      <SelectValue />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="PENDING">{t("admin.ai.pending")}</SelectItem>
                      <SelectItem value="PROCESSING">{t("admin.ai.processing")}</SelectItem>
                      <SelectItem value="COMPLETED">{t("admin.ai.completed")}</SelectItem>
                      <SelectItem value="FAILED">{t("admin.ai.failed")}</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
              </div>
              <DialogFooter>
                <Button onClick={createBrochure}>{t("admin.ai.generate_brochure")}</Button>
              </DialogFooter>
            </DialogContent>
          </Dialog>
        </div>

        <Card>
          <CardHeader>
            <CardTitle>{t("admin.ai.generated_brochures")}</CardTitle>
          </CardHeader>
          <CardContent>
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>{t("admin.ai.property")}</TableHead>
                  <TableHead>{t("admin.ai.language")}</TableHead>
                  <TableHead>{t("admin.ai.status")}</TableHead>
                  <TableHead>{t("admin.ai.generated_at")}</TableHead>
                  <TableHead>{t("admin.ai.pdf")}</TableHead>
                  <TableHead className="text-right">{t("admin.ai.actions")}</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {brochures.map(brochure => <TableRow key={brochure.id}>
                    <TableCell className="font-medium">
                      <div className="flex items-center gap-2">
                        <FileText className="h-4 w-4" />
                        <div>
                          <div>{brochure.propertyId}</div>
                          {brochure.listingId && <div className="text-xs text-muted-foreground">{brochure.listingId}</div>}
                        </div>
                      </div>
                    </TableCell>
                    <TableCell>
                      <Badge variant="outline">{brochure.language || 'en'}</Badge>
                    </TableCell>
                    <TableCell>
                      <Badge className={getStatusColor(brochure.status)}>
                        {brochure.status}
                      </Badge>
                    </TableCell>
                    <TableCell>
                      {new Date(brochure.generatedAt).toLocaleDateString()}
                    </TableCell>
                    <TableCell>
                      {brochure.status === 'COMPLETED' ? <Button variant="link" className="p-0 h-auto font-mono text-xs" onClick={() => window.open(brochure.pdfUrl, '_blank')}>
                          <Download className="h-3 w-3 mr-1 inline" />{t("admin.ai.download")}</Button> : <span className="text-muted-foreground text-xs">{t("admin.ai.pending")}</span>}
                    </TableCell>
                    <TableCell className="text-right">
                      <DropdownMenu>
                        <DropdownMenuTrigger asChild>
                          <Button variant="ghost" className="h-8 w-8 p-0">
                            <MoreHorizontal className="h-4 w-4" />
                          </Button>
                        </DropdownMenuTrigger>
                        <DropdownMenuContent align="end">
                          <DropdownMenuLabel>{t("admin.ai.actions")}</DropdownMenuLabel>
                          <DropdownMenuItem onClick={() => openView(brochure)}>
                            <Eye className="h-4 w-4 mr-2" />{t("admin.ai.view_details")}</DropdownMenuItem>
                          <DropdownMenuItem onClick={() => openEdit(brochure)}>
                            <Edit className="h-4 w-4 mr-2" />{t("admin.ai.edit")}</DropdownMenuItem>
                          <DropdownMenuSeparator />
                          <DropdownMenuItem onClick={() => deleteBrochure(brochure.id)} className="text-red-600">
                            <Trash2 className="h-4 w-4 mr-2" />{t("admin.ai.delete")}</DropdownMenuItem>
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
              <DialogTitle>{t("admin.ai.edit_brochure_generation")}</DialogTitle>
              <DialogDescription>{t("admin.ai.update_the_brochure_generation")}</DialogDescription>
            </DialogHeader>
            <div className="grid gap-4 py-4">
              <div className="grid grid-cols-4 items-center gap-4">
                <Label htmlFor="edit-language" className="text-right">{t("admin.ai.language")}</Label>
                <Select value={form.language} onValueChange={value => setForm({
                ...form,
                language: value
              })}>
                  <SelectTrigger className="col-span-3">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="en">{t("admin.ai.english")}</SelectItem>
                    <SelectItem value="tr">{t("admin.ai.turkish")}</SelectItem>
                    <SelectItem value="ar">{t("admin.ai.arabic")}</SelectItem>
                    <SelectItem value="es">{t("admin.ai.spanish")}</SelectItem>
                    <SelectItem value="fr">{t("admin.ai.french")}</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <div className="grid grid-cols-4 items-center gap-4">
                <Label htmlFor="edit-status" className="text-right">{t("admin.ai.status")}</Label>
                <Select value={form.status} onValueChange={value => setForm({
                ...form,
                status: value
              })}>
                  <SelectTrigger className="col-span-3">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="PENDING">{t("admin.ai.pending")}</SelectItem>
                    <SelectItem value="PROCESSING">{t("admin.ai.processing")}</SelectItem>
                    <SelectItem value="COMPLETED">{t("admin.ai.completed")}</SelectItem>
                    <SelectItem value="FAILED">{t("admin.ai.failed")}</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </div>
            <DialogFooter>
              <Button onClick={updateBrochure}>{t("admin.ai.update_brochure")}</Button>
            </DialogFooter>
          </DialogContent>
        </Dialog>

        <Dialog open={isViewDialogOpen} onOpenChange={setIsViewDialogOpen}>
          <DialogContent className="max-w-2xl">
            <DialogHeader>
              <DialogTitle>{t("admin.ai.view_brochure_details")}</DialogTitle>
              <DialogDescription>{t("admin.ai.detailed_view_of_the")}</DialogDescription>
            </DialogHeader>
            <div className="grid gap-4 py-4">
              <div className="grid grid-cols-4 items-center gap-4">
                <Label className="text-right font-medium">{t("admin.ai.property_id")}</Label>
                <span className="col-span-3 font-mono text-sm">{form.propertyId}</span>
              </div>
              <div className="grid grid-cols-4 items-center gap-4">
                <Label className="text-right font-medium">{t("admin.ai.listing_id")}</Label>
                <span className="col-span-3 font-mono text-sm">{form.listingId || 'N/A'}</span>
              </div>
              <div className="grid grid-cols-4 items-center gap-4">
                <Label className="text-right font-medium">{t("admin.ai.language")}</Label>
                <Badge variant="outline" className="col-span-3 justify-start">{form.language || 'en'}</Badge>
              </div>
              <div className="grid grid-cols-4 items-center gap-4">
                <Label className="text-right font-medium">{t("admin.ai.status")}</Label>
                <Badge className={getStatusColor(form.status)}>{form.status}</Badge>
              </div>
              <div className="grid grid-cols-4 items-center gap-4">
                <Label className="text-right font-medium">{t("admin.ai.pdf_url")}</Label>
                <span className="col-span-3 font-mono text-sm break-all">{form.pdfUrl}</span>
              </div>
            </div>
          </DialogContent>
        </Dialog>
      </div>
    </PageShell>;
}