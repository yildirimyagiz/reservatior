"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Progress } from "@/components/ui/progress";
import { Users, MessageSquare, Phone, Mail, Calendar, Clock, CheckCircle, XCircle, AlertTriangle, TrendingUp, TrendingDown, Star, Heart, Globe, Filter, Search, Download, RefreshCw, Activity, BarChart3, PieChart, Target, Smile, Frown, Meh, UserCheck, UserX, Send, Video, DollarSign, Loader2 } from "lucide-react";
import { useAuth } from "@/lib/auth/hooks";
import { useQuery, useQueryClient } from "@tanstack/react-query";
import { guestsApi } from "@/lib/api/guests";
import { useToast } from "@/hooks/use-toast";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
interface GuestFollowUp {
  id: string;
  guest: {
    id: string;
    name: string;
    email: string;
    phone: string;
    nationality: string;
    language: string;
    preferredContact: 'email' | 'phone' | 'sms' | 'whatsapp';
    avatar?: string;
    joinDate: Date;
    totalBookings: number;
    totalSpent: number;
    averageRating: number;
    status: 'active' | 'inactive' | 'vip' | 'blacklisted';
    preferences: {
      roomType: string[];
      amenities: string[];
      budgetRange: [number, number];
      checkInTime: string;
      specialRequests: string[];
    };
  };
  followUpType: 'pre_arrival' | 'post_stay' | 'special_occasion' | 'feedback' | 'complaint' | 'loyalty';
  priority: 'low' | 'medium' | 'high' | 'urgent';
  status: 'pending' | 'in_progress' | 'completed' | 'cancelled' | 'scheduled';
  scheduledDate?: Date;
  completedDate?: Date;
  subject: string;
  description: string;
  communicationHistory: Array<{
    id: string;
    timestamp: Date;
    type: 'email' | 'phone' | 'sms' | 'whatsapp' | 'in_person';
    direction: 'inbound' | 'outbound';
    content: string;
    duration?: number;
    status: 'sent' | 'delivered' | 'opened' | 'read' | 'failed' | 'completed';
    agentId: string;
    agentName: string;
    attachments?: Array<{
      name: string;
      type: string;
      url: string;
    }>;
  }>;
  nextAction?: {
    type: 'call' | 'email' | 'sms' | 'meeting' | 'task';
    scheduledDate: Date;
    assignedTo: string;
    description: string;
  };
  satisfactionScore?: number;
  feedback?: {
    rating: number;
    comment: string;
    categories: {
      service: number;
      cleanliness: number;
      location: number;
      value: number;
      amenities: number;
    };
    sentiment: 'positive' | 'neutral' | 'negative';
    tags: string[];
  };
  assignedAgent: string;
  createdAt: Date;
  updatedAt: Date;
  createdBy: string;
}
interface FollowUpAnalytics {
  total: number;
  pending: number;
  inProgress: number;
  completed: number;
  cancelled: number;
  scheduled: number;
  responseRate: number;
  satisfactionScore: number;
  completionRate: number;
  averageResponseTime: number;
  followUpTypes: {
    preArrival: number;
    postStay: number;
    specialOccasion: number;
    feedback: number;
    complaint: number;
    loyalty: number;
  };
  priorityDistribution: {
    low: number;
    medium: number;
    high: number;
    urgent: number;
  };
}
export default function GuestFollowUp() {
  const {
    t
  } = useTranslation();
  const {
    user
  } = useAuth();
  const { toast } = useToast();
  const queryClient = useQueryClient();
  const [filteredFollowUps, setFilteredFollowUps] = useState<GuestFollowUp[]>([]);
  const [filter, setFilter] = useState<{
    status?: string;
    type?: string;
    priority?: string;
    assignedAgent?: string;
    dateRange?: [Date, Date];
    search?: string;
  }>({});
  const [selectedFollowUp, setSelectedFollowUp] = useState<GuestFollowUp | null>(null);
  const [viewMode, setViewMode] = useState<'list' | 'kanban' | 'calendar'>('list');
  const [isLive, setIsLive] = useState(true);

  const [isActionModalOpen, setIsActionModalOpen] = useState(false);
  const [actionType, setActionType] = useState<'message' | 'call' | 'schedule' | null>(null);
  const [actionContent, setActionContent] = useState('');

  const { data: followUps = [], isLoading: isFollowUpsLoading } = useQuery({
    queryKey: ['guest-follow-ups'],
    queryFn: async () => {
      const response = await guestsApi.getFollowUps() as any;
      // Convert dates from strings if necessary, though leaving as is since this is a UI-level integration
      return (response.data || []) as GuestFollowUp[];
    }
  });

  const { data: analytics, isLoading: isAnalyticsLoading } = useQuery({
    queryKey: ['guest-follow-up-analytics'],
    queryFn: async () => {
      const response = await guestsApi.getFollowUpAnalytics() as any;
      return response.data as FollowUpAnalytics;
    }
  });

  // Apply filters
  useEffect(() => {
    let filtered = [...followUps];
    if (filter.status) {
      filtered = filtered.filter(fu => fu.status === filter.status);
    }
    if (filter.type) {
      filtered = filtered.filter(fu => fu.followUpType === filter.type);
    }
    if (filter.priority) {
      filtered = filtered.filter(fu => fu.priority === filter.priority);
    }
    if (filter.assignedAgent) {
      filtered = filtered.filter(fu => fu.assignedAgent === filter.assignedAgent);
    }
    if (filter.search) {
      filtered = filtered.filter(fu => fu.guest.name.toLowerCase().includes(filter.search!.toLowerCase()) || fu.guest.email.toLowerCase().includes(filter.search!.toLowerCase()) || fu.subject.toLowerCase().includes(filter.search!.toLowerCase()) || fu.description.toLowerCase().includes(filter.search!.toLowerCase()));
    }
    setFilteredFollowUps(filtered);
  }, [followUps, filter]);

  // Simulate live updates
  useEffect(() => {
    if (!isLive) return;
    const interval = setInterval(() => {
      queryClient.setQueryData(['guest-follow-up-analytics'], (prev: FollowUpAnalytics | undefined) => {
        if (!prev) return prev;
        return {
          ...prev,
          total: prev.total + (Math.random() > 0.8 ? 1 : 0),
          responseRate: Math.max(0, Math.min(100, prev.responseRate + (Math.random() - 0.5) * 2)),
          satisfactionScore: Math.max(1, Math.min(5, prev.satisfactionScore + (Math.random() - 0.5) * 0.1))
        };
      });
    }, 15000);
    return () => clearInterval(interval);
  }, [isLive, queryClient]);
  const getStatusColor = (status: string) => {
    switch (status) {
      case 'pending':
        return 'bg-yellow-100 text-yellow-800';
      case 'in_progress':
        return 'bg-blue-100 text-blue-800';
      case 'completed':
        return 'bg-green-100 text-green-800';
      case 'cancelled':
        return 'bg-red-100 text-red-800';
      case 'scheduled':
        return 'bg-purple-100 text-purple-800';
      default:
        return 'bg-gray-100 text-gray-800';
    }
  };
  const getPriorityColor = (priority: string) => {
    switch (priority) {
      case 'low':
        return 'bg-gray-100 text-gray-800';
      case 'medium':
        return 'bg-blue-100 text-blue-800';
      case 'high':
        return 'bg-orange-100 text-orange-800';
      case 'urgent':
        return 'bg-red-100 text-red-800';
      default:
        return 'bg-gray-100 text-gray-800';
    }
  };
  const getFollowUpTypeIcon = (type: string) => {
    switch (type) {
      case 'pre_arrival':
        return <Calendar className="w-4 h-4" />;
      case 'post_stay':
        return <CheckCircle className="w-4 h-4" />;
      case 'special_occasion':
        return <Star className="w-4 h-4" />;
      case 'feedback':
        return <MessageSquare className="w-4 h-4" />;
      case 'complaint':
        return <AlertTriangle className="w-4 h-4" />;
      case 'loyalty':
        return <Heart className="w-4 h-4" />;
      default:
        return <Users className="w-4 h-4" />;
    }
  };
  const getGuestStatusIcon = (status: string) => {
    switch (status) {
      case 'active':
        return <UserCheck className="w-4 h-4 text-green-500" />;
      case 'vip':
        return <Star className="w-4 h-4 text-yellow-500" />;
      case 'inactive':
        return <UserX className="w-4 h-4 text-gray-500" />;
      case 'blacklisted':
        return <XCircle className="w-4 h-4 text-red-500" />;
      default:
        return <Users className="w-4 h-4" />;
    }
  };
  const getSatisfactionIcon = (score: number) => {
    if (score >= 4) return <Smile className="w-4 h-4 text-green-500" />;
    if (score >= 3) return <Meh className="w-4 h-4 text-yellow-500" />;
    return <Frown className="w-4 h-4 text-red-500" />;
  };
  const exportFollowUps = () => {
    const csv = ['Guest Name,Email,Phone,Follow-up Type,Priority,Status,Agent,Scheduled Date,Feedback Score', ...filteredFollowUps.map(fu => `"${fu.guest?.name}","${fu.guest?.email}","${fu.guest?.phone}","${fu.followUpType}","${fu.priority}","${fu.status}","${fu.assignedAgent}","${fu.scheduledDate ? new Date(fu.scheduledDate).toISOString() : ''}","${fu.satisfactionScore || ''}"`)].join('\n');
    const blob = new Blob([csv], {
      type: 'text/csv'
    });
    const url = window.URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = `guest-follow-ups-${new Date().toISOString().split('T')[0]}.csv`;
    a.click();
    window.URL.revokeObjectURL(url);
  };
  return <div className="min-h-screen bg-background">
      <div className="container mx-auto p-6">
        <div className="mb-6">
          <h1 className="text-3xl font-bold">{t("client.src.guest_followup_system")}</h1>
          <p className="text-muted-foreground">{t("client.src.personalized_followup_and_communication")}</p>
        </div>

        {/* Analytics Dashboard */}
        {analytics && <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4 mb-6">
            <Card>
              <CardContent className="p-4">
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-sm font-medium text-muted-foreground">{t("client.src.total_followups")}</p>
                    <p className="text-2xl font-bold">{analytics.total}</p>
                    <p className="text-xs text-muted-foreground">{t("client.src.completion")}{analytics.completionRate.toFixed(1)}%</p>
                  </div>
                  <Users className="w-8 h-8 text-blue-500" />
                </div>
              </CardContent>
            </Card>

            <Card>
              <CardContent className="p-4">
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-sm font-medium text-muted-foreground">{t("client.src.satisfaction_score")}</p>
                    <p className="text-2xl font-bold">{analytics.satisfactionScore.toFixed(1)}</p>
                    <div className="flex items-center gap-1">
                      {getSatisfactionIcon(analytics.satisfactionScore)}
                      <p className="text-xs text-muted-foreground">{t("client.src.out_of_5")}</p>
                    </div>
                  </div>
                  <Star className="w-8 h-8 text-yellow-500" />
                </div>
              </CardContent>
            </Card>

            <Card>
              <CardContent className="p-4">
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-sm font-medium text-muted-foreground">{t("client.src.response_rate")}</p>
                    <p className="text-2xl font-bold">{analytics.responseRate.toFixed(1)}%</p>
                    <div className="flex items-center gap-1">
                      {analytics.responseRate > 70 ? <TrendingUp className="w-3 h-3 text-green-500" /> : <TrendingDown className="w-3 h-3 text-red-500" />}
                      <p className="text-xs text-muted-foreground">{t("client.src.good")}</p>
                    </div>
                  </div>
                  <MessageSquare className="w-8 h-8 text-green-500" />
                </div>
              </CardContent>
            </Card>

            <Card>
              <CardContent className="p-4">
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-sm font-medium text-muted-foreground">{t("client.src.avg_response_time")}</p>
                    <p className="text-2xl font-bold">{analytics.averageResponseTime.toFixed(1)}s</p>
                    <p className="text-xs text-muted-foreground">{t("client.src.seconds")}</p>
                  </div>
                  <Clock className="w-8 h-8 text-purple-500" />
                </div>
              </CardContent>
            </Card>
          </div>}

        {/* Status Overview */}
        <div className="grid gap-4 md:grid-cols-5 mb-6">
          {[{
          status: 'pending',
          count: analytics?.pending || 0,
          label: t("client.src.pending"),
          color: 'bg-yellow-100 text-yellow-800'
        }, {
          status: 'in_progress',
          count: analytics?.inProgress || 0,
          label: t("client.src.in_progress"),
          color: 'bg-blue-100 text-blue-800'
        }, {
          status: 'completed',
          count: analytics?.completed || 0,
          label: t("client.src.completed"),
          color: 'bg-green-100 text-green-800'
        }, {
          status: 'scheduled',
          count: analytics?.scheduled || 0,
          label: t("client.src.scheduled"),
          color: 'bg-purple-100 text-purple-800'
        }, {
          status: 'cancelled',
          count: analytics?.cancelled || 0,
          label: t("client.src.cancelled"),
          color: 'bg-red-100 text-red-800'
        }].map(({
          status,
          count,
          label,
          color
        }) => <Card key={status} className="cursor-pointer" onClick={() => setFilter({
          ...filter,
          status
        })}>
              <CardContent className="p-4">
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-2xl font-bold">{count}</p>
                    <p className="text-sm text-muted-foreground">{label}</p>
                  </div>
                  <Badge className={color}>{status}</Badge>
                </div>
              </CardContent>
            </Card>)}
        </div>

        {/* Controls */}
        <div className="flex flex-col gap-4 md:flex-row md:items-center md:justify-between mb-6">
          <div className="flex flex-wrap gap-2">
            <Button variant={isLive ? "default" : "outline"} size="sm" onClick={() => setIsLive(!isLive)}>
              {isLive ? <Activity className="w-4 h-4 mr-2" /> : <Clock className="w-4 h-4 mr-2" />}
              {isLive ? "Live" : "Paused"}
            </Button>
            
            <Button variant="outline" size="sm" onClick={() => {
                queryClient.invalidateQueries({ queryKey: ['guest-follow-ups'] });
                queryClient.invalidateQueries({ queryKey: ['guest-follow-up-analytics'] });
              }}>
              <RefreshCw className="w-4 h-4 mr-2" />{t("client.src.refresh")}</Button>

            <Button variant="outline" size="sm" onClick={exportFollowUps}>
              <Download className="w-4 h-4 mr-2" />{t("client.src.download")}</Button>
          </div>

          <div className="flex items-center gap-2">
            <div className="relative">
              <Search className="absolute left-2 top-2.5 h-4 w-4 text-muted-foreground" />
              <input type="text" aria-label="Search guests" placeholder={t("client.src.search_guests")} className="pl-8 pr-3 py-2 border rounded-md text-sm" value={filter.search || ''} onChange={e => setFilter({
              ...filter,
              search: e.target.value || undefined
            })} />
            </div>
            
            <Button variant="outline" size="sm">
              <Filter className="w-4 h-4 mr-2" />{t("client.src.filtre")}</Button>
          </div>
        </div>

        {/* Filters */}
        <div className="flex flex-wrap gap-2 mb-6">
          <select aria-label="Filter by follow-up status" className="px-3 py-1 border rounded-md text-sm" value={filter.status || ''} onChange={e => setFilter({
          ...filter,
          status: e.target.value || undefined
        })}>
            <option value="">{t("client.src.all_statuses")}</option>
            <option value="pending">{t("client.src.pending")}</option>
            <option value="in_progress">{t("client.src.in_progress")}</option>
            <option value="completed">{t("client.src.completed")}</option>
            <option value="scheduled">{t("client.src.scheduled")}</option>
            <option value="cancelled">{t("client.src.cancelled")}</option>
          </select>

          <select aria-label="Filter by follow-up type" className="px-3 py-1 border rounded-md text-sm" value={filter.type || ''} onChange={e => setFilter({
          ...filter,
          type: e.target.value || undefined
        })}>
            <option value="">{t("client.src.all_types")}</option>
            <option value="pre_arrival">{t("client.src.prearrival")}</option>
            <option value="post_stay">{t("client.src.poststay")}</option>
            <option value="special_occasion">{t("client.src.special_occasion")}</option>
            <option value="feedback">{t("client.src.feedback")}</option>
            <option value="complaint">{t("client.src.complaint")}</option>
            <option value="loyalty">{t("client.src.loyalty")}</option>
          </select>

          <select aria-label="Filter by priority" className="px-3 py-1 border rounded-md text-sm" value={filter.priority || ''} onChange={e => setFilter({
          ...filter,
          priority: e.target.value || undefined
        })}>
            <option value="">{t("client.src.all_priorities")}</option>
            <option value="low">{t("client.src.low")}</option>
            <option value="medium">{t("client.src.medium")}</option>
            <option value="high">{t("client.src.high")}</option>
            <option value="urgent">{t("client.src.urgent")}</option>
          </select>

          <div className="flex gap-2">
            <Button variant={viewMode === 'list' ? 'default' : 'outline'} size="sm" onClick={() => setViewMode('list')}>{t("client.src.list")}</Button>
            <Button variant={viewMode === 'kanban' ? 'default' : 'outline'} size="sm" onClick={() => setViewMode('kanban')}>{t("client.src.kanban")}</Button>
            <Button variant={viewMode === 'calendar' ? 'default' : 'outline'} size="sm" onClick={() => setViewMode('calendar')}>{t("client.src.calendar")}</Button>
          </div>
        </div>

        <Tabs defaultValue="follow-ups" className="w-full">
          <TabsList className="grid w-full grid-cols-3">
            <TabsTrigger value="follow-ups">{t("client.src.followups")}</TabsTrigger>
            <TabsTrigger value="analytics">{t("client.src.analytics")}</TabsTrigger>
            <TabsTrigger value="templates">{t("client.src.templates")}</TabsTrigger>
          </TabsList>

          <TabsContent value="follow-ups" className="space-y-6">
            {/* Follow-ups List */}
            {viewMode === 'list' && <Card>
                <CardHeader>
                  <CardTitle>{t("client.src.guest_followups")}</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="space-y-4">
                    {filteredFollowUps.map(followUp => <div key={followUp.id} className="border rounded-lg p-4 hover:bg-muted/50 transition-colors cursor-pointer" onClick={() => setSelectedFollowUp(followUp)}>
                        <div className="flex items-start justify-between mb-3">
                          <div className="flex items-center gap-3">
                            <div className="w-12 h-12 bg-muted rounded-lg flex items-center justify-center">
                              {getGuestStatusIcon(followUp.guest.status)}
                            </div>
                            <div>
                              <div className="flex items-center gap-2 mb-1">
                                <h2 className="font-medium">{followUp.guest.name}</h2>
                                <Badge className={getPriorityColor(followUp.priority)}>
                                  {followUp.priority}
                                </Badge>
                                <Badge className={getStatusColor(followUp.status)}>
                                  {followUp.status}
                                </Badge>
                              </div>
                              <p className="text-sm text-muted-foreground">{followUp.guest.email}</p>
                            </div>
                          </div>
                          <div className="text-right">
                            <div className="flex items-center gap-1 mb-1">
                              {getFollowUpTypeIcon(followUp.followUpType)}
                              <span className="text-sm font-medium">{followUp.followUpType.replace('_', ' ')}</span>
                            </div>
                            {followUp.satisfactionScore && <div className="flex items-center gap-1">
                                {getSatisfactionIcon(followUp.satisfactionScore)}
                                <span className="text-sm">{followUp.satisfactionScore.toFixed(1)}</span>
                              </div>}
                          </div>
                        </div>

                        <div className="grid grid-cols-2 md:grid-cols-4 gap-4 text-sm">
                          <div>
                            <p className="text-muted-foreground">{t("client.src.subject")}</p>
                            <p className="font-medium">{followUp.subject}</p>
                          </div>
                          <div>
                            <p className="text-muted-foreground">{t("client.src.communication")}</p>
                            <p className="font-medium">{followUp.guest.preferredContact}</p>
                          </div>
                          <div>
                            <p className="text-muted-foreground">{t("client.src.responsible")}</p>
                            <p className="font-medium">{followUp.assignedAgent}</p>
                          </div>
                          <div>
                            <p className="text-muted-foreground">{t("client.src.scheduled")}</p>
                            <p className="font-medium">
                              {followUp.scheduledDate ? followUp.scheduledDate.toLocaleDateString() : '-'}
                            </p>
                          </div>
                        </div>

                        <div className="flex items-center gap-2 mt-3">
                          <div className="flex items-center gap-1">
                            <Globe className="w-3 h-3" />
                            <span className="text-sm">{followUp.guest.nationality}</span>
                          </div>
                          <div className="flex items-center gap-1">
                            <Users className="w-3 h-3" />
                            <span className="text-sm">{followUp.guest.totalBookings}{t("client.src.bookings")}</span>
                          </div>
                          <div className="flex items-center gap-1">
                            <DollarSign className="w-3 h-3" />
                            <span className="text-sm">${followUp.guest.totalSpent}</span>
                          </div>
                        </div>
                      </div>)}
                  </div>
                </CardContent>
              </Card>}

            {/* Kanban View */}
            {viewMode === 'kanban' && <div className="grid gap-6 md:grid-cols-3">
                {['pending', 'in_progress', 'completed'].map(status => <Card key={status}>
                    <CardHeader>
                      <CardTitle className="flex items-center gap-2">
                        {status === 'pending' ? <Clock className="w-5 h-5" /> : status === 'in_progress' ? <Activity className="w-5 h-5" /> : <CheckCircle className="w-5 h-5" />}
                        <span className="capitalize">
                          {status === 'pending' ? 'Pending' : status === 'in_progress' ? 'In Progress' : 'Completed'}
                        </span>
                        <Badge variant="secondary">
                          {filteredFollowUps.filter(fu => fu.status === status).length}
                        </Badge>
                      </CardTitle>
                    </CardHeader>
                    <CardContent className="space-y-3">
                      {filteredFollowUps.filter(followUp => followUp.status === status).map(followUp => <div key={followUp.id} className="border rounded-lg p-3 hover:bg-muted/50 transition-colors cursor-pointer" onClick={() => setSelectedFollowUp(followUp)}>
                            <div className="flex items-center justify-between mb-2">
                              <p className="font-medium text-sm">{followUp.guest.name}</p>
                              <Badge className={getPriorityColor(followUp.priority)} variant="outline">
                                {followUp.priority}
                              </Badge>
                            </div>
                            <p className="text-sm font-medium">{followUp.subject}</p>
                            <p className="text-xs text-muted-foreground">{followUp.guest.email}</p>
                            <div className="flex items-center gap-2 mt-2">
                              {getFollowUpTypeIcon(followUp.followUpType)}
                              <span className="text-xs">{followUp.followUpType.replace('_', ' ')}</span>
                            </div>
                          </div>)}
                    </CardContent>
                  </Card>)}
              </div>}

            {/* Calendar View */}
            {viewMode === 'calendar' && <Card>
                <CardHeader>
                  <CardTitle>{t("client.src.calendar_view")}</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="h-96 bg-muted rounded-md flex items-center justify-center">
                    <p className="text-sm text-muted-foreground">{t("client.src.calendar_view_will_be")}</p>
                  </div>
                </CardContent>
              </Card>}
          </TabsContent>

          <TabsContent value="analytics" className="space-y-6">
            <div className="grid gap-6 md:grid-cols-2">
              <Card>
                <CardHeader>
                  <CardTitle className="flex items-center gap-2">
                    <BarChart3 className="w-5 h-5" />{t("client.src.followup_types_distribution")}</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="space-y-3">
                    {analytics && Object.entries(analytics.followUpTypes).map(([type, count]) => <div key={type} className="flex items-center justify-between">
                        <div className="flex items-center gap-2">
                          {getFollowUpTypeIcon(type)}
                          <span className="text-sm capitalize">{type.replace('_', ' ')}</span>
                        </div>
                        <div className="flex items-center gap-2">
                          <div className="w-32 bg-muted rounded-full h-2">
                            <div className="bg-primary h-2 rounded-full" style={{
                          width: `${count / analytics.total * 100}%`
                        }} />
                          </div>
                          <span className="text-sm font-medium w-8">{count}</span>
                        </div>
                      </div>)}
                  </div>
                </CardContent>
              </Card>

              <Card>
                <CardHeader>
                  <CardTitle className="flex items-center gap-2">
                    <PieChart className="w-5 h-5" />{t("client.src.priority_distribution")}</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="space-y-3">
                    {analytics && Object.entries(analytics.priorityDistribution).map(([priority, count]) => <div key={priority} className="flex items-center justify-between">
                        <Badge className={getPriorityColor(priority)}>
                          {priority}
                        </Badge>
                        <div className="flex items-center gap-2">
                          <div className="w-32 bg-muted rounded-full h-2">
                            <div className="bg-primary h-2 rounded-full" style={{
                          width: `${count / analytics.total * 100}%`
                        }} />
                          </div>
                          <span className="text-sm font-medium w-8">{count}</span>
                        </div>
                      </div>)}
                  </div>
                </CardContent>
              </Card>

              <Card>
                <CardHeader>
                  <CardTitle className="flex items-center gap-2">
                    <Target className="w-5 h-5" />{t("client.src.performance_metrics")}</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="space-y-4">
                    <div>
                      <div className="flex justify-between mb-1">
                        <span className="text-sm font-medium">{t("client.src.completion_rate")}</span>
                        <span className="text-sm">{analytics?.completionRate.toFixed(1)}%</span>
                      </div>
                      <Progress value={analytics?.completionRate} className="h-2" />
                    </div>
                    <div>
                      <div className="flex justify-between mb-1">
                        <span className="text-sm font-medium">{t("client.src.response_rate")}</span>
                        <span className="text-sm">{analytics?.responseRate.toFixed(1)}%</span>
                      </div>
                      <Progress value={analytics?.responseRate} className="h-2" />
                    </div>
                    <div>
                      <div className="flex justify-between mb-1">
                        <span className="text-sm font-medium">{t("client.src.satisfaction_score")}</span>
                        <span className="text-sm">{analytics?.satisfactionScore.toFixed(1)}/5</span>
                      </div>
                      <Progress value={(analytics?.satisfactionScore || 0) * 20} className="h-2" />
                    </div>
                  </div>
                </CardContent>
              </Card>

              <Card>
                <CardHeader>
                  <CardTitle className="flex items-center gap-2">
                    <TrendingUp className="w-5 h-5" />{t("client.src.trend_analysis")}</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="h-64 bg-muted rounded-md flex items-center justify-center">
                    <p className="text-sm text-muted-foreground">{t("client.src.trend_analysis_chart_will")}</p>
                  </div>
                </CardContent>
              </Card>
            </div>
          </TabsContent>

          <TabsContent value="templates" className="space-y-6">
            <Card>
              <CardHeader>
                <CardTitle>{t("client.src.communication_templates")}</CardTitle>
              </CardHeader>
              <CardContent>
                <div className="grid gap-4 md:grid-cols-2">
                  <Button variant="outline" className="h-20 flex-col">
                    <Mail className="w-8 h-8 mb-2" />
                    <span>{t("client.src.email_templates")}</span>
                  </Button>
                  <Button variant="outline" className="h-20 flex-col">
                    <MessageSquare className="w-8 h-8 mb-2" />
                    <span>{t("client.src.sms_templates")}</span>
                  </Button>
                  <Button variant="outline" className="h-20 flex-col">
                    <Phone className="w-8 h-8 mb-2" />
                    <span>{t("client.src.phone_scripts")}</span>
                  </Button>
                  <Button variant="outline" className="h-20 flex-col">
                    <Video className="w-8 h-8 mb-2" />
                    <span>{t("client.src.video_messages")}</span>
                  </Button>
                </div>
              </CardContent>
            </Card>
          </TabsContent>
        </Tabs>

        {/* Follow-up Detail Modal */}
        {selectedFollowUp && <div className="fixed inset-0 bg-black/50 flex items-center justify-center p-4 z-50">
            <Card className="w-full max-w-4xl max-h-[90vh] overflow-auto">
              <CardHeader>
                <div className="flex items-center justify-between">
                  <CardTitle>{t("client.src.followup_detail")}{selectedFollowUp.guest.name}</CardTitle>
                  <Button variant="ghost" size="sm" onClick={() => setSelectedFollowUp(null)}>
                    ×
                  </Button>
                </div>
              </CardHeader>
              <CardContent className="space-y-6">
                {/* Guest Info */}
                <div>
                  <h3 className="text-lg font-medium mb-3">{t("client.src.guest_information")}</h3>
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <Card>
                      <CardContent className="p-4">
                        <div className="flex items-center gap-3 mb-3">
                          <div className="w-12 h-12 bg-muted rounded-lg flex items-center justify-center">
                            {getGuestStatusIcon(selectedFollowUp.guest.status)}
                          </div>
                          <div>
                            <h4 className="font-medium">{selectedFollowUp.guest.name}</h4>
                            <p className="text-sm text-muted-foreground">{selectedFollowUp.guest.email}</p>
                            <Badge variant="outline">{selectedFollowUp.guest.status}</Badge>
                          </div>
                        </div>
                        <div className="space-y-2 text-sm">
                          <div className="flex justify-between">
                            <span className="text-muted-foreground">{t("client.src.phone")}</span>
                            <span className="font-medium">{selectedFollowUp.guest.phone}</span>
                          </div>
                          <div className="flex justify-between">
                            <span className="text-muted-foreground">{t("client.src.nationality")}</span>
                            <span className="font-medium">{selectedFollowUp.guest.nationality}</span>
                          </div>
                          <div className="flex justify-between">
                            <span className="text-muted-foreground">{t("client.src.language")}</span>
                            <span className="font-medium">{selectedFollowUp.guest.language}</span>
                          </div>
                          <div className="flex justify-between">
                            <span className="text-muted-foreground">{t("client.src.communication")}</span>
                            <span className="font-medium">{selectedFollowUp.guest.preferredContact}</span>
                          </div>
                        </div>
                      </CardContent>
                    </Card>
                    <Card>
                      <CardContent className="p-4">
                        <h4 className="font-medium mb-3">{t("client.src.statistics")}</h4>
                        <div className="space-y-2 text-sm">
                          <div className="flex justify-between">
                            <span className="text-muted-foreground">{t("client.src.total_bookings")}</span>
                            <span className="font-medium">{selectedFollowUp.guest.totalBookings}</span>
                          </div>
                          <div className="flex justify-between">
                            <span className="text-muted-foreground">{t("client.src.total_spent")}</span>
                            <span className="font-medium">${selectedFollowUp.guest.totalSpent}</span>
                          </div>
                          <div className="flex justify-between">
                            <span className="text-muted-foreground">{t("client.src.average_rating")}</span>
                            <span className="font-medium">{selectedFollowUp.guest.averageRating.toFixed(1)}</span>
                          </div>
                          <div className="flex justify-between">
                            <span className="text-muted-foreground">{t("client.src.join_date")}</span>
                            <span className="font-medium">{selectedFollowUp.guest.joinDate.toLocaleDateString()}</span>
                          </div>
                        </div>
                      </CardContent>
                    </Card>
                  </div>
                </div>

                {/* Follow-up Details */}
                <div>
                  <h3 className="text-lg font-medium mb-3">{t("client.src.followup_details")}</h3>
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <Card>
                      <CardContent className="p-4">
                        <div className="space-y-2">
                          <div className="flex justify-between">
                            <span className="text-sm font-medium text-muted-foreground">{t("client.src.type")}</span>
                            <div className="flex items-center gap-2">
                              {getFollowUpTypeIcon(selectedFollowUp.followUpType)}
                              <span className="font-medium">{selectedFollowUp.followUpType.replace('_', ' ')}</span>
                            </div>
                          </div>
                          <div className="flex justify-between">
                            <span className="text-sm font-medium text-muted-foreground">{t("client.src.priority")}</span>
                            <Badge className={getPriorityColor(selectedFollowUp.priority)}>
                              {selectedFollowUp.priority}
                            </Badge>
                          </div>
                          <div className="flex justify-between">
                            <span className="text-sm font-medium text-muted-foreground">{t("client.src.status")}</span>
                            <Badge className={getStatusColor(selectedFollowUp.status)}>
                              {selectedFollowUp.status}
                            </Badge>
                          </div>
                          <div className="flex justify-between">
                            <span className="text-sm font-medium text-muted-foreground">{t("client.src.responsible")}</span>
                            <span className="font-medium">{selectedFollowUp.assignedAgent}</span>
                          </div>
                        </div>
                      </CardContent>
                    </Card>
                    <Card>
                      <CardContent className="p-4">
                        <h4 className="font-medium mb-2">{t("client.src.subject_and_description")}</h4>
                        <p className="text-sm font-medium mb-2">{selectedFollowUp.subject}</p>
                        <p className="text-sm text-muted-foreground">{selectedFollowUp.description}</p>
                      </CardContent>
                    </Card>
                  </div>
                </div>

                {/* Communication History */}
                <div>
                  <h3 className="text-lg font-medium mb-3">{t("client.src.communication_history")}</h3>
                  <Card>
                    <CardContent className="p-4">
                      <div className="space-y-3">
                        {selectedFollowUp.communicationHistory.map((comm, index) => <div key={index} className="flex items-start gap-3">
                            <div className="w-2 h-2 bg-primary rounded-full mt-2"></div>
                            <div className="flex-1">
                              <div className="flex items-center gap-2 mb-1">
                                <p className="font-medium text-sm">{comm.type}</p>
                                <Badge variant={comm.direction === 'outbound' ? 'default' : 'secondary'}>
                                  {comm.direction === 'outbound' ? 'Sent' : 'Received'}
                                </Badge>
                                <p className="text-xs text-muted-foreground">{comm.timestamp.toLocaleString()}</p>
                              </div>
                              <p className="text-sm mb-1">{comm.content}</p>
                              <p className="text-xs text-muted-foreground">{t("client.src.by")}{comm.agentName} • {comm.status}</p>
                            </div>
                          </div>)}
                      </div>
                    </CardContent>
                  </Card>
                </div>

                {/* Feedback */}
                {selectedFollowUp.feedback && <div>
                    <h3 className="text-lg font-medium mb-3">{t("client.src.feedback")}</h3>
                    <Card>
                      <CardContent className="p-4">
                        <div className="space-y-4">
                          <div className="flex items-center gap-4">
                            <div className="flex items-center gap-1">
                              {getSatisfactionIcon(selectedFollowUp.feedback.rating)}
                              <span className="font-medium">{selectedFollowUp.feedback.rating.toFixed(1)}</span>
                            </div>
                            <Badge className={selectedFollowUp.feedback.sentiment === 'positive' ? 'bg-green-100 text-green-800' : selectedFollowUp.feedback.sentiment === 'negative' ? 'bg-red-100 text-red-800' : 'bg-gray-100 text-gray-800'}>
                              {selectedFollowUp.feedback.sentiment}
                            </Badge>
                          </div>
                          <p className="text-sm">{selectedFollowUp.feedback.comment}</p>
                          <div className="grid grid-cols-2 md:grid-cols-5 gap-4">
                            {Object.entries(selectedFollowUp.feedback.categories).map(([category, rating]) => <div key={category} className="text-center">
                                <p className="text-xs text-muted-foreground capitalize">{category}</p>
                                <div className="flex items-center justify-center gap-1">
                                  <Star className="w-3 h-3 text-yellow-500 fill-yellow-500" />
                                  <span className="text-sm font-medium">{rating.toFixed(1)}</span>
                                </div>
                              </div>)}
                          </div>
                          <div className="flex gap-2">
                            {selectedFollowUp.feedback.tags.map((tag, index) => <Badge key={index} variant="outline">{tag}</Badge>)}
                          </div>
                        </div>
                      </CardContent>
                    </Card>
                  </div>}

                {/* Actions */}
                <div className="flex gap-2 pt-4 border-t">
                  <Button onClick={() => {
                    setActionType('message');
                    setIsActionModalOpen(true);
                  }}>
                    <Send className="w-4 h-4 mr-2" />{t("client.src.send_message")}</Button>
                  <Button variant="outline" onClick={() => {
                    setActionType('call');
                    setIsActionModalOpen(true);
                  }}>
                    <Phone className="w-4 h-4 mr-2" />{t("client.src.call")}</Button>
                  <Button variant="outline" onClick={() => {
                    setActionType('schedule');
                    setIsActionModalOpen(true);
                  }}>
                    <Calendar className="w-4 h-4 mr-2" />{t("client.src.schedule")}</Button>
                  <Button variant="outline" onClick={() => toast({ title: t("client.src.export_started") })}>
                    <Download className="w-4 h-4 mr-2" />{t("client.src.download")}</Button>
                </div>
              </CardContent>
            </Card>
          </div>}

        <Dialog open={isActionModalOpen} onOpenChange={setIsActionModalOpen}>
          <DialogContent>
            <DialogHeader>
              <DialogTitle>
                {actionType === 'message' && t("client.src.send_message")}
                {actionType === 'call' && t("client.src.call")}
                {actionType === 'schedule' && t("client.src.schedule")}
              </DialogTitle>
            </DialogHeader>
            <div className="space-y-4 py-4">
              <Label>{t("client.src.details")}</Label>
              <Textarea value={actionContent} onChange={e => setActionContent(e.target.value)} rows={4} placeholder={t("client.src.enter_details")} />
            </div>
            <DialogFooter>
              <Button variant="outline" onClick={() => setIsActionModalOpen(false)}>{t("client.src.cancel")}</Button>
              <Button onClick={() => {
                toast({ title: t("client.src.action_completed") });
                setIsActionModalOpen(false);
                setActionContent('');
              }}>{t("client.src.submit")}</Button>
            </DialogFooter>
          </DialogContent>
        </Dialog>
      </div>
    </div>;
}