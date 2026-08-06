"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { PageShell } from "../layout/PageShell";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription, DialogFooter } from "@/components/ui/dialog";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { useToast } from "@/hooks/use-toast";
import { agentsApi } from "@/lib/api/agents";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { Edit, Trash2, MoreHorizontal, Mail, Star, Plus, Search, Phone, Building, MapPin, Loader2 } from "lucide-react";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
interface Agent {
  id: string;
  orgId: string;
  userId: string;
  firstName: string;
  lastName: string;
  email: string;
  phone?: string;
  bio?: string;
  licenseNumber?: string;
  status: AgentStatus;
  rating?: number;
  totalDeals?: number;
  totalRevenue?: number;
  agencyId?: string;
  specialization?: string[];
  commissionRate?: number;
  createdAt: string;
  updatedAt: string;
  user?: {
    id: string;
    email: string;
    name: string;
  };
  agency?: {
    id: string;
    name: string;
    address?: string;
  };
}
enum AgentStatus {
  ACTIVE = "ACTIVE",
  INACTIVE = "INACTIVE",
  PENDING = "PENDING",
  SUSPENDED = "SUSPENDED",
}
const STATUS_COLORS: Record<AgentStatus, string> = {
  ACTIVE: "bg-blue-100 text-blue-700",
  INACTIVE: "bg-gray-100 text-gray-600",
  PENDING: "bg-yellow-100 text-yellow-700",
  SUSPENDED: "bg-red-100 text-red-700"
};
export default function Agents() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const [search, setSearch] = useState("");
  const [filterStatus, setFilterStatus] = useState("all");
  const [filterAgency, setFilterAgency] = useState("all");
  const [createOpen, setCreateOpen] = useState(false);
  const [editOpen, setEditOpen] = useState(false);
  const queryClient = useQueryClient();
  const [selectedAgent, setSelectedAgent] = useState<Agent | null>(null);
  const { data: rawData = [], isLoading: loading } = useQuery({
    queryKey: ['agents'],
    queryFn: async () => {
      const response = await agentsApi.getAll({ page: "1", limit: "50" }) as any;
      return (response.data || response || []) as Agent[];
    }
  });

  const agents = rawData;
  const filteredAgents = agents.filter(agent => {
    const matchesSearch = agent.firstName.toLowerCase().includes(search.toLowerCase()) || agent.lastName.toLowerCase().includes(search.toLowerCase()) || agent.email.toLowerCase().includes(search.toLowerCase()) || agent.user?.name?.toLowerCase().includes(search.toLowerCase());
    const matchesStatus = filterStatus === "all" || agent.status === filterStatus;
    const matchesAgency = filterAgency === "all" || agent.agencyId === filterAgency;
    return matchesSearch && matchesStatus && matchesAgency;
  });
  const totalAgents = filteredAgents.length;
  const activeAgents = filteredAgents.filter(a => a.status === "ACTIVE").length;
  const pendingAgents = filteredAgents.filter(a => a.status === "PENDING").length;
  const totalRevenue = filteredAgents.reduce((sum, a) => sum + (a.totalRevenue || 0), 0);
  const createMutation = useMutation({
    mutationFn: (data: any) => agentsApi.create(data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['agents'] });
      setCreateOpen(false);
      toast({
        title: t("client.src.agent_created"),
        description: t("client.src.new_agent_has_been")
      });
    },
    onError: () => {
      toast({
        title: t("common.error"),
        description: t("client.src.failed_to_create_agent"),
        variant: "destructive"
      });
    }
  });

  const updateMutation = useMutation({
    mutationFn: ({ id, data }: { id: string, data: any }) => agentsApi.update(id, data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['agents'] });
      setEditOpen(false);
      toast({
        title: t("client.src.agent_updated"),
        description: t("client.src.agent_has_been_updated")
      });
    },
    onError: () => {
      toast({
        title: t("common.error"),
        description: t("client.src.failed_to_update_agent"),
        variant: "destructive"
      });
    }
  });

  const deleteMutation = useMutation({
    mutationFn: (id: string) => agentsApi.delete(id),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['agents'] });
      toast({
        title: t("client.src.agent_deleted"),
        description: t("client.src.agent_has_been_deleted")
      });
    }
  });

  const handleCreateAgent = (data: any) => createMutation.mutate(data);
  const handleUpdateAgent = (id: string, data: any) => updateMutation.mutate({ id, data });
  const handleDeleteAgent = (id: string) => deleteMutation.mutate(id);
  const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleDateString();
  };
  const formatCurrency = (amount: number) => {
    return new Intl.NumberFormat('en-US', {
      style: 'currency',
      currency: 'USD'
    }).format(amount);
  };
  const getStatusColor = (status: AgentStatus) => {
    return STATUS_COLORS[status] || "bg-gray-100 text-gray-700";
  };
  const getRatingStars = (rating?: number) => {
    if (!rating) return 0;
    return Math.round(rating);
  };
  return <PageShell title={t("client.src.agents")} description={t("client.src.manage_real_estate_agents")}>
      <div className="space-y-6">
        {/* Summary Cards */}
        <div className="grid gap-4 md:grid-cols-4">
          <div className="bg-card p-6 rounded-lg shadow">
            <h3 className="text-sm font-medium text-gray-500">{t("client.src.total_agents")}</h3>
            <p className="text-2xl font-bold text-gray-900">{totalAgents}</p>
          </div>
          <div className="bg-card p-6 rounded-lg shadow">
            <h3 className="text-sm font-medium text-gray-500">{t("common.active")}</h3>
            <p className="text-2xl font-bold text-blue-600">{activeAgents}</p>
          </div>
          <div className="bg-card p-6 rounded-lg shadow">
            <h3 className="text-sm font-medium text-gray-500">{t("common.processing")}</h3>
            <p className="text-2xl font-bold text-yellow-600">{pendingAgents}</p>
          </div>
          <div className="bg-card p-6 rounded-lg shadow">
            <h3 className="text-sm font-medium text-gray-500">{t("common.total_revenue")}</h3>
            <p className="text-2xl font-bold text-brand">{formatCurrency(totalRevenue)}</p>
          </div>
        </div>

        {/* Filters and Actions */}
        <div className="flex items-center justify-between space-x-4">
          <div className="flex items-center space-x-2">
            <div className="relative">
              <Search className="absolute left-2 top-2.5 h-4 w-4 text-gray-400" />
              <Input placeholder={t("client.src.search_agents")} value={search} onChange={e => setSearch(e.target.value)} className="pl-8 w-64" />
            </div>
            <Select value={filterStatus} onValueChange={setFilterStatus}>
              <SelectTrigger className="w-32">
                <SelectValue placeholder={t("common.status")} />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="all">{t("common.all_status")}</SelectItem>
                {Object.values(AgentStatus).map(status => <SelectItem key={status} value={status}>
                    {status}
                  </SelectItem>)}
              </SelectContent>
            </Select>
            <Select value={filterAgency} onValueChange={setFilterAgency}>
              <SelectTrigger className="w-32">
                <SelectValue placeholder={t("common.agency")} />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="all">{t("client.src.all_agencies")}</SelectItem>
                {Array.from(new Set(agents.map(a => a.agency?.name).filter(Boolean))).map(agencyName => <SelectItem key={agencyName as string} value={agencyName as string}>
                    {agencyName}
                  </SelectItem>)}
              </SelectContent>
            </Select>
          </div>
          <Button onClick={() => setCreateOpen(true)}>
            <Plus className="h-4 w-4 mr-2" />{t("client.src.add_agent")}</Button>
        </div>

        {/* Agents Table */}
        <div className="bg-card rounded-lg shadow">
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>{t("common.agent")}</TableHead>
                <TableHead>{t("client.src.contact")}</TableHead>
                <TableHead>{t("common.agency")}</TableHead>
                <TableHead>{t("common.status")}</TableHead>
                <TableHead>{t("client.src.rating")}</TableHead>
                <TableHead>{t("client.src.deals")}</TableHead>
                <TableHead>{t("common.revenue")}</TableHead>
                <TableHead>{t("client.src.joined")}</TableHead>
                <TableHead>{t("common.actions")}</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {loading ? <TableRow>
                  <TableCell colSpan={9} className="text-center py-8"><Loader2 className="w-8 h-8 animate-spin mx-auto text-primary" /></TableCell>
                </TableRow> : filteredAgents.length === 0 ? <TableRow>
                  <TableCell colSpan={9} className="text-center py-8">{t("client.src.no_agents_found")}</TableCell>
                </TableRow> : filteredAgents.map(agent => <TableRow key={agent.id}>
                    <TableCell>
                      <div className="flex items-center space-x-3">
                        <Avatar className="h-10 w-10">
                          <AvatarFallback>
                            {agent.firstName.charAt(0)}{agent.lastName.charAt(0)}
                          </AvatarFallback>
                        </Avatar>
                        <div>
                          <div className="font-medium">
                            {agent.firstName} {agent.lastName}
                          </div>
                          <div className="text-sm text-gray-500">
                            {agent.licenseNumber && `License: ${agent.licenseNumber}`}
                          </div>
                        </div>
                      </div>
                    </TableCell>
                    <TableCell>
                      <div>
                        <div className="text-sm">{agent.email}</div>
                        {agent.phone && <div className="text-sm text-gray-500">{agent.phone}</div>}
                      </div>
                    </TableCell>
                    <TableCell>
                      <div>
                        <div className="font-medium">{agent.agency?.name}</div>
                        {agent.agency?.address && <div className="text-sm text-gray-500">{agent.agency.address}</div>}
                      </div>
                    </TableCell>
                    <TableCell>
                      <Badge className={getStatusColor(agent.status)}>
                        {agent.status}
                      </Badge>
                    </TableCell>
                    <TableCell>
                      <div className="flex items-center">
                        <div className="flex">
                          {[1, 2, 3, 4, 5].map(star => <Star key={star} className={`h-4 w-4 ${star <= getRatingStars(agent.rating) ? "text-yellow-400 fill-current" : "text-gray-300"}`} />)}
                        </div>
                        {agent.rating && <span className="ml-2 text-sm text-gray-600">
                            ({agent.rating})
                          </span>}
                      </div>
                    </TableCell>
                    <TableCell>
                      <div className="text-sm">
                        {agent.totalDeals || 0}{t("client.src.deals")}</div>
                    </TableCell>
                    <TableCell>
                      <div className="text-sm font-medium">
                        {formatCurrency(agent.totalRevenue || 0)}
                      </div>
                    </TableCell>
                    <TableCell>
                      <div className="text-sm">{formatDate(agent.createdAt)}</div>
                    </TableCell>
                    <TableCell>
                      <DropdownMenu>
                        <DropdownMenuTrigger asChild>
                          <Button variant="ghost" size="sm" aria-label={t("common.more")}>
                            <MoreHorizontal className="h-4 w-4" />
                          </Button>
                        </DropdownMenuTrigger>
                        <DropdownMenuContent>
                          <DropdownMenuItem onClick={() => {
                      setSelectedAgent(agent);
                      setEditOpen(true);
                    }}>
                            <Edit className="h-4 w-4 mr-2" />{t("common.edit")}</DropdownMenuItem>
                          <DropdownMenuItem>
                            <Mail className="h-4 w-4 mr-2" />{t("client.src.send_email")}</DropdownMenuItem>
                          <DropdownMenuItem>
                            <Phone className="h-4 w-4 mr-2" />{t("client.src.call")}</DropdownMenuItem>
                          <DropdownMenuItem>
                            <Building className="h-4 w-4 mr-2" />{t("client.src.view_performance")}</DropdownMenuItem>
                          <DropdownMenuItem>
                            <MapPin className="h-4 w-4 mr-2" />{t("client.src.view_properties")}</DropdownMenuItem>
                          <DropdownMenuItem className="text-red-600" onClick={() => handleDeleteAgent(agent.id)}>
                            <Trash2 className="h-4 w-4 mr-2" />{t("common.delete")}</DropdownMenuItem>
                        </DropdownMenuContent>
                      </DropdownMenu>
                    </TableCell>
                  </TableRow>)}
            </TableBody>
          </Table>
        </div>

        {/* Create Agent Dialog */}
        <Dialog open={createOpen} onOpenChange={setCreateOpen}>
          <DialogContent className="sm:max-w-[600px]">
            <DialogHeader>
              <DialogTitle>{t("client.src.add_new_agent")}</DialogTitle>
              <DialogDescription>{t("client.src.create_a_new_agent")}</DialogDescription>
            </DialogHeader>
            <div className="space-y-4">
              <div className="grid grid-cols-2 gap-4">
                <div>
                  <Label htmlFor="firstName">{t("client.src.first_name")}</Label>
                  <Input id="firstName" placeholder={t("client.src.enter_first_name")} />
                </div>
                <div>
                  <Label htmlFor="lastName">{t("client.src.last_name")}</Label>
                  <Input id="lastName" placeholder={t("client.src.enter_last_name")} />
                </div>
              </div>
              <div className="grid grid-cols-2 gap-4">
                <div>
                  <Label htmlFor="email">{t("common.email")}</Label>
                  <Input id="email" type="email" placeholder={t("client.src.enter_email_address")} />
                </div>
                <div>
                  <Label htmlFor="phone">{t("client.src.phone")}</Label>
                  <Input id="phone" placeholder={t("client.src.enter_phone_number")} />
                </div>
              </div>
              <div>
                <Label htmlFor="licenseNumber">{t("client.src.license_number")}</Label>
                <Input id="licenseNumber" placeholder={t("client.src.enter_license_number")} />
              </div>
              <div>
                <Label htmlFor="agency">{t("common.agency")}</Label>
                <Select>
                  <SelectTrigger>
                    <SelectValue placeholder={t("client.src.select_agency")} />
                  </SelectTrigger>
                  <SelectContent>
                    {/* Add agency options */}
                  </SelectContent>
                </Select>
              </div>
              <div>
                <Label htmlFor="specialization">{t("client.src.specialization")}</Label>
                <Select>
                  <SelectTrigger>
                    <SelectValue placeholder={t("client.src.select_specialization")} />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="residential">{t("client.src.residential")}</SelectItem>
                    <SelectItem value="commercial">{t("client.src.commercial")}</SelectItem>
                    <SelectItem value="luxury">{t("client.src.luxury")}</SelectItem>
                    <SelectItem value="rental">{t("client.src.rental")}</SelectItem>
                    <SelectItem value="property-management">{t("client.src.property_management")}</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <div>
                <Label htmlFor="commissionRate">{t("client.src.commission_rate")}</Label>
                <Input id="commissionRate" type="number" placeholder="2.5" step="0.1" />
              </div>
              <div>
                <Label htmlFor="bio">{t("client.src.bio")}</Label>
                <Textarea id="bio" placeholder={t("client.src.enter_agent_bio_and")} rows={3} />
              </div>
            </div>
            <DialogFooter>
              <Button variant="outline" onClick={() => setCreateOpen(false)}>{t("common.cancel")}</Button>
              <Button onClick={() => handleCreateAgent({})}>{t("client.src.create_agent")}</Button>
            </DialogFooter>
          </DialogContent>
        </Dialog>

        {/* Edit Agent Dialog */}
        <Dialog open={editOpen} onOpenChange={setEditOpen}>
          <DialogContent className="sm:max-w-[600px]">
            <DialogHeader>
              <DialogTitle>{t("client.src.edit_agent")}</DialogTitle>
              <DialogDescription>{t("client.src.update_agent_information_and")}</DialogDescription>
            </DialogHeader>
            <div className="space-y-4">
              {/* Edit form fields */}
            </div>
            <DialogFooter>
              <Button variant="outline" onClick={() => setEditOpen(false)}>{t("common.cancel")}</Button>
              <Button onClick={() => selectedAgent && handleUpdateAgent(selectedAgent.id, {})}>{t("client.src.update_agent")}</Button>
            </DialogFooter>
          </DialogContent>
        </Dialog>
      </div>
    </PageShell>;
}