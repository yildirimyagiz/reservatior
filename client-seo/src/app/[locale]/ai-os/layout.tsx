import { RoleGuard } from "@/components/auth/RoleGuard";

export default function AiOSLayout({ children }: { children: React.ReactNode }) {
  return <RoleGuard osModule="ai-os">{children}</RoleGuard>;
}
