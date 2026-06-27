import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Progress } from "@/components/ui/progress";
import { BarChart3, Users, Calendar, DollarSign, MapPin, TrendingUp, Settings, MoreHorizontal, Edit, Trash2, Maximize2 } from "lucide-react";
// import { DashboardWidget } from "@prisma/client";

interface DashboardWidget {
  id: string;
  type: string;
  widgetType: string;
  title: string;
  config: any;
  position: any;
  size: any;
  createdAt: string;
  updatedAt: string;
}
interface DashboardWidgetProps {
  widget: DashboardWidget;
  onEdit?: (widget: DashboardWidget) => void;
  onDelete?: (widget: DashboardWidget) => void;
  onResize?: (widget: DashboardWidget, size: {
    width: number;
    height: number;
  }) => void;
  isEditable?: boolean;
}
const WIDGET_ICONS = {
  STATS_CARD: BarChart3,
  CHART: TrendingUp,
  USER_LIST: Users,
  CALENDAR: Calendar,
  FINANCIAL_SUMMARY: DollarSign,
  MAP_WIDGET: MapPin,
  RECENT_ACTIVITY: Settings
};
const WIDGET_COMPONENTS = {
  STATS_CARD: StatsCardWidget,
  CHART: ChartWidget,
  USER_LIST: UserListWidget,
  CALENDAR: CalendarWidget,
  FINANCIAL_SUMMARY: FinancialSummaryWidget,
  MAP_WIDGET: MapWidget,
  RECENT_ACTIVITY: RecentActivityWidget
};
export default function DashboardWidgetComponent({
  widget,
  onEdit,
  onDelete,
  onResize,
  isEditable = false
}: DashboardWidgetProps) {
  const {
    t
  } = useTranslation();
  const [isExpanded, setIsExpanded] = useState(false);
  const Icon = WIDGET_ICONS[widget.widgetType as keyof typeof WIDGET_ICONS] || Settings;
  const WidgetContent = WIDGET_COMPONENTS[widget.widgetType as keyof typeof WIDGET_COMPONENTS] || DefaultWidget;
  const handleEdit = () => {
    onEdit?.(widget);
  };
  const handleDelete = () => {
    onDelete?.(widget);
  };
  const handleResize = () => {
    const newSize = {
      width: (widget.position as any)?.width || 4,
      height: isExpanded ? 2 : 4
    };
    onResize?.(widget, newSize);
    setIsExpanded(!isExpanded);
  };
  return <Card className="relative group hover:shadow-lg transition-shadow" style={{
    gridColumn: `span ${(widget.position as any)?.width || 4}`,
    gridRow: `span ${(widget.position as any)?.height || 2}`
  }}>
      <CardHeader className="pb-3">
        <div className="flex items-center justify-between">
          <div className="flex items-center gap-2">
            <Icon className="w-5 h-5 text-muted-foreground" />
            <CardTitle className="text-lg">{widget.title}</CardTitle>
          </div>
          <div className="flex items-center gap-1 opacity-0 group-hover:opacity-100 transition-opacity">
            {isEditable && <>
                <Button variant="ghost" size="sm" onClick={handleEdit}>
                  <Edit className="w-4 h-4" />
                </Button>
                <Button variant="ghost" size="sm" onClick={handleDelete}>
                  <Trash2 className="w-4 h-4" />
                </Button>
                <Button variant="ghost" size="sm" onClick={handleResize}>
                  <Maximize2 className="w-4 h-4" />
                </Button>
              </>}
            <Button variant="ghost" size="sm">
              <MoreHorizontal className="w-4 h-4" />
            </Button>
          </div>
        </div>
      </CardHeader>
      <CardContent>
        <WidgetContent config={widget.config} />
      </CardContent>
    </Card>;
}

