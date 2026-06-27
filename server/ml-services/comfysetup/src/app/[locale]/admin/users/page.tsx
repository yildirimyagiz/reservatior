import { requireAdmin } from "@/lib/admin";
import prisma from "@/lib/prisma";
import { Search, UserPlus, Filter, Download } from "lucide-react";
import Link from "next/link";

interface PageProps {
  params: Promise<{ locale: string }>;
  searchParams: Promise<{ search?: string; role?: string; page?: string }>;
}

export default async function UsersPage({ params, searchParams }: PageProps) {
  await requireAdmin();
  const { locale } = await params;
  const { search = "", role = "all", page = "1" } = await searchParams;

  const pageSize = 20;
  const skip = (parseInt(page) - 1) * pageSize;

  const where = {
    AND: [
      search
        ? {
            OR: [
              { email: { contains: search, mode: "insensitive" as const } },
              { name: { contains: search, mode: "insensitive" as const } },
            ],
          }
        : {},
      role !== "all" ? { role: role as any } : {},
    ],
  };

  const [users, totalCount] = await Promise.all([
    prisma.user.findMany({
      where,
      take: pageSize,
      skip,
      orderBy: { createdAt: "desc" },
      include: {
        _count: {
          select: {
            generations: true,
            walkthroughs: true,
            brochures: true,
          },
        },
        trial: {
          select: {
            status: true,
            usedCredits: true,
            totalCredits: true,
          },
        },
        subscription: {
          select: {
            status: true,
            currentPeriodEnd: true,
          },
        },
      },
    }),
    prisma.user.count({ where }),
  ]);

  const totalPages = Math.ceil(totalCount / pageSize);

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-white">User Management</h1>
          <p className="mt-2 text-slate-400">Manage all users, credits, and permissions</p>
        </div>
        <Link
          href={`/${locale}/admin/users/create`}
          className="flex items-center gap-2 rounded-lg bg-blue-600 px-4 py-2 text-white hover:bg-blue-700 transition"
        >
          <UserPlus className="h-4 w-4" />
          Create User
        </Link>
      </div>

      {/* Filters */}
      <div className="rounded-xl border border-slate-800 bg-slate-900/50 p-4">
        <div className="flex flex-wrap gap-4">
          <div className="flex-1 min-w-[300px]">
            <div className="relative">
              <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-5 w-5 text-slate-400" />
              <input
                type="text"
                placeholder="Search by email or name..."
                defaultValue={search}
                className="w-full rounded-lg border border-slate-700 bg-slate-800 pl-10 pr-4 py-2 text-white placeholder:text-slate-500 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
              />
            </div>
          </div>
          <select
            defaultValue={role}
            className="rounded-lg border border-slate-700 bg-slate-800 px-4 py-2 text-white focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
          >
            <option value="all">All Roles</option>
            <option value="USER">User</option>
            <option value="ADMIN">Admin</option>
          </select>
          <button className="flex items-center gap-2 rounded-lg border border-slate-700 bg-slate-800 px-4 py-2 text-white hover:bg-slate-700 transition">
            <Download className="h-4 w-4" />
            Export
          </button>
        </div>
      </div>

      {/* Stats */}
      <div className="grid grid-cols-1 gap-4 sm:grid-cols-4">
        <div className="rounded-lg border border-slate-800 bg-slate-900/50 p-4">
          <p className="text-sm text-slate-400">Total Users</p>
          <p className="mt-1 text-2xl font-bold text-white">{totalCount}</p>
        </div>
        <div className="rounded-lg border border-slate-800 bg-slate-900/50 p-4">
          <p className="text-sm text-slate-400">Active Trials</p>
          <p className="mt-1 text-2xl font-bold text-green-400">
            {users.filter((u) => u.trial?.status === "ACTIVE").length}
          </p>
        </div>
        <div className="rounded-lg border border-slate-800 bg-slate-900/50 p-4">
          <p className="text-sm text-slate-400">Paid Subscribers</p>
          <p className="mt-1 text-2xl font-bold text-blue-400">
            {users.filter((u) => u.subscription?.status === "active").length}
          </p>
        </div>
        <div className="rounded-lg border border-slate-800 bg-slate-900/50 p-4">
          <p className="text-sm text-slate-400">Admins</p>
          <p className="mt-1 text-2xl font-bold text-purple-400">
            {users.filter((u) => u.role === "ADMIN").length}
          </p>
        </div>
      </div>

      {/* Users Table */}
      <div className="rounded-xl border border-slate-800 bg-slate-900/50 overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead className="border-b border-slate-800 bg-slate-800/50">
              <tr>
                <th className="px-6 py-4 text-left text-xs font-medium text-slate-400 uppercase tracking-wider">
                  User
                </th>
                <th className="px-6 py-4 text-left text-xs font-medium text-slate-400 uppercase tracking-wider">
                  Role
                </th>
                <th className="px-6 py-4 text-left text-xs font-medium text-slate-400 uppercase tracking-wider">
                  Credits
                </th>
                <th className="px-6 py-4 text-left text-xs font-medium text-slate-400 uppercase tracking-wider">
                  Status
                </th>
                <th className="px-6 py-4 text-left text-xs font-medium text-slate-400 uppercase tracking-wider">
                  Activity
                </th>
                <th className="px-6 py-4 text-left text-xs font-medium text-slate-400 uppercase tracking-wider">
                  Joined
                </th>
                <th className="px-6 py-4 text-right text-xs font-medium text-slate-400 uppercase tracking-wider">
                  Actions
                </th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-800">
              {users.map((user) => (
                <tr key={user.id} className="hover:bg-slate-800/50 transition">
                  <td className="px-6 py-4">
                    <div>
                      <p className="font-medium text-white">{user.name || "Anonymous"}</p>
                      <p className="text-sm text-slate-400">{user.email}</p>
                    </div>
                  </td>
                  <td className="px-6 py-4">
                    <span
                      className={`inline-flex rounded-full px-2 py-1 text-xs font-semibold ${
                        user.role === "ADMIN"
                          ? "bg-purple-500/10 text-purple-400"
                          : "bg-blue-500/10 text-blue-400"
                      }`}
                    >
                      {user.role}
                    </span>
                  </td>
                  <td className="px-6 py-4">
                    <span className="font-medium text-white">{user.credits}</span>
                  </td>
                  <td className="px-6 py-4">
                    {user.subscription ? (
                      <span className="inline-flex items-center gap-1 text-sm">
                        <span className="h-2 w-2 rounded-full bg-green-500" />
                        <span className="text-green-400">Subscribed</span>
                      </span>
                    ) : user.trial?.status === "ACTIVE" ? (
                      <span className="inline-flex items-center gap-1 text-sm">
                        <span className="h-2 w-2 rounded-full bg-yellow-500" />
                        <span className="text-yellow-400">Trial</span>
                      </span>
                    ) : (
                      <span className="inline-flex items-center gap-1 text-sm">
                        <span className="h-2 w-2 rounded-full bg-slate-500" />
                        <span className="text-slate-400">Free</span>
                      </span>
                    )}
                  </td>
                  <td className="px-6 py-4">
                    <div className="text-sm text-slate-400">
                      {user._count.generations} gens / {user._count.walkthroughs} walks /{" "}
                      {user._count.brochures} brochures
                    </div>
                  </td>
                  <td className="px-6 py-4 text-sm text-slate-400">
                    {new Date(user.createdAt).toLocaleDateString()}
                  </td>
                  <td className="px-6 py-4 text-right">
                    <Link
                      href={`/${locale}/admin/users/${user.id}`}
                      className="text-blue-400 hover:text-blue-300 text-sm font-medium"
                    >
                      View Details
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
            Showing {skip + 1} to {Math.min(skip + pageSize, totalCount)} of {totalCount} users
          </p>
          <div className="flex gap-2">
            {Array.from({ length: totalPages }, (_, i) => i + 1).map((p) => (
              <Link
                key={p}
                href={`/${locale}/admin/users?page=${p}${search ? `&search=${search}` : ""}${
                  role !== "all" ? `&role=${role}` : ""
                }`}
                className={`px-4 py-2 rounded-lg text-sm font-medium transition ${
                  parseInt(page) === p
                    ? "bg-blue-600 text-white"
                    : "bg-slate-800 text-slate-400 hover:bg-slate-700 hover:text-white"
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
