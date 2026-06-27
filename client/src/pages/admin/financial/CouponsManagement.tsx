import { t } from "i18next";
import { useState } from "react";
import { PageShell } from "../../client/layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Tag, Plus, Search, CheckCircle, Clock, Globe } from "lucide-react";
import { useTranslation } from "react-i18next";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter } from "@/components/ui/dialog";

// Simulated B2B Coupons Data
const mockCoupons = [
  { id: "1", code: "SUMMER2026", discount: 10, type: "PERCENTAGE", expiresAt: "2026-08-31", region: "GLOBAL", status: "ACTIVE", usageCount: 145 },
  { id: "2", code: "TR-WELCOME", discount: 500, type: "FIXED", expiresAt: "2026-12-31", region: "TR", status: "ACTIVE", usageCount: 89 },
  { id: "3", code: "US-PROMO", discount: 50, type: "FIXED", expiresAt: "2026-05-01", region: "US", status: "EXPIRED", usageCount: 300 },
];

export default function CouponsManagement() {
  const { t } = useTranslation();
  const [searchTerm, setSearchTerm] = useState("");
  const [createOpen, setCreateOpen] = useState(false);

  const filteredCoupons = mockCoupons.filter(c => 
    c.code.toLowerCase().includes(searchTerm.toLowerCase())
  );

  return (
    <PageShell 
      title={t("admin.financial.coupons_management", "Coupons & Promotions")}
      description={t("admin.financial.coupons_desc", "Manage global and regional promotional codes for users.")}
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
                <p className="text-sm font-medium text-muted-foreground">{t("admin.financial.active_campaigns", "Active Campaigns")}</p>
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
                <p className="text-sm font-medium text-muted-foreground">{t("admin.financial.total_usages", "Total Usages")}</p>
                <h3 className="text-3xl font-bold">534</h3>
              </div>
            </CardContent>
          </Card>
          <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-sm">
            <CardContent className="p-6 flex items-center gap-4">
              <div className="p-4 bg-blue-500/10 text-blue-500 rounded-2xl">
                <Globe className="w-8 h-8" />
              </div>
              <div>
                <p className="text-sm font-medium text-muted-foreground">{t("admin.financial.regions_targeted", "Regions Targeted")}</p>
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
                placeholder={t("admin.financial.search_coupons", "Search coupons...")} 
                value={searchTerm} 
                onChange={e => setSearchTerm(e.target.value)} 
                className="bg-card border-border rounded-2xl pl-12 h-14 shadow-sm" 
              />
            </div>
            <Button onClick={() => setCreateOpen(true)} className="h-14 px-8 rounded-2xl font-bold gap-2">
              <Plus className="w-4 h-4" />{t("admin.financial.create_coupon", "Create Coupon")}</Button>
          </div>

          <Card className="rounded-3xl shadow-sm border-border">
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>{t("admin.financial.code", "Code")}</TableHead>
                  <TableHead>{t("admin.financial.type", "Type")}</TableHead>
                  <TableHead>{t("admin.financial.value", "Value")}</TableHead>
                  <TableHead>{t("admin.financial.region", "Region")}</TableHead>
                  <TableHead>{t("admin.financial.status", "Status")}</TableHead>
                  <TableHead>{t("admin.financial.usages", "Usages")}</TableHead>
                  <TableHead>{t("admin.financial.expires", "Expires")}</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {filteredCoupons.map(coupon => (
                  <TableRow key={coupon.id}>
                    <TableCell className="font-bold font-mono text-primary">{coupon.code}</TableCell>
                    <TableCell><Badge variant="outline">{coupon.type}</Badge></TableCell>
                    <TableCell className="font-semibold">
                      {coupon.type === "PERCENTAGE" ? `${coupon.discount}%` : `$${coupon.discount}`}
                    </TableCell>
                    <TableCell>
                      <Badge className={coupon.region === "GLOBAL" ? "bg-blue-500" : "bg-orange-500"}>
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
            <DialogTitle>{t("admin.financial.create_new_coupon", "Create New Coupon")}</DialogTitle>
          </DialogHeader>
          <div className="space-y-4 py-4">
            <div className="space-y-2">
              <label className="text-sm font-medium">{t("admin.financial.coupon_code", "Coupon Code")}</label>
              <Input placeholder="e.g. SUMMER2026" />
            </div>
            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-2">
                <label className="text-sm font-medium">{t("admin.financial.discount_value", "Discount Value")}</label>
                <Input type="number" placeholder="10" />
              </div>
              <div className="space-y-2">
                <label className="text-sm font-medium">{t("admin.financial.discount_type", "Discount Type")}</label>
                <Select defaultValue="PERCENTAGE">
                  <SelectTrigger><SelectValue /></SelectTrigger>
                  <SelectContent>
                    <SelectItem value="PERCENTAGE">{t("admin.financial.percentage", "Percentage")}</SelectItem>
                    <SelectItem value="FIXED">{t("admin.financial.fixed_amount", "Fixed Amount")}</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </div>
            <div className="space-y-2">
              <label className="text-sm font-medium">{t("admin.financial.target_region", "Target Region")}</label>
              <Select defaultValue="GLOBAL">
                <SelectTrigger><SelectValue /></SelectTrigger>
                <SelectContent>
                  <SelectItem value="GLOBAL">{t("admin.financial.global_regions", "Global (All Regions)")}</SelectItem>
                  <SelectItem value="US">{t("admin.financial.us_region", "United States (US)")}</SelectItem>
                  <SelectItem value="TR">{t("admin.financial.tr_region", "Turkey (TR)")}</SelectItem>
                  <SelectItem value="UK">{t("admin.financial.uk_region", "United Kingdom (UK)")}</SelectItem>
                </SelectContent>
              </Select>
            </div>
          </div>
          <DialogFooter>
            <Button variant="outline" onClick={() => setCreateOpen(false)}>{t("admin.financial.cancel", "Cancel")}</Button>
            <Button onClick={() => setCreateOpen(false)}>{t("admin.financial.create_campaign", "Create Campaign")}</Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </PageShell>
  );
}
