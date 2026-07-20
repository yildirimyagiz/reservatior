"use client";

import { useTranslation } from "react-i18next";
import { useState } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Input } from '@/components/ui/input';
import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar';
import { ScrollArea } from '@/components/ui/scroll-area';
import { Search, Filter, Plus, Download, CreditCard, CheckCircle, XCircle, Clock, AlertCircle, MoreVertical, Edit, RefreshCw, FileText, Mail, Phone, User, Settings } from 'lucide-react';
export default function Payments() {
  const {
    t
  } = useTranslation();
  const [selectedPayment, setSelectedPayment] = useState(1);
  const [searchQuery, setSearchQuery] = useState('');
  const [statusFilter, setStatusFilter] = useState('all');
  const [timeFilter, setTimeFilter] = useState('month');
  const payments = [{
    id: 1,
    tenant: 'John Doe',
    property: 'Sunset Apartments - Unit 4B',
    amount: '$2,500',
    type: 'rent',
    status: 'completed',
    method: 'bank_transfer',
    dueDate: '2024-01-01',
    paidDate: '2024-01-01',
    nextDueDate: '2024-02-01',
    recurring: true,
    autoPay: true,
    invoice: 'INV-2024-001',
    notes: 'Monthly rent payment',
    avatar: 'JD',
    email: 'john.doe@email.com',
    phone: '+1 (555) 123-4567'
  }, {
    id: 2,
    tenant: 'Sarah Johnson',
    property: 'Ocean View Villa - Unit 2A',
    amount: '$4,200',
    type: 'rent',
    status: 'pending',
    method: 'credit_card',
    dueDate: '2024-01-05',
    paidDate: null,
    nextDueDate: '2024-02-05',
    recurring: true,
    autoPay: false,
    invoice: 'INV-2024-002',
    notes: 'Monthly rent payment - overdue',
    avatar: 'SJ',
    email: 'sarah.johnson@email.com',
    phone: '+1 (555) 987-6543'
  }, {
    id: 3,
    tenant: 'Michael Chen',
    property: 'Downtown Loft - Unit 1C',
    amount: '$350',
    type: 'maintenance',
    status: 'failed',
    method: 'paypal',
    dueDate: '2024-01-10',
    paidDate: null,
    nextDueDate: null,
    recurring: false,
    autoPay: false,
    invoice: 'INV-2024-003',
    notes: 'Maintenance fee for plumbing repair',
    avatar: 'MC',
    email: 'michael.chen@email.com',
    phone: '+1 (555) 456-7890'
  }, {
    id: 4,
    tenant: 'Emily Williams',
    property: 'Garden Villa - Unit 3D',
    amount: '$1,250',
    type: 'deposit',
    status: 'completed',
    method: 'bank_transfer',
    dueDate: '2023-12-15',
    paidDate: '2023-12-14',
    nextDueDate: null,
    recurring: false,
    autoPay: false,
    invoice: 'INV-2023-045',
    notes: 'Security deposit for new lease',
    avatar: 'EW',
    email: 'emily.williams@email.com',
    phone: '+1 (555) 789-0123'
  }];
  const filteredPayments = payments.filter(payment => {
    const matchesSearch = payment.tenant.toLowerCase().includes(searchQuery.toLowerCase()) || payment.property.toLowerCase().includes(searchQuery.toLowerCase()) || payment.invoice.toLowerCase().includes(searchQuery.toLowerCase());
    const matchesStatus = statusFilter === 'all' || payment.status === statusFilter;
    return matchesSearch && matchesStatus;
  });
  const currentPayment = payments.find(p => p.id === selectedPayment);
  const getStatusColor = (status: string) => {
    switch (status) {
      case 'completed':
        return 'bg-green-100 text-green-800';
      case 'pending':
        return 'bg-yellow-100 text-yellow-800';
      case 'failed':
        return 'bg-red-100 text-red-800';
      case 'refunded':
        return 'bg-blue-100 text-blue-800';
      default:
        return 'bg-gray-100 text-gray-800';
    }
  };
  const getStatusIcon = (status: string) => {
    switch (status) {
      case 'completed':
        return <CheckCircle className="w-4 h-4" />;
      case 'pending':
        return <Clock className="w-4 h-4" />;
      case 'failed':
        return <XCircle className="w-4 h-4" />;
      case 'refunded':
        return <RefreshCw className="w-4 h-4" />;
      default:
        return <AlertCircle className="w-4 h-4" />;
    }
  };
  const getTypeColor = (type: string) => {
    switch (type) {
      case 'rent':
        return 'bg-purple-100 text-purple-800';
      case 'deposit':
        return 'bg-blue-100 text-blue-800';
      case 'maintenance':
        return 'bg-orange-100 text-orange-800';
      case 'utilities':
        return 'bg-green-100 text-green-800';
      default:
        return 'bg-gray-100 text-gray-800';
    }
  };
  const totalRevenue = payments.filter(p => p.status === 'completed').reduce((sum, p) => sum + parseFloat(p.amount.replace(/[$,]/g, '')), 0);
  const pendingAmount = payments.filter(p => p.status === 'pending').reduce((sum, p) => sum + parseFloat(p.amount.replace(/[$,]/g, '')), 0);
  const failedAmount = payments.filter(p => p.status === 'failed').reduce((sum, p) => sum + parseFloat(p.amount.replace(/[$,]/g, '')), 0);
  return <div className="h-full flex">
      {/* Payments List */}
      <div className="w-96 border-r bg-gray-50">
        <div className="p-4 border-b">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold">{t("client.src.payments")}</h2>
            <Button size="sm">
              <Plus className="w-4 h-4 mr-2" />{t("client.src.new_payment")}</Button>
          </div>
          
          {/* Search and Filter */}
          <div className="space-y-3">
            <div className="relative">
              <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 w-4 h-4 text-gray-400" />
              <Input placeholder={t("client.src.search_payments")} value={searchQuery} onChange={e => setSearchQuery(e.target.value)} className="pl-10" />
            </div>
            
            <div className="flex gap-2">
              <select value={statusFilter} onChange={e => setStatusFilter(e.target.value)} className="flex-1 px-3 py-2 text-sm border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500">
                <option value="all">{t("client.src.all_status")}</option>
                <option value="completed">{t("client.src.completed")}</option>
                <option value="pending">{t("client.src.pending")}</option>
                <option value="failed">{t("client.src.failed")}</option>
                <option value="refunded">{t("client.src.refunded")}</option>
              </select>
              <Button variant="outline" size="sm">
                <Filter className="w-4 h-4" />
              </Button>
            </div>

            {/* Time Filter */}
            <div className="flex gap-2">
              <select value={timeFilter} onChange={e => setTimeFilter(e.target.value)} className="flex-1 px-3 py-2 text-sm border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500">
                <option value="today">{t("client.src.today")}</option>
                <option value="week">{t("client.src.this_week")}</option>
                <option value="month">{t("client.src.this_month")}</option>
                <option value="quarter">{t("client.src.this_quarter")}</option>
                <option value="year">{t("client.src.this_year")}</option>
              </select>
            </div>
          </div>
        </div>
        
        <ScrollArea className="flex-1">
          <div className="p-2">
            {filteredPayments.map(payment => <div key={payment.id} onClick={() => setSelectedPayment(payment.id)} className={`p-3 rounded-lg cursor-pointer transition-colors mb-2 ${selectedPayment === payment.id ? 'bg-purple-50 border border-purple-200' : 'hover:bg-gray-100'}`}>
                <div className="flex items-start gap-3">
                  <Avatar className="w-10 h-10">
                    <AvatarImage src={`/api/placeholder/avatar-${payment.id}.jpg`} />
                    <AvatarFallback>{payment.avatar}</AvatarFallback>
                  </Avatar>
                  <div className="flex-1 min-w-0">
                    <div className="flex items-center justify-between mb-1">
                      <p className="font-medium text-sm truncate">{payment.tenant}</p>
                      <p className="font-bold text-sm">{payment.amount}</p>
                    </div>
                    <p className="text-xs text-gray-600 truncate">{payment.property}</p>
                    <div className="flex items-center gap-2 mt-2">
                      <Badge className={`text-xs ${getStatusColor(payment.status)}`}>
                        {getStatusIcon(payment.status)}
                        <span className="ml-1">{payment.status}</span>
                      </Badge>
                      <Badge className={`text-xs ${getTypeColor(payment.type)}`}>
                        {payment.type}
                      </Badge>
                      {payment.recurring && <Badge variant="outline" className="text-xs">{t("client.src.recurring")}</Badge>}
                      {payment.autoPay && <Badge variant="outline" className="text-xs">{t("client.src.autopay")}</Badge>}
                    </div>
                    <div className="flex items-center justify-between mt-2 text-xs text-gray-500">
                      <span>{t("client.src.due")}{payment.dueDate}</span>
                      <span>{payment.invoice}</span>
                    </div>
                  </div>
                </div>
              </div>)}
          </div>
        </ScrollArea>
      </div>

      {/* Payment Details */}
      <div className="flex-1">
        {currentPayment && <div className="h-full flex flex-col">
            {/* Payment Header */}
            <div className="p-6 border-b bg-white">
              <div className="flex items-center justify-between">
                <div className="flex items-center gap-4">
                  <Avatar className="w-12 h-12">
                    <AvatarImage src={`/api/placeholder/avatar-${currentPayment.id}.jpg`} />
                    <AvatarFallback className="text-lg">{currentPayment.avatar}</AvatarFallback>
                  </Avatar>
                  <div>
                    <h3 className="text-xl font-semibold">{currentPayment.tenant}</h3>
                    <div className="flex items-center gap-2 mt-1">
                      <Badge className={getStatusColor(currentPayment.status)}>
                        {getStatusIcon(currentPayment.status)}
                        <span className="ml-1">{currentPayment.status}</span>
                      </Badge>
                      <Badge className={getTypeColor(currentPayment.type)}>
                        {currentPayment.type}
                      </Badge>
                      {currentPayment.recurring && <Badge variant="outline">{t("client.src.recurring")}</Badge>}
                    </div>
                    <p className="text-sm text-gray-600 mt-1">{currentPayment.property}</p>
                  </div>
                </div>
                <div className="flex items-center gap-2">
                  <Button size="sm">
                    <Edit className="w-4 h-4 mr-2" />{t("client.src.edit")}</Button>
                  <Button size="sm" variant="outline">
                    <FileText className="w-4 h-4 mr-2" />{t("client.src.invoice")}</Button>
                  <Button size="sm" variant="outline">
                    <MoreVertical className="w-4 h-4" />
                  </Button>
                </div>
              </div>
            </div>

            {/* Payment Content */}
            <ScrollArea className="flex-1 p-6">
              <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
                {/* Main Info */}
                <div className="lg:col-span-2 space-y-6">
                  {/* Payment Details */}
                  <Card>
                    <CardHeader>
                      <CardTitle className="flex items-center gap-2">
                        <CreditCard className="w-5 h-5" />{t("client.src.payment_details")}</CardTitle>
                    </CardHeader>
                    <CardContent>
                      <div className="space-y-4">
                        <div className="grid grid-cols-2 gap-4">
                          <div>
                            <p className="font-medium">{t("client.src.amount")}</p>
                            <p className="text-2xl font-bold text-green-600">{currentPayment.amount}</p>
                          </div>
                          <div>
                            <p className="font-medium">{t("client.src.invoice")}</p>
                            <p className="text-sm text-gray-600">{currentPayment.invoice}</p>
                          </div>
                        </div>
                        <div className="grid grid-cols-2 gap-4">
                          <div>
                            <p className="font-medium">{t("client.src.due_date")}</p>
                            <p className="text-sm text-gray-600">{currentPayment.dueDate}</p>
                          </div>
                          <div>
                            <p className="font-medium">{t("client.src.paid_date")}</p>
                            <p className="text-sm text-gray-600">
                              {currentPayment.paidDate || 'Not paid yet'}
                            </p>
                          </div>
                        </div>
                        <div className="grid grid-cols-2 gap-4">
                          <div>
                            <p className="font-medium">{t("client.src.payment_method")}</p>
                            <p className="text-sm text-gray-600 capitalize">
                              {currentPayment.method.replace('_', ' ')}
                            </p>
                          </div>
                          <div>
                            <p className="font-medium">{t("client.src.next_due_date")}</p>
                            <p className="text-sm text-gray-600">
                              {currentPayment.nextDueDate || 'N/A'}
                            </p>
                          </div>
                        </div>
                        <div>
                          <p className="font-medium">{t("client.src.notes")}</p>
                          <p className="text-sm text-gray-600">{currentPayment.notes}</p>
                        </div>
                      </div>
                    </CardContent>
                  </Card>

                  {/* Tenant Information */}
                  <Card>
                    <CardHeader>
                      <CardTitle className="flex items-center gap-2">
                        <User className="w-5 h-5" />{t("client.src.tenant_information")}</CardTitle>
                    </CardHeader>
                    <CardContent>
                      <div className="space-y-4">
                        <div className="flex items-center gap-4">
                          <Avatar className="w-12 h-12">
                            <AvatarImage src={`/api/placeholder/avatar-${currentPayment.id}.jpg`} />
                            <AvatarFallback>{currentPayment.avatar}</AvatarFallback>
                          </Avatar>
                          <div>
                            <p className="font-medium">{currentPayment.tenant}</p>
                            <div className="flex items-center gap-2 text-sm text-gray-600">
                              <div className="flex items-center gap-1">
                                <Mail className="w-4 h-4" />
                                {currentPayment.email}
                              </div>
                            </div>
                            <div className="flex items-center gap-1 text-sm text-gray-600">
                              <Phone className="w-4 h-4" />
                              {currentPayment.phone}
                            </div>
                          </div>
                        </div>
                        <div>
                          <p className="font-medium">{t("client.src.property")}</p>
                          <p className="text-sm text-gray-600">{currentPayment.property}</p>
                        </div>
                      </div>
                    </CardContent>
                  </Card>

                  {/* Payment History */}
                  <Card>
                    <CardHeader>
                      <CardTitle>{t("client.src.payment_history")}</CardTitle>
                    </CardHeader>
                    <CardContent>
                      <div className="space-y-3">
                        {[{
                      date: '2024-01-01',
                      amount: '$2,500',
                      status: 'completed',
                      method: 'bank_transfer'
                    }, {
                      date: '2023-12-01',
                      amount: '$2,500',
                      status: 'completed',
                      method: 'bank_transfer'
                    }, {
                      date: '2023-11-01',
                      amount: '$2,500',
                      status: 'completed',
                      method: 'bank_transfer'
                    }, {
                      date: '2023-10-01',
                      amount: '$2,500',
                      status: 'completed',
                      method: 'bank_transfer'
                    }].map((payment, index) => <div key={index} className="flex items-center justify-between p-3 border rounded">
                            <div>
                              <p className="font-medium">{payment.date}</p>
                              <p className="text-sm text-gray-600 capitalize">{payment.method.replace('_', ' ')}</p>
                            </div>
                            <div className="text-right">
                              <p className="font-medium">{payment.amount}</p>
                              <Badge className={`text-xs ${getStatusColor(payment.status)}`}>
                                {payment.status}
                              </Badge>
                            </div>
                          </div>)}
                      </div>
                    </CardContent>
                  </Card>
                </div>

                {/* Sidebar */}
                <div className="space-y-6">
                  {/* Quick Actions */}
                  <Card>
                    <CardHeader>
                      <CardTitle>{t("client.src.quick_actions")}</CardTitle>
                    </CardHeader>
                    <CardContent className="space-y-2">
                      {currentPayment.status === 'pending' && <Button size="sm" className="w-full">
                          <CheckCircle className="w-4 h-4 mr-2" />{t("client.src.mark_as_paid")}</Button>}
                      {currentPayment.status === 'failed' && <Button size="sm" className="w-full">
                          <RefreshCw className="w-4 h-4 mr-2" />{t("client.src.retry_payment")}</Button>}
                      <Button size="sm" variant="outline" className="w-full">
                        <Mail className="w-4 h-4 mr-2" />{t("client.src.send_reminder")}</Button>
                      <Button size="sm" variant="outline" className="w-full">
                        <FileText className="w-4 h-4 mr-2" />{t("client.src.generate_invoice")}</Button>
                      <Button size="sm" variant="outline" className="w-full">
                        <Download className="w-4 h-4 mr-2" />{t("client.src.download_receipt")}</Button>
                    </CardContent>
                  </Card>

                  {/* Payment Summary */}
                  <Card>
                    <CardHeader>
                      <CardTitle>{t("client.src.payment_summary")}</CardTitle>
                    </CardHeader>
                    <CardContent className="space-y-3">
                      <div className="flex items-center justify-between">
                        <span className="text-sm">{t("client.src.total_revenue")}</span>
                        <span className="font-bold text-green-600">${totalRevenue.toLocaleString()}</span>
                      </div>
                      <div className="flex items-center justify-between">
                        <span className="text-sm">{t("client.src.pending")}</span>
                        <span className="font-bold text-yellow-600">${pendingAmount.toLocaleString()}</span>
                      </div>
                      <div className="flex items-center justify-between">
                        <span className="text-sm">{t("client.src.failed")}</span>
                        <span className="font-bold text-red-600">${failedAmount.toLocaleString()}</span>
                      </div>
                      <div className="pt-2 border-t">
                        <div className="flex items-center justify-between">
                          <span className="text-sm">{t("client.src.net_revenue")}</span>
                          <span className="font-bold text-purple-600">
                            ${(totalRevenue - failedAmount).toLocaleString()}
                          </span>
                        </div>
                      </div>
                    </CardContent>
                  </Card>

                  {/* Recurring Settings */}
                  {currentPayment.recurring && <Card>
                      <CardHeader>
                        <CardTitle>{t("client.src.recurring_settings")}</CardTitle>
                      </CardHeader>
                      <CardContent className="space-y-3">
                        <div className="flex items-center justify-between">
                          <span className="text-sm">{t("client.src.autopay")}</span>
                          <Badge className={currentPayment.autoPay ? 'bg-green-100 text-green-800' : 'bg-gray-100 text-gray-800'}>
                            {currentPayment.autoPay ? 'Enabled' : 'Disabled'}
                          </Badge>
                        </div>
                        <div className="flex items-center justify-between">
                          <span className="text-sm">{t("client.src.next_payment")}</span>
                          <span className="text-sm font-medium">{currentPayment.nextDueDate}</span>
                        </div>
                        <Button size="sm" variant="outline" className="w-full">
                          <Settings className="w-4 h-4 mr-2" />{t("client.src.manage_recurring")}</Button>
                      </CardContent>
                    </Card>}
                </div>
              </div>
            </ScrollArea>
          </div>}
      </div>
    </div>;
}