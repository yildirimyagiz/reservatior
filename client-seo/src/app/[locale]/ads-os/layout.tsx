import { RoleGuard } from "@/components/auth/RoleGuard";

export default function AdsOSLayout({ children }: { children: React.ReactNode }) {
  return <RoleGuard osModule="ads-os">{children}</RoleGuard>;
}
