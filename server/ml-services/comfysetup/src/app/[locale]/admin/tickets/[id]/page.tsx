import { requireAdmin } from "@/lib/admin";
import prisma from "@/lib/prisma";
import { notFound } from "next/navigation";
import Link from "next/link";
import { ArrowLeft, User, Mail, Calendar, Tag } from "lucide-react";
import TicketResponder from "@/components/admin/ticket-responder";

interface PageProps {
  params: Promise<{ locale: string; id: string }>;
}

export default async function TicketDetailPage({ params }: PageProps) {
  await requireAdmin();
  const { locale, id } = await params;

  const ticket = await prisma.helpTicket.findUnique({
    where: { id },
    include: {
      user: {
        select: {
          id: true,
          email: true,
          name: true,
          credits: true,
        },
      },
    },
  });

  if (!ticket) {
    notFound();
  }

  const statusColors = {
    OPEN: "bg-blue-500/10 text-blue-400 border-blue-500/20",
    IN_PROGRESS: "bg-yellow-500/10 text-yellow-400 border-yellow-500/20",
    RESOLVED: "bg-green-500/10 text-green-400 border-green-500/20",
    CLOSED: "bg-slate-500/10 text-slate-400 border-slate-500/20",
  };

  const priorityColors = {
    LOW: "bg-slate-500/10 text-slate-400",
    MEDIUM: "bg-blue-500/10 text-blue-400",
    HIGH: "bg-orange-500/10 text-orange-400",
    URGENT: "bg-red-500/10 text-red-400",
  };

  return (
    <div className="space-y-6">
      {/* Back Button */}
      <Link
        href={`/${locale}/admin/tickets`}
        className="inline-flex items-center gap-2 text-slate-400 hover:text-white transition"
      >
        <ArrowLeft className="h-4 w-4" />
        Back to Tickets
      </Link>

      {/* Ticket Header */}
      <div className="rounded-xl border border-slate-800 bg-slate-900/50 p-6">
        <div className="flex items-start justify-between mb-4">
          <div>
            <h1 className="text-2xl font-bold text-white">{ticket.subject}</h1>
            <div className="mt-2 flex items-center gap-3">
              <span
                className={`inline-flex rounded-full border px-3 py-1 text-sm font-semibold ${
                  statusColors[ticket.status]
                }`}
              >
                {ticket.status}
              </span>
              <span
                className={`inline-flex rounded-full px-3 py-1 text-sm font-semibold ${
                  priorityColors[ticket.priority]
                }`}
              >
                {ticket.priority} Priority
              </span>
            </div>
          </div>
          <div className="text-right text-sm text-slate-400">
            <div className="flex items-center gap-2">
              <Calendar className="h-4 w-4" />
              {new Date(ticket.createdAt).toLocaleString()}
            </div>
          </div>
        </div>

        {/* User Info */}
        <div className="grid grid-cols-1 gap-4 md:grid-cols-3 pt-4 border-t border-slate-800">
          <div className="flex items-center gap-3">
            <User className="h-5 w-5 text-slate-400" />
            <div>
              <p className="text-sm text-slate-400">Customer</p>
              <Link
                href={`/${locale}/admin/users/${ticket.user.id}`}
                className="font-medium text-blue-400 hover:text-blue-300"
              >
                {ticket.user.name || "Anonymous"}
              </Link>
            </div>
          </div>
          <div className="flex items-center gap-3">
            <Mail className="h-5 w-5 text-slate-400" />
            <div>
              <p className="text-sm text-slate-400">Email</p>
              <p className="font-medium text-white">{ticket.user.email}</p>
            </div>
          </div>
          <div className="flex items-center gap-3">
            <Tag className="h-5 w-5 text-slate-400" />
            <div>
              <p className="text-sm text-slate-400">Category</p>
              <p className="font-medium text-white">{ticket.category || "General"}</p>
            </div>
          </div>
        </div>
      </div>

      <div className="grid grid-cols-1 gap-6 lg:grid-cols-3">
        {/* Customer Message */}
        <div className="lg:col-span-2 space-y-6">
          <div className="rounded-xl border border-slate-800 bg-slate-900/50 p-6">
            <h2 className="text-lg font-bold text-white mb-4">Customer Message</h2>
            <div className="prose prose-invert max-w-none">
              <p className="text-slate-300 whitespace-pre-wrap">{ticket.message}</p>
            </div>
          </div>

          {/* Admin Response */}
          {ticket.adminResponse && (
            <div className="rounded-xl border border-green-500/20 bg-green-500/5 p-6">
              <h2 className="text-lg font-bold text-white mb-4">Admin Response</h2>
              <div className="prose prose-invert max-w-none">
                <p className="text-slate-300 whitespace-pre-wrap">{ticket.adminResponse}</p>
              </div>
            </div>
          )}

          {/* Response Form */}
          <div className="rounded-xl border border-slate-800 bg-slate-900/50 p-6">
            <h2 className="text-lg font-bold text-white mb-4">
              {ticket.adminResponse ? "Update Response" : "Send Response"}
            </h2>
            <TicketResponder
              ticketId={ticket.id}
              currentStatus={ticket.status}
              currentResponse={ticket.adminResponse}
            />
          </div>
        </div>

        {/* Sidebar - User Info */}
        <div className="space-y-6">
          <div className="rounded-xl border border-slate-800 bg-slate-900/50 p-6">
            <h2 className="text-lg font-bold text-white mb-4">Customer Details</h2>
            <dl className="space-y-3">
              <div>
                <dt className="text-sm text-slate-400">Name</dt>
                <dd className="mt-1 text-sm font-medium text-white">
                  {ticket.user.name || "Not provided"}
                </dd>
              </div>
              <div>
                <dt className="text-sm text-slate-400">Email</dt>
                <dd className="mt-1 text-sm font-medium text-white">{ticket.user.email}</dd>
              </div>
              <div>
                <dt className="text-sm text-slate-400">Credits</dt>
                <dd className="mt-1 text-sm font-medium text-white">{ticket.user.credits}</dd>
              </div>
              <div className="pt-3">
                <Link
                  href={`/${locale}/admin/users/${ticket.user.id}`}
                  className="block w-full rounded-lg bg-blue-600 px-4 py-2 text-center text-sm text-white hover:bg-blue-700 transition"
                >
                  View Full Profile
                </Link>
              </div>
            </dl>
          </div>
        </div>
      </div>
    </div>
  );
}
