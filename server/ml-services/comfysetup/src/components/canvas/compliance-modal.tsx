'use client';

import { useState, useMemo } from "react";
import {
    Dialog,
    DialogContent,
    DialogHeader,
    DialogTitle,
    DialogDescription,
} from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { Toggle } from "@/components/ui/toggle";
import { CopyBlock } from "@/components/ui/copy-button";
import { useCanvasStore } from "@/lib/store/canvas-store";
import { CheckCircle2, Circle, ShieldCheck, Download, AlertTriangle } from "lucide-react";
import { cn } from "@/lib/utils";
import { toast } from "sonner";
import { Select } from "@/components/ui/select";
import { Label } from "@/components/ui/label";

interface ComplianceModalProps {
    open: boolean;
    onOpenChange: (open: boolean) => void;
}

type MLSRuleset = 'default' | 'nwmls';

const DEFAULT_CHECKLIST = [
    {
        id: "rights",
        title: "Photo Rights & Usage",
        description: "Ensure you have licensing or written permission to use all images."
    },
    {
        id: "disclosure",
        title: "Disclosure & Labeling",
        description: "Mark image as 'Virtually Staged' and include disclosure in remarks."
    },
    {
        id: "original",
        title: "Provide Original Photos",
        description: "Include unedited photos adjacent to staged versions where required."
    },
    {
        id: "representation",
        title: "Preserve True Representation",
        description: "Do not alter structural elements or hide defects."
    },
    {
        id: "no-branding",
        title: "Avoid Branding / Logos",
        description: "Remove agent/broker logos or contact info from staged photos."
    }
];

const NWMLS_CHECKLIST = [
    {
        id: "rights",
        title: "Photo Rights & Usage",
        description: "Ensure you have licensing or written permission to use all images."
    },
    {
        id: "no-text",
        title: "No Text or Graphics",
        description: "NWMLS prohibits any superimposed text, graphics, or watermarks on photos."
    },
    {
        id: "disclosure-remarks",
        title: "Remarks Disclosure",
        description: "Disclosure must be included in the listing remarks section."
    },
    {
        id: "no-entities",
        title: "No People or Pets",
        description: "Photos must not include people or pets."
    },
    {
        id: "representation",
        title: "True Property Picture",
        description: "Do not alter structural elements, add new features, or hide defects."
    }
];

const DEFAULT_DISCLOSURE = "One or more photos were virtually staged; no structural changes portrayed.";
const NWMLS_DISCLOSURE = "Select photos are virtually staged; no structural changes portrayed.";