// Widget Content Components
function StatsCardWidget({
  config
}: {
  config: any;
}) {
  const stats = config.stats || [{
    label: t("client.src.total_properties"),
    value: "24",
    change: "+2"
  }, {
    label: t("client.src.active_leases"),
    value: "18",
    change: "+3"
  }, {
    label: t("client.src.monthly_revenue"),
    value: "$48,250",
    change: "+12%"
  }];
  return <div className="space-y-4">
      {stats.map((stat: any, index: number) => <div key={index} className="flex items-center justify-between">
          <div>
            <p className="text-sm font-medium">{stat.label}</p>
            <p className="text-2xl font-bold">{stat.value}</p>
          </div>
          <Badge variant={stat.change.startsWith("+") ? "default" : "secondary"}>
            {stat.change}
          </Badge>
        </div>)}
    </div>;
}
function ChartWidget({
  config
}: {
  config: any;
}) {
  const {
    t
  } = useTranslation();
  const chartType = config.chartType || "line";
  const data = config.data || [];
  return <div className="h-48 flex items-center justify-center bg-muted rounded-lg">
      <div className="text-center text-muted-foreground">
        <TrendingUp className="w-8 h-8 mx-auto mb-2" />
        <p className="text-sm">{chartType}{t("client.src.chart")}</p>
        <p className="text-xs">{data.length}{t("client.src.data_points")}</p>
      </div>
    </div>;
}
function UserListWidget({
  config
}: {
  config: any;
}) {
  const users = config.users || [{
    name: "John Doe",
    role: "Agent",
    status: "active"
  }, {
    name: "Jane Smith",
    role: "Manager",
    status: "active"
  }, {
    name: "Bob Johnson",
    role: "Tenant",
    status: "inactive"
  }];
  return <div className="space-y-3">
      {users.slice(0, 5).map((user: any, index: number) => <div key={index} className="flex items-center justify-between">
          <div>
            <p className="text-sm font-medium">{user.name}</p>
            <p className="text-xs text-muted-foreground">{user.role}</p>
          </div>
          <Badge variant={user.status === "active" ? "default" : "secondary"}>
            {user.status}
          </Badge>
        </div>)}
    </div>;
}
function CalendarWidget({
  config
}: {
  config: any;
}) {
  const events = config.events || [{
    title: t("client.src.property_viewing"),
    time: "10:00 AM",
    date: "Today"
  }, {
    title: t("client.src.lease_signing"),
    time: "2:00 PM",
    date: "Today"
  }, {
    title: t("client.src.maintenance"),
    time: "9:00 AM",
    date: "Tomorrow"
  }];
  return <div className="space-y-3">
      {events.slice(0, 4).map((event: any, index: number) => <div key={index} className="flex items-center justify-between">
          <div>
            <p className="text-sm font-medium">{event.title}</p>
            <p className="text-xs text-muted-foreground">{event.time}</p>
          </div>
          <Badge variant="outline">{event.date}</Badge>
        </div>)}
    </div>;
}
function FinancialSummaryWidget({
  config
}: {
  config: any;
}) {
  const {
    t
  } = useTranslation();
  const summary = config.summary || {
    totalRevenue: 125000,
    totalExpenses: 45000,
    netProfit: 80000,
    profitMargin: 64
  };
  return <div className="space-y-4">
      <div className="grid grid-cols-2 gap-4">
        <div>
          <p className="text-sm text-muted-foreground">{t("client.src.revenue")}</p>
          <p className="text-lg font-bold text-green-600">
            ${summary.totalRevenue.toLocaleString()}
          </p>
        </div>
        <div>
          <p className="text-sm text-muted-foreground">{t("client.src.expenses")}</p>
          <p className="text-lg font-bold text-red-600">
            ${summary.totalExpenses.toLocaleString()}
          </p>
        </div>
      </div>
      <div>
        <div className="flex justify-between mb-1">
          <p className="text-sm text-muted-foreground">{t("client.src.profit_margin")}</p>
          <p className="text-sm font-medium">{summary.profitMargin}%</p>
        </div>
        <Progress value={summary.profitMargin} className="h-2" />
      </div>
      <div className="text-center">
        <p className="text-sm text-muted-foreground">{t("client.src.net_profit")}</p>
        <p className="text-2xl font-bold text-green-600">
          ${summary.netProfit.toLocaleString()}
        </p>
      </div>
    </div>;
}
function MapWidget({
  config
}: {
  config: any;
}) {
  const {
    t
  } = useTranslation();
  return <div className="h-48 bg-muted rounded-lg flex items-center justify-center">
      <div className="text-center text-muted-foreground">
        <MapPin className="w-8 h-8 mx-auto mb-2" />
        <p className="text-sm">{t("client.src.map_view")}</p>
        <p className="text-xs">
          {config.center?.lat || "40.7128"}, {config.center?.lng || "-74.0060"}
        </p>
      </div>
    </div>;
}
function RecentActivityWidget({
  config
}: {
  config: any;
}) {
  const activities = config.activities || [{
    title: t("client.src.new_lease_signed"),
    description: t("client.src.sunset_villa_smith_family"),
    time: "2h ago"
  }, {
    title: t("client.src.property_listed"),
    description: t("client.src.skyline_penthouse_850000"),
    time: "5h ago"
  }, {
    title: t("client.src.maintenance_scheduled"),
    description: t("client.src.nordic_apartment_hvac_service"),
    time: "1d ago"
  }];
  return <div className="space-y-3">
      {activities.slice(0, 4).map((activity: any, index: number) => <div key={index} className="flex items-start gap-3">
          <div className="w-2 h-2 rounded-full bg-blue-500 mt-2" />
          <div className="flex-1 min-w-0">
            <p className="text-sm font-medium">{activity.title}</p>
            <p className="text-xs text-muted-foreground truncate">
              {activity.description}
            </p>
            <p className="text-xs text-muted-foreground">{activity.time}</p>
          </div>
        </div>)}
    </div>;
}
function DefaultWidget({
  widget
}: {
  widget: DashboardWidget;
  config?: any;
}) {
  const {
    t
  } = useTranslation();
  return <div className="h-48 bg-muted rounded-lg flex items-center justify-center">
      <div className="text-center text-muted-foreground">
        <Settings className="w-8 h-8 mx-auto mb-2" />
        <p className="text-sm">{t("client.src.unknown_widget_type")}</p>
        <p className="text-xs">{widget.widgetType}</p>
      </div>
    </div>;
}