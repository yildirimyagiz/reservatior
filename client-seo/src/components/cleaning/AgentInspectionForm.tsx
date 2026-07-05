"use client";

import { useState, useEffect } from "react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Textarea } from "@/components/ui/textarea";
import { MapPin, Crosshair, CheckCircle2, XCircle, AlertTriangle, Star } from "lucide-react";
import { cn } from "@/lib/utils";

interface InspectionItem {
  id: string;
  label: string;
  result: "pass" | "fail" | null;
  notes: string;
}

const DEFAULT_ITEMS: InspectionItem[] = [
  { id: "general_clean", label: "General Cleanliness", result: null, notes: "" },
  { id: "linens", label: "Linens & Towels Freshness", result: null, notes: "" },
  { id: "surfaces", label: "Surfaces Dust-Free", result: null, notes: "" },
  { id: "floors", label: "Floors Mopped/Vacuumed", result: null, notes: "" },
  { id: "bathroom", label: "Bathroom Sanitized", result: null, notes: "" },
  { id: "kitchen", label: "Kitchen Clean & Stocked", result: null, notes: "" },
  { id: "smell", label: "No Odors", result: null, notes: "" },
  { id: "trash", label: "Trash Removed", result: null, notes: "" },
];

interface AgentInspectionFormProps {
  propertyName?: string;
  className?: string;
  onComplete?: (score: number) => void;
}

