import { RoleGuard } from "@/components/auth/RoleGuard";

export default function SecurityOSLayout({ children }: { children: React.ReactNode }) {
  return <RoleGuard osModule="security-os">{children}</RoleGuard>;
}
