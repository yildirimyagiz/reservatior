import { RoleGuard } from "@/components/auth/RoleGuard";

export default function CrmOSLayout({ children }: { children: React.ReactNode }) {
  return <RoleGuard osModule="crm-os">{children}</RoleGuard>;
}
