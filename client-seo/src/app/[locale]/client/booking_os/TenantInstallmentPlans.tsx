"use client";

import React, { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { CreditCard, Zap, CheckCircle2, AlertTriangle } from "lucide-react";

const RENT_PLANS = [
  { id: "R-819", tenant: "Eleanor V.", property: "Marina Residences #4B", total: 18000, model: "6 Installments", status: "ACTIVE", rail: "CARD_INSTALLMENT" },
  { id: "R-820", tenant: "David L.", property: "Harbour View Penthouse", total: 54000, model: "12 Installments", status: "PENDING_RISK", rail: "A2A_FAST" },
  { id: "R-821", tenant: "Sophie M.", property: "Riverside Loft Block A", total: 12500, model: "Flexible Pay", status: "ACTIVE", rail: "CARD_INSTALLMENT" },
];

export function TenantInstallmentPlans() {
  const [plans, setPlans] = useState(RENT_PLANS);

  return (
    <Card className="bg-slate-900/60 border-slate-800 mt-6">
      <CardHeader>
        <CardTitle className="text-slate-100 flex items-center gap-2">
          <Zap className="h-5 w-5 text-blue-400" />
          Tenant Flex & Installment Plans
        </CardTitle>
        <CardDescription className="text-slate-400">
          Overview of active rental deposits and commissions paid via installments.
        </CardDescription>
      </CardHeader>
      <CardContent>
        <Table>
          <TableHeader className="bg-slate-800/30">
            <TableRow className="border-slate-800">
              <TableHead className="text-slate-400">Plan ID</TableHead>
              <TableHead className="text-slate-400">Tenant & Property</TableHead>
              <TableHead className="text-slate-400">Total Value</TableHead>
              <TableHead className="text-slate-400">Payment Rail</TableHead>
              <TableHead className="text-slate-400">Status</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {plans.map(p => (
              <TableRow key={p.id} className="border-slate-800 hover:bg-slate-800/20">
                <TableCell className="font-medium text-slate-200">{p.id}</TableCell>
                <TableCell>
                  <p className="text-sm text-slate-200">{p.tenant}</p>
                  <p className="text-xs text-slate-500">{p.property}</p>
                </TableCell>
                <TableCell className="text-blue-400 font-semibold">
                  ${p.total.toLocaleString()}
                  <span className="block text-xs text-slate-500 font-normal">{p.model}</span>
                </TableCell>
                <TableCell>
                  <Badge variant="outline" className="bg-slate-800/50 text-slate-300 border-slate-700">
                    <CreditCard className="h-3 w-3 mr-1" /> {p.rail === "CARD_INSTALLMENT" ? "Credit Card" : "A2A Fast"}
                  </Badge>
                </TableCell>
                <TableCell>
                  {p.status === "ACTIVE" ? (
                    <Badge variant="outline" className="bg-emerald-500/10 text-emerald-400 border-emerald-500/20">
                      <CheckCircle2 className="h-3 w-3 mr-1" /> Active
                    </Badge>
                  ) : (
                    <Badge variant="outline" className="bg-orange-500/10 text-orange-400 border-orange-500/20">
                      <AlertTriangle className="h-3 w-3 mr-1" /> Risk Review
                    </Badge>
                  )}
                </TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </CardContent>
    </Card>
  );
}
