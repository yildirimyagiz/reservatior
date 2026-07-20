"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { PageShell } from "@/pages-spa/client/layout/PageShell";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { MoreHorizontal, Plus, Search, Phone, Mail, MessageSquare, Star, TrendingUp, Edit, Eye, Calendar, User, Building, Trash2 } from "lucide-react";
import { Input } from "@/components/ui/input";
import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle, DialogFooter } from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { useToast } from "@/hooks/use-toast";
import { apiClient } from "@/lib/api/client";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { clientRelationshipsApi } from "@/lib/api/client-relationships";
interface ClientRelationship {
  id: string;
  orgId: string;
  clientId: string;
  relationshipType: RelationshipType;
  status: RelationshipStatus;
  agentId: string;
  propertyId?: string;
  contactPreferences: {
    preferredChannel: ContactChannel;
    contactFrequency: ContactFrequency;
    preferredTime?: string;
    timezone?: string;
  };
  satisfactionScore?: number;
  lastContactAt?: string;
  nextFollowUpAt?: string;
  notes?: string;
  tags: string[];
  metrics: {
    totalDeals?: number;
    totalValue?: number;
    averageDealSize?: number;
    conversionRate?: number;
    responseRate?: number;
    engagementScore?: number;
  };
  createdAt: string;
  updatedAt: string;
  client?: {
    id: string;
    name: string;
    email: string;
    phone?: string;
    type: "INDIVIDUAL" | "COMPANY";
    company?: string;
  };
  agent?: {
    id: string;
    name: string;
    email: string;
  };
  property?: {
    id: string;
    name: string;
    addressLine1: string;
    type: string;
  };
}
enum RelationshipType {
  TENANT = "TENANT",
  BUYER = "BUYER",
  SELLER = "SELLER",
  LANDLORD = "LANDLORD",
  INVESTOR = "INVESTOR",
  COMMERCIAL = "COMMERCIAL",
  PROPERTY_MANAGER = "PROPERTY_MANAGER",
  VENDOR = "VENDOR",
}
enum RelationshipStatus {
  ACTIVE = "ACTIVE",
  INACTIVE = "INACTIVE",
  PENDING = "PENDING",
  LOST = "LOST",
  ARCHIVED = "ARCHIVED",
}
enum ContactChannel {
  EMAIL = "EMAIL",
  PHONE = "PHONE",
  SMS = "SMS",
  WHATSAPP = "WHATSAPP",
  IN_PERSON = "IN_PERSON",
  VIDEO_CALL = "VIDEO_CALL",
}
enum ContactFrequency {
  DAILY = "DAILY",
  WEEKLY = "WEEKLY",
  BI_WEEKLY = "BI_WEEKLY",
  MONTHLY = "MONTHLY",
  QUARTERLY = "QUARTERLY",
  AS_NEEDED = "AS_NEEDED",
}
const RELATIONSHIP_TYPES = {
  TENANT: {
    label: t("client.src.tenant"),
    color: "bg-blue-100 text-blue-700"
  },
  BUYER: {
    label: t("client.src.buyer"),
    color: "bg-green-100 text-green-700"
  },
  SELLER: {
    label: t("client.src.seller"),
    color: "bg-purple-100 text-purple-700"
  },
  LANDLORD: {
    label: t("client.src.landlord"),
    color: "bg-orange-100 text-orange-700"
  },
  INVESTOR: {
    label: t("client.src.investor"),
    color: "bg-yellow-100 text-yellow-700"
  },
  COMMERCIAL: {
    label: t("client.src.commercial"),
    color: "bg-red-100 text-red-700"
  },
  PROPERTY_MANAGER: {
    label: t("client.src.property_manager"),
    color: "bg-indigo-100 text-indigo-700"
  },
  VENDOR: {
    label: t("client.src.vendor"),
    color: "bg-gray-100 text-gray-700"
  }
};
const STATUS_CONFIG = {
  ACTIVE: {
    label: t("client.src.active"),
    color: "bg-green-100 text-green-700"
  },
  INACTIVE: {
    label: t("client.src.inactive"),
    color: "bg-gray-100 text-gray-500"
  },
  PENDING: {
    label: t("client.src.pending"),
    color: "bg-yellow-100 text-yellow-700"
  },
  LOST: {
    label: t("client.src.lost"),
    color: "bg-red-100 text-red-700"
  },
  ARCHIVED: {
    label: t("client.src.archived"),
    color: "bg-gray-100 text-gray-500"
  }
};
const CONTACT_CHANNELS = {
  EMAIL: {
    label: t("client.src.email"),
    icon: Mail
  },
  PHONE: {
    label: t("client.src.phone"),
    icon: Phone
  },
  SMS: {
    label: t("client.src.sms"),
    icon: MessageSquare
  },
  WHATSAPP: {
    label: t("client.src.whatsapp"),
    icon: MessageSquare
  },
  IN_PERSON: {
    label: t("client.src.in_person"),
    icon: User
  },
  VIDEO_CALL: {
    label: t("client.src.video_call"),
    icon: User
  }
};
export default function ClientRelationships() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const [search, setSearch] = useState("");
  const [filterType, setFilterType] = useState("all");
  const [filterStatus, setFilterStatus] = useState("all");
  const [filterAgent, setFilterAgent] = useState("all");
  const [createOpen, setCreateOpen] = useState(false);
  const [editOpen, setEditOpen] = useState(false);
  const [selectedRelationship, setSelectedRelationship] = useState<ClientRelationship | null>(null);
  const queryClient = useQueryClient();

  const { data: relationships = [], isLoading: loading } = useQuery<ClientRelationship[]>({
    queryKey: ['client-relationships'],
    queryFn: async () => {
      const response = await clientRelationshipsApi.getAll({ page: 1, limit: 50 });
      return (response as any).data || [];
    }
  });
  const filteredRelationships = relationships.filter(relationship => {
    const matchesSearch = relationship.client?.name?.toLowerCase().includes(search.toLowerCase()) || relationship.client?.email?.toLowerCase().includes(search.toLowerCase()) || relationship.property?.name?.toLowerCase().includes(search.toLowerCase());
    const matchesType = filterType === "all" || relationship.relationshipType === filterType;
    const matchesStatus = filterStatus === "all" || relationship.status === filterStatus;
    const matchesAgent = filterAgent === "all" || relationship.agentId === filterAgent;
    return matchesSearch && matchesType && matchesStatus && matchesAgent;
  });
  const totalRelationships = filteredRelationships.length;
  const activeRelationships = filteredRelationships.filter(r => r.status === "ACTIVE").length;
  const highValueRelationships = filteredRelationships.filter(r => (r.metrics.totalValue || 0) > 100000).length;
  // const totalValue = filteredRelationships.reduce((sum, r) => sum + (r.metrics.totalValue || 0), 0);
  const avgSatisfaction = filteredRelationships.reduce((sum, r) => sum + (r.satisfactionScore || 0), 0) / (filteredRelationships.length || 1);
  const createMutation = useMutation({
    mutationFn: (data: any) => clientRelationshipsApi.create(data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['client-relationships'] });
      setCreateOpen(false);
      toast({ title: t("client.src.relationship_created"), description: t("client.src.new_client_relationship_has") });
    },
    onError: () => toast({ title: t("client.src.error"), description: t("client.src.failed_to_create_client"), variant: "destructive" })
  });

  const updateMutation = useMutation({
    mutationFn: ({ id, data }: { id: string, data: any }) => clientRelationshipsApi.update(id, data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['client-relationships'] });
      setEditOpen(false);
      toast({ title: t("client.src.relationship_updated"), description: t("client.src.client_relationship_has_been") });
    },
    onError: () => toast({ title: t("client.src.error"), description: t("client.src.failed_to_update_client"), variant: "destructive" })
  });

  const deleteMutation = useMutation({
    mutationFn: (id: string) => clientRelationshipsApi.delete(id),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['client-relationships'] });
      toast({ title: t("client.src.relationship_deleted"), description: t("client.src.client_relationship_has_been") });
    }
  });

  const handleCreateRelationship = (data: any) => createMutation.mutate(data);
  const handleUpdateRelationship = (id: string, data: any) => updateMutation.mutate({ id, data });
  const handleDeleteRelationship = (id: string) => deleteMutation.mutate(id);
  const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleDateString();
  };
  const formatCurrency = (amount: number) => {
    return new Intl.NumberFormat('en-US', {
      style: 'currency',
      currency: 'USD'
    }).format(amount);
  };
  const getRelationshipTypeColor = (type: RelationshipType) => {
    const config = RELATIONSHIP_TYPES[type];
    return config ? config.color : "bg-gray-100 text-gray-700";
  };
  const getStatusColor = (status: RelationshipStatus) => {
    const config = STATUS_CONFIG[status];
    return config ? config.color : "bg-gray-100 text-gray-700";
  };
  const getContactChannelIcon = (channel: ContactChannel) => {
    const config = CONTACT_CHANNELS[channel];
    return config ? <config.icon className="h-4 w-4" /> : null;
  };
  const getSatisfactionStars = (score?: number) => {
    if (!score) return 0;
    return Math.round(score);
  };
  return <PageShell title={t("client.src.client_relationships")} description={t("client.src.manage_client_relationships_and")}>
      <div className="space-y-6">
        {/* Summary Cards */}
        <div className="grid gap-4 md:grid-cols-4">
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("client.src.total_relationships")}</CardTitle>
              <User className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{totalRelationships}</div>
              <p className="text-xs text-muted-foreground">{t("client.src.all_client_relationships")}</p>
            </CardContent>
          </Card>
          
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("client.src.active")}</CardTitle>
              <TrendingUp className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-green-600">{activeRelationships}</div>
              <p className="text-xs text-muted-foreground">
                {totalRelationships > 0 ? (activeRelationships / totalRelationships * 100).toFixed(1) : 0}{t("client.src.active")}</p>
            </CardContent>
          </Card>
          
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("client.src.high_value")}</CardTitle>
              <Star className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-purple-600">{highValueRelationships}</div>
              <p className="text-xs text-muted-foreground">{t("client.src.100k_value")}</p>
            </CardContent>
          </Card>
          
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("client.src.avg_satisfaction")}</CardTitle>
              <Star className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-yellow-600">{avgSatisfaction.toFixed(1)}</div>
              <p className="text-xs text-muted-foreground">{t("client.src.out_of_50")}</p>
            </CardContent>
          </Card>
        </div>

        {/* Filters and Actions */}
        <div className="flex items-center justify-between space-x-4">
          <div className="flex items-center space-x-2">
            <div className="relative">
              <Search className="absolute left-2 top-2.5 h-4 w-4 text-gray-400" />
              <Input placeholder={t("client.src.search_relationships")} value={search} onChange={(e: React.ChangeEvent<HTMLInputElement>) => setSearch(e.target.value)} className="pl-8 w-64" />
            </div>
            <Select value={filterType} onValueChange={setFilterType}>
              <SelectTrigger className="w-32">
                <SelectValue placeholder={t("client.src.type")} />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="all">{t("client.src.all_types")}</SelectItem>
                {Object.values(RelationshipType).map(type => <SelectItem key={type} value={type}>
                    {RELATIONSHIP_TYPES[type]?.label}
                  </SelectItem>)}
              </SelectContent>
            </Select>
            <Select value={filterStatus} onValueChange={setFilterStatus}>
              <SelectTrigger className="w-32">
                <SelectValue placeholder={t("client.src.status")} />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="all">{t("client.src.all_status")}</SelectItem>
                {Object.values(RelationshipStatus).map(status => <SelectItem key={status} value={status}>
                    {STATUS_CONFIG[status]?.label}
                  </SelectItem>)}
              </SelectContent>
            </Select>
            <Select value={filterAgent} onValueChange={setFilterAgent}>
              <SelectTrigger className="w-32">
                <SelectValue placeholder={t("client.src.agent")} />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="all">{t("client.src.all_agents")}</SelectItem>
                {Array.from(new Set(relationships.map(r => r.agent?.name || "").filter(Boolean))).map(agentName => <SelectItem key={agentName} value={agentName}>
                    {agentName}
                  </SelectItem>)}
              </SelectContent>
            </Select>
          </div>
          <Button onClick={() => setCreateOpen(true)}>
            <Plus className="h-4 w-4 mr-2" />{t("client.src.add_relationship")}</Button>
        </div>

        {/* Relationships Table */}
        <Card>
          <CardHeader>
            <CardTitle>{t("client.src.client_relationships")}</CardTitle>
            <CardDescription>{t("client.src.manage_client_relationships_communication")}</CardDescription>
          </CardHeader>
          <CardContent>
            {loading ? <div className="flex items-center justify-center py-8">
                <div className="text-sm text-muted-foreground">{t("client.src.loading")}</div>
              </div> : <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>{t("client.src.client")}</TableHead>
                    <TableHead>{t("client.src.type")}</TableHead>
                    <TableHead>{t("client.src.status")}</TableHead>
                    <TableHead>{t("client.src.agent")}</TableHead>
                    <TableHead>{t("client.src.property")}</TableHead>
                    <TableHead>{t("client.src.contact")}</TableHead>
                    <TableHead>{t("client.src.satisfaction")}</TableHead>
                    <TableHead>{t("client.src.value")}</TableHead>
                    <TableHead>{t("client.src.next_followup")}</TableHead>
                    <TableHead className="w-[50px]"></TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {filteredRelationships.length === 0 ? <TableRow>
                      <TableCell colSpan={10} className="text-center py-8">{t("client.src.no_relationships_found")}</TableCell>
                    </TableRow> : filteredRelationships.map(relationship => <TableRow key={relationship.id}>
                        <TableCell>
                          <div>
                            <div className="font-medium">{relationship.client?.name}</div>
                            <div className="text-sm text-muted-foreground">{relationship.client?.email}</div>
                            {relationship.client?.phone && <div className="text-sm text-muted-foreground">{relationship.client.phone}</div>}
                          </div>
                        </TableCell>
                        <TableCell>
                          <Badge className={getRelationshipTypeColor(relationship.relationshipType)}>
                            {RELATIONSHIP_TYPES[relationship.relationshipType]?.label}
                          </Badge>
                        </TableCell>
                        <TableCell>
                          <Badge className={getStatusColor(relationship.status)}>
                            {STATUS_CONFIG[relationship.status]?.label}
                          </Badge>
                        </TableCell>
                        <TableCell>
                          <div>
                            <div className="font-medium">{relationship.agent?.name}</div>
                            <div className="text-sm text-muted-foreground">{relationship.agent?.email}</div>
                          </div>
                        </TableCell>
                        <TableCell>
                          {relationship.property ? <div>
                              <div className="font-medium">{relationship.property.name}</div>
                              <div className="text-sm text-muted-foreground">{relationship.property.addressLine1}</div>
                            </div> : <span className="text-muted-foreground">-</span>}
                        </TableCell>
                        <TableCell>
                          <div className="flex items-center space-x-2">
                            {getContactChannelIcon(relationship.contactPreferences.preferredChannel)}
                            <span className="text-sm">
                              {CONTACT_CHANNELS[relationship.contactPreferences.preferredChannel]?.label}
                            </span>
                          </div>
                        </TableCell>
                        <TableCell>
                          {relationship.satisfactionScore ? <div className="flex items-center space-x-1">
                              <div className="flex">
                                {[1, 2, 3, 4, 5].map(star => <Star key={star} className={`h-4 w-4 ${star <= getSatisfactionStars(relationship.satisfactionScore) ? "text-yellow-400 fill-current" : "text-gray-300"}`} />)}
                              </div>
                              <span className="text-sm text-muted-foreground ml-1">
                                ({relationship.satisfactionScore.toFixed(1)})
                              </span>
                            </div> : <span className="text-muted-foreground">-</span>}
                        </TableCell>
                        <TableCell className="font-medium">
                          {formatCurrency(relationship.metrics.totalValue || 0)}
                        </TableCell>
                        <TableCell>
                          <div className="text-sm">
                            {relationship.nextFollowUpAt ? formatDate(relationship.nextFollowUpAt) : "-"}
                          </div>
                        </TableCell>
                        <TableCell>
                          <DropdownMenu>
                            <DropdownMenuTrigger asChild>
                              <Button variant="ghost" size="sm">
                                <MoreHorizontal className="h-4 w-4" />
                              </Button>
                            </DropdownMenuTrigger>
                            <DropdownMenuContent>
                              <DropdownMenuItem onClick={() => {
                        setSelectedRelationship(relationship);
                        setEditOpen(true);
                      }}>
                                <Edit className="h-4 w-4 mr-2" />{t("client.src.edit")}</DropdownMenuItem>
                              <DropdownMenuItem>
                                <Eye className="h-4 w-4 mr-2" />{t("client.src.view_details")}</DropdownMenuItem>
                              <DropdownMenuItem>
                                <MessageSquare className="h-4 w-4 mr-2" />{t("client.src.send_message")}</DropdownMenuItem>
                              <DropdownMenuItem>
                                <Calendar className="h-4 w-4 mr-2" />{t("client.src.schedule_followup")}</DropdownMenuItem>
                              <DropdownMenuItem>
                                <Building className="h-4 w-4 mr-2" />{t("client.src.view_properties")}</DropdownMenuItem>
                              <DropdownMenuItem>
                                <TrendingUp className="h-4 w-4 mr-2" />{t("client.src.view_analytics")}</DropdownMenuItem>
                              <DropdownMenuItem className="text-red-600" onClick={() => handleDeleteRelationship(relationship.id)}>
                                <Trash2 className="h-4 w-4 mr-2" />{t("client.src.delete")}</DropdownMenuItem>
                            </DropdownMenuContent>
                          </DropdownMenu>
                        </TableCell>
                      </TableRow>)}
                </TableBody>
              </Table>}
          </CardContent>
        </Card>

        {/* Create Relationship Dialog */}
        <Dialog open={createOpen} onOpenChange={setCreateOpen}>
          <DialogContent className="sm:max-w-[600px]">
            <DialogHeader>
              <DialogTitle>{t("client.src.add_client_relationship")}</DialogTitle>
              <DialogDescription>{t("client.src.create_a_new_client")}</DialogDescription>
            </DialogHeader>
            <div className="space-y-4">
              <div className="grid grid-cols-2 gap-4">
                <div>
                  <Label htmlFor="client">{t("client.src.client")}</Label>
                  <Select>
                    <SelectTrigger>
                      <SelectValue placeholder={t("client.src.select_client")} />
                    </SelectTrigger>
                    <SelectContent>
                      {/* Add client options */}
                    </SelectContent>
                  </Select>
                </div>
                <div>
                  <Label htmlFor="relationshipType">{t("client.src.relationship_type")}</Label>
                  <Select>
                    <SelectTrigger>
                      <SelectValue placeholder={t("client.src.select_type")} />
                    </SelectTrigger>
                    <SelectContent>
                      {Object.values(RelationshipType).map(type => <SelectItem key={type} value={type}>
                          {RELATIONSHIP_TYPES[type]?.label}
                        </SelectItem>)}
                    </SelectContent>
                  </Select>
                </div>
              </div>
              <div className="grid grid-cols-2 gap-4">
                <div>
                  <Label htmlFor="agent">{t("client.src.agent")}</Label>
                  <Select>
                    <SelectTrigger>
                      <SelectValue placeholder={t("client.src.select_agent")} />
                    </SelectTrigger>
                    <SelectContent>
                      {/* Add agent options */}
                    </SelectContent>
                  </Select>
                </div>
                <div>
                  <Label htmlFor="property">{t("client.src.property_optional")}</Label>
                  <Select>
                    <SelectTrigger>
                      <SelectValue placeholder={t("client.src.select_property")} />
                    </SelectTrigger>
                    <SelectContent>
                      {/* Add property options */}
                    </SelectContent>
                  </Select>
                </div>
              </div>
              <div className="grid grid-cols-2 gap-4">
                <div>
                  <Label htmlFor="preferredChannel">{t("client.src.preferred_channel")}</Label>
                  <Select>
                    <SelectTrigger>
                      <SelectValue placeholder={t("client.src.select_channel")} />
                    </SelectTrigger>
                    <SelectContent>
                      {Object.values(ContactChannel).map(channel => <SelectItem key={channel} value={channel}>
                          {CONTACT_CHANNELS[channel]?.label}
                        </SelectItem>)}
                    </SelectContent>
                  </Select>
                </div>
                <div>
                  <Label htmlFor="contactFrequency">{t("client.src.contact_frequency")}</Label>
                  <Select>
                    <SelectTrigger>
                      <SelectValue placeholder={t("client.src.select_frequency")} />
                    </SelectTrigger>
                    <SelectContent>
                      {Object.values(ContactFrequency).map(frequency => <SelectItem key={frequency} value={frequency}>
                          {frequency.replace("_", " ")}
                        </SelectItem>)}
                    </SelectContent>
                  </Select>
                </div>
              </div>
              <div>
                <Label htmlFor="notes">{t("client.src.notes")}</Label>
                <textarea id="notes" placeholder={t("client.src.enter_relationship_notes_and")} className="w-full p-2 border rounded" rows={3} />
              </div>
              <div>
                <Label htmlFor="tags">{t("client.src.tags_comma_separated")}</Label>
                <Input id="tags" placeholder={t("client.src.vip_commercial_longterm_etc")} />
              </div>
            </div>
            <DialogFooter>
              <Button variant="outline" onClick={() => setCreateOpen(false)}>{t("client.src.cancel")}</Button>
              <Button onClick={() => handleCreateRelationship({})}>{t("client.src.create_relationship")}</Button>
            </DialogFooter>
          </DialogContent>
        </Dialog>

        {/* Edit Relationship Dialog */}
        <Dialog open={editOpen} onOpenChange={setEditOpen}>
          <DialogContent className="sm:max-w-[600px]">
            <DialogHeader>
              <DialogTitle>{t("client.src.edit_client_relationship")}</DialogTitle>
              <DialogDescription>{t("client.src.update_client_relationship_details")}</DialogDescription>
            </DialogHeader>
            <div className="space-y-4">
              {/* Edit form fields */}
            </div>
            <DialogFooter>
              <Button variant="outline" onClick={() => setEditOpen(false)}>{t("client.src.cancel")}</Button>
              <Button onClick={() => selectedRelationship && handleUpdateRelationship(selectedRelationship.id, {})}>{t("client.src.update_relationship")}</Button>
            </DialogFooter>
          </DialogContent>
        </Dialog>
      </div>
    </PageShell>;
}