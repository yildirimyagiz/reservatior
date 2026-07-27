import { RoleGuard } from "@/components/auth/RoleGuard";

export default function CommerceOSLayout({ children }: { children: React.ReactNode }) {
  return <RoleGuard osModule="commerce-os">{children}</RoleGuard>;
}
