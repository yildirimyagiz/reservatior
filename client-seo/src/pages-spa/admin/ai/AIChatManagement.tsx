"use client";

import { t } from"i18next";
import { useTranslation } from"react-i18next";
import { useState, useEffect } from"react";
import { PageShell } from"../../client/layout/PageShell";
import { Button } from"@/components/ui/button";
import { Badge } from"@/components/ui/badge";
import { Input } from"@/components/ui/input";
import { Label } from"@/components/ui/label";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from"@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from"@/components/ui/select";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuLabel, DropdownMenuTrigger } from"@/components/ui/dropdown-menu";
import { MessageSquare, Search, MoreHorizontal, Eye, Activity, User, Bot, Phone } from"lucide-react";
import { useToast } from"@/hooks/use-toast";
import { apiClient } from"@/lib/api/client";
import { useQuery, useMutation, useQueryClient } from"@tanstack/react-query";
import { Card, CardHeader, CardTitle, CardContent } from"@/components/ui/card";
interface AIChatbotSession {
 id: string;
 orgId?: string;
 userId?: string;
 contactId?: string;
 sessionId: string;
 conversationHistory: any;
 intent?: string;
 confidence?: number;
 status: 'ACTIVE' | 'ENDED' | 'TRANSFERRED';
 transferredTo?: string;
 startedAt: string;
 lastActivityAt: string;
 endedAt?: string;
 satisfaction?: number;
 createdAt: string;
 messagesCount?: number;
 handoffsCount?: number;
}
interface AIChatMessage {
 id: string;
 orgId?: string;
 sessionId: string;
 listingId?: string;
 reservationId?: string;
 role: 'USER' | 'ASSISTANT' | 'SYSTEM';
 content: string;
 contentHash?: string;
 redactedContent?: string;
 piiDetected: boolean;
 piiTypes: string[];
 language: string;
 isAI: boolean;
 escalationTag?: string;
 escalationTopic?: string;
 paymentAgreed: boolean;
 paymentPlan?: any;
 securityFlag: boolean;
 securityReason?: string;
 moduleType: string;
 metadata?: any;
 tokenCount?: number;
 processingMs?: number;
 createdAt: string;
}
interface AIChatHandoff {
 id: string;
 orgId?: string;
 sessionId: string;
 handoffReason: string;
 handoffTo: string;
 handoffAt: string;
 resolvedAt?: string;
 resolvedBy?: string;
 notes?: string;
 deletedAt?: string;
}
export default function AIChatManagement() {
 const {
 t
 } = useTranslation();
 const [selectedSession, setSelectedSession] = useState<AIChatbotSession | null>(null);
 const [isSessionDialogOpen, setIsSessionDialogOpen] = useState(false);
 const [searchTerm, setSearchTerm] = useState('');
 const [statusFilter, setStatusFilter] = useState<string>('all');
 const {
 toast
 } = useToast();
 const queryClient = useQueryClient();
 const deleteMutation = useMutation({
 mutationFn: async (id: string) => apiClient.delete(`/unknown/${id}`),
 onSuccess: () => {
 toast({ title:"Deleted", description:"Record deleted successfully" });
 queryClient.invalidateQueries();
 },
 onError: (err: any) => toast({ title:"Error", description: err.message, variant:"destructive" })
 });
 


 // Fetch AI chat sessions
 const {
 data: sessionData,
 isLoading: loadingSessions,
 error: sessionError
 } = useQuery({
 queryKey: ['aiChatbotSessions', searchTerm, statusFilter],
 queryFn: async () => {
 const query: any = {};
 if (searchTerm) query.sessionId = `${searchTerm}*`;
 if (statusFilter !=="all") query.status = statusFilter;
 const data = await apiClient.get<any>("/aichatbot-session", query);
 return data;
 }
 });
 const sessions = Array.isArray(sessionData) ? sessionData : (sessionData?.data || []);

 // Fetch Session details (messages and handoffs)
 const {
 data: detailData,
 isLoading: loadingDetails
 } = useQuery({
 queryKey: ['aiChatbotSessionDetails', selectedSession?.id],
 enabled: !!selectedSession,
 queryFn: async () => {
 const sessionId = selectedSession!.id;
 const [messagesRes, handoffsRes] = await Promise.all([
 apiClient.get<any>("/aichat-message", { sessionId }),
 apiClient.get<any>("/aichat-handoff", { sessionId })
 ]);
 return {
 messages: Array.isArray(messagesRes) ? messagesRes : (messagesRes.data || []),
 handoffs: Array.isArray(handoffsRes) ? handoffsRes : (handoffsRes.data || [])
 };
 }
 });
 const messages = detailData?.messages || [];
 const handoffs = detailData?.handoffs || [];

 // Update session status mutation
 const updateStatusMutation = useMutation({
 mutationFn: async ({
 id,
 status,
 transferredTo
 }: {
 id: string;
 status: string;
 transferredTo?: string;
 }) => {
 const updateData: any = {
 status
 };
 if (status === 'ENDED') updateData.endedAt = new Date().toISOString();
 if (status === 'TRANSFERRED') {
 updateData.transferredTo = transferredTo;
 }
 await apiClient.patch(`/aichatbot-session/${id}`, updateData);
 },
 onSuccess: () => {
 queryClient.invalidateQueries({
 queryKey: ['aiChatbotSessions']
 });
 toast({
 title: t("admin_ai_success"),
 description: t("admin_ai_status_updated_successfully")
 });
 },
 onError: (error: any) => {
 toast({
 title: t("admin_ai_error"),
 description: error.message,
 variant:"destructive"
 });
 }
 });
 const getStatusColor = (status: string) => {
 switch (status) {
 case 'ACTIVE':
 return 'bg-green-500';
 case 'ENDED':
 return 'bg-white/10';
 case 'TRANSFERRED':
 return 'bg-muted0';
 default:
 return 'bg-white/10';
 }
 };
 const getRoleIcon = (role: string) => {
 switch (role) {
 case 'USER':
 return <User className="h-4 w-4" />;
 case 'ASSISTANT':
 return <Bot className="h-4 w-4" />;
 case 'SYSTEM':
 return <Activity className="h-4 w-4" />;
 default:
 return <MessageSquare className="h-4 w-4" />;
 }
 };
 const activeSessionsCount = sessions.filter((s: any) => s.status === 'ACTIVE').length;
 const totalMessagesCount = sessions.reduce((acc: number, s: any) => acc + (s.messagesCount || 0), 0);
 const avgSatisfaction = sessions.filter((s: any) => s.satisfaction !== undefined).reduce((acc: number, s: any, _: any, arr: any[]) => arr.length > 0 ? acc + (s.satisfaction || 0) / arr.length : 0, 0);
 if (loadingSessions) {
 return <PageShell title={t("admin_ai_ai_chat_management")}>
 <div className="flex items-center justify-center h-64">
 <Activity className="h-8 w-8 animate-spin" />
 </div>
 </PageShell>;
 }
 if (sessionError) return <div>{t("admin_ai_error")}{sessionError.message}</div>;
 return <PageShell title={t("admin_ai_ai_chat_management")}>
 <div className="animate-in fade-in slide-in-from-bottom-4 duration-700 space-y-6">
 {/* Overview Cards */}
 <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
 <Card>
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium">{t("admin_ai_active_sessions")}</CardTitle>
 <MessageSquare className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold">{activeSessionsCount}</div>
 <p className="text-xs text-muted-foreground">{t("admin_ai_of")}{sessions.length}{t("admin_ai_total_sessions")}</p>
 </CardContent>
 </Card>

 <Card>
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium">{t("admin_ai_total_messages")}</CardTitle>
 <MessageSquare className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold">{totalMessagesCount}</div>
 <p className="text-xs text-muted-foreground">{t("admin_ai_across_all_sessions")}</p>
 </CardContent>
 </Card>

 <Card>
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium">{t("admin_ai_avg_satisfaction")}</CardTitle>
 <User className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold">
 {avgSatisfaction > 0 ? `${avgSatisfaction.toFixed(1)}/5` : 'N/A'}
 </div>
 <p className="text-xs text-muted-foreground">{t("admin_ai_user_satisfaction_rating")}</p>
 </CardContent>
 </Card>

 <Card>
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium">{t("admin_ai_transfer_rate")}</CardTitle>
 <Phone className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold">
 {sessions.length > 0 ? `${(sessions.filter((s: any) => s.status === 'TRANSFERRED').length / sessions.length * 100).toFixed(1)}%` : '0%'}
 </div>
 <p className="text-xs text-muted-foreground">{t("admin_ai_sessions_requiring_human_assistance")}</p>
 </CardContent>
 </Card>
 </div>

 {/* Filters */}
 <Card>
 <CardContent className="pt-6">
 <div className="flex gap-4">
 <div className="flex-1">
 <div className="relative">
 <Search className="absolute left-2 top-2.5 h-4 w-4 text-muted-foreground" />
 <Input placeholder={t("admin_ai_search_sessions")} value={searchTerm} onChange={e => setSearchTerm(e.target.value)} className="pl-8" />
 </div>
 </div>
 <Select value={statusFilter} onValueChange={setStatusFilter}>
 <SelectTrigger className="w-[180px]">
 <SelectValue placeholder={t("admin_ai_filter_by_status")} />
 </SelectTrigger>
 <SelectContent>
 <SelectItem value="all">{t("admin_ai_all_statuses")}</SelectItem>
 <SelectItem value="ACTIVE">{t("admin_ai_active")}</SelectItem>
 <SelectItem value="ENDED">{t("admin_ai_ended")}</SelectItem>
 <SelectItem value="TRANSFERRED">{t("admin_ai_transferred")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 </CardContent>
 </Card>

 {/* Sessions Table */}
 <Card>
 <CardHeader>
 <CardTitle>{t("admin_ai_ai_chat_sessions")}</CardTitle>
 </CardHeader>
 <CardContent>
 <Table>
 <TableHeader>
 <TableRow>
 <TableHead>{t("admin_ai_session_id")}</TableHead>
 <TableHead>{t("admin_ai_status")}</TableHead>
 <TableHead>{t("admin_ai_intent")}</TableHead>
 <TableHead>{t("admin_ai_messages")}</TableHead>
 <TableHead>{t("admin_ai_started_at")}</TableHead>
 <TableHead>{t("admin_ai_last_activity")}</TableHead>
 <TableHead>{t("admin_ai_satisfaction")}</TableHead>
 <TableHead className="text-right">{t("admin_ai_actions")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {sessions.map((session: AIChatbotSession) => <TableRow key={session.id}>
 <TableCell className="font-medium font-mono text-xs">
 {session.sessionId}
 </TableCell>
 <TableCell>
 <div className="flex items-center gap-2">
 <div className={`w-2 h-2 rounded-full ${getStatusColor(session.status)}`} />
 <span className="capitalize">{session.status.toLowerCase()}</span>
 </div>
 </TableCell>
 <TableCell>
 <Badge variant="outline">{session.intent || 'Unknown'}</Badge>
 </TableCell>
 <TableCell>{session.messagesCount || 0}</TableCell>
 <TableCell>
 {new Date(session.startedAt).toLocaleString()}
 </TableCell>
 <TableCell>
 {new Date(session.lastActivityAt).toLocaleString()}
 </TableCell>
 <TableCell>
 {session.satisfaction ? `${session.satisfaction}/5` : 'N/A'}
 </TableCell>
 <TableCell className="text-right">
 <DropdownMenu>
 <DropdownMenuTrigger asChild>
 <Button variant="ghost" className="h-8 w-8 p-0">
 <MoreHorizontal className="h-4 w-4" />
 </Button>
 </DropdownMenuTrigger>
 <DropdownMenuContent align="end">
 <DropdownMenuLabel>{t("admin_ai_actions")}</DropdownMenuLabel>
 <DropdownMenuItem onClick={() => {
 setSelectedSession(session);
 setIsSessionDialogOpen(true);
 }}>
 <Eye className="h-4 w-4 mr-2" />{t("admin_ai_view_details")}</DropdownMenuItem>
 {session.status === 'ACTIVE' && <>
 <DropdownMenuItem onClick={() => updateStatusMutation.mutate({
 id: session.id,
 status: 'ENDED'
 })}>{t("admin_ai_end_session")}</DropdownMenuItem>
 <DropdownMenuItem onClick={() => updateStatusMutation.mutate({
 id: session.id,
 status: 'TRANSFERRED',
 transferredTo: 'human_agent'
 })}>
 <Phone className="h-4 w-4 mr-2" />{t("admin_ai_transfer_to_agent")}</DropdownMenuItem>
 </>}
 </DropdownMenuContent>
 </DropdownMenu>
 </TableCell>
 </TableRow>)}
 </TableBody>
 </Table>
 </CardContent>
 </Card>

 {/* Session Details Dialog */}
 <Dialog open={isSessionDialogOpen} onOpenChange={setIsSessionDialogOpen}>
 <DialogContent className="max-w-4xl max-h-[80vh] overflow-y-auto">
 <DialogHeader>
 <DialogTitle>{t("admin_ai_chat_session_details")}</DialogTitle>
 <DialogDescription>{t("admin_ai_session_id")}{selectedSession?.sessionId}
 </DialogDescription>
 </DialogHeader>

 {loadingDetails ? <div className="flex justify-center py-8"><Activity className="animate-spin h-8 w-8" /></div> : selectedSession && <div className="space-y-6">
 {/* Session Info */}
 <div className="grid grid-cols-2 gap-4">
 <div>
 <Label>{t("admin_ai_status")}</Label>
 <div className="flex items-center gap-2 mt-1">
 <div className={`w-2 h-2 rounded-full ${getStatusColor(selectedSession.status)}`} />
 <span className="capitalize">{selectedSession.status.toLowerCase()}</span>
 </div>
 </div>
 <div>
 <Label>{t("admin_ai_intent")}</Label>
 <p className="mt-1">{selectedSession.intent || 'Unknown'}</p>
 </div>
 <div>
 <Label>{t("admin_ai_confidence")}</Label>
 <p className="mt-1">{selectedSession.confidence ? `${selectedSession.confidence}%` : 'N/A'}</p>
 </div>
 <div>
 <Label>{t("admin_ai_satisfaction")}</Label>
 <p className="mt-1">{selectedSession.satisfaction ? `${selectedSession.satisfaction}/5` : 'N/A'}</p>
 </div>
 </div>

 {/* Messages */}
 <div>
 <Label className="text-base font-semibold">{t("admin_ai_messages")}</Label>
 <div className="mt-2 space-y-2 max-h-64 overflow-y-auto">
 {messages.map((message: AIChatMessage) => <div key={message.id} className={`p-3 rounded-lg ${message.role === 'USER' ? 'bg-muted/50' : message.role === 'ASSISTANT' ? 'bg-green-50/50' : 'bg-card/50'}`}>
 <div className="flex items-center gap-2 mb-1">
 {getRoleIcon(message.role)}
 <span className="text-xs font-medium">{message.role}</span>
 <span className="text-xs text-muted-foreground">
 {new Date(message.createdAt).toLocaleTimeString()}
 </span>
 {message.piiDetected && <Badge variant="destructive" className="text-xs h-4 px-1">{t("admin_ai_pii")}</Badge>}
 </div>
 <p className="text-sm">{message.content}</p>
 </div>)}
 </div>
 </div>

 {/* Handoffs */}
 {handoffs.length > 0 && <div>
 <Label className="text-base font-semibold">{t("admin_ai_handoffs")}</Label>
 <div className="mt-2 space-y-2">
 {handoffs.map((handoff: AIChatHandoff) => <div key={handoff.id} className="p-3 border rounded-lg text-sm">
 <div className="flex justify-between items-start">
 <p className="font-medium">{handoff.handoffReason}</p>
 <span className="text-xs text-muted-foreground">{new Date(handoff.handoffAt).toLocaleString()}</span>
 </div>
 <p className="text-muted-foreground mt-1">{t("admin_ai_to")}{handoff.handoffTo}</p>
 </div>)}
 </div>
 </div>}
 </div>}

 <DialogFooter>
 <Button onClick={() => setIsSessionDialogOpen(false)}>{t("admin_ai_close")}</Button>
 </DialogFooter>
 </DialogContent>
 </Dialog>
 </div>
 </PageShell>;
}