export function AgentInspectionForm({ propertyName, className, onComplete }: AgentInspectionFormProps) {
  const [items, setItems] = useState(DEFAULT_ITEMS);
  const [gpsStatus, setGpsStatus] = useState<"idle" | "acquiring" | "acquired" | "failed">("idle");
  const [location, setLocation] = useState<{ lat: number; lng: number } | null>(null);
  const [submitted, setSubmitted] = useState(false);

  useEffect(() => {
    if (gpsStatus === "acquiring") {
      navigator.geolocation.getCurrentPosition(
        pos => {
          setLocation({ lat: pos.coords.latitude, lng: pos.coords.longitude });
          setGpsStatus("acquired");
        },
        () => setGpsStatus("failed"),
        { enableHighAccuracy: true, timeout: 10000 }
      );
    }
  }, [gpsStatus]);

  const setResult = (id: string, result: "pass" | "fail") => {
    setItems(prev => prev.map(i => i.id === id ? { ...i, result } : i));
  };

  const setNotes = (id: string, notes: string) => {
    setItems(prev => prev.map(i => i.id === id ? { ...i, notes } : i));
  };

  const allInspected = items.every(i => i.result !== null);
  const passCount = items.filter(i => i.result === "pass").length;
  const score = items.length > 0 ? Math.round((passCount / items.length) * 100) : 0;

  const handleSubmit = () => {
    setSubmitted(true);
    onComplete?.(score);
  };

  return (
    <Card className={cn("bg-slate-900/50 border-slate-800", className)}>
      <CardHeader>
        <div className="flex items-center justify-between">
          <div>
            <CardTitle className="text-slate-100 text-base flex items-center gap-2">
              <Crosshair className="w-4 h-4 text-cyan-500" />
              Agent Inspection Checklist
            </CardTitle>
            <CardDescription className="text-slate-400 text-xs mt-1">
              {propertyName ? `${propertyName} · ` : ""}GPS-verified quality spot check
            </CardDescription>
          </div>
          <div className="flex items-center gap-2">
            <Badge
              variant="outline"
              className={cn(
                "text-xs",
                gpsStatus === "acquired" ? "border-emerald-500/30 text-emerald-400" :
                gpsStatus === "failed" ? "border-red-500/30 text-red-400" :
                "border-slate-600 text-slate-400"
              )}
            >
              <MapPin className="w-3 h-3 mr-1" />
              {gpsStatus === "acquired" ? "GPS Verified" :
               gpsStatus === "acquiring" ? "Locating..." :
               gpsStatus === "failed" ? "GPS Failed" : "No GPS"}
            </Badge>
            {score > 0 && !submitted && (
              <Badge variant="outline" className="border-purple-500/30 text-purple-400">
                <Star className="w-3 h-3 mr-1" />
                {score}/100
              </Badge>
            )}
          </div>
        </div>
      </CardHeader>
      <CardContent>
        {gpsStatus === "idle" && (
          <div className="mb-4 p-3 rounded-lg bg-cyan-500/5 border border-cyan-500/20">
            <p className="text-xs text-cyan-400 mb-2">GPS verification required before inspection</p>
            <Button
              variant="outline"
              size="sm"
              className="border-cyan-700 text-cyan-300"
              onClick={() => setGpsStatus("acquiring")}
            >
              <MapPin className="w-3.5 h-3.5 mr-2" />
              Verify Location
            </Button>
          </div>
        )}

        <div className="space-y-2">
          {items.map(item => (
            <div
              key={item.id}
              className={cn(
                "flex items-center gap-3 p-2 rounded-lg border transition-colors",
                item.result === "pass" ? "bg-emerald-500/5 border-emerald-500/20" :
                item.result === "fail" ? "bg-red-500/5 border-red-500/20" :
                "bg-slate-900/30 border-slate-800"
              )}
            >
              <div className="flex-1 min-w-0">
                <p className={cn(
                  "text-sm font-medium",
                  item.result === "pass" ? "text-emerald-300" :
                  item.result === "fail" ? "text-red-300" : "text-slate-300"
                )}>
                  {item.label}
                </p>
                <input
                  type="text"
                  placeholder="Notes (optional)"
                  value={item.notes}
                  onChange={e => setNotes(item.id, e.target.value)}
                  className="mt-1 w-full bg-transparent text-xs text-slate-500 border-0 border-b border-slate-800 focus:border-slate-600 focus:outline-none pb-0.5"
                />
              </div>
              <div className="flex gap-1 shrink-0">
                <button
                  onClick={() => !submitted && setResult(item.id, "pass")}
                  disabled={submitted || gpsStatus !== "acquired"}
                  className={cn(
                    "w-8 h-8 rounded-lg flex items-center justify-center transition-colors",
                    item.result === "pass" ? "bg-emerald-500/20 text-emerald-400" : "bg-slate-800 text-slate-500 hover:bg-emerald-500/10 hover:text-emerald-400"
                  )}
                >
                  <CheckCircle2 className="w-4 h-4" />
                </button>
                <button
                  onClick={() => !submitted && setResult(item.id, "fail")}
                  disabled={submitted || gpsStatus !== "acquired"}
                  className={cn(
                    "w-8 h-8 rounded-lg flex items-center justify-center transition-colors",
                    item.result === "fail" ? "bg-red-500/20 text-red-400" : "bg-slate-800 text-slate-500 hover:bg-red-500/10 hover:text-red-400"
                  )}
                >
                  <XCircle className="w-4 h-4" />
                </button>
              </div>
            </div>
          ))}
        </div>

        {location && (
          <div className="mt-3 flex items-center gap-2 text-xs text-slate-500">
            <MapPin className="w-3 h-3" />
            <span className="font-mono">{location.lat.toFixed(6)}, {location.lng.toFixed(6)}</span>
            <Badge variant="outline" className="text-[9px] border-emerald-500/20 text-emerald-500">Geofenced</Badge>
          </div>
        )}

        {allInspected && !submitted && gpsStatus === "acquired" && (
          <div className="mt-4 flex justify-between items-center">
            <div className="text-sm text-slate-400">
              Score: <span className="text-emerald-400 font-bold">{score}/100</span>
            </div>
            <Button onClick={handleSubmit} className="bg-cyan-600 hover:bg-cyan-700 text-white">
              <CheckCircle2 className="w-4 h-4 mr-2" />
              Submit Inspection Report
            </Button>
          </div>
        )}

        {submitted && (
          <div className="mt-4 p-3 rounded-lg bg-emerald-500/10 border border-emerald-500/20">
            <div className="flex items-center gap-3">
              <CheckCircle2 className="w-5 h-5 text-emerald-400 shrink-0" />
              <div>
                <p className="text-sm font-medium text-emerald-300">Inspection Submitted</p>
                <p className="text-xs text-slate-400">
                  Score: {score}/100 · {passCount}/{items.length} passed · GPS at {location?.lat.toFixed(4)}, {location?.lng.toFixed(4)}
                </p>
              </div>
            </div>
          </div>
        )}
      </CardContent>
    </Card>
  );
}
