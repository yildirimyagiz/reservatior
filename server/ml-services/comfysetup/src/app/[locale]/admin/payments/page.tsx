import { requireAdmin } from "@/lib/admin";
import prisma from "@/lib/prisma";
import { CreditCard, DollarSign, TrendingUp, Users } from "lucide-react";
import Link from "next/link";

interface PageProps {
  params: Promise<{ locale: string }>;
  searchParams: Promise<{ status?: string; page?: string }>;
}

export default async function PaymentsPage({ params, searchParams }: PageProps) {
  await requireAdmin();
  const { locale } = await params;
  const { status = "all", page = "1" } = await searchParams;

  const pageSize = 20;
  const skip = (parseInt(page) - 1) * pageSize;

  const where = status !== "all" ? { status: status as any } : {};

  const [orders, totalCount, revenue, subscriptions] = await Promise.all([
    prisma.order.findMany({
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
        items: {
          include: {
            product: true,
          },
        },
      },
    }),
    prisma.order.count({ where }),
    prisma.order.aggregate({
      where: { status: { in: ["PAID", "FULFILLED"] } },
      _sum: { total: true },
      _count: true,
    }),
    prisma.subscription.count({
      where: { status: "active" },
    }),
  ]);

  const totalPages = Math.ceil(totalCount / pageSize);

  const statusColors = {
    PENDING: "bg-yellow-500/10 text-yellow-400",
    PAID: "bg-green-500/10 text-green-400",
    FULFILLED: "bg-blue-500/10 text-blue-400",
    CANCELLED: "bg-red-500/10 text-red-400",
    REFUNDED: "bg-orange-500/10 text-orange-400",
  };

  return (
    <div className="space-y-6">
      {/* Header */}
      <div>
        <h1 className="text-3xl font-bold text-white">Payment Management</h1>
        <p className="mt-2 text-slate-400">Monitor orders, payments, and subscriptions</p>
      </div>

      {/* Revenue Stats */}
      <div className="grid grid-cols-1 gap-4 sm:grid-cols-4">
        <div className="rounded-lg border border-slate-800 bg-slate-900/50 p-4">
          <div className="flex items-center gap-3">
            <div className="rounded-lg bg-green-500/10 p-2">
              <DollarSign className="h-5 w-5 text-green-400" />
            </div>
            <div>
              <p className="text-sm text-slate-400">Total Revenue</p>
              <p className="text-2xl font-bold text-white">
                ${Number(revenue._sum.total || 0).toLocaleString()}
              </p>
            </div>
          </div>
        </div>
        <div className="rounded-lg border border-slate-800 bg-slate-900/50 p-4">
          <div className="flex items-center gap-3">
            <div className="rounded-lg bg-blue-500/10 p-2">
              <CreditCard className="h-5 w-5 text-blue-400" />
            </div>
            <div>
              <p className="text-sm text-slate-400">Total Orders</p>
              <p className="text-2xl font-bold text-white">{revenue._count}</p>
            </div>
          </div>
        </div>
        <div className="rounded-lg border border-slate-800 bg-slate-900/50 p-4">
          <div className="flex items-center gap-3">
            <div className="rounded-lg bg-purple-500/10 p-2">
              <Users className="h-5 w-5 text-purple-400" />
            </div>
            <div>
              <p className="text-sm text-slate-400">Active Subscriptions</p>
              <p className="text-2xl font-bold text-white">{subscriptions}</p>
            </div>
          </div>
        </div>
        <div className="rounded-lg border border-slate-800 bg-slate-900/50 p-4">
          <div className="flex items-center gap-3">
            <div className="rounded-lg bg-orange-500/10 p-2">
              <TrendingUp className="h-5 w-5 text-orange-400" />
            </div>
            <div>
              <p className="text-sm text-slate-400">Avg Order Value</p>
              <p className="text-2xl font-bold text-white">
                ${revenue._count > 0 ? (Number(revenue._sum.total || 0) / revenue._count).toFixed(2) : "0.00"}
              </p>
            </div>
          </div>
        </div>
      </div>

      {/* Filters */}
      <div className="rounded-xl border border-slate-800 bg-slate-900/50 p-4">
        <div className="flex gap-4">
          <select
            defaultValue={status}
            className="rounded-lg border border-slate-700 bg-slate-800 px-4 py-2 text-white focus:border-blue-500 focus:outline-none"
          >
            <option value="all">All Status</option>
            <option value="PENDING">Pending</option>
            <option value="PAID">Paid</option>
            <option value="FULFILLED">Fulfilled</option>
            <option value="CANCELLED">Cancelled</option>
            <option value="REFUNDED">Refunded</option>
          </select>
        </div>
      </div>

      {/* Orders Table */}
      <div className="rounded-xl border border-slate-800 bg-slate-900/50 overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead className="border-b border-slate-800 bg-slate-800/50">
              <tr>
                <th className="px-6 py-4 text-left text-xs font-medium text-slate-400 uppercase">
                  Order ID
                </th>
                <th className="px-6 py-4 text-left text-xs font-medium text-slate-400 uppercase">
                  Customer
                </th>
                <th className="px-6 py-4 text-left text-xs font-medium text-slate-400 uppercase">
                  Items
                </th>
                <th className="px-6 py-4 text-left text-xs font-medium text-slate-400 uppercase">
                  Total
                </th>
                <th className="px-6 py-4 text-left text-xs font-medium text-slate-400 uppercase">
                  Status
                </th>
                <th className="px-6 py-4 text-left text-xs font-medium text-slate-400 uppercase">
                  Date
                </th>
                <th className="px-6 py-4 text-right text-xs font-medium text-slate-400 uppercase">
                  Actions
                </th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-800">
              {orders.map((order) => (
                <tr key={order.id} className="hover:bg-slate-800/50 transition">
                  <td className="px-6 py-4">
                    <span className="font-mono text-sm text-white">
                      {order.id.substring(0, 8)}...
                    </span>
                  </td>
                  <td className="px-6 py-4">
                    {order.user ? (
                      <Link
                        href={`/${locale}/admin/users/${order.user.id}`}
                        className="text-blue-400 hover:text-blue-300"
                      >
                        {order.user.name || order.user.email}
                      </Link>
                    ) : (
                      <span className="text-slate-500">Guest</span>
                    )}
                  </td>
                  <td className="px-6 py-4">
                    <span className="text-sm text-white">{order.items.length} items</span>
                  </td>
                  <td className="px-6 py-4">
                    <span className="text-lg font-bold text-white">
                      ${Number(order.total).toFixed(2)}
                    </span>
                  </td>
                  <td className="px-6 py-4">
                    <span
                      className={`inline-flex rounded-full px-2 py-1 text-xs font-semibold ${
                        statusColors[order.status]
                      }`}
                    >
                      {order.status}
                    </span>
                  </td>
                  <td className="px-6 py-4 text-sm text-slate-400">
                    {new Date(order.createdAt).toLocaleDateString()}
                  </td>
                  <td className="px-6 py-4 text-right">
                    <button className="text-blue-400 hover:text-blue-300 text-sm font-medium">
                      Details
                    </button>
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
            Showing {skip + 1} to {Math.min(skip + pageSize, totalCount)} of {totalCount} orders
          </p>
          <div className="flex gap-2">
            {Array.from({ length: Math.min(totalPages, 10) }, (_, i) => i + 1).map((p) => (
              <Link
                key={p}
                href={`/${locale}/admin/payments?page=${p}${status !== "all" ? `&status=${status}` : ""}`}
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
