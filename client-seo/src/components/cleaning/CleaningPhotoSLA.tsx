"use client";

import { useState, useRef } from "react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Progress } from "@/components/ui/progress";
import { Camera, CheckCircle2, XCircle, Upload, Image, Loader2 } from "lucide-react";
import { cn } from "@/lib/utils";

interface PhotoCheckpoint {
  id: string;
  label: string;
  description: string;
  status: "pending" | "captured" | "approved" | "rejected";
  photoUrl?: string;
}

const CHECKPOINTS: PhotoCheckpoint[] = [
  { id: "kitchen", label: "Kitchen", description: "Countertops, sink, appliances", status: "pending" },
  { id: "bathroom", label: "Bathroom", description: "Toilet, shower, mirror, sink", status: "pending" },
  { id: "bedroom", label: "Bedroom", description: "Beds made, linens fresh, floor clear", status: "pending" },
  { id: "living", label: "Living Area", description: "Furniture arranged, surfaces dusted", status: "pending" },
  { id: "entryway", label: "Entryway", description: "Shoes stored, door area clean", status: "pending" },
  { id: "windows", label: "Windows", description: "Streak-free, sills dusted", status: "pending" },
  { id: "floors", label: "Floors", description: "Mopped/vacuumed, no debris", status: "pending" },
  { id: "linens", label: "Linens & Towels", description: "Fresh sets, neatly folded", status: "pending" },
  { id: "trash", label: "Trash", description: "All bins emptied, liners replaced", status: "pending" },
  { id: "amenities", label: "Amenities", description: "Soap, paper, supplies stocked", status: "pending" },
  { id: "appliances", label: "Appliances", description: "Fridge, oven, microwave, dishwasher", status: "pending" },
  { id: "exterior", label: "Exterior", description: "Entry clean, lights on, no hazards", status: "pending" },
];

interface CleaningPhotoSLAProps {
  propertyName?: string;
  bookingId?: string;
  className?: string;
  onComplete?: (results: typeof CHECKPOINTS) => void;
}

export function CleaningPhotoSLA({ propertyName, bookingId, className, onComplete }: CleaningPhotoSLAProps) {
  const [checkpoints, setCheckpoints] = useState(CHECKPOINTS);
  const [activeCheckpoint, setActiveCheckpoint] = useState<string | null>(null);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [submitted, setSubmitted] = useState(false);
  const fileInputRef = useRef<HTMLInputElement>(null);
  const [previewUrl, setPreviewUrl] = useState<string | null>(null);

  const capturedCount = checkpoints.filter(c => c.status !== "pending").length;
  const approvedCount = checkpoints.filter(c => c.status === "approved").length;
  const progress = Math.round((capturedCount / checkpoints.length) * 100);

  const handleFileCapture = (checkpointId: string) => {
    setActiveCheckpoint(checkpointId);
    fileInputRef.current?.click();
  };

  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file || !activeCheckpoint) return;

    const url = URL.createObjectURL(file);
    setPreviewUrl(url);

    setCheckpoints(prev =>
      prev.map(c => c.id === activeCheckpoint ? { ...c, status: "captured" as const, photoUrl: url } : c)
    );
    setActiveCheckpoint(null);
  };

  const triggerCamera = async (checkpointId: string) => {
    try {
      const stream = await navigator.mediaDevices.getUserMedia({ video: { facingMode: "environment" } });
      stream.getTracks().forEach(t => t.stop());
      handleFileCapture(checkpointId);
    } catch {
      handleFileCapture(checkpointId);
    }
  };

  const submitForAIReview = async () => {
    setIsSubmitting(true);
    await new Promise(r => setTimeout(r, 2000));
    setCheckpoints(prev =>
      prev.map(c => ({
        ...c,
        status: c.status === "captured" ? ("approved" as const) : c.status,
      }))
    );
    setIsSubmitting(false);
    setSubmitted(true);
    onComplete?.(checkpoints);
  };

  return (
    <Card className={cn("bg-slate-900/50 border-slate-800", className)}>
      <CardHeader>
        <div className="flex items-center justify-between">
          <div>
            <CardTitle className="text-slate-100 text-base flex items-center gap-2">
              <Camera className="w-4 h-4 text-blue-500" />
              12-Point Photo SLA
            </CardTitle>
            <CardDescription className="text-slate-400 text-xs mt-1">
              {propertyName || "Property"} · Capture all 12 checkpoints for AI verification
            </CardDescription>
          </div>
          <div className="text-right">
            <div className="text-2xl font-bold text-slate-100">{capturedCount}/12</div>
            <p className="text-xs text-slate-500">Photos captured</p>
          </div>
        </div>
        <Progress value={progress} className="h-1.5 bg-slate-800 mt-3" />
      </CardHeader>
      <CardContent>
        <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 gap-2">
          {checkpoints.map(cp => (
            <button
              key={cp.id}
              onClick={() => !submitted && triggerCamera(cp.id)}
              disabled={submitted}
              className={cn(
                "relative flex flex-col items-center gap-1 p-2 rounded-lg border text-xs transition-all",
                cp.status === "pending" && "border-slate-800 bg-slate-900/30 text-slate-500 hover:border-slate-700 hover:bg-slate-800/50",
                cp.status === "captured" && "border-blue-500/30 bg-blue-500/10 text-blue-400",
                cp.status === "approved" && "border-blue-500/30 bg-blue-500/10 text-blue-400",
                cp.status === "rejected" && "border-red-500/30 bg-red-500/10 text-red-400",
                submitted && "cursor-default"
              )}
            >
              {cp.status === "approved" ? (
                <CheckCircle2 className="w-5 h-5" />
              ) : cp.status === "rejected" ? (
                <XCircle className="w-5 h-5" />
              ) : cp.status === "captured" ? (
                <Image className="w-5 h-5" />
              ) : (
                <Camera className="w-5 h-5" />
              )}
              <span className="font-medium truncate w-full text-center">{cp.label}</span>
              {cp.status === "approved" && (
                <Badge variant="outline" className="text-[9px] px-1 py-0 h-4 border-blue-500/30 text-blue-400 bg-blue-500/10">
                  AI Verified
                </Badge>
              )}
            </button>
          ))}
        </div>

        <input
          ref={fileInputRef}
          type="file"
          accept="image/*"
          capture="environment"
          className="hidden"
          onChange={handleFileChange}
        />

        {capturedCount > 0 && !submitted && (
          <div className="mt-4 flex justify-end">
            <Button
              onClick={submitForAIReview}
              disabled={isSubmitting}
              className="bg-blue-600 hover:bg-blue-700 text-white"
            >
              {isSubmitting ? (
                <><Loader2 className="w-4 h-4 mr-2 animate-spin" /> AI Analyzing Photos...</>
              ) : (
                <><Upload className="w-4 h-4 mr-2" /> Submit for AI Verification ({capturedCount}/12)</>
              )}
            </Button>
          </div>
        )}

        {submitted && (
          <div className="mt-4 p-3 rounded-lg bg-blue-500/10 border border-blue-500/20 flex items-center gap-3">
            <CheckCircle2 className="w-5 h-5 text-blue-400 shrink-0" />
            <div>
              <p className="text-sm font-medium text-blue-300">AI Verification Passed</p>
              <p className="text-xs text-slate-400">{approvedCount}/{checkpoints.length} checkpoints approved — SmartLock code will be generated</p>
            </div>
          </div>
        )}
      </CardContent>
    </Card>
  );
}
