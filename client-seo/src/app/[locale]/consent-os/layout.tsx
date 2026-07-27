import { RoleGuard } from "@/components/auth/RoleGuard";

export default function ConsentOSLayout({ children }: { children: React.ReactNode }) {
  return <RoleGuard osModule="consent-os">{children}</RoleGuard>;
}
