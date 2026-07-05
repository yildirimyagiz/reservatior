"use client";

import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Lock, Unlock, ShieldCheck, AlertTriangle, RotateCw, CheckCircle2, XCircle } from "lucide-react";
import { cn } from "@/lib/utils";

interface SmartLockGateProps {
  lockId?: string;
  propertyName?: string;
  className?: string;
}

type GateStatus = "LOCKED" | "UNLOCKED" | "PENDING_CLEANING" | "CODE_GENERATED";

interface GateStep {
  label: string;
  status: "pass" | "fail" | "pending";
  description: string;
}

export function SmartLockGate({ lockId, propertyName, className }: SmartLockGateProps) {
  const [gateStatus, setGateStatus] = useState<GateStatus>("LOCKED");
  const [syncing, setSyncing] = useState(false);

  const steps: GateStep[] = [
    {
      label: "Check-out Cleaning",
      status: gateStatus === "PENDING_CLEANING" ? "pending" : "pass",
      description: "12-point photo SLA verified by AI",
    },
    {
      label: "AI Visual Inspection",
      status: gateStatus === "PENDING_CLEANING" ? "pending" : gateStatus === "LOCKED" ? "fail" : "pass",
      description: "Stain & dust detection passed",
    },
    {
      label: "SmartLock Code Generation",
      status: gateStatus === "CODE_GENERATED" ? "pass" : gateStatus === "UNLOCKED" ? "pass" : "pending",
      description: "Next guest access code ready",
    },
    {
      label: "Access Granted",
      status: gateStatus === "UNLOCKED" ? "pass" : "pending",
      description: "Guest checked in",
    },
  ];

  const isGateOpen = gateStatus === "UNLOCKED" || gateStatus === "CODE_GENERATED";

  const simulateSync = async () => {
    setSyncing(true);
    await new Promise(r => setTimeout(r, 1500));
    setGateStatus(prev =>
      prev === "LOCKED" ? "PENDING_CLEANING" :
      prev === "PENDING_CLEANING" ? "CODE_GENERATED" :
      prev === "CODE_GENERATED" ? "UNLOCKED" : "LOCKED"
    );
    setSyncing(false);
  };

  return (
    <Card className={cn("bg-slate-900/50 border-slate-800", className)}>
      <CardHeader className="flex flex-row items-start justify-between">
        <div>
          <CardTitle className="text-slate-100 text-base flex items-center gap-2">
            <ShieldCheck className="w-4 h-4 text-emerald-500" />
            SmartLock Quality Gate
          </CardTitle>
          <CardDescription className="text-slate-400 text-xs mt-1">
            {propertyName ? `${propertyName} · ` : ""}Cleaning verification gates digital access
          </CardDescription>
        </div>
        <Badge
          variant="outline"
          className={cn(
            "text-xs font-mono",
            isGateOpen
              ? "border-emerald-500/30 text-emerald-400 bg-emerald-500/10"
              : "border-amber-500/30 text-amber-400 bg-amber-500/10"
          )}
        >
          {isGateOpen ? (
            <><Unlock className="w-3 h-3 mr-1" /> Gate Open</>
          ) : (
            <><Lock className="w-3 h-3 mr-1" /> Gate Locked</>
          )}
        </Badge>
      </CardHeader>
      <CardContent>
        <div className="space-y-3">
          {steps.map((step, i) => (
            <div key={i} className="flex items-start gap-3">
              <div className="flex flex-col items-center">
                <div className={cn(
                  "w-6 h-6 rounded-full flex items-center justify-center border",
                  step.status === "pass" && "border-emerald-500/50 bg-emerald-500/20 text-emerald-400",
                  step.status === "fail" && "border-red-500/50 bg-red-500/20 text-red-400",
                  step.status === "pending" && "border-slate-600 bg-slate-800 text-slate-500",
                )}>
                  {step.status === "pass" ? <CheckCircle2 className="w-3.5 h-3.5" /> :
                   step.status === "fail" ? <XCircle className="w-3.5 h-3.5" /> :
                   <div className="w-2 h-2 rounded-full bg-slate-600 animate-pulse" />}
                </div>
                {i < steps.length - 1 && <div className="w-px h-6 bg-slate-700" />}
              </div>
              <div className="flex-1 pb-3">
                <p className={cn(
                  "text-sm font-medium",
                  step.status === "pass" ? "text-emerald-300" :
                  step.status === "fail" ? "text-red-300" : "text-slate-400"
                )}>
                  {step.label}
                </p>
                <p className="text-xs text-slate-500">{step.description}</p>
              </div>
            </div>
          ))}
        </div>

        <div className="flex items-center justify-between pt-3 border-t border-slate-800 mt-2">
          <div className="flex items-center gap-2 text-xs text-slate-500">
            {gateStatus === "LOCKED" && <AlertTriangle className="w-3.5 h-3.5 text-amber-400" />}
            {gateStatus === "UNLOCKED" && <Unlock className="w-3.5 h-3.5 text-emerald-400" />}
            {gateStatus === "CODE_GENERATED" && <CheckCircle2 className="w-3.5 h-3.5 text-emerald-400" />}
            {gateStatus === "PENDING_CLEANING" && <RotateCw className="w-3.5 h-3.5 text-amber-400 animate-spin" />}
            <span>
              {gateStatus === "LOCKED" && "Waiting for cleaning verification"}
              {gateStatus === "PENDING_CLEANING" && "AI inspecting photos..."}
              {gateStatus === "CODE_GENERATED" && "Code ready — awaiting check-in"}
              {gateStatus === "UNLOCKED" && "Guest access granted"}
            </span>
          </div>
          <Button
            variant="outline"
            size="sm"
            className="text-xs border-slate-700 text-slate-300"
            onClick={simulateSync}
            disabled={syncing}
          >
            {syncing ? "Syncing..." : "Simulate Next Step"}
          </Button>
        </div>
      </CardContent>
    </Card>
  );
}
