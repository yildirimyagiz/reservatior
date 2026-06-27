import { requireAdmin } from "@/lib/admin";
import prisma from "@/lib/prisma";
import { MessageSquare, AlertCircle, CheckCircle2, Clock } from "lucide-react";
import Link from "next/link";

interface PageProps {
  params: Promise<{ locale: string }>;
  searchParams: Promise<{ status?: string; priority?: string; page?: string }>;
}

export default async function TicketsPage({ params, searchParams }: PageProps) {
  await requireAdmin();
  const { locale } = await params;
  const { status = "all", priority = "all", page = "1" } = await searchParams;

  const pageSize = 20;
  const skip = (parseInt(page) - 1) * pageSize;

  const where = {
    AND: [
      status !== "all" ? { status: status as any } : {},
      priority !== "all" ? { priority: priority as any } : {},
    ],
  };

  const [tickets, totalCount, stats] = await Promise.all([
    prisma.helpTicket.findMany({
      where,
      take: pageSize,
      skip,
      orderBy: { createdAt: "desc" },
      include: {
        user: {
          select: {
            id: true,
            name: true,
            email: true,
          },
        },
      },
    }),
    prisma.helpTicket.count({ where }),
    prisma.helpTicket.groupBy({
      by: ["status"],
      _count: true,
    }),
  ]);

  const totalPages = Math.ceil(totalCount / pageSize);

  const statusColors = {
    OPEN: "bg-blue-500/10 text-blue-400",
    IN_PROGRESS: "bg-yellow-500/10 text-yellow-400",
    RESOLVED: "bg-green-500/10 text-green-400",
    CLOSED: "bg-slate-500/10 text-slate-400",
  };

  const priorityColors = {
    LOW: "bg-slate-500/10 text-slate-400",
    MEDIUM: "bg-blue-500/10 text-blue-400",
    HIGH: "bg-orange-500/10 text-orange-400",
    URGENT: "bg-red-500/10 text-red-400",
  };

  return (
    <div className="space-y-6">
      {/* Header */}
      <div>
        <h1 className="text-3xl font-bold text-white">Support Tickets</h1>
        <p className="mt-2 text-slate-400">Manage customer support requests</p>
      </div>

      {/* Stats */}
      <div className="grid grid-cols-1 gap-4 sm:grid-cols-5">
        <div className="rounded-lg border border-slate-800 bg-slate-900/50 p-4">
          <div className="flex items-center gap-3">
            <MessageSquare className="h-5 w-5 text-slate-400" />
            <div>
              <p className="text-sm text-slate-400">Total</p>
              <p className="text-2xl font-bold text-white">{totalCount}</p>
            </div>
          </div>
        </div>
        {stats.map((stat) => {
          const icons = {
            OPEN: Clock,
            IN_PROGRESS: AlertCircle,
            RESOLVED: CheckCircle2,
            CLOSED: CheckCircle2,
          };
          const Icon = icons[stat.status as keyof typeof icons];
          return (
            <div key={stat.status} className="rounded-lg border border-slate-800 bg-slate-900/50 p-4">
              <div className="flex items-center gap-3">
                <Icon className="h-5 w-5 text-slate-400" />
                <div>
                  <p className="text-sm text-slate-400">{stat.status}</p>
                  <p className="text-2xl font-bold text-white">{stat._count}</p>
                </div>
              </div>
            </div>
          );
        })}
      </div>

      {/* Filters */}
      <div className="rounded-xl border border-slate-800 bg-slate-900/50 p-4">
        <div className="flex gap-4">
          <select
            defaultValue={status}
            className="rounded-lg border border-slate-700 bg-slate-800 px-4 py-2 text-white focus:border-blue-500 focus:outline-none"
          >
            <option value="all">All Status</option>
            <option value="OPEN">Open</option>
            <option value="IN_PROGRESS">In Progress</option>
            <option value="RESOLVED">Resolved</option>
            <option value="CLOSED">Closed</option>
          </select>
          <select
            defaultValue={priority}
            className="rounded-lg border border-slate-700 bg-slate-800 px-4 py-2 text-white focus:border-blue-500 focus:outline-none"
          >
            <option value="all">All Priorities</option>
            <option value="LOW">Low</option>
            <option value="MEDIUM">Medium</option>
            <option value="HIGH">High</option>
            <option value="URGENT">Urgent</option>
          </select>
        </div>
      </div>

      {/* Tickets Table */}
      <div className="rounded-xl border border-slate-800 bg-slate-900/50 overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead className="border-b border-slate-800 bg-slate-800/50">
              <tr>
                <th className="px-6 py-4 text-left text-xs font-medium text-slate-400 uppercase">
                  Ticket
                </th>
                <th className="px-6 py-4 text-left text-xs font-medium text-slate-400 uppercase">
                  User
                </th>
                <th className="px-6 py-4 text-left text-xs font-medium text-slate-400 uppercase">
                  Category
                </th>
                <th className="px-6 py-4 text-left text-xs font-medium text-slate-400 uppercase">
                  Priority
                </th>
                <th className="px-6 py-4 text-left text-xs font-medium text-slate-400 uppercase">
                  Status
                </th>
                <th className="px-6 py-4 text-left text-xs font-medium text-slate-400 uppercase">
                  Created
                </th>
                <th className="px-6 py-4 text-right text-xs font-medium text-slate-400 uppercase">
                  Actions
                </th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-800">
              {tickets.map((ticket) => (
                <tr key={ticket.id} className="hover:bg-slate-800/50 transition">
                  <td className="px-6 py-4">
                    <div className="max-w-md">
                      <p className="font-medium text-white">{ticket.subject}</p>
                      <p className="text-sm text-slate-400 truncate">{ticket.message}</p>
                    </div>
                  </td>
                  <td className="px-6 py-4">
                    <Link
                      href={`/${locale}/admin/users/${ticket.user.id}`}
                      className="text-blue-400 hover:text-blue-300"
                    >
                      {ticket.user.name || ticket.user.email}
                    </Link>
                  </td>
                  <td className="px-6 py-4">
                    <span className="text-sm text-slate-400">{ticket.category || "General"}</span>
                  </td>
                  <td className="px-6 py-4">
                    <span
                      className={`inline-flex rounded-full px-2 py-1 text-xs font-semibold ${
                        priorityColors[ticket.priority]
                      }`}
                    >
                      {ticket.priority}
                    </span>
                  </td>
                  <td className="px-6 py-4">
                    <span
                      className={`inline-flex rounded-full px-2 py-1 text-xs font-semibold ${
                        statusColors[ticket.status]
                      }`}
                    >
                      {ticket.status}
                    </span>
                  </td>
                  <td className="px-6 py-4 text-sm text-slate-400">
                    {new Date(ticket.createdAt).toLocaleDateString()}
                  </td>
                  <td className="px-6 py-4 text-right">
                    <Link
                      href={`/${locale}/admin/tickets/${ticket.id}`}
                      className="text-blue-400 hover:text-blue-300 text-sm font-medium"
                    >
                      View & Respond
                    </Link>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>

      {/* Pagination */}
      {totalPages > 1 && (
        <div className="flex items-center justify-between">
          <p className="text-sm text-slate-400">
            Showing {skip + 1} to {Math.min(skip + pageSize, totalCount)} of {totalCount} tickets
          </p>
          <div className="flex gap-2">
            {Array.from({ length: Math.min(totalPages, 10) }, (_, i) => i + 1).map((p) => (
              <Link
                key={p}
                href={`/${locale}/admin/tickets?page=${p}${status !== "all" ? `&status=${status}` : ""}${
                  priority !== "all" ? `&priority=${priority}` : ""
                }`}
                className={`px-4 py-2 rounded-lg text-sm font-medium transition ${
                  parseInt(page) === p
                    ? "bg-blue-600 text-white"
                    : "bg-slate-800 text-slate-400 hover:bg-slate-700"
                }`}
              >
                {p}
              </Link>
            ))}
          </div>
        </div>
      )}
    </div>
  );
}
