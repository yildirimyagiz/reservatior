import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { PageShell } from "../../client/layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuLabel, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { Eye, Calendar, Users, CheckCircle, XCircle, MoreHorizontal, Activity, Star, TrendingUp } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { apiClient } from "@/lib/api";
interface PropertyViewing {
  id: string;
  orgId?: string;
  propertyId: string;
  leadId?: string;
  agentId?: string;
  viewingType: 'IN_PERSON' | 'VIRTUAL' | 'SELF_GUIDED';
  status: 'SCHEDULED' | 'CONFIRMED' | 'COMPLETED' | 'CANCELLED' | 'NO_SHOW';
  scheduledAt: Date;
  duration: number; // minutes
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
  const {
    t
  } = useTranslation();
  const [viewings, setViewings] = useState<PropertyViewing[]>([]);
  const [loading, setLoading] = useState(true);
  const [statusFilter, setStatusFilter] = useState<string>('all');
  const [typeFilter, setTypeFilter] = useState<string>('all');
  const {
    toast
  } = useToast();
  useEffect(() => {
    fetchViewings();
  }, [statusFilter, typeFilter]);
  const fetchViewings = async () => {
    try {
      const params = new URLSearchParams();
      if (statusFilter !== 'all') params.append('status', statusFilter);
      if (typeFilter !== 'all') params.append('type', typeFilter);
      const response = (await apiClient.get(`/properties/viewings?${params}`)) as {
        data: PropertyViewing[];
      };
      setViewings(response.data);
    } catch (error) {
      toast({
        title: t("admin.property.error"),
        description: t("admin.property.failed_to_fetch_property"),
        variant: "destructive"
      });
    } finally {
      setLoading(false);
    }
  };
  const updateViewingStatus = async (viewingId: string, status: string) => {
    try {
      await apiClient.put(`/properties/viewings/${viewingId}`, {
        status
      });
      setViewings(viewings.map(v => v.id === viewingId ? {
        ...v,
        status: status as any
      } : v));
      toast({
        title: t("admin.property.success"),
        description: t("admin.property.viewing_status_updated_successfully")
      });
    } catch (error) {
      toast({
        title: t("admin.property.error"),
        description: t("admin.property.failed_to_update_viewing"),
        variant: "destructive"
      });
    }
  };
  const getStatusColor = (status: string) => {
    switch (status) {
      case 'SCHEDULED':
        return 'bg-blue-500';
      case 'CONFIRMED':
        return 'bg-green-500';
      case 'COMPLETED':
        return 'bg-purple-500';
      case 'CANCELLED':
        return 'bg-red-500';
      case 'NO_SHOW':
        return 'bg-gray-500';
      default:
        return 'bg-gray-500';
    }
  };
  const getTypeIcon = (type: string) => {
    switch (type) {
      case 'IN_PERSON':
        return <Users className="h-4 w-4" />;
      case 'VIRTUAL':
        return <Eye className="h-4 w-4" />;
      case 'SELF_GUIDED':
        return <Activity className="h-4 w-4" />;
      default:
        return <Calendar className="h-4 w-4" />;
    }
  };
  const scheduledViewings = viewings.filter(v => v.status === 'SCHEDULED').length;
  const completedViewings = viewings.filter(v => v.status === 'COMPLETED').length;
  const avgRating = viewings.filter(v => v.feedback?.rating).reduce((acc, v, _, arr) => arr.length > 0 ? acc + (v.feedback?.rating || 0) / arr.length : 0, 0);
  const conversionRate = viewings.length > 0 ? viewings.filter(v => v.feedback?.interested).length / viewings.length * 100 : 0;
  if (loading) {
    return <PageShell title={t("admin.property.property_viewings")}>
        <div className="flex items-center justify-center h-64">
          <Activity className="h-8 w-8 animate-spin" />
        </div>
      </PageShell>;
  }
  return <PageShell title={t("admin.property.property_viewings")}>
      <div className="space-y-6">
        {/* Overview Cards */}
        <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin.property.scheduled_viewings")}</CardTitle>
              <Calendar className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{scheduledViewings}</div>
              <p className="text-xs text-muted-foreground">{t("admin.property.upcoming_appointments")}</p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin.property.completed_viewings")}</CardTitle>
              <CheckCircle className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-green-600">{completedViewings}</div>
              <p className="text-xs text-muted-foreground">{t("admin.property.total_completed_this_month")}</p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin.property.avg_rating")}</CardTitle>
              <Star className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{avgRating.toFixed(1)}/5</div>
              <p className="text-xs text-muted-foreground">{t("admin.property.customer_satisfaction")}</p>
            </CardContent>
          </Card>

          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin.property.conversion_rate")}</CardTitle>
              <TrendingUp className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{conversionRate.toFixed(1)}%</div>
              <p className="text-xs text-muted-foreground">{t("admin.property.interested_leads")}</p>
            </CardContent>
          </Card>
        </div>

