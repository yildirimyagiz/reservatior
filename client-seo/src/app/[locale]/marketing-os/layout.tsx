import { RoleGuard } from "@/components/auth/RoleGuard";

export default function MarketingOSLayout({ children }: { children: React.ReactNode }) {
  return <RoleGuard osModule="marketing-os">{children}</RoleGuard>;
}