export function ComplianceModal({ open, onOpenChange }: ComplianceModalProps) {
    const { watermarkEnabled, setWatermarkEnabled, roomImage } = useCanvasStore();

    // MLS Ruleset state
    const [ruleset, setRuleset] = useState<MLSRuleset>('default');

    // Checklist state
    const [checkedItems, setCheckedItems] = useState<Record<string, boolean>>({});

    const checklist = ruleset === 'nwmls' ? NWMLS_CHECKLIST : DEFAULT_CHECKLIST;
    const disclosureText = ruleset === 'nwmls' ? NWMLS_DISCLOSURE : DEFAULT_DISCLOSURE;

    const toggleCheck = (id: string) => {
        setCheckedItems(prev => ({
            ...prev,
            [id]: !prev[id]
        }));
    };

    const allChecked = useMemo(() => {
        return checklist.every(item => checkedItems[item.id]);
    }, [checklist, checkedItems]);

    const handleDownloadOriginal = () => {
        if (!roomImage) {
            toast.error("No original image available");
            return;
        }
        const link = document.createElement('a');
        link.download = `original-room-${Date.now()}.png`;
        link.href = roomImage;
        link.click();
        toast.success("Original photo downloaded");
    };

    // When ruleset changes, we might want to clear checks or force watermark off for NWMLS
    const handleRulesetChange = (val: string) => {
        const nextRuleset = val as MLSRuleset;
        setRuleset(nextRuleset);
        setCheckedItems({}); // Reset checklist when switching rulesets

        if (nextRuleset === 'nwmls') {
            setWatermarkEnabled(false);
        }
    };

    return (
        <Dialog open={open} onOpenChange={onOpenChange}>
            <DialogContent className="max-w-2xl bg-slate-900 border-slate-800 text-white max-h-[90vh] overflow-y-auto">
                <DialogHeader>
                    <div className="flex items-center gap-2">
                        <ShieldCheck className="w-6 h-6 text-emerald-500" />
                        <DialogTitle>Compliance & Rules</DialogTitle>
                    </div>
                    <DialogDescription className="text-slate-400">
                        Select your MLS to ensure compliance with local rules.
                    </DialogDescription>
                </DialogHeader>

                <div className="space-y-6 mt-4">
                    {/* Ruleset Selector */}
                    <div className="space-y-2">
                        <Label className="text-xs text-slate-400 uppercase tracking-wider">Select MLS Region</Label>
                        <Select
                            value={ruleset}
                            onChange={handleRulesetChange}
                            options={[
                                { value: 'default', label: 'Standard / International' },
                                { value: 'nwmls', label: 'NWMLS (Northwest MLS)' },
                            ]}
                            className="bg-slate-950 border-slate-800"
                        />
                    </div>

                    {/* Watermark Section */}
                    <div className={cn(
                        "space-y-4 p-5 rounded-lg border transition-all",
                        ruleset === 'nwmls'
                            ? "bg-amber-500/5 border-amber-500/20 opacity-80"
                            : "bg-slate-950/50 border-slate-800"
                    )}>
                        <div className="flex items-center justify-between">
                            <div className="flex-1 pr-4">
                                <h3 className="text-sm font-semibold text-white/90">Visible Watermark</h3>
                                <p className="text-xs text-slate-400 mt-1">
                                    {ruleset === 'nwmls'
                                        ? "Prohibited by NWMLS. Text/Graphics are not allowed on photos."
                                        : "Overlay 'Virtually Staged' on the bottom right of the image."
                                    }
                                </p>
                            </div>
                            <Toggle
                                checked={watermarkEnabled}
                                onChange={setWatermarkEnabled}
                                className="scale-90"
                                disabled={ruleset === 'nwmls'}
                            />
                        </div>
                        {ruleset === 'nwmls' && (
                            <div className="mt-2 flex items-center gap-2 text-[10px] text-amber-500/80 bg-amber-500/10 px-2 py-1 rounded">
                                <AlertTriangle className="w-3 h-3" />
                                <span>NWMLS Rules: No text, graphics, or watermarks allowed on listing photos.</span>
                            </div>
                        )}
                    </div>

                    {/* Disclosure Text */}
                    <div className="space-y-2">
                        <h3 className="text-sm font-semibold text-white/90 px-1">Required Disclosure</h3>
                        <p className="text-xs text-slate-500 px-1 mb-2">
                            {ruleset === 'nwmls'
                                ? "Include this text in the 'Public Remarks' or 'Agent Remarks' section."
                                : "Copy this text for listing remarks or captions."
                            }
                        </p>
                        <CopyBlock
                            text={disclosureText}
                            label="Listing Remarks Disclosure"
                            className="text-white"
                        />
                    </div>

                    {/* Compliance Checklist */}
                    <div className="space-y-3">
                        <div className="flex items-center justify-between px-1">
                            <h3 className="text-sm font-semibold text-white/90">Rule Verification</h3>
                            <span className="text-[10px] bg-slate-800 px-2 py-0.5 rounded text-slate-400 uppercase">
                                {ruleset === 'nwmls' ? 'NWMLS ACTIVE' : 'STANDARD'}
                            </span>
                        </div>
                        <div className="space-y-2">
                            {checklist.map(item => {
                                const isChecked = checkedItems[item.id];
                                return (
                                    <div
                                        key={item.id}
                                        onClick={() => toggleCheck(item.id)}
                                        className={cn(
                                            "flex items-start gap-3 p-3 rounded-lg border cursor-pointer transition-all",
                                            isChecked
                                                ? "bg-emerald-500/10 border-emerald-500/30"
                                                : "bg-slate-950 border-slate-800 hover:border-slate-700"
                                        )}
                                    >
                                        <div className={cn(
                                            "mt-0.5 transition-colors",
                                            isChecked ? "text-emerald-500" : "text-slate-600"
                                        )}>
                                            {isChecked ? <CheckCircle2 className="w-5 h-5" /> : <Circle className="w-5 h-5" />}
                                        </div>
                                        <div className="flex-1">
                                            <div className={cn(
                                                "text-sm font-medium transition-colors",
                                                isChecked ? "text-emerald-400" : "text-slate-300"
                                            )}>
                                                {item.title}
                                            </div>
                                            <div className="text-xs text-slate-500 mt-0.5">
                                                {item.description}
                                            </div>
                                        </div>
                                    </div>
                                );
                            })}
                        </div>
                    </div>

                    {/* Original Photo Actions */}
                    <div className="pt-4 border-t border-slate-800 flex flex-col sm:flex-row justify-between items-center gap-4">
                        <button
                            onClick={handleDownloadOriginal}
                            disabled={!roomImage}
                            className="flex items-center gap-2 text-xs text-slate-400 hover:text-white transition-colors disabled:opacity-50"
                        >
                            <Download className="w-3 h-3" />
                            Download Original Reference
                        </button>

                        <div className="flex gap-3 w-full sm:w-auto">
                            <Button
                                className={cn(
                                    "flex-1 sm:flex-none transition-all",
                                    allChecked
                                        ? "bg-emerald-600 hover:bg-emerald-700 text-white"
                                        : "bg-slate-800 text-slate-400"
                                )}
                                onClick={() => onOpenChange(false)}
                            >
                                {allChecked ? "Compliance Verified" : "Close"}
                            </Button>
                        </div>
                    </div>
                </div>
            </DialogContent>
        </Dialog>
    );
}
