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
import { aiApi, type AiExtractedData } from "@/lib/api/ai";
import { FileText, Database, Plus, Edit, Trash2, MoreHorizontal } from "lucide-react";
export default function AiExtractedDataPage() {
  const {
    t
  } = useTranslation();
  const [data, setData] = useState<AiExtractedData[]>([]);
  const [loading, setLoading] = useState(true);
  const [selectedItem, setSelectedItem] = useState<AiExtractedData | null>(null);
  const [isCreateDialogOpen, setIsCreateDialogOpen] = useState(false);
  const [isEditDialogOpen, setIsEditDialogOpen] = useState(false);
  const {
    toast
  } = useToast();
  const [form, setForm] = useState({
    entityType: '',
    entityId: '',
    extractedJson: '',
    confidenceScore: 0,
    aiModel: ''
  });
  useEffect(() => {
    fetchData();
  }, []);
  const fetchData = async () => {
    try {
      const response = await aiApi.getExtractedData();
      setData(response);
    } catch (error) {
      toast({
        title: t("admin.ai.error"),
        description: t("admin.ai.failed_to_fetch_extracted"),
        variant: "destructive"
      });
    } finally {
      setLoading(false);
    }
  };
  const createItem = async () => {
    try {
      const response = await aiApi.createExtractedData({
        entityType: form.entityType,
        entityId: form.entityId,
        extractedJson: JSON.parse(form.extractedJson),
        confidenceScore: form.confidenceScore,
        aiModel: form.aiModel
      });
      setData([...data, response]);
      setIsCreateDialogOpen(false);
      resetForm();
      toast({
        title: t("admin.ai.success"),
        description: t("admin.ai.extracted_data_created_successfully")
      });
    } catch (error) {
      toast({
        title: t("admin.ai.error"),
        description: t("admin.ai.failed_to_create_extracted"),
        variant: "destructive"
      });
    }
  };
  const updateItem = async () => {
    if (!selectedItem) return;
    try {
      const response = await aiApi.updateExtractedData(selectedItem.id, {
        entityType: form.entityType,
        entityId: form.entityId,
        extractedJson: JSON.parse(form.extractedJson),
        confidenceScore: form.confidenceScore,
        aiModel: form.aiModel
      });
      setData(data.map(item => item.id === selectedItem.id ? response : item));
      setIsEditDialogOpen(false);
      setSelectedItem(null);
      resetForm();
      toast({
        title: t("admin.ai.success"),
        description: t("admin.ai.extracted_data_updated_successfully")
      });
    } catch (error) {
      toast({
        title: t("admin.ai.error"),
        description: t("admin.ai.failed_to_update_extracted"),
        variant: "destructive"
      });
    }
  };
  const deleteItem = async (id: string) => {
    try {
      await aiApi.deleteExtractedData(id);
      setData(data.filter(item => item.id !== id));
      toast({
        title: t("admin.ai.success"),
        description: t("admin.ai.extracted_data_deleted_successfully")
      });
    } catch (error) {
      toast({
        title: t("admin.ai.error"),
        description: t("admin.ai.failed_to_delete_extracted"),
        variant: "destructive"
      });
    }
  };
  const resetForm = () => {
    setForm({
      entityType: '',
      entityId: '',
      extractedJson: '',
      confidenceScore: 0,
      aiModel: ''
    });
  };
  const openEdit = (item: AiExtractedData) => {
    setSelectedItem(item);
    setForm({
      entityType: item.entityType,
      entityId: item.entityId,
      extractedJson: JSON.stringify(item.extractedJson, null, 2),
      confidenceScore: item.confidenceScore || 0,
      aiModel: item.aiModel || ''
    });
    setIsEditDialogOpen(true);
  };
  if (loading) {
    return <PageShell title={t("admin.ai.ai_extracted_data_management")}>
        <div className="flex items-center justify-center h-64">
          <Database className="h-8 w-8 animate-spin" />
        </div>
      </PageShell>;
  }
  return <PageShell title={t("admin.ai.ai_extracted_data_management")}>
      <div className="space-y-6">
        <div className="flex justify-between items-center">
          <div>
            <h1 className="text-3xl font-bold">{t("admin.ai.ai_extracted_data")}</h1>
            <p className="text-muted-foreground">{t("admin.ai.manage_aiextracted_data_from")}</p>
          </div>
          <Dialog open={isCreateDialogOpen} onOpenChange={setIsCreateDialogOpen}>
            <DialogTrigger asChild>
              <Button>
                <Plus className="h-4 w-4 mr-2" />{t("admin.ai.add_extracted_data")}</Button>
            </DialogTrigger>
            <DialogContent className="max-w-2xl">
              <DialogHeader>
                <DialogTitle>{t("admin.ai.add_new_extracted_data")}</DialogTitle>
                <DialogDescription>{t("admin.ai.create_a_new_ai")}</DialogDescription>
              </DialogHeader>
              <div className="grid gap-4 py-4">
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label htmlFor="entityType" className="text-right">{t("admin.ai.entity_type")}</Label>
                  <Input id="entityType" value={form.entityType} onChange={e => setForm({
                  ...form,
                  entityType: e.target.value
                })} className="col-span-3" placeholder={t("admin.ai.eg_property_document_image")} />
                </div>
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label htmlFor="entityId" className="text-right">{t("admin.ai.entity_id")}</Label>
                  <Input id="entityId" value={form.entityId} onChange={e => setForm({
                  ...form,
                  entityId: e.target.value
                })} className="col-span-3" />
                </div>
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label htmlFor="aiModel" className="text-right">{t("admin.ai.ai_model")}</Label>
                  <Input id="aiModel" value={form.aiModel} onChange={e => setForm({
                  ...form,
                  aiModel: e.target.value
                })} className="col-span-3" placeholder={t("admin.ai.eg_gpt4_bert")} />
                </div>
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label htmlFor="confidenceScore" className="text-right">{t("admin.ai.confidence")}</Label>
                  <Input id="confidenceScore" type="number" step="0.01" min="0" max="1" value={form.confidenceScore} onChange={e => setForm({
                  ...form,
                  confidenceScore: parseFloat(e.target.value)
                })} className="col-span-3" />
                </div>
                <div className="grid grid-cols-4 items-start gap-4">
                  <Label htmlFor="extractedJson" className="text-right pt-2">{t("admin.ai.extracted_json")}</Label>
                  <Textarea id="extractedJson" value={form.extractedJson} onChange={e => setForm({
                  ...form,
                  extractedJson: e.target.value
                })} className="col-span-3 min-h-32" placeholder={t("admin.ai.key_value")} />
                </div>
              </div>
              <DialogFooter>
                <Button onClick={createItem}>{t("admin.ai.create_data")}</Button>
              </DialogFooter>
            </DialogContent>
          </Dialog>
        </div>

        <Card>
          <CardHeader>
            <CardTitle>{t("admin.ai.extracted_data_entries")}</CardTitle>
          </CardHeader>
          <CardContent>
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>{t("admin.ai.entity_type")}</TableHead>
                  <TableHead>{t("admin.ai.entity_id")}</TableHead>
                  <TableHead>{t("admin.ai.ai_model")}</TableHead>
                  <TableHead>{t("admin.ai.confidence")}</TableHead>
                  <TableHead>{t("admin.ai.created")}</TableHead>
                  <TableHead className="text-right">{t("admin.ai.actions")}</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {data.map(item => <TableRow key={item.id}>
                    <TableCell className="font-medium">
                      <div className="flex items-center gap-2">
                        <FileText className="h-4 w-4" />
                        {item.entityType}
                      </div>
                    </TableCell>
                    <TableCell className="font-mono text-xs">{item.entityId}</TableCell>
                    <TableCell>
                      <Badge variant="outline">{item.aiModel || 'Unknown'}</Badge>
                    </TableCell>
                    <TableCell>
                      <div className="flex items-center gap-2">
                        <div className="w-16 bg-gray-200 rounded-full h-2">
                          <div className="bg-blue-500 h-2 rounded-full" style={{
                        width: `${(item.confidenceScore || 0) * 100}%`
                      }} />
                        </div>
                        <span className="text-sm">{((item.confidenceScore || 0) * 100).toFixed(1)}%</span>
                      </div>
                    </TableCell>
                    <TableCell>
                      {new Date(item.createdAt).toLocaleDateString()}
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
                          <DropdownMenuItem onClick={() => openEdit(item)}>
                            <Edit className="h-4 w-4 mr-2" />{t("admin.ai.edit")}</DropdownMenuItem>
                          <DropdownMenuSeparator />
                          <DropdownMenuItem onClick={() => deleteItem(item.id)} className="text-red-600">
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
              <DialogTitle>{t("admin.ai.edit_extracted_data")}</DialogTitle>
              <DialogDescription>{t("admin.ai.update_the_extracted_data")}</DialogDescription>
            </DialogHeader>
            <div className="grid gap-4 py-4">
              <div className="grid grid-cols-4 items-center gap-4">
                <Label htmlFor="edit-entityType" className="text-right">{t("admin.ai.entity_type")}</Label>
                <Input id="edit-entityType" value={form.entityType} onChange={e => setForm({
                ...form,
                entityType: e.target.value
              })} className="col-span-3" />
              </div>
              <div className="grid grid-cols-4 items-center gap-4">
                <Label htmlFor="edit-entityId" className="text-right">{t("admin.ai.entity_id")}</Label>
                <Input id="edit-entityId" value={form.entityId} onChange={e => setForm({
                ...form,
                entityId: e.target.value
              })} className="col-span-3" />
              </div>
              <div className="grid grid-cols-4 items-center gap-4">
                <Label htmlFor="edit-aiModel" className="text-right">{t("admin.ai.ai_model")}</Label>
                <Input id="edit-aiModel" value={form.aiModel} onChange={e => setForm({
                ...form,
                aiModel: e.target.value
              })} className="col-span-3" />
              </div>
              <div className="grid grid-cols-4 items-center gap-4">
                <Label htmlFor="edit-confidenceScore" className="text-right">{t("admin.ai.confidence")}</Label>
                <Input id="edit-confidenceScore" type="number" step="0.01" min="0" max="1" value={form.confidenceScore} onChange={e => setForm({
                ...form,
                confidenceScore: parseFloat(e.target.value)
              })} className="col-span-3" />
              </div>
              <div className="grid grid-cols-4 items-start gap-4">
                <Label htmlFor="edit-extractedJson" className="text-right pt-2">{t("admin.ai.extracted_json")}</Label>
                <Textarea id="edit-extractedJson" value={form.extractedJson} onChange={e => setForm({
                ...form,
                extractedJson: e.target.value
              })} className="col-span-3 min-h-32" />
              </div>
            </div>
            <DialogFooter>
              <Button onClick={updateItem}>{t("admin.ai.update_data")}</Button>
            </DialogFooter>
          </DialogContent>
        </Dialog>
      </div>
    </PageShell>;
}