        {/* Filters */}
        <Card>
          <CardContent className="pt-6">
            <div className="flex gap-4">
              <div className="flex items-center gap-2">
                <span className="text-sm font-medium">{t("admin.property.status")}</span>
                <Select value={statusFilter} onValueChange={setStatusFilter}>
                  <SelectTrigger className="w-[150px]">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
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
                <span className="text-sm font-medium">{t("admin.property.type")}</span>
                <Select value={typeFilter} onValueChange={setTypeFilter}>
                  <SelectTrigger className="w-[150px]">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
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

        {/* Viewings Table */}
        <Card>
          <CardHeader>
            <CardTitle>{t("admin.property.property_viewings")}</CardTitle>
            <p className="text-sm text-muted-foreground">{t("admin.property.manage_and_track_property")}</p>
          </CardHeader>
          <CardContent>
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>{t("admin.property.property")}</TableHead>
                  <TableHead>{t("admin.property.lead")}</TableHead>
                  <TableHead>{t("admin.property.type")}</TableHead>
                  <TableHead>{t("admin.property.status")}</TableHead>
                  <TableHead>{t("admin.property.scheduled")}</TableHead>
                  <TableHead>{t("admin.property.duration")}</TableHead>
                  <TableHead>{t("admin.property.rating")}</TableHead>
                  <TableHead>{t("admin.property.interested")}</TableHead>
                  <TableHead className="text-right">{t("admin.property.actions")}</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {viewings.map(viewing => <TableRow key={viewing.id}>
                    <TableCell className="font-medium">
                      <div>
                        <div>{viewing.property?.address || `Property ${viewing.propertyId}`}</div>
                        <div className="text-xs text-muted-foreground">
                          {viewing.property?.city}, {viewing.property?.state}
                        </div>
                      </div>
                    </TableCell>
                    <TableCell>
                      <div>
                        <div className="font-medium">{viewing.lead?.name || 'Unknown'}</div>
                        <div className="text-xs text-muted-foreground">{viewing.lead?.email}</div>
                      </div>
                    </TableCell>
                    <TableCell>
                      <div className="flex items-center gap-2">
                        {getTypeIcon(viewing.viewingType)}
                        <span className="capitalize">
                          {viewing.viewingType.replace('_', ' ').toLowerCase()}
                        </span>
                      </div>
                    </TableCell>
                    <TableCell>
                      <div className="flex items-center gap-2">
                        <div className={`w-2 h-2 rounded-full ${getStatusColor(viewing.status)}`} />
                        <span className="capitalize">{viewing.status.toLowerCase()}</span>
                      </div>
                    </TableCell>
                    <TableCell>
                      {new Date(viewing.scheduledAt).toLocaleString()}
                    </TableCell>
                    <TableCell>{viewing.duration}{t("admin.property.min")}</TableCell>
                    <TableCell>
                      {viewing.feedback?.rating ? <div className="flex items-center gap-1">
                          <Star className="h-3 w-3 fill-yellow-400 text-yellow-400" />
                          <span className="text-sm">{viewing.feedback.rating}/5</span>
                        </div> : <span className="text-muted-foreground">-</span>}
                    </TableCell>
                    <TableCell>
                      {viewing.feedback ? viewing.feedback.interested ? <CheckCircle className="h-4 w-4 text-green-500" /> : <XCircle className="h-4 w-4 text-red-500" /> : <span className="text-muted-foreground">-</span>}
                    </TableCell>
                    <TableCell className="text-right">
                      <DropdownMenu>
                        <DropdownMenuTrigger asChild>
                          <Button variant="ghost" className="h-8 w-8 p-0">
                            <MoreHorizontal className="h-4 w-4" />
                          </Button>
                        </DropdownMenuTrigger>
                        <DropdownMenuContent align="end">
                          <DropdownMenuLabel>{t("admin.property.actions")}</DropdownMenuLabel>
                          <DropdownMenuItem>
                            <Eye className="h-4 w-4 mr-2" />{t("admin.property.view_details")}</DropdownMenuItem>
                          {viewing.status === 'SCHEDULED' && <>
                              <DropdownMenuItem onClick={() => updateViewingStatus(viewing.id, 'CONFIRMED')}>
                                <CheckCircle className="h-4 w-4 mr-2" />{t("admin.property.confirm")}</DropdownMenuItem>
                              <DropdownMenuItem onClick={() => updateViewingStatus(viewing.id, 'CANCELLED')} className="text-red-600">
                                <XCircle className="h-4 w-4 mr-2" />{t("admin.property.cancel")}</DropdownMenuItem>
                            </>}
                          {viewing.status === 'CONFIRMED' && <DropdownMenuItem onClick={() => updateViewingStatus(viewing.id, 'COMPLETED')}>
                              <CheckCircle className="h-4 w-4 mr-2" />{t("admin.property.mark_complete")}</DropdownMenuItem>}
                        </DropdownMenuContent>
                      </DropdownMenu>
                    </TableCell>
                  </TableRow>)}
              </TableBody>
            </Table>
          </CardContent>
        </Card>

