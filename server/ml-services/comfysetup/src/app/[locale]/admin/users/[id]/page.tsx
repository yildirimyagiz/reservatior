import { requireAdmin } from "@/lib/admin";
import prisma from "@/lib/prisma";
import { notFound } from "next/navigation";
import Link from "next/link";
import { ArrowLeft, Shield, CreditCard, Activity, FileText } from "lucide-react";
import CreditAdjuster from "@/components/admin/credit-adjuster";

interface PageProps {
  params: Promise<{ locale: string; id: string }>;
}

export default async function UserDetailPage({ params }: PageProps) {
  await requireAdmin();
  const { locale, id } = await params;

  const user = await prisma.user.findUnique({
    where: { id },
    include: {
      trial: true,
      subscription: true,
      _count: {
        select: {
          generations: true,
          walkthroughs: true,
          brochures: true,
          orders: true,
          notifications: true,
        },
      },
      generations: {
        take: 10,
        orderBy: { createdAt: "desc" },
      },
      walkthroughs: {
        take: 5,
        orderBy: { createdAt: "desc" },
      },
      orders: {
        take: 5,
        orderBy: { createdAt: "desc" },
      },
    },
  });

  if (!user) {
    notFound();
  }

  return (
    <div className="space-y-6">
      {/* Back Button */}
      <Link
        href={`/${locale}/admin/users`}
        className="inline-flex items-center gap-2 text-slate-400 hover:text-white transition"
      >
        <ArrowLeft className="h-4 w-4" />
        Back to Users
      </Link>

      {/* User Header */}
      <div className="rounded-xl border border-slate-800 bg-slate-900/50 p-6">
        <div className="flex items-start justify-between">
          <div className="flex items-center gap-4">
            <div className="flex h-16 w-16 items-center justify-center rounded-full bg-blue-500/10 text-2xl font-bold text-blue-400">
              {user.name?.[0]?.toUpperCase() || user.email?.[0]?.toUpperCase() || "U"}
            </div>
            <div>
              <h1 className="text-2xl font-bold text-white">{user.name || "Anonymous User"}</h1>
              <p className="text-slate-400">{user.email}</p>
              <div className="mt-2 flex items-center gap-2">
                <span
                  className={`inline-flex rounded-full px-2 py-1 text-xs font-semibold ${
                    user.role === "ADMIN"
                      ? "bg-purple-500/10 text-purple-400"
                      : "bg-blue-500/10 text-blue-400"
                  }`}
                >
                  {user.role}
                </span>
                {user.emailVerified && (
                  <span className="inline-flex rounded-full bg-green-500/10 px-2 py-1 text-xs font-semibold text-green-400">
                    Verified
                  </span>
                )}
              </div>
            </div>
          </div>
          <div className="flex gap-2">
            <CreditAdjuster
              userId={user.id}
              currentCredits={user.credits}
              userName={user.name || user.email || "User"}
            />
          </div>
        </div>
      </div>

      {/* Stats Grid */}
      <div className="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-4">
        <div className="rounded-lg border border-slate-800 bg-slate-900/50 p-4">
          <div className="flex items-center gap-3">
            <div className="rounded-lg bg-blue-500/10 p-2">
              <CreditCard className="h-5 w-5 text-blue-400" />
            </div>
            <div>
              <p className="text-sm text-slate-400">Credits</p>
              <p className="text-2xl font-bold text-white">{user.credits}</p>
            </div>
          </div>
        </div>
        <div className="rounded-lg border border-slate-800 bg-slate-900/50 p-4">
          <div className="flex items-center gap-3">
            <div className="rounded-lg bg-purple-500/10 p-2">
              <Activity className="h-5 w-5 text-purple-400" />
            </div>
            <div>
              <p className="text-sm text-slate-400">Generations</p>
              <p className="text-2xl font-bold text-white">{user._count.generations}</p>
            </div>
          </div>
        </div>
        <div className="rounded-lg border border-slate-800 bg-slate-900/50 p-4">
          <div className="flex items-center gap-3">
            <div className="rounded-lg bg-green-500/10 p-2">
              <FileText className="h-5 w-5 text-green-400" />
            </div>
            <div>
              <p className="text-sm text-slate-400">Walkthroughs</p>
              <p className="text-2xl font-bold text-white">{user._count.walkthroughs}</p>
            </div>
          </div>
        </div>
        <div className="rounded-lg border border-slate-800 bg-slate-900/50 p-4">
          <div className="flex items-center gap-3">
            <div className="rounded-lg bg-orange-500/10 p-2">
              <Shield className="h-5 w-5 text-orange-400" />
            </div>
            <div>
              <p className="text-sm text-slate-400">Orders</p>
              <p className="text-2xl font-bold text-white">{user._count.orders}</p>
            </div>
          </div>
        </div>
      </div>

      <div className="grid grid-cols-1 gap-6 lg:grid-cols-2">
        {/* Account Info */}
        <div className="rounded-xl border border-slate-800 bg-slate-900/50 p-6">
          <h2 className="text-xl font-bold text-white mb-4">Account Information</h2>
          <dl className="space-y-3">
            <div>
              <dt className="text-sm text-slate-400">User ID</dt>
              <dd className="mt-1 text-sm font-mono text-white">{user.id}</dd>
            </div>
            <div>
              <dt className="text-sm text-slate-400">Email</dt>
              <dd className="mt-1 text-sm text-white">{user.email}</dd>
            </div>
            <div>
              <dt className="text-sm text-slate-400">Phone</dt>
              <dd className="mt-1 text-sm text-white">{user.phoneNumber || "Not provided"}</dd>
            </div>
            <div>
              <dt className="text-sm text-slate-400">Joined</dt>
              <dd className="mt-1 text-sm text-white">
                {new Date(user.createdAt).toLocaleDateString()}
              </dd>
            </div>
            <div>
              <dt className="text-sm text-slate-400">Stripe Customer ID</dt>
              <dd className="mt-1 text-sm font-mono text-white">
                {user.stripeCustomerId || "None"}
              </dd>
            </div>
          </dl>
        </div>

        {/* Trial/Subscription Info */}
        <div className="rounded-xl border border-slate-800 bg-slate-900/50 p-6">
          <h2 className="text-xl font-bold text-white mb-4">Subscription Status</h2>
          {user.subscription ? (
            <div className="space-y-3">
              <div>
                <dt className="text-sm text-slate-400">Status</dt>
                <dd className="mt-1">
                  <span
                    className={`inline-flex rounded-full px-2 py-1 text-xs font-semibold ${
                      user.subscription.status === "active"
                        ? "bg-green-500/10 text-green-400"
                        : "bg-yellow-500/10 text-yellow-400"
                    }`}
                  >
                    {user.subscription.status}
                  </span>
                </dd>
              </div>
              <div>
                <dt className="text-sm text-slate-400">Subscription ID</dt>
                <dd className="mt-1 text-sm font-mono text-white">
                  {user.subscription.stripeSubscriptionId}
                </dd>
              </div>
              <div>
                <dt className="text-sm text-slate-400">Current Period Ends</dt>
                <dd className="mt-1 text-sm text-white">
                  {new Date(user.subscription.currentPeriodEnd).toLocaleDateString()}
                </dd>
              </div>
            </div>
          ) : user.trial ? (
            <div className="space-y-3">
              <div>
                <dt className="text-sm text-slate-400">Trial Status</dt>
                <dd className="mt-1">
                  <span
                    className={`inline-flex rounded-full px-2 py-1 text-xs font-semibold ${
                      user.trial.status === "ACTIVE"
                        ? "bg-green-500/10 text-green-400"
                        : "bg-red-500/10 text-red-400"
                    }`}
                  >
                    {user.trial.status}
                  </span>
                </dd>
              </div>
              <div>
                <dt className="text-sm text-slate-400">Credits Used</dt>
                <dd className="mt-1 text-sm text-white">
                  {user.trial.usedCredits} / {user.trial.totalCredits}
                </dd>
              </div>
              <div>
                <dt className="text-sm text-slate-400">Risk Level</dt>
                <dd className="mt-1">
                  <span
                    className={`inline-flex rounded-full px-2 py-1 text-xs font-semibold ${
                      user.trial.riskLevel === "LOW"
                        ? "bg-green-500/10 text-green-400"
                        : user.trial.riskLevel === "MEDIUM"
                        ? "bg-yellow-500/10 text-yellow-400"
                        : "bg-red-500/10 text-red-400"
                    }`}
                  >
                    {user.trial.riskLevel}
                  </span>
                </dd>
              </div>
              <div>
                <dt className="text-sm text-slate-400">Expires</dt>
                <dd className="mt-1 text-sm text-white">
                  {new Date(user.trial.expiresAt).toLocaleDateString()}
                </dd>
              </div>
            </div>
          ) : (
            <p className="text-slate-400">No active trial or subscription</p>
          )}
        </div>
      </div>

      {/* Recent Activity */}
      <div className="rounded-xl border border-slate-800 bg-slate-900/50 p-6">
        <h2 className="text-xl font-bold text-white mb-4">Recent Generations</h2>
        <div className="space-y-3">
          {user.generations.length > 0 ? (
            user.generations.map((gen) => (
              <div
                key={gen.id}
                className="flex items-center justify-between rounded-lg border border-slate-800 bg-slate-800/50 p-4"
              >
                <div className="flex-1">
                  <p className="text-sm font-medium text-white">{gen.type}</p>
                  <p className="text-sm text-slate-400 truncate max-w-lg">{gen.prompt}</p>
                </div>
                <div className="text-right">
                  <p className="text-sm text-blue-400">{gen.cost} credits</p>
                  <p className="text-xs text-slate-500">
                    {new Date(gen.createdAt).toLocaleDateString()}
                  </p>
                </div>
              </div>
            ))
          ) : (
            <p className="text-slate-400 text-center py-4">No generations yet</p>
          )}
        </div>
      </div>
    </div>
  );
}
