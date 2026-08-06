"use client";

import { useTranslation } from "react-i18next";
import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { useToast } from "@/hooks/use-toast";
import { PieChart, Users, DollarSign, Percent, Plus, Trash2, Save } from "lucide-react";

interface SplitRule {
  id: string;
  role: string;
  agentId: string;
  percentage: number;
}

export default function CommissionSplit() {
  const { t } = useTranslation();
  const { toast } = useToast();

  const [totalCommission, setTotalCommission] = useState(10000);
  const [splits, setSplits] = useState<SplitRule[]>([
    { id: "1", role: "LISTING_AGENT", agentId: "agent-1", percentage: 40 },
    { id: "2", role: "BUYER_AGENT", agentId: "agent-2", percentage: 40 },
    { id: "3", role: "BROKERAGE", agentId: "org-1", percentage: 20 },
  ]);

  const handleAddSplit = () => {
    const newSplit: SplitRule = {
      id: Date.now().toString(),
      role: "REFERRAL",
      agentId: "",
      percentage: 0,
    };
    setSplits([...splits, newSplit]);
  };

  const handleRemoveSplit = (id: string) => {
    setSplits(splits.filter(s => s.id !== id));
  };

  const handleUpdateSplit = (id: string, field: keyof SplitRule, value: any) => {
    setSplits(splits.map(s => s.id === id ? { ...s, [field]: value } : s));
  };

  const handleSave = () => {
    const totalPercentage = splits.reduce((acc, curr) => acc + curr.percentage, 0);
    if (totalPercentage !== 100) {
      toast({
        title: t("common.error", "Error"),
        description: t("client.src.split_must_equal_100", "Total split percentage must equal exactly 100%"),
        variant: "destructive"
      });
      return;
    }

    toast({
      title: t("client.src.success", "Success"),
      description: t("client.src.commission_split_saved", "Commission split rules saved successfully"),
    });
  };

  const totalPercentage = splits.reduce((acc, curr) => acc + curr.percentage, 0);

  return (
    <div className="p-8 space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold text-gray-900">{t("client.src.commission_split", "Commission Split")}</h1>
          <p className="text-gray-600 mt-1">{t("client.src.manage_commission_splits", "Manage co-brokerage and commission splits")}</p>
        </div>
      </div>
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
        <Card className="md:col-span-2">
          <CardHeader>
            <CardTitle>{t("client.src.split_configuration", "Split Configuration")}</CardTitle>
            <CardDescription>{t("client.src.configure_how_commission_is_divided", "Configure how the total commission is divided among agents and partners")}</CardDescription>
          </CardHeader>
          <CardContent className="space-y-6">
            <div className="flex items-center justify-between border-b pb-4">
              <div>
                <Label className="text-muted-foreground">{t("client.src.total_commission_amount", "Total Commission Amount")}</Label>
                <div className="text-2xl font-bold flex items-center mt-1">
                  <DollarSign className="w-5 h-5 text-muted-foreground mr-1" />
                  <Input 
                    type="number" 
                    value={totalCommission} 
                    onChange={e => setTotalCommission(Number(e.target.value))}
                    className="w-40 text-xl font-bold border-none bg-transparent focus-visible:ring-0 p-0 h-auto"
                  />
                </div>
              </div>
              <div className="text-right">
                <Label className="text-muted-foreground">{t("client.src.total_allocated", "Total Allocated")}</Label>
                <div className={`text-2xl font-bold mt-1 ${totalPercentage === 100 ? 'text-green-600' : 'text-red-600'}`}>
                  {totalPercentage}%
                </div>
              </div>
            </div>

            <div className="space-y-4">
              {splits.map((split, index) => (
                <div key={split.id} className="flex items-center gap-4 p-4 bg-muted/50 rounded-lg border">
                  <div className="flex-1">
                    <Label className="text-xs mb-1 block">{t("client.src.role", "Role")}</Label>
                    <Select value={split.role} onValueChange={(val) => handleUpdateSplit(split.id, 'role', val)}>
                      <SelectTrigger className="bg-background">
                        <SelectValue />
                      </SelectTrigger>
                      <SelectContent>
                        <SelectItem value="LISTING_AGENT">{t("client.src.listing_agent", "Listing Agent")}</SelectItem>
                        <SelectItem value="BUYER_AGENT">{t("client.src.buyer_agent", "Buyer Agent")}</SelectItem>
                        <SelectItem value="REFERRAL">{t("client.src.referral_partner", "Referral Partner")}</SelectItem>
                        <SelectItem value="BROKERAGE">{t("client.src.brokerage", "Brokerage")}</SelectItem>
                      </SelectContent>
                    </Select>
                  </div>
                  <div className="flex-1">
                    <Label className="text-xs mb-1 block">{t("client.src.agent_partner", "Agent / Partner")}</Label>
                    <Input 
                      placeholder="Agent ID or Name" 
                      value={split.agentId} 
                      onChange={(e) => handleUpdateSplit(split.id, 'agentId', e.target.value)}
                      className="bg-background"
                    />
                  </div>
                  <div className="w-32">
                    <Label className="text-xs mb-1 block">{t("client.src.percentage", "Percentage (%)")}</Label>
                    <div className="relative">
                      <Input 
                        type="number" 
                        value={split.percentage} 
                        onChange={(e) => handleUpdateSplit(split.id, 'percentage', Number(e.target.value))}
                        className="bg-background pr-8"
                      />
                      <Percent className="w-4 h-4 absolute right-3 top-3 text-muted-foreground" />
                    </div>
                  </div>
                  <div className="w-32">
                    <Label className="text-xs mb-1 block">{t("client.src.amount", "Amount")}</Label>
                    <div className="h-10 flex items-center font-medium text-lg">
                      ${((totalCommission * split.percentage) / 100).toLocaleString()}
                    </div>
                  </div>
                  <div className="pt-5">
                    <Button variant="ghost" size="icon" className="text-red-500 hover:text-red-700 hover:bg-red-50" onClick={() => handleRemoveSplit(split.id)}>
                      <Trash2 className="w-4 h-4" />
                    </Button>
                  </div>
                </div>
              ))}
            </div>

            <Button variant="outline" className="w-full border-dashed" onClick={handleAddSplit}>
              <Plus className="w-4 h-4 mr-2" />
              {t("client.src.add_split", "Add Split")}
            </Button>

            <div className="flex justify-end pt-4">
              <Button onClick={handleSave} className="bg-primary hover:bg-primary/90">
                <Save className="w-4 h-4 mr-2" />
                {t("common.save_changes", "Save Changes")}
              </Button>
            </div>
          </CardContent>
        </Card>

        <Card className="h-fit">
          <CardHeader>
            <CardTitle>{t("client.src.split_summary", "Summary")}</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {splits.map((split, i) => (
                <div key={`summary-${split.id}`} className="flex justify-between items-center border-b pb-2 last:border-0 last:pb-0">
                  <div className="flex items-center">
                    <div className={`w-3 h-3 rounded-full mr-2 bg-chart-${(i % 5) + 1}`} />
                    <span className="text-sm font-medium">{split.role.replace('_', ' ')}</span>
                  </div>
                  <div className="text-right">
                    <div className="text-sm font-bold">${((totalCommission * split.percentage) / 100).toLocaleString()}</div>
                    <div className="text-xs text-muted-foreground">{split.percentage}%</div>
                  </div>
                </div>
              ))}
              
              <div className="mt-6 pt-4 border-t">
                <div className="flex justify-between items-center text-sm mb-2">
                  <span className="text-muted-foreground">{t("client.src.status", "Status")}</span>
                  {totalPercentage === 100 ? (
                    <Badge variant="outline" className="bg-green-50 text-green-700 border-green-200">Balanced</Badge>
                  ) : (
                    <Badge variant="outline" className="bg-red-50 text-red-700 border-red-200">Unbalanced ({totalPercentage}%)</Badge>
                  )}
                </div>
              </div>
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  );
}
