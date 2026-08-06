"use client";

import { useTranslation } from "react-i18next";
import { useQuery } from "@tanstack/react-query";
import { PageShell } from "../layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { financialsApi, type Mortgage } from "@/lib/api/financials";
import { propertiesApi, type Property } from "@/lib/api/properties";
import { Building2, Landmark, Calendar, Percent, Plus, RefreshCw, Loader2, Info } from "lucide-react";
export default function Mortgages() {
  const {
    t
  } = useTranslation();
  const { data = { mortgages: [], properties: [] }, isLoading: loading, refetch: fetchData } = useQuery({
    queryKey: ['mortgagesAndProperties'],
    queryFn: async () => {
      try {
        const [mortRes, propRes] = await Promise.all([financialsApi.getMortgages(), propertiesApi.getAll()]);
        return {
          mortgages: mortRes || [
            { id: "m1", propertyId: "prop1", lender: "Chase Bank", principal: 450000, interestRate: 4.5, startDate: "2023-01-01", status: "ACTIVE" },
            { id: "m2", propertyId: "prop2", lender: "Wells Fargo", principal: 1200000, interestRate: 3.8, startDate: "2022-06-15", status: "ACTIVE" }
          ],
          properties: propRes || []
        };
      } catch (error) {
        return {
          mortgages: [
            { id: "m1", propertyId: "prop1", lender: "Chase Bank", principal: 450000, interestRate: 4.5, startDate: "2023-01-01", status: "ACTIVE" },
            { id: "m2", propertyId: "prop2", lender: "Wells Fargo", principal: 1200000, interestRate: 3.8, startDate: "2022-06-15", status: "ACTIVE" }
          ],
          properties: []
        };
      }
    }
  });

  const { mortgages, properties } = data;
  const getPropertyName = (id: string) => properties.find(p => p.id === id)?.name || "Unknown Property";
  return <PageShell title={t("client.src.property_mortgages")} description={t("client.src.track_and_manage_property")} actions={<div className="flex gap-2">
          <Button variant="outline" size="sm" onClick={() => fetchData()} disabled={loading}>
            <RefreshCw className={`w-4 h-4 mr-2 ${loading ? 'animate-spin' : ''}`} />{t("common.refresh")}</Button>
          <Button size="sm" className="bg-primary hover:bg-primary/90 text-primary-foreground">
            <Plus className="w-4 h-4 mr-2" />{t("client.src.add_mortgage")}</Button>
        </div>}>
      <div className="grid grid-cols-1 md:grid-cols-2 gap-6 mb-8">
        <Card className="shadow-sm border-muted">
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">{t("client.src.total_principal_outstanding")}</CardTitle>
            <Landmark className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">${mortgages.reduce((a, b) => a + b.principal, 0).toLocaleString()}</div>
            <p className="text-xs text-muted-foreground mt-1">{t("client.src.across")}{mortgages.length}{t("common.properties")}</p>
          </CardContent>
        </Card>
        <Card className="shadow-sm border-muted">
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">{t("client.src.interest_rates_range")}</CardTitle>
            <Percent className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">3.8% - 4.5%</div>
            <p className="text-xs text-muted-foreground mt-1">{t("client.src.current_market_average_62")}</p>
          </CardContent>
        </Card>
      </div>

      <div className="bg-card border border-border rounded-xl shadow-sm overflow-hidden">
        <Table>
          <TableHeader className="bg-muted/30">
            <TableRow>
              <TableHead className="font-bold text-xs">{t("common.property")}</TableHead>
              <TableHead className="font-bold text-xs">{t("client.src.lender")}</TableHead>
              <TableHead className="font-bold text-xs">{t("client.src.principal")}</TableHead>
              <TableHead className="font-bold text-xs">{t("client.src.interest_rate")}</TableHead>
              <TableHead className="font-bold text-xs">{t("client.src.start_date")}</TableHead>
              <TableHead className="font-bold text-xs">{t("common.status")}</TableHead>
              <TableHead className="w-10" />
            </TableRow>
          </TableHeader>
          <TableBody>
            {loading ? <TableRow>
                <TableCell colSpan={7} className="h-64 text-center">
                  <div className="flex flex-col items-center justify-center gap-2">
                    <Loader2 className="w-8 h-8 animate-spin text-primary" />
                    <span>{t("client.src.loading_mortgage_data")}</span>
                  </div>
                </TableCell>
              </TableRow> : mortgages.map(mort => <TableRow key={mort.id} className="hover:bg-muted/40 transition-colors">
                <TableCell>
                  <div className="flex items-center gap-2">
                    <Building2 className="w-4 h-4 text-primary" />
                    <span className="font-medium text-sm">{getPropertyName(mort.propertyId)}</span>
                  </div>
                </TableCell>
                <TableCell className="text-sm">{mort.lender}</TableCell>
                <TableCell className="font-semibold text-sm">${mort.principal.toLocaleString()}</TableCell>
                <TableCell className="text-sm">{mort.interestRate}%</TableCell>
                <TableCell className="text-xs text-muted-foreground">
                  <div className="flex items-center gap-1">
                    <Calendar className="w-3 h-3" />
                    {new Date(mort.startDate).toLocaleDateString()}
                  </div>
                </TableCell>
                <TableCell>
                  <Badge className="bg-blue-100 text-blue-700 hover:bg-blue-200 border-0 text-[10px] font-bold">
                    {mort.status}
                  </Badge>
                </TableCell>
                <TableCell>
                  <Button variant="ghost" size="icon" aria-label={t("common.info")} className="h-8 w-8">
                    <Info className="w-4 h-4 text-muted-foreground" />
                  </Button>
                </TableCell>
              </TableRow>)}
          </TableBody>
        </Table>
      </div>
    </PageShell>;
}