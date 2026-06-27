import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Input } from '@/components/ui/input';
import { ScrollArea } from '@/components/ui/scroll-area';
import { Search, Plus, Download, CheckCircle, XCircle, Clock, AlertCircle, MoreVertical, Edit, FileText, Calculator, Receipt, Wrench, Zap, Droplets, Wind, Shield, Wrench as Tool, ClipboardList, CheckSquare, AlertTriangle, Activity, CreditCard, Calendar } from 'lucide-react';
export default function FacilityManagement() {
  const {
    t
  } = useTranslation();
  const [selectedService, setSelectedService] = useState(1);
  const [searchQuery, setSearchQuery] = useState('');
  const [statusFilter, setStatusFilter] = useState('all');
  const [typeFilter, setTypeFilter] = useState('all');
  const services = [{
    id: 1,
    title: t("client.src.regular_cleaning_service"),
    client: 'John Doe',
    property: 'Sunset Apartments - Unit 4B',
    type: 'cleaning',
    status: 'active',
    frequency: 'weekly',
    amount: '$150',
    taxRate: 8.5,
    taxAmount: '$12.75',
    totalAmount: '$162.75',
    nextService: '2024-01-22',
    lastService: '2024-01-15',
    startDate: '2024-01-01',
    endDate: '2024-06-30',
    contractId: 'SRV-2024-001',
    invoiceId: 'INV-2024-023',
    notes: 'Weekly cleaning including deep kitchen cleaning',
    avatar: 'JD',
    email: 'john.doe@email.com',
    phone: '+1 (555) 123-4567',
    services: ['general_cleaning', 'kitchen_deep_clean', 'bathroom_cleaning'],
    extras: ['window_cleaning', 'carpet_cleaning'],
    taxIncluded: true,
    autoBilling: true
  }, {
    id: 2,
    title: t("client.src.hvac_maintenance"),
    client: 'Sarah Johnson',
    property: 'Ocean View Villa - Unit 2A',
    type: 'maintenance',
    status: 'scheduled',
    frequency: 'monthly',
    amount: '$200',
    taxRate: 8.5,
    taxAmount: '$17.00',
    totalAmount: '$217.00',
    nextService: '2024-01-25',
    lastService: '2023-12-25',
    startDate: '2023-01-01',
    endDate: '2024-12-31',
    contractId: 'SRV-2023-045',
    invoiceId: 'INV-2024-024',
    notes: 'Monthly HVAC filter replacement and system check',
    avatar: 'SJ',
    email: 'sarah.johnson@email.com',
    phone: '+1 (555) 987-6543',
    services: ['hvac_inspection', 'filter_replacement'],
    extras: ['duct_cleaning'],
    taxIncluded: true,
    autoBilling: true
  }, {
    id: 3,
    title: t("client.src.plumbing_services"),
    client: 'Michael Chen',
    property: 'Downtown Loft - Unit 1C',
    type: 'plumbing',
    status: 'pending',
    frequency: 'on_demand',
    amount: '$350',
    taxRate: 8.5,
    taxAmount: '$29.75',
    totalAmount: '$379.75',
    nextService: '2024-01-20',
    lastService: null,
    startDate: '2024-01-20',
    endDate: '2024-01-20',
    contractId: 'SRV-2024-002',
    invoiceId: 'INV-2024-025',
    notes: 'Emergency plumbing repair - leaky faucet',
    avatar: 'MC',
    email: 'michael.chen@email.com',
    phone: '+1 (555) 456-7890',
    services: ['faucet_repair', 'pipe_inspection'],
    extras: [],
    taxIncluded: true,
    autoBilling: false
  }, {
    id: 4,
    title: t("client.src.electrical_services"),
    client: 'Emily Williams',
    property: 'Garden Villa - Unit 3D',
    type: 'electrical',
    status: 'completed',
    frequency: 'on_demand',
    amount: '$450',
    taxRate: 8.5,
    taxAmount: '$38.25',
    totalAmount: '$488.25',
    nextService: null,
    lastService: '2024-01-10',
    startDate: '2024-01-10',
    endDate: '2024-01-10',
    contractId: 'SRV-2024-003',
    invoiceId: 'INV-2024-022',
    notes: 'Complete electrical panel upgrade',
    avatar: 'EW',
    email: 'emily.williams@email.com',
    phone: '+1 (555) 789-0123',
    services: ['panel_upgrade', 'wiring_inspection'],
    extras: ['outlet_installation'],
    taxIncluded: true,
    autoBilling: false
  }];
  const filteredServices = services.filter(service => {
    const matchesSearch = service.client.toLowerCase().includes(searchQuery.toLowerCase()) || service.property.toLowerCase().includes(searchQuery.toLowerCase()) || service.title.toLowerCase().includes(searchQuery.toLowerCase());
    const matchesStatus = statusFilter === 'all' || service.status === statusFilter;
    const matchesType = typeFilter === 'all' || service.type === typeFilter;
    return matchesSearch && matchesStatus && matchesType;
  });
  const currentService = services.find(s => s.id === selectedService);
  const getStatusColor = (status: string) => {
    switch (status) {
      case 'active':
        return 'bg-green-100 text-green-800';
      case 'scheduled':
        return 'bg-blue-100 text-blue-800';
      case 'pending':
        return 'bg-yellow-100 text-yellow-800';
      case 'completed':
        return 'bg-gray-100 text-gray-800';
      case 'cancelled':
        return 'bg-red-100 text-red-800';
      default:
        return 'bg-gray-100 text-gray-800';
    }
  };
  const getStatusIcon = (status: string) => {
    switch (status) {
      case 'active':
        return <Activity className="w-4 h-4" />;
      case 'scheduled':
        return <Calendar className="w-4 h-4" />;
      case 'pending':
        return <Clock className="w-4 h-4" />;
      case 'completed':
        return <CheckCircle className="w-4 h-4" />;
      case 'cancelled':
        return <XCircle className="w-4 h-4" />;
      default:
        return <AlertCircle className="w-4 h-4" />;
    }
  };
  const getTypeIcon = (type: string) => {
    switch (type) {
      case 'cleaning':
        return <Wrench className="w-4 h-4" />;
      case 'maintenance':
        return <Tool className="w-4 h-4" />;
      case 'plumbing':
        return <Droplets className="w-4 h-4" />;
      case 'electrical':
        return <Zap className="w-4 h-4" />;
      case 'hvac':
        return <Wind className="w-4 h-4" />;
      default:
        return <Tool className="w-4 h-4" />;
    }
  };
  const getTypeColor = (type: string) => {
    switch (type) {
      case 'cleaning':
        return 'bg-blue-100 text-blue-800';
      case 'maintenance':
        return 'bg-purple-100 text-purple-800';
      case 'plumbing':
        return 'bg-blue-100 text-blue-800';
      case 'electrical':
        return 'bg-yellow-100 text-yellow-800';
      case 'hvac':
        return 'bg-green-100 text-green-800';
      default:
        return 'bg-gray-100 text-gray-800';
    }
  };
  const totalRevenue = services.filter(s => s.status === 'active' || s.status === 'completed').reduce((sum, s) => sum + parseFloat(s.totalAmount.replace(/[$,]/g, '')), 0);
  const totalTax = services.filter(s => s.status === 'active' || s.status === 'completed').reduce((sum, s) => sum + parseFloat(s.taxAmount.replace(/[$,]/g, '')), 0);
  const activeServices = services.filter(s => s.status === 'active').length;
  return <div className="h-full flex">
      {/* Services List */}
      <div className="w-96 border-r bg-gray-50">
        <div className="p-4 border-b">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold">{t("client.src.facility_services")}</h2>
            <Button size="sm">
              <Plus className="w-4 h-4 mr-2" />{t("client.src.new_service")}</Button>
          </div>
          
          {/* Search and Filter */}
          <div className="space-y-3">
            <div className="relative">
              <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 w-4 h-4 text-gray-400" />
              <Input placeholder={t("client.src.search_services")} value={searchQuery} onChange={e => setSearchQuery(e.target.value)} className="pl-10" />
            </div>
            
            <div className="flex gap-2">
              <select value={statusFilter} onChange={e => setStatusFilter(e.target.value)} className="flex-1 px-3 py-2 text-sm border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500">
                <option value="all">{t("client.src.all_status")}</option>
                <option value="active">{t("client.src.active")}</option>
                <option value="scheduled">{t("client.src.scheduled")}</option>
                <option value="pending">{t("client.src.pending")}</option>
                <option value="completed">{t("client.src.completed")}</option>
                <option value="cancelled">{t("client.src.cancelled")}</option>
              </select>
              <select value={typeFilter} onChange={e => setTypeFilter(e.target.value)} className="flex-1 px-3 py-2 text-sm border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500">
                <option value="all">{t("client.src.all_types")}</option>
                <option value="cleaning">{t("client.src.cleaning")}</option>
                <option value="maintenance">{t("client.src.maintenance")}</option>
                <option value="plumbing">{t("client.src.plumbing")}</option>
                <option value="electrical">{t("client.src.electrical")}</option>
                <option value="hvac">{t("client.src.hvac")}</option>
              </select>
            </div>
          </div>
        </div>
        
        <ScrollArea className="flex-1">
          <div className="p-2">
            {filteredServices.map(service => <div key={service.id} onClick={() => setSelectedService(service.id)} className={`p-3 rounded-lg cursor-pointer transition-colors mb-2 ${selectedService === service.id ? 'bg-purple-50 border border-purple-200' : 'hover:bg-gray-100'}`}>
                <div className="flex items-start gap-3">
                  <div className="w-10 h-10 rounded-lg bg-linear-to-br from-purple-600 to-pink-600 flex items-center justify-center text-white">
                    {getTypeIcon(service.type)}
                  </div>
                  <div className="flex-1 min-w-0">
                    <div className="flex items-center justify-between mb-1">
                      <p className="font-medium text-sm truncate">{service.title}</p>
                      <p className="font-bold text-sm">{service.totalAmount}</p>
                    </div>
                    <p className="text-xs text-gray-600 truncate">{service.client}</p>
                    <p className="text-xs text-gray-500 truncate">{service.property}</p>
                    <div className="flex items-center gap-2 mt-2">
                      <Badge className={`text-xs ${getStatusColor(service.status)}`}>
                        {getStatusIcon(service.status)}
                        <span className="ml-1">{service.status}</span>
                      </Badge>
                      <Badge className={`text-xs ${getTypeColor(service.type)}`}>
                        {service.type}
                      </Badge>
                      {service.taxIncluded && <Badge variant="outline" className="text-xs">{t("client.src.tax_inc")}</Badge>}
                    </div>
                    <div className="flex items-center justify-between mt-2 text-xs text-gray-500">
                      <span>{t("client.src.next")}{service.nextService || 'N/A'}</span>
                      <span>{service.frequency}</span>
                    </div>
                  </div>
                </div>
              </div>)}
          </div>
        </ScrollArea>
      </div>

      {/* Service Details */}
      <div className="flex-1">
        {currentService && <div className="h-full flex flex-col">
            {/* Service Header */}
            <div className="p-6 border-b bg-white">
              <div className="flex items-center justify-between">
                <div className="flex items-center gap-4">
                  <div className="w-12 h-12 rounded-lg bg-linear-to-br from-purple-600 to-pink-600 flex items-center justify-center text-white">
                    {getTypeIcon(currentService.type)}
                  </div>
                  <div>
                    <h3 className="text-xl font-semibold">{currentService.title}</h3>
                    <div className="flex items-center gap-2 mt-1">
                      <Badge className={getStatusColor(currentService.status)}>
                        {getStatusIcon(currentService.status)}
                        <span className="ml-1">{currentService.status}</span>
                      </Badge>
                      <Badge className={getTypeColor(currentService.type)}>
                        {currentService.type}
                      </Badge>
                      <Badge variant="outline">{currentService.contractId}</Badge>
                    </div>
                    <p className="text-sm text-gray-600 mt-1">{currentService.client} • {currentService.property}</p>
                  </div>
                </div>
                <div className="flex items-center gap-2">
                  <Button size="sm">
                    <Edit className="w-4 h-4 mr-2" />{t("client.src.edit")}</Button>
                  <Button size="sm" variant="outline">
                    <Receipt className="w-4 h-4 mr-2" />{t("client.src.invoice")}</Button>
                  <Button size="sm" variant="outline">
                    <MoreVertical className="w-4 h-4" />
                  </Button>
                </div>
              </div>
            </div>

            {/* Service Content */}
            <ScrollArea className="flex-1 p-6">
              <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
                {/* Main Info */}
                <div className="lg:col-span-2 space-y-6">
                  {/* Service Details */}
                  <Card>
                    <CardHeader>
                      <CardTitle className="flex items-center gap-2">
                        <ClipboardList className="w-5 h-5" />{t("client.src.service_details")}</CardTitle>
                    </CardHeader>
                    <CardContent>
                      <div className="space-y-4">
                        <div className="grid grid-cols-2 gap-4">
                          <div>
                            <p className="font-medium">{t("client.src.service_amount")}</p>
                            <p className="text-2xl font-bold text-purple-600">{currentService.amount}</p>
                          </div>
                          <div>
                            <p className="font-medium">{t("client.src.total_with_tax")}</p>
                            <p className="text-2xl font-bold text-green-600">{currentService.totalAmount}</p>
                          </div>
                        </div>
                        <div className="grid grid-cols-2 gap-4">
                          <div>
                            <p className="font-medium">{t("client.src.tax_rate")}</p>
                            <p className="text-lg font-bold">{currentService.taxRate}%</p>
                          </div>
                          <div>
                            <p className="font-medium">{t("client.src.tax_amount")}</p>
                            <p className="text-lg font-bold text-blue-600">{currentService.taxAmount}</p>
                          </div>
                        </div>
                        <div className="grid grid-cols-2 gap-4">
                          <div>
                            <p className="font-medium">{t("client.src.frequency")}</p>
                            <p className="text-sm text-gray-600 capitalize">{currentService.frequency.replace('_', ' ')}</p>
                          </div>
                          <div>
                            <p className="font-medium">{t("client.src.next_service")}</p>
                            <p className="text-sm text-gray-600">{currentService.nextService}</p>
                          </div>
                        </div>
                        <div className="grid grid-cols-2 gap-4">
                          <div>
                            <p className="font-medium">{t("client.src.start_date")}</p>
                            <p className="text-sm text-gray-600">{currentService.startDate}</p>
                          </div>
                          <div>
                            <p className="font-medium">{t("client.src.end_date")}</p>
                            <p className="text-sm text-gray-600">{currentService.endDate}</p>
                          </div>
                        </div>
                        <div className="grid grid-cols-2 gap-4">
                          <div>
                            <p className="font-medium">{t("client.src.contract_id")}</p>
                            <p className="text-sm text-gray-600">{currentService.contractId}</p>
                          </div>
                          <div>
                            <p className="font-medium">{t("client.src.invoice_id")}</p>
                            <p className="text-sm text-gray-600">{currentService.invoiceId}</p>
                          </div>
                        </div>
                        <div className="flex items-center gap-4">
                          <div className="flex items-center gap-2">
                            <Shield className="w-4 h-4 text-gray-400" />
                            <span className="text-sm">{t("client.src.tax_included")}</span>
                            <Badge className={currentService.taxIncluded ? 'bg-green-100 text-green-800' : 'bg-gray-100 text-gray-800'}>
                              {currentService.taxIncluded ? 'Yes' : 'No'}
                            </Badge>
                          </div>
                          <div className="flex items-center gap-2">
                            <CreditCard className="w-4 h-4 text-gray-400" />
                            <span className="text-sm">{t("client.src.auto_billing")}</span>
                            <Badge className={currentService.autoBilling ? 'bg-green-100 text-green-800' : 'bg-gray-100 text-gray-800'}>
                              {currentService.autoBilling ? 'Enabled' : 'Disabled'}
                            </Badge>
                          </div>
                        </div>
                        <div>
                          <p className="font-medium">{t("client.src.notes")}</p>
                          <p className="text-sm text-gray-600">{currentService.notes}</p>
                        </div>
                      </div>
                    </CardContent>
                  </Card>

                  {/* Services & Extras */}
                  <Card>
                    <CardHeader>
                      <CardTitle className="flex items-center gap-2">
                        <Tool className="w-5 h-5" />{t("client.src.services_extras")}</CardTitle>
                    </CardHeader>
                    <CardContent>
                      <div className="space-y-4">
                        <div>
                          <p className="font-medium mb-2">{t("client.src.included_services")}</p>
                          <div className="space-y-2">
                            {currentService.services.map((service, index) => <div key={index} className="flex items-center gap-2 p-2 bg-green-50 border border-green-200 rounded">
                                <CheckSquare className="w-4 h-4 text-green-600" />
                                <span className="text-sm text-green-800 capitalize">{service.replace('_', ' ')}</span>
                              </div>)}
                          </div>
                        </div>
                        {currentService.extras.length > 0 && <div>
                            <p className="font-medium mb-2">{t("client.src.extra_services")}</p>
                            <div className="space-y-2">
                              {currentService.extras.map((extra, index) => <div key={index} className="flex items-center gap-2 p-2 bg-blue-50 border border-blue-200 rounded">
                                  <Plus className="w-4 h-4 text-blue-600" />
                                  <span className="text-sm text-blue-800 capitalize">{extra.replace('_', ' ')}</span>
                                </div>)}
                            </div>
                          </div>}
                      </div>
                    </CardContent>
                  </Card>

                  {/* Service History */}
                  <Card>
                    <CardHeader>
                      <CardTitle>{t("client.src.service_history")}</CardTitle>
                    </CardHeader>
                    <CardContent>
                      <div className="space-y-3">
                        <div className="flex items-center justify-between p-3 border rounded">
                          <div>
                            <p className="font-medium">{t("client.src.regular_cleaning")}</p>
                            <p className="text-sm text-gray-600">{currentService.lastService}</p>
                          </div>
                          <div className="text-right">
                            <p className="font-medium">{currentService.amount}</p>
                            <Badge className="text-xs bg-green-100 text-green-800">{t("client.src.completed")}</Badge>
                          </div>
                        </div>
                        {currentService.frequency === 'weekly' && <div className="flex items-center justify-between p-3 border rounded">
                            <div>
                              <p className="font-medium">{t("client.src.scheduled_service")}</p>
                              <p className="text-sm text-gray-600">{currentService.nextService}</p>
                            </div>
                            <div className="text-right">
                              <p className="font-medium">{currentService.amount}</p>
                              <Badge className="text-xs bg-blue-100 text-blue-800">{t("client.src.scheduled")}</Badge>
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
                      {currentService.status === 'pending' && <Button size="sm" className="w-full">
                          <CheckCircle className="w-4 h-4 mr-2" />{t("client.src.mark_completed")}</Button>}
                      {currentService.status === 'scheduled' && <Button size="sm" className="w-full">
                          <Activity className="w-4 h-4 mr-2" />{t("client.src.start_service")}</Button>}
                      <Button size="sm" variant="outline" className="w-full">
                        <Calculator className="w-4 h-4 mr-2" />{t("client.src.calculate_tax")}</Button>
                      <Button size="sm" variant="outline" className="w-full">
                        <Receipt className="w-4 h-4 mr-2" />{t("client.src.generate_invoice")}</Button>
                      <Button size="sm" variant="outline" className="w-full">
                        <Download className="w-4 h-4 mr-2" />{t("client.src.download_report")}</Button>
                    </CardContent>
                  </Card>

                  {/* Revenue Summary */}
                  <Card>
                    <CardHeader>
                      <CardTitle>{t("client.src.revenue_summary")}</CardTitle>
                    </CardHeader>
                    <CardContent className="space-y-3">
                      <div className="flex items-center justify-between">
                        <span className="text-sm">{t("client.src.total_revenue")}</span>
                        <span className="font-bold text-green-600">${totalRevenue.toLocaleString()}</span>
                      </div>
                      <div className="flex items-center justify-between">
                        <span className="text-sm">{t("client.src.total_tax")}</span>
                        <span className="font-bold text-blue-600">${totalTax.toLocaleString()}</span>
                      </div>
                      <div className="flex items-center justify-between">
                        <span className="text-sm">{t("client.src.active_services")}</span>
                        <span className="font-bold text-purple-600">{activeServices}</span>
                      </div>
                      <div className="pt-2 border-t">
                        <div className="flex items-center justify-between">
                          <span className="text-sm">{t("client.src.net_revenue")}</span>
                          <span className="font-bold text-green-600">
                            ${(totalRevenue - totalTax).toLocaleString()}
                          </span>
                        </div>
                      </div>
                    </CardContent>
                  </Card>

                  {/* Tax Information */}
                  <Card>
                    <CardHeader>
                      <CardTitle>{t("client.src.tax_information")}</CardTitle>
                    </CardHeader>
                    <CardContent className="space-y-3">
                      <div className="flex items-center justify-between">
                        <span className="text-sm">{t("client.src.tax_rate")}</span>
                        <span className="font-bold">{currentService.taxRate}%</span>
                      </div>
                      <div className="flex items-center justify-between">
                        <span className="text-sm">{t("client.src.tax_collected")}</span>
                        <span className="font-bold text-blue-600">{currentService.taxAmount}</span>
                      </div>
                      <div className="flex items-center justify-between">
                        <span className="text-sm">{t("client.src.tax_status")}</span>
                        <Badge className="bg-green-100 text-green-800">{t("client.src.reported")}</Badge>
                      </div>
                      <Button size="sm" variant="outline" className="w-full">
                        <FileText className="w-4 h-4 mr-2" />{t("client.src.tax_report")}</Button>
                    </CardContent>
                  </Card>

                  {/* Alerts */}
                  {currentService.status === 'pending' && <Card>
                      <CardHeader>
                        <CardTitle className="flex items-center gap-2 text-yellow-600">
                          <AlertTriangle className="w-5 h-5" />{t("client.src.service_alert")}</CardTitle>
                      </CardHeader>
                      <CardContent className="space-y-2">
                        <div className="p-3 bg-yellow-50 border border-yellow-200 rounded">
                          <p className="text-sm font-medium text-yellow-800">{t("client.src.service_pending")}</p>
                          <p className="text-xs text-yellow-600">{t("client.src.service_scheduled_for")}{currentService.nextService}</p>
                        </div>
                      </CardContent>
                    </Card>}
                </div>
              </div>
            </ScrollArea>
          </div>}
      </div>
    </div>;
}