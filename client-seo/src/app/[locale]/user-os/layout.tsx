import { RoleGuard } from "@/components/auth/RoleGuard";

export default function UserOSLayout({ children }: { children: React.ReactNode }) {
  return <RoleGuard osModule="user-os">{children}</RoleGuard>;
}
