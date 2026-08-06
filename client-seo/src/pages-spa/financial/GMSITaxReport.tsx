"use client";

import React, { useState } from "react";
import {
  FileText,
  Download,
  CheckCircle2,
  Building2,
  Calculator,
  ShieldAlert,
  ArrowUpRight,
  Sparkles,
} from "lucide-react";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { toast } from "sonner";

export default function GMSITaxReport() {
  const [taxYear, setTaxYear] = useState("2026");

  const reportData = {
    taxYear: 2026,
    landlordName: "Ahmet Yılmaz",
    tckn: "12345678901",
    taxOffice: "Zincirlikuyu Vergi Dairesi",
    summary: {
      totalGrossRentCollected: 420000,
      annualExemption: 33000, // 2026 Mesken İstisnası
      deductibleExpenses: 14700, // Reservatior Hizmet & Komisyon Faturaları (%3.5)
      netTaxableBase: 372300,
      estimatedTaxDuty: 61845,
    },
    monthlyBreakdown: [
      { month: "2026-01", gross: 35000, fee: 1225, netPay: 33775, invoiceNo: "RSV2026000001" },
      { month: "2026-02", gross: 35000, fee: 1225, netPay: 33775, invoiceNo: "RSV2026000002" },
      { month: "2026-03", gross: 35000, fee: 1225, netPay: 33775, invoiceNo: "RSV2026000003" },
      { month: "2026-04", gross: 35000, fee: 1225, netPay: 33775, invoiceNo: "RSV2026000004" },
    ],
  };

  const handleExportXML = () => {
    toast.success("GİB Hazır Beyanname Formatlı XML Dosyası İndirildi!");
  };

  return (
    <div className="p-6 sm:p-10 space-y-8 max-w-6xl mx-auto font-sans">
      {/* Header */}
      <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 border-b pb-6">
        <div>
          <div className="flex items-center gap-2">
            <Badge className="bg-blue-600 text-white text-xs">GİB Entegre</Badge>
            <span className="text-xs text-muted-foreground">Gelir İdaresi Başkanlığı Uyumlu</span>
          </div>
          <h1 className="text-3xl font-extrabold text-foreground mt-1">
            GMSİ Yıl Sonu Vergi Beyanname Modülü
          </h1>
          <p className="text-sm text-muted-foreground">
            Gayrimenkul Sermaye İratı kira gelirlerinizi tek tıkla mali müşavirinize veya GİB portalına aktarın.
          </p>
        </div>

        <div className="flex gap-3">
          <Button onClick={handleExportXML} className="bg-blue-600 hover:bg-blue-700 text-white rounded-xl font-bold">
            <Download className="w-4 h-4 mr-2" /> GİB XML İndir
          </Button>
        </div>
      </div>

      {/* Summary Cards */}
      <div className="grid grid-cols-1 sm:grid-cols-4 gap-4">
        <Card className="rounded-2xl border border-border">
          <CardHeader className="pb-2">
            <CardDescription className="text-xs">Brüt Kira Tahsilatı</CardDescription>
            <CardTitle className="text-2xl font-bold text-foreground">
              {reportData.summary.totalGrossRentCollected.toLocaleString("tr-TR")} TL
            </CardTitle>
          </CardHeader>
        </Card>

        <Card className="rounded-2xl border border-border">
          <CardHeader className="pb-2">
            <CardDescription className="text-xs">Mesken İstisnası (2026)</CardDescription>
            <CardTitle className="text-2xl font-bold text-blue-500">
              -{reportData.summary.annualExemption.toLocaleString("tr-TR")} TL
            </CardTitle>
          </CardHeader>
        </Card>

        <Card className="rounded-2xl border border-border">
          <CardHeader className="pb-2">
            <CardDescription className="text-xs">Düşülebilir Komisyon Gideri</CardDescription>
            <CardTitle className="text-2xl font-bold text-blue-500">
              -{reportData.summary.deductibleExpenses.toLocaleString("tr-TR")} TL
            </CardTitle>
          </CardHeader>
        </Card>

        <Card className="rounded-2xl border border-border bg-primary/5">
          <CardHeader className="pb-2">
            <CardDescription className="text-xs text-primary font-bold">Tahmini Vergi Matrahı</CardDescription>
            <CardTitle className="text-2xl font-bold text-primary">
              {reportData.summary.netTaxableBase.toLocaleString("tr-TR")} TL
            </CardTitle>
          </CardHeader>
        </Card>
      </div>

      {/* Monthly Breakdown Table */}
      <Card className="rounded-3xl border border-border">
        <CardHeader>
          <CardTitle className="text-lg font-bold">Aylık Kira & Komisyon Faturası Dökümü</CardTitle>
          <CardDescription className="text-xs">
            PayTR / Stripe üzerinden ev sahibine aktarılan net kira ve kesilen Reservatior e-Fatura numaraları.
          </CardDescription>
        </CardHeader>
        <CardContent>
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>Dönem</TableHead>
                <TableHead>Tahsil Edilen Brüt Kira</TableHead>
                <TableHead>Kesilen Hizmet Bedeli (%3.5)</TableHead>
                <TableHead>Net Hesaba Yatan</TableHead>
                <TableHead>Reservatior E-Fatura No</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {reportData.monthlyBreakdown.map((row) => (
                <TableRow key={row.month}>
                  <TableCell className="font-bold">{row.month}</TableCell>
                  <TableCell>{row.gross.toLocaleString("tr-TR")} TL</TableCell>
                  <TableCell className="text-blue-500 font-medium">-{row.fee.toLocaleString("tr-TR")} TL</TableCell>
                  <TableCell className="text-blue-500 font-bold">{row.netPay.toLocaleString("tr-TR")} TL</TableCell>
                  <TableCell className="font-mono text-xs">{row.invoiceNo}</TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
        </CardContent>
      </Card>
    </div>
  );
}
