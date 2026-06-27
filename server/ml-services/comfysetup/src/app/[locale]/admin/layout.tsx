import { requireAdmin } from "@/lib/admin";
import { getDictionary, isValidLocale } from "@/lib/i18n/config";
import { notFound, redirect } from "next/navigation";
import Link from "next/link";
import { 
  LayoutDashboard, 
  Users, 
  CreditCard, 
  Settings, 
  FileText, 
  Video, 
  BarChart3,
  LifeBuoy,
  Image as ImageIcon,
  Home,
  LogOut
} from "lucide-react";

interface AdminLayoutProps {
  children: React.ReactNode;
  params: Promise<{ locale: string }>;
}

export default async function AdminLayout({ children, params }: AdminLayoutProps) {
  const { locale } = await params;

  if (!isValidLocale(locale)) {
    notFound();
  }

  // Require admin role
  const session = await requireAdmin();

  const navigation = [
    { name: "Dashboard", href: `/${locale}/admin`, icon: LayoutDashboard },
    { name: "Users", href: `/${locale}/admin/users`, icon: Users },
    { name: "Generations", href: `/${locale}/admin/generations`, icon: ImageIcon },
    { name: "Walkthroughs", href: `/${locale}/admin/walkthroughs`, icon: Video },
    { name: "Brochures", href: `/${locale}/admin/brochures`, icon: FileText },
    { name: "Payments", href: `/${locale}/admin/payments`, icon: CreditCard },
    { name: "Support Tickets", href: `/${locale}/admin/tickets`, icon: LifeBuoy },
    { name: "Analytics", href: `/${locale}/admin/analytics`, icon: BarChart3 },
    { name: "System", href: `/${locale}/admin/system`, icon: Settings },
  ];

  return (
    <div className="min-h-screen bg-slate-950">
      {/* Top Navigation Bar */}
      <header className="fixed top-0 left-0 right-0 z-50 border-b border-slate-800 bg-slate-900/95 backdrop-blur">
        <div className="flex h-16 items-center justify-between px-6">
          <div className="flex items-center gap-4">
            <Link href={`/${locale}`} className="flex items-center gap-2 text-white hover:text-blue-400 transition">
              <Home className="h-5 w-5" />
              <span className="font-semibold">Back to Site</span>
            </Link>
            <div className="h-6 w-px bg-slate-700" />
            <h1 className="text-xl font-bold text-white">Admin Panel</h1>
          </div>
          <div className="flex items-center gap-4">
            <span className="text-sm text-slate-400">{session.user?.email}</span>
            <Link
              href="/api/auth/signout"
              className="flex items-center gap-2 rounded-lg bg-slate-800 px-4 py-2 text-sm text-white hover:bg-slate-700 transition"
            >
              <LogOut className="h-4 w-4" />
              Sign Out
            </Link>
          </div>
        </div>
      </header>

      <div className="flex pt-16">
        {/* Sidebar Navigation */}
        <aside className="fixed left-0 top-16 bottom-0 w-64 border-r border-slate-800 bg-slate-900 overflow-y-auto">
          <nav className="p-4 space-y-1">
            {navigation.map((item) => (
              <Link
                key={item.name}
                href={item.href}
                className="flex items-center gap-3 rounded-lg px-4 py-3 text-slate-300 hover:bg-slate-800 hover:text-white transition group"
              >
                <item.icon className="h-5 w-5 text-slate-400 group-hover:text-blue-400 transition" />
                <span className="font-medium">{item.name}</span>
              </Link>
            ))}
          </nav>
        </aside>

        {/* Main Content */}
        <main className="flex-1 ml-64 p-8">
          {children}
        </main>
      </div>
    </div>
  );
}
