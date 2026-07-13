"use client";

import { t } from"i18next";
import { useTranslation } from"react-i18next";
import { useState } from"react";
import { PageShell } from"../../client/layout/PageShell";
import { Button } from"@/components/ui/button";
import { Badge } from"@/components/ui/badge";
import { Input } from"@/components/ui/input";
import { Label } from"@/components/ui/label";
import { Textarea } from"@/components/ui/textarea";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from"@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter, DialogDescription } from"@/components/ui/dialog";
import { useToast } from"@/hooks/use-toast";
import { Brain, Sparkles, Zap, RefreshCw, Play, Pause, Edit, Trash2, MoreHorizontal, Bot, Eye } from"lucide-react";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from"@/components/ui/dropdown-menu";
import { useQuery } from"@tanstack/react-query";
import { aiApi } from"@/lib/api/ai";

// ─── AI Studio ────────────────────────────────────────────────────────────────
export function AIStudio() {
 const {
 t
 } = useTranslation();
 const {
 toast
 } = useToast();
 const [prompt, setPrompt] = useState("");
 const [result, setResult] = useState("");
 const [loading, setLoading] = useState(false);
 const [mode, setMode] = useState("property-description");
 const MODES = [{
 value:"property-description",
 label: t("admin_ai_property_description"),
 icon:"🏡"
 }, {
 value:"email-template",
 label: t("admin_ai_email_template"),
 icon:"✉️"
 }, {
 value:"market-analysis",
 label: t("admin_ai_market_analysis"),
 icon:"📊"
 }, {
 value:"negotiation-script",
 label: t("admin_ai_negotiation_script"),
 icon:"🤝"
 }, {
 value:"listing-title",
 label: t("admin_ai_listing_title"),
 icon:"✏️"
 }];
 const handleGenerate = async () => {
 if (!prompt.trim()) return;
 setLoading(true);
 await new Promise(r => setTimeout(r, 1800));
 const samples: Record<string, string> = {"property-description":"Welcome to this stunning modern villa nestled in the heart of Los Angeles. Boasting 4 bedrooms and 3 bathrooms across 2,800 sq ft of thoughtfully designed living space, this property effortlessly blends contemporary aesthetics with functional comfort. The open-plan kitchen and living area flow seamlessly to a private garden—perfect for entertaining. The master suite features a spa-like en-suite and walk-in wardrobe.","email-template":"Subject: Exciting News About Your Property Search\n\nDear [Name],\n\nI hope this message finds you well. I wanted to reach out personally with some exciting listings that I believe match your criteria perfectly. Based on our conversation, I've identified 3 properties that tick all your boxes—great schools, spacious layout, and within your budget.\n\nI'd love to schedule a viewing at your convenience. Would Thursday or Friday work for you?\n\nWarm regards,\n[Agent Name]","market-analysis":"Current Market Analysis — Q1 2025\n\nThe local real estate market continues to show resilience with median prices up 4.2% YoY. Days on market have decreased from 28 to 19, indicating strong buyer demand. Inventory remains tight at 1.8 months supply. Premium areas such as Sunset Hills and Riverside Drive are seeing above-asking-price offers in 67% of transactions."
 };
 setResult(samples[mode] || `Generated AI content for: ${prompt}`);
 setLoading(false);
 toast({
 title: t("admin_ai_content_generated")
 });
 };
 return <div className="p-6 space-y-6">
 <div>
 <h1 className="text-2xl font-bold">{t("admin_ai_ai_studio")}</h1>
 <p className="text-sm text-muted-foreground mt-0.5">{t("admin_ai_generate_property_content_emails")}</p>
 </div>

 {/* Stats */}
 <div className="grid grid-cols-2 sm:grid-cols-4 gap-4">
 {[{
 label: t("admin_ai_descriptions_generated"),
 value:"1,248"
 }, {
 label: t("admin_ai_emails_drafted"),
 value:"386"
 }, {
 label: t("admin_ai_analyses_run"),
 value:"94"
 }, {
 label: t("admin_ai_time_saved"),
 value:"~62h"
 }].map(s => <div key={s.label} className="bg-card border border-border rounded-xl p-4">
 <p className="text-xs text-muted-foreground">{s.label}</p>
 <p className="text-2xl font-bold mt-1">{s.value}</p>
 </div>)}
 </div>

 <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
 {/* Input panel */}
 <div className="bg-card border border-border rounded-xl p-5 space-y-4">
 <h2 className="font-semibold flex items-center gap-2"><Sparkles className="w-4 h-4 text-primary" />{t("admin_ai_generate_content")}</h2>
 <div className="space-y-1.5">
 <Label>{t("admin_ai_mode")}</Label>
 <div className="grid grid-cols-2 gap-2">
 {MODES.map(m => <button key={m.value} onClick={() => setMode(m.value)} className={`p-2.5 rounded-lg border text-left text-sm transition-colors ${mode === m.value ?"border-primary bg-primary/5 text-primary" :"border-border hover:bg-muted/40"}`}>
 <span className="mr-1.5">{m.icon}</span>{m.label}
 </button>)}
 </div>
 </div>
 <div className="space-y-1.5">
 <Label>{t("admin_ai_your_input")}</Label>
 <Textarea value={prompt} onChange={e => setPrompt(e.target.value)} rows={5} placeholder={mode ==="property-description" ?"4BR, 3BA villa in LA, modern kitchen, private pool, 2800 sqft, listed at $850K..." :"Describe what you need..."} />
 </div>
 <Button onClick={handleGenerate} disabled={loading || !prompt.trim()} className="w-full">
 {loading ? <><RefreshCw className="w-4 h-4 mr-2 animate-spin" />{t("admin_ai_generating")}</> : <><Sparkles className="w-4 h-4 mr-2" />{t("admin_ai_generate")}</>}
 </Button>
 </div>

 {/* Output panel */}
 <div className="bg-card border border-border rounded-xl p-5 space-y-4">
 <div className="flex items-center justify-between">
 <h2 className="font-semibold flex items-center gap-2"><Bot className="w-4 h-4 text-primary" />{t("admin_ai_output")}</h2>
 {result && <Button variant="outline" size="sm" onClick={() => {
 navigator.clipboard?.writeText(result);
 toast({
 title: t("admin_ai_copied")
 });
 }}>{t("admin_ai_copy")}</Button>}
 </div>
 {result ? <div className="bg-muted/30 rounded-lg p-4 text-sm leading-relaxed whitespace-pre-wrap min-h-[200px]">{result}</div> : <div className="min-h-[200px] flex flex-col items-center justify-center text-muted-foreground gap-3">
 <Brain className="w-10 h-10 opacity-30" />
 <p className="text-sm">{t("admin_ai_generated_content_will_appear")}</p>
 </div>}
 </div>
 </div>
 </div>;
}

