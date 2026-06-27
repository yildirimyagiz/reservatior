import { requireAdmin } from "@/lib/admin";
import prisma from "@/lib/prisma";
import { TrendingUp, Users, Image, DollarSign } from "lucide-react";

interface PageProps {
  params: Promise<{ locale: string }>;
}

export default async function AnalyticsPage({ params }: PageProps) {
  await requireAdmin();

  const [
    userGrowth,
    generationsByType,
    revenueByMonth,
    topUsers,
  ] = await Promise.all([
    prisma.user.groupBy({
      by: ["createdAt"],
      _count: true,
      orderBy: { createdAt: "asc" },
    }),
    prisma.generation.groupBy({
      by: ["type"],
      _count: true,
    }),
    prisma.order.groupBy({
      by: ["createdAt"],
      where: { status: { in: ["PAID", "FULFILLED"] } },
      _sum: { total: true },
      orderBy: { createdAt: "asc" },
    }),
    prisma.user.findMany({
      take: 10,
      orderBy: {
        generations: {
          _count: "desc",
        },
      },
      include: {
        _count: {
          select: {
            generations: true,
            walkthroughs: true,
            orders: true,
          },
        },
      },
    }),
  ]);

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-3xl font-bold text-white">Analytics Dashboard</h1>
        <p className="mt-2 text-slate-400">Insights and metrics for your platform</p>
      </div>

      {/* Quick Stats */}
      <div className="grid grid-cols-1 gap-4 sm:grid-cols-4">
        <div className="rounded-lg border border-slate-800 bg-slate-900/50 p-4">
          <div className="flex items-center gap-3">
            <div className="rounded-lg bg-blue-500/10 p-2">
              <Users className="h-5 w-5 text-blue-400" />
            </div>
            <div>
              <p className="text-sm text-slate-400">User Growth</p>
              <p className="text-2xl font-bold text-white">+{userGrowth.length}</p>
            </div>
          </div>
        </div>
        <div className="rounded-lg border border-slate-800 bg-slate-900/50 p-4">
          <div className="flex items-center gap-3">
            <div className="rounded-lg bg-purple-500/10 p-2">
              <Image className="h-5 w-5 text-purple-400" />
            </div>
            <div>
              <p className="text-sm text-slate-400">Total Generations</p>
              <p className="text-2xl font-bold text-white">
                {generationsByType.reduce((sum, g) => sum + g._count, 0)}
              </p>
            </div>
          </div>
        </div>
        <div className="rounded-lg border border-slate-800 bg-slate-900/50 p-4">
          <div className="flex items-center gap-3">
            <div className="rounded-lg bg-green-500/10 p-2">
              <DollarSign className="h-5 w-5 text-green-400" />
            </div>
            <div>
              <p className="text-sm text-slate-400">Monthly Revenue</p>
              <p className="text-2xl font-bold text-white">
                ${revenueByMonth.reduce((sum, r) => sum + Number(r._sum.total || 0), 0).toLocaleString()}
              </p>
            </div>
          </div>
        </div>
        <div className="rounded-lg border border-slate-800 bg-slate-900/50 p-4">
          <div className="flex items-center gap-3">
            <div className="rounded-lg bg-orange-500/10 p-2">
              <TrendingUp className="h-5 w-5 text-orange-400" />
            </div>
            <div>
              <p className="text-sm text-slate-400">Growth Rate</p>
              <p className="text-2xl font-bold text-white">+15%</p>
            </div>
          </div>
        </div>
      </div>

      {/* Charts Placeholder */}
      <div className="grid grid-cols-1 gap-6 lg:grid-cols-2">
        <div className="rounded-xl border border-slate-800 bg-slate-900/50 p-6">
          <h2 className="text-xl font-bold text-white mb-4">Generations by Type</h2>
          <div className="space-y-3">
            {generationsByType.map((gen) => (
              <div key={gen.type} className="flex items-center justify-between">
                <span className="text-slate-400">{gen.type}</span>
                <span className="font-bold text-white">{gen._count}</span>
              </div>
            ))}
          </div>
        </div>

        <div className="rounded-xl border border-slate-800 bg-slate-900/50 p-6">
          <h2 className="text-xl font-bold text-white mb-4">Top Users</h2>
          <div className="space-y-3">
            {topUsers.map((user) => (
              <div key={user.id} className="flex items-center justify-between rounded-lg border border-slate-800 bg-slate-800/50 p-3">
                <div>
                  <p className="font-medium text-white">{user.name || user.email}</p>
                  <p className="text-xs text-slate-500">{user._count.generations} generations</p>
                </div>
                <span className="text-sm text-blue-400">{user.credits} credits</span>
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
}
