import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useEffect, useState } from "react";
import { PageShell } from "@/pages/client/layout/PageShell";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { HelpCircle, MessageSquare, CheckCircle, AlertTriangle, RefreshCw, Clock } from "lucide-react";
import { ticketsApi, type Ticket, TicketStatus } from "@/lib/api/tickets";
import { useToast } from "@/hooks/use-toast";
const STATUS_COLORS: Record<string, string> = {
  OPEN: "bg-blue-100 text-blue-700",
  IN_PROGRESS: "bg-yellow-100 text-yellow-700",
  RESOLVED: "bg-green-100 text-green-700",
  CLOSED: "bg-gray-100 text-gray-700"
};

const getLocalizedStatus = (status: string, t: any) => {
  const map: Record<string, string> = {
    OPEN: t("client.src.status_open", "Açık"),
    IN_PROGRESS: t("client.src.status_in_progress", "İşlemde"),
    RESOLVED: t("client.src.status_resolved", "Çözüldü"),
    CLOSED: t("client.src.status_closed", "Kapalı")
  };
  return map[status] || status.replace(/_/g, " ");
};

export default function SupportDashboard() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const [tickets, setTickets] = useState<Ticket[]>([]);
  const [loading, setLoading] = useState(true);
  const [search, setSearch] = useState("");
  const load = async () => {
    setLoading(true);
    try {
      const res: any = await ticketsApi.getTickets();
      setTickets(Array.isArray(res) ? res : res?.data ?? []);
    } catch {
      setTickets([]);
    } finally {
      setLoading(false);
    }
  };
  useEffect(() => {
    load();
  }, []);
  const handleClose = async (id: string) => {
    try {
      await ticketsApi.closeTicket(id);
      toast({
        title: t("client.src.ticket_closed")
      });
      load();
    } catch {
      toast({
        title: t("client.src.error"),
        description: t("client.src.failed_to_close_ticket"),
        variant: "destructive"
      });
    }
  };
  const filtered = tickets.filter(t => !search || t.subject?.toLowerCase().includes(search.toLowerCase()));
  const byStatus = (status: TicketStatus) => tickets.filter(t => t.status === status).length;
  return <PageShell title={t("client.src.support_dashboard")} description={t("client.src.overview_of_all_support")} searchValue={search} onSearchChange={setSearch} searchPlaceholder={t("client.src.search_tickets", "Biletlerde ara...")} stats={[{
    label: t("client.src.total_tickets"),
    value: tickets.length
  }, {
    label: t("client.src.open"),
    value: byStatus(TicketStatus.OPEN)
  }, {
    label: t("client.src.in_progress"),
    value: byStatus(TicketStatus.IN_PROGRESS)
  }, {
    label: t("client.src.resolved"),
    value: byStatus(TicketStatus.RESOLVED)
  }]} actions={<Button variant="outline" size="sm" onClick={load} disabled={loading}><RefreshCw className={`w-4 h-4 mr-1.5 ${loading ? "animate-spin" : ""}`} />{t("client.src.refresh")}</Button>}>
      {/* Status summary cards */}
      <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-4">
        {[{
        label: t("client.src.open"),
        status: TicketStatus.OPEN,
        icon: HelpCircle,
        color: "text-blue-500"
      }, {
        label: t("client.src.in_progress"),
        status: TicketStatus.IN_PROGRESS,
        icon: Clock,
        color: "text-yellow-500"
      }, {
        label: t("client.src.resolved"),
        status: TicketStatus.RESOLVED,
        icon: CheckCircle,
        color: "text-green-500"
      }, {
        label: t("client.src.closed"),
        status: TicketStatus.CLOSED,
        icon: MessageSquare,
        color: "text-gray-500"
      }].map(item => <div key={item.label} className="bg-card border border-border rounded-xl p-4 flex items-center gap-3">
            <item.icon className={`w-8 h-8 ${item.color}`} />
            <div>
              <p className="text-2xl font-bold">{byStatus(item.status)}</p>
              <p className="text-xs text-muted-foreground">{item.label}</p>
            </div>
          </div>)}
      </div>

      {loading ? <div className="space-y-2">{[...Array(4)].map((_, i) => <div key={i} className="h-16 bg-muted/30 rounded-xl animate-pulse" />)}</div> : filtered.length === 0 ? <div className="text-center py-16 text-muted-foreground">
          <HelpCircle className="w-12 h-12 mx-auto mb-4 opacity-30" />
          <p>{t("client.src.no_tickets_found")}</p>
        </div> : <div className="space-y-3">
          {filtered.map(ticket => <div key={ticket.id} className="bg-card border border-border rounded-xl p-5 flex items-center gap-4 hover:border-primary/30 transition-colors">
              <div className="w-10 h-10 rounded-lg bg-primary/10 flex items-center justify-center shrink-0">
                {ticket.status === TicketStatus.RESOLVED || ticket.status === TicketStatus.CLOSED ? <CheckCircle className="w-5 h-5 text-green-500" /> : <AlertTriangle className="w-5 h-5 text-primary" />}
              </div>
              <div className="flex-1 min-w-0">
                <div className="flex items-center gap-2 mb-0.5">
                  <span className="text-xs font-mono text-muted-foreground">{ticket.cuid || ticket.id}</span>
                  <Badge className={`${STATUS_COLORS[ticket.status]} border-0 text-[10px]`}>
                    {getLocalizedStatus(ticket.status, t)}
                  </Badge>
                </div>
                <p className="text-sm font-medium truncate">{ticket.subject}</p>
                {ticket.description && <p className="text-xs text-muted-foreground truncate mt-0.5">{ticket.description}</p>}
              </div>
              <span className="text-xs text-muted-foreground whitespace-nowrap flex items-center gap-1">
                <Clock className="w-3 h-3" />{new Date(ticket.createdAt).toLocaleDateString()}
              </span>
              {ticket.status !== TicketStatus.CLOSED && ticket.status !== TicketStatus.RESOLVED && <Button variant="outline" size="sm" onClick={() => handleClose(ticket.id)}>{t("client.src.close")}</Button>}
            </div>)}
        </div>}
    </PageShell>;
}