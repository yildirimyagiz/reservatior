import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { useToast } from "@/hooks/use-toast";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Helmet } from "react-helmet-async";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { BarChart, Bar, Cell, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer, AreaChart, Area, PieChart, Pie } from "recharts";
import { TrendingUp, DollarSign, Users, Home, Download, Target, Zap } from "lucide-react";
import { propertiesApi } from "@/lib/api/properties";
import { contactsApi } from "@/lib/api/contacts";
import { dealsApi } from "@/lib/api/deals";
import { leadsApi } from "@/lib/api/leads";
import { tasksApi } from "@/lib/api/tasks";
export default function Analytics() {
  const {
    t
  } = useTranslation();
  const [loading, setLoading] = useState(true);
  const [timeRange, setTimeRange] = useState("30days");
  const [data, setData] = useState<{
    properties: any[];
    contacts: any[];
    leads: any[];
    tasks: any[];
    deals: any[];
  }>({
    properties: [],
    contacts: [],
    leads: [],
    tasks: [],
    deals: []
  });
  const [metrics, setMetrics] = useState({
    totalProperties: 0,
    totalContacts: 0,
    totalLeads: 0,
    totalTasks: 0,
    totalDeals: 0,
    totalValue: 0,
    conversionRate: 0,
    avgDealSize: 0
  });
  const {
    toast
  } = useToast();
  useEffect(() => {
    loadAnalyticsData();
  }, [timeRange]);
  const loadAnalyticsData = async () => {
    try {
      setLoading(true);
      const [propertiesRes, contactsRes, leadsRes, tasksRes, dealsRes] = await Promise.all([propertiesApi.getAll().catch(() => ({
        data: []
      })) as Promise<{
        data: any[];
      }>, contactsApi.getAll().catch(() => ({
        data: []
      })) as Promise<{
        data: any[];
      }>, leadsApi.getAll().catch(() => ({
        data: []
      })) as Promise<{
        data: any[];
      }>, tasksApi.getAll().catch(() => ({
        data: []
      })) as Promise<{
        data: any[];
      }>, dealsApi.getAll().catch(() => ({
        data: []
      })) as Promise<{
        data: any[];
      }>]);
      const properties = propertiesRes.data || [];
      const contacts = contactsRes.data || [];
      const leads = leadsRes.data || [];
      const tasks = tasksRes.data || [];
      const deals = dealsRes.data || [];
      setData({
        properties,
        contacts,
        leads,
        tasks,
        deals
      });
      const totalValue = deals.reduce((sum: number, deal: any) => sum + (deal.salePrice || deal.listingPrice || 0), 0);
      const closedDeals = deals.filter((d: any) => d.status === "CLOSED");
      const conversionRate = leads.length > 0 ? closedDeals.length / leads.length * 100 : 0;
      const avgDealSize = closedDeals.length > 0 ? totalValue / closedDeals.length : 0;
      setMetrics({
        totalProperties: properties.length,
        totalContacts: contacts.length,
        totalLeads: leads.length,
        totalTasks: tasks.length,
        totalDeals: deals.length,
        totalValue,
        conversionRate,
        avgDealSize
      });
    } catch (error) {
      toast({
        title: t("admin.analytics.error"),
        description: t("admin.analytics.failed_to_load_analytics"),
        variant: "destructive"
      });
    } finally {
      setLoading(false);
    }
  };
  const getRevenueData = () => {
    const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"];
    return months.map(month => ({
      month,
      revenue: Math.floor(Math.random() * 50000) + 30000,
      deals: Math.floor(Math.random() * 20) + 10
    }));
  };
  const getLeadSourceData = () => {
    return [{
      name: "Website",
      value: 35,
      color: "#3b82f6"
    }, {
      name: "Referral",
      value: 25,
      color: "#10b981"
    }, {
      name: "Social Media",
      value: 20,
      color: "#f59e0b"
    }, {
      name: "Email",
      value: 15,
      color: "#ef4444"
    }, {
      name: "Other",
      value: 5,
      color: "#8b5cf6"
    }];
  };
  const getPropertyTypeData = () => {
    const types = ["House", "Apartment", "Condo", "Commercial", "Land"];
    return types.map(type => ({
      type,
      count: Math.floor(Math.random() * 50) + 10
    }));
  };
  const getTaskStatusData = () => {
    return [{
      status: "Completed",
      count: data.tasks.filter((t: any) => t.status === "COMPLETED").length
    }, {
      status: "In Progress",
      count: data.tasks.filter((t: any) => t.status === "IN_PROGRESS").length
    }, {
      status: "Pending",
      count: data.tasks.filter((t: any) => t.status === "PENDING").length
    }, {
      status: "Overdue",
      count: data.tasks.filter((t: any) => t.status === "OVERDUE").length
    }];
  };
  if (loading) {
    return <div className="p-6 flex items-center justify-center min-h-[400px]">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary"></div>
      </div>;
  }
  return <div className="p-6">
      <Helmet>
        <title>{t("admin.analytics.analytics_and_reports_reservatior")}</title>
        <meta name="description" content="Detailed analytics and performance reports." />
      </Helmet>

      <div className="container mx-auto space-y-8">
        <div className="flex flex-col lg:flex-row justify-between items-start lg:items-center gap-4">
          <div>
            <h1 className="text-3xl font-bold">{t("admin.analytics.analytics_dashboard")}</h1>
            <p className="text-muted-foreground mt-1">{t("admin.analytics.monitor_your_business_metrics")}</p>
          </div>
          <div className="flex items-center gap-4">
            <Select value={timeRange} onValueChange={setTimeRange}>
              <SelectTrigger className="w-48">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="7days">{t("admin.analytics.last_7_days")}</SelectItem>
                <SelectItem value="30days">{t("admin.analytics.last_30_days")}</SelectItem>
                <SelectItem value="90days">{t("admin.analytics.last_90_days")}</SelectItem>
                <SelectItem value="1year">{t("admin.analytics.last_year")}</SelectItem>
              </SelectContent>
            </Select>
            <Button variant="outline">
              <Download className="w-4 h-4 mr-2" />{t("admin.analytics.export")}</Button>
          </div>
        </div>

        {/* KPI Cards */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
          <Card>
            <CardContent className="p-6">
              <div className="flex items-center">
                <div className="p-2 bg-blue-100 dark:bg-blue-900/20 rounded-lg">
                  <Home className="w-6 h-6 text-blue-600" />
                </div>
                <div className="ml-4">
                  <p className="text-sm font-medium text-muted-foreground">{t("admin.analytics.total_properties")}</p>
                  <p className="text-2xl font-bold text-foreground">
                    {metrics.totalProperties}
                  </p>
                </div>
              </div>
            </CardContent>
          </Card>

          <Card>
            <CardContent className="p-6">
              <div className="flex items-center">
                <div className="p-2 bg-green-100 dark:bg-green-900/20 rounded-lg">
                  <Users className="w-6 h-6 text-green-600" />
                </div>
                <div className="ml-4">
                  <p className="text-sm font-medium text-muted-foreground">{t("admin.analytics.total_contacts")}</p>
                  <p className="text-2xl font-bold text-foreground">
                    {metrics.totalContacts}
                  </p>
                </div>
              </div>
            </CardContent>
          </Card>

          <Card>
            <CardContent className="p-6">
              <div className="flex items-center">
                <div className="p-2 bg-purple-100 dark:bg-purple-900/20 rounded-lg">
                  <Target className="w-6 h-6 text-purple-600" />
                </div>
                <div className="ml-4">
                  <p className="text-sm font-medium text-muted-foreground">{t("admin.analytics.total_deals")}</p>
                  <p className="text-2xl font-bold text-foreground">
                    {metrics.totalDeals}
                  </p>
                </div>
              </div>
            </CardContent>
          </Card>

          <Card>
            <CardContent className="p-6">
              <div className="flex items-center">
                <div className="p-2 bg-orange-100 dark:bg-orange-900/20 rounded-lg">
                  <DollarSign className="w-6 h-6 text-orange-600" />
                </div>
                <div className="ml-4">
                  <p className="text-sm font-medium text-muted-foreground">{t("admin.analytics.total_value")}</p>
                  <p className="text-2xl font-bold text-foreground">
                    ${metrics.totalValue.toLocaleString()}
                  </p>
                </div>
              </div>
            </CardContent>
          </Card>
        </div>

        {/* Charts Grid */}
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          <Card>
            <CardHeader>
              <CardTitle className="flex items-center">
                <TrendingUp className="w-5 h-5 mr-2" />{t("admin.analytics.revenue_deals_trend")}</CardTitle>
            </CardHeader>
            <CardContent>
              <ResponsiveContainer width="100%" height={300} minWidth={0}>
                <AreaChart data={getRevenueData()}>
                  <CartesianGrid strokeDasharray="3 3" />
                  <XAxis dataKey="month" />
                  <YAxis />
                  <Tooltip />
                  <Legend />
                  <Area type="monotone" dataKey="revenue" stroke="#3b82f6" fill="#3b82f6" fillOpacity={0.6} />
                  <Area type="monotone" dataKey="deals" stroke="#10b981" fill="#10b981" fillOpacity={0.6} />
                </AreaChart>
              </ResponsiveContainer>
            </CardContent>
          </Card>

          <Card>
            <CardHeader>
              <CardTitle className="flex items-center">
                <Zap className="w-5 h-5 mr-2" />{t("admin.analytics.lead_sources")}</CardTitle>
            </CardHeader>
            <CardContent>
              <ResponsiveContainer width="100%" height={300} minWidth={0}>
                <PieChart>
                  <Pie data={getLeadSourceData()} cx="50%" cy="50%" labelLine={false} label={({
                  name,
                  percent
                }) => `${name} ${((percent || 0) * 100).toFixed(0)}%`} outerRadius={80} fill="#8884d8" dataKey="value">
                    {getLeadSourceData().map(entry => <Cell key={`cell-${entry.name}`} fill={entry.color} />)}
                  </Pie>
                  <Tooltip />
                </PieChart>
              </ResponsiveContainer>
            </CardContent>
          </Card>
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          <Card>
            <CardHeader>
              <CardTitle>{t("admin.analytics.properties_by_type")}</CardTitle>
            </CardHeader>
            <CardContent>
              <ResponsiveContainer width="100%" height={250} minWidth={0}>
                <BarChart data={getPropertyTypeData()}>
                  <CartesianGrid strokeDasharray="3 3" />
                  <XAxis dataKey="type" />
                  <YAxis />
                  <Tooltip />
                  <Bar dataKey="count" fill="#3b82f6" />
                </BarChart>
              </ResponsiveContainer>
            </CardContent>
          </Card>

          <Card>
            <CardHeader>
              <CardTitle>{t("admin.analytics.task_status_overview")}</CardTitle>
            </CardHeader>
            <CardContent>
              <ResponsiveContainer width="100%" height={250} minWidth={0}>
                <BarChart data={getTaskStatusData()}>
                  <CartesianGrid strokeDasharray="3 3" />
                  <XAxis dataKey="status" />
                  <YAxis />
                  <Tooltip />
                  <Bar dataKey="count" fill="#10b981" />
                </BarChart>
              </ResponsiveContainer>
            </CardContent>
          </Card>
        </div>

        <Card>
          <CardHeader>
            <CardTitle>{t("admin.analytics.performance_metrics")}</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
              <div className="text-center">
                <div className="text-3xl font-bold text-blue-600">
                  {metrics.conversionRate.toFixed(1)}%
                </div>
                <p className="text-sm text-muted-foreground mt-1">{t("admin.analytics.lead_to_deal_conversion")}</p>
              </div>
              <div className="text-center">
                <div className="text-3xl font-bold text-green-600">
                  ${metrics.avgDealSize.toLocaleString()}
                </div>
                <p className="text-sm text-muted-foreground mt-1">{t("admin.analytics.average_deal_size")}</p>
              </div>
              <div className="text-center">
                <div className="text-3xl font-bold text-purple-600">
                  {data.tasks.filter((t: any) => t.status === "COMPLETED").length}
                </div>
                <p className="text-sm text-muted-foreground mt-1">{t("admin.analytics.completed_tasks")}</p>
              </div>
            </div>
          </CardContent>
        </Card>
      </div>
    </div>;
}