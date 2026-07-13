"use client";

import { useState } from"react";
import { useParams } from"@/lib/react-router-shim";
import { useQuery, useMutation, useQueryClient } from"@tanstack/react-query";
import { apiClient } from"@/lib/api/client";
import { Button } from"@/components/ui/button";
import { Input } from"@/components/ui/input";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { Loader2, Plus, Trash, RefreshCw } from"lucide-react";
import { useToast } from"@/hooks/use-toast";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger, DialogFooter, DialogDescription } from"@/components/ui/dialog";
import { Label } from"@/components/ui/label";

export default function DynamicAdminPage() {
 const { toast } = useToast();
 const { model } = useParams();
 const queryClient = useQueryClient();
 const [isAddOpen, setIsAddOpen] = useState(false);
 const [formData, setFormData] = useState({ name:"", type:"" });
 const [page, setPage] = useState(1);
 const limit = 50;

 const createMutation = useMutation({
 mutationFn: async (data: any) => {
 const res = await apiClient.post('/dynamic', data);
 return res;
 },
 onSuccess: () => {
 setIsAddOpen(false);
 queryClient.invalidateQueries({ queryKey: ["admin_dynamic_data", model] });
 toast({ title:"Success", description:"Dynamic Record created successfully" });
 },
 onError: (err: any) => {
 toast({ title:"Error", description: err.message, variant:"destructive" });
 }
 });

 const { data: schema, isLoading: schemaLoading } = useQuery({
 queryKey: ["admin_dynamic_schema", model],
 queryFn: async () => {
 const res = await apiClient.get(`/admin/dynamic/schema/${model}`) as any;
 if (res.error) throw new Error(res.error);
 return res.data;
 },
 enabled: !!model
 });

 const { data: records, isLoading: dataLoading, refetch } = useQuery({
 queryKey: ["admin_dynamic_data", model, page],
 queryFn: async () => {
 const res = await apiClient.get(`/admin/dynamic/data/${model}?page=${page}&limit=${limit}`) as any;
 if (res.error) throw new Error(res.error);
 return res;
 },
 enabled: !!model && !!schema
 });

 const deleteMutation = useMutation({
 mutationFn: async (id: number | string) => {
 const res = await apiClient.delete(`/admin/dynamic/data/${model}/${id}`) as any;
 if (res.error) throw new Error(res.error);
 return res;
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ["admin_dynamic_data", model] });
 toast({ title:"Record deleted" });
 },
 onError: (err: any) => {
 toast({ title:"Error deleting", description: err.message, variant:"destructive" });
 }
 });

 if (schemaLoading) return <div className="p-8 flex justify-center"><Loader2 className="animate-spin w-8 h-8 text-slate-500" /></div>;
 if (!schema) return <div className="p-8 text-red-500">Model schema not found.</div>;

 const displayFields = schema.fields.filter((f: any) =>
 f.type === 'String' || f.type === 'Int' || f.type === 'Boolean' || f.type === 'DateTime'
 ).slice(0, 7);

 return (
 <div className="space-y-6">
 <div className="bg-card p-6 rounded-2xl border border-border">
 <div className="flex justify-between items-center">
 <div>
 <h1 className="text-2xl font-bold text-foreground">{schema.name} Management</h1>
 <p className="text-muted-foreground">Dynamically generated interface for {schema.name}</p>
 </div>
 <div className="flex space-x-2">
 <Button variant="outline" onClick={() => refetch()}><RefreshCw className="w-4 h-4 mr-2" />Refresh</Button>
 <Dialog open={isAddOpen} onOpenChange={setIsAddOpen}>
 <DialogTrigger asChild>
 <Button>
 <Plus className="w-4 h-4 mr-2" />Add {schema.name}
 </Button>
 </DialogTrigger>
 <DialogContent className="sm:max-w-[425px] bg-card border-border text-foreground">
 <DialogHeader>
 <DialogTitle>{t("admin_auto_create_new_dynamic_record", "Create New Dynamic Record")}</DialogTitle>
 <DialogDescription className="text-muted-foreground">{t("admin_auto_enter_the_details_for_the_new_dynamic_re", "Enter the details for the new dynamic record.")}</DialogDescription>
 </DialogHeader>
 <div className="grid gap-4 py-4">
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="name" className="text-right text-xs text-muted-foreground">{t("admin_auto_name", "Name")}</Label>
 <Input
 id="name"
 className="col-span-3 h-10 bg-card border-border text-foreground"
 value={formData.name}
 onChange={e => setFormData({ ...formData, name: e.target.value })}
 placeholder="Enter name"
 />
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="type" className="text-right text-xs text-muted-foreground">{t("admin_auto_type", "Type")}</Label>
 <Input
 id="type"
 className="col-span-3 h-10 bg-card border-border text-foreground"
 value={formData.type}
 onChange={e => setFormData({ ...formData, type: e.target.value })}
 placeholder="Enter type"
 />
 </div>
 </div>
 <DialogFooter>
 <Button variant="outline" onClick={() => setIsAddOpen(false)}>Cancel</Button>
 <Button onClick={() => createMutation.mutate(formData)} disabled={createMutation.isPending}>
 {createMutation.isPending ?"Saving..." :"Save Changes"}
 </Button>
 </DialogFooter>
 </DialogContent>
 </Dialog>
 </div>
 </div>
 </div>

 <div className="bg-card border border-border rounded-lg overflow-hidden">
 <Table>
 <TableHeader>
 <TableRow className="border-border hover:bg-card">
 {displayFields.map((f: any) => (
 <TableHead key={f.name} className="text-muted-foreground">{f.name}</TableHead>
 ))}
 <TableHead className="text-right text-muted-foreground">Actions</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {dataLoading ? (
 <TableRow><TableCell colSpan={displayFields.length + 1} className="text-center py-8"><Loader2 className="animate-spin w-6 h-6 mx-auto text-slate-500" /></TableCell></TableRow>
 ) : (records as any)?.data?.length === 0 ? (
 <TableRow><TableCell colSpan={displayFields.length + 1} className="text-center py-8 text-slate-500">No records found</TableCell></TableRow>
 ) : (
 (records as any)?.data?.map((row: any, i: number) => (
 <TableRow key={row.id || i} className="border-border hover:bg-card">
 {displayFields.map((f: any) => (
 <TableCell key={f.name} className="text-muted-foreground">
 {row[f.name] !== null ? String(row[f.name]) : <span className="text-slate-600">null</span>}
 </TableCell>
 ))}
 <TableCell className="text-right">
 <Button variant="ghost" size="sm" className="text-red-400 hover:text-red-300 hover:bg-red-900/20"
 onClick={() => { if (window.confirm('Are you sure?')) deleteMutation.mutate(row.id); }}>
 <Trash className="w-4 h-4" />
 </Button>
 </TableCell>
 </TableRow>
 ))
 )}
 </TableBody>
 </Table>
 </div>
 </div>
 );
}
