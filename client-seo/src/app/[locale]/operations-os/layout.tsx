import { RoleGuard } from "@/components/auth/RoleGuard";

export default function OperationsOSLayout({ children }: { children: React.ReactNode }) {
  return <RoleGuard osModule="operations-os">{children}</RoleGuard>;
}
