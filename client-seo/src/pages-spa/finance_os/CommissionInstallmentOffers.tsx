"use client";

import React, { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { CreditCard, ArrowRight, CheckCircle2 } from "lucide-react";

const OFFERS = [
  { id: "C-9102", property: "1422 Harbor View Dr", agent: "Marcus T.", commission: 35000, model: "12 Installments", status: "PENDING_AGENT_APPROVAL" },
  { id: "C-9103", property: "Downtown Studio A", agent: "Sarah L.", commission: 12500, model: "Hybrid 50/6", status: "ACTIVE" },
];

export function CommissionInstallmentOffers() {
  const [offers, setOffers] = useState(OFFERS);

  return (
    <Card className="bg-slate-900/60 border-slate-800">
      <CardHeader className="flex flex-row items-center justify-between pb-4">
        <div>
          <CardTitle className="text-slate-100 flex items-center gap-2">
            <CreditCard className="h-5 w-5 text-emerald-400" />
            Agent Commission Installment Offers
          </CardTitle>
          <CardDescription className="text-slate-400">
            Real-time status of commission factoring and installment agreements.
          </CardDescription>
        </div>
        <Button variant="outline" className="border-slate-700 text-slate-300">
          New Offer
        </Button>
      </CardHeader>
      <CardContent>
        <Table>
          <TableHeader className="bg-slate-800/30">
            <TableRow className="border-slate-800">
              <TableHead className="text-slate-400">Contract ID</TableHead>
              <TableHead className="text-slate-400">Agent & Property</TableHead>
              <TableHead className="text-slate-400">Total Commission</TableHead>
              <TableHead className="text-slate-400">Model</TableHead>
              <TableHead className="text-slate-400">Status</TableHead>
              <TableHead className="text-right text-slate-400">Action</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {offers.map(o => (
              <TableRow key={o.id} className="border-slate-800 hover:bg-slate-800/20">
                <TableCell className="font-medium text-slate-200">{o.id}</TableCell>
                <TableCell>
                  <p className="text-sm text-slate-200">{o.agent}</p>
                  <p className="text-xs text-slate-500">{o.property}</p>
                </TableCell>
                <TableCell className="text-emerald-400 font-semibold">
                  ${o.commission.toLocaleString()}
                </TableCell>
                <TableCell>
                  <Badge variant="outline" className="bg-indigo-500/10 text-indigo-400 border-indigo-500/20">
                    {o.model}
                  </Badge>
                </TableCell>
                <TableCell>
                  {o.status === "ACTIVE" ? (
                    <Badge variant="outline" className="bg-emerald-500/10 text-emerald-400 border-emerald-500/20">
                      <CheckCircle2 className="h-3 w-3 mr-1" /> Active
                    </Badge>
                  ) : (
                    <Badge variant="outline" className="bg-yellow-500/10 text-yellow-500 border-yellow-500/20">
                      Pending Approval
                    </Badge>
                  )}
                </TableCell>
                <TableCell className="text-right">
                  <Button size="sm" variant="ghost" className="text-blue-400 hover:text-blue-300">
                    Review <ArrowRight className="h-4 w-4 ml-1" />
                  </Button>
                </TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </CardContent>
    </Card>
  );
}
