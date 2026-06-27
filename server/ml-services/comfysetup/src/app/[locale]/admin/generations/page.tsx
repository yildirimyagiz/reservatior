import { requireAdmin } from "@/lib/admin";
import prisma from "@/lib/prisma";
import { Image as ImageIcon, Video, Eye } from "lucide-react";
import Link from "next/link";

interface PageProps {
  params: Promise<{ locale: string }>;
  searchParams: Promise<{ type?: string; page?: string }>;
}

export default async function GenerationsPage({ params, searchParams }: PageProps) {
  await requireAdmin();
  const { locale } = await params;
  const { type = "all", page = "1" } = await searchParams;

  const pageSize = 20;
  const skip = (parseInt(page) - 1) * pageSize;

  const where = type !== "all" ? { type: type as any } : {};

  const [generations, totalCount, stats] = await Promise.all([
    prisma.generation.findMany({
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
    prisma.generation.count({ where }),
    prisma.generation.groupBy({
      by: ["type"],
      _count: true,
    }),
  ]);

  const totalPages = Math.ceil(totalCount / pageSize);

  return (
    <div className="space-y-6">
      {/* Header */}
      <div>
        <h1 className="text-3xl font-bold text-white">Generation Monitoring</h1>
        <p className="mt-2 text-slate-400">Monitor all AI generations and their status</p>
      </div>

      {/* Stats */}
      <div className="grid grid-cols-1 gap-4 sm:grid-cols-4">
        <div className="rounded-lg border border-slate-800 bg-slate-900/50 p-4">
          <p className="text-sm text-slate-400">Total Generations</p>
          <p className="mt-1 text-2xl font-bold text-white">{totalCount}</p>
        </div>
        {stats.map((stat) => (
          <div key={stat.type} className="rounded-lg border border-slate-800 bg-slate-900/50 p-4">
            <p className="text-sm text-slate-400">{stat.type}</p>
            <p className="mt-1 text-2xl font-bold text-white">{stat._count}</p>
          </div>
        ))}
      </div>

      {/* Filters */}
      <div className="rounded-xl border border-slate-800 bg-slate-900/50 p-4">
        <div className="flex gap-4">
          <select
            defaultValue={type}
            className="rounded-lg border border-slate-700 bg-slate-800 px-4 py-2 text-white focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
          >
            <option value="all">All Types</option>
            <option value="IMAGE">Image</option>
            <option value="VIDEO">Video</option>
            <option value="PANORAMA_360">Panorama 360</option>
          </select>
        </div>
      </div>

      {/* Generations Table */}
      <div className="rounded-xl border border-slate-800 bg-slate-900/50 overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead className="border-b border-slate-800 bg-slate-800/50">
              <tr>
                <th className="px-6 py-4 text-left text-xs font-medium text-slate-400 uppercase">
                  Preview
                </th>
                <th className="px-6 py-4 text-left text-xs font-medium text-slate-400 uppercase">
                  User
                </th>
                <th className="px-6 py-4 text-left text-xs font-medium text-slate-400 uppercase">
                  Type
                </th>
                <th className="px-6 py-4 text-left text-xs font-medium text-slate-400 uppercase">
                  Prompt
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
              {generations.map((gen) => (
                <tr key={gen.id} className="hover:bg-slate-800/50 transition">
                  <td className="px-6 py-4">
                    {gen.imageUrl ? (
                      <img
                        src={gen.imageUrl}
                        alt="Generation"
                        className="h-12 w-12 rounded object-cover"
                      />
                    ) : gen.videoUrl ? (
                      <div className="flex h-12 w-12 items-center justify-center rounded bg-purple-500/10">
                        <Video className="h-6 w-6 text-purple-400" />
                      </div>
                    ) : (
                      <div className="flex h-12 w-12 items-center justify-center rounded bg-slate-700">
                        <ImageIcon className="h-6 w-6 text-slate-400" />
                      </div>
                    )}
                  </td>
                  <td className="px-6 py-4">
                    <Link
                      href={`/${locale}/admin/users/${gen.user.id}`}
                      className="text-blue-400 hover:text-blue-300"
                    >
                      {gen.user.name || gen.user.email}
                    </Link>
                  </td>
                  <td className="px-6 py-4">
                    <span className="inline-flex rounded-full bg-blue-500/10 px-2 py-1 text-xs font-semibold text-blue-400">
                      {gen.type}
                    </span>
                  </td>
                  <td className="px-6 py-4 max-w-md">
                    <p className="truncate text-sm text-white">{gen.prompt}</p>
                    {gen.roomType && (
                      <p className="text-xs text-slate-500">Room: {gen.roomType}</p>
                    )}
                  </td>
                  <td className="px-6 py-4">
                    <span className="font-medium text-white">{gen.cost} credits</span>
                  </td>
                  <td className="px-6 py-4 text-sm text-slate-400">
                    {new Date(gen.createdAt).toLocaleDateString()}
                  </td>
                  <td className="px-6 py-4 text-right">
                    {gen.imageUrl || gen.videoUrl ? (
                      <a
                        href={gen.imageUrl || gen.videoUrl || "#"}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="inline-flex items-center gap-1 text-blue-400 hover:text-blue-300 text-sm"
                      >
                        <Eye className="h-4 w-4" />
                        View
                      </a>
                    ) : (
                      <span className="text-slate-500 text-sm">No output</span>
                    )}
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
            Showing {skip + 1} to {Math.min(skip + pageSize, totalCount)} of {totalCount}{" "}
            generations
          </p>
          <div className="flex gap-2">
            {Array.from({ length: Math.min(totalPages, 10) }, (_, i) => i + 1).map((p) => (
              <Link
                key={p}
                href={`/${locale}/admin/generations?page=${p}${type !== "all" ? `&type=${type}` : ""}`}
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
