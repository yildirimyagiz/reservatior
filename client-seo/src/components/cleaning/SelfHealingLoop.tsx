"use client";

import { useState, useRef } from "react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Textarea } from "@/components/ui/textarea";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { AlertTriangle, CheckCircle2, ArrowRight, RefreshCw, DollarSign, Wrench } from "lucide-react";
import { cn } from "@/lib/utils";

type LoopStep = "issue_reported" | "compensation" | "cleaning_dispatched" | "re_inspected" | "resolved";

const STEP_LABELS: Record<LoopStep, string> = {
  issue_reported: "Issue Reported",
  compensation: "Guest Compensated",
  cleaning_dispatched: "Cleaning Dispatched",
  re_inspected: "Re-Inspected",
  resolved: "Resolved",
};

interface SelfHealingLoopProps {
  bookingId?: string;
  propertyName?: string;
  className?: string;
}

export function SelfHealingLoop({ bookingId, propertyName, className }: SelfHealingLoopProps) {
  const [currentStep, setCurrentStep] = useState<LoopStep>("issue_reported");
  const [issueType, setIssueType] = useState("");
  const [issueDescription, setIssueDescription] = useState("");
  const [compensationAmount] = useState(75);
  const [submitting, setSubmitting] = useState(false);

  const stepIndex = ["issue_reported", "compensation", "cleaning_dispatched", "re_inspected", "resolved"];

  const progress = Math.round((stepIndex.indexOf(currentStep) / (stepIndex.length - 1)) * 100);

  const advanceStep = async () => {
    setSubmitting(true);
    await new Promise(r => setTimeout(r, 800));
    const currentIdx = stepIndex.indexOf(currentStep);
    if (currentIdx < stepIndex.length - 1) {
      setCurrentStep(stepIndex[currentIdx + 1] as LoopStep);
    }
    setSubmitting(false);
  };

  const resetLoop = () => {
    setCurrentStep("issue_reported");
    setIssueType("");
    setIssueDescription("");
  };

  return (
    <Card className={cn("bg-slate-900/50 border-slate-800", className)}>
      <CardHeader>
        <div className="flex items-center justify-between">
          <div>
            <CardTitle className="text-slate-100 text-base flex items-center gap-2">
              <RefreshCw className="w-4 h-4 text-amber-500" />
              Self-Healing Quality Loop
            </CardTitle>
            <CardDescription className="text-slate-400 text-xs mt-1">
              {propertyName ? `${propertyName} · ` : ""}Automated issue → compensation → cleaning → verification
            </CardDescription>
          </div>
          {currentStep === "resolved" && (
            <Badge variant="outline" className="border-emerald-500/30 text-emerald-400">
              <CheckCircle2 className="w-3 h-3 mr-1" /> Loop Closed
            </Badge>
          )}
        </div>

        {currentStep !== "resolved" && (
          <div className="mt-3">
            <div className="flex justify-between mb-1">
              {stepIndex.map((s, i) => (
                <div
                  key={s}
                  className={cn(
                    "text-[10px] font-medium",
                    stepIndex.indexOf(currentStep) >= i ? "text-emerald-400" : "text-slate-600"
                  )}
                >
                  {i + 1}
                </div>
              ))}
            </div>
            <div className="h-1.5 bg-slate-800 rounded-full overflow-hidden">
              <div
                className="h-full bg-gradient-to-r from-amber-500 to-emerald-500 rounded-full transition-all duration-500"
                style={{ width: `${progress}%` }}
              />
            </div>
          </div>
        )}
      </CardHeader>
      <CardContent>
        <div className="space-y-4">
          {stepIndex.map((step, i) => {
            const isActive = step === currentStep;
            const isPast = stepIndex.indexOf(currentStep) > i;
            const Icon = isPast ? CheckCircle2 :
                         isActive && step === "issue_reported" ? AlertTriangle :
                         isActive && step === "compensation" ? DollarSign :
                         isActive && step === "cleaning_dispatched" ? Wrench :
                         isActive && step === "re_inspected" ? RefreshCw :
                         isActive ? CheckCircle2 : AlertTriangle;

            return (
              <div key={step} className="flex items-start gap-3">
                <div className={cn(
                  "w-7 h-7 rounded-full flex items-center justify-center shrink-0 border transition-colors",
                  isPast ? "border-emerald-500/50 bg-emerald-500/20 text-emerald-400" :
                  isActive ? "border-amber-500/50 bg-amber-500/20 text-amber-400" :
                  "border-slate-700 bg-slate-800/50 text-slate-600"
                )}>
                  <Icon className="w-3.5 h-3.5" />
                </div>
                <div className="flex-1 min-w-0">
                  <p className={cn(
                    "text-sm font-medium",
                    isPast ? "text-emerald-300" : isActive ? "text-amber-200" : "text-slate-600"
                  )}>
                    {STEP_LABELS[step]}
                  </p>
                  <p className="text-xs text-slate-500 mt-0.5">
                    {step === "issue_reported" && "Guest reports quality issue"}
                    {step === "compensation" && `Auto-compensation of $${compensationAmount} processed`}
                    {step === "cleaning_dispatched" && "Cleaning crew dispatched for re-cleaning"}
                    {step === "re_inspected" && "AI re-inspection passed — quality restored"}
                    {step === "resolved" && "All steps completed. Guest notified."}
                  </p>

                  {isActive && step === "issue_reported" && (
                    <div className="mt-3 space-y-2">
                      <Select value={issueType} onValueChange={setIssueType}>
                        <SelectTrigger className="w-full border-slate-700 bg-slate-800 text-slate-200 text-xs">
                          <SelectValue placeholder="Select issue type" />
                        </SelectTrigger>
                        <SelectContent className="border-slate-700 bg-slate-900">
                          <SelectItem value="cleanliness" className="text-slate-200">Cleanliness</SelectItem>
                          <SelectItem value="damage" className="text-slate-200">Damage</SelectItem>
                          <SelectItem value="amenities" className="text-slate-200">Missing Amenities</SelectItem>
                          <SelectItem value="odor" className="text-slate-200">Odor</SelectItem>
                          <SelectItem value="pest" className="text-slate-200">Pest</SelectItem>
                        </SelectContent>
                      </Select>
                      <Textarea
                        placeholder="Describe the issue..."
                        value={issueDescription}
                        onChange={e => setIssueDescription(e.target.value)}
                        className="border-slate-700 bg-slate-800 text-slate-200 text-xs min-h-[60px]"
                      />
                    </div>
                  )}
                </div>
              </div>
            );
          })}
        </div>

        <div className="mt-4 flex justify-between items-center pt-3 border-t border-slate-800">
          {currentStep === "resolved" ? (
            <Button variant="outline" size="sm" className="border-slate-700 text-slate-300" onClick={resetLoop}>
              <RefreshCw className="w-3.5 h-3.5 mr-2" />
              Start New Loop
            </Button>
          ) : (
            <Button
              onClick={advanceStep}
              disabled={submitting || (currentStep === "issue_reported" && (!issueType || !issueDescription))}
              className={cn(
                "ml-auto text-white",
                currentStep === "issue_reported" ? "bg-amber-600 hover:bg-amber-700" :
                currentStep === "compensation" ? "bg-blue-600 hover:bg-blue-700" :
                "bg-emerald-600 hover:bg-emerald-700"
              )}
            >
              {submitting ? "Processing..." : <>
                {currentStep === "issue_reported" && <>Flag Issue & Compensate Guest</>}
                {currentStep === "compensation" && <>Dispatch Cleaning Crew</>}
                {currentStep === "cleaning_dispatched" && <>Run AI Re-Inspection</>}
                {currentStep === "re_inspected" && <>Close Loop</>}
                <ArrowRight className="w-3.5 h-3.5 ml-2" />
              </>}
            </Button>
          )}
        </div>
      </CardContent>
    </Card>
  );
}
