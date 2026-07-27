import { RoleGuard } from "@/components/auth/RoleGuard";

export default function DevapiOSLayout({ children }: { children: React.ReactNode }) {
  return <RoleGuard osModule="devapi-os">{children}</RoleGuard>;
}
