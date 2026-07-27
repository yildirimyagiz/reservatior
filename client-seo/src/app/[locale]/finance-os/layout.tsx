import { RoleGuard } from "@/components/auth/RoleGuard";

export default function FinanceOSLayout({ children }: { children: React.ReactNode }) {
  return <RoleGuard osModule="finance-os">{children}</RoleGuard>;
}
