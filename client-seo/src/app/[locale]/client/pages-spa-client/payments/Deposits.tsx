"use client";

import { useTranslation } from "react-i18next";
import { useState } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Input } from '@/components/ui/input';
import { ScrollArea } from '@/components/ui/scroll-area';
import { Search, Plus, Download, CheckCircle, XCircle, Clock, AlertCircle, MoreVertical, Edit, FileText, Shield, Calculator, DollarSign } from 'lucide-react';
import { Avatar, AvatarFallback, AvatarImage } from '@radix-ui/react-avatar';
export default function Deposits() {
  const {
    t
  } = useTranslation();
  const [selectedDeposit, setSelectedDeposit] = useState(1);
  const [searchQuery, setSearchQuery] = useState('');
  const [statusFilter, setStatusFilter] = useState('all');
  const [typeFilter, setTypeFilter] = useState('all');
  const deposits = [{
    id: 1,
    tenant: 'John Doe',
    property: 'Sunset Apartments - Unit 4B',
    amount: '$5,000',
    type: 'security',
    status: 'held',
    depositDate: '2024-01-15',
    expectedReturn: '2024-06-15',
    actualReturn: null,
    deductions: 0,
    refundAmount: '$5,000',
    interest: 0,
    invoice: 'DEP-2024-001',
    notes: 'Standard security deposit for 6-month lease',
    avatar: 'JD',
    email: 'john.doe@email.com',
    phone: '+1 (555) 123-4567',
    leaseId: 'LEASE-2024-001',
    propertyCondition: 'excellent',
    inspectionDate: '2024-01-10',
    bankAccount: '****1234',
    insurance: 'covered'
  }, {
    id: 2,
    tenant: 'Sarah Johnson',
    property: 'Ocean View Villa - Unit 2A',
    amount: '$8,500',
    type: 'security',
    status: 'partial_refund',
    depositDate: '2023-12-01',
    expectedReturn: '2024-03-01',
    actualReturn: '2024-03-05',
    deductions: 1200,
    refundAmount: '$7,300',
    interest: 0,
    invoice: 'DEP-2023-045',
    notes: 'Security deposit - $1,200 deducted for damages',
    avatar: 'SJ',
    email: 'sarah.johnson@email.com',
    phone: '+1 (555) 987-6543',
    leaseId: 'LEASE-2023-045',
    propertyCondition: 'good',
    inspectionDate: '2024-02-28',
    bankAccount: '****5678',
    insurance: 'covered'
  }, {
    id: 3,
    tenant: 'Michael Chen',
    property: 'Downtown Loft - Unit 1C',
    amount: '$3,000',
    type: 'pet',
    status: 'held',
    depositDate: '2024-01-20',
    expectedReturn: '2024-07-20',
    actualReturn: null,
    deductions: 0,
    refundAmount: '$3,000',
    interest: 0,
    invoice: 'DEP-2024-002',
    notes: 'Pet deposit for small dog',
    avatar: 'MC',
    email: 'michael.chen@email.com',
    phone: '+1 (555) 456-7890',
    leaseId: 'LEASE-2024-002',
    propertyCondition: 'good',
    inspectionDate: '2024-01-18',
    bankAccount: '****9012',
    insurance: 'covered'
  }, {
    id: 4,
    tenant: 'Emily Williams',
    property: 'Garden Villa - Unit 3D',
    amount: '$2,500',
    type: 'key',
    status: 'refunded',
    depositDate: '2023-11-15',
    expectedReturn: '2024-01-15',
    actualReturn: '2024-01-18',
    deductions: 0,
    refundAmount: '$2,500',
    interest: 25,
    invoice: 'DEP-2023-089',
    notes: 'Key deposit - refunded with interest',
    avatar: 'EW',
    email: 'emily.williams@email.com',
    phone: '+1 (555) 789-0123',
    leaseId: 'LEASE-2023-089',
    propertyCondition: 'excellent',
    inspectionDate: '2024-01-12',
    bankAccount: '****3456',
    insurance: 'covered'
  }];
  const filteredDeposits = deposits.filter(deposit => {
    const matchesSearch = deposit.tenant.toLowerCase().includes(searchQuery.toLowerCase()) || deposit.property.toLowerCase().includes(searchQuery.toLowerCase()) || deposit.invoice.toLowerCase().includes(searchQuery.toLowerCase());
    const matchesStatus = statusFilter === 'all' || deposit.status === statusFilter;
    const matchesType = typeFilter === 'all' || deposit.type === typeFilter;
    return matchesSearch && matchesStatus && matchesType;
  });
  const currentDeposit = deposits.find(d => d.id === selectedDeposit);
  const getStatusColor = (status: string) => {
    switch (status) {
      case 'held':
        return 'bg-blue-100 text-blue-800';
      case 'refunded':
        return 'bg-green-100 text-green-800';
      case 'partial_refund':
        return 'bg-yellow-100 text-yellow-800';
      case 'forfeited':
        return 'bg-red-100 text-red-800';
      default:
        return 'bg-gray-100 text-gray-800';
    }
  };
  const getStatusIcon = (status: string) => {
    switch (status) {
      case 'held':
        return <Shield className="w-4 h-4" />;
      case 'refunded':
        return <CheckCircle className="w-4 h-4" />;
      case 'partial_refund':
        return <AlertCircle className="w-4 h-4" />;
      case 'forfeited':
        return <XCircle className="w-4 h-4" />;
      default:
        return <Clock className="w-4 h-4" />;
    }
  };
  const getTypeColor = (type: string) => {
    switch (type) {
      case 'security':
        return 'bg-purple-100 text-purple-800';
      case 'pet':
        return 'bg-orange-100 text-orange-800';
      case 'key':
        return 'bg-blue-100 text-blue-800';
      case 'damage':
        return 'bg-red-100 text-red-800';
      default:
        return 'bg-gray-100 text-gray-800';
    }
  };
  const totalDeposits = deposits.reduce((sum, d) => sum + parseFloat(d.amount.replace(/[$,]/g, '')), 0);
  const totalRefunds = deposits.filter(d => d.status === 'refunded' || d.status === 'partial_refund').reduce((sum, d) => sum + parseFloat(d.refundAmount.replace(/[$,]/g, '')), 0);
  const totalDeductions = deposits.reduce((sum, d) => sum + d.deductions, 0);
  return <div className="h-full flex">
      {/* Deposits List */}
      <div className="w-96 border-r bg-gray-50">
        <div className="p-4 border-b">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold">{t("client.src.deposits")}</h2>
            <Button size="sm">
              <Plus className="w-4 h-4 mr-2" />{t("client.src.new_deposit")}</Button>
          </div>
          
          {/* Search and Filter */}
          <div className="space-y-3">
            <div className="relative">
              <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 w-4 h-4 text-gray-400" />
              <Input placeholder={t("client.src.search_deposits")} value={searchQuery} onChange={e => setSearchQuery(e.target.value)} className="pl-10" />
            </div>
            
            <div className="flex gap-2">
              <select value={statusFilter} onChange={e => setStatusFilter(e.target.value)} className="flex-1 px-3 py-2 text-sm border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500">
                <option value="all">{t("client.src.all_status")}</option>
                <option value="held">{t("client.src.held")}</option>
                <option value="refunded">{t("client.src.refunded")}</option>
                <option value="partial_refund">{t("client.src.partial_refund")}</option>
                <option value="forfeited">{t("client.src.forfeited")}</option>
              </select>
              <select value={typeFilter} onChange={e => setTypeFilter(e.target.value)} className="flex-1 px-3 py-2 text-sm border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500">
                <option value="all">{t("client.src.all_types")}</option>
                <option value="security">{t("client.src.security")}</option>
                <option value="pet">{t("client.src.pet")}</option>
                <option value="key">{t("client.src.key")}</option>
                <option value="damage">{t("client.src.damage")}</option>
              </select>
            </div>
          </div>
        </div>
        
        <ScrollArea className="flex-1">
          <div className="p-2">
            {filteredDeposits.map(deposit => <div key={deposit.id} onClick={() => setSelectedDeposit(deposit.id)} className={`p-3 rounded-lg cursor-pointer transition-colors mb-2 ${selectedDeposit === deposit.id ? 'bg-purple-50 border border-purple-200' : 'hover:bg-gray-100'}`}>
                <div className="flex items-start gap-3">
                  <Avatar className="w-10 h-10">
                    <AvatarImage src={`/api/placeholder/avatar-${deposit.id}.jpg`} />
                    <AvatarFallback>{deposit.avatar}</AvatarFallback>
                  </Avatar>
                  <div className="flex-1 min-w-0">
                    <div className="flex items-center justify-between mb-1">
                      <p className="font-medium text-sm truncate">{deposit.tenant}</p>
                      <p className="font-bold text-sm">{deposit.amount}</p>
                    </div>
                    <p className="text-xs text-gray-600 truncate">{deposit.property}</p>
                    <div className="flex items-center gap-2 mt-2">
                      <Badge className={`text-xs ${getStatusColor(deposit.status)}`}>
                        {getStatusIcon(deposit.status)}
                        <span className="ml-1">{deposit.status.replace('_', ' ')}</span>
                      </Badge>
                      <Badge className={`text-xs ${getTypeColor(deposit.type)}`}>
                        {deposit.type}
                      </Badge>
                      {deposit.deductions > 0 && <Badge variant="outline" className="text-xs text-red-600">
                          -${deposit.deductions}
                        </Badge>}
                    </div>
                    <div className="flex items-center justify-between mt-2 text-xs text-gray-500">
                      <span>{t("client.src.deposited")}{deposit.depositDate}</span>
                      <span>{deposit.invoice}</span>
                    </div>
                  </div>
                </div>
              </div>)}
          </div>
        </ScrollArea>
      </div>

      {/* Deposit Details */}
      <div className="flex-1">
        {currentDeposit && <div className="h-full flex flex-col">
            {/* Deposit Header */}
            <div className="p-6 border-b bg-white">
              <div className="flex items-center justify-between">
                <div className="flex items-center gap-4">
                  <Avatar className="w-12 h-12">
                    <AvatarImage src={`/api/placeholder/avatar-${currentDeposit.id}.jpg`} />
                    <AvatarFallback className="text-lg">{currentDeposit.avatar}</AvatarFallback>
                  </Avatar>
                  <div>
                    <h3 className="text-xl font-semibold">{currentDeposit.tenant}</h3>
                    <div className="flex items-center gap-2 mt-1">
                      <Badge className={getStatusColor(currentDeposit.status)}>
                        {getStatusIcon(currentDeposit.status)}
                        <span className="ml-1">{currentDeposit.status.replace('_', ' ')}</span>
                      </Badge>
                      <Badge className={getTypeColor(currentDeposit.type)}>
                        {currentDeposit.type}
                      </Badge>
                    </div>
                    <p className="text-sm text-gray-600 mt-1">{currentDeposit.property}</p>
                  </div>
                </div>
                <div className="flex items-center gap-2">
                  <Button size="sm">
                    <Edit className="w-4 h-4 mr-2" />{t("client.src.edit")}</Button>
                  <Button size="sm" variant="outline">
                    <FileText className="w-4 h-4 mr-2" />{t("client.src.receipt")}</Button>
                  <Button size="sm" variant="outline">
                    <MoreVertical className="w-4 h-4" />
                  </Button>
                </div>
              </div>
            </div>

            {/* Deposit Content */}
            <ScrollArea className="flex-1 p-6">
              <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
                {/* Main Info */}
                <div className="lg:col-span-2 space-y-6">
                  {/* Deposit Details */}
                  <Card>
                    <CardHeader>
                      <CardTitle className="flex items-center gap-2">
                        <DollarSign className="w-5 h-5" />{t("client.src.deposit_details")}</CardTitle>
                    </CardHeader>
                    <CardContent>
                      <div className="space-y-4">
                        <div className="grid grid-cols-2 gap-4">
                          <div>
                            <p className="font-medium">{t("client.src.deposit_amount")}</p>
                            <p className="text-2xl font-bold text-blue-600">{currentDeposit.amount}</p>
                          </div>
                          <div>
                            <p className="font-medium">{t("client.src.refund_amount")}</p>
                            <p className="text-2xl font-bold text-green-600">{currentDeposit.refundAmount}</p>
                          </div>
                        </div>
                        <div className="grid grid-cols-2 gap-4">
                          <div>
                            <p className="font-medium">{t("client.src.deposit_date")}</p>
                            <p className="text-sm text-gray-600">{currentDeposit.depositDate}</p>
                          </div>
                          <div>
                            <p className="font-medium">{t("client.src.expected_return")}</p>
                            <p className="text-sm text-gray-600">{currentDeposit.expectedReturn}</p>
                          </div>
                        </div>
                        <div className="grid grid-cols-2 gap-4">
                          <div>
                            <p className="font-medium">{t("client.src.actual_return")}</p>
                            <p className="text-sm text-gray-600">
                              {currentDeposit.actualReturn || 'Not returned yet'}
                            </p>
                          </div>
                          <div>
                            <p className="font-medium">{t("client.src.interest_earned")}</p>
                            <p className="text-sm text-gray-600">${currentDeposit.interest}</p>
                          </div>
                        </div>
                        {currentDeposit.deductions > 0 && <div className="p-3 bg-red-50 border border-red-200 rounded-lg">
                            <p className="font-medium text-red-800">{t("client.src.deductions")}{currentDeposit.deductions}</p>
                            <p className="text-sm text-red-600">{t("client.src.deducted_for_damagescleaning")}</p>
                          </div>}
                        <div>
                          <p className="font-medium">{t("client.src.notes")}</p>
                          <p className="text-sm text-gray-600">{currentDeposit.notes}</p>
                        </div>
                      </div>
                    </CardContent>
                  </Card>

                  {/* Property Information */}
                  <Card>
                    <CardHeader>
                      <CardTitle className="flex items-center gap-2">
                        <Shield className="w-5 h-5" />{t("client.src.property_lease_information")}</CardTitle>
                    </CardHeader>
                    <CardContent>
                      <div className="space-y-4">
                        <div className="grid grid-cols-2 gap-4">
                          <div>
                            <p className="font-medium">{t("client.src.property")}</p>
                            <p className="text-sm text-gray-600">{currentDeposit.property}</p>
                          </div>
                          <div>
                            <p className="font-medium">{t("client.src.lease_id")}</p>
                            <p className="text-sm text-gray-600">{currentDeposit.leaseId}</p>
                          </div>
                        </div>
                        <div className="grid grid-cols-2 gap-4">
                          <div>
                            <p className="font-medium">{t("client.src.property_condition")}</p>
                            <p className="text-sm text-gray-600 capitalize">{currentDeposit.propertyCondition}</p>
                          </div>
                          <div>
                            <p className="font-medium">{t("client.src.inspection_date")}</p>
                            <p className="text-sm text-gray-600">{currentDeposit.inspectionDate}</p>
                          </div>
                        </div>
                        <div className="grid grid-cols-2 gap-4">
                          <div>
                            <p className="font-medium">{t("client.src.bank_account")}</p>
                            <p className="text-sm text-gray-600">{currentDeposit.bankAccount}</p>
                          </div>
                          <div>
                            <p className="font-medium">{t("client.src.insurance")}</p>
                            <p className="text-sm text-gray-600 capitalize">{currentDeposit.insurance}</p>
                          </div>
                        </div>
                      </div>
                    </CardContent>
                  </Card>

                  {/* Transaction History */}
                  <Card>
                    <CardHeader>
                      <CardTitle>{t("client.src.transaction_history")}</CardTitle>
                    </CardHeader>
                    <CardContent>
                      <div className="space-y-3">
                        <div className="flex items-center justify-between p-3 border rounded">
                          <div>
                            <p className="font-medium">{t("client.src.deposit_received")}</p>
                            <p className="text-sm text-gray-600">{currentDeposit.depositDate}</p>
                          </div>
                          <div className="text-right">
                            <p className="font-medium text-green-600">+{currentDeposit.amount}</p>
                            <Badge className="text-xs bg-green-100 text-green-800">{t("client.src.completed")}</Badge>
                          </div>
                        </div>
                        {currentDeposit.deductions > 0 && <div className="flex items-center justify-between p-3 border rounded">
                            <div>
                              <p className="font-medium">{t("client.src.damage_deductions")}</p>
                              <p className="text-sm text-gray-600">{t("client.src.property_repairs")}</p>
                            </div>
                            <div className="text-right">
                              <p className="font-medium text-red-600">-${currentDeposit.deductions}</p>
                              <Badge className="text-xs bg-red-100 text-red-800">{t("client.src.deducted")}</Badge>
                            </div>
                          </div>}
                        {currentDeposit.actualReturn && <div className="flex items-center justify-between p-3 border rounded">
                            <div>
                              <p className="font-medium">{t("client.src.deposit_refunded")}</p>
                              <p className="text-sm text-gray-600">{currentDeposit.actualReturn}</p>
                            </div>
                            <div className="text-right">
                              <p className="font-medium text-blue-600">-{currentDeposit.refundAmount}</p>
                              <Badge className="text-xs bg-blue-100 text-blue-800">{t("client.src.refunded")}</Badge>
                            </div>
                          </div>}
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
                      {currentDeposit.status === 'held' && <Button size="sm" className="w-full">
                          <CheckCircle className="w-4 h-4 mr-2" />{t("client.src.process_refund")}</Button>}
                      <Button size="sm" variant="outline" className="w-full">
                        <Calculator className="w-4 h-4 mr-2" />{t("client.src.calculate_deductions")}</Button>
                      <Button size="sm" variant="outline" className="w-full">
                        <FileText className="w-4 h-4 mr-2" />{t("client.src.generate_statement")}</Button>
                      <Button size="sm" variant="outline" className="w-full">
                        <Download className="w-4 h-4 mr-2" />{t("client.src.download_receipt")}</Button>
                    </CardContent>
                  </Card>

                  {/* Deposit Summary */}
                  <Card>
                    <CardHeader>
                      <CardTitle>{t("client.src.deposit_summary")}</CardTitle>
                    </CardHeader>
                    <CardContent className="space-y-3">
                      <div className="flex items-center justify-between">
                        <span className="text-sm">{t("client.src.total_deposits")}</span>
                        <span className="font-bold text-blue-600">${totalDeposits.toLocaleString()}</span>
                      </div>
                      <div className="flex items-center justify-between">
                        <span className="text-sm">{t("client.src.total_refunded")}</span>
                        <span className="font-bold text-green-600">${totalRefunds.toLocaleString()}</span>
                      </div>
                      <div className="flex items-center justify-between">
                        <span className="text-sm">{t("client.src.total_deductions")}</span>
                        <span className="font-bold text-red-600">${totalDeductions.toLocaleString()}</span>
                      </div>
                      <div className="pt-2 border-t">
                        <div className="flex items-center justify-between">
                          <span className="text-sm">{t("client.src.net_held")}</span>
                          <span className="font-bold text-purple-600">
                            ${(totalDeposits - totalRefunds).toLocaleString()}
                          </span>
                        </div>
                      </div>
                    </CardContent>
                  </Card>

                  {/* Insurance Status */}
                  <Card>
                    <CardHeader>
                      <CardTitle>{t("client.src.insurance_status")}</CardTitle>
                    </CardHeader>
                    <CardContent className="space-y-3">
                      <div className="flex items-center justify-between">
                        <span className="text-sm">{t("client.src.coverage")}</span>
                        <Badge className="bg-green-100 text-green-800">
                          {currentDeposit.insurance}
                        </Badge>
                      </div>
                      <div className="flex items-center justify-between">
                        <span className="text-sm">{t("client.src.policy_number")}</span>
                        <span className="text-sm font-medium">{t("client.src.pol2024")}{currentDeposit.id}</span>
                      </div>
                      <div className="flex items-center justify-between">
                        <span className="text-sm">{t("client.src.premium")}</span>
                        <span className="text-sm font-medium">{t("client.src.25month")}</span>
                      </div>
                      <Button size="sm" variant="outline" className="w-full">
                        <Shield className="w-4 h-4 mr-2" />{t("client.src.view_policy")}</Button>
                    </CardContent>
                  </Card>
                </div>
              </div>
            </ScrollArea>
          </div>}
      </div>
    </div>;
}