"use client";

import { useState, useCallback } from "react";
import {
  GitCompareArrows,
  Plus,
  Trash2,
  Star,
  TrendingUp,
  MapPin,
  Building2,
  ArrowUpDown,
} from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Badge } from "@/components/ui/badge";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog";
import { useInvestmentIntelligenceStore } from "@/lib/investment-intelligence-store";
import { formatCurrency } from "@/lib/seo/market-data";
import type { PropertyComparisonItem } from "@/types/investment-intelligence";
import { useTranslation } from "react-i18next";

export function PropertyComparisonEngine() {
  const { t } = useTranslation();
  const { comparisonItems, addToComparison, removeFromComparison, clearComparison } =
    useInvestmentIntelligenceStore();
  const [showAddDialog, setShowAddDialog] = useState(false);
  const [sortBy, setSortBy] = useState<keyof PropertyComparisonItem>("overallScore");
  const [sortDir, setSortDir] = useState<"asc" | "desc">("desc");
  const [newProp, setNewProp] = useState({
    name: "",
    city: "Dubai",
    district: "",
    purchasePrice: 1500000,
    monthlyRent: 9500,
    locationScore: 70,
    liquidityScore: 70,
    appreciationPotential: 60,
  });

  const handleAdd = useCallback(() => {
    if (!newProp.name) return;
    addToComparison(newProp);
    setShowAddDialog(false);
    setNewProp({
      name: "",
      city: "Dubai",
      district: "",
      purchasePrice: 1500000,
      monthlyRent: 9500,
      locationScore: 70,
      liquidityScore: 70,
      appreciationPotential: 60,
    });
  }, [newProp, addToComparison]);

  const sorted = [...comparisonItems].sort((a, b) => {
    const aVal = a[sortBy] as number;
    const bVal = b[sortBy] as number;
    return sortDir === "desc" ? bVal - aVal : aVal - bVal;
  });

  const handleSort = (field: keyof PropertyComparisonItem) => {
    if (sortBy === field) {
      setSortDir((d) => (d === "desc" ? "asc" : "desc"));
    } else {
      setSortBy(field);
      setSortDir("desc");
    }
  };

  const SortHeader = ({ field, label }: { field: keyof PropertyComparisonItem; label: string }) => (
    <th
      className="text-right py-2 px-2 cursor-pointer hover:text-foreground select-none"
      onClick={() => handleSort(field)}
    >
      <span className="inline-flex items-center gap-1">
        {label}
        {sortBy === field && (
          <ArrowUpDown className="w-3 h-3" />
        )}
      </span>
    </th>
  );

  return (
    <div className="max-w-6xl mx-auto px-4 py-8">
      <div className="flex items-center justify-between mb-6">
        <div>
          <h2 className="text-2xl font-bold flex items-center gap-2">
            <GitCompareArrows className="w-6 h-6" />
            Property Comparison
          </h2>
          <p className="text-muted-foreground">
            Compare properties side by side across yield, ROI, location, and liquidity
          </p>
        </div>
        <div className="flex gap-2">
          <Dialog open={showAddDialog} onOpenChange={setShowAddDialog}>
            <DialogTrigger asChild>
              <Button>
                <Plus className="w-4 h-4 mr-1" />
                Add Property
              </Button>
            </DialogTrigger>
            <DialogContent>
              <DialogHeader>
                <DialogTitle>Add Property to Compare</DialogTitle>
              </DialogHeader>
              <div className="space-y-4 mt-4">
                <div>
                  <Label>Property Name</Label>
                  <Input
                    value={newProp.name}
                    onChange={(e) => setNewProp({ ...newProp, name: e.target.value })}
                    placeholder="e.g., Marina Residence Tower 1"
                  />
                </div>
                <div className="grid grid-cols-2 gap-4">
                  <div>
                    <Label>City</Label>
                    <Input
                      value={newProp.city}
                      onChange={(e) => setNewProp({ ...newProp, city: e.target.value })}
                    />
                  </div>
                  <div>
                    <Label>District</Label>
                    <Input
                      value={newProp.district}
                      onChange={(e) => setNewProp({ ...newProp, district: e.target.value })}
                      placeholder="e.g., Dubai Marina"
                    />
                  </div>
                </div>
                <div className="grid grid-cols-2 gap-4">
                  <div>
                    <Label>Purchase Price</Label>
                    <Input
                      type="number"
                      value={newProp.purchasePrice}
                      onChange={(e) =>
                        setNewProp({ ...newProp, purchasePrice: parseFloat(e.target.value) || 0 })
                      }
                    />
                  </div>
                  <div>
                    <Label>Monthly Rent</Label>
                    <Input
                      type="number"
                      value={newProp.monthlyRent}
                      onChange={(e) =>
                        setNewProp({ ...newProp, monthlyRent: parseFloat(e.target.value) || 0 })
                      }
                    />
                  </div>
                </div>
                <div className="grid grid-cols-3 gap-4">
                  <div>
                    <Label>Location Score (0-100)</Label>
                    <Input
                      type="number"
                      value={newProp.locationScore}
                      onChange={(e) =>
                        setNewProp({ ...newProp, locationScore: parseInt(e.target.value) || 0 })
                      }
                      min={0}
                      max={100}
                    />
                  </div>
                  <div>
                    <Label>Liquidity Score (0-100)</Label>
                    <Input
                      type="number"
                      value={newProp.liquidityScore}
                      onChange={(e) =>
                        setNewProp({ ...newProp, liquidityScore: parseInt(e.target.value) || 0 })
                      }
                      min={0}
                      max={100}
                    />
                  </div>
                  <div>
                    <Label>Appreciation %</Label>
                    <Input
                      type="number"
                      value={newProp.appreciationPotential}
                      onChange={(e) =>
                        setNewProp({ ...newProp, appreciationPotential: parseInt(e.target.value) || 0 })
                      }
                      min={0}
                      max={100}
                    />
                  </div>
                </div>
                <Button onClick={handleAdd} className="w-full">
                  Add to Comparison
                </Button>
              </div>
            </DialogContent>
          </Dialog>
          {comparisonItems.length > 0 && (
            <Button variant="outline" onClick={clearComparison}>
              <Trash2 className="w-4 h-4 mr-1" />
              Clear All
            </Button>
          )}
        </div>
      </div>

      {comparisonItems.length === 0 ? (
        <Card className="min-h-[300px] flex items-center justify-center">
          <CardContent className="text-center p-8">
            <GitCompareArrows className="w-16 h-16 mx-auto mb-4 text-muted-foreground/30" />
            <p className="text-lg font-medium text-muted-foreground">
              No properties to compare yet
            </p>
            <p className="text-sm text-muted-foreground/70 mt-2">
              Add properties to see side-by-side comparison
            </p>
          </CardContent>
        </Card>
      ) : (
        <Card>
          <CardContent className="p-0 overflow-x-auto">
            <table className="w-full text-sm">
              <thead>
                <tr className="border-b bg-muted/50">
                  <th className="text-left py-3 px-4 font-medium">Property</th>
                  <SortHeader field="purchasePrice" label="Price" />
                  <SortHeader field="grossYield" label="Gross Yield" />
                  <SortHeader field="netYield" label="Net Yield" />
                  <SortHeader field="roi" label="ROI" />
                  <SortHeader field="locationScore" label="Location" />
                  <SortHeader field="liquidityScore" label="Liquidity" />
                  <SortHeader field="appreciationPotential" label="Appreciation" />
                  <SortHeader field="overallScore" label="Overall" />
                  <th className="py-3 px-2"></th>
                </tr>
              </thead>
              <tbody>
                {sorted.map((item, idx) => (
                  <tr
                    key={item.id}
                    className={`border-b border-border/50 hover:bg-muted/30 ${
                      idx === 0 ? "bg-primary/5" : ""
                    }`}
                  >
                    <td className="py-3 px-4">
                      <div>
                        <p className="font-medium">{item.name}</p>
                        <p className="text-xs text-muted-foreground flex items-center gap-1">
                          <MapPin className="w-3 h-3" />
                          {item.district}, {item.city}
                        </p>
                      </div>
                    </td>
                    <td className="text-right py-3 px-2">
                      {formatCurrency(item.purchasePrice, "AED")}
                    </td>
                    <td className="text-right py-3 px-2 text-success font-medium">
                      {item.grossYield}%
                    </td>
                    <td className="text-right py-3 px-2">{item.netYield}%</td>
                    <td className="text-right py-3 px-2 font-medium">{item.roi}%</td>
                    <td className="text-right py-3 px-2">
                      <div className="flex items-center justify-end gap-1">
                        {item.locationScore}
                        {item.locationScore >= 80 && <Star className="w-3 h-3 text-yellow-400" />}
                      </div>
                    </td>
                    <td className="text-right py-3 px-2">{item.liquidityScore}</td>
                    <td className="text-right py-3 px-2">{item.appreciationPotential}%</td>
                    <td className="text-right py-3 px-2">
                      <Badge
                        className={
                          item.overallScore >= 70
                            ? "bg-success/20 text-success"
                            : item.overallScore >= 50
                            ? "bg-yellow-500/20 text-yellow-400"
                            : "bg-red-500/20 text-red-400"
                        }
                      >
                        {item.overallScore}
                      </Badge>
                    </td>
                    <td className="py-3 px-2">
                      <Button
                        variant="ghost"
                        size="sm"
                        onClick={() => removeFromComparison(item.id)}
                       aria-label={t("common.delete")}>
                        <Trash2 className="w-4 h-4 text-destructive" />
                      </Button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </CardContent>
        </Card>
      )}
    </div>
  );
}
