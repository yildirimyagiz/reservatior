import { requireAdmin } from "@/lib/admin";
import prisma from "@/lib/prisma";
import { FileText, Download, Eye } from "lucide-react";
import Link from "next/link";

interface PageProps {
  params: Promise<{ locale: string }>;
  searchParams: Promise<{ page?: string }>;
}

export default async function BrochuresPage({ params, searchParams }: PageProps) {
  await requireAdmin();
  const { locale } = await params;
  const { page = "1" } = await searchParams;

  const pageSize = 20;
  const skip = (parseInt(page) - 1) * pageSize;

  const [brochures, totalCount] = await Promise.all([
    prisma.brochure.findMany({
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
        _count: {
          select: {
            generations: true,
          },
        },
      },
    }),
    prisma.brochure.count(),
  ]);

  const totalPages = Math.ceil(totalCount / pageSize);

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-3xl font-bold text-white">Brochure Management</h1>
        <p className="mt-2 text-slate-400">View and manage all generated brochures</p>
      </div>

      <div className="rounded-lg border border-slate-800 bg-slate-900/50 p-4">
        <p className="text-sm text-slate-400">Total Brochures</p>
        <p className="mt-1 text-2xl font-bold text-white">{totalCount}</p>
      </div>

      <div className="rounded-xl border border-slate-800 bg-slate-900/50 overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead className="border-b border-slate-800 bg-slate-800/50">
              <tr>
                <th className="px-6 py-4 text-left text-xs font-medium text-slate-400 uppercase">Title</th>
                <th className="px-6 py-4 text-left text-xs font-medium text-slate-400 uppercase">User</th>
                <th className="px-6 py-4 text-left text-xs font-medium text-slate-400 uppercase">Property</th>
                <th className="px-6 py-4 text-left text-xs font-medium text-slate-400 uppercase">Images</th>
                <th className="px-6 py-4 text-left text-xs font-medium text-slate-400 uppercase">Created</th>
                <th className="px-6 py-4 text-right text-xs font-medium text-slate-400 uppercase">Actions</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-800">
              {brochures.map((brochure) => (
                <tr key={brochure.id} className="hover:bg-slate-800/50 transition">
                  <td className="px-6 py-4">
                    <div className="flex items-center gap-3">
                      <FileText className="h-5 w-5 text-orange-400" />
                      <span className="font-medium text-white">{brochure.title}</span>
                    </div>
                  </td>
                  <td className="px-6 py-4">
                    <Link href={`/${locale}/admin/users/${brochure.user.id}`} className="text-blue-400 hover:text-blue-300">
                      {brochure.user.name || brochure.user.email}
                    </Link>
                  </td>
                  <td className="px-6 py-4">
                    <div className="max-w-xs">
                      <p className="text-sm text-white truncate">{brochure.property?.title || "N/A"}</p>
                      {brochure.propertyAddress && (
                        <p className="text-xs text-slate-500 truncate">{brochure.propertyAddress}</p>
                      )}
                    </div>
                  </td>
                  <td className="px-6 py-4">
                    <span className="text-sm text-slate-400">{brochure._count.generations} images</span>
                  </td>
                  <td className="px-6 py-4 text-sm text-slate-400">
                    {new Date(brochure.createdAt).toLocaleDateString()}
                  </td>
                  <td className="px-6 py-4 text-right">
                    {brochure.pdfUrl && (
                      <a href={brochure.pdfUrl} target="_blank" rel="noopener noreferrer" className="inline-flex items-center gap-1 text-blue-400 hover:text-blue-300 text-sm">
                        <Download className="h-4 w-4" />
                        Download
                      </a>
                    )}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>

      {totalPages > 1 && (
        <div className="flex items-center justify-between">
          <p className="text-sm text-slate-400">
            Showing {skip + 1} to {Math.min(skip + pageSize, totalCount)} of {totalCount} brochures
          </p>
          <div className="flex gap-2">
            {Array.from({ length: Math.min(totalPages, 10) }, (_, i) => i + 1).map((p) => (
              <Link key={p} href={`/${locale}/admin/brochures?page=${p}`} className={`px-4 py-2 rounded-lg text-sm font-medium transition ${parseInt(page) === p ? "bg-blue-600 text-white" : "bg-slate-800 text-slate-400 hover:bg-slate-700"}`}>
                {p}
              </Link>
            ))}
          </div>
        </div>
      )}
    </div>
  );
}
