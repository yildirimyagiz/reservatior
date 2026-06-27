import { requireAdmin } from "@/lib/admin";
import prisma from "@/lib/prisma";
import { Video, Clock, CheckCircle, XCircle, Eye } from "lucide-react";
import Link from "next/link";

interface PageProps {
  params: Promise<{ locale: string }>;
  searchParams: Promise<{ status?: string; pipeline?: string; page?: string }>;
}

export default async function WalkthroughsPage({ params, searchParams }: PageProps) {
  await requireAdmin();
  const { locale } = await params;
  const { status = "all", pipeline = "all", page = "1" } = await searchParams;

  const pageSize = 20;
  const skip = (parseInt(page) - 1) * pageSize;

  const where = {
    AND: [
      status !== "all" ? { status: status as any } : {},
      pipeline !== "all" ? { pipeline: pipeline as any } : {},
    ],
  };

  const [walkthroughs, totalCount, statusStats] = await Promise.all([
    prisma.walkthrough.findMany({
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
        property: {
          select: {
            title: true,
            address: true,
          },
        },
      },
    }),
    prisma.walkthrough.count({ where }),
    prisma.walkthrough.groupBy({
      by: ["status"],
      _count: true,
    }),
  ]);

  const totalPages = Math.ceil(totalCount / pageSize);

  const statusIcons = {
    QUEUED: Clock,
    PROCESSING: Clock,
    COMPLETED: CheckCircle,
    FAILED: XCircle,
  };

  const statusColors = {
    QUEUED: "bg-yellow-500/10 text-yellow-400",
    PROCESSING: "bg-blue-500/10 text-blue-400",
    COMPLETED: "bg-green-500/10 text-green-400",
    FAILED: "bg-red-500/10 text-red-400",
  };

  return (
    <div className="space-y-6">
      {/* Header */}
      <div>
        <h1 className="text-3xl font-bold text-white">Walkthrough Monitoring</h1>
        <p className="mt-2 text-slate-400">Monitor all 3D walkthrough generation jobs</p>
      </div>

      {/* Stats */}
      <div className="grid grid-cols-1 gap-4 sm:grid-cols-5">
        <div className="rounded-lg border border-slate-800 bg-slate-900/50 p-4">
          <p className="text-sm text-slate-400">Total</p>
          <p className="mt-1 text-2xl font-bold text-white">{totalCount}</p>
        </div>
        {statusStats.map((stat) => {
          const Icon = statusIcons[stat.status as keyof typeof statusIcons];
          return (
            <div key={stat.status} className="rounded-lg border border-slate-800 bg-slate-900/50 p-4">
              <div className="flex items-center gap-2">
                <Icon className="h-4 w-4 text-slate-400" />
                <p className="text-sm text-slate-400">{stat.status}</p>
              </div>
              <p className="mt-1 text-2xl font-bold text-white">{stat._count}</p>
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
            <option value="QUEUED">Queued</option>
            <option value="PROCESSING">Processing</option>
            <option value="COMPLETED">Completed</option>
            <option value="FAILED">Failed</option>
          </select>
          <select
            defaultValue={pipeline}
            className="rounded-lg border border-slate-700 bg-slate-800 px-4 py-2 text-white focus:border-blue-500 focus:outline-none"
          >
            <option value="all">All Pipelines</option>
            <option value="PARALLAX_2_5D">Parallax 2.5D</option>
            <option value="INSTANT_NGP_SINGLE">Instant NGP Single</option>
            <option value="INSTANT_NGP_FULL">Instant NGP Full</option>
            <option value="GAUSSIAN_SPLATTING">Gaussian Splatting</option>
          </select>
        </div>
      </div>

      {/* Walkthroughs Table */}
      <div className="rounded-xl border border-slate-800 bg-slate-900/50 overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead className="border-b border-slate-800 bg-slate-800/50">
              <tr>
                <th className="px-6 py-4 text-left text-xs font-medium text-slate-400 uppercase">
                  User
                </th>
                <th className="px-6 py-4 text-left text-xs font-medium text-slate-400 uppercase">
                  Property
                </th>
                <th className="px-6 py-4 text-left text-xs font-medium text-slate-400 uppercase">
                  Pipeline
                </th>
                <th className="px-6 py-4 text-left text-xs font-medium text-slate-400 uppercase">
                  Photos
                </th>
                <th className="px-6 py-4 text-left text-xs font-medium text-slate-400 uppercase">
                  Status
                </th>
                <th className="px-6 py-4 text-left text-xs font-medium text-slate-400 uppercase">
                  Cost
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
              {walkthroughs.map((wt) => {
                const StatusIcon = statusIcons[wt.status];
                return (
                  <tr key={wt.id} className="hover:bg-slate-800/50 transition">
                    <td className="px-6 py-4">
                      <Link
                        href={`/${locale}/admin/users/${wt.user.id}`}
                        className="text-blue-400 hover:text-blue-300"
                      >
                        {wt.user.name || wt.user.email}
                      </Link>
                    </td>
                    <td className="px-6 py-4">
                      <div className="max-w-xs">
                        <p className="text-sm text-white truncate">
                          {wt.property?.title || "Untitled"}
                        </p>
                        {wt.property?.address && (
                          <p className="text-xs text-slate-500 truncate">
                            {wt.property.address}
                          </p>
                        )}
                      </div>
                    </td>
                    <td className="px-6 py-4">
                      <span className="inline-flex rounded-full bg-purple-500/10 px-2 py-1 text-xs font-semibold text-purple-400">
                        {wt.pipeline}
                      </span>
                    </td>
                    <td className="px-6 py-4">
                      <span className="text-sm text-white">{wt.photoCount} photos</span>
                    </td>
                    <td className="px-6 py-4">
                      <span
                        className={`inline-flex items-center gap-1 rounded-full px-2 py-1 text-xs font-semibold ${
                          statusColors[wt.status]
                        }`}
                      >
                        <StatusIcon className="h-3 w-3" />
                        {wt.status}
                      </span>
                    </td>
                    <td className="px-6 py-4">
                      <span className="font-medium text-white">
                        ${wt.cost ? Number(wt.cost).toFixed(2) : "0.00"}
                      </span>
                    </td>
                    <td className="px-6 py-4 text-sm text-slate-400">
                      {new Date(wt.createdAt).toLocaleDateString()}
                    </td>
                    <td className="px-6 py-4 text-right">
                      {wt.videoUrl ? (
                        <a
                          href={wt.videoUrl}
                          target="_blank"
                          rel="noopener noreferrer"
                          className="inline-flex items-center gap-1 text-blue-400 hover:text-blue-300 text-sm"
                        >
                          <Eye className="h-4 w-4" />
                          View
                        </a>
                      ) : (
                        <span className="text-slate-500 text-sm">Processing</span>
                      )}
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        </div>
      </div>

      {/* Pagination */}
      {totalPages > 1 && (
        <div className="flex items-center justify-between">
          <p className="text-sm text-slate-400">
            Showing {skip + 1} to {Math.min(skip + pageSize, totalCount)} of {totalCount}{" "}
            walkthroughs
          </p>
          <div className="flex gap-2">
            {Array.from({ length: Math.min(totalPages, 10) }, (_, i) => i + 1).map((p) => (
              <Link
                key={p}
                href={`/${locale}/admin/walkthroughs?page=${p}${
                  status !== "all" ? `&status=${status}` : ""
                }${pipeline !== "all" ? `&pipeline=${pipeline}` : ""}`}
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
