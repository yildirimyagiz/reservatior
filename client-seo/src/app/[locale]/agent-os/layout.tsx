import { RoleGuard } from "@/components/auth/RoleGuard";

export default function AgentOSLayout({ children }: { children: React.ReactNode }) {
  return <RoleGuard osModule="agent-os">{children}</RoleGuard>;
}
