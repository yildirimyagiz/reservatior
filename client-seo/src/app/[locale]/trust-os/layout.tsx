import { RoleGuard } from "@/components/auth/RoleGuard";

export default function TrustOSLayout({ children }: { children: React.ReactNode }) {
  return <RoleGuard osModule="trust-os">{children}</RoleGuard>;
}