        {/* Viewing Insights */}
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          <Card>
            <CardHeader>
              <CardTitle>{t("admin.property.viewing_types_distribution")}</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                <div className="flex justify-between items-center">
                  <span className="text-sm flex items-center gap-2">
                    <Users className="h-4 w-4" />{t("admin.property.in_person")}</span>
                  <span className="font-medium">
                    {viewings.filter(v => v.viewingType === 'IN_PERSON').length}
                  </span>
                </div>
                <div className="flex justify-between items-center">
                  <span className="text-sm flex items-center gap-2">
                    <Eye className="h-4 w-4" />{t("admin.property.virtual")}</span>
                  <span className="font-medium">
                    {viewings.filter(v => v.viewingType === 'VIRTUAL').length}
                  </span>
                </div>
                <div className="flex justify-between items-center">
                  <span className="text-sm flex items-center gap-2">
                    <Activity className="h-4 w-4" />{t("admin.property.self_guided")}</span>
                  <span className="font-medium">
                    {viewings.filter(v => v.viewingType === 'SELF_GUIDED').length}
                  </span>
                </div>
              </div>
            </CardContent>
          </Card>

          <Card>
            <CardHeader>
              <CardTitle>{t("admin.property.status_overview")}</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                <div className="flex justify-between items-center">
                  <span className="text-sm">{t("admin.property.scheduled")}</span>
                  <span className="font-medium">{scheduledViewings}</span>
                </div>
                <div className="flex justify-between items-center">
                  <span className="text-sm">{t("admin.property.confirmed")}</span>
                  <span className="font-medium">
                    {viewings.filter(v => v.status === 'CONFIRMED').length}
                  </span>
                </div>
                <div className="flex justify-between items-center">
                  <span className="text-sm">{t("admin.property.completed")}</span>
                  <span className="font-medium text-green-600">{completedViewings}</span>
                </div>
                <div className="flex justify-between items-center">
                  <span className="text-sm">{t("admin.property.no_show")}</span>
                  <span className="font-medium text-red-600">
                    {viewings.filter(v => v.status === 'NO_SHOW').length}
                  </span>
                </div>
              </div>
            </CardContent>
          </Card>
        </div>
      </div>
    </PageShell>;
}