"use client";

import { t } from"i18next";
import { useState } from"react";
import { PageShell } from"../../client/layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { Badge } from"@/components/ui/badge";
import { Button } from"@/components/ui/button";
import { Input } from"@/components/ui/input";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from"@/components/ui/select";
import { Tag, Plus, Search, CheckCircle, Clock, Globe } from"lucide-react";
import { useTranslation } from"react-i18next";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter } from"@/components/ui/dialog";

// Simulated B2B Coupons Data
const mockCoupons = [
 { id:"1", code:"SUMMER2026", discount: 10, type:"PERCENTAGE", expiresAt:"2026-08-31", region:"GLOBAL", status:"ACTIVE", usageCount: 145 },
 { id:"2", code:"TR-WELCOME", discount: 500, type:"FIXED", expiresAt:"2026-12-31", region:"TR", status:"ACTIVE", usageCount: 89 },
 { id:"3", code:"US-PROMO", discount: 50, type:"FIXED", expiresAt:"2026-05-01", region:"US", status:"EXPIRED", usageCount: 300 },
];

export default function CouponsManagement() {
 const { toast } = useToast();
 const queryClient = useQueryClient();
 
 
 
 const { t } = useTranslation();
 const [searchTerm, setSearchTerm] = useState("");
 const [createOpen, setCreateOpen] = useState(false);
 const [isEditOpen, setIsEditOpen] = useState(false);
 const [editingCoupon, setEditingCoupon] = useState<any>(null);
 
 // Form State matches Discount Model
 const [formData, setFormData] = useState({
 name: '',
 code: '',
 value: 0,
 type: 'PERCENTAGE', // or FIXED
 maxUsage: 100,
 propertyId: '', // Ideally linked to a property
 });

 const createMutation = useMutation({
 mutationFn: async (data: any) => apiClient.post('/discount', data),
 onSuccess: () => {
 toast({ title:"Success", description:"Discount created successfully" });
 queryClient.invalidateQueries({ queryKey: ['admin-discounts'] });
 setCreateOpen(false);
 }
 });

 const updateMutation = useMutation({
 mutationFn: async (data: any) => apiClient.put(`/discount/${data.id}`, data),
 onSuccess: () => {
 toast({ title:"Updated", description:"Discount updated successfully" });
 queryClient.invalidateQueries({ queryKey: ['admin-discounts'] });
 setIsEditOpen(false);
 setEditingCoupon(null);
 }
 });

 const deleteMutation = useMutation({
 mutationFn: async (id: string) => apiClient.delete(`/discount/${id}`),
 onSuccess: () => {
 toast({ title:"Deleted", description:"Discount deleted successfully" });
 queryClient.invalidateQueries({ queryKey: ['admin-discounts'] });
 }
 });

 const handleEdit = (coupon: any) => {
 setEditingCoupon(coupon);
 setFormData({
 name: coupon.name || '',
 code: coupon.code || '',
 value: coupon.value || 0,
 type: coupon.type || 'PERCENTAGE',
 maxUsage: coupon.maxUsage || 100,
 propertyId: coupon.propertyId || ''
 });
 setIsEditOpen(true);
 };


 const filteredCoupons = mockCoupons.filter(c => 
 c.code.toLowerCase().includes(searchTerm.toLowerCase())
 );

 return (
 <PageShell 
 title={t("admin_financial_coupons_management","Coupons & Promotions")}
 description={t("admin_financial_coupons_desc","Manage global and regional promotional codes for users.")}
 >
 <div className="space-y-8 pb-20">
 
 {/* Stats Grid */}
 <div className="grid grid-cols-1 md:grid-cols-3 gap-6 px-4">
 <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-sm">
 <CardContent className="p-6 flex items-center gap-4">
 <div className="p-4 bg-primary/10 text-primary rounded-2xl">
 <Tag className="w-8 h-8" />
 </div>
 <div>
 <p className="text-sm font-medium text-muted-foreground">{t("admin_financial_active_campaigns","Active Campaigns")}</p>
 <h3 className="text-3xl font-bold">2</h3>
 </div>
 </CardContent>
 </Card>
 <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-sm">
 <CardContent className="p-6 flex items-center gap-4">
 <div className="p-4 bg-green-500/10 text-green-500 rounded-2xl">
 <CheckCircle className="w-8 h-8" />
 </div>
 <div>
 <p className="text-sm font-medium text-muted-foreground">{t("admin_financial_total_usages","Total Usages")}</p>
 <h3 className="text-3xl font-bold">534</h3>
 </div>
 </CardContent>
 </Card>
 <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-sm">
 <CardContent className="p-6 flex items-center gap-4">
 <div className="p-4 bg-muted0/10 text-slate-500 rounded-2xl">
 <Globe className="w-8 h-8" />
 </div>
 <div>
 <p className="text-sm font-medium text-muted-foreground">{t("admin_financial_regions_targeted","Regions Targeted")}</p>
 <h3 className="text-3xl font-bold">3</h3>
 </div>
 </CardContent>
 </Card>
 </div>

 {/* List Section */}
 <div className="px-4">
 <div className="flex flex-col lg:flex-row items-center justify-between gap-6 mb-6">
 <div className="relative group w-full lg:w-96">
 <Search className="absolute left-4 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
 <Input 
 placeholder={t("admin_financial_search_coupons","Search coupons...")} 
 value={searchTerm} 
 onChange={e => setSearchTerm(e.target.value)} 
 className="bg-card border-border rounded-2xl pl-12 h-14 shadow-sm" 
 />
 </div>
 <Button onClick={() => setCreateOpen(true)} className="h-14 px-8 rounded-2xl font-bold gap-2">
 <Plus className="w-4 h-4" />{t("admin_financial_create_coupon","Create Coupon")}</Button>
 </div>

 <Card className="rounded-3xl shadow-sm border-border">
 <Table>
 <TableHeader>
 <TableRow>
 <TableHead>{t("admin_financial_code","Code")}</TableHead>
 <TableHead>{t("admin_financial_type","Type")}</TableHead>
 <TableHead>{t("admin_financial_value","Value")}</TableHead>
 <TableHead>{t("admin_financial_region","Region")}</TableHead>
 <TableHead>{t("admin_financial_status","Status")}</TableHead>
 <TableHead>{t("admin_financial_usages","Usages")}</TableHead>
 <TableHead>{t("admin_financial_expires","Expires")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {filteredCoupons.map(coupon => (
 <TableRow key={coupon.id}>
 <TableCell className="font-bold font-mono text-primary">{coupon.code}</TableCell>
 <TableCell><Badge variant="outline">{coupon.type}</Badge></TableCell>
 <TableCell className="font-semibold">
 {coupon.type ==="PERCENTAGE" ? `${coupon.discount}%` : `$${coupon.discount}`}
 </TableCell>
 <TableCell>
 <Badge className={coupon.region ==="GLOBAL" ?"bg-muted0" :"bg-orange-500"}>
 {coupon.region}
 </Badge>
 </TableCell>
 <TableCell>
 <div className="flex items-center gap-2">
 <div className={`w-2 h-2 rounded-full ${coupon.status === 'ACTIVE' ? 'bg-green-500' : 'bg-red-500'}`} />
 <span className="text-xs font-semibold">{coupon.status}</span>
 </div>
 </TableCell>
 <TableCell>{coupon.usageCount}</TableCell>
 <TableCell className="text-muted-foreground text-sm">{coupon.expiresAt}</TableCell>
 </TableRow>
 ))}
 </TableBody>
 </Table>
 </Card>
 </div>
 </div>

 <Dialog open={createOpen} onOpenChange={setCreateOpen}>
 <DialogContent className="sm:max-w-md">
 <DialogHeader>
 <DialogTitle>{t("admin_financial_create_new_coupon","Create New Coupon")}</DialogTitle>
 </DialogHeader>
 <div className="space-y-4 py-4">
 <div className="space-y-2">
 <label className="text-sm font-medium">{t("admin_financial_coupon_code","Coupon Code")}</label>
 <Input placeholder="e.g. SUMMER2026" />
 </div>
 <div className="grid grid-cols-2 gap-4">
 <div className="space-y-2">
 <label className="text-sm font-medium">{t("admin_financial_discount_value","Discount Value")}</label>
 <Input type="number" placeholder="10" />
 </div>
 <div className="space-y-2">
 <label className="text-sm font-medium">{t("admin_financial_discount_type","Discount Type")}</label>
 <Select defaultValue="PERCENTAGE">
 <SelectTrigger><SelectValue /></SelectTrigger>
 <SelectContent>
 <SelectItem value="PERCENTAGE">{t("admin_financial_percentage","Percentage")}</SelectItem>
 <SelectItem value="FIXED">{t("admin_financial_fixed_amount","Fixed Amount")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 </div>
 <div className="space-y-2">
 <label className="text-sm font-medium">{t("admin_financial_target_region","Target Region")}</label>
 <Select defaultValue="GLOBAL">
 <SelectTrigger><SelectValue /></SelectTrigger>
 <SelectContent>
 <SelectItem value="GLOBAL">{t("admin_financial_global_regions","Global (All Regions)")}</SelectItem>
 <SelectItem value="US">{t("admin_financial_us_region","United States (US)")}</SelectItem>
 <SelectItem value="TR">{t("admin_financial_tr_region","Turkey (TR)")}</SelectItem>
 <SelectItem value="UK">{t("admin_financial_uk_region","United Kingdom (UK)")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 </div>
 <DialogFooter>
 <Button variant="outline" onClick={() => setCreateOpen(false)}>{t("admin_financial_cancel","Cancel")}</Button>
 <Button onClick={() => setCreateOpen(false)}>{t("admin_financial_create_campaign","Create Campaign")}</Button>
 </DialogFooter>
 </DialogContent>
 </Dialog>
 
 <Dialog open={isEditOpen} onOpenChange={setIsEditOpen}>
 <DialogContent className="sm:max-w-[425px]">
 <DialogHeader>
 <DialogTitle>{t("admin_financial_edit_coupon","Edit Discount/Coupon")}</DialogTitle>
 </DialogHeader>
 <div className="grid gap-4 py-4">
 <div className="grid gap-2">
 <Label htmlFor="edit-name">{t("admin_auto_name", "Name")}</Label>
 <Input id="edit-name" value={formData.name} onChange={e => setFormData({...formData, name: e.target.value})} />
 </div>
 <div className="grid gap-2">
 <Label htmlFor="edit-code">{t("admin_auto_code", "Code")}</Label>
 <Input id="edit-code" value={formData.code} onChange={e => setFormData({...formData, code: e.target.value})} />
 </div>
 <div className="grid grid-cols-2 gap-4">
 <div className="grid gap-2">
 <Label htmlFor="edit-value">{t("admin_auto_value", "Value")}</Label>
 <Input id="edit-value" type="number" value={formData.value} onChange={e => setFormData({...formData, value: parseFloat(e.target.value)})} />
 </div>
 <div className="grid gap-2">
 <Label htmlFor="edit-type">{t("admin_auto_type", "Type")}</Label>
 <Select value={formData.type} onValueChange={v => setFormData({...formData, type: v})}>
 <SelectTrigger><SelectValue /></SelectTrigger>
 <SelectContent>
 <SelectItem value="PERCENTAGE">Percentage</SelectItem>
 <SelectItem value="FIXED">Fixed Amount</SelectItem>
 </SelectContent>
 </Select>
 </div>
 </div>
 </div>
 <DialogFooter>
 <Button variant="outline" onClick={() => setIsEditOpen(false)}>{t("common.cancel","Cancel")}</Button>
 <Button onClick={() => updateMutation.mutate({...formData, id: editingCoupon?.id})} disabled={updateMutation.isPending}>{t("common.save","Save Changes")}</Button>
 </DialogFooter>
 </DialogContent>
 </Dialog>

 </PageShell>
 );
}
