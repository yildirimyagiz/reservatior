import { RoleGuard } from "@/components/auth/RoleGuard";

export default function ListingOSLayout({ children }: { children: React.ReactNode }) {
  return <RoleGuard osModule="listing-os">{children}</RoleGuard>;
}
