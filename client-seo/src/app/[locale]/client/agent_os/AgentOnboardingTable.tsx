"use client";

import React, { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Check, Mail, Smartphone, Globe, RefreshCcw } from "lucide-react";
import { m } from "framer-motion";

const MOCK_AGENTS = [
  { id: 1, name: "Jessica H.", provider: "NWMLS", status: "PENDING", phone: "+1 (206) 555-0100", email: "jess@example.com" },
  { id: 2, name: "Marcus T.", provider: "NWMLS", status: "INVITED", phone: "+1 (206) 555-0199", email: "marcus@example.com" },
  { id: 3, name: "Sarah L.", provider: "Zillow", status: "ONBOARDED", phone: "+1 (425) 555-0122", email: "sarah@example.com" },
  { id: 4, name: "David K.", provider: "NWMLS", status: "PENDING", phone: "+1 (425) 555-0144", email: "david@example.com" },
];

export function AgentOnboardingTable() {
  const [agents, setAgents] = useState(MOCK_AGENTS);
  const [loadingId, setLoadingId] = useState<number | null>(null);

  const handleInvite = (id: number) => {
    setLoadingId(id);
    setTimeout(() => {
      setAgents(prev => prev.map(a => a.id === id ? { ...a, status: "INVITED" } : a));
      setLoadingId(null);
    }, 1500);
  };

  return (
    <Card className="bg-slate-900/60 border-slate-800">
      <CardHeader className="flex flex-row items-center justify-between">
        <div>
          <CardTitle className="text-slate-100 flex items-center gap-2">
            <Globe className="h-5 w-5 text-indigo-400" />
            MLS Agent Acquisition
          </CardTitle>
          <CardDescription className="text-slate-400">
            Agents imported from external MLS providers (NWMLS, Zillow) waiting for automated onboarding.
          </CardDescription>
        </div>
        <Button variant="outline" className="border-slate-700 text-slate-300 hover:bg-slate-800 hover:text-white">
          <RefreshCcw className="h-4 w-4 mr-2" />
          Sync Providers
        </Button>
      </CardHeader>
      <CardContent>
        <div className="rounded-md border border-slate-800 overflow-hidden">
          <Table>
            <TableHeader className="bg-slate-800/50">
              <TableRow className="border-slate-800 hover:bg-transparent">
                <TableHead className="text-slate-400">Agent Name</TableHead>
                <TableHead className="text-slate-400">Provider</TableHead>
                <TableHead className="text-slate-400">Contact</TableHead>
                <TableHead className="text-slate-400">Status</TableHead>
                <TableHead className="text-right text-slate-400">Actions</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {agents.map((agent, i) => (
                <TableRow key={agent.id} className="border-slate-800 hover:bg-slate-800/20">
                  <TableCell className="font-medium text-slate-200">{agent.name}</TableCell>
                  <TableCell>
                    <Badge variant="outline" className="border-indigo-500/30 text-indigo-400 bg-indigo-500/10">
                      {agent.provider}
                    </Badge>
                  </TableCell>
                  <TableCell>
                    <div className="flex flex-col gap-1 text-xs text-slate-400">
                      <span className="flex items-center gap-1"><Smartphone className="h-3 w-3" /> {agent.phone}</span>
                      <span className="flex items-center gap-1"><Mail className="h-3 w-3" /> {agent.email}</span>
                    </div>
                  </TableCell>
                  <TableCell>
                    <Badge variant="outline" className={`
                      ${agent.status === 'PENDING' ? 'border-yellow-500/30 text-yellow-400 bg-yellow-500/10' : ''}
                      ${agent.status === 'INVITED' ? 'border-blue-500/30 text-blue-400 bg-blue-500/10' : ''}
                      ${agent.status === 'ONBOARDED' ? 'border-emerald-500/30 text-emerald-400 bg-emerald-500/10' : ''}
                    `}>
                      {agent.status}
                    </Badge>
                  </TableCell>
                  <TableCell className="text-right">
                    {agent.status === 'PENDING' && (
                      <Button 
                        size="sm" 
                        className="bg-indigo-600 hover:bg-indigo-500 text-white"
                        onClick={() => handleInvite(agent.id)}
                        disabled={loadingId === agent.id}
                      >
                        {loadingId === agent.id ? (
                          <RefreshCcw className="h-4 w-4 animate-spin" />
                        ) : (
                          "Send Invite"
                        )}
                      </Button>
                    )}
                    {agent.status === 'INVITED' && (
                      <Button size="sm" variant="outline" className="border-slate-700 text-slate-400" disabled>
                        <Check className="h-4 w-4 mr-2" /> Invited
                      </Button>
                    )}
                    {agent.status === 'ONBOARDED' && (
                      <span className="text-xs font-medium text-emerald-500 flex items-center justify-end gap-1">
                        <Check className="h-4 w-4" /> Active Member
                      </span>
                    )}
                  </TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
        </div>
      </CardContent>
    </Card>
  );
}