// ─── AI Valuation ─────────────────────────────────────────────────────────────
interface Valuation {
 id: string;
 propertyName: string;
 address: string;
 estimatedValue: number;
 confidence: number;
 comparables: number;
 lastRun: string;
 trend:"UP" |"DOWN" |"STABLE";
}
const MOCK_VALUATIONS: Valuation[] = [{
 id:"1",
 propertyName:"Sunset Villa",
 address:"12 Sunset Blvd, LA",
 estimatedValue: 895000,
 confidence: 0.91,
 comparables: 12,
 lastRun:"2025-01-10 08:00",
 trend:"UP"
}, {
 id:"2",
 propertyName:"Ocean View Apt",
 address:"88 Ocean Ave, Miami",
 estimatedValue: 438000,
 confidence: 0.87,
 comparables: 9,
 lastRun:"2025-01-10 08:00",
 trend:"STABLE"
}, {
 id:"3",
 propertyName:"Mountain Cabin",
 address:"5 Pine Trail, Aspen",
 estimatedValue: 271000,
 confidence: 0.75,
 comparables: 5,
 lastRun:"2025-01-09 20:00",
 trend:"DOWN"
}];
export function AIValuation() {
 const {
 t
 } = useTranslation();
 const {
 toast
 } = useToast();
 const [running, setRunning] = useState(false);
 const [detailOpen, setDetailOpen] = useState(false);
 const [selected, setSelected] = useState<Valuation | null>(null);

 const { data: valuationsData, refetch } = useQuery({
 queryKey: ['aiPropertyValuations'],
 queryFn: async () => {
 const res = await aiApi.getPropertyValuations();
 const apiVals = Array.isArray(res) ? res : ((res as any).data || []);
 
 return apiVals.map((v: any) => ({
 id: v.id,
 propertyName: v.propertyName || `Property ${v.propertyId?.slice(0,6) ||"Unknown"}`,
 address: v.address || v.marketData?.address ||"Unknown Address",
 estimatedValue: v.estimatedValue || 0,
 confidence: v.confidence || 0.85,
 comparables: v.factors?.comparablesCount || 5,
 lastRun: v.updatedAt ? new Date(v.updatedAt).toLocaleString() : new Date().toLocaleString(),
 trend: v.factors?.trend ||"STABLE"
 })) as Valuation[];
 }
 });

 const valuations = valuationsData && valuationsData.length > 0 ? valuationsData : MOCK_VALUATIONS;

 const handleRunAll = async () => {
 setRunning(true);
 await new Promise(r => setTimeout(r, 2000));
 refetch();
 setRunning(false);
 toast({
 title: t("admin_ai_valuations_updated"),
 description: t("admin_ai_all_properties_revalued")
 });
 };
 const TREND_STYLES = {
 UP:"text-green-600",
 DOWN:"text-red-600",
 STABLE:"text-muted-foreground"
 };
 const TREND_ICONS = {
 UP:"↑",
 DOWN:"↓",
 STABLE:"→"
 };
 return <>
 <PageShell title={t("admin_ai_ai_property_valuation")} description={t("admin_ai_automated_property_value_estimates")} actions={<Button onClick={handleRunAll} disabled={running} size="sm">
 <RefreshCw className={`w-4 h-4 mr-1.5 ${running ?"animate-spin" :""}`} />
 {running ?"Running..." :"Run All Valuations"}
 </Button>} stats={[{
 label: t("admin_ai_valued_properties"),
 value: valuations.length
 }, {
 label: t("admin_ai_avg_confidence"),
 value: `${Math.round(valuations.reduce((s, v) => s + v.confidence, 0) / (valuations.length || 1) * 100)}%`
 }, {
 label: t("admin_ai_trending_up"),
 value: valuations.filter(v => v.trend ==="UP").length
 }, {
 label: t("admin_ai_total_portfolio_value"),
 value: `$${(valuations.reduce((s, v) => s + v.estimatedValue, 0) / 1e6).toFixed(2)}M`
 }]}>
 <div className="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-4">
 {valuations.map(v => <div key={v.id} className="bg-card border border-border rounded-xl p-5 space-y-4">
 <div>
 <p className="font-semibold">{v.propertyName}</p>
 <p className="text-xs text-muted-foreground">{v.address}</p>
 </div>
 <div className="flex items-end justify-between">
 <div>
 <p className="text-3xl font-bold">${(v.estimatedValue / 1000).toFixed(0)}K</p>
 <p className={`text-sm font-medium ${TREND_STYLES[v.trend]}`}>{TREND_ICONS[v.trend]} {v.trend}</p>
 </div>
 <div className="text-right text-sm text-muted-foreground">
 <p>{v.comparables}{t("admin_ai_comparables")}</p>
 <p className="text-xs">{t("admin_ai_updated")}{v.lastRun.split("")[0]}</p>
 </div>
 </div>
 <div>
 <div className="flex justify-between text-xs mb-1"><span className="text-muted-foreground">{t("admin_ai_confidence")}</span><span>{Math.round(v.confidence * 100)}%</span></div>
 <div className="h-1.5 bg-muted rounded-full overflow-hidden"><div className="h-full bg-primary rounded-full" style={{
 width: `${v.confidence * 100}%`
 }} /></div>
 </div>
 <Button variant="outline" size="sm" className="w-full" onClick={() => {
 setSelected(v);
 setDetailOpen(true);
 }}>
 <Eye className="w-3.5 h-3.5 mr-1.5" />{t("admin_ai_view_comparables")}</Button>
 </div>)}
 </div>
 </PageShell>
 <Dialog open={detailOpen} onOpenChange={setDetailOpen}>
 <DialogContent className="sm:max-w-md">
 <DialogHeader><DialogTitle>{t("admin_ai_valuation_detail")}{selected?.propertyName}</DialogTitle></DialogHeader>
 {selected && <div className="space-y-4 py-2">
 <div className="text-center py-4 bg-muted/30 rounded-xl">
 <p className="text-xl font-bold">${selected.estimatedValue.toLocaleString()}</p>
 <p className="text-sm text-muted-foreground mt-1">{t("admin_ai_estimated_market_value")}</p>
 </div>
 <div className="grid grid-cols-2 gap-3 text-sm">
 <div><p className="text-xs text-muted-foreground">{t("admin_ai_confidence")}</p><p className="font-semibold">{Math.round(selected.confidence * 100)}%</p></div>
 <div><p className="text-xs text-muted-foreground">{t("admin_ai_comparables_used")}</p><p className="font-semibold">{selected.comparables}</p></div>
 <div><p className="text-xs text-muted-foreground">{t("admin_ai_price_trend")}</p><p className={`font-semibold ${TREND_STYLES[selected.trend]}`}>{TREND_ICONS[selected.trend]} {selected.trend}</p></div>
 <div><p className="text-xs text-muted-foreground">{t("admin_ai_last_updated")}</p><p className="font-semibold text-xs">{selected.lastRun}</p></div>
 </div>
 <div className="text-xs text-muted-foreground bg-muted/30 p-3 rounded-lg">{t("admin_ai_value_estimate_based_on")}{selected.comparables}{t("admin_ai_comparable_properties_sold_within")}</div>
 </div>}
 </DialogContent>
 </Dialog>
 </>;
}

