"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { CreditCard, DollarSign, TrendingUp, TrendingDown, Clock, CheckCircle, XCircle, AlertTriangle, MessageSquare, Filter, Search, Download, RefreshCw, Activity, Target, Zap, Headphones, ThumbsUp, FileText, Receipt, CreditCard as CreditCardIcon, Banknote, Building, Globe, Smile, Send } from "lucide-react";
import { useAuth } from "@/lib/auth/hooks";
import { useToast } from "@/hooks/use-toast";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
interface Payout {
  id: string;
  reservationId: string;
  guest: {
    id: string;
    name: string;
    email: string;
    phone: string;
    nationality: string;
  };
  property: {
    id: string;
    name: string;
    type: string;
    address: string;
  };
  amount: {
    total: number;
    currency: string;
    commission: number;
    netAmount: number;
    fees: {
      service: number;
      processing: number;
      tax: number;
    };
  };
  method: {
    type: 'bank_transfer' | 'credit_card' | 'paypal' | 'stripe' | 'cash';
    details: {
      bankName?: string;
      accountNumber?: string;
      last4?: string;
      cardType?: string;
      paypalEmail?: string;
      stripeAccountId?: string;
      cashReceivedBy?: string;
    };
  };
  status: 'pending' | 'processing' | 'completed' | 'failed' | 'cancelled' | 'refunded';
  scheduledDate?: Date;
  processedDate?: Date;
  completedDate?: Date;
  failureReason?: string;
  refundAmount?: number;
  refundReason?: string;
  receiptUrl?: string;
  transactionId?: string;
  notes?: string;
  assignedAgent: string;
  createdAt: Date;
  updatedAt: Date;
  createdBy: string;
}
interface PayoutAnalytics {
  total: number;
  pending: number;
  processing: number;
  completed: number;
  failed: number;
  cancelled: number;
  refunded: number;
  totalAmount: number;
  averageAmount: number;
  processingTime: {
    average: number;
    fastest: number;
    slowest: number;
  };
  methodDistribution: {
    bank_transfer: number;
    credit_card: number;
    paypal: number;
    stripe: number;
    cash: number;
  };
  failureRate: number;
  refundRate: number;
}
interface HelpDeskTicket {
  id: string;
  ticketNumber: string;
  subject: string;
  description: string;
  category: 'payment_issue' | 'refund_request' | 'technical_support' | 'general_inquiry' | 'complaint' | 'feature_request';
  priority: 'low' | 'medium' | 'high' | 'urgent';
  status: 'open' | 'in_progress' | 'pending_customer' | 'resolved' | 'closed' | 'cancelled';
  guest: {
    id: string;
    name: string;
    email: string;
    phone: string;
  };
  assignedAgent: string;
  messages: Array<{
    id: string;
    timestamp: Date;
    sender: 'agent' | 'guest';
    content: string;
    type: 'text' | 'file' | 'image';
    attachment?: {
      name: string;
      type: string;
      url: string;
    };
    isInternal: boolean;
  }>;
  satisfaction?: {
    rating?: number;
    comment?: string;
    resolvedAt?: Date;
  };
  resolution?: string;
  createdAt: Date;
  updatedAt: Date;
  resolvedAt?: Date;
  timeToFirstResponse?: number;
  timeToResolution?: number;
  tags: string[];
}
export default function PayoutAndHelpDesk() {
  const {
    t
  } = useTranslation();
  const {
    user
  } = useAuth();
  const { toast } = useToast();
  const [payouts, setPayouts] = useState<Payout[]>([]);
  const [filteredPayouts, setFilteredPayouts] = useState<Payout[]>([]);
  const [helpDeskTickets, setHelpDeskTickets] = useState<HelpDeskTicket[]>([]);
  const [filteredTickets, setFilteredTickets] = useState<HelpDeskTicket[]>([]);
  const [analytics, setAnalytics] = useState<{
    payouts: PayoutAnalytics | null;
    helpDesk: {
      total: number;
      open: number;
      inProgress: number;
      resolved: number;
      closed: number;
      averageResponseTime: number;
      averageResolutionTime: number;
      satisfactionRate: number;
    } | null;
  }>({
    payouts: null,
    helpDesk: null
  });
  const [filter, setFilter] = useState<{
    status?: string;
    method?: string;
    dateRange?: [Date, Date];
    category?: string;
    priority?: string;
    search?: string;
  }>({});
  const [selectedPayout, setSelectedPayout] = useState<Payout | null>(null);
  const [selectedTicket, setSelectedTicket] = useState<HelpDeskTicket | null>(null);
  const [isLive, setIsLive] = useState(true);

  const [isTicketActionOpen, setIsTicketActionOpen] = useState(false);
  const [ticketActionType, setTicketActionType] = useState<'message' | 'resolve' | 'escalate' | null>(null);
  const [ticketActionContent, setTicketActionContent] = useState('');

  // Mock data generation
  const generateMockPayouts = (): Payout[] => {
    const now = new Date();
    const methods: Payout['method']['type'][] = ['bank_transfer', 'credit_card', 'paypal', 'stripe', 'cash'];
    const statuses: Payout['status'][] = ['pending', 'processing', 'completed', 'failed', 'cancelled', 'refunded'];
    return Array.from({
      length: 25
    }, (_, i) => {
      const method = methods[Math.floor(Math.random() * methods.length)];
      const status = statuses[Math.floor(Math.random() * statuses.length)];
      const total = Math.floor(Math.random() * 5000) + 500;
      const commission = total * 0.15;
      const fees = {
        service: total * 0.05,
        processing: total * 0.02,
        tax: total * 0.18
      };
      return {
        id: `payout${i + 1}`,
        reservationId: `res${Math.floor(Math.random() * 100) + 1}`,
        guest: {
          id: `guest${Math.floor(Math.random() * 50) + 1}`,
          name: `Guest ${Math.floor(Math.random() * 100) + 1}`,
          email: `guest${Math.floor(Math.random() * 50) + 1}@email.com`,
          phone: `+12345678${Math.floor(Math.random() * 1000)}`,
          nationality: ['USA', 'UK', 'Germany', 'Turkey', 'France'][Math.floor(Math.random() * 5)]
        },
        property: {
          id: `prop${Math.floor(Math.random() * 20) + 1}`,
          name: `Property ${Math.floor(Math.random() * 10) + 1}`,
          type: ['Apartment', 'Villa', 'House'][Math.floor(Math.random() * 3)],
          address: `${Math.floor(Math.random() * 999)} Main St, Istanbul`
        },
        amount: {
          total,
          currency: 'USD',
          commission,
          netAmount: total - commission - Object.values(fees).reduce((sum, fee) => sum + fee, 0),
          fees
        },
        method: {
          type: method,
          details: method === 'bank_transfer' ? {
            bankName: 'Bank of America',
            accountNumber: '****1234',
            last4: '1234'
          } : method === 'credit_card' ? {
            cardType: 'Visa',
            last4: '****5678'
          } : method === 'paypal' ? {
            paypalEmail: 'payment@example.com'
          } : method === 'stripe' ? {
            stripeAccountId: 'acct_123456789'
          } : {
            cashReceivedBy: user?.name || 'Agent Smith'
          }
        },
        status,
        scheduledDate: status === 'pending' ? new Date(now.getTime() + Math.random() * 7 * 24 * 60 * 60 * 1000) : undefined,
        processedDate: status === 'processing' ? new Date(now.getTime() - Math.random() * 3 * 24 * 60 * 60 * 1000) : undefined,
        completedDate: status === 'completed' ? new Date(now.getTime() - Math.random() * 30 * 24 * 60 * 60 * 1000) : undefined,
        failureReason: status === 'failed' ? 'Insufficient funds' : undefined,
        refundAmount: status === 'refunded' ? total * 0.8 : undefined,
        transactionId: `txn_${Date.now()}_${i}`,
        receiptUrl: status === 'completed' ? `https://receipts.example.com/txn_${i}` : undefined,
        assignedAgent: user?.name || 'Agent Smith',
        createdAt: new Date(now.getTime() - Math.random() * 60 * 24 * 60 * 60 * 1000),
        updatedAt: new Date(now.getTime() - Math.random() * 24 * 60 * 60 * 1000),
        createdBy: 'System'
      };
    });
  };
  const generateMockHelpDeskTickets = (): HelpDeskTicket[] => {
    const now = new Date();
    const categories: HelpDeskTicket['category'][] = ['payment_issue', 'refund_request', 'technical_support', 'general_inquiry', 'complaint', 'feature_request'];
    const priorities: HelpDeskTicket['priority'][] = ['low', 'medium', 'high', 'urgent'];
    const statuses: HelpDeskTicket['status'][] = ['open', 'in_progress', 'pending_customer', 'resolved', 'closed'];
    return Array.from({
      length: 30
    }, (_, i) => {
      const category = categories[Math.floor(Math.random() * categories.length)];
      const priority = priorities[Math.floor(Math.random() * priorities.length)];
      const status = statuses[Math.floor(Math.random() * statuses.length)];
      return {
        id: `ticket${i + 1}`,
        ticketNumber: `TKT-${String(now.getFullYear()).slice(2)}${String(now.getMonth() + 1).padStart(2, '0')}${String(i + 1).padStart(5, '0')}`,
        subject: `${category.replace('_', ' ').charAt(0).toUpperCase() + category.replace('_', ' ').slice(1)} Issue`,
        description: `This is a ${category.replace('_', ' ')} that needs attention and resolution.`,
        category,
        priority,
        status,
        guest: {
          id: `guest${Math.floor(Math.random() * 100) + 1}`,
          name: `Customer ${Math.floor(Math.random() * 100) + 1}`,
          email: `customer${Math.floor(Math.random() * 100) + 1}@email.com`,
          phone: `+12345678${Math.floor(Math.random() * 1000)}`
        },
        assignedAgent: user?.name || 'Agent Smith',
        messages: [{
          id: `msg${i}1`,
          timestamp: new Date(now.getTime() - Math.random() * 7 * 24 * 60 * 60 * 1000),
          sender: 'guest',
          content: `I'm having an issue with ${category.replace('_', ' ')}`,
          type: 'text',
          isInternal: false
        }, {
          id: `msg${i}2`,
          timestamp: new Date(now.getTime() - Math.random() * 6 * 24 * 60 * 60 * 1000),
          sender: 'agent',
          content: `Thank you for contacting us. We're looking into your ${category.replace('_', ' ')} issue.`,
          type: 'text',
          isInternal: true
        }],
        satisfaction: status === 'resolved' ? {
          rating: Math.random() * 2 + 3,
          comment: 'Great service, issue was resolved quickly!',
          resolvedAt: new Date(now.getTime() - Math.random() * 2 * 24 * 60 * 60 * 1000)
        } : undefined,
        resolution: status === 'resolved' ? 'Issue was successfully resolved' : undefined,
        createdAt: new Date(now.getTime() - Math.random() * 30 * 24 * 60 * 60 * 1000),
        updatedAt: new Date(now.getTime() - Math.random() * 24 * 60 * 60 * 1000),
        resolvedAt: status === 'resolved' ? new Date(now.getTime() - Math.random() * 2 * 24 * 60 * 60 * 1000) : undefined,
        timeToFirstResponse: Math.floor(Math.random() * 24) + 1,
        timeToResolution: status === 'resolved' ? Math.floor(Math.random() * 72) + 1 : undefined,
        tags: [category, priority, status]
      };
    });
  };
  const generateMockAnalytics = () => {
    const payouts = generateMockPayouts();
    const tickets = generateMockHelpDeskTickets();
    const payoutAnalytics: PayoutAnalytics = {
      total: payouts.length,
      pending: payouts.filter(p => p.status === 'pending').length,
      processing: payouts.filter(p => p.status === 'processing').length,
      completed: payouts.filter(p => p.status === 'completed').length,
      failed: payouts.filter(p => p.status === 'failed').length,
      cancelled: payouts.filter(p => p.status === 'cancelled').length,
      refunded: payouts.filter(p => p.status === 'refunded').length,
      totalAmount: payouts.reduce((sum, p) => sum + p.amount.total, 0),
      averageAmount: payouts.reduce((sum, p) => sum + p.amount.total, 0) / payouts.length,
      processingTime: {
        average: 48,
        fastest: 12,
        slowest: 120
      },
      methodDistribution: {
        bank_transfer: payouts.filter(p => p.method.type === 'bank_transfer').length,
        credit_card: payouts.filter(p => p.method.type === 'credit_card').length,
        paypal: payouts.filter(p => p.method.type === 'paypal').length,
        stripe: payouts.filter(p => p.method.type === 'stripe').length,
        cash: payouts.filter(p => p.method.type === 'cash').length
      },
      failureRate: payouts.filter(p => p.status === 'failed').length / payouts.length * 100,
      refundRate: payouts.filter(p => p.status === 'refunded').length / payouts.length * 100
    };
    const helpDeskAnalytics = {
      total: tickets.length,
      open: tickets.filter(t => t.status === 'open').length,
      inProgress: tickets.filter(t => t.status === 'in_progress').length,
      resolved: tickets.filter(t => t.status === 'resolved').length,
      closed: tickets.filter(t => t.status === 'closed').length,
      averageResponseTime: tickets.reduce((sum, t) => sum + (t.timeToFirstResponse || 0), 0) / tickets.length,
      averageResolutionTime: tickets.filter(t => t.timeToResolution).reduce((sum, t) => sum + (t.timeToResolution || 0), 0) / tickets.filter(t => t.timeToResolution).length,
      satisfactionRate: tickets.filter(t => t.satisfaction?.rating).reduce((sum, t) => sum + (t.satisfaction?.rating || 0), 0) / tickets.filter(t => t.satisfaction?.rating).length
    };
    return {
      payouts: payoutAnalytics,
      helpDesk: helpDeskAnalytics
    };
  };

  // Initialize with mock data
  useEffect(() => {
    const mockPayouts = generateMockPayouts();
    const mockTickets = generateMockHelpDeskTickets();
    const mockAnalytics = generateMockAnalytics();
    setPayouts(mockPayouts);
    setHelpDeskTickets(mockTickets);
    setAnalytics(mockAnalytics);
  }, []);

  // Apply filters
  useEffect(() => {
    let filtered = [...payouts];
    if (filter.status) {
      filtered = filtered.filter(p => p.status === filter.status);
    }
    if (filter.method) {
      filtered = filtered.filter(p => p.method.type === filter.method);
    }
    if (filter.search) {
      filtered = filtered.filter(p => p.guest.name.toLowerCase().includes(filter.search!.toLowerCase()) || p.guest.email.toLowerCase().includes(filter.search!.toLowerCase()) || p.property.name.toLowerCase().includes(filter.search!.toLowerCase()));
    }
    setFilteredPayouts(filtered);
    let filteredTickets = [...helpDeskTickets];
    if (filter.category) {
      filteredTickets = filteredTickets.filter(t => t.category === filter.category);
    }
    if (filter.priority) {
      filteredTickets = filteredTickets.filter(t => t.priority === filter.priority);
    }
    if (filter.search) {
      filteredTickets = filteredTickets.filter(t => t.ticketNumber.toLowerCase().includes(filter.search!.toLowerCase()) || t.subject.toLowerCase().includes(filter.search!.toLowerCase()) || t.guest.name.toLowerCase().includes(filter.search!.toLowerCase()) || t.guest.email.toLowerCase().includes(filter.search!.toLowerCase()));
    }
    setFilteredTickets(filteredTickets);
  }, [payouts, helpDeskTickets, filter]);

  // Simulate live updates
  useEffect(() => {
    if (!isLive) return;
    const interval = setInterval(() => {
      // Update payouts
      setPayouts(prev => {
        const updated = prev.map(p => {
          if (p.status === 'pending' && Math.random() > 0.9) {
            return {
              ...p,
              status: 'processing' as const,
              processedDate: new Date()
            };
          }
          if (p.status === 'processing' && Math.random() > 0.8) {
            return {
              ...p,
              status: 'completed' as const,
              completedDate: new Date()
            };
          }
          return p;
        });
        return updated;
      });

      // Update tickets
      setHelpDeskTickets(prev => {
        const updated = prev.map(t => {
          if (t.status === 'open' && Math.random() > 0.85) {
            return {
              ...t,
              status: 'in_progress' as const,
              assignedAgent: user?.name || 'System'
            };
          }
          if (t.status === 'in_progress' && Math.random() > 0.9) {
            return {
              ...t,
              status: 'resolved' as const,
              satisfaction: {
                rating: Math.random() * 2 + 3,
                comment: 'Issue resolved successfully!'
              },
              resolvedAt: new Date(),
              timeToResolution: Math.floor(Math.random() * 48) + 1
            };
          }
          return t;
        });
        return updated;
      });
    }, 8000);
    return () => clearInterval(interval);
  }, [isLive]);
  const getStatusColor = (status: string) => {
    switch (status) {
      case 'pending':
        return 'bg-yellow-100 text-yellow-800';
      case 'processing':
        return 'bg-blue-100 text-blue-800';
      case 'completed':
        return 'bg-green-100 text-green-800';
      case 'failed':
        return 'bg-red-100 text-red-800';
      case 'cancelled':
        return 'bg-gray-100 text-gray-800';
      case 'refunded':
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
  const formatCurrency = (amount: number, currency: string) => {
    return new Intl.NumberFormat('en-US', {
      style: 'currency',
      currency
    }).format(amount);
  };
  const getMethodIcon = (method: string) => {
    switch (method) {
      case 'bank_transfer':
        return <Building className="w-4 h-4" />;
      case 'credit_card':
        return <CreditCardIcon className="w-4 h-4" />;
      case 'paypal':
        return <Globe className="w-4 h-4" />;
      case 'stripe':
        return <CreditCard className="w-4 h-4" />;
      case 'cash':
        return <Banknote className="w-4 h-4" />;
      default:
        return <DollarSign className="w-4 h-4" />;
    }
  };
  const getCategoryIcon = (category: string) => {
    switch (category) {
      case 'payment_issue':
        return <CreditCard className="w-4 h-4" />;
      case 'refund_request':
        return <Receipt className="w-4 h-4" />;
      case 'technical_support':
        return <AlertTriangle className="w-4 h-4" />;
      case 'general_inquiry':
        return <MessageSquare className="w-4 h-4" />;
      case 'complaint':
        return <XCircle className="w-4 h-4" />;
      case 'feature_request':
        return <Target className="w-4 h-4" />;
      default:
        return <Headphones className="w-4 h-4" />;
    }
  };
  const exportPayouts = () => {
    const csv = ['Reservation ID,Guest Name,Guest Email,Amount,Currency,Method,Status,Processed Date', ...filteredPayouts.map(p => `${p.reservationId},${p.guest.name},${p.guest.email},${p.amount.total},${p.amount.currency},${p.method.type},${p.status},${p.processedDate?.toISOString() || ''}`)].join('\n');
    const blob = new Blob([csv], {
      type: 'text/csv'
    });
    const url = window.URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = `payouts-${new Date().toISOString().split('T')[0]}.csv`;
    a.click();
    window.URL.revokeObjectURL(url);
  };
  return <div className="min-h-screen bg-background">
      <div className="container mx-auto p-6">
        <div className="mb-6">
          <h1 className="text-3xl font-bold">{t("client.src.payout_support_center")}</h1>
          <p className="text-muted-foreground">{t("client.src.manage_payouts_and_monitor")}</p>
        </div>

        {/* Analytics Dashboard */}
        {analytics && <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4 mb-6">
            {/* Payout Analytics */}
            <Card>
              <CardContent className="p-4">
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-sm font-medium text-muted-foreground">{t("client.src.total_payouts")}</p>
                    <p className="text-2xl font-bold">{analytics.payouts?.total || 0}</p>
                    <p className="text-xs text-muted-foreground">{formatCurrency(analytics.payouts?.totalAmount || 0, 'USD')}</p>
                  </div>
                  <DollarSign className="w-8 h-8 text-green-500" />
                </div>
              </CardContent>
            </Card>

            <Card>
              <CardContent className="p-4">
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-sm font-medium text-muted-foreground">{t("client.src.pending_payouts")}</p>
                    <p className="text-2xl font-bold">{analytics.payouts?.pending || 0}</p>
                  </div>
                  <Clock className="w-8 h-8 text-yellow-500" />
                </div>
              </CardContent>
            </Card>

            <Card>
              <CardContent className="p-4">
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-sm font-medium text-muted-foreground">{t("client.src.processing_time")}</p>
                    <p className="text-2xl font-bold">{analytics.payouts?.processingTime?.average || 0}h</p>
                    <p className="text-xs text-muted-foreground">{t("client.src.average")}</p>
                  </div>
                  <Activity className="w-8 h-8 text-blue-500" />
                </div>
              </CardContent>
            </Card>

            <Card>
              <CardContent className="p-4">
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-sm font-medium text-muted-foreground">{t("client.src.failure_rate")}</p>
                    <p className="text-2xl font-bold">{analytics.payouts?.failureRate?.toFixed(1) || 0}%</p>
                    <div className="flex items-center gap-1">
                      {analytics.payouts?.failureRate && analytics.payouts.failureRate > 5 ? <TrendingUp className="w-3 h-3 text-red-500" /> : <TrendingDown className="w-3 h-3 text-green-500" />}
                      <p className="text-xs text-muted-foreground">{t("client.src.vs_last_month")}</p>
                    </div>
                  </div>
                  <AlertTriangle className="w-8 h-8 text-red-500" />
                </div>
              </CardContent>
            </Card>

            {/* Help Desk Analytics */}
            <Card>
              <CardContent className="p-4">
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-sm font-medium text-muted-foreground">{t("client.src.open_support")}</p>
                    <p className="text-2xl font-bold">{analytics.helpDesk?.open || 0}</p>
                  </div>
                  <Headphones className="w-8 h-8 text-blue-500" />
                </div>
              </CardContent>
            </Card>

            <Card>
              <CardContent className="p-4">
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-sm font-medium text-muted-foreground">{t("client.src.response_time")}</p>
                    <p className="text-2xl font-bold">{analytics.helpDesk?.averageResponseTime || 0}h</p>
                    <p className="text-xs text-muted-foreground">{t("client.src.first_response")}</p>
                  </div>
                  <MessageSquare className="w-8 h-8 text-purple-500" />
                </div>
              </CardContent>
            </Card>

            <Card>
              <CardContent className="p-4">
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-sm font-medium text-muted-foreground">{t("client.src.satisfaction")}</p>
                    <p className="text-2xl font-bold">
                      {analytics.helpDesk?.satisfactionRate ? <div className="flex items-center gap-1">
                          <ThumbsUp className="w-3 h-3 text-green-500" />
                          <span>{analytics.helpDesk.satisfactionRate.toFixed(1)}</span>
                        </div> : 'N/A'}
                    </p>
                  </div>
                  <Smile className="w-8 h-8 text-green-500" />
                </div>
              </CardContent>
            </Card>
          </div>}

        {/* Status Overview */}
        <div className="grid gap-4 md:grid-cols-3 lg:grid-cols-6 mb-6">
          {[{
          status: 'pending',
          count: analytics.payouts?.pending || 0,
          label: t("client.src.pending"),
          color: 'bg-yellow-100 text-yellow-800'
        }, {
          status: 'processing',
          count: analytics.payouts?.processing || 0,
          label: t("client.src.processing"),
          color: 'bg-blue-100 text-blue-800'
        }, {
          status: 'completed',
          count: analytics.payouts?.completed || 0,
          label: t("client.src.completed"),
          color: 'bg-green-100 text-green-800'
        }, {
          status: 'failed',
          count: analytics.payouts?.failed || 0,
          label: t("client.src.failed"),
          color: 'bg-red-100 text-red-800'
        }, {
          status: 'refunded',
          count: analytics.payouts?.refunded || 0,
          label: t("client.src.refunded"),
          color: 'bg-purple-100 text-purple-800'
        }, {
          status: 'cancelled',
          count: analytics.payouts?.cancelled || 0,
          label: t("client.src.cancelled"),
          color: 'bg-gray-100 text-gray-800'
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
                  <div className="flex items-center gap-2">
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
            setPayouts(generateMockPayouts());
            setHelpDeskTickets(generateMockHelpDeskTickets());
            setAnalytics(generateMockAnalytics());
          }}>
              <RefreshCw className="w-4 h-4 mr-2" />{t("client.src.refresh")}</Button>

            <Button variant="outline" size="sm" onClick={exportPayouts}>
              <Download className="w-4 h-4 mr-2" />{t("client.src.download")}</Button>
          </div>

          <div className="flex items-center gap-2">
            <div className="relative">
              <Search className="absolute left-2 top-2.5 h-4 w-4 text-muted-foreground" />
              <input type="text" aria-label="Search payouts or support" placeholder={t("client.src.search_payout_or_support")} className="pl-8 pr-3 py-2 border rounded-md text-sm" value={filter.search || ''} onChange={e => setFilter({
              ...filter,
              search: e.target.value || undefined
            })} />
            </div>
            
            <Button variant="outline" size="sm">
              <Filter className="w-4 h-4 mr-2" />{t("client.src.filter")}</Button>
          </div>
        </div>

        <Tabs defaultValue="payouts" className="w-full">
          <TabsList className="grid w-full grid-cols-2">
            <TabsTrigger value="payouts">{t("client.src.payouts")}</TabsTrigger>
            <TabsTrigger value="help-desk">{t("client.src.support_center")}</TabsTrigger>
          </TabsList>

          <TabsContent value="payouts" className="space-y-6">
            {/* Payout Filters */}
            <div className="flex flex-wrap gap-2 mb-6">
              <select aria-label="Filter by status" className="px-3 py-1 border rounded-md text-sm" value={filter.status || ''} onChange={e => setFilter({
              ...filter,
              status: e.target.value || undefined
            })}>
                <option value="">{t("client.src.all_statuses")}</option>
                <option value="pending">{t("client.src.pending")}</option>
                <option value="processing">{t("client.src.processing")}</option>
                <option value="completed">{t("client.src.completed")}</option>
                <option value="failed">{t("client.src.failed")}</option>
                <option value="cancelled">{t("client.src.cancelled")}</option>
                <option value="refunded">{t("client.src.refunded")}</option>
              </select>

              <select aria-label="Filter by payment method" className="px-3 py-1 border rounded-md text-sm" value={filter.method || ''} onChange={e => setFilter({
              ...filter,
              method: e.target.value || undefined
            })}>
                <option value="">{t("client.src.all_payment_methods")}</option>
                <option value="bank_transfer">{t("client.src.bank_transfer")}</option>
                <option value="credit_card">{t("client.src.credit_card")}</option>
                <option value="paypal">{t("client.src.paypal")}</option>
                <option value="stripe">{t("client.src.stripe")}</option>
                <option value="cash">{t("client.src.cash")}</option>
              </select>
            </div>

            {/* Payouts List */}
            <Card>
              <CardHeader>
                <CardTitle>{t("client.src.payout_list")}</CardTitle>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  {filteredPayouts.map(payout => <div key={payout.id} className="border rounded-lg p-4 hover:bg-muted/50 transition-colors cursor-pointer" onClick={() => setSelectedPayout(payout)}>
                      <div className="flex items-start justify-between mb-3">
                        <div className="flex items-center gap-3">
                          <div className="w-12 h-12 bg-muted rounded-lg flex items-center justify-center">
                            {getMethodIcon(payout.method.type)}
                          </div>
                          <div>
                            <div className="flex items-center gap-2 mb-1">
                              <h2 className="font-medium">{payout.guest.name}</h2>
                              <Badge className={getStatusColor(payout.status)}>
                                {payout.status}
                              </Badge>
                            </div>
                            <p className="text-sm text-muted-foreground">{payout.property.name}</p>
                          </div>
                        </div>
                        <div className="text-right">
                          <p className="text-lg font-bold">{formatCurrency(payout.amount.total, payout.amount.currency)}</p>
                          <p className="text-sm text-muted-foreground">{payout.transactionId}</p>
                        </div>
                      </div>

                      <div className="grid grid-cols-2 md:grid-cols-4 gap-4 text-sm">
                        <div>
                          <p className="text-muted-foreground">{t("client.src.guest")}</p>
                          <p className="font-medium">{payout.guest.email}</p>
                          <p className="text-xs text-muted-foreground">{payout.guest.nationality}</p>
                        </div>
                        <div>
                          <p className="text-muted-foreground">{t("client.src.payment_method")}</p>
                          <p className="font-medium">{payout.method.type.replace('_', ' ')}</p>
                        </div>
                        <div>
                          <p className="text-muted-foreground">{t("client.src.commission")}</p>
                          <p className="font-medium">{formatCurrency(payout.amount.commission, payout.amount.currency)}</p>
                        </div>
                        <div>
                          <p className="text-muted-foreground">{t("client.src.net_amount")}</p>
                          <p className="font-medium">{formatCurrency(payout.amount.netAmount, payout.amount.currency)}</p>
                        </div>
                      </div>
                    </div>)}
                </div>
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="help-desk" className="space-y-6">
            {/* Help Desk Filters */}
            <div className="flex flex-wrap gap-2 mb-6">
              <select aria-label="Filter by category" className="px-3 py-1 border rounded-md text-sm" value={filter.category || ''} onChange={e => setFilter({
              ...filter,
              category: e.target.value || undefined
            })}>
                <option value="">{t("client.src.all_categories")}</option>
                <option value="payment_issue">{t("client.src.payment_issue")}</option>
                <option value="refund_request">{t("client.src.refund_request")}</option>
                <option value="technical_support">{t("client.src.technical_support")}</option>
                <option value="general_inquiry">{t("client.src.general_inquiry")}</option>
                <option value="complaint">{t("client.src.complaint")}</option>
                <option value="feature_request">{t("client.src.feature_request")}</option>
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
            </div>

            {/* Help Desk Tickets */}
            <Card>
              <CardHeader>
                <CardTitle>{t("client.src.support_tickets")}</CardTitle>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  {filteredTickets.map(ticket => <div key={ticket.id} className="border rounded-lg p-4 hover:bg-muted/50 transition-colors cursor-pointer" onClick={() => setSelectedTicket(ticket)}>
                      <div className="flex items-start justify-between mb-3">
                        <div className="flex items-center gap-3">
                          <div className="w-12 h-12 bg-muted rounded-lg flex items-center justify-center">
                            {getCategoryIcon(ticket.category)}
                          </div>
                          <div>
                            <div className="flex items-center gap-2 mb-1">
                              <h4 className="font-medium">#{ticket.ticketNumber}</h4>
                              <Badge className={getPriorityColor(ticket.priority)}>
                                {ticket.priority}
                              </Badge>
                              <Badge className={getStatusColor(ticket.status)}>
                                {ticket.status}
                              </Badge>
                            </div>
                            <p className="text-sm text-muted-foreground">{ticket.subject}</p>
                          </div>
                          <p className="text-xs text-muted-foreground">{ticket.guest.name}</p>
                        </div>
                        <div className="text-right">
                          <p className="text-sm font-medium">{ticket.assignedAgent}</p>
                          <p className="text-xs text-muted-foreground">{ticket.createdAt.toLocaleDateString()}</p>
                        </div>
                      </div>

                      <div className="flex items-center gap-2 mt-3">
                        <div className="flex items-center gap-1">
                          {ticket.satisfaction?.rating && <>
                              <ThumbsUp className="w-3 h-3 text-green-500" />
                              <span className="text-sm">{ticket.satisfaction.rating.toFixed(1)}</span>
                            </>}
                        </div>
                        <div className="flex items-center gap-1">
                          {ticket.timeToFirstResponse && <>
                              <Clock className="w-3 h-3 text-blue-500" />
                              <span className="text-sm">{ticket.timeToFirstResponse}h</span>
                            </>}
                        </div>
                        {ticket.timeToResolution && <>
                            <CheckCircle className="w-3 h-3 text-green-500" />
                            <span className="text-sm">{ticket.timeToResolution}h</span>
                          </>}
                      </div>
                    </div>)}
                </div>
              </CardContent>
            </Card>
          </TabsContent>
        </Tabs>

        {/* Payout Detail Modal */}
        {selectedPayout && <div className="fixed inset-0 bg-black/50 flex items-center justify-center p-4 z-50">
            <Card className="w-full max-w-4xl max-h-[90vh] overflow-auto">
              <CardHeader>
                <div className="flex items-center justify-between">
                  <CardTitle>{t("client.src.payout_detail")}{selectedPayout.transactionId}</CardTitle>
                  <Button variant="ghost" size="sm" onClick={() => setSelectedPayout(null)}>
                    ×
                  </Button>
                </div>
              </CardHeader>
              <CardContent className="space-y-6">
                {/* Payment Details */}
                <div>
                  <h3 className="text-lg font-medium mb-3">{t("client.src.payment_details")}</h3>
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <Card>
                      <CardContent className="p-4">
                        <div className="space-y-2">
                          <div className="flex justify-between">
                            <span className="text-sm font-medium text-muted-foreground">{t("client.src.status")}</span>
                            <Badge className={getStatusColor(selectedPayout.status)}>
                              {selectedPayout.status}
                            </Badge>
                          </div>
                          <div className="flex justify-between">
                            <span className="text-sm font-medium text-muted-foreground">{t("client.src.payment_method")}</span>
                            <span className="font-medium">{selectedPayout.method.type.replace('_', ' ')}</span>
                          </div>
                          <div className="flex justify-between">
                            <span className="text-sm font-medium text-muted-foreground">{t("client.src.transaction_id")}</span>
                            <span className="font-medium">{selectedPayout.transactionId}</span>
                          </div>
                        </div>
                      </CardContent>
                    </Card>
                    <Card>
                      <CardContent className="p-4">
                        <div className="space-y-2">
                          <div className="flex justify-between">
                            <span className="text-sm font-medium text-muted-foreground">{t("client.src.total_amount")}</span>
                            <span className="font-medium">{formatCurrency(selectedPayout.amount.total, selectedPayout.amount.currency)}</span>
                          </div>
                          <div className="flex justify-between">
                            <span className="text-sm font-medium text-muted-foreground">{t("client.src.commission")}</span>
                            <span className="font-medium">{formatCurrency(selectedPayout.amount.commission, selectedPayout.amount.currency)}</span>
                          </div>
                          <div className="flex justify-between">
                            <span className="text-sm font-medium text-muted-foreground">{t("client.src.net_amount")}</span>
                            <span className="font-medium">{formatCurrency(selectedPayout.amount.netAmount, selectedPayout.amount.currency)}</span>
                          </div>
                        </div>
                      </CardContent>
                    </Card>
                  </div>
                </div>

                {/* Actions */}
                <div className="flex gap-2 pt-4 border-t">
                  <Button onClick={() => toast({ title: t("client.src.payout_processed") })}>
                    <Zap className="w-4 h-4 mr-2" />{t("client.src.process")}</Button>
                  <Button variant="outline" onClick={() => {
                    if (selectedPayout.receiptUrl) window.open(selectedPayout.receiptUrl, '_blank');
                    else toast({ title: t("client.src.no_receipt_available"), variant: "destructive" });
                  }}>
                    <FileText className="w-4 h-4 mr-2" />{t("client.src.view_receipt")}</Button>
                  <Button variant="outline" onClick={() => toast({ title: t("client.src.export_started") })}>
                    <Download className="w-4 h-4 mr-2" />{t("client.src.download")}</Button>
                </div>
              </CardContent>
            </Card>
          </div>}

        {/* Help Desk Ticket Detail Modal */}
        {selectedTicket && <div className="fixed inset-0 bg-black/50 flex items-center justify-center p-4 z-50">
            <Card className="w-full max-w-4xl max-h-[90vh] overflow-auto">
              <CardHeader>
                <div className="flex items-center justify-between">
                  <CardTitle>{t("client.src.support_ticket")}{selectedTicket.ticketNumber}</CardTitle>
                  <Button variant="ghost" size="sm" onClick={() => setSelectedTicket(null)}>
                    ×
                  </Button>
                </div>
              </CardHeader>
              <CardContent className="space-y-6">
                {/* Ticket Details */}
                <div>
                  <h3 className="text-lg font-medium mb-3">{t("client.src.ticket_details")}</h3>
                  <Card>
                    <CardContent className="p-4">
                      <div className="space-y-2">
                        <div className="flex justify-between">
                          <span className="text-sm font-medium text-muted-foreground">{t("client.src.category")}</span>
                          <div className="flex items-center gap-2">
                            {getCategoryIcon(selectedTicket.category)}
                            <span className="font-medium">{selectedTicket.category.replace('_', ' ')}</span>
                          </div>
                        </div>
                        <div className="flex justify-between">
                          <span className="text-sm font-medium text-muted-foreground">{t("client.src.priority")}</span>
                          <Badge className={getPriorityColor(selectedTicket.priority)}>
                            {selectedTicket.priority}
                          </Badge>
                        </div>
                        <div className="flex justify-between">
                          <span className="text-sm font-medium text-muted-foreground">{t("client.src.status")}</span>
                          <Badge className={getStatusColor(selectedTicket.status)}>
                            {selectedTicket.status}
                          </Badge>
                        </div>
                      </div>
                    </CardContent>
                  </Card>
                </div>

                {/* Actions */}
                <div className="flex gap-2 pt-4 border-t">
                  <Button onClick={() => {
                    setTicketActionType('message');
                    setIsTicketActionOpen(true);
                  }}>
                    <Send className="w-4 h-4 mr-2" />{t("client.src.send_message")}</Button>
                  <Button variant="outline" onClick={() => {
                    setTicketActionType('resolve');
                    setIsTicketActionOpen(true);
                  }}>
                    <CheckCircle className="w-4 h-4 mr-2" />{t("client.src.resolve")}</Button>
                  <Button variant="outline" onClick={() => {
                    setTicketActionType('escalate');
                    setIsTicketActionOpen(true);
                  }}>
                    <AlertTriangle className="w-4 h-4 mr-2" />{t("client.src.escalate")}</Button>
                </div>
              </CardContent>
            </Card>
          </div>}

        <Dialog open={isTicketActionOpen} onOpenChange={setIsTicketActionOpen}>
          <DialogContent>
            <DialogHeader>
              <DialogTitle>
                {ticketActionType === 'message' && t("client.src.send_message")}
                {ticketActionType === 'resolve' && t("client.src.resolve_ticket")}
                {ticketActionType === 'escalate' && t("client.src.escalate_ticket")}
              </DialogTitle>
            </DialogHeader>
            <div className="space-y-4 py-4">
              <Label>{t("client.src.details")}</Label>
              <Textarea value={ticketActionContent} onChange={e => setTicketActionContent(e.target.value)} rows={4} placeholder={t("client.src.enter_details")} />
            </div>
            <DialogFooter>
              <Button variant="outline" onClick={() => setIsTicketActionOpen(false)}>{t("client.src.cancel")}</Button>
              <Button onClick={() => {
                toast({ title: t("client.src.action_completed") });
                setIsTicketActionOpen(false);
                setTicketActionContent('');
              }}>{t("client.src.submit")}</Button>
            </DialogFooter>
          </DialogContent>
        </Dialog>
      </div>
    </div>;
}