import { requireAdmin } from "@/lib/admin";
import prisma from "@/lib/prisma";
import { Users, CreditCard, Image as ImageIcon, Video, FileText, TrendingUp } from "lucide-react";
import Link from "next/link";

interface PageProps {
  params: Promise<{ locale: string }>;
}

async function getAdminStats() {
  const [
    totalUsers,
    totalGenerations,
    totalWalkthroughs,
    totalBrochures,
    activeTrials,
    totalRevenue,
    recentUsers,
    recentGenerations,
  ] = await Promise.all([
    prisma.user.count(),
    prisma.generation.count(),
    prisma.walkthrough.count(),
    prisma.brochure.count(),
    prisma.trialProfile.count({
      where: { status: "ACTIVE" },
    }),
    prisma.order.aggregate({
      where: { status: { in: ["PAID", "FULFILLED"] } },
      _sum: { total: true },
    }),
    prisma.user.findMany({
      take: 5,
      orderBy: { createdAt: "desc" },
      select: {
        id: true,
        name: true,
        email: true,
        role: true,
        credits: true,
        createdAt: true,
      },
    }),
    prisma.generation.findMany({
      take: 5,
      orderBy: { createdAt: "desc" },
      include: {
        user: {
          select: {
            name: true,
            email: true,
          },
        },
      },
    }),
  ]);

  return {
    totalUsers,
    totalGenerations,
    totalWalkthroughs,
    totalBrochures,
    activeTrials,
    totalRevenue: totalRevenue._sum.total || 0,
    recentUsers,
    recentGenerations,
  };
}

export default async function AdminDashboard({ params }: PageProps) {
  await requireAdmin();
  const stats = await getAdminStats();

  const statCards = [
    {
      title: "Total Users",
      value: stats.totalUsers.toLocaleString(),
      icon: Users,
      color: "blue",
      href: "/admin/users",
    },
    {
      title: "Generations",
      value: stats.totalGenerations.toLocaleString(),
      icon: ImageIcon,
      color: "purple",
      href: "/admin/generations",
    },
    {
      title: "Walkthroughs",
      value: stats.totalWalkthroughs.toLocaleString(),
      icon: Video,
      color: "green",
      href: "/admin/walkthroughs",
    },
    {
      title: "Brochures",
      value: stats.totalBrochures.toLocaleString(),
      icon: FileText,
      color: "orange",
      href: "/admin/brochures",
    },
    {
      title: "Active Trials",
      value: stats.activeTrials.toLocaleString(),
      icon: TrendingUp,
      color: "cyan",
      href: "/admin/users",
    },
    {
      title: "Total Revenue",
      value: `$${Number(stats.totalRevenue).toLocaleString()}`,
      icon: CreditCard,
      color: "emerald",
      href: "/admin/payments",
    },
  ];

  const colorClasses = {
    blue: "bg-blue-500/10 text-blue-400 border-blue-500/20",
    purple: "bg-purple-500/10 text-purple-400 border-purple-500/20",
    green: "bg-green-500/10 text-green-400 border-green-500/20",
    orange: "bg-orange-500/10 text-orange-400 border-orange-500/20",
    cyan: "bg-cyan-500/10 text-cyan-400 border-cyan-500/20",
    emerald: "bg-emerald-500/10 text-emerald-400 border-emerald-500/20",
  };

  return (
    <div className="space-y-8">
      {/* Page Header */}
      <div>
        <h1 className="text-3xl font-bold text-white">Admin Dashboard</h1>
        <p className="mt-2 text-slate-400">Overview of your application metrics and activity</p>
      </div>

      {/* Stats Grid */}
      <div className="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-3">
        {statCards.map((stat) => {
          const { locale } = { locale: "en" }; // Will be passed from params
          return (
            <Link
              key={stat.title}
              href={`/${locale}${stat.href}`}
              className="group relative overflow-hidden rounded-xl border border-slate-800 bg-slate-900/50 p-6 transition hover:border-slate-700 hover:bg-slate-900"
            >
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm font-medium text-slate-400">{stat.title}</p>
                  <p className="mt-2 text-3xl font-bold text-white">{stat.value}</p>
                </div>
                <div className={`rounded-lg border p-3 ${colorClasses[stat.color as keyof typeof colorClasses]}`}>
                  <stat.icon className="h-6 w-6" />
                </div>
              </div>
            </Link>
          );
        })}
      </div>

      <div className="grid grid-cols-1 gap-8 lg:grid-cols-2">
        {/* Recent Users */}
        <div className="rounded-xl border border-slate-800 bg-slate-900/50 p-6">
          <h2 className="text-xl font-bold text-white mb-4">Recent Users</h2>
          <div className="space-y-3">
            {stats.recentUsers.map((user) => (
              <div
                key={user.id}
                className="flex items-center justify-between rounded-lg border border-slate-800 bg-slate-800/50 p-4"
              >
                <div>
                  <p className="font-medium text-white">{user.name || "Anonymous"}</p>
                  <p className="text-sm text-slate-400">{user.email}</p>
                </div>
                <div className="text-right">
                  <p className="text-sm font-medium text-blue-400">{user.credits} credits</p>
                  <p className="text-xs text-slate-500">
                    {new Date(user.createdAt).toLocaleDateString()}
                  </p>
                </div>
              </div>
            ))}
          </div>
        </div>

        {/* Recent Generations */}
        <div className="rounded-xl border border-slate-800 bg-slate-900/50 p-6">
          <h2 className="text-xl font-bold text-white mb-4">Recent Generations</h2>
          <div className="space-y-3">
            {stats.recentGenerations.map((gen) => (
              <div
                key={gen.id}
                className="flex items-center justify-between rounded-lg border border-slate-800 bg-slate-800/50 p-4"
              >
                <div className="flex-1">
                  <p className="font-medium text-white">{gen.user.name || "Anonymous"}</p>
                  <p className="text-sm text-slate-400 truncate">{gen.prompt}</p>
                </div>
                <div className="text-right ml-4">
                  <p className="text-sm font-medium text-purple-400">{gen.type}</p>
                  <p className="text-xs text-slate-500">
                    {new Date(gen.createdAt).toLocaleDateString()}
                  </p>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
}