// ─── Automation Rules ─────────────────────────────────────────────────────────
interface AutoRule {
 id: string;
 name: string;
 trigger: string;
 action: string;
 isActive: boolean;
 runCount: number;
 lastRun?: string;
}
const MOCK_RULES: AutoRule[] = [{
 id:"1",
 name:"New Lead → Send Welcome Email",
 trigger:"Lead Created",
 action:"Send Email Template",
 isActive: true,
 runCount: 142,
 lastRun:"2025-01-10 08:45"
}, {
 id:"2",
 name:"Lease Expiring → Renewal Notice",
 trigger:"Lease Expires in 60 days",
 action:"Send Renewal Email + Create Task",
 isActive: true,
 runCount: 18,
 lastRun:"2025-01-09 09:00"
}, {
 id:"3",
 name:"Payment Overdue → Alert Agent",
 trigger:"Payment Overdue 7 days",
 action:"Notify Agent + Create Task",
 isActive: true,
 runCount: 31,
 lastRun:"2025-01-08 10:00"
}, {
 id:"4",
 name:"Hot Lead Score → Assign Agent",
 trigger:"Lead Score > 80",
 action:"Assign to Top Agent",
 isActive: false,
 runCount: 8
}];
export function Automation() {
 const {
 t
 } = useTranslation();
 const {
 toast
 } = useToast();
 const [createOpen, setCreateOpen] = useState(false);
 const [form, setForm] = useState({
 name:"",
 trigger:"",
 action:"",
 isActive: true
 });
 const handleToggle = (r: AutoRule) => toast({
 title: r.isActive ?"Rule Disabled" :"Rule Enabled",
 description: r.name
 });
 const handleCreate = (e: React.FormEvent) => {
 e.preventDefault();
 setCreateOpen(false);
 toast({
 title: t("admin_ai_rule_created")
 });
 };
 return <>
 <PageShell title={t("admin_ai_automation_rules")} description={t("admin_ai_triggerbased_workflows_that_run")} createLabel={t("admin_ai_new_rule","Yeni Kural")} onCreateClick={() => setCreateOpen(true)} stats={[{
 label: t("admin_ai_total_rules"),
 value: MOCK_RULES.length
 }, {
 label: t("admin_ai_active"),
 value: MOCK_RULES.filter(r => r.isActive).length
 }, {
 label: t("admin_ai_total_runs"),
 value: MOCK_RULES.reduce((s, r) => s + r.runCount, 0)
 }, {
 label: t("admin_ai_this_month"),
 value: 42
 }]}>
 <div className="space-y-3">
 {MOCK_RULES.map(rule => <div key={rule.id} className={`bg-card border rounded-xl p-4 flex items-center gap-4 ${rule.isActive ?"border-border" :"border-border opacity-60"}`}>
 <div className={`w-10 h-10 rounded-lg flex items-center justify-center shrink-0 ${rule.isActive ?"bg-primary/10" :"bg-muted"}`}>
 <Zap className={`w-5 h-5 ${rule.isActive ?"text-primary" :"text-muted-foreground"}`} />
 </div>
 <div className="flex-1 min-w-0">
 <div className="flex items-center gap-2">
 <p className="font-medium text-sm">{rule.name}</p>
 {rule.isActive ? <Badge className="bg-green-100 text-green-700 border-0 text-xs">{t("admin_ai_active")}</Badge> : <Badge className="bg-card text-muted-foreground border-0 text-xs">{t("admin_ai_inactive")}</Badge>}
 </div>
 <div className="flex items-center gap-3 mt-1 text-xs text-muted-foreground">
 <span>{t("admin_ai_trigger")}<strong className="text-foreground">{rule.trigger}</strong></span>
 <span>→</span>
 <span>{t("admin_ai_action")}<strong className="text-foreground">{rule.action}</strong></span>
 </div>
 <div className="flex items-center gap-3 mt-1 text-xs text-muted-foreground">
 <span>{t("admin_ai_ran")}{rule.runCount}{t("admin_ai_times")}</span>
 {rule.lastRun && <span>{t("admin_ai_last")}{rule.lastRun}</span>}
 </div>
 </div>
 <div className="flex items-center gap-2 shrink-0">
 <Button variant="outline" size="sm" onClick={() => handleToggle(rule)}>
 {rule.isActive ? <Pause className="w-3.5 h-3.5 mr-1" /> : <Play className="w-3.5 h-3.5 mr-1" />}
 {rule.isActive ?"Pause" :"Enable"}
 </Button>
 <DropdownMenu>
 <DropdownMenuTrigger asChild><Button variant="ghost" size="icon" className="h-8 w-8"><MoreHorizontal className="w-4 h-4" /></Button></DropdownMenuTrigger>
 <DropdownMenuContent align="end">
 <DropdownMenuItem><Edit className="w-4 h-4 mr-2" />{t("admin_ai_edit")}</DropdownMenuItem>
 <DropdownMenuItem className="text-destructive"><Trash2 className="w-4 h-4 mr-2" />{t("admin_ai_delete")}</DropdownMenuItem>
 </DropdownMenuContent>
 </DropdownMenu>
 </div>
 </div>)}
 </div>
 </PageShell>
 <Dialog open={createOpen} onOpenChange={setCreateOpen}>
 <DialogContent className="sm:max-w-md">
 <DialogHeader><DialogTitle>{t("admin_ai_new_automation_rule")}</DialogTitle><DialogDescription>{t("admin_ai_define_a_trigger_and")}</DialogDescription></DialogHeader>
 <form onSubmit={handleCreate} className="space-y-4 py-2">
 <div className="space-y-1.5"><Label>{t("admin_ai_rule_name")}</Label><Input value={form.name} onChange={e => setForm({
 ...form,
 name: e.target.value
 })} required /></div>
 <div className="space-y-1.5"><Label>{t("admin_ai_trigger")}</Label>
 <Select value={form.trigger} onValueChange={v => setForm({
 ...form,
 trigger: v
 })}>
 <SelectTrigger><SelectValue placeholder={t("admin_ai_when_this_happens")} /></SelectTrigger>
 <SelectContent>
 <SelectItem value="lead-created">{t("admin_ai_lead_created")}</SelectItem>
 <SelectItem value="lease-expiring">{t("admin_ai_lease_expiring")}</SelectItem>
 <SelectItem value="payment-overdue">{t("admin_ai_payment_overdue")}</SelectItem>
 <SelectItem value="lead-score-high">{t("admin_ai_lead_score")}{'>'} 80</SelectItem>
 <SelectItem value="booking-confirmed">{t("admin_ai_booking_confirmed")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 <div className="space-y-1.5"><Label>{t("admin_ai_action")}</Label>
 <Select value={form.action} onValueChange={v => setForm({
 ...form,
 action: v
 })}>
 <SelectTrigger><SelectValue placeholder={t("admin_ai_then_do_this")} /></SelectTrigger>
 <SelectContent>
 <SelectItem value="send-email">{t("admin_ai_send_email")}</SelectItem>
 <SelectItem value="create-task">{t("admin_ai_create_task")}</SelectItem>
 <SelectItem value="notify-agent">{t("admin_ai_notify_agent")}</SelectItem>
 <SelectItem value="assign-lead">{t("admin_ai_assign_lead")}</SelectItem>
 <SelectItem value="send-sms">{t("admin_ai_send_sms")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 <label className="flex items-center gap-2 cursor-pointer">
 <input type="checkbox" checked={form.isActive} onChange={e => setForm({
 ...form,
 isActive: e.target.checked
 })} className="w-4 h-4 rounded-lg" />
 <span className="text-sm">{t("admin_ai_activate_immediately")}</span>
 </label>
 <DialogFooter><Button type="submit">{t("admin_ai_create_rule")}</Button></DialogFooter>
 </form>
 </DialogContent>
 </Dialog>
 </>;
}