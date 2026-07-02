import { useTranslation } from "react-i18next";
import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuLabel, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { Eye, Calendar, Users, CheckCircle, XCircle, MoreHorizontal, Activity, Star, TrendingUp } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { apiClient } from "@/lib/api/client";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";

interface PropertyViewing {
  id: string;
  orgId?: string;
  propertyId: string;
  leadId?: string;
  agentId?: string;
  viewingType: 'IN_PERSON' | 'VIRTUAL' | 'SELF_GUIDED';
  status: 'SCHEDULED' | 'CONFIRMED' | 'COMPLETED' | 'CANCELLED' | 'NO_SHOW';
  scheduledAt: Date;
  duration: number;
  notes?: string;
  feedback?: {
    rating?: number;
    comments?: string;
    interested: boolean;
  };
  createdAt: Date;
  property?: {
    id: string;
    address: string;
    city: string;
    state: string;
  };
  lead?: {
    id: string;
    name: string;
    email: string;
  };
}
export default function PropertyViewings() {
  const { t } = useTranslation();
  const { toast } = useToast();
  const queryClient = useQueryClient();
  const deleteMutation = useMutation({
    mutationFn: async (id: string) => apiClient.delete(`/api/v1/unknown/${id}`),
    onSuccess: () => {
      toast({ title: "Deleted", description: "Record deleted successfully" });
      queryClient.invalidateQueries();
    },
    onError: (err: any) => toast({ title: "Error", description: err.message, variant: "destructive" })
  });
  

  const [statusFilter, setStatusFilter] = useState<string>('all');
  const [typeFilter, setTypeFilter] = useState<string>('all');
  const { data: viewings = [], isLoading } = useQuery({
    queryKey: ['property-viewing', statusFilter, typeFilter],
    queryFn: async () => {
      const params = new URLSearchParams();
      if (statusFilter !== 'all') params.append('status', statusFilter);
      if (typeFilter !== 'all') params.append('type', typeFilter);
      const response = await apiClient.get(`/property-viewing?${params}`) as { data: PropertyViewing[] };
      return response.data;
    }
  });
  const updateStatusMutation = useMutation({
    mutationFn: async ({ viewingId, status }: { viewingId: string; status: string }) => {
      await apiClient.put(`/property-viewing/${viewingId}`, { status });
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['property-viewing'] });
      toast({ title: t("admin.property.success"), description: t("admin.property.viewing_status_updated_successfully") });
    },
    onError: () => {
      toast({ title: t("admin.property.error"), description: t("admin.property.failed_to_update_viewing"), variant: "destructive" });
    }
  });
  const getStatusColor = (status: string) => {
    switch (status) {
      case 'SCHEDULED': return 'bg-blue-500';
      case 'CONFIRMED': return 'bg-green-500';
      case 'COMPLETED': return 'bg-purple-500';
      case 'CANCELLED': return 'bg-red-500';
      case 'NO_SHOW': return 'bg-gray-500';
      default: return 'bg-gray-500';
    }
  };
  const getTypeIcon = (type: string) => {
    switch (type) {
      case 'IN_PERSON': return <Users className="h-4 w-4 text-slate-400" />;
      case 'VIRTUAL': return <Eye className="h-4 w-4 text-slate-400" />;
      case 'SELF_GUIDED': return <Activity className="h-4 w-4 text-slate-400" />;
      default: return <Calendar className="h-4 w-4 text-slate-400" />;
    }
  };
  const scheduledViewings = viewings.filter(v => v.status === 'SCHEDULED').length;
  const completedViewings = viewings.filter(v => v.status === 'COMPLETED').length;
  const avgRating = viewings.filter(v => v.feedback?.rating).reduce((acc, v, _, arr) => arr.length > 0 ? acc + (v.feedback?.rating || 0) / arr.length : 0, 0);
  const conversionRate = viewings.length > 0 ? viewings.filter(v => v.feedback?.interested).length / viewings.length * 100 : 0;
  if (isLoading) {
    return <div className="min-h-screen bg-background p-6">
        <div className="bg-white/5 p-6 rounded-2xl border border-white/10">
          <h1 className="text-xl font-bold text-white">{t("admin.property.property_viewings")}</h1>
        </div>
        <div className="flex items-center justify-center h-64 mt-6">
          <Activity className="h-8 w-8 animate-spin text-white" />
        </div>
      </div>;
  }
  return <div className="min-h-screen bg-background">
      <div className="p-6 space-y-6">
        <div className="bg-white/5 p-6 rounded-2xl border border-white/10">
          <h1 className="text-xl font-bold text-white">{t("admin.property.property_viewings")}</h1>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
          <Card className="bg-white/5 border-white/10">
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium text-slate-400">{t("admin.property.scheduled_viewings")}</CardTitle>
              <Calendar className="h-4 w-4 text-slate-400" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-white">{scheduledViewings}</div>
              <p className="text-xs text-slate-400">{t("admin.property.upcoming_appointments")}</p>
            </CardContent>
          </Card>

          <Card className="bg-white/5 border-white/10">
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium text-slate-400">{t("admin.property.completed_viewings")}</CardTitle>
              <CheckCircle className="h-4 w-4 text-slate-400" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-green-400">{completedViewings}</div>
              <p className="text-xs text-slate-400">{t("admin.property.total_completed_this_month")}</p>
            </CardContent>
          </Card>

          <Card className="bg-white/5 border-white/10">
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium text-slate-400">{t("admin.property.avg_rating")}</CardTitle>
              <Star className="h-4 w-4 text-slate-400" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-white">{avgRating.toFixed(1)}/5</div>
              <p className="text-xs text-slate-400">{t("admin.property.customer_satisfaction")}</p>
            </CardContent>
          </Card>

          <Card className="bg-white/5 border-white/10">
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium text-slate-400">{t("admin.property.conversion_rate")}</CardTitle>
              <TrendingUp className="h-4 w-4 text-slate-400" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-white">{conversionRate.toFixed(1)}%</div>
              <p className="text-xs text-slate-400">{t("admin.property.interested_leads")}</p>
            </CardContent>
          </Card>
        </div>

        <Card className="bg-white/5 border-white/10">
          <CardContent className="pt-6">
            <div className="flex gap-4">
              <div className="flex items-center gap-2">
                <span className="text-sm font-medium text-slate-400">{t("admin.property.status")}</span>
                <Select value={statusFilter} onValueChange={setStatusFilter}>
                  <SelectTrigger className="w-[150px] bg-white/5 border-white/10 text-white">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent className="bg-[#14151a] border-white/10 text-white">
                    <SelectItem value="all">{t("admin.property.all_statuses")}</SelectItem>
                    <SelectItem value="SCHEDULED">{t("admin.property.scheduled")}</SelectItem>
                    <SelectItem value="CONFIRMED">{t("admin.property.confirmed")}</SelectItem>
                    <SelectItem value="COMPLETED">{t("admin.property.completed")}</SelectItem>
                    <SelectItem value="CANCELLED">{t("admin.property.cancelled")}</SelectItem>
                    <SelectItem value="NO_SHOW">{t("admin.property.no_show")}</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <div className="flex items-center gap-2">
                <span className="text-sm font-medium text-slate-400">{t("admin.property.type")}</span>
                <Select value={typeFilter} onValueChange={setTypeFilter}>
                  <SelectTrigger className="w-[150px] bg-white/5 border-white/10 text-white">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent className="bg-[#14151a] border-white/10 text-white">
                    <SelectItem value="all">{t("admin.property.all_types")}</SelectItem>
                    <SelectItem value="IN_PERSON">{t("admin.property.in_person")}</SelectItem>
                    <SelectItem value="VIRTUAL">{t("admin.property.virtual")}</SelectItem>
                    <SelectItem value="SELF_GUIDED">{t("admin.property.self_guided")}</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card className="bg-white/5 border-white/10">
          <CardHeader>
            <CardTitle className="text-white">{t("admin.property.property_viewings")}</CardTitle>
            <p className="text-sm text-slate-400">{t("admin.property.manage_and_track_property")}</p>
          </CardHeader>
          <CardContent>
            <Table>
              <TableHeader>
                <TableRow className="border-white/10">
                  <TableHead className="text-slate-400">{t("admin.property.property")}</TableHead>
                  <TableHead className="text-slate-400">{t("admin.property.lead")}</TableHead>
                  <TableHead className="text-slate-400">{t("admin.property.type")}</TableHead>
                  <TableHead className="text-slate-400">{t("admin.property.status")}</TableHead>
                  <TableHead className="text-slate-400">{t("admin.property.scheduled")}</TableHead>
                  <TableHead className="text-slate-400">{t("admin.property.duration")}</TableHead>
                  <TableHead className="text-slate-400">{t("admin.property.rating")}</TableHead>
                  <TableHead className="text-slate-400">{t("admin.property.interested")}</TableHead>
                  <TableHead className="text-right text-slate-400">{t("admin.property.actions")}</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {viewings.map(viewing => <TableRow key={viewing.id} className="border-white/10">
                    <TableCell className="font-medium text-white">
                      <div>
                        <div className="text-white">{viewing.property?.address || `Property ${viewing.propertyId}`}</div>
                        <div className="text-xs text-slate-400">
                          {viewing.property?.city}, {viewing.property?.state}
                        </div>
                      </div>
                    </TableCell>
                    <TableCell className="text-slate-400">
                      <div>
                        <div className="font-medium text-white">{viewing.lead?.name || 'Unknown'}</div>
                        <div className="text-xs text-slate-400">{viewing.lead?.email}</div>
                      </div>
                    </TableCell>
                    <TableCell>
                      <div className="flex items-center gap-2 text-white">
                        {getTypeIcon(viewing.viewingType)}
                        <span className="capitalize">{viewing.viewingType.replace('_', ' ').toLowerCase()}</span>
                      </div>
                    </TableCell>
                    <TableCell>
                      <div className="flex items-center gap-2 text-white">
                        <div className={`w-2 h-2 rounded-full ${getStatusColor(viewing.status)}`} />
                        <span className="capitalize">{viewing.status.toLowerCase()}</span>
                      </div>
                    </TableCell>
                    <TableCell className="text-slate-400">{new Date(viewing.scheduledAt).toLocaleString()}</TableCell>
                    <TableCell className="text-slate-400">{viewing.duration}{t("admin.property.min")}</TableCell>
                    <TableCell>
                      {viewing.feedback?.rating ? <div className="flex items-center gap-1">
                          <Star className="h-3 w-3 fill-yellow-400 text-yellow-400" />
                          <span className="text-sm text-white">{viewing.feedback.rating}/5</span>
                        </div> : <span className="text-slate-400">-</span>}
                    </TableCell>
                    <TableCell>
                      {viewing.feedback ? viewing.feedback.interested ? <CheckCircle className="h-4 w-4 text-green-500" /> : <XCircle className="h-4 w-4 text-red-500" /> : <span className="text-slate-400">-</span>}
                    </TableCell>
                    <TableCell className="text-right">
                      <DropdownMenu>
                        <DropdownMenuTrigger asChild>
                          <Button variant="ghost" className="h-8 w-8 p-0 text-slate-400">
                            <MoreHorizontal className="h-4 w-4" />
                          </Button>
                        </DropdownMenuTrigger>
                        <DropdownMenuContent align="end" className="bg-[#14151a] border-white/10 text-white">
                          <DropdownMenuLabel className="text-slate-400">{t("admin.property.actions")}</DropdownMenuLabel>
                          <DropdownMenuItem className="hover:bg-white/5">
                            <Eye className="h-4 w-4 mr-2" />{t("admin.property.view_details")}
                          </DropdownMenuItem>
                          {viewing.status === 'SCHEDULED' && <>
                              <DropdownMenuItem className="hover:bg-white/5" onClick={() => updateStatusMutation.mutate({ viewingId: viewing.id, status: 'CONFIRMED' })}>
                                <CheckCircle className="h-4 w-4 mr-2" />{t("admin.property.confirm")}
                              </DropdownMenuItem>
                              <DropdownMenuItem className="hover:bg-white/5 text-red-600" onClick={() => updateStatusMutation.mutate({ viewingId: viewing.id, status: 'CANCELLED' })}>
                                <XCircle className="h-4 w-4 mr-2" />{t("admin.property.cancel")}
                              </DropdownMenuItem>
                            </>}
                          {viewing.status === 'CONFIRMED' && <DropdownMenuItem className="hover:bg-white/5" onClick={() => updateStatusMutation.mutate({ viewingId: viewing.id, status: 'COMPLETED' })}>
                              <CheckCircle className="h-4 w-4 mr-2" />{t("admin.property.mark_complete")}
                            </DropdownMenuItem>}
                        </DropdownMenuContent>
                      </DropdownMenu>
                    </TableCell>
                  </TableRow>)}
              </TableBody>
            </Table>
          </CardContent>
        </Card>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          <Card className="bg-white/5 border-white/10">
            <CardHeader>
              <CardTitle className="text-white">{t("admin.property.viewing_types_distribution")}</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                <div className="flex justify-between items-center">
                  <span className="text-sm text-white flex items-center gap-2">
                    <Users className="h-4 w-4 text-slate-400" />{t("admin.property.in_person")}</span>
                  <span className="font-medium text-white">{viewings.filter(v => v.viewingType === 'IN_PERSON').length}</span>
                </div>
                <div className="flex justify-between items-center">
                  <span className="text-sm text-white flex items-center gap-2">
                    <Eye className="h-4 w-4 text-slate-400" />{t("admin.property.virtual")}</span>
                  <span className="font-medium text-white">{viewings.filter(v => v.viewingType === 'VIRTUAL').length}</span>
                </div>
                <div className="flex justify-between items-center">
                  <span className="text-sm text-white flex items-center gap-2">
                    <Activity className="h-4 w-4 text-slate-400" />{t("admin.property.self_guided")}</span>
                  <span className="font-medium text-white">{viewings.filter(v => v.viewingType === 'SELF_GUIDED').length}</span>
                </div>
              </div>
            </CardContent>
          </Card>

          <Card className="bg-white/5 border-white/10">
            <CardHeader>
              <CardTitle className="text-white">{t("admin.property.status_overview")}</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                <div className="flex justify-between items-center">
                  <span className="text-sm text-white">{t("admin.property.scheduled")}</span>
                  <span className="font-medium text-white">{scheduledViewings}</span>
                </div>
                <div className="flex justify-between items-center">
                  <span className="text-sm text-white">{t("admin.property.confirmed")}</span>
                  <span className="font-medium text-white">{viewings.filter(v => v.status === 'CONFIRMED').length}</span>
                </div>
                <div className="flex justify-between items-center">
                  <span className="text-sm text-white">{t("admin.property.completed")}</span>
                  <span className="font-medium text-green-400">{completedViewings}</span>
                </div>
                <div className="flex justify-between items-center">
                  <span className="text-sm text-white">{t("admin.property.no_show")}</span>
                  <span className="font-medium text-red-400">{viewings.filter(v => v.status === 'NO_SHOW').length}</span>
                </div>
              </div>
            </CardContent>
          </Card>
        </div>
      </div>
    </div>;
}
