"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from 'react';
import { Upload, Mail } from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Input } from '@/components/ui/input';
import { ScrollArea } from '@/components/ui/scroll-area';
import { Search, Plus, Download, FileText, CheckCircle, XCircle, Clock, AlertCircle, MoreVertical, Edit, PenTool, Send, Archive, FileSignature, Eye } from 'lucide-react';
export default function Signing() {
  const {
    t
  } = useTranslation();
  const [selectedContract, setSelectedContract] = useState(1);
  const [searchQuery, setSearchQuery] = useState('');
  const [statusFilter, setStatusFilter] = useState('all');
  const [typeFilter, setTypeFilter] = useState('all');
  const contracts = [{
    id: 1,
    title: t("client.src.residential_lease_agreement"),
    tenant: 'John Doe',
    property: 'Sunset Apartments - Unit 4B',
    type: 'lease',
    status: 'signed',
    createdDate: '2024-01-10',
    sentDate: '2024-01-10',
    signedDate: '2024-01-12',
    expiryDate: '2024-06-15',
    amount: '$2,500/month',
    duration: '6 months',
    contractId: 'LEASE-2024-001',
    version: 'v2.1',
    notes: 'Standard residential lease with pet clause',
    avatar: 'JD',
    email: 'john.doe@email.com',
    phone: '+1 (555) 123-4567',
    signatures: [{
      party: 'Tenant',
      name: 'John Doe',
      signed: true,
      date: '2024-01-12',
      method: 'electronic'
    }, {
      party: 'Landlord',
      name: 'Property Manager',
      signed: true,
      date: '2024-01-12',
      method: 'electronic'
    }, {
      party: 'Witness',
      name: 'Jane Smith',
      signed: true,
      date: '2024-01-12',
      method: 'electronic'
    }],
    documents: ['lease_agreement.pdf', 'property_disclosure.pdf', 'pet_addendum.pdf'],
    reminders: ['rent_due', 'maintenance_request', 'lease_renewal']
  }, {
    id: 2,
    title: t("client.src.facility_management_agreement"),
    tenant: 'Sarah Johnson',
    property: 'Ocean View Villa - Unit 2A',
    type: 'facility',
    status: 'pending',
    createdDate: '2024-01-15',
    sentDate: '2024-01-15',
    signedDate: null,
    expiryDate: '2024-12-31',
    amount: '$450/month',
    duration: '12 months',
    contractId: 'FAC-2024-001',
    version: 'v1.0',
    notes: 'Comprehensive facility management with extra services',
    avatar: 'SJ',
    email: 'sarah.johnson@email.com',
    phone: '+1 (555) 987-6543',
    signatures: [{
      party: 'Client',
      name: 'Sarah Johnson',
      signed: false,
      date: null,
      method: 'electronic'
    }, {
      party: 'Provider',
      name: 'Facility Manager',
      signed: true,
      date: '2024-01-15',
      method: 'electronic'
    }],
    documents: ['facility_agreement.pdf', 'service_schedule.pdf', 'pricing_structure.pdf'],
    reminders: ['payment_due', 'service_review', 'contract_renewal']
  }, {
    id: 3,
    title: t("client.src.extra_services_agreement"),
    tenant: 'Michael Chen',
    property: 'Downtown Loft - Unit 1C',
    type: 'services',
    status: 'draft',
    createdDate: '2024-01-18',
    sentDate: null,
    signedDate: null,
    expiryDate: '2024-07-18',
    amount: '$150/month',
    duration: '6 months',
    contractId: 'SRV-2024-001',
    version: 'v0.9',
    notes: 'Additional cleaning and maintenance services',
    avatar: 'MC',
    email: 'michael.chen@email.com',
    phone: '+1 (555) 456-7890',
    signatures: [{
      party: 'Client',
      name: 'Michael Chen',
      signed: false,
      date: null,
      method: 'electronic'
    }, {
      party: 'Provider',
      name: 'Service Manager',
      signed: false,
      date: null,
      method: 'electronic'
    }],
    documents: ['services_agreement_draft.pdf'],
    reminders: []
  }, {
    id: 4,
    title: t("client.src.property_management_contract"),
    tenant: 'Emily Williams',
    property: 'Garden Villa - Unit 3D',
    type: 'management',
    status: 'expired',
    createdDate: '2023-01-01',
    sentDate: '2023-01-01',
    signedDate: '2023-01-03',
    expiryDate: '2024-01-01',
    amount: '$350/month',
    duration: '12 months',
    contractId: 'MGT-2023-001',
    version: 'v1.2',
    notes: 'Full property management services',
    avatar: 'EW',
    email: 'emily.williams@email.com',
    phone: '+1 (555) 789-0123',
    signatures: [{
      party: 'Owner',
      name: 'Emily Williams',
      signed: true,
      date: '2023-01-03',
      method: 'electronic'
    }, {
      party: 'Manager',
      name: 'Property Manager',
      signed: true,
      date: '2023-01-03',
      method: 'electronic'
    }],
    documents: ['management_contract.pdf', 'fee_structure.pdf'],
    reminders: []
  }];
  const filteredContracts = contracts.filter(contract => {
    const matchesSearch = contract.tenant.toLowerCase().includes(searchQuery.toLowerCase()) || contract.property.toLowerCase().includes(searchQuery.toLowerCase()) || contract.title.toLowerCase().includes(searchQuery.toLowerCase()) || contract.contractId.toLowerCase().includes(searchQuery.toLowerCase());
    const matchesStatus = statusFilter === 'all' || contract.status === statusFilter;
    const matchesType = typeFilter === 'all' || contract.type === typeFilter;
    return matchesSearch && matchesStatus && matchesType;
  });
  const currentContract = contracts.find(c => c.id === selectedContract);
  const getStatusColor = (status: string) => {
    switch (status) {
      case 'signed':
        return 'bg-blue-100 text-blue-800';
      case 'pending':
        return 'bg-yellow-100 text-yellow-800';
      case 'draft':
        return 'bg-gray-100 text-gray-800';
      case 'expired':
        return 'bg-red-100 text-red-800';
      case 'cancelled':
        return 'bg-red-100 text-red-800';
      default:
        return 'bg-gray-100 text-gray-800';
    }
  };
  const getStatusIcon = (status: string) => {
    switch (status) {
      case 'signed':
        return <CheckCircle className="w-4 h-4" />;
      case 'pending':
        return <Clock className="w-4 h-4" />;
      case 'draft':
        return <FileText className="w-4 h-4" />;
      case 'expired':
        return <XCircle className="w-4 h-4" />;
      case 'cancelled':
        return <XCircle className="w-4 h-4" />;
      default:
        return <AlertCircle className="w-4 h-4" />;
    }
  };
  const getTypeColor = (type: string) => {
    switch (type) {
      case 'lease':
        return 'bg-brand/15 text-brand';
      case 'facility':
        return 'bg-blue-100 text-blue-800';
      case 'services':
        return 'bg-orange-100 text-orange-800';
      case 'management':
        return 'bg-blue-100 text-blue-800';
      default:
        return 'bg-gray-100 text-gray-800';
    }
  };
  const totalContracts = contracts.length;
  const signedContracts = contracts.filter(c => c.status === 'signed').length;
  const pendingContracts = contracts.filter(c => c.status === 'pending').length;
  const totalValue = contracts.filter(c => c.status === 'signed' || c.status === 'pending').reduce((sum, c) => sum + parseFloat(c.amount.replace(/[$,]/g, '')), 0);
  return <div className="h-full flex">
      {/* Contracts List */}
      <div className="w-96 border-r bg-gray-50">
        <div className="p-4 border-b">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold">{t("client.src.contract_signing")}</h2>
            <Button size="sm">
              <Plus className="w-4 h-4 mr-2" />{t("client.src.new_contract")}</Button>
          </div>
          
          {/* Search and Filter */}
          <div className="space-y-3">
            <div className="relative">
              <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 w-4 h-4 text-gray-400" />
              <Input placeholder={t("client.src.search_contracts")} value={searchQuery} onChange={e => setSearchQuery(e.target.value)} className="pl-10" />
            </div>
            
            <div className="flex gap-2">
              <select aria-label="Filter by status" value={statusFilter} onChange={e => setStatusFilter(e.target.value)} className="flex-1 px-3 py-2 text-sm border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500">
                <option value="all">{t("common.all_status")}</option>
                <option value="signed">{t("common.signed")}</option>
                <option value="pending">{t("common.processing")}</option>
                <option value="draft">{t("common.draft")}</option>
                <option value="expired">{t("common.expired")}</option>
                <option value="cancelled">{t("common.cancelled")}</option>
              </select>
              <select aria-label="Filter by type" value={typeFilter} onChange={e => setTypeFilter(e.target.value)} className="flex-1 px-3 py-2 text-sm border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500">
                <option value="all">{t("common.all_types")}</option>
                <option value="lease">{t("client.src.lease")}</option>
                <option value="facility">{t("client.src.facility")}</option>
                <option value="services">{t("client.src.services")}</option>
                <option value="management">{t("client.src.management")}</option>
              </select>
            </div>
          </div>
        </div>
        
        <ScrollArea className="flex-1">
          <div className="p-2">
            {filteredContracts.map(contract => <div key={contract.id} onClick={() => setSelectedContract(contract.id)} className={`p-3 rounded-lg cursor-pointer transition-colors mb-2 ${selectedContract === contract.id ? 'bg-brand/10 border border-purple-200' : 'hover:bg-gray-100'}`}>
                <div className="flex items-start gap-3">
                  <div className="w-10 h-10 rounded-lg bg-gradient-to-br from-brand to-pink-600 flex items-center justify-center text-white">
                    <FileSignature className="w-5 h-5" />
                  </div>
                  <div className="flex-1 min-w-0">
                    <div className="flex items-center justify-between mb-1">
                      <p className="font-medium text-sm truncate">{contract.title}</p>
                      <p className="font-bold text-sm">{contract.amount}</p>
                    </div>
                    <p className="text-xs text-gray-600 truncate">{contract.tenant}</p>
                    <p className="text-xs text-gray-500 truncate">{contract.property}</p>
                    <div className="flex items-center gap-2 mt-2">
                      <Badge className={`text-xs ${getStatusColor(contract.status)}`}>
                        {getStatusIcon(contract.status)}
                        <span className="ml-1">{contract.status}</span>
                      </Badge>
                      <Badge className={`text-xs ${getTypeColor(contract.type)}`}>
                        {contract.type}
                      </Badge>
                      <Badge variant="outline" className="text-xs">
                        {contract.contractId}
                      </Badge>
                    </div>
                    <div className="flex items-center justify-between mt-2 text-xs text-gray-500">
                      <span>{t("common.created")}{contract.createdDate}</span>
                      <span>{contract.duration}</span>
                    </div>
                  </div>
                </div>
              </div>)}
          </div>
        </ScrollArea>
      </div>

      {/* Contract Details */}
      <div className="flex-1">
        {currentContract && <div className="h-full flex flex-col">
            {/* Contract Header */}
            <div className="p-6 border-b bg-card">
              <div className="flex items-center justify-between">
                <div className="flex items-center gap-4">
                  <div className="w-12 h-12 rounded-lg bg-gradient-to-br from-brand to-pink-600 flex items-center justify-center text-white">
                    <FileSignature className="w-6 h-6" />
                  </div>
                  <div>
                    <h3 className="text-xl font-semibold">{currentContract.title}</h3>
                    <div className="flex items-center gap-2 mt-1">
                      <Badge className={getStatusColor(currentContract.status)}>
                        {getStatusIcon(currentContract.status)}
                        <span className="ml-1">{currentContract.status}</span>
                      </Badge>
                      <Badge className={getTypeColor(currentContract.type)}>
                        {currentContract.type}
                      </Badge>
                      <Badge variant="outline">{currentContract.contractId}</Badge>
                    </div>
                    <p className="text-sm text-gray-600 mt-1">{currentContract.tenant} • {currentContract.property}</p>
                  </div>
                </div>
                <div className="flex items-center gap-2">
                  <Button size="sm">
                    <Eye className="w-4 h-4 mr-2" />{t("common.view")}</Button>
                  <Button size="sm" variant="outline">
                    <Edit className="w-4 h-4 mr-2" />{t("common.edit")}</Button>
                  <Button size="sm" variant="outline">
                    <Send className="w-4 h-4 mr-2" />{t("client.src.send")}</Button>
                  <Button size="sm" variant="outline" aria-label={t("common.more")}>
                    <MoreVertical className="w-4 h-4" />
                  </Button>
                </div>
              </div>
            </div>

            {/* Contract Content */}
            <ScrollArea className="flex-1 p-6">
              <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
                {/* Main Info */}
                <div className="lg:col-span-2 space-y-6">
                  {/* Contract Details */}
                  <Card>
                    <CardHeader>
                      <CardTitle className="flex items-center gap-2">
                        <FileText className="w-5 h-5" />{t("client.src.contract_details")}</CardTitle>
                    </CardHeader>
                    <CardContent>
                      <div className="space-y-4">
                        <div className="grid grid-cols-2 gap-4">
                          <div>
                            <p className="font-medium">{t("client.src.contract_amount")}</p>
                            <p className="text-2xl font-bold text-brand">{currentContract.amount}</p>
                          </div>
                          <div>
                            <p className="font-medium">{t("client.src.duration")}</p>
                            <p className="text-lg font-bold">{currentContract.duration}</p>
                          </div>
                        </div>
                        <div className="grid grid-cols-2 gap-4">
                          <div>
                            <p className="font-medium">{t("client.src.created_date")}</p>
                            <p className="text-sm text-gray-600">{currentContract.createdDate}</p>
                          </div>
                          <div>
                            <p className="font-medium">{t("client.src.sent_date")}</p>
                            <p className="text-sm text-gray-600">
                              {currentContract.sentDate || 'Not sent yet'}
                            </p>
                          </div>
                        </div>
                        <div className="grid grid-cols-2 gap-4">
                          <div>
                            <p className="font-medium">{t("client.src.signed_date")}</p>
                            <p className="text-sm text-gray-600">
                              {currentContract.signedDate || 'Not signed yet'}
                            </p>
                          </div>
                          <div>
                            <p className="font-medium">{t("common.expiry_date")}</p>
                            <p className="text-sm text-gray-600">{currentContract.expiryDate}</p>
                          </div>
                        </div>
                        <div className="grid grid-cols-2 gap-4">
                          <div>
                            <p className="font-medium">{t("client.src.version")}</p>
                            <p className="text-sm text-gray-600">{currentContract.version}</p>
                          </div>
                          <div>
                            <p className="font-medium">{t("client.src.contract_id")}</p>
                            <p className="text-sm text-gray-600">{currentContract.contractId}</p>
                          </div>
                        </div>
                        <div>
                          <p className="font-medium">{t("common.notes")}</p>
                          <p className="text-sm text-gray-600">{currentContract.notes}</p>
                        </div>
                      </div>
                    </CardContent>
                  </Card>

                  {/* Signatures */}
                  <Card>
                    <CardHeader>
                      <CardTitle className="flex items-center gap-2">
                        <PenTool className="w-5 h-5" />{t("client.src.signatures")}</CardTitle>
                    </CardHeader>
                    <CardContent>
                      <div className="space-y-4">
                        {currentContract.signatures.map((signature, index) => <div key={index} className="flex items-center justify-between p-4 border rounded-lg">
                            <div className="flex items-center gap-3">
                              <div className={`w-10 h-10 rounded-full flex items-center justify-center ${signature.signed ? 'bg-blue-100 text-blue-600' : 'bg-gray-100 text-gray-400'}`}>
                                {signature.signed ? <CheckCircle className="w-5 h-5" /> : <Clock className="w-5 h-5" />}
                              </div>
                              <div>
                                <p className="font-medium">{signature.party}</p>
                                <p className="text-sm text-gray-600">{signature.name}</p>
                                <p className="text-xs text-gray-500 capitalize">{signature.method}</p>
                              </div>
                            </div>
                            <div className="text-right">
                              <p className="text-sm font-medium">
                                {signature.signed ? signature.date : 'Pending'}
                              </p>
                              <Badge className={`text-xs ${signature.signed ? 'bg-blue-100 text-blue-800' : 'bg-yellow-100 text-yellow-800'}`}>
                                {signature.signed ? 'Signed' : 'Pending'}
                              </Badge>
                            </div>
                          </div>)}
                      </div>
                    </CardContent>
                  </Card>

                  {/* Documents */}
                  <Card>
                    <CardHeader>
                      <CardTitle className="flex items-center justify-between">
                        <div className="flex items-center gap-2">
                          <FileText className="w-5 h-5" />{t("common.documents")}{currentContract.documents.length})
                        </div>
                        <Button size="sm" variant="outline">
                          <Upload className="w-4 h-4 mr-2" />{t("client.src.upload")}</Button>
                      </CardTitle>
                    </CardHeader>
                    <CardContent>
                      <div className="space-y-2">
                        {currentContract.documents.map((doc, index) => <div key={index} className="flex items-center justify-between p-3 border rounded">
                            <div className="flex items-center gap-3">
                              <FileText className="w-4 h-4 text-gray-400" />
                              <div>
                                <p className="font-medium text-sm">{doc}</p>
                                <p className="text-xs text-gray-500">{t("client.src.pdf_23_mb")}</p>
                              </div>
                            </div>
                            <div className="flex items-center gap-2">
                              <Button size="sm" variant="ghost" aria-label={t("common.view")}>
                                <Eye className="w-4 h-4" />
                              </Button>
                              <Button size="sm" variant="ghost" aria-label={t("common.download")}>
                                <Download className="w-4 h-4" />
                              </Button>
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
                      {currentContract.status === 'draft' && <Button size="sm" className="w-full">
                          <Send className="w-4 h-4 mr-2" />{t("client.src.send_for_signature")}</Button>}
                      {currentContract.status === 'pending' && <Button size="sm" className="w-full">
                          <Mail className="w-4 h-4 mr-2" />{t("client.src.send_reminder")}</Button>}
                      <Button size="sm" variant="outline" className="w-full">
                        <Download className="w-4 h-4 mr-2" />{t("client.src.download_pdf")}</Button>
                      <Button size="sm" variant="outline" className="w-full">
                        <Archive className="w-4 h-4 mr-2" />{t("client.src.archive_contract")}</Button>
                    </CardContent>
                  </Card>

                  {/* Contract Summary */}
                  <Card>
                    <CardHeader>
                      <CardTitle>{t("client.src.contract_summary")}</CardTitle>
                    </CardHeader>
                    <CardContent className="space-y-3">
                      <div className="flex items-center justify-between">
                        <span className="text-sm">{t("client.src.total_contracts")}</span>
                        <span className="font-bold">{totalContracts}</span>
                      </div>
                      <div className="flex items-center justify-between">
                        <span className="text-sm">{t("common.signed")}</span>
                        <span className="font-bold text-blue-600">{signedContracts}</span>
                      </div>
                      <div className="flex items-center justify-between">
                        <span className="text-sm">{t("common.processing")}</span>
                        <span className="font-bold text-yellow-600">{pendingContracts}</span>
                      </div>
                      <div className="pt-2 border-t">
                        <div className="flex items-center justify-between">
                          <span className="text-sm">{t("client.src.monthly_value")}</span>
                          <span className="font-bold text-brand">
                            ${totalValue.toLocaleString()}
                          </span>
                        </div>
                      </div>
                    </CardContent>
                  </Card>

                  {/* Reminders */}
                  {currentContract.reminders.length > 0 && <Card>
                      <CardHeader>
                        <CardTitle>{t("client.src.active_reminders")}</CardTitle>
                      </CardHeader>
                      <CardContent className="space-y-2">
                        {currentContract.reminders.map((reminder, index) => <div key={index} className="flex items-center gap-2 p-2 bg-brand/10 border border-border rounded">
                            <Clock className="w-4 h-4 text-brand" />
                            <span className="text-sm text-blue-800 capitalize">{reminder.replace('_', ' ')}</span>
                          </div>)}
                      </CardContent>
                    </Card>}
                </div>
              </div>
            </ScrollArea>
          </div>}
      </div>
    </div>;